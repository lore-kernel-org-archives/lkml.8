Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F3F8C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF39B22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gygChIbH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pUeKe373"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732841AbgGaJ1M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:27:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732394AbgGaJXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:14 -0400
Date:   Fri, 31 Jul 2020 09:23:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zFFe3TMk0PG80zCUZwJ3NXIWTD2Jc/ucyfLWg3AbBT0=;
        b=gygChIbHNlLc58sB4eGpvh6eGkxH8po95thRJltc6/UYunFovCbLayBsStNDhyL6agcFfR
        I9lw8WDWY7djaCsANL18rNIpCPAdHBkxGccDXhPFzpmMhTCyFB3/JEUB5sOmIkrl9lnUb5
        6QBdOm7k9K1+G5Msq/eIjh8/GE/FmlSXfe/Fhu1YEMcBSHk2UvSv3nVxQ0yNOeARIa4g49
        yhZz7Dr4NqjbfIOZujJeFLq9MuTMfsyijMv3S0Sg7MKe30ZTcaG9Fo3/dZdt2ZKjyn7k5N
        vXH1gzwSnis5CO0W6+K29XQVd7/fT2Jpt5Hp5YD5B/E+Dp8KoPu9yb3pm6m9Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187392;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zFFe3TMk0PG80zCUZwJ3NXIWTD2Jc/ucyfLWg3AbBT0=;
        b=pUeKe373cdRtCeKKz98Hf1VyJlTxLaekm3NYpX2ale6nUPdUz1bunLrY2u59RrC7VKXM3h
        YN8l3pdDetu4U2AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()
Cc:     kbuild test robot <lkp@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618739189.4006.420783684057137039.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     8344496e8b49c4122c1808d6cd3f8dc71bccb595
Gitweb:        https://git.kernel.org/tip/8344496e8b49c4122c1808d6cd3f8dc71bccb595
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 May 2020 20:03:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:22 -07:00

rcu-tasks: Conditionally compile show_rcu_tasks_gp_kthreads()

The show_rcu_tasks_gp_kthreads() function is not invoked by Tiny RCU,
but is nevertheless defined in Tiny RCU builds that enable Tasks Trace
RCU.  This commit therefore conditionally compiles this function so
that it is defined only in builds that actually use it.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index da200e5..d5c003c 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -103,6 +103,7 @@ module_param(rcu_task_stall_timeout, int, 0644);
 #define RTGS_WAIT_READERS	 9
 #define RTGS_INVOKE_CBS		10
 #define RTGS_WAIT_CBS		11
+#ifndef CONFIG_TINY_RCU
 static const char * const rcu_tasks_gp_state_names[] = {
 	"RTGS_INIT",
 	"RTGS_WAIT_WAIT_CBS",
@@ -117,6 +118,7 @@ static const char * const rcu_tasks_gp_state_names[] = {
 	"RTGS_INVOKE_CBS",
 	"RTGS_WAIT_CBS",
 };
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -129,6 +131,7 @@ static void set_tasks_gp_state(struct rcu_tasks *rtp, int newstate)
 	rtp->gp_jiffies = jiffies;
 }
 
+#ifndef CONFIG_TINY_RCU
 /* Return state name. */
 static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
 {
@@ -139,6 +142,7 @@ static const char *tasks_gp_state_getname(struct rcu_tasks *rtp)
 		return "???";
 	return rcu_tasks_gp_state_names[j];
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 // Enqueue a callback for the specified flavor of Tasks RCU.
 static void call_rcu_tasks_generic(struct rcu_head *rhp, rcu_callback_t func,
@@ -268,6 +272,7 @@ static void __init rcu_tasks_bootup_oddness(void)
 
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+#ifndef CONFIG_TINY_RCU
 /* Dump out rcutorture-relevant state common to all RCU-tasks flavors. */
 static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 {
@@ -281,6 +286,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 static void exit_tasks_rcu_finish_trace(struct task_struct *t);
 
@@ -557,10 +563,12 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
+#ifndef CONFIG_TINY_RCU
 static void show_rcu_tasks_classic_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
@@ -682,10 +690,12 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
+#ifndef CONFIG_TINY_RCU
 static void show_rcu_tasks_rude_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 #else /* #ifdef CONFIG_TASKS_RUDE_RCU */
 static void show_rcu_tasks_rude_gp_kthread(void) {}
@@ -1164,6 +1174,7 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
+#ifndef CONFIG_TINY_RCU
 static void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
@@ -1174,18 +1185,21 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
 static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
+#ifndef CONFIG_TINY_RCU
 void show_rcu_tasks_gp_kthreads(void)
 {
 	show_rcu_tasks_classic_gp_kthread();
 	show_rcu_tasks_rude_gp_kthread();
 	show_rcu_tasks_trace_gp_kthread();
 }
+#endif /* #ifndef CONFIG_TINY_RCU */
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
 static inline void rcu_tasks_bootup_oddness(void) {}
