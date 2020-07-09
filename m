Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9B5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCBEF20663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:13:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ChllgYMf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgGIKN6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgGIKN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:13:57 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3752C061A0B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 03:13:57 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id dm12so675798qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 03:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WjZTjs02fu7fnerdCk5ET/PatSUJYyYJSI5RutPAEE=;
        b=ChllgYMfz/gmomQEI81iWspGrHDfWjgdo049A6gjgs5gi5KNYSYCwEgjIseBF5/czl
         MNGBJ6+DVdAc6+oj5PiyJfmsKUj5Qm8Fyr4LEu+9t8t4xYvRG422l+iZOCXsq7+9jXio
         BYgSYG5zXDb47xF6x4pMuBPKcsLiz4dvsC5Ck/mfLB/TLLN9Z0J1bT6YSlESOzZupMjC
         GyNQYuRLhsbwuHWfYlGmLF6EuEmxaybjxPCbuZU0zPt6DyU1kJptJeu9GYnZ5PArw2hk
         qjLcI6OskqSR6O/3cr/gmXa5rWQ8IUX5c+/ufeeGQWQaEkMqpWkiZi6QXBsTimNAtXDj
         bT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WjZTjs02fu7fnerdCk5ET/PatSUJYyYJSI5RutPAEE=;
        b=C/EyhEs70SJ0lKzLqrROC7B9vvoJIO9Nuv9Dg9qeEWmItwxKtHGqqPnFO7OrGaTQrA
         vtS82tH5d9oPd3RX2i65ZVlG3HWvtuDhetxxISeNWoEVVepibLk3VMA6ZAp/BOKPaGbh
         5PQA5b1B5fO4FnmZLFRCRKvV4aucXW8DseSnLCvHWPae9ViW3R/1FHWn2an9UAxiVMo6
         S6boa7bjknf2yQ4+InwljRZf/euqTiOTGluxtPGttiEie7xS5eXPuXIFmgRnCH7uz6Lw
         bL7gI5/S2dDZImFNFDZCxwKZmvwQW/DIVBtSTnIPa52kfbzZN0mVdROWpWstE+FzdU6w
         Q4Bw==
X-Gm-Message-State: AOAM5328TYwAmnK1Ii7ltrXG+XgXOfumac6/VltKCKEsXDFuBveqjilk
        gFnz/MTgF7Tvt56lceUBi/CuzSD2xQd6qfTrrdWF0g==
X-Google-Smtp-Source: ABdhPJxNEPKDrORg/ebJJ7z/FfGLGRvapcU7zAzxAl8u7hZxdNGaLgvgGX/ZCH4aT91R7HBzM3kZqB0OQk4j2wMorkg=
X-Received: by 2002:a0c:dc07:: with SMTP id s7mr62810191qvk.122.1594289636572;
 Thu, 09 Jul 2020 03:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000042f21905a991ecea@google.com> <20200704164522.GO9247@paulmck-ThinkPad-P72>
 <CACT4Y+Zs4TO9-XSZ7cRXFZVqRakS8WuSno2=dac6Gv2XmExbkA@mail.gmail.com>
 <CACT4Y+aMJRwQANQZ5Fr1RPZ6EOZ2zEPaZwMTndKJ+mTJ8o6b7Q@mail.gmail.com> <20200707162610.GY9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200707162610.GY9247@paulmck-ThinkPad-P72>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 9 Jul 2020 12:13:44 +0200
Message-ID: <CACT4Y+Z8yErbDWPxv5tX0hnw7cTa6nJjg5f=MWMYS-2X91TZ9w@mail.gmail.com>
Subject: Re: KASAN: stack-out-of-bounds Read in csd_lock_record
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     syzbot <syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 6:26 PM Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Tue, Jul 07, 2020 at 05:51:48PM +0200, Dmitry Vyukov wrote:
> > On Sat, Jul 4, 2020 at 8:34 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > >
> > > On Sat, Jul 4, 2020 at 6:45 PM Paul E. McKenney <paulmck@kernel.org> wrote:
> > > >
> > > > On Fri, Jul 03, 2020 at 04:31:22PM -0700, syzbot wrote:
> > > > > Hello,
> > > > >
> > > > > syzbot found the following crash on:
> > > > >
> > > > > HEAD commit:    9e50b94b Add linux-next specific files for 20200703
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=1024b405100000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=f99cc0faa1476ed6
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=0f719294463916a3fc0e
> > > > > compiler:       gcc (GCC) 10.1.0-syz 20200507
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16dc490f100000
> > > > >
> > > > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > > > Reported-by: syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com
> > > >
> > > > Good catch!  A call to csd_lock_record() was on the wrong side of a
> > > > call to csd_unlock().
> > >
> > > Thanks for taking a look.
> > >
> > > > But is folded into another commit for bisectability reasons, so
> > > > "Reported-by" would not make sense.  I have instead added this to the
> > > > commit log:
> > > >
> > > > [ paulmck: Fix for syzbot+0f719294463916a3fc0e@syzkaller.appspotmail.com ]
> > > > Link: https://lore.kernel.org/lkml/00000000000042f21905a991ecea@google.com
> > > > Link: https://lore.kernel.org/lkml/0000000000002ef21705a9933cf3@google.com
> > >
> > > This should work, as far as I remember sybot looks for the email+hash
> > > anywhere in the commit.
> > > FWIW Tested-by can make sense as well.
> >
> > Paul, there is also some spike of stalls in smp_call_function,
> > if you look at the top ones at:
> > https://syzkaller.appspot.com/upstream#open
> >
> > Can these be caused by the same root cause?
> > I am not sure what trees the bug was/is present... This seems to only
> > happen on linux-next and nowhere else. But these stalls equally happen
> > on mainline...
>
> I would be surprised, given that the csd_unlock() was before the faulting
> reference.  But then again, I have been surprised before.

Yes, it seems unrelated.
It looks like something broken in the kernel recently and now instead
of diagnosing a stall on one CPU, it diagnoses it as a stall in
smp_call_function on another CPU. This produces large number of
assorted stall reports which are not too actionable...


> You aren't running scftorture with its longwait parameter set to a
> non-zero value, are you?  In that case, stalls are expected behavior.
> This is to support test the CSD lock diagnostics in -rcu.  Which isn't
> in mainline yet, so maybe I am asking a stupid question.

Since I don't know what is scftorture/longwait, I guess I am not running it :)

> If these are repeatable, one thing to try is to build the kernel with
> CSD_LOCK_WAIT_DEBUG=y.  This requires c6c67d89c059 ("smp: Add source and
> destination CPUs to __call_single_data") and 216d15e0d870 ("kernel/smp:
> Provide CSD lock timeout diagnostics") from the -rcu tree's "dev" branch.
> This will dump out the smp_call_function() function that was to be
> invoked, on the off-chance that the problem is something like lock
> contention in that function.

Here are some with reproducers:
https://syzkaller.appspot.com/bug?id=8a1e95291152ce5afea43c103a1fd62a257fcf4b
https://syzkaller.appspot.com/bug?id=5e3ac329b6304aacc6304cfaab1a514bca12ce82
https://syzkaller.appspot.com/bug?id=a01b4478f89e19cee91531f7c2b7751f0caf8c0c
https://syzkaller.appspot.com/bug?id=e4caef9fc41d0c019c532a4257faec129699a42e

But the question is if this CSD_LOCK_WAIT_DEBUG=y is useful in
general? Should we enable it all the time?
