Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37134C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13A1F24974
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732479AbgEKVDq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731989AbgEKU7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D453C061A0C;
        Mon, 11 May 2020 13:59:48 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWc-0005rl-8v; Mon, 11 May 2020 22:59:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4BDBB1C07B4;
        Mon, 11 May 2020 22:59:32 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:32 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add torture tests for RCU Tasks Rude
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077218.390.1491218566333354232.tip-bot2@tip-bot2>
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

Commit-ID:     3d6e43c75d6bab212e8bc142585ee36eb8e2e5d9
Gitweb:        https://git.kernel.org/tip/3d6e43c75d6bab212e8bc142585ee36eb8e2e5d9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 03 Mar 2020 15:02:50 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcutorture: Add torture tests for RCU Tasks Rude

This commit adds the definitions required to torture the rude flavor of
RCU tasks.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/Kconfig.debug                                   |  2 +-
 kernel/rcu/rcu.h                                           |  1 +-
 kernel/rcu/rcutorture.c                                    | 31 ++++++-
 tools/testing/selftests/rcutorture/configs/rcu/CFLIST      |  1 +-
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01      | 10 ++-
 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot |  1 +-
 6 files changed, 44 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot

diff --git a/kernel/rcu/Kconfig.debug b/kernel/rcu/Kconfig.debug
index 4aa02ee..b5f3545 100644
--- a/kernel/rcu/Kconfig.debug
+++ b/kernel/rcu/Kconfig.debug
@@ -29,6 +29,7 @@ config RCU_PERF_TEST
 	select TORTURE_TEST
 	select SRCU
 	select TASKS_RCU
+	select TASKS_RUDE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs performance
@@ -46,6 +47,7 @@ config RCU_TORTURE_TEST
 	select TORTURE_TEST
 	select SRCU
 	select TASKS_RCU
+	select TASKS_RUDE_RCU
 	default n
 	help
 	  This option provides a kernel module that runs torture tests
diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index 00ddc92..c574620 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -441,6 +441,7 @@ void rcu_request_urgent_qs_task(struct task_struct *t);
 enum rcutorture_type {
 	RCU_FLAVOR,
 	RCU_TASKS_FLAVOR,
+	RCU_TASKS_RUDE_FLAVOR,
 	RCU_TRIVIAL_FLAVOR,
 	SRCU_FLAVOR,
 	INVALID_RCU_FLAVOR
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index fbb3e62..6b06638 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -730,6 +730,33 @@ static struct rcu_torture_ops trivial_ops = {
 	.name		= "trivial"
 };
 
+/*
+ * Definitions for rude RCU-tasks torture testing.
+ */
+
+static void rcu_tasks_rude_torture_deferred_free(struct rcu_torture *p)
+{
+	call_rcu_tasks_rude(&p->rtort_rcu, rcu_torture_cb);
+}
+
+static struct rcu_torture_ops tasks_rude_ops = {
+	.ttype		= RCU_TASKS_RUDE_FLAVOR,
+	.init		= rcu_sync_torture_init,
+	.readlock	= rcu_torture_read_lock_trivial,
+	.read_delay	= rcu_read_delay,  /* just reuse rcu's version. */
+	.readunlock	= rcu_torture_read_unlock_trivial,
+	.get_gp_seq	= rcu_no_completed,
+	.deferred_free	= rcu_tasks_rude_torture_deferred_free,
+	.sync		= synchronize_rcu_tasks_rude,
+	.exp_sync	= synchronize_rcu_tasks_rude,
+	.call		= call_rcu_tasks_rude,
+	.cb_barrier	= rcu_barrier_tasks_rude,
+	.fqs		= NULL,
+	.stats		= NULL,
+	.irq_capable	= 1,
+	.name		= "tasks-rude"
+};
+
 static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -739,7 +766,7 @@ static unsigned long rcutorture_seq_diff(unsigned long new, unsigned long old)
 
 static bool __maybe_unused torturing_tasks(void)
 {
-	return cur_ops == &tasks_ops;
+	return cur_ops == &tasks_ops || cur_ops == &tasks_rude_ops;
 }
 
 /*
@@ -2413,7 +2440,7 @@ rcu_torture_init(void)
 	int firsterr = 0;
 	static struct rcu_torture_ops *torture_ops[] = {
 		&rcu_ops, &rcu_busted_ops, &srcu_ops, &srcud_ops,
-		&busted_srcud_ops, &tasks_ops, &trivial_ops,
+		&busted_srcud_ops, &tasks_ops, &tasks_rude_ops, &trivial_ops,
 	};
 
 	if (!torture_init_begin(torture_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
index c3c1fb5..ec0c72f 100644
--- a/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
+++ b/tools/testing/selftests/rcutorture/configs/rcu/CFLIST
@@ -14,3 +14,4 @@ TINY02
 TASKS01
 TASKS02
 TASKS03
+RUDE01
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01 b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
new file mode 100644
index 0000000..bafe94c
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01
@@ -0,0 +1,10 @@
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
+CONFIG_HOTPLUG_CPU=y
+CONFIG_PREEMPT_NONE=n
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=y
+CONFIG_DEBUG_LOCK_ALLOC=y
+CONFIG_PROVE_LOCKING=y
+#CHECK#CONFIG_PROVE_RCU=y
+CONFIG_RCU_EXPERT=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
new file mode 100644
index 0000000..9363708
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcu/RUDE01.boot
@@ -0,0 +1 @@
+rcutorture.torture_type=tasks-rude
