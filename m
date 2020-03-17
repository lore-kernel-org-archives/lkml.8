Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F6AC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:13:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C79FF20738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584465204;
	bh=BqCVv2OsKZz+I4IGlw/e0EIks1KktHt7HapHjxJ5TfM=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=vR5YdbVCeCUHguqSs9uXLgEYM/Rf49JhXZtCj1nThCYfs26cwkFPqb/3+J8kGD7q4
	 P6jxwwZEDrsJX/1QcChIMpri1rt+ywF4x7tCmfy1cMBijsD3u32k9S9DpurAlPKROt
	 A497i3Q2reHShKCI+ai/9hA6q8sWQg75YacQKAdo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCQRNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:13:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726407AbgCQRNV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:13:21 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57CFC20738;
        Tue, 17 Mar 2020 17:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584465200;
        bh=BqCVv2OsKZz+I4IGlw/e0EIks1KktHt7HapHjxJ5TfM=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=mR6aXKPiuaEP/zjSjTImPnNGr7rETk3A8xHAPHt8BJ6L58JGejapK+uKrSswNtweU
         NvGWK+r0zzOFtnb1mhZJPCLP8naq2JcDT0wQX57uE8HGpuZpvwMWkbLeSEDVNG0hQR
         MQP68hXV5LAbq5Jw8L/vE+0U6SrxPcp7J8wJsWhk=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 30E1C35226E2; Tue, 17 Mar 2020 10:13:20 -0700 (PDT)
Date:   Tue, 17 Mar 2020 10:13:20 -0700
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
Message-ID: <20200317171320.GI3199@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200309190359.GA5822@paulmck-ThinkPad-P72>
 <20200309190420.6100-27-paulmck@kernel.org>
 <20200312180328.GA4772@paulmck-ThinkPad-P72>
 <20200312180414.GA8024@paulmck-ThinkPad-P72>
 <CANpmjNOqmsm69vfdCAVGhLzTV-oB3E5saRbjzwrkbO-6nGgTYw@mail.gmail.com>
 <CANpmjNO=jGNNd4J0hBhz4ORLdw_+EHQDvyoQRikRCOsuMAcXYg@mail.gmail.com>
 <20200316154535.GX3199@paulmck-ThinkPad-P72>
 <CANpmjNOsLeiD6hYXeD4g8fA=Ti6EiUsbtiv4VshRGg+oG1ct-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOsLeiD6hYXeD4g8fA=Ti6EiUsbtiv4VshRGg+oG1ct-g@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 05:22:34PM +0100, Marco Elver wrote:
> On Mon, 16 Mar 2020 at 16:45, Paul E. McKenney <paulmck@kernel.org> wrote:
> >
> > On Mon, Mar 16, 2020 at 02:56:38PM +0100, Marco Elver wrote:
> > > On Fri, 13 Mar 2020 at 16:28, Marco Elver <elver@google.com> wrote:
> > > >
> > > > On Thu, 12 Mar 2020 at 19:04, Paul E. McKenney <paulmck@kernel.org> wrote:
> > > > >
> > > > > On Thu, Mar 12, 2020 at 11:03:28AM -0700, Paul E. McKenney wrote:
> > > > > > On Mon, Mar 09, 2020 at 12:04:15PM -0700, paulmck@kernel.org wrote:
> > > > > > > From: Marco Elver <elver@google.com>
> > > > > > >
> > > > > > > Add option to allow interrupts while a watchpoint is set up. This can be
> > > > > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > > > > > parameter 'kcsan.interrupt_watcher=1'.
> > > > > > >
> > > > > > > Note that, currently not all safe per-CPU access primitives and patterns
> > > > > > > are accounted for, which could result in false positives. For example,
> > > > > > > asm-generic/percpu.h uses plain operations, which by default are
> > > > > > > instrumented. On interrupts and subsequent accesses to the same
> > > > > > > variable, KCSAN would currently report a data race with this option.
> > > > > > >
> > > > > > > Therefore, this option should currently remain disabled by default, but
> > > > > > > may be enabled for specific test scenarios.
> > > > > > >
> > > > > > > To avoid new warnings, changes all uses of smp_processor_id() to use the
> > > > > > > raw version (as already done in kcsan_found_watchpoint()). The exact SMP
> > > > > > > processor id is for informational purposes in the report, and
> > > > > > > correctness is not affected.
> > > > > > >
> > > > > > > Signed-off-by: Marco Elver <elver@google.com>
> > > > > > > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > > > >
> > > > > > And I get silent hangs that bisect to this patch when running the
> > > > > > following rcutorture command, run in the kernel source tree on a
> > > > > > 12-hardware-thread laptop:
> > > > > >
> > > > > > bash tools/testing/selftests/rcutorture/bin/kvm.sh --cpus 12 --duration 10 --kconfig "CONFIG_DEBUG_INFO=y CONFIG_KCSAN=y CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n CONFIG_KCSAN_REPORT_ONCE_IN_MS=100000 CONFIG_KCSAN_VERBOSE=y CONFIG_KCSAN_INTERRUPT_WATCHER=y" --configs TREE03
> > > > > >
> > > > > > It works fine on some (but not all) of the other rcutorture test
> > > > > > scenarios.  It fails on TREE01, TREE02, TREE03, TREE09.  The common thread
> > > > > > is that these are the TREE scenarios are all PREEMPT=y.  So are RUDE01,
> > > > > > SRCU-P, TASKS01, and TASKS03, but these scenarios are not hammering
> > > > > > on Tree RCU, and thus have far less interrupt activity and the like.
> > > > > > Given that it is an interrupt-related feature being added by this commit,
> > > > > > this seems like expected (mis)behavior.
> > > > > >
> > > > > > Can you reproduce this?  If not, are there any diagnostics I can add to
> > > > > > my testing?  Or a diagnostic patch I could apply?
> > > >
> > > > I think I can reproduce it.  Let me debug some more, so far I haven't
> > > > found anything yet.
> > > >
> > > > What I do know is that it's related to reporting. Turning kcsan_report
> > > > into a noop makes the test run to completion.
> > > >
> > > > > I should hasten to add that this feature was quite helpful in recent work!
> > > >
> > > > Good to know. :-)  We can probably keep this patch, since the default
> > > > config doesn't turn this on. But I will try to see what's up with the
> > > > hangs, and hopefully find a fix.
> > >
> > > So this one turned out to be quite interesting. We can get deadlocks
> > > if we can set up multiple watchpoints per task in case it's
> > > interrupted and the interrupt sets up another watchpoint, and there
> > > are many concurrent races happening; because the other_info struct in
> > > report.c may never be released if an interrupt blocks the consumer due
> > > to waiting for other_info to become released.
> >
> > Been there, done that!  ;-)
> >
> > > Give me another day or 2 to come up with a decent fix.
> >
> > My thought is to send a pull request for the commits up to but not
> > including this patch, allowing ample development and testing time for
> > the fix.  My concern with sending this, even with a fix, is that any
> > further bugs might cast a shadow on the whole series, further slowing
> > acceptance into mainline.
> >
> > Fair enough?
> 
> That's fine. I think the features changes can stay on -rcu/kcsan-dev
> for now, but the documentation updates don't depend on them.
> If it'd be useful, the updated documentation could be moved before
> this patch to -rcu/kcsan, so we'd have
> 
>  kcsan: Add current->state to implicitly atomic accesses
>  kcsan: Add option for verbose reporting
>  kcsan: Add option to allow watcher interruptions
> -- cut --
>  kcsan: Update API documentation in kcsan-checks.h
>  kcsan: Update Documentation/dev-tools/kcsan.rst
>  kcsan: Fix a typo in a comment
> .. rest of series ..
> 
> Although I'm fine with either.

Given my churn with a recent merge window, I am more reluctant than
I might otherwise be to do that sort of rearrangement.  Sorry to be
so cowardly!

							Thanx, Paul
