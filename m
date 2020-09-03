Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE8D9C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B578920775
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:22:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6CYVKSM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728688AbgICQWN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgICQWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:22:11 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41DE9C061244;
        Thu,  3 Sep 2020 09:22:10 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s205so4454239lja.7;
        Thu, 03 Sep 2020 09:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wqygor/7f4RTr/lzYBDIRDISW50xTxoN66N24t29AO4=;
        b=K6CYVKSMzoRCQ0XEzJqlEkZ/l7QlNeOgpul6gDuIXp/a9i2qV12ZbByLYIhJBwmjt6
         u+SsTmAf5FIqvNGgZ6NKVygZkcONQwApWwjTRtEm7OfD4cY8DCicsCTFhQtaswUbwZF5
         ZfFKC4OxySp971WZBwEKiJdjCk70k98/yrcGoUysowz1vtaH1T53O3Z3+LImKOZIcymF
         ePgmFkjwEt+nSshwVFnZX6OwytXISxqN71gWxmHT4ztW2LdH+/VeO2RpxEdq3f8avlnd
         A9GTkuIOsHPSoZbKOua1sEvTwKkZgHH/WvOvkmJPHmgF+iUhpfbzLAnkO1EJoGkcKWr7
         mI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wqygor/7f4RTr/lzYBDIRDISW50xTxoN66N24t29AO4=;
        b=lk7jDBDbU/kdJ8OSRTroLim6vWsyEwsTGj9oajzFH9OA5o0ypI4aW4W62N0MOkfnjj
         PCq32f4wmWJbjL0VvDNxNrrRRP5AY2ZnQd0HgCr/nb3KvuEwbOFDc4U5GzDPrpccl9hX
         9jPjnqvSueNzP0tU/gj+1OZ5Y0KhaClBVwEtq5fty/a51RZsCT3IrzZfICFMt8fXLZSe
         ojDlf3c6du22rI8cTTzY26UPvwco6fL/21l+JdzCMEajqwfbyNp37rvx+2eVMxWQXZ23
         2Pe5EDokqBhuYBR1yNWPvGOVBM+aqepYcuciM9la/ZJ62XD9I9jbwHch10Wqp9vBg73d
         szcA==
X-Gm-Message-State: AOAM531N9TB5WF5YGvuMCKCqk7HU1Cu6PEqcJSKZmnvuymQelu/JFzTd
        GooR8UzmNFM8ykzIxEjFRF+iJRbjpQQlNyMQtCc=
X-Google-Smtp-Source: ABdhPJwj3dVJl+5HfK8qIz/ymWx66QSmAhKn6EQqdti/u96b3C99nmvLAtQ5IT4o0w8Rys34Rutz+AGxQq+K+n1shjM=
X-Received: by 2002:a2e:80d6:: with SMTP id r22mr1576140ljg.356.1599150128583;
 Thu, 03 Sep 2020 09:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <1599060933-8092-1-git-send-email-u0084500@gmail.com> <20200902165713.GG56237@roeck-us.net>
In-Reply-To: <20200902165713.GG56237@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 4 Sep 2020 00:21:56 +0800
Message-ID: <CADiBU3_iHk4aoM8o6GcaTmWDZT4ymvb0Ff-XeLLZ0C9dhCnLZQ@mail.gmail.com>
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

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B49=E6=9C=883=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=8812:57=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Wed, Sep 02, 2020 at 11:35:33PM +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Fix: If vbus event is before cc_event trigger, hard_reset_count
> > won't bt reset for some case.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> > Below's the flow.
> >
> > _tcpm_pd_vbus_off() -> run_state_machine to change state to SNK_UNATTAC=
HED
> > call tcpm_snk_detach() -> tcpm_snk_detach() -> tcpm_detach()
> > tcpm_port_is_disconnected() will be called.
> > But port->attached is still true and port->cc1=3Dopen and port->cc2=3Do=
pen
> >
> > It cause tcpm_port_is_disconnected return false, then hard_reset_count =
won't be reset.
> > After that, tcpm_reset_port() is called.
> > port->attached become false.
> >
> > After that, cc now trigger cc_change event, the hard_reset_count will b=
e kept.
> > Even tcpm_detach will be called, due to port->attached is false, tcpm_d=
etach()
> > will directly return.
> >
> > CC_EVENT will only trigger drp toggling again.
> > ---
> >  drivers/usb/typec/tcpm/tcpm.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcp=
m.c
> > index a48e3f90..5c73e1d 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -2797,8 +2797,7 @@ static void tcpm_detach(struct tcpm_port *port)
> >               port->tcpc->set_bist_data(port->tcpc, false);
> >       }
> >
> > -     if (tcpm_port_is_disconnected(port))
> > -             port->hard_reset_count =3D 0;
> > +     port->hard_reset_count =3D 0;
> >
>
> Doesn't that mean that the state machine will never enter
> error recovery ?
>
I think it does't affect the error recovery.
All error recovery seems to check pd_capable flag.

From my below case, it's A to C cable only. There is no USBPD contract
will be estabilished.

This case occurred following by the below test condition
Cable -> A to C (default Rp bind to vbus) connected to PC.
1. first time plugged in the cable with PC
It will make HARD_RESET_COUNT  to be equal 2
2. And then plug out. At that time HARD_RESET_COUNT is till 2.
3. next time plugged in again.
Due to hard_reset_count is still 2 , after wait_cap_timeout, the state
eventually changed to SNK_READY.
But during the state transition, no hard_reset  be sent.

Defined in the USBPD policy engine, typec transition to USBPD, all
variables must be reset included hard_reset_count.
So it expected SNK must send hard_reset again.

The original code defined hard_reset_count must be reset only when
tcpm_port_is_disconnected.

It doesn't make sense that it only occurred in some scenario.
If tcpm_detach is called, hard_reset count must be reset also.

> Guenter
>
> >       tcpm_reset_port(port);
> >  }
> > --
> > 2.7.4
> >
