Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D153C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C1E20836
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731801AbgEKVEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731852AbgEKU7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:39 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D6EC061A0C;
        Mon, 11 May 2020 13:59:39 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWT-0005pW-Pb; Mon, 11 May 2020 22:59:37 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E30B61C0494;
        Mon, 11 May 2020 22:59:29 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:29 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add stall warnings for RCU Tasks Trace
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076982.390.17964288214382278812.tip-bot2@tip-bot2>
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

Commit-ID:     4593e772b5020e714e18f6e212d70b24fbe88b79
Gitweb:        https://git.kernel.org/tip/4593e772b5020e714e18f6e212d70b24fbe88b79
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 10 Mar 2020 12:13:53 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcu-tasks: Add stall warnings for RCU Tasks Trace

This commit adds RCU CPU stall warnings for RCU Tasks Trace.  These
dump out any tasks blocking the current grace period, as well as any
CPUs that have not responded to an IPI request.  This happens in two
phases, when initially extracting state from the tasks and later when
waiting for any holdout tasks to check in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 70 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index fd34fd6..4237881 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -798,9 +798,41 @@ static void rcu_tasks_trace_postscan(void)
 	// Any tasks that exit after this point will set ->trc_reader_checked.
 }
 
+/* Show the state of a task stalling the current RCU tasks trace GP. */
+static void show_stalled_task_trace(struct task_struct *t, bool *firstreport)
+{
+	int cpu;
+
+	if (*firstreport) {
+		pr_err("INFO: rcu_tasks_trace detected stalls on tasks:\n");
+		*firstreport = false;
+	}
+	// FIXME: This should attempt to use try_invoke_on_nonrunning_task().
+	cpu = task_cpu(t);
+	pr_alert("P%d: %c%c%c nesting: %d%c cpu: %d\n",
+		 t->pid,
+		 ".I"[READ_ONCE(t->trc_ipi_to_cpu) > 0],
+		 ".i"[is_idle_task(t)],
+		 ".N"[cpu > 0 && tick_nohz_full_cpu(cpu)],
+		 t->trc_reader_nesting,
+		 " N"[!!t->trc_reader_need_end],
+		 cpu);
+	sched_show_task(t);
+}
+
+/* List stalled IPIs for RCU tasks trace. */
+static void show_stalled_ipi_trace(void)
+{
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		if (per_cpu(trc_ipi_to_cpu, cpu))
+			pr_alert("\tIPI outstanding to CPU %d\n", cpu);
+}
+
 /* Do one scan of the holdout list. */
 static void check_all_holdout_tasks_trace(struct list_head *hop,
-					  bool ndrpt, bool *frptp)
+					  bool needreport, bool *firstreport)
 {
 	struct task_struct *g, *t;
 
@@ -813,21 +845,51 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 		// If check succeeded, remove this task from the list.
 		if (READ_ONCE(t->trc_reader_checked))
 			trc_del_holdout(t);
+		else if (needreport)
+			show_stalled_task_trace(t, firstreport);
+	}
+	if (needreport) {
+		if (firstreport)
+			pr_err("INFO: rcu_tasks_trace detected stalls? (Late IPI?)\n");
+		show_stalled_ipi_trace();
 	}
 }
 
 /* Wait for grace period to complete and provide ordering. */
 static void rcu_tasks_trace_postgp(void)
 {
+	bool firstreport;
+	struct task_struct *g, *t;
+	LIST_HEAD(holdouts);
+	long ret;
+
 	// Remove the safety count.
 	smp_mb__before_atomic();  // Order vs. earlier atomics
 	atomic_dec(&trc_n_readers_need_end);
 	smp_mb__after_atomic();  // Order vs. later atomics
 
 	// Wait for readers.
-	wait_event_idle_exclusive(trc_wait,
-				  atomic_read(&trc_n_readers_need_end) == 0);
-
+	for (;;) {
+		ret = wait_event_idle_exclusive_timeout(
+				trc_wait,
+				atomic_read(&trc_n_readers_need_end) == 0,
+				READ_ONCE(rcu_task_stall_timeout));
+		if (ret)
+			break;  // Count reached zero.
+		for_each_process_thread(g, t)
+			if (READ_ONCE(t->trc_reader_need_end))
+				trc_add_holdout(t, &holdouts);
+		firstreport = true;
+		list_for_each_entry_safe(t, g, &holdouts, trc_holdout_list)
+			if (READ_ONCE(t->trc_reader_need_end)) {
+				show_stalled_task_trace(t, &firstreport);
+				trc_del_holdout(t);
+			}
+		if (firstreport)
+			pr_err("INFO: rcu_tasks_trace detected stalls? (Counter/taskslist mismatch?)\n");
+		show_stalled_ipi_trace();
+		pr_err("\t%d holdouts\n", atomic_read(&trc_n_readers_need_end));
+	}
 	smp_mb(); // Caller's code must be ordered after wakeup.
 }
 
