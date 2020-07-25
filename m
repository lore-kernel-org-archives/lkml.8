Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A346C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:44:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7691D206D7
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 17:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2UQhjcBh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727854AbgGYRoi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726995AbgGYRoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 13:44:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE49C08C5C0
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jul 2020 10:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=IzlB8C4ebbWL5U23JeDEz95EVKPJZOd57Pw+Ihb9yS4=; b=2UQhjcBh9fvIISuXAxoCEifRW3
        uc5y6cxLCDu3konYEKpwvi1biaFLwBsd96kUVi2T57kwFRHIs4TPN2UIrfaA/Hr0n0eSTLT5327YY
        9MKVYyaTe1hyQ2SU0fRuUTiuvNMixWOIiNL1ZRRfJ1IB7IlzMm6TymbhSo0CjrTYyeatdz0V7VXUL
        KIf5E1KDPv97iSrro2CE8AhW42HGtnX3128M7GTiXIfezGFFrNIPIsPtWGcggWpuCcWPFtjfh5eJP
        876BOX8Wng4CAhnelnuLt3jWciA1GBaHISOxp5Y+cm6jeMjt6MDYqhEfwhjsqpi4QQeqjgbAZZE4m
        auAgsE/A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jzODo-0008IH-Qa; Sat, 25 Jul 2020 17:44:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1283E301179;
        Sat, 25 Jul 2020 19:44:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EC37120104627; Sat, 25 Jul 2020 19:44:30 +0200 (CEST)
Date:   Sat, 25 Jul 2020 19:44:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kcsan: Add option to allow watcher interruptions
Message-ID: <20200725174430.GH10769@hirez.programming.kicks-ass.net>
References: <20200220141551.166537-1-elver@google.com>
 <20200220185855.GY2935@paulmck-ThinkPad-P72>
 <20200220213317.GA35033@google.com>
 <20200725145623.GZ9247@paulmck-ThinkPad-P72>
 <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPhuvrhRHAiuv2Zju1VNSe7dO0aaYn+1TB99OF2Hv0S_A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 25, 2020 at 05:17:43PM +0200, Marco Elver wrote:
> On Sat, 25 Jul 2020 at 16:56, Paul E. McKenney <paulmck@kernel.org> wrote:
> > On Thu, Feb 20, 2020 at 10:33:17PM +0100, Marco Elver wrote:
> > > On Thu, 20 Feb 2020, Paul E. McKenney wrote:
> > > > On Thu, Feb 20, 2020 at 03:15:51PM +0100, Marco Elver wrote:
> > > > > Add option to allow interrupts while a watchpoint is set up. This can be
> > > > > enabled either via CONFIG_KCSAN_INTERRUPT_WATCHER or via the boot
> > > > > parameter 'kcsan.interrupt_watcher=1'.
> [...]
> > > > > As an example, the first data race that this found:
> > > > >
> > > > > write to 0xffff88806b3324b8 of 4 bytes by interrupt on cpu 0:
> > > > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]
> > > > >  __rcu_read_lock+0x3c/0x50 kernel/rcu/tree_plugin.h:373
> [...]
> > > > > read to 0xffff88806b3324b8 of 4 bytes by task 6131 on cpu 0:       |
> > > > >  rcu_preempt_read_enter kernel/rcu/tree_plugin.h:353 [inline]  ----+
> [...]
> > > > >
> > > > > The writer is doing 'current->rcu_read_lock_nesting++'. The read is as
> > > > > vulnerable to compiler optimizations and would therefore conclude this
> > > > > is a valid data race.
> > > >
> > > > Heh!  That one is a fun one!  It is on a very hot fastpath.  READ_ONCE()
> > > > and WRITE_ONCE() are likely to be measurable at the system level.
> > > >
> > > > Thoughts on other options?

> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
> > > index c6ea81cd41890..e0595abd50c0f 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -350,17 +350,17 @@ static int rcu_preempt_blocked_readers_cgp(struct rcu_node *rnp)
> > >
> > >  static void rcu_preempt_read_enter(void)
> > >  {
> > > -     current->rcu_read_lock_nesting++;
> > > +     local_inc(&current->rcu_read_lock_nesting);
> > >  }
> > >
> > >  static void rcu_preempt_read_exit(void)
> > >  {
> > > -     current->rcu_read_lock_nesting--;
> > > +     local_dec(&current->rcu_read_lock_nesting);
> > >  }
> > >
> > >  static void rcu_preempt_depth_set(int val)
> > >  {
> > > -     current->rcu_read_lock_nesting = val;
> > > +     local_set(&current->rcu_read_lock_nesting, val);
> 
> > I agree that this removes the data races, and that the code for x86 is
> > quite nice, but aren't rcu_read_lock() and rcu_read_unlock() going to
> > have heavyweight atomic operations on many CPUs?
> >
> > Maybe I am stuck with arch-specific code in rcu_read_lock() and
> > rcu_preempt_read_exit().  I suppose worse things could happen.
> 
> Peter also mentioned to me that while local_t on x86 generates
> reasonable code, on other architectures it's terrible. So I think
> something else is needed, and feel free to discard the above idea.
> With sufficient enough reasoning, how bad would a 'data_race(..)' be?

Right, so local_t it atrocious on many architectures, they fall back to
atomic_t.

Even architectures that have optimized variants (eg. Power), they're
quite a lot more expensive than what we actually need here.

Only architectures like x86 that have single instruction memops can
generate anywhere near the code that we'd want here.

So the thing is, since RCU count is 0 per context (an IRQ must have an
equal amount of rcu_read_unlock() as it has rcu_read_lock()), interrupts
are not in fact a problem, even on load-store (RISC) architectures
(preempt_count has the same thing).

So the addition/subtraction in rcu_preempt_read_{enter,exit}() doesn't
need to be atomic vs interrupts. The only thing we really do need is
them being single-copy-atomic.

The problem with READ/WRITE_ONCE is that if we were to use it, we'd end
up with a load-store, even on x86, which is sub-optimal.

I suppose the 'correct' code here would be something like:

	*((volatile int *)&current->rcu_read_lock_nesting)++;

then the compiler can either do a single memop (x86 and the like) or a
load-store that is free from tearing.


