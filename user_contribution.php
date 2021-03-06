<?php

require_once('includes.php');


//Denne siden skal bare sees av admin eller prosjektleder og viser timer brukt av en enkelt bruker på et spesifikt prosjekt

$userManager = new UserManager($db, $request, $session);
$hourManager = new HourManager($db, $request, $session);
$taskManager = new TaskManager($db, $request, $session);

$user = $session->get('User');

if (!is_null($user) && ($user->isAdmin() | $user->isProjectLeader() | $user->isGroupLeader())) {
    $userID = $request->query->getInt('userID');
    $userToView = $userManager->getUser($userID);

    $hours = $hourManager->getHours(null, $userID);


    if ($request->request->has('edit_commentBoss_hour') && XsrfProtection::verifyMac("Edit Comment Boss")) {
        $hourID = $request->query->getInt('hourId');
        if ($hourManager->editCommentBoss($hourID)) {
            header("Location: ".$requestUri);
            exit();
        } else {
            header("Location: ".$requestUri."&failedtocommentbyboss=1");
            exit();
        }
    }
    else {
        echo $twig->render('user_contribution.twig',
            array('session' => $session, 'request' => $request, 'user' => $user,
                'userToView' => $userToView, 'userID' => $userID,
                 'hours' => $hours,
                'hourManager' => $hourManager));

    }
} else {
    header("location: index.php");
    exit();
}
