Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FE00C43461
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:24:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E98512075A
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 15:24:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gNjNb+eO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728891AbgIFPYh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 11:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728982AbgIFPWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 11:22:54 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FDFCC061575;
        Sun,  6 Sep 2020 08:22:53 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id k25so632357ljk.0;
        Sun, 06 Sep 2020 08:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=q0s2ClRu2GPHpF4lTAIJa0AcRQgvCReBw6zuZZrL6Xg=;
        b=gNjNb+eOcYR1ur4HAWsoY4MxvPqJ1vKJrSJ5IQ4QhNpEz1nnFO/kNywrg15QiVAkkx
         XVmp7z1jWUlWECfGIUQDiBrwJjZBeAEQPZb6s8QEEp+zI9rubbcDTWjEc+L/8ZO3zisZ
         AbrGr0uFhYPpE98nSbDVPkeOM97Kmd9EUJoHdg8G6ar7BIouQFBG8VJKJXH7lpPMWP7u
         x3emn+XFceNX9cRtVEujJpRZviv81rt8L8KvaZcYo7MZnrpLj/GQSmYRTOVzaDeew6bT
         d7Pmy6z8E7XH1TupvOZqrNKQLteCN015NJwASF6ERN9nI/XP7d+IFhwgg06TbkjpdYIu
         4pxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=q0s2ClRu2GPHpF4lTAIJa0AcRQgvCReBw6zuZZrL6Xg=;
        b=bIvKud4bPloVLfzsAcH8eNxakoJKr7DloMLJjyiMLGH3GSWUzsEx22Ju5SpwGzUwRt
         x0gbDTppgPRb/fLtlZrLkGRDEhkTRh8Tfq1Df5zWAeuCUTZvg/gEc//RWp89ttKSLex7
         FAadXR1HC8n0R7kW8KvYnchetf5ELrqsmJoXkocB2CiER7ySXXBvaqaURG0pqH9ryzBk
         qxzNbjlCr1XW2X1QiXhoPXVU4NPIpNnFaAyqD2Vwz4cs/QysoSR1aCUBR3epzq4w0kG4
         YuZTvNmmAoa/7DbTtfX9OXXPjk3i+W0j1o7KQ0RjFMazTiZASrP1CmwcZXlx3D0vQ7Zq
         TdYA==
X-Gm-Message-State: AOAM530ZwqFkMiMY8pzQKMX+lUnhTaQuPn2runeirxHOKVa3IOYTsUL3
        gFk5X3wzdB0PmT6t3CzLykdJZsYE6k52EwazCOKQjyZQ6Tc=
X-Google-Smtp-Source: ABdhPJy8iAKfHMxBw733GjeB4LEUxysEIUarvutkX7YozgOgbMv+G1sluoQg18cE6EKV0kMkBD/Ift63zVd5e5xxRbk=
X-Received: by 2002:a2e:6a04:: with SMTP id f4mr7725521ljc.119.1599405771760;
 Sun, 06 Sep 2020 08:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net> <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
 <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
In-Reply-To: <63c7f5e4-eff2-1420-30a5-a0b98a7815e0@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sun, 6 Sep 2020 23:22:40 +0800
Message-ID: <CADiBU3-83rVLqhVAqqSGc0qQ66PHsGVVcp_m3sm_4ZS5A+GXKQ@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Fix if vbus before cc, hard_reset_count
 not reset issue
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        cy_huang <cy_huang@richtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=885=E6=97=
=A5 =E9=80=B1=E5=85=AD =E4=B8=8B=E5=8D=8811:51=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 9/4/20 6:24 PM, ChiYuan Huang wrote:
> > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=885=
=E6=97=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:41=E5=AF=AB=E9=81=93=EF=BC=
=9A
> >>
> >> On 9/3/20 9:21 AM, ChiYuan Huang wrote:
> >>> Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=883=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:57=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>>>
> >>>> On Wed, Sep 02, 2020 at 11:35:33PM +0800, cy_huang wrote:
> >>>>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>>>
> >>>>> Fix: If vbus event is before cc_event trigger, hard_reset_count
> >>>>> won't bt reset for some case.
> >>>>>
> >>>>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>>>> ---
> >>>>> Below's the flow.
> >>>>>
> >>>>> _tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_UNA=
TTACHED
> >>>>> call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
> >>>>> tcpm_port_is_disconnected() will be called.
> >>>>> But port->attached is still true and port->cc1=3Dopen and port->cc2=
=3Dopen
> >>>>>
> >>>>> It cause tcpm_port_is_disconnected return false, then hard_reset_co=
unt won't be reset.
> >>>>> After that, tcpm_reset_port() is called.
> >>>>> port->attached become false.
> >>>>>
> >>>>> After that, cc now trigger cc_change event, the hard_reset_count wi=
ll be kept.
> >>>>> Even tcpm_detach will be called, due to port->attached is false, tc=
pm_detach()
> >>>>> will directly return.
> >>>>>
> >>>>> CC_EVENT will only trigger drp toggling again.
> >>>>> ---
> >>>>>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
> >>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm=
/tcpm.c
> >>>>> index a48e3f90..5c73e1d 100644
> >>>>> --- a/drivers/usb/typec/tcpm/tcpm.c
> >>>>> +++ b/drivers/usb/typec/tcpm/tcpm.c
> >>>>> @@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *por=
t)
> >>>>>               port->tcpc->set_bist_data(port->tcpc, false);
> >>>>>       }
> >>>>>
> >>>>> -     if (tcpm_port_is_disconnected(port))
> >>>>> -             port->hard_reset_count =3D 0;
> >>>>> +     port->hard_reset_count =3D 0;
> >>>>>
> >>>>
> >>>> Doesn't that mean that the state machine will never enter
> >>>> error recovery ?
> >>>>
> >>> I think it does't affect the error recovery.
> >>> All error recovery seems to check pd_capable flag.
> >>>
> >>> >From my below case, it's A to C cable only. There is no USBPD contra=
ct
> >>> will be estabilished.
> >>>
> >>> This case occurred following by the below test condition
> >>> Cable -> A to C (default Rp bind to vbus) connected to PC.
> >>> 1. first time plugged in the cable with PC
> >>> It will make HARD_RESET_COUNT  to be equal 2
> >>> 2. And then plug out. At that time HARD_RESET_COUNT is till 2.
> >>> 3. next time plugged in again.
> >>> Due to hard_reset_count is still 2 , after wait_cap_timeout, the stat=
e
> >>> eventually changed to SNK_READY.
> >>> But during the state transition, no hard_reset  be sent.
> >>>
> >>> Defined in the USBPD policy engine, typec transition to USBPD, all
> >>> variables must be reset included hard_reset_count.
> >>> So it expected SNK must send hard_reset again.
> >>>
> >>> The original code defined hard_reset_count must be reset only when
> >>> tcpm_port_is_disconnected.
> >>>
> >>> It doesn't make sense that it only occurred in some scenario.
> >>> If tcpm_detach is called, hard_reset count must be reset also.
> >>>
> >>
> >> If a hard reset fails, the state machine may cycle through states
> >> HARD_RESET_SEND, HARD_RESET_START, SRC_HARD_RESET_VBUS_OFF,
> >> SRC_HARD_RESET_VBUS_ON back to SRC_UNATTACHED. In this state,
> >> tcpm_src_detach() and with it tcpm_detach() is called. The hard
> >> reset counter is incremented in HARD_RESET_SEND. If tcpm_detach()
> >> resets the counter, the state machine will keep cycling through hard
> >> resets without ever entering the error recovery state. I am not
> >> entirely sure where the counter should be reset, but tcpm_detach()
> >> seems to be the wrong place.
> >
> > This case you specified means locally error occurred.
>
> It could be a local error (with the local hardware), or with the
> remote partner not accepting the reset. We only know that an error
> occurred.
>
> > It intended to re-run the state machine from typec  to USBPD.
> >>From my understanding, hard_reset_count to be reset is reasonable.
> >
> > The normal stare from the state transition you specified is
> > HARD_RESET_SEND, HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF,
> > SRC_HARD_RESET_VBUS_ON -> received VBUS_EVENT then go to SRC_STARTUP.
> >
> The operational word is "normal". Error recovery is expected to handle
> situations which are not normal.

Following by the USBPD 3.0 revision 1.2, section 8.3.3.24.1
The ErrorRecovery state is  used to electronically disconnect Port
Partner using the USB Type-C connector.
And there's one sentence to be said "The ErrorRecovery staste shall
map to USB Type-C Error Recovery state operations".
I also read ErrorRecovery state in USB TYPE-C 1.3 spec.
Section 4.5.2.2.2.1   ErrorRecovery state requirement listed the below text=
.
The port shall not drive VBUS or VCONN, and shall present a
high-impedance to ground (above
zOPEN) on its CC1 and CC2 pins.
Section 4.5.2.2.2.2 Exiting from the error recovery state
I read the description. The roughly meaning is to change the state to
Unattached(Src or Snk) after tErrorRecovery.

Summary the above text.
Reset HardResetCounter is ok in tcpm_detach.
My patch is just to relax the counter reset conditions during tcpm_detach()=
.
If not, it will check tcpm_port_is_disconnected().
And only two scenario, the hard reset count will be cleared to 0 at this ca=
se.
1) port not attached and cc1=3Dopen and cc2=3Dopen
2) port attached and either (polarity=3Dcc1, cc1=3Dopen) or (polarity=3Dcc2=
, cc2=3Dopen)

I think this judgement is narrow in tcpm_detach case.

>
> I don't question the need to reset the counter. The only question
> is where and when to reset it.
>
I re-check all tcpm code for hard reset counter about the increment and res=
et.
They all meets USBPD spec. Only the detach case, I'm wondering why it
need to add the check for tcpm_port_is_disconnected().

> Guenter
