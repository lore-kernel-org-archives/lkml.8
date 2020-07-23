Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6333EC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AFC9206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 06:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b2uWM5w0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgGWGV1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 02:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgGWGV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 02:21:26 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D61BEC0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:21:25 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id n4so1440667uae.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 23:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NmccGowISiofEIh34tVNSq1T6x9AX5ZUAzxKCJSNHX0=;
        b=b2uWM5w0BWXHy9/wyNBLvHGrr96J9rx1+GnWbJXRWy1ssaBMyCjUB2RZJtFZdZcZmT
         v15QIv2IYLtzO1qqrXRk+hrP933/BXm8f87aWfBemViSB03s9U+Q1KkUzwMLK7h72b3c
         9WOZMVJplHAkok9IyXhhz5GzW/QRsbWfNuaQj7416eMhKfq7/zgCHM+dKWqhFLVkkj8y
         CSp7uwOiSwGmrZnKSKQgXG0P/eITv6H64Lsk2CT28zrUS5AcCpx7DBx7wVoQ/3euNPRv
         y1rXH2a9z8CIlXczstjpCRJOGD3OAFpl/HJ7b/U9Jtd+BnEFBe22lhe1hZF8q3srWmUJ
         qCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NmccGowISiofEIh34tVNSq1T6x9AX5ZUAzxKCJSNHX0=;
        b=VlweDLIFrwBEsEjIBEeBsx4hrcobX8vtosx+/LbEY8Ynkz6pXUXPrLgLwhSJ4n1ybf
         tYBd2BjU16cA3fQONBS1EP9m3WxqGFibfb5It364Yy8uUs8fXb7AJrW14RkQNBLvEApC
         Y8ynW4jIySJ4f8aNN2iqvzhbk6E7Xd3G9Z+gTIESGDq9GomyYnp2yzc6i7T8Upgs3w5u
         ED29W26pYknmgnOe7u23iDwD57SEXRO4D0UEYPTWlKJDsZHleLhsBRJXnYUU29QGFKf1
         rXrx59SE//Q7FkhtXEphpHqpxAEDhtdJsHkNz/yVfmCrCDEcyO2tuCRpezCXrWoTEomV
         ApHA==
X-Gm-Message-State: AOAM530b9IBqFsKwPHm3cZslWBQYawGuZVJxfXOuUVdMXdB4UUcveFas
        ZT1esb2axNszcu4qm0kwPzKBR+WvSFqx1B1PBVthtQ==
X-Google-Smtp-Source: ABdhPJwK8GHsQwdp9vyTZWpwEqdZo+WJwfQ/RzI8dqwEldOdwfGlen4uSOJYU/jBl5wlXkUdnFu/Zf7creSN7XEKAm4=
X-Received: by 2002:ab0:6353:: with SMTP id f19mr2793756uap.69.1595485284749;
 Wed, 22 Jul 2020 23:21:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200713204300.345975-1-badhri@google.com> <20200714060520.GB657428@kroah.com>
 <040b4cde-91d4-7776-60b5-8f55b6e75831@roeck-us.net> <CAPTae5JHSrp5H47Dr9mrkS_PF_W8MH1TFMzNCc4Geva0-b-B0A@mail.gmail.com>
In-Reply-To: <CAPTae5JHSrp5H47Dr9mrkS_PF_W8MH1TFMzNCc4Geva0-b-B0A@mail.gmail.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 22 Jul 2020 23:20:48 -0700
Message-ID: <CAPTae5KZKKFhgovg1jGwyWhSQ-gfdXDsKUL+yFNxqkq27VK49g@mail.gmail.com>
Subject: Re: [PATCH] usb: typec: tcpm: Move to high priority workqueue for
 processing events
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     reg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Just sent out the patch "usb: typec: tcpm: Migrate workqueue to RT
priority for processing events" which uses kthread_create_worker and
hrtimer.nAppreciate your guidance !! The commits 38a1222ae4f3 and
1ff688209e2e were spot on as they were trying solve the same problem
in a different subsystem.

Thanks,
Badhri

On Tue, Jul 14, 2020 at 10:16 AM Badhri Jagan Sridharan
<badhri@google.com> wrote:
>
> On Mon, Jul 13, 2020 at 11:58 PM Guenter Roeck <linux@roeck-us.net> wrote=
:
> >
> > On 7/13/20 11:05 PM, reg Kroah-Hartman wrote:
> > > On Mon, Jul 13, 2020 at 01:43:00PM -0700, Badhri Jagan Sridharan wrot=
e:
> > >> "tReceiverResponse 15 ms Section 6.6.2
> > >> The receiver of a Message requiring a response Shall respond
> > >> within tReceiverResponse in order to ensure that the
> > >> sender=E2=80=99s SenderResponseTimer does not expire."
> > >>
> > >> When the cpu complex is busy running other lower priority
> > >> work items, TCPM's work queue sometimes does not get scheduled
> > >> on time to meet the above requirement from the spec.
> > >> Elevating the TCPM's work queue to higher priority allows
> > >> TCPM to meet tReceiverResponse in a busy system.
> > >>
> > >> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > >> ---
> > >>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/=
tcpm.c
> > >> index 82b19ebd7838e0..088b6f1fa1ff89 100644
> > >> --- a/drivers/usb/typec/tcpm/tcpm.c
> > >> +++ b/drivers/usb/typec/tcpm/tcpm.c
> > >> @@ -4747,7 +4747,7 @@ struct tcpm_port *tcpm_register_port(struct de=
vice *dev, struct tcpc_dev *tcpc)
> > >>      mutex_init(&port->lock);
> > >>      mutex_init(&port->swap_lock);
> > >>
> > >> -    port->wq =3D create_singlethread_workqueue(dev_name(dev));
> > >> +    port->wq =3D alloc_ordered_workqueue("%s", WQ_HIGHPRI, dev_name=
(dev));
> > >
> > > How are you "guaranteeing" that this is really going to change anythi=
ng
> > > on a highly loaded machine?
> > >
> > > Yes, it might make things better, but if you have a hard deadline lik=
e
> > > this, you need to do things a bit differently to always ensure that y=
ou
> > > meet it.  I do not think this change is that fix, do you?
> > >
> Yes Greg I agree with you, moving to HIGHPRI was making it better but
> is not going to
> solve the problem always. I was wondering whether are there better
> ways of doing this.
>
> >
> > Good point. The worker in drivers/watchdog/ !watchdog_dev.c might be
> > useful as a starting point. There may be better examples - this is
> > just one I know of which had a similar problem. See commits
> > 38a1222ae4f3 and 1ff688209e2e.
> >
> > Guenter
>
> Thanks a lot Guenter !! Very useful pointers, will review the
> approaches in both the
> commits !
