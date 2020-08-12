Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CDDC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:01:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DDF206DA
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 02:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HDA4NFi9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgHLCBs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 22:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726235AbgHLCBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 22:01:48 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9F7C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:01:47 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id q13so315493vsn.9
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 19:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tFY4085plBY8G7tVD9MczcUSssYpeVWGX8Ah9xVqPOk=;
        b=HDA4NFi9vQjtl12+Zmrjq+C3UnJr0mMBKrILh7t3fkK5hS5cNExIGL1+L1hIEprKFY
         x+UHshB2qPRa7PC01fywLSFvj2iZvBI8hqCmFZw2kEf5oRNClRsIUrxtAvAsblH+J5zZ
         2KMfqb4HX6ghLCBOoOUwyb66NWWlO71PVYBlukNa+PtZj04JAm3WukGJSpHHvXU83i97
         KUshbPtCx7M+J8xGBUa0sZoKfukD3msvsdQJcyaAg0xhTazKRsXmH+VmGbgjrZRXESAv
         00+tkEfI9xA9WQ2GwGdVUiB0Ui+CpKMCkIYXGEm/0rRQeSLupTNG+OkHlGJelIW/hVeP
         B8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tFY4085plBY8G7tVD9MczcUSssYpeVWGX8Ah9xVqPOk=;
        b=AjHneJpBZjaNo1YB3/Zwzu+SJfvxFR0tm/KdfBc9cXkaSpwmltlflm2m0qdmkMnqrR
         qHOOCMk9CzIMg2lquYsox96fC2+UVbYKFZuFKWMphiE/cxnDLCypZXODZyyHwIVdITBy
         13IvgXz7Mg5ZjtNUpeFjyoVpuHe1CQXuI+0qHdKpVz1zxU0atALuQ1S9M2MnxuSGQt9m
         WI8GnwO6n1ZbFFxcLWA5csh7uiFrQPEbJTwIgWixdnInRnZkXvyxqZ4EVQA6iEUI9uFf
         AdlJlA/LQNNJNu0NLgGRcTdQ73/9mkprFsy/1Y5XmAm856o0anxLaenF0QNeow59PiT9
         wXJQ==
X-Gm-Message-State: AOAM533eLomwsM6Z79vNPEWdFCZqAaNc3A1OZ8GHasWFpZ9ymukSO/av
        k9EuaaCNvpcVDCpmaGHWi6iP05w6A14VqbfW6LPIng==
X-Google-Smtp-Source: ABdhPJw1XndaA/OYA/SoNpImfbiqj/XJo4rws0tFRMOxmiIgBDNA1xisgCnGslix67SfdNKWCiSpD/Z3IVj+nBpG8Rs=
X-Received: by 2002:a67:f1c7:: with SMTP id v7mr10241022vsm.50.1597197706596;
 Tue, 11 Aug 2020 19:01:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200812001439.545655-1-badhri@google.com> <20200812014319.GA116801@roeck-us.net>
In-Reply-To: <20200812014319.GA116801@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 11 Aug 2020 19:01:10 -0700
Message-ID: <CAPTae5Jw3ZysWnYj=s7cjU1Hnr3ib7vfCHsgV=1Qq_2EWcUNvg@mail.gmail.com>
Subject: Re: [PATCH v2] tcpm: During PR_SWAP, source caps should be sent only
 after tSwapSourceStart
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 6:43 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Tue, Aug 11, 2020 at 05:14:39PM -0700, Badhri Jagan Sridharan wrote:
> > From the spec:
> > "6.6.8.1 SwapSourceStartTimer
> > The SwapSourceStartTimer Shall be used by the new Source, after a Power
> > Role Swap or Fast Role Swap, to ensure that it does not send
> > Source_Capabilities Message before the new Sink is ready to receive the
> > Source_Capabilities Message. The new Source Shall Not send the
> > Source_Capabilities Message earlier than tSwapSourceStart after the
> > last bit of the EOP of GoodCRC Message sent in response to the PS_RDY
> > Message sent by the new Source indicating that its power supply is
> > ready."
> >
> > This fixes TD.PD.CP.E3, TD.PD.CP.E4, TD.PD.CP.E5 failures
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>
> Nit below, otherwise
>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>
> Note that I wasn't copied on this patch and only noticed it accidentally.

Apologies Guenter ! Error on my side while performing the git
send-email command.
Will make sure that I double check next time.

>
> Guenter
>
> > ---
> > Changes since V1:
> > - Comment on the permissible values of tSwapSourceStart
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 2 +-
> >  include/linux/usb/pd.h        | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 3ef37202ee37..d38347bd3335 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -3555,7 +3555,7 @@ static void run_state_machine(struct tcpm_port *port)
> >                */
> >               tcpm_set_pwr_role(port, TYPEC_SOURCE);
> >               tcpm_pd_send_control(port, PD_CTRL_PS_RDY);
> > -             tcpm_set_state(port, SRC_STARTUP, 0);
> > +             tcpm_set_state(port, SRC_STARTUP, PD_T_SWAP_SRC_START);
> >               break;
> >
> >       case VCONN_SWAP_ACCEPT:
> > diff --git a/include/linux/usb/pd.h b/include/linux/usb/pd.h
> > index b6c233e79bd4..ed5eed73ccf8 100644
> > --- a/include/linux/usb/pd.h
> > +++ b/include/linux/usb/pd.h
> > @@ -473,6 +473,7 @@ static inline unsigned int rdo_max_power(u32 rdo)
> >  #define PD_T_ERROR_RECOVERY  100     /* minimum 25 is insufficient */
> >  #define PD_T_SRCSWAPSTDBY      625     /* Maximum of 650ms */
> >  #define PD_T_NEWSRC            250     /* Maximum of 275ms */
> > +#define PD_T_SWAP_SRC_START  20     /* Minimum of 20ms */
>
> Odd alignment. Same as with the previous two lines which don't use tabs
> either.
>
> >
> >  #define PD_T_DRP_TRY         100     /* 75 - 150 ms */
> >  #define PD_T_DRP_TRYWAIT     600     /* 400 - 800 ms */
