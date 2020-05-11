Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E6A8C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C38520882
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732040AbgEKU75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731936AbgEKU7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57687C061A0E;
        Mon, 11 May 2020 13:59:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWV-0005pn-A2; Mon, 11 May 2020 22:59:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5757F1C0837;
        Mon, 11 May 2020 22:59:30 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:30 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add torture tests for RCU Tasks Trace
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077025.390.480686560796550762.tip-bot2@tip-bot2>
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

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c1a76c0b6abac4e7eb49b5c24a0829f47b70769d
Gitweb:        https://git.kernel.org/tip/c1a76c0b6abac4e7eb49b5c24a0829f47b70769d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 10 Mar 2020 10:32:30 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcutorture: Add torture tests for RCU Tasks Trace

This commit adds the definitions required to torture the tracing flavor
of RCU tasks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                                    |  2 +-
 kernel/rcu/rcu.h                                            |  1 +-
 kernel/rcu/rcutorture.c                                     | 44 ++++++-
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST       |  1 +-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01      | 10 ++-
 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot |  1 +-
 6 files changed, 58 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index b5f3545..452feae 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -30,6 +30,7 @@ config RCU_PERF_TEST
 	select SRCU
 	select TASKS_RCU
 	select TASKS_RUDE_RCU
+	select TASKS_TRACE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs performance
@@ -48,6 +49,7 @@ config RCU_TORTURE_TEST
 	select SRCU
 	select TASKS_RCU
 	select TASKS_RUDE_RCU
+	select TASKS_TRACE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index c574620..7290386 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -442,6 +442,7 @@ enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
 	RCU_TASKS_RUDE_FLAVOR,
+	RCU_TASKS_TRACING_FLAVOR,
 	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
 	INVALID_RCU_FLAVOR
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 6b06638..0bec925 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -45,6 +45,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/oom.h>
 #include <linux/tick.h>
+#include <linux/rcupdate_trace.h>
 
 #include "rcu.h"
 
@@ -757,6 +758,45 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.name		= "tasks-rude"
 };
 
+/*
+ * Definitions for tracing RCU-tasks torture testing.
+ */
+
+static int tasks_tracing_torture_read_lock(void)
+{
+	rcu_read_lock_trace();
+	return 0;
+}
+
+static void tasks_tracing_torture_read_unlock(int idx)
+{
+	rcu_read_unlock_trace();
+}
+
+static void rcu_tasks_tracing_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu_tasks_trace(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops tasks_tracing_ops = {
+	.ttype		= RCU_TASKS_TRACING_FLAVOR,
+	.init		= rcu_sync_torture_init,
+	.readlock	= tasks_tracing_torture_read_lock,
+	.read_delay	= srcu_read_delay,  /* just reuse srcu's version. */
+	.readunlock	= tasks_tracing_torture_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.deferred_free	= rcu_tasks_tracing_torture_deferred_free,
+	.sync		= synchronize_rcu_tasks_trace,
+	.exp_sync	= synchronize_rcu_tasks_trace,
+	.call		= call_rcu_tasks_trace,
+	.cb_barrier	= rcu_barrier_tasks_trace,
+	.fqs		= NULL,
+	.stats		= NULL,
+	.irq_capable	= 1,
+	.slow_gps	= 1,
+	.name		= "tasks-tracing"
+};
+
 static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -1323,6 +1363,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 				  rcu_read_lock_bh_held() ||
 				  rcu_read_lock_sched_held() ||
 				  srcu_read_lock_held(srcu_ctlp) ||
+				  rcu_read_lock_trace_held() ||
 				  torturing_tasks());
 	if (p == NULL) {
 		/* Wait for rcu_torture_writer to get underway */
@@ -2440,7 +2481,8 @@ rcu_torture_init(void)
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops, &trivial_ops,
+		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops,
+		&tasks_tracing_ops, &trivial_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index ec0c72f..dfb1817 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -15,3 +15,4 @@ TASKS01
 TASKS02
 TASKS03
 RUDE01
+TRACE01
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
new file mode 100644
index 0000000..078e2c1
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01
@@ -0,0 +1,10 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=4
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+#CHECK#CONFIG_PROVE_RCU=y
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
new file mode 100644
index 0000000..9675ad6
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/TRACE01.boot
@@ -0,0 +1 @@
+rcutorture.torture_type=tasks-tracing
