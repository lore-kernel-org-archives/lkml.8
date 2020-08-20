Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEBEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFA7207DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 19:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHTT71 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 15:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:46650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgHTT70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 15:59:26 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3534F2076E;
        Thu, 20 Aug 2020 19:59:25 +0000 (UTC)
Date:   Thu, 20 Aug 2020 15:59:23 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Marco Elver <elver@google.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, will@kernel.org, npiggin@gmail.com,
        jgross@suse.com, paulmck@kernel.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de
Subject: Re: [PATCH 0/9] TRACE_IRQFLAGS wreckage
Message-ID: <20200820155923.3d5c4873@oasis.local.home>
In-Reply-To: <20200820172046.GA177701@elver.google.com>
References: <20200820073031.886217423@infradead.org>
        <20200820103643.1b9abe88@oasis.local.home>
        <20200820145821.GA1362448@hirez.programming.kicks-ass.net>
        <20200820172046.GA177701@elver.google.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Aug 2020 19:20:46 +0200
Marco Elver <elver@google.com> wrote:

> On Thu, Aug 20, 2020 at 04:58PM +0200, peterz@infradead.org wrote:
> > On Thu, Aug 20, 2020 at 10:36:43AM -0400, Steven Rostedt wrote:  
> > > 
> > > I tested this series on top of tip/master and triggered the below
> > > warning when running the irqsoff tracer boot up test (config attached).
> > > 
> > > -- Steve
> > > 
> > >  Testing tracer irqsoff: 
> > >  
> > >  =============================
> > >  WARNING: suspicious RCU usage
> > >  5.9.0-rc1-test+ #92 Not tainted
> > >  -----------------------------
> > >  include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!  
> ...
> > 
> > Shiny, I think that wants something like the below, but let me go frob
> > my config and test it.
> > 
> > ---
> > --- a/drivers/cpuidle/cpuidle.c
> > +++ b/drivers/cpuidle/cpuidle.c  
> ...
> 
> With that applied (manually, due to conflicts), I still get warnings for
> certain call locations with KCSAN on (that is with my fix from the other
> email):
> 
> | =============================
> | WARNING: suspicious RCU usage
> | 5.9.0-rc1+ #23 Tainted: G        W        
> | -----------------------------
> | include/trace/events/random.h:310 suspicious rcu_dereference_check() usage!
> | 
> | other info that might help us debug this:
> | 
> | 
> | rcu_scheduler_active = 2, debug_locks = 0
> | RCU used illegally from extended quiescent state!
> | no locks held by swapper/1/0.
> | 
> | stack backtrace:
> | CPU: 1 PID: 0 Comm: swapper/1 Tainted: G        W         5.9.0-rc1+ #23
> | Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
> | Call Trace:
> |  __dump_stack lib/dump_stack.c:77 [inline]
> |  dump_stack+0xf1/0x14d lib/dump_stack.c:118
> |  trace_prandom_u32 include/trace/events/random.h:310 [inline]
> |  prandom_u32+0x1ee/0x200 lib/random32.c:86
> |  prandom_u32_max include/linux/prandom.h:46 [inline]
> |  reset_kcsan_skip kernel/kcsan/core.c:277 [inline]
> |  kcsan_setup_watchpoint+0x9b/0x600 kernel/kcsan/core.c:424
> |  is_idle_task+0xd/0x20 include/linux/sched.h:1671 		<==== inline, but not noinstr
> |  irqentry_enter+0x17/0x50 kernel/entry/common.c:293 		<==== noinstr function
> 

What happens if you apply the below patch?

-- Steve

diff --git a/lib/random32.c b/lib/random32.c
index 932345323af0..1c5607a411d4 100644
--- a/lib/random32.c
+++ b/lib/random32.c
@@ -83,7 +83,7 @@ u32 prandom_u32(void)
 	u32 res;
 
 	res = prandom_u32_state(state);
-	trace_prandom_u32(res);
+	trace_prandom_u32_rcuidle(res);
 	put_cpu_var(net_rand_state);
 
 	return res;
