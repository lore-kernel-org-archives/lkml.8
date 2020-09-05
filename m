Return-Path: <SRS0=flm+=CO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107DCC43461
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2EEE20797
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Sep 2020 01:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDeQiHJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgIEBZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 21:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgIEBZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 21:25:05 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC0F8C061244;
        Fri,  4 Sep 2020 18:25:04 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id u27so4735296lfm.13;
        Fri, 04 Sep 2020 18:25:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Gz2Zs59lr0OT5rRSLvbdS3pphO697NYICUlFWA2KU8Y=;
        b=PDeQiHJZ1kR0rdRhMm3ibnMS+UdCLKeNQwn4K54NpebqCadc7/mgtzlGuIdq09XAql
         qy5q6utByc6++EfzmgOBptbivO3qyUWgDmJeljC6dgSJaWpqwpDOAah383cYcamuL2UN
         2W1b0yas1CwXDOLld9zu+h5hNblvhH47hHjR4j2rKaH9POBMDAMIrxaRt9BIqOuJOpq4
         Gv5bKz3OFS8r80TXOEgs6Tzoz23zZL821oOZupVDSjU/XcyLBPRmfxMr+WRHi667fwwv
         C6ncI9CghU92/JQTUXlCCYW32ixrzInSvMZ7PD2pAkxx8QBgcMh2viM3ODqtkycoLIp0
         SqOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Gz2Zs59lr0OT5rRSLvbdS3pphO697NYICUlFWA2KU8Y=;
        b=tw7av6PlUoxmfImO7XVtmR8m5iAagQZWaTX7+M8lSvIylA1hqkvBfwA3540BGs5vZD
         3bGamTnSB++gx1cdeKkYyMUDZuLIHJFQnPvI90d6eyNt64dfDkNBjUVCmMf48PtUdkGO
         +LdwBrRCgG8AfiU+Nd2S7NBaaWMPOvGp//Xj1OhVJT1j5GRgT15pWmw9shg/EFYcyWYM
         Pb1rMu263jWdveWxE5o1PMlxq9GdLC3nvL3QG6opcrHv/eI/seARxTH4kfu+4pngEUeW
         vuan7oc2by/SmhrVnMrPh2+5GMUZ1/3G4XTcihchTkICZpmdli1LX9fTBIaH6zmIaK3y
         oREg==
X-Gm-Message-State: AOAM533cGli3iGoyYlVZYyz9RssQgeHGsfw1xnGHIbKASXedSSBE7uvu
        mh5jNXpkzhGPuFWAN6/su5H7I5U4HMRtAUQhsRE=
X-Google-Smtp-Source: ABdhPJyxrsUKxF22uxdyYAa/Xp+qw/ZuKxc7IdKhzVtp+FVens6NNhQ3NiuzwJzS3snv5XG/XN/rMFxMEaQ50kRJ5MU=
X-Received: by 2002:a19:457:: with SMTP id 84mr5037845lfe.191.1599269101709;
 Fri, 04 Sep 2020 18:25:01 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com>
 <20200902165713.GG56237@roeck-us.net> <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
 <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net>
In-Reply-To: <fd2a33fc-2383-66cb-0fd7-d5aa0cc9111f@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Sat, 5 Sep 2020 09:24:50 +0800
Message-ID: <CADiBU3_vYAmHDCONrExzyM+1CTfqJx_eS1hYG8aHkNWFzTcwfg@mail.gmail.com>
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
=A5 =E9=80=B1=E5=85=AD =E4=B8=8A=E5=8D=883:41=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 9/3/20 9:21 AM, ChiYuan Huang wrote:
> > Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=883=
=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:57=E5=AF=AB=E9=81=93=EF=
=BC=9A
> >>
> >> On Wed, Sep 02, 2020 at 11:35:33PM +0800, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Fix: If vbus event is before cc_event trigger, hard_reset_count
> >>> won't bt reset for some case.
> >>>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>> Below's the flow.
> >>>
> >>> _tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_UNATT=
ACHED
> >>> call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
> >>> tcpm_port_is_disconnected() will be called.
> >>> But port->attached is still true and port->cc1=3Dopen and port->cc2=
=3Dopen
> >>>
> >>> It cause tcpm_port_is_disconnected return false, then hard_reset_coun=
t won't be reset.
> >>> After that, tcpm_reset_port() is called.
> >>> port->attached become false.
> >>>
> >>> After that, cc now trigger cc_change event, the hard_reset_count will=
 be kept.
> >>> Even tcpm_detach will be called, due to port->attached is false, tcpm=
_detach()
> >>> will directly return.
> >>>
> >>> CC_EVENT will only trigger drp toggling again.
> >>> ---
> >>>  drivers/usb/typec/tcpm/tcpm.c | 3 +--
> >>>  1 file changed, 1 insertion(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/t=
cpm.c
> >>> index a48e3f90..5c73e1d 100644
> >>> --- a/drivers/usb/typec/tcpm/tcpm.c
> >>> +++ b/drivers/usb/typec/tcpm/tcpm.c
> >>> @@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *port)
> >>>               port->tcpc->set_bist_data(port->tcpc, false);
> >>>       }
> >>>
> >>> -     if (tcpm_port_is_disconnected(port))
> >>> -             port->hard_reset_count =3D 0;
> >>> +     port->hard_reset_count =3D 0;
> >>>
> >>
> >> Doesn't that mean that the state machine will never enter
> >> error recovery ?
> >>
> > I think it does't affect the error recovery.
> > All error recovery seems to check pd_capable flag.
> >
> >>From my below case, it's A to C cable only. There is no USBPD contract
> > will be estabilished.
> >
> > This case occurred following by the below test condition
> > Cable -> A to C (default Rp bind to vbus) connected to PC.
> > 1. first time plugged in the cable with PC
> > It will make HARD_RESET_COUNT  to be equal 2
> > 2. And then plug out. At that time HARD_RESET_COUNT is till 2.
> > 3. next time plugged in again.
> > Due to hard_reset_count is still 2 , after wait_cap_timeout, the state
> > eventually changed to SNK_READY.
> > But during the state transition, no hard_reset  be sent.
> >
> > Defined in the USBPD policy engine, typec transition to USBPD, all
> > variables must be reset included hard_reset_count.
> > So it expected SNK must send hard_reset again.
> >
> > The original code defined hard_reset_count must be reset only when
> > tcpm_port_is_disconnected.
> >
> > It doesn't make sense that it only occurred in some scenario.
> > If tcpm_detach is called, hard_reset count must be reset also.
> >
>
> If a hard reset fails, the state machine may cycle through states
> HARD_RESET_SEND, HARD_RESET_START, SRC_HARD_RESET_VBUS_OFF,
> SRC_HARD_RESET_VBUS_ON back to SRC_UNATTACHED. In this state,
> tcpm_src_detach() and with it tcpm_detach() is called. The hard
> reset counter is incremented in HARD_RESET_SEND. If tcpm_detach()
> resets the counter, the state machine will keep cycling through hard
> resets without ever entering the error recovery state. I am not
> entirely sure where the counter should be reset, but tcpm_detach()
> seems to be the wrong place.

This case you specified means locally error occurred.
It intended to re-run the state machine from typec  to USBPD.
From my understanding, hard_reset_count to be reset is reasonable.

The normal stare from the state transition you specified is
HARD_RESET_SEND, HARD_RESET_START -> SRC_HARD_RESET_VBUS_OFF,
SRC_HARD_RESET_VBUS_ON -> received VBUS_EVENT then go to SRC_STARTUP.

>
> Guenter
>
> >> Guenter
> >>
> >>>       tcpm_reset_port(port);
> >>>  }
> >>> --
> >>> 2.7.4
> >>>
>
