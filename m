Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4614FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27D5F2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726159AbgFAJwa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgFAJwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:24 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6D62C08C5C0;
        Mon,  1 Jun 2020 02:52:23 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7E-0003f2-Jw; Mon, 01 Jun 2020 11:52:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3CBB31C0244;
        Mon,  1 Jun 2020 11:52:20 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:20 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smp: Optimize send_call_function_single_ipi()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200526161907.953304789@infradead.org>
References: <20200526161907.953304789@infradead.org>
MIME-Version: 1.0
Message-ID: <159100514006.17951.5633093083657745774.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b2a02fc43a1f40ef4eb2fb2b06357382608d4d84
Gitweb:        https://git.kernel.org/tip/b2a02fc43a1f40ef4eb2fb2b06357382608d4d84
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 May 2020 18:11:01 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:54:15 +02:00

smp: Optimize send_call_function_single_ipi()

Just like the ttwu_queue_remote() IPI, make use of _TIF_POLLING_NRFLAG
to avoid sending IPIs to idle CPUs.

[ mingo: Fix UP build bug. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200526161907.953304789@infradead.org
---
 kernel/sched/core.c  | 10 ++++++++++
 kernel/sched/idle.c  |  5 +++++
 kernel/sched/sched.h |  7 ++++---
 kernel/smp.c         | 16 +++++++++++++++-
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 2cacc1e..fa0d499 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2296,6 +2296,16 @@ static void wake_csd_func(void *info)
 	sched_ttwu_pending();
 }
 
+void send_call_function_single_ipi(int cpu)
+{
+	struct rq *rq = cpu_rq(cpu);
+
+	if (!set_nr_if_polling(rq->idle))
+		arch_send_call_function_single_ipi(cpu);
+	else
+		trace_sched_wake_idle_without_ipi(cpu);
+}
+
 /*
  * Queue a task on the target CPUs wake_list and wake the CPU via IPI if
  * necessary. The wakee CPU on receipt of the IPI will queue the task
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index b743bf3..387fd75 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -289,6 +289,11 @@ static void do_idle(void)
 	 */
 	smp_mb__after_atomic();
 
+	/*
+	 * RCU relies on this call to be done outside of an RCU read-side
+	 * critical section.
+	 */
+	flush_smp_call_function_from_idle();
 	sched_ttwu_pending();
 	schedule_idle();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3c163cb..75b0629 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1506,11 +1506,12 @@ static inline void unregister_sched_domain_sysctl(void)
 }
 #endif
 
-#else
+extern void flush_smp_call_function_from_idle(void);
 
+#else /* !CONFIG_SMP: */
+static inline void flush_smp_call_function_from_idle(void) { }
 static inline void sched_ttwu_pending(void) { }
-
-#endif /* CONFIG_SMP */
+#endif
 
 #include "stats.h"
 #include "autogroup.h"
diff --git a/kernel/smp.c b/kernel/smp.c
index f720e38..9f11813 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -135,6 +135,8 @@ static __always_inline void csd_unlock(call_single_data_t *csd)
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(call_single_data_t, csd_data);
 
+extern void send_call_function_single_ipi(int cpu);
+
 /*
  * Insert a previously allocated call_single_data_t element
  * for execution on the given CPU. data must already have
@@ -178,7 +180,7 @@ static int generic_exec_single(int cpu, call_single_data_t *csd,
 	 * equipped to do the right thing...
 	 */
 	if (llist_add(&csd->llist, &per_cpu(call_single_queue, cpu)))
-		arch_send_call_function_single_ipi(cpu);
+		send_call_function_single_ipi(cpu);
 
 	return 0;
 }
@@ -278,6 +280,18 @@ static void flush_smp_call_function_queue(bool warn_cpu_offline)
 	}
 }
 
+void flush_smp_call_function_from_idle(void)
+{
+	unsigned long flags;
+
+	if (llist_empty(this_cpu_ptr(&call_single_queue)))
+		return;
+
+	local_irq_save(flags);
+	flush_smp_call_function_queue(true);
+	local_irq_restore(flags);
+}
+
 /*
  * smp_call_function_single - Run a function on a specific CPU
  * @func: The function to run. This must be fast and non-blocking.
