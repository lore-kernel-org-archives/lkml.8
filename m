Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DEAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B12F2072A
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 14:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EzOOuC3K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729217AbgICOOr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 10:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729189AbgICOLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 10:11:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC6C061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 07:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qVAAo3cfmgrogiwKK5Lo7FxdIw7lvM7vC5DYxMfRdDc=; b=EzOOuC3KIcQeVjUlVPJ4IAnpB3
        6GyOiA4goiGHCazIVT5amdek/qdf40kE8618mbJwJwlptywP9OVravY+UQ31MuafqTFR1P1B1H/7X
        YpcXGTgflIZit+2eNrFZe/Kn4NVn/2zIfNrloGiWKAkxsmzwaQVO6+C0uPwgcmiu6c6fGodNci9xA
        IL74StQk7cSLzvGYvkir/rXuSrMNIT2j8fcy6Bz9kSaT8dbk4lXCo0lLDElmQSLhNS7WOlJP9WAvL
        ZKxDc029udQ8HcqMeugUNWxcPbaODUAyX1Z/yZUQtQpbSXy3LhnGAbPh3IY6Pnmd0pQNoIRgmvoW7
        Bytvr+GQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDpnF-00061W-IJ; Thu, 03 Sep 2020 14:00:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C3993011C6;
        Thu,  3 Sep 2020 16:00:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 226D72BBB3E7F; Thu,  3 Sep 2020 16:00:47 +0200 (CEST)
Date:   Thu, 3 Sep 2020 16:00:47 +0200
From:   peterz@infradead.org
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
Message-ID: <20200903140047.GD1362448@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
 <20200902035146.GA45826@roeck-us.net>
 <20200902085636.GV1362448@hirez.programming.kicks-ass.net>
 <e4999b75-604f-29a3-e78c-508ee6bede88@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4999b75-604f-29a3-e78c-508ee6bede88@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 06:57:36AM -0700, Guenter Roeck wrote:
> On 9/2/20 1:56 AM, peterz@infradead.org wrote:
> > On Tue, Sep 01, 2020 at 08:51:46PM -0700, Guenter Roeck wrote:
> > 
> >> [   27.056457] include/trace/events/lock.h:13 suspicious rcu_dereference_check() usage!
> > 
> >> [   27.057006] Hardware name: Generic OMAP3-GP (Flattened Device Tree)
> >> [   27.057098] [<c03125b4>] (unwind_backtrace) from [<c030c32c>] (show_stack+0x10/0x14)
> >> [   27.057189] [<c030c32c>] (show_stack) from [<c08e7a4c>] (dump_stack+0xd8/0xf8)
> >> [   27.057312] [<c08e7a4c>] (dump_stack) from [<c03b04bc>] (lock_acquire+0x4d8/0x4dc)
> >> [   27.057464] [<c03b04bc>] (lock_acquire) from [<c12457e8>] (_raw_spin_lock_irqsave+0x58/0x74)
> >> [   27.057617] [<c12457e8>] (_raw_spin_lock_irqsave) from [<c0338198>] (pwrdm_lock+0x10/0x18)
> >> [   27.057739] [<c0338198>] (pwrdm_lock) from [<c033a214>] (clkdm_deny_idle+0x10/0x24)
> >> [   27.057891] [<c033a214>] (clkdm_deny_idle) from [<c0332e10>] (omap3_enter_idle_bm+0xd4/0x1b8)
> >> [   27.058044] [<c0332e10>] (omap3_enter_idle_bm) from [<c0f740d4>] (cpuidle_enter_state+0x16c/0x620)
> > 
> > ARM cpuidle is a trainwreck :/
> > 
> > So it looks like we have:
> > 
> >  - clkdm_
> >  - pwrdm_
> >  - cpu_pm_
> >  - pm_runtime_
> > 
> > In that approximate order, and then there's the coupled idle muck.
> > Sometimes cpuidle core calls cpu_pm_*(), but mostly it's sprinkled
> > around in drivers.
> > 
> > How about we unconditionally kill tracing when RCU is idle? Yes this is
> > a hack, and we really should turn it into a WARN in due time.
> > 
> > The thing is, we're shutting down clock/power domains and god knows
> > what, the CPU is in a crap state, we'll not take interrupts, but tracing
> > must happen! Hell no.
> > 
> > Let's make the rule that if you want something traced, you get to pull
> > it out of the cpuidle driver and stick it in the generic code with a
> > CPUIDLE_FLAG, before rcu_idle_enter().
> > 
> > Totally untested patch below..
> > 
> 
> Unfortunately, that patch does not make a difference; I still see the
> same tracebacks with it applied.

I stuck a tracepoint in intel_idle and had a rummage around. The below
seems to work for me now.

---
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0e149c..878bac893e41 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -27,17 +27,20 @@
  *         SOFTIRQ_MASK:	0x0000ff00
  *         HARDIRQ_MASK:	0x000f0000
  *             NMI_MASK:	0x00f00000
+ *         RCUIDLE_MASK:	0x01000000
  * PREEMPT_NEED_RESCHED:	0x80000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_BITS	4
 #define NMI_BITS	4
+#define RCUIDLE_BITS	1
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 #define NMI_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
+#define RCUIDLE_SHIFT	(NMI_SHIFT     + NMI_BITS)
 
 #define __IRQ_MASK(x)	((1UL << (x))-1)
 
@@ -45,11 +48,13 @@
 #define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
 #define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
 #define NMI_MASK	(__IRQ_MASK(NMI_BITS)     << NMI_SHIFT)
+#define RCUIDLE_MASK	(__IRQ_MASK(RCUIDLE_BITS) << RCUIDLE_SHIFT)
 
 #define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
 #define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
 #define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
 #define NMI_OFFSET	(1UL << NMI_SHIFT)
+#define RCUIDLE_OFFSET	(1UL << RCUIDLE_SHIFT)
 
 #define SOFTIRQ_DISABLE_OFFSET	(2 * SOFTIRQ_OFFSET)
 
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 3722a10fc46d..5bc45f6750f5 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -172,12 +172,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		int __maybe_unused __idx = 0;				\
 		void *__data;						\
 									\
-		if (!(cond))						\
+		if (!(cond) || (preempt_count() & RCUIDLE_MASK))	\
 			return;						\
 									\
 		/* srcu can't be used from NMI */			\
 		WARN_ON_ONCE(rcuidle && in_nmi());			\
 									\
+		if (IS_ENABLED(CONFIG_LOCKDEP) && !(rcuidle)) {		\
+			rcu_read_lock_sched_notrace();			\
+			rcu_dereference_sched(__tracepoint_##name.funcs);\
+			rcu_read_unlock_sched_notrace();		\
+		}							\
+									\
 		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
 									\
@@ -242,11 +248,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 				TP_PROTO(data_proto),			\
 				TP_ARGS(data_args),			\
 				TP_CONDITION(cond), 0);			\
-		if (IS_ENABLED(CONFIG_LOCKDEP) && (cond)) {		\
-			rcu_read_lock_sched_notrace();			\
-			rcu_dereference_sched(__tracepoint_##name.funcs);\
-			rcu_read_unlock_sched_notrace();		\
-		}							\
 	}								\
 	__DECLARE_TRACE_RCU(name, PARAMS(proto), PARAMS(args),		\
 		PARAMS(cond), PARAMS(data_proto), PARAMS(data_args))	\
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8ce77d9ac716..ad9fb4f12c63 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -269,6 +269,8 @@ static noinstr void rcu_dynticks_eqs_enter(void)
 	/* Better not have special action (TLB flush) pending! */
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) &&
 		     (seq & RCU_DYNTICK_CTRL_MASK));
+
+	__preempt_count_add(RCUIDLE_OFFSET);
 }
 
 /*
@@ -281,6 +283,8 @@ static noinstr void rcu_dynticks_eqs_exit(void)
 	struct rcu_data *rdp = this_cpu_ptr(&rcu_data);
 	int seq;
 
+	__preempt_count_sub(RCUIDLE_OFFSET);
+
 	/*
 	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
 	 * and we also must force ordering with the next RCU read-side
