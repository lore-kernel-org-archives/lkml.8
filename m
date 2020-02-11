Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 945D0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:50:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71D222082F
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgBKOuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:50:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:37002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728009AbgBKOuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:50:51 -0500
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFDB20708;
        Tue, 11 Feb 2020 14:50:49 +0000 (UTC)
Date:   Tue, 11 Feb 2020 09:50:47 -0500
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
Subject: [PATCH v2] tracing/perf: Move rcu_irq_enter/exit_irqson() to perf
 trace point hook
Message-ID: <20200211095047.58ddf750@gandalf.local.home>
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
issue with perf, because perf only uses rcu to synchronize its trace point
callback routines.

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
Changes since v1:

  - Moved the rcu_is_watching logic to perf_tp_event() and remove the
    exporting of rcu_irq_enter/exit_irqson().

 include/linux/tracepoint.h |  8 ++------
 kernel/events/core.c       | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

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
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 455451d24b4a..0abbf5e2ee62 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -8941,6 +8941,7 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 {
 	struct perf_sample_data data;
 	struct perf_event *event;
+	bool rcu_watching = rcu_is_watching();
 
 	struct perf_raw_record raw = {
 		.frag = {
@@ -8949,6 +8950,17 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 		},
 	};
 
+	if (!rcu_watching) {
+		/*
+		 * If nmi_enter() is traced, it is possible that
+		 * RCU may not be watching "yet", and this is called.
+		 * We can not call rcu_irq_enter_irqson() in this case.
+		 */
+		if (unlikely(in_nmi()))
+			goto out;
+		rcu_irq_enter_irqson();
+	}
+
 	perf_sample_data_init(&data, 0, 0);
 	data.raw = &raw;
 
@@ -8985,8 +8997,11 @@ void perf_tp_event(u16 event_type, u64 count, void *record, int entry_size,
 unlock:
 		rcu_read_unlock();
 	}
-
+	if (!rcu_watching)
+		rcu_irq_exit_irqson();
+out:
 	perf_swevent_put_recursion_context(rctx);
+
 }
 EXPORT_SYMBOL_GPL(perf_tp_event);
 
-- 
2.20.1


