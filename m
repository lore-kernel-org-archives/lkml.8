Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3317C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:22:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 782F120658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 16:22:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GfO5cCJa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732089AbgCPQWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 12:22:47 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:37993 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731704AbgCPQWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 12:22:46 -0400
Received: by mail-oi1-f194.google.com with SMTP id k21so18435683oij.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0YSwpvB1oyD4y2ce8RBaDN9TnhxehmimDnF/JqC+Zgs=;
        b=GfO5cCJa79aDMD4rqfExkqyncVYhuK5cD77K2kjdk7KXNm+1wIXIupmO5zMh1W8pOK
         h3LenYYYOuCdSKvp2gLNtTOxpDhPVnm193qY4lqz9x5UfjqvexoYvn07d+x16PN9BKMk
         pf4d2NV++0PPEbS0xpFu2KDHpHXR8sInafIoC5mh28B8S4Iyk2Mm9DkscSfXPnJDP3/r
         aRGRBRgLB0Uskm3YoVExbn7Z2lAOXLgnGel9oVZO5KScRXQ/f9X6gjSg6ni0YsPtLBiG
         nffGqbJ/dIPMWbn6rPD/U1sTwx3KliNFkadVa+AIBeUB2ZTL+Z0wces78O8HQHybt8Ri
         Jw2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0YSwpvB1oyD4y2ce8RBaDN9TnhxehmimDnF/JqC+Zgs=;
        b=f3lCfiHpfd3PtVa6TOlBtSe1HFXdwWZ74C1NKTVtV66dd09F5Q2nZgFu6A8YFECuxl
         UX5nyNbCg7RISHEhUWguVPVYndUBTWoiBGXc1QuDP8oDfvAAQigesNDTKbmTPlQQ+cXO
         IY2pBaTGV1r3YKrO0Ryj5aGpcERhFr+dRo9vnDQW5LShQLM4+ACqhl8v2xA47lCRtTW7
         xRwL8ffGPYE4FQKcg4VTEV7d7v/x98PGRsoX1DXE9Nc+Ql1J7tJy5hRlmFbo/x8wY0HM
         O0GTUHGpqixR4WfzIIvaNFIRTv2K6wAG+GRveMY0MCgp7JeH/Y/IBU1M8OS9p4YnblpR
         fxWw==
X-Gm-Message-State: ANhLgQ3kjkwLVsqa7zmRdhlQhkOds6SskSCeMiHirHIaA1iNmKgv8Ruz
        aSYEavNZ3oIHz8y+hCcq9P3nWTMVs3JbJGRO5yoSlA==
X-Google-Smtp-Source: ADFU+vv/E7lgVfUROfAAXX+UWGXFQba3pdoJSfjPELbyLIdAjpi7SCYFg3nVhsUwQolhlJTTnuDptuzrEHT2qYG+O/0=
X-Received: by 2002:a05:6808:4e:: with SMTP id v14mr283233oic.70.1584375765709;
 Mon, 16 Mar 2020 09:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200309190359.GA5822@paulmck-ThinkPad-P72> <20200309190420.6100-27-paulmck@kernel.org>
 <20200312180328.GA4772@paulmck-ThinkPad-P72> <20200312180414.GA8024@paulmck-ThinkPad-P72>
 <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com>
 <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com> <20200316154535.GX3199@paulmck-ThinkPad-P72>
In-Reply-To: <20200316154535.GX3199@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Mon, 16 Mar 2020 17:22:34 +0100
Message-ID: <CANpmjNOsLeiD6hYXeD4g8fA=Ti6EiUsbtiv4VshRGg+oG1ct-g@mail.gmail.com>
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

On Mon, 16 Mar 2020 at 16:45, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Mon, Mar 16, 2020 at 02:56:38PM +0100, Marco Elver wrote:
> > On Fri, 13 Mar 2020 at 16:28, Marco Elver <elver@google.com> wrote:
> > >
> > > On Thu, 12 Mar 2020 at 19:04, Paul E. McKenney <paulmck@kernel.org> w=
rote:
> > > >
> > > > On Thu, Mar 12, 2020 at 11:03:28AM -0700, Paul E. McKenney wrote:
> > > > > On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org wrot=
e:
> > > > > > From: Marco Elver <elver@google.com>
> > > > > >
> > > > > > Add option to allow interrupts while a watchpoint is set up. Th=
is can be
> > > > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the bo=
ot
> > > > > > parameter 'kcsan.interrupt_watcher=3D1'.
> > > > > >
> > > > > > Note that, currently not all safe per-CPU access primitives and=
 patterns
> > > > > > are accounted for, which could result in false positives. For e=
xample,
> > > > > > asm-generic/percpu.h uses plain operations, which by default ar=
e
> > > > > > instrumented. On interrupts and subsequent accesses to the same
> > > > > > variable, KCSAN would currently report a data race with this op=
tion.
> > > > > >
> > > > > > Therefore, this option should currently remain disabled by defa=
ult, but
> > > > > > may be enabled for specific test scenarios.
> > > > > >
> > > > > > To avoid new warnings, changes all uses of smp_processor_id() t=
o use the
> > > > > > raw version (as already done in kcsan_found_watchpoint()). The =
exact SMP
> > > > > > processor id is for informational purposes in the report, and
> > > > > > correctness is not affected.
> > > > > >
> > > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > >
> > > > > And I get silent hangs that bisect to this patch when running the
> > > > > following rcutorture command, run in the kernel source tree on a
> > > > > 12-hardware-thread laptop:
> > > > >
> > > > > bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --du=
ration 10 --kconfig "CONFIG_DEBUG_INFO=3Dy CONFIG_KCSAN=3Dy CONFIG_KCSAN_AS=
SUME_PLAIN_WRITES_ATOMIC=3Dn CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=3Dn CONF=
IG_KCSAN_REPORT_ONCE_IN_MS=3D100000 CONFIG_KCSAN_VERBOSE=3Dy CONFIG_KCSAN_I=
NTERRUPT_WATCHER=3Dy" --configs TREE03
> > > > >
> > > > > It works fine on some (but not all) of the other rcutorture test
> > > > > scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The comm=
on thread
> > > > > is that these are the TREE scenarios are all PREEMPT=3Dy.  So are=
 RUDE01,
> > > > > SRCU-P, TASKS01, and TASKS03, but these scenarios are not hammeri=
ng
> > > > > on Tree RCU, and thus have far less interrupt activity and the li=
ke.
> > > > > Given that it is an interrupt-related feature being added by this=
 commit,
> > > > > this seems like expected (mis)behavior.
> > > > >
> > > > > Can you reproduce this?  If not, are there any diagnostics I can =
add to
> > > > > my testing?  Or a diagnostic patch I could apply?
> > >
> > > I think I can reproduce it.  Let me debug some more, so far I haven't
> > > found anything yet.
> > >
> > > What I do know is that it's related to reporting. Turning kcsan_repor=
t
> > > into a noop makes the test run to completion.
> > >
> > > > I should hasten to add that this feature was quite helpful in recen=
t work!
> > >
> > > Good to know. :-)  We can probably keep this patch, since the default
> > > config doesn't turn this on. But I will try to see what's up with the
> > > hangs, and hopefully find a fix.
> >
> > So this one turned out to be quite interesting. We can get deadlocks
> > if we can set up multiple watchpoints per task in case it's
> > interrupted and the interrupt sets up another watchpoint, and there
> > are many concurrent races happening; because the other_info struct in
> > report.c may never be released if an interrupt blocks the consumer due
> > to waiting for other_info to become released.
>
> Been there, done that!  ;-)
>
> > Give me another day or 2 to come up with a decent fix.
>
> My thought is to send a pull request for the commits up to but not
> including this patch, allowing ample development and testing time for
> the fix.  My concern with sending this, even with a fix, is that any
> further bugs might cast a shadow on the whole series, further slowing
> acceptance into mainline.
>
> Fair enough?

That's fine. I think the features changes can stay on -rcu/kcsan-dev
for now, but the documentation updates don't depend on them.
If it'd be useful, the updated documentation could be moved before
this patch to -rcu/kcsan, so we'd have

 kcsan: Add current->state to implicitly atomic accesses
 kcsan: Add option for verbose reporting
 kcsan: Add option to allow watcher interruptions
-- cut --
 kcsan: Update API documentation in kcsan-checks.h
 kcsan: Update Documentation/dev-tools/kcsan.rst
 kcsan: Fix a typo in a comment
.. rest of series ..

Although I'm fine with either.

Thanks,
-- Marco
