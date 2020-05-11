Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC459C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D019E2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732253AbgEKVBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732097AbgEKVAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:06 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98A79C05BD09;
        Mon, 11 May 2020 14:00:06 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWr-00061T-LQ; Mon, 11 May 2020 23:00:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DFD3C1C086F;
        Mon, 11 May 2020 22:59:43 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:43 -0000
From:   "tip-bot2 for Zhaolong Zhang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Fix the (t=0 jiffies) false positive
Cc:     Zhaolong Zhang <zhangzl2013@126.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078382.390.9243348981726326890.tip-bot2@tip-bot2>
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

Commit-ID:     fcbcc0e700500fcecf24b9b705825135de30415e
Gitweb:        https://git.kernel.org/tip/fcbcc0e700500fcecf24b9b705825135de30415e
Author:        Zhaolong Zhang <zhangzl2013@126.com>
AuthorDate:    Thu, 05 Mar 2020 14:56:11 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Fix the (t=0 jiffies) false positive

It is possible that an over-long grace period will end while the RCU
CPU stall warning message is printing.  In this case, the estimate of
the offending grace period's duration can be erroneous due to refetching
of rcu_state.gp_start, which will now be the time of the newly started
grace period.  Computation of this duration clearly needs to use the
start time for the old over-long grace period, not the fresh new one.
This commit avoids such errors by causing both print_other_cpu_stall() and
print_cpu_stall() to reuse the value previously fetched by their caller.

Signed-off-by: Zhaolong Zhang <zhangzl2013@126.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index e7da111..3a7bc99 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -371,7 +371,7 @@ static void rcu_check_gp_kthread_starvation(void)
 	}
 }
 
-static void print_other_cpu_stall(unsigned long gp_seq)
+static void print_other_cpu_stall(unsigned long gp_seq, unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -408,7 +408,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(detected by %d, t=%ld jiffies, g=%ld, q=%lu)\n",
-	       smp_processor_id(), (long)(jiffies - rcu_state.gp_start),
+	       smp_processor_id(), (long)(jiffies - gps),
 	       (long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 	if (ndetected) {
 		rcu_dump_cpu_stacks();
@@ -442,7 +442,7 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 	rcu_force_quiescent_state();  /* Kick them all. */
 }
 
-static void print_cpu_stall(void)
+static void print_cpu_stall(unsigned long gps)
 {
 	int cpu;
 	unsigned long flags;
@@ -467,7 +467,7 @@ static void print_cpu_stall(void)
 	for_each_possible_cpu(cpu)
 		totqlen += rcu_get_n_cbs_cpu(cpu);
 	pr_cont("\t(t=%lu jiffies g=%ld q=%lu)\n",
-		jiffies - rcu_state.gp_start,
+		jiffies - gps,
 		(long)rcu_seq_current(&rcu_state.gp_seq), totqlen);
 
 	rcu_check_gp_kthread_starvation();
@@ -546,7 +546,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 	    cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* We haven't checked in, so go dump stack. */
-		print_cpu_stall();
+		print_cpu_stall(gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 
@@ -555,7 +555,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
 		   cmpxchg(&rcu_state.jiffies_stall, js, jn) == js) {
 
 		/* They had a few time units to dump stack, so complain. */
-		print_other_cpu_stall(gs2);
+		print_other_cpu_stall(gs2, gps);
 		if (rcu_cpu_stall_ftrace_dump)
 			rcu_ftrace_dump(DUMP_ALL);
 	}
