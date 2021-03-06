<?php

require_once('includes.php');

include('user_register_check.php');

$userManager = new UserManager($db, $request, $session);


if (!is_null($user) && ($user->isAdmin() | $user->isProjectLeader())) {
    if ($request->request->has('register') && XsrfProtection::verifyMac("user_register")) {

        if ($userManager->registerUser($user)) {
            header("Location: userprofiles.php");
            exit();
        } else {
            header("Location: userprofiles.php");
            exit();
        }

    } else {
        try {
            echo $twig->render('user_register.twig', array('session' => $session,
                'request' => $request, 'user' => $user));
        } catch (LoaderError | \Twig\Error\RuntimeError | \Twig\Error\SyntaxError $e) {

        }
    }
} else {
    header("location: login.php");
    exit();
}


?>