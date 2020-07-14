Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D785C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5C5722574
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 17:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VBuqWZc3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbgGNRRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgGNRRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 13:17:02 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D3C061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:17:02 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id g22so3847960vke.9
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 10:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=laL9jqyDAhx8XNNdn2YvqLz5e2HsHmGbabHru5+6+ac=;
        b=VBuqWZc3c+PV/wsheMBO3Vhs1BGr9+VWwRe05MDbpZdOf/G+daYhXw4yDzDIfW1fED
         0lyxr9FjVC4EHq9r2uYZMsdGn8/tizR7hUsSwZjkerZ1wGgHr1OEHHQgSyshpcxJqqTf
         7N4uMIWxxiO/fnIi4BbjtufFGzGoAK1VsSk1yoamyQcz10vtvr8/R6VJ64EoIaW/8H67
         wvPp8gR3TyuOB9oSm5zH92PYfdfxFnytZyCnvhcBpdFNYdtibwY31XF1nQbwoU2ZE/EY
         Y1igfMjeV6q1ZQRZfPD6/j+u35LjChvDXySpQk3KA9drVbJMTEAEowF9B68b7xc6hMmT
         D5Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=laL9jqyDAhx8XNNdn2YvqLz5e2HsHmGbabHru5+6+ac=;
        b=DpsHi+gjvb00b34ZENFz2uR4CC+TXfvKXcdWVJZph17d5Ewzh8TbaeeE02qbHCx14x
         yQ2nlx/rLsCWepn78nH58cDbwCymy/NDy7V+ThM/qnRP/wNJz+cZ47zQmZ8ewgTNVKwk
         4VorTgUnT3RsIJp0iyPSt5WOnWzyytu1Aiyd/i3KZ1UJDPdsskIyab22CUnYXX0N8YoC
         zL9gFpvCfu4cbAYaGsnOwAxFDtDsgII/AuGPu3Lb/V1r8KMtXx6rciXdLPZqyqU/kKQz
         cy36gng/H88bNRlRC2/Uv9dmuRYocowRTA0JeXKmQTm5ilVq/un3I56Exu0j1vWqA7iA
         0Zhw==
X-Gm-Message-State: AOAM532zv0FXY0CKyEhq+p8usuLsSFrw//uGxTX+gWJHxUivYxA7CnBx
        jecPegf/ba8tFdzgeC2hICxtBZKOq8TBE5emSOl0m8dr
X-Google-Smtp-Source: ABdhPJzHNFrugBMO2S61VslrpSRXmFF2CHqMHlK2gROBSdoqMAnqNd/Z46gTkqHWdvA45vYX+KRznEjm7iQcOKGJrdc=
X-Received: by 2002:ac5:c189:: with SMTP id z9mr4800999vkb.79.1594747021495;
 Tue, 14 Jul 2020 10:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200713204300.345975-1-badhri@google.com> <20200714060520.GB657428@kroah.com>
 <040b4cde-91d4-7776-60b5-8f55b6e75831@roeck-us.net>
In-Reply-To: <040b4cde-91d4-7776-60b5-8f55b6e75831@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Tue, 14 Jul 2020 10:16:25 -0700
Message-ID: <CAPTae5JHSrp5H47Dr9mrkS_PF_W8MH1TFMzNCc4Geva0-b-B0A@mail.gmail.com>
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

On Mon, Jul 13, 2020 at 11:58 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 7/13/20 11:05 PM, reg Kroah-Hartman wrote:
> > On Mon, Jul 13, 2020 at 01:43:00PM -0700, Badhri Jagan Sridharan wrote:
> >> "tReceiverResponse 15 ms Section 6.6.2
> >> The receiver of a Message requiring a response Shall respond
> >> within tReceiverResponse in order to ensure that the
> >> sender=E2=80=99s SenderResponseTimer does not expire."
> >>
> >> When the cpu complex is busy running other lower priority
> >> work items, TCPM's work queue sometimes does not get scheduled
> >> on time to meet the above requirement from the spec.
> >> Elevating the TCPM's work queue to higher priority allows
> >> TCPM to meet tReceiverResponse in a busy system.
> >>
> >> Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> >> ---
> >>  drivers/usb/typec/tcpm/tcpm.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tc=
pm.c
> >> index 82b19ebd7838e0..088b6f1fa1ff89 100644
> >> --- a/drivers/usb/typec/tcpm/tcpm.c
> >> +++ b/drivers/usb/typec/tcpm/tcpm.c
> >> @@ -4747,7 +4747,7 @@ struct tcpm_port *tcpm_register_port(struct devi=
ce *dev, struct tcpc_dev *tcpc)
> >>      mutex_init(&port->lock);
> >>      mutex_init(&port->swap_lock);
> >>
> >> -    port->wq =3D create_singlethread_workqueue(dev_name(dev));
> >> +    port->wq =3D alloc_ordered_workqueue("%s", WQ_HIGHPRI, dev_name(d=
ev));
> >
> > How are you "guaranteeing" that this is really going to change anything
> > on a highly loaded machine?
> >
> > Yes, it might make things better, but if you have a hard deadline like
> > this, you need to do things a bit differently to always ensure that you
> > meet it.  I do not think this change is that fix, do you?
> >
Yes Greg I agree with you, moving to HIGHPRI was making it better but
is not going to
solve the problem always. I was wondering whether are there better
ways of doing this.

>
> Good point. The worker in drivers/watchdog/ !watchdog_dev.c might be
> useful as a starting point. There may be better examples - this is
> just one I know of which had a similar problem. See commits
> 38a1222ae4f3 and 1ff688209e2e.
>
> Guenter

Thanks a lot Guenter !! Very useful pointers, will review the
approaches in both the
commits !
