Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC756C54E8D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9913120882
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 20:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732051AbgEKU77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726946AbgEKU7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2E9C061A0C;
        Mon, 11 May 2020 13:59:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWU-0005o5-Tu; Mon, 11 May 2020 22:59:39 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7AA211C06DA;
        Mon, 11 May 2020 22:59:27 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:27 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Provide boot parameter to delay IPIs until
 late in grace period
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076742.390.5618701239564079461.tip-bot2@tip-bot2>
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

Commit-ID:     b0afa0f056676ffe0a7213818f09d2460adbcc16
Gitweb:        https://git.kernel.org/tip/b0afa0f056676ffe0a7213818f09d2460adbcc16
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Mar 2020 11:39:26 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Provide boot parameter to delay IPIs until late in grace period

This commit provides a rcupdate.rcu_task_ipi_delay kernel boot parameter
that specifies how old the RCU tasks trace grace period must be before
the grace-period kthread starts sending IPIs.  This delay allows more
tasks to pass through rcu_tasks_qs() quiescent states, thus reducing
(or even eliminating) the number of IPIs that must be sent.

On a short rcutorture test setting this kernel boot parameter to HZ/2
resulted in zero IPIs for all 877 RCU-tasks trace grace periods that
elapsed during that test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  7 +++++++
 kernel/rcu/tasks.h                              | 13 +++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f2a93c8..aaa8678 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4286,6 +4286,13 @@
 			only normal grace-period primitives.  No effect
 			on CONFIG_TINY_RCU kernels.
 
+	rcupdate.rcu_task_ipi_delay= [KNL]
+			Set time in jiffies during which RCU tasks will
+			avoid sending IPIs, starting with the beginning
+			of a given grace period.  Setting a large
+			number avoids disturbing real-time workloads,
+			but lengthens grace periods.
+
 	rcupdate.rcu_task_stall_timeout= [KNL]
 			Set timeout in jiffies for RCU task stall warning
 			messages.  Disable with a value less than or equal
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 71462cf..eeac4a1 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -74,6 +74,11 @@ static struct rcu_tasks rt_name =					\
 /* Track exiting tasks in order to allow them to be waited for. */
 DEFINE_STATIC_SRCU(tasks_rcu_exit_srcu);
 
+/* Avoid IPIing CPUs early in the grace period. */
+#define RCU_TASK_IPI_DELAY (HZ / 2)
+static int rcu_task_ipi_delay __read_mostly = RCU_TASK_IPI_DELAY;
+module_param(rcu_task_ipi_delay, int, 0644);
+
 /* Control stall timeouts.  Disable with <= 0, otherwise jiffies till stall. */
 #define RCU_TASK_STALL_TIMEOUT (HZ * 60 * 10)
 static int rcu_task_stall_timeout __read_mostly = RCU_TASK_STALL_TIMEOUT;
@@ -713,6 +718,10 @@ DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
+void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
+DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
+		 "RCU Tasks Trace");
+
 /* If we are the last reader, wake up the grace-period kthread. */
 void rcu_read_unlock_trace_special(struct task_struct *t)
 {
@@ -998,10 +1007,6 @@ void exit_tasks_rcu_finish_trace(struct task_struct *t)
 		rcu_read_unlock_trace_special(t);
 }
 
-void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
-DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
-		 "RCU Tasks Trace");
-
 /**
  * call_rcu_tasks_trace() - Queue a callback trace task-based grace period
  * @rhp: structure to be used for queueing the RCU updates.
