Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93031C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C6820724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:28:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t+u32kyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgCMP2g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:28:36 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:33638 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgCMP2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:28:36 -0400
Received: by mail-oi1-f195.google.com with SMTP id r7so9792674oij.0
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 08:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JhUIJfLxmDw2Pu91CEiBsHmiHtKiQT2VqIQ9110wd4A=;
        b=t+u32kyhLw+7adryUUVInMpucQxHziECi40b/B2TaT2Oh4SIWUyC4ZsgDIMJHnwq55
         +VA+YrbrTrv/YeN9eoJ1jsXjNNjmqb8KUK238UoQT2NqWZCcgNB9d0tcx5FXHVJ15krP
         /D3ts1NUogGV8daixTF1UbUeJqRZXGVyU5XemJKqTYXiuAgkYYGRXTQy2fHJm2CkX+to
         TIkeZpUfOBYUMhzXKZrYbI3mUiyZ9SKzUKtZXyIJmY6PEUi7ayUlOHymkBjYxWgAKAun
         x+/TGGr7IZ0/VacU7K1KFV6M2XNIYPX+AABmzYn0uFxXuOGCS8YaJ+0LKQ44u2d4QC7V
         +RSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JhUIJfLxmDw2Pu91CEiBsHmiHtKiQT2VqIQ9110wd4A=;
        b=TGJZvmOihXV3OAEjl0HTXJr7EiyD5RVXHxEFupPg1N33vLtFKnkTgX63MCQZjupDZL
         vyQHhaimjb6Nevw8+6RFz9Rl58W2H0qTBNagGqfTfWBw3k0NhS1HhPdmIK85FGJo1dah
         I2BhK6Gtrx9EM0q3jY+GY6ZNXDyq9bRjOo3f1MN8AEkMIOUFsDbbDtzXHJmSO57UzkYQ
         PBAU3WYtU0MkJeczC3iOX7MBm5gIXpmdQvSORlHT3evB7R6F4DaK1CI9AcTZJoujmftv
         fNx47VUR3oH/f9nTIwFsdGhJfn7GvE2q7oYA3qArY6NWRBMHrrYfJm9I3gIkjpV8SlK0
         94pw==
X-Gm-Message-State: ANhLgQ2jFxoGiWszi5Hs9m4JjK61p9REq0kgHPWDCDZduSF8gVh344BX
        iDfKSvtHcRkOrDKi3tMXOie9hFT51Di/11jwGmf0vA==
X-Google-Smtp-Source: ADFU+vtaJJMt+GLtMNMWk5U9y4vLRkiYAf4WkM2Me8zd76he9xhBYHltUHQ1oqyHiVqEGT+K6h3YkdkkxWPUevQEbqA=
X-Received: by 2002:aca:4cd8:: with SMTP id z207mr7211572oia.155.1584113314909;
 Fri, 13 Mar 2020 08:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200309190359.GA5822@paulmck-ThinkPad-P72> <20200309190420.6100-27-paulmck@kernel.org>
 <20200312180328.GA4772@paulmck-ThinkPad-P72> <20200312180414.GA8024@paulmck-ThinkPad-P72>
In-Reply-To: <20200312180414.GA8024@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Fri, 13 Mar 2020 16:28:23 +0100
Message-ID: <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com>
Subject: Re: [PATCH kcsan 27/32] kcsan: Add option to allow watcher interruptions
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020 at 19:04, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Mar 12, 2020 at 11:03:28AM -0700, Paul E. McKenney wrote:
> > On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org wrote:
> > > From: Marco Elver <elver@google.com>
> > >
> > > Add option to allow interrupts while a watchpoint is set up. This can=
 be
> > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > parameter 'kcsan.interrupt_watcher=3D1'.
> > >
> > > Note that, currently not all safe per-CPU access primitives and patte=
rns
> > > are accounted for, which could result in false positives. For example=
,
> > > asm-generic/percpu.h uses plain operations, which by default are
> > > instrumented. On interrupts and subsequent accesses to the same
> > > variable, KCSAN would currently report a data race with this option.
> > >
> > > Therefore, this option should currently remain disabled by default, b=
ut
> > > may be enabled for specific test scenarios.
> > >
> > > To avoid new warnings, changes all uses of smp_processor_id() to use =
the
> > > raw version (as already done in kcsan_found_watchpoint()). The exact =
SMP
> > > processor id is for informational purposes in the report, and
> > > correctness is not affected.
> > >
> > > Signed-off-by: Marco Elver <elver@google.com>
> > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> > And I get silent hangs that bisect to this patch when running the
> > following rcutorture command, run in the kernel source tree on a
> > 12-hardware-thread laptop:
> >
> > bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --duration=
 10 --kconfig "CONFIG_DEBUG_INFO=3Dy CONFIG_KCSAN=3Dy CONFIG_KCSAN_ASSUME_P=
LAIN_WRITES_ATOMIC=3Dn CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dn CONFIG_KCS=
AN_REPORT_ONCE_IN_MS=3D100000 CONFIG_KCSAN_VERBOSE=3Dy CONFIG_KCSAN_INTERRU=
PT_WATCHER=3Dy" --configs TREE03
> >
> > It works fine on some (but not all) of the other rcutorture test
> > scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The common thr=
ead
> > is that these are the TREE scenarios are all PREEMPT=3Dy.  So are RUDE0=
1,
> > SRCU-P, TASKS01, and TASKS03, but these scenarios are not hammering
> > on Tree RCU, and thus have far less interrupt activity and the like.
> > Given that it is an interrupt-related feature being added by this commi=
t,
> > this seems like expected (mis)behavior.
> >
> > Can you reproduce this?  If not, are there any diagnostics I can add to
> > my testing?  Or a diagnostic patch I could apply?

I think I can reproduce it.  Let me debug some more, so far I haven't
found anything yet.

What I do know is that it's related to reporting. Turning kcsan_report
into a noop makes the test run to completion.

> I should hasten to add that this feature was quite helpful in recent work=
!

Good to know. :-)  We can probably keep this patch, since the default
config doesn't turn this on. But I will try to see what's up with the
hangs, and hopefully find a fix.

Thanks,
-- Marco
