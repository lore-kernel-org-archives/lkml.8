Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 004A1C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F5C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbgBJWGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:34024 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727431AbgBJWGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 17:06:46 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00CCC2070A;
        Mon, 10 Feb 2020 22:06:44 +0000 (UTC)
Date:   Mon, 10 Feb 2020 17:06:43 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: [PATCH] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200210170643.3544795d@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

Commit e6753f23d961d ("tracepoint: Make rcuidle tracepoint callers use
SRCU") removed the calls to rcu_irq_enter/exit_irqson() and replaced it with
srcu callbacks as that much faster for the rcuidle cases. But this caused an
issue with perf, because perf only uses rcu to synchronize trace points.

The issue was that if perf traced one of the "rcuidle" paths, that path no
longer enabled RCU if it was not watching, and this caused lockdep to
complain when the perf code used rcu_read_lock() and RCU was not "watching".

Commit 865e63b04e9b2 ("tracing: Add back in rcu_irq_enter/exit_irqson() for
rcuidle tracepoints") added back the rcu_irq_enter/exit_irqson() code, but
this made the srcu changes no longer applicable.

As perf is the only callback that needs the heavier weight
"rcu_irq_enter/exit_irqson()" calls, move it to the perf specific code and
not bog down those that do not require it.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/tracepoint.h |  8 ++------
 include/trace/perf.h       | 17 +++++++++++++++--
 kernel/rcu/tree.c          |  2 ++
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 1fb11daa5c53..a83fd076a312 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -179,10 +179,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		 * For rcuidle callers, use srcu since sched-rcu	\
 		 * doesn't work from the idle path.			\
 		 */							\
-		if (rcuidle) {						\
+		if (rcuidle)						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqson();				\
-		}							\
 									\
 		it_func_ptr = rcu_dereference_raw((tp)->funcs);		\
 									\
@@ -194,10 +192,8 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 			} while ((++it_func_ptr)->func);		\
 		}							\
 									\
-		if (rcuidle) {						\
-			rcu_irq_exit_irqson();				\
+		if (rcuidle)						\
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
-		}							\
 									\
 		preempt_enable_notrace();				\
 	} while (0)
diff --git a/include/trace/perf.h b/include/trace/perf.h
index dbc6c74defc3..1c94ce0cd4e2 100644
--- a/include/trace/perf.h
+++ b/include/trace/perf.h
@@ -39,17 +39,27 @@ perf_trace_##call(void *__data, proto)					\
 	u64 __count = 1;						\
 	struct task_struct *__task = NULL;				\
 	struct hlist_head *head;					\
+	bool rcu_watching;						\
 	int __entry_size;						\
 	int __data_size;						\
 	int rctx;							\
 									\
+	rcu_watching = rcu_is_watching();				\
+									\
 	__data_size = trace_event_get_offsets_##call(&__data_offsets, args); \
 									\
+	if (!rcu_watching) {						\
+		/* Can not use RCU if rcu is not watching and in NMI */	\
+		if (in_nmi())						\
+			return;						\
+		rcu_irq_enter_irqson();					\
+	}								\
+									\
 	head = this_cpu_ptr(event_call->perf_events);			\
 	if (!bpf_prog_array_valid(event_call) &&			\
 	    __builtin_constant_p(!__task) && !__task &&			\
 	    hlist_empty(head))						\
-		return;							\
+		goto out;						\
 									\
 	__entry_size = ALIGN(__data_size + sizeof(*entry) + sizeof(u32),\
 			     sizeof(u64));				\
@@ -57,7 +67,7 @@ perf_trace_##call(void *__data, proto)					\
 									\
 	entry = perf_trace_buf_alloc(__entry_size, &__regs, &rctx);	\
 	if (!entry)							\
-		return;							\
+		goto out;						\
 									\
 	perf_fetch_caller_regs(__regs);					\
 									\
@@ -68,6 +78,9 @@ perf_trace_##call(void *__data, proto)					\
 	perf_trace_run_bpf_submit(entry, __entry_size, rctx,		\
 				  event_call, __count, __regs,		\
 				  head, __task);			\
+out:									\
+	if (!rcu_watching)						\
+		rcu_irq_exit_irqson();					\
 }
 
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 1694a6b57ad8..3e6f07b62515 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -719,6 +719,7 @@ void rcu_irq_exit_irqson(void)
 	rcu_irq_exit();
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(rcu_irq_exit_irqson);
 
 /*
  * Exit an RCU extended quiescent state, which can be either the
@@ -890,6 +891,7 @@ void rcu_irq_enter_irqson(void)
 	rcu_irq_enter();
 	local_irq_restore(flags);
 }
+EXPORT_SYMBOL_GPL(rcu_irq_enter_irqson);
 
 /*
  * If any sort of urgency was applied to the current CPU (for example,
-- 
2.20.1

