Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E8FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4E082078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbgEKVEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731878AbgEKU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A90CC05BD0B;
        Mon, 11 May 2020 13:59:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWM-0005lk-TU; Mon, 11 May 2020 22:59:31 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F0C691C04D6;
        Mon, 11 May 2020 22:59:24 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:24 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Disable CPU hotplug across RCU tasks trace scans
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076484.390.9211273599973610096.tip-bot2@tip-bot2>
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

Commit-ID:     81b4a7bc3b54b0b839dbf3d2b8c9a353ae910688
Gitweb:        https://git.kernel.org/tip/81b4a7bc3b54b0b839dbf3d2b8c9a353ae910688
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Mar 2020 10:10:07 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Disable CPU hotplug across RCU tasks trace scans

This commit disables CPU hotplug across RCU tasks trace scans, which
is a first step towards correctly recognizing idle tasks "running" on
offline CPUs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index dd311e9..361e17d 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -910,16 +910,16 @@ static void rcu_tasks_trace_pregp_step(void)
 {
 	int cpu;
 
-	// Wait for CPU-hotplug paths to complete.
-	cpus_read_lock();
-	cpus_read_unlock();
-
 	// Allow for fast-acting IPIs.
 	atomic_set(&trc_n_readers_need_end, 1);
 
 	// There shouldn't be any old IPIs, but...
 	for_each_possible_cpu(cpu)
 		WARN_ON_ONCE(per_cpu(trc_ipi_to_cpu, cpu));
+
+	// Disable CPU hotplug across the tasklist scan.
+	// This also waits for all readers in CPU-hotplug code paths.
+	cpus_read_lock();
 }
 
 /* Do first-round processing for the specified task. */
@@ -935,6 +935,9 @@ static void rcu_tasks_trace_pertask(struct task_struct *t,
 /* Do intermediate processing between task and holdout scans. */
 static void rcu_tasks_trace_postscan(void)
 {
+	// Re-enable CPU hotplug now that the tasklist scan has completed.
+	cpus_read_unlock();
+
 	// Wait for late-stage exiting tasks to finish exiting.
 	// These might have passed the call to exit_tasks_rcu_finish().
 	synchronize_rcu();
@@ -979,6 +982,9 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 {
 	struct task_struct *g, *t;
 
+	// Disable CPU hotplug across the holdout list scan.
+	cpus_read_lock();
+
 	list_for_each_entry_safe(t, g, hop, trc_holdout_list) {
 		// If safe and needed, try to check the current task.
 		if (READ_ONCE(t->trc_ipi_to_cpu) == -1 &&
@@ -991,6 +997,10 @@ static void check_all_holdout_tasks_trace(struct list_head *hop,
 		else if (needreport)
 			show_stalled_task_trace(t, firstreport);
 	}
+
+	// Re-enable CPU hotplug now that the holdout list scan has completed.
+	cpus_read_unlock();
+
 	if (needreport) {
 		if (firstreport)
 			pr_err("INFO: rcu_tasks_trace detected stalls? (Late IPI?)\n");
