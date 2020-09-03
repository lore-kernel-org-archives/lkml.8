Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BFBC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBBA4206D4
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 15:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iIZmjgdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbgICPhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 11:37:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgICPhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 11:37:20 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B16EC061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SKy5YdR8nRowCcugijXzS8cF9ilZwN6ezV7ecLDZuMI=; b=iIZmjgdV7ntsY/9AR5NsftYD6q
        Q4mYaDBpk9UpNw69DGsthBow6AOe2iUPQxBNZtjjcaBFA12hb2dh/dW688CPy8noDdrVBfDs5vIfA
        5r9KTTR+KjiVzJjqCCqqu8nN1swHTIL1F3fBF6ywGd/mVNajRj3f/UaHpm2iCLNVQv5BDXAaKb3Bm
        OFJ77T0uTpis+LmjK9agdN4trHY2nOHdsUEVcGSKJz+447W0g26UWkvb7tqQ/0jEhTc89iqk6JzZ+
        T0Sop5mwdtuxzvAqlr78wOA4hhxjzq9KktPZ1MaVSSS/e7MKfTmKtxqnba2QaMQJkfQxsX6B3TEqu
        vwtJcLPQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDrIA-0001XJ-KD; Thu, 03 Sep 2020 15:36:51 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BB8A0300F7A;
        Thu,  3 Sep 2020 17:36:49 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A4ACD2BC23B39; Thu,  3 Sep 2020 17:36:49 +0200 (CEST)
Date:   Thu, 3 Sep 2020 17:36:49 +0200
From:   peterz@infradead.org
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        joel@joelfernandes.org, svens@linux.ibm.com, tglx@linutronix.de,
        ulf.hansson@linaro.org, viresh.kumar@linaro.org,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2 11/11] lockdep,trace: Expose tracepoints
Message-ID: <20200903153649.GF1362448@hirez.programming.kicks-ass.net>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.782688941@infradead.org>
 <20200902035146.GA45826@roeck-us.net>
 <20200902085636.GV1362448@hirez.programming.kicks-ass.net>
 <e4999b75-604f-29a3-e78c-508ee6bede88@roeck-us.net>
 <20200903140047.GD1362448@hirez.programming.kicks-ass.net>
 <9ea73cb4-262d-d9ba-beac-e9e013f89d6e@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ea73cb4-262d-d9ba-beac-e9e013f89d6e@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 08:19:38AM -0700, Guenter Roeck wrote:
> This doesn't compile for me - there is no "name" parameter in __DO_TRACE().
> 
> Error log:
> In file included from ./include/linux/rculist.h:11,
>                  from ./include/linux/pid.h:5,
>                  from ./include/linux/sched.h:14,
>                  from ./include/linux/sched/numa_balancing.h:10,
>                  from ./include/trace/events/sched.h:8,
>                  from kernel/sched/core.c:10:
> ./include/trace/events/sched.h: In function 'trace_sched_kthread_stop':
> ./include/linux/tracepoint.h:175:26: error: '__tracepoint_name' undeclared
> 
> I applied your patch on top of v5.9-rc3-75-gfc3abb53250a. Are you using
> a different branch ?

Argh, I was on tip/master... easy fix though.

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
index 598fec9f9dbf..0469bc1c24fc 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -164,12 +164,18 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		void *__data;						\
 		int __maybe_unused __idx = 0;				\
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
+			rcu_dereference_sched((tp)->funcs);		\
+			rcu_read_unlock_sched_notrace();		\
+		}							\
+									\
 		/* keep srcu and sched-rcu usage consistent */		\
 		preempt_disable_notrace();				\
 									\
@@ -235,11 +241,6 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
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


