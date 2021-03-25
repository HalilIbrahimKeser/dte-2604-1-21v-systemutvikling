<?php


class HourManager
{
    private $dbase;
    private $request;
    private $session;

    public function __construct(PDO $db, \Symfony\Component\HttpFoundation\Request $request, \Symfony\Component\HttpFoundation\Session\Session $session)
    {
        $this->dbase = $db;
        $this->request = $request;
        $this->session = $session;
    }



    private function notifyUser($strHeader, $strMessage = "")
    {
        $this->session->getFlashBag()->clear();
        $this->session->getFlashBag()->add('header', $strHeader);
        $this->session->getFlashBag()->add('message', $strMessage);
    }

    // GET ALL HOURS FOR USER
    public function getAllHoursForUser(): array    {
    }
    //END GET ALL TIMES

    // REGISTER TIME FOR USER
    public function registerTimeForUser() {
    }
    //END REGISTER TIME

    //CHANGE TIME USER
    public function changeTimeForUser() {

    }
    //END CHANGE TIME USER
}