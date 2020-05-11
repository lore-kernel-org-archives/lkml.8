Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98E2EC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829582078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbgEKVEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731875AbgEKU7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:31 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7877C05BD09;
        Mon, 11 May 2020 13:59:31 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWH-0005ji-4H; Mon, 11 May 2020 22:59:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BB80E1C07B4;
        Mon, 11 May 2020 22:59:21 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:21 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] ftrace: Use synchronize_rcu_tasks_rude() instead of
 ftrace_sync()
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076164.390.8535049254984522740.tip-bot2@tip-bot2>
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

Commit-ID:     e5a971d76d701dbff9e5dbaa84dc9e8c3081a867
Gitweb:        https://git.kernel.org/tip/e5a971d76d701dbff9e5dbaa84dc9e8c3081a867
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Apr 2020 12:10:28 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:53 -07:00

ftrace: Use synchronize_rcu_tasks_rude() instead of ftrace_sync()

This commit replaces the schedule_on_each_cpu(ftrace_sync) instances
with synchronize_rcu_tasks_rude().

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
[ paulmck: Make Kconfig adjustments noted by kbuild test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/trace/Kconfig  |  1 +
 kernel/trace/ftrace.c | 17 +++--------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 402eef8..ae69010 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -158,6 +158,7 @@ config FUNCTION_TRACER
 	select CONTEXT_SWITCH_TRACER
 	select GLOB
 	select TASKS_RCU if PREEMPTION
+	select TASKS_RUDE_RCU
 	help
 	  Enable the kernel to trace every kernel function. This is done
 	  by using a compiler feature to insert a small, 5-byte No-Operation
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 041694a..771eace 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -160,17 +160,6 @@ static void ftrace_pid_func(unsigned long ip, unsigned long parent_ip,
 	op->saved_func(ip, parent_ip, op, regs);
 }
 
-static void ftrace_sync(struct work_struct *work)
-{
-	/*
-	 * This function is just a stub to implement a hard force
-	 * of synchronize_rcu(). This requires synchronizing
-	 * tasks even in userspace and idle.
-	 *
-	 * Yes, function tracing is rude.
-	 */
-}
-
 static void ftrace_sync_ipi(void *data)
 {
 	/* Probably not needed, but do it anyway */
@@ -256,7 +245,7 @@ static void update_ftrace_function(void)
 	 * Make sure all CPUs see this. Yes this is slow, but static
 	 * tracing is slow and nasty to have enabled.
 	 */
-	schedule_on_each_cpu(ftrace_sync);
+	synchronize_rcu_tasks_rude();
 	/* Now all cpus are using the list ops. */
 	function_trace_op = set_function_trace_op;
 	/* Make sure the function_trace_op is visible on all CPUs */
@@ -2932,7 +2921,7 @@ int ftrace_shutdown(struct ftrace_ops *ops, int command)
 		 * infrastructure to do the synchronization, thus we must do it
 		 * ourselves.
 		 */
-		schedule_on_each_cpu(ftrace_sync);
+		synchronize_rcu_tasks_rude();
 
 		/*
 		 * When the kernel is preeptive, tasks can be preempted
@@ -5887,7 +5876,7 @@ ftrace_graph_release(struct inode *inode, struct file *file)
 		 * infrastructure to do the synchronization, thus we must do it
 		 * ourselves.
 		 */
-		schedule_on_each_cpu(ftrace_sync);
+		synchronize_rcu_tasks_rude();
 
 		free_ftrace_hash(old_hash);
 	}
