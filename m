Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9146FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5492078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbgEKU7w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731898AbgEKU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:35 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E42C061A0C;
        Mon, 11 May 2020 13:59:35 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWQ-0005lR-6G; Mon, 11 May 2020 22:59:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 319381C06E5;
        Mon, 11 May 2020 22:59:24 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:24 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Make RCU tasks trace also wait for idle tasks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076411.390.4440439643536264638.tip-bot2@tip-bot2>
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

Commit-ID:     9796e1ae7386ecf66eb234f7db7753845ebb2139
Gitweb:        https://git.kernel.org/tip/9796e1ae7386ecf66eb234f7db7753845ebb2139
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Mar 2020 13:18:54 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Make RCU tasks trace also wait for idle tasks

This commit scans the CPUs, adding each CPU's idle task to the list of
tasks that need quiescent states.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index e3a42d8..f272e8f 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -15,7 +15,7 @@ struct rcu_tasks;
 typedef void (*rcu_tasks_gp_func_t)(struct rcu_tasks *rtp);
 typedef void (*pregp_func_t)(void);
 typedef void (*pertask_func_t)(struct task_struct *t, struct list_head *hop);
-typedef void (*postscan_func_t)(void);
+typedef void (*postscan_func_t)(struct list_head *hop);
 typedef void (*holdouts_func_t)(struct list_head *hop, bool ndrpt, bool *frptp);
 typedef void (*postgp_func_t)(struct rcu_tasks *rtp);
 
@@ -331,7 +331,7 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 	rcu_read_unlock();
 
 	set_tasks_gp_state(rtp, RTGS_POST_SCAN_TASKLIST);
-	rtp->postscan_func();
+	rtp->postscan_func(&holdouts);
 
 	/*
 	 * Each pass through the following loop scans the list of holdout
@@ -415,7 +415,7 @@ static void rcu_tasks_pertask(struct task_struct *t, struct list_head *hop)
 }
 
 /* Processing between scanning taskslist and draining the holdout list. */
-void rcu_tasks_postscan(void)
+void rcu_tasks_postscan(struct list_head *hop)
 {
 	/*
 	 * Wait for tasks that are in the process of exiting.  This
@@ -936,9 +936,17 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 	trc_wait_for_one_reader(t, hop);
 }
 
-/* Do intermediate processing between task and holdout scans. */
-static void rcu_tasks_trace_postscan(void)
+/*
+ * Do intermediate processing between task and holdout scans and
+ * pick up the idle tasks.
+ */
+static void rcu_tasks_trace_postscan(struct list_head *hop)
 {
+	int cpu;
+
+	for_each_possible_cpu(cpu)
+		rcu_tasks_trace_pertask(idle_task(cpu), hop);
+
 	// Re-enable CPU hotplug now that the tasklist scan has completed.
 	cpus_read_unlock();
 
