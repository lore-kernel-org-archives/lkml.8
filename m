Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78971C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:45:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FA772071C
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584373538;
	bh=lZh2UH1vaPZgUoTeswY5i4DsjVcM49h34P67hgeTXmI=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=yEH5VaVVFEgrI1p40LewJBO8/9DWEuekuEaq1NOoptcTB5IHq+MZTszJv+gEdNN8J
	 dweLPnYhRagHlEJQ3zh4E1xV9c2zLjnAxiG5p/JiK4w3xYIHO75fD+nyLvpRuFUhxO
	 2ygvlLuL9rSxUdQdSCVD8sl2Z1eFEjEY/7uYZd8Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731893AbgCPPph (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:45:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731715AbgCPPpg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 11:45:36 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F310220679;
        Mon, 16 Mar 2020 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584373536;
        bh=lZh2UH1vaPZgUoTeswY5i4DsjVcM49h34P67hgeTXmI=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=P1EkSJ3rP/Jq/1IgNaK7grui5CLqBycqrh6a+v5UWYDh2W4VOIhH1S/AHpdYIBjuG
         TuIEkQ7j3smWgXWWxJjlHW3EutJP5c1wjjutBhNc5kLUUpi0SjrzAtoAwrn4I8rvtG
         CTNwbHXx+MOk7viN/x52MKTc0laODLhWT5xPya3o=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id BD7EC3522DE1; Mon, 16 Mar 2020 08:45:35 -0700 (PDT)
Date:   Mon, 16 Mar 2020 08:45:35 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>, kernel-team@fb.com,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, Qian Cai <cai@lca.pw>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH kcsan 27/32] kcsan: Add option to allow watcher
 interruptions
Message-ID: <20200316154535.GX3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
 <20200309190420.6100-27-paulmck@kernel.org>
 <20200312180328.GA4772@paulmck-ThinkPad-P72>
 <20200312180414.GA8024@paulmck-ThinkPad-P72>
 <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com>
 <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 02:56:38PM +0100, Marco Elver wrote:
> On Fri, 13 Mar 2020 at 16:28, Marco Elver <elver@google.com> wrote:
> >
> > On Thu, 12 Mar 2020 at 19:04, Paul E. McKenney <paulmck@kernel.org> wrote:
> > >
> > > On Thu, Mar 12, 2020 at 11:03:28AM -0700, Paul E. McKenney wrote:
> > > > On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org wrote:
> > > > > From: Marco Elver <elver@google.com>
> > > > >
> > > > > Add option to allow interrupts while a watchpoint is set up. This can be
> > > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > > > parameter 'kcsan.interrupt_watcher=1'.
> > > > >
> > > > > Note that, currently not all safe per-CPU access primitives and patterns
> > > > > are accounted for, which could result in false positives. For example,
> > > > > asm-generic/percpu.h uses plain operations, which by default are
> > > > > instrumented. On interrupts and subsequent accesses to the same
> > > > > variable, KCSAN would currently report a data race with this option.
> > > > >
> > > > > Therefore, this option should currently remain disabled by default, but
> > > > > may be enabled for specific test scenarios.
> > > > >
> > > > > To avoid new warnings, changes all uses of smp_processor_id() to use the
> > > > > raw version (as already done in kcsan_found_watchpoint()). The exact SMP
> > > > > processor id is for informational purposes in the report, and
> > > > > correctness is not affected.
> > > > >
> > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >
> > > > And I get silent hangs that bisect to this patch when running the
> > > > following rcutorture command, run in the kernel source tree on a
> > > > 12-hardware-thread laptop:
> > > >
> > > > bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --duration 10 --kconfig "CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y" --configs TREE03
> > > >
> > > > It works fine on some (but not all) of the other rcutorture test
> > > > scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The common thread
> > > > is that these are the TREE scenarios are all PREEMPT=y.  So are RUDE01,
> > > > SRCU-P, TASKS01, and TASKS03, but these scenarios are not hammering
> > > > on Tree RCU, and thus have far less interrupt activity and the like.
> > > > Given that it is an interrupt-related feature being added by this commit,
> > > > this seems like expected (mis)behavior.
> > > >
> > > > Can you reproduce this?  If not, are there any diagnostics I can add to
> > > > my testing?  Or a diagnostic patch I could apply?
> >
> > I think I can reproduce it.  Let me debug some more, so far I haven't
> > found anything yet.
> >
> > What I do know is that it's related to reporting. Turning kcsan_report
> > into a noop makes the test run to completion.
> >
> > > I should hasten to add that this feature was quite helpful in recent work!
> >
> > Good to know. :-)  We can probably keep this patch, since the default
> > config doesn't turn this on. But I will try to see what's up with the
> > hangs, and hopefully find a fix.
> 
> So this one turned out to be quite interesting. We can get deadlocks
> if we can set up multiple watchpoints per task in case it's
> interrupted and the interrupt sets up another watchpoint, and there
> are many concurrent races happening; because the other_info struct in
> report.c may never be released if an interrupt blocks the consumer due
> to waiting for other_info to become released.

Been there, done that!  ;-)

> Give me another day or 2 to come up with a decent fix.

My thought is to send a pull request for the commits up to but not
including this patch, allowing ample development and testing time for
the fix.  My concern with sending this, even with a fix, is that any
further bugs might cast a shadow on the whole series, further slowing
acceptance into mainline.

Fair enough?

							Thanx, Paul
