<?php

require_once('includes.php');


$groupManager = new GroupManager($db, $request, $session);
$userManager = new UserManager($db, $request, $session);
$projectManager = new ProjectManager($db, $request, $session);
$taskManager = new TaskManager($db, $request, $session);

$group = $groupManager->getGroup($request->query->getInt('groupid'));


if (!is_null($user) && !is_null($group) ) {
    $groupID = $group->getGroupID();
    $members = $groupManager->getGroupMembers($groupID);
    $isMember = false;

    /* Sjekk om bruker er medlem i fremviste gruppe */

    $isMember = $groupManager->checkIfMemberOfGroup($group->getGroupID(), $user->getUserID());


    if ($isMember or $user->isAdmin() or $user->isProjectLeader() or ($user->getUserID() == $group->getGroupLeader())) {
        $groupID = $group->getGroupID();

        $employees = $groupManager->getAllNonMembers($groupID);

        $candidates = $groupManager->getLeaderCandidates($groupID);

        $projects = $projectManager->getAllProjects();

        $tasks = $taskManager->getAllTasks( 1, $group->getProjectName(), null, $groupID);

        if ($request->request->has('group_edit') && XsrfProtection::verifyMac("Group edit")) {
            if (!$user->isAdmin()) {
                $request->request->set('isAdmin', 0);
            }
            if ($groupManager->editGroup($group)) {
                header("Location: ".$requestUri);
                exit();
            } else {
                header("Location: ".$requestUri);
                exit();
            }

        } else if ($request->request->has('add_members') && XsrfProtection::verifyMac("Group add members")) {
            if ($groupManager->addEmployees($groupID)) {
                header("Location: ".$requestUri);
                exit();
            } else {
                header("Location: ".$requestUri);
                exit();
            }
        } else if ($request->request->has('remove_members') && XsrfProtection::verifyMac("Group remove members")) {
            if ($groupManager->removeEmployees($group)) {
                header("Location: ".$requestUri);
                exit();
            } else {
                header("Location: ".$requestUri);
                exit();
            }
        } else if ($request->request->has('add_to_project') && XsrfProtection::verifyMac("Add group to project")) {
            if ($groupManager->addToProject($group)) {
                header("Location: ".$requestUri);
                exit();
            } else {
                header("Location: ".$requestUri);
                exit();
            }
        } else if ($request->request->has('group_delete') && $user->isAdmin() && XsrfProtection::verifyMac("Delete group")) {
            if ($groupManager->deleteGroup($group)) {
                header("Location: groups.php?deleteddgroup=1");
                exit();
            } else {
                header("Location: ".$requestUri);
                exit();
            }
        } else {
            if ($isMember or $user->isAdmin() or $user->isProjectLeader() or $user->isGroupLeader()) {
                try {
                    echo $twig->render('group_edit.twig', array('session' => $session,
                        'request' => $request, 'user' => $user, 'employees' => $employees,
                        'group' => $group, 'members' => $members, 'candidates' => $candidates,
                        'projects' => $projects, 'tasks' => $tasks));
                } catch (LoaderError | \Twig\Error\RuntimeError | \Twig\Error\SyntaxError $e) {
                }
            }
        }
    } else {
        header("location: groups.php");
        exit();
    }
} else {
    header("location: index.php");
    exit();
}

?>