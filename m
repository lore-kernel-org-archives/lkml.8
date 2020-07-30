Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73A50C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 505B322B40
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 02:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lfV5Tdpz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgG3CjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 22:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728407AbgG3CjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 22:39:01 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD94C061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:39:01 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id 4so3554473uav.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 19:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=E20RVflhVFnMt9UGu16p7I5RTrWtNW8Uf2aYJ2/Gr7Y=;
        b=lfV5TdpzVjKu+M+liEs7tTTk+NgtfxK/nozymIFCnGRVSdsVuikHvSbNgxaTqgZfml
         1UGtWqI3XGE+pRbt7DP1OE4nQ5uaB7Rxs83BXQQ1vkXSeqBT1UzB4Ijhc8yifp9PIKHt
         sBVSGbd39iUAzWsjPlaDTt/Qh2hHox0avjEdPw83tS/cG87HYumw4idIsfBBmiQA/c2r
         lcyeeoZzSF5fYUYH/vPZLwpEvAcf0/TlXxkQffsAn2f3127QcNHypevW9SqabO95VuDJ
         UxULZ/YT3sj8J+d7nnVfz8yMy5p5Qq86PaBezHfjTmRZNIITG+pZ1Is8CuWsYQkb5vvM
         khwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=E20RVflhVFnMt9UGu16p7I5RTrWtNW8Uf2aYJ2/Gr7Y=;
        b=dKiOVCWiJ2JY9V3wK91+ZsFm5pwUbQqxeUGddaStGz6WmkGPkwNxI1UvgJsknf8c7/
         VQrQzwtpgGYyj+kUSyZ1Kh5F4/KpSadaRos9KMuTXnHWOc8swRzpt6ZZshMP+hY93H2m
         yMz2uY00YdL/xsHozwe2fXtAgr0W6u1ozJFCCaGaxUhLGfc4cW/aP9Gpm82jypf4eQHj
         lQsiPcM2+AGJJzTdm6TWJm8OfN8dID0S+E9fkOXpwX5v+qsnhXsatUtVUnAxen+OOXem
         eXFkDm9F7bJd9g00UAKijfNxCZ5uT6YNSX+nvjiHSjtHai9OXWWsTGOPFhMvOHnlTJR3
         sYuQ==
X-Gm-Message-State: AOAM530652yRSApBGAH0Ja65ALnKURKItLNOToqgXwotUnN6nrRPm8aB
        B2DKxk38k0TWYGKyuod6fF0/Cssx8mK1HqMM0M5Kdw==
X-Google-Smtp-Source: ABdhPJxIG1HcbbzQQNHtu2oFdgoSkUBH11ggchCC3T+Er2W4FoZeNX6n5wjRR6RQEjk76B7mkoDqEKz27yn1e+kCykA=
X-Received: by 2002:a9f:370a:: with SMTP id z10mr12273015uad.69.1596076737246;
 Wed, 29 Jul 2020 19:38:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200724020551.2737376-1-badhri@google.com> <20200729145309.GA3490882@kroah.com>
In-Reply-To: <20200729145309.GA3490882@kroah.com>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 29 Jul 2020 19:38:21 -0700
Message-ID: <CAPTae5+jOkRs9nWRMQHg3uBjZnqYhZnR=DTg5-Yku1r4qOqNZQ@mail.gmail.com>
Subject: Re: [PATCH v2] usb: typec: tcpm: Migrate workqueue to RT priority for
 processing events
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Sure just sent the new patch v3.

Patch applies cleanly on my end. So wondering what I am missing.
Just in case if you are still noticing merge conflicts.

Here is the git log of my local tree:
633198cd2945b7 (HEAD -> usb-next-1) usb: typec: tcpm: Migrate
workqueue to RT priority for processing events
fa56dd9152ef95 (origin/usb-next) Merge tag 'usb-serial-5.9-rc1' of
https://git.kernel.org/pub/scm/linux/kernel/git/johan/usb-serial into
usb-next
25252919a1050e xhci: dbgtty: Make some functions static
b0e02550346e67 xhci: dbc: Make function xhci_dbc_ring_alloc() static
ca6377900974c3 Revert "usb: dwc2: override PHY input signals with usb
role switch support"
09df709cb5aeb2 Revert "usb: dwc2: don't use ID/Vbus detection if
usb-role-switch on STM32MP15 SoCs"
17a82716587e9d USB: iowarrior: fix up report size handling for some devices
e98ba8cc3f8a89 Merge tag 'usb-for-v5.9' of
git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb into usb-next
c97793089b11f7 Merge 5.8-rc7 into usb-next
92ed301919932f (tag: v5.8-rc7, origin/usb-linus, origin/main) Linux 5.8-rc7

Was comparing against
https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git/log/?h=3Dusb=
-next

Thanks,
Badhri


On Wed, Jul 29, 2020 at 7:53 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Jul 23, 2020 at 07:05:51PM -0700, Badhri Jagan Sridharan wrote:
> > "tReceiverResponse 15 ms Section 6.6.2
> > The receiver of a Message requiring a response Shall respond
> > within tReceiverResponse in order to ensure that the
> > sender=E2=80=99s SenderResponseTimer does not expire."
> >
> > When the cpu complex is busy running other lower priority
> > work items, TCPM's work queue sometimes does not get scheduled
> > on time to meet the above requirement from the spec.
> > Moving to kthread_work apis to run with real time priority.
> > Just lower than the default threaded irq priority,
> > MAX_USER_RT_PRIO/2 + 1. (Higher number implies lower priority).
> >
> > Further, as observed in 1ff688209e2e, moving to hrtimers to
> > overcome scheduling latency while scheduling the delayed work.
> >
> > TCPM has three work streams:
> > 1. tcpm_state_machine
> > 2. vdm_state_machine
> > 3. event_work
> >
> > tcpm_state_machine and vdm_state_machine both schedule work in
> > future i.e. delayed. Hence each of them have a corresponding
> > hrtimer, tcpm_state_machine_timer & vdm_state_machine_timer.
> >
> > When work is queued right away kthread_queue_work is used.
> > Else, the relevant timer is programmed and made to queue
> > the kthread_work upon timer expiry.
> >
> > kthread_create_worker only creates one kthread worker thread,
> > hence single threadedness of workqueue is retained.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
>
> This doesn't apply against my usb-next branch at all.
>
> Can you rebase and resend?
>
> Remember to collect the reviewed-by tags as well when you do so.
>
> thanks,
>
> greg k-h
