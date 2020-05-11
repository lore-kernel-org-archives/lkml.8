Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40AAC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD73E2078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:04:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgEKU7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 16:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731867AbgEKU7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AFAC061A0E;
        Mon, 11 May 2020 13:59:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWK-0005l8-L6; Mon, 11 May 2020 22:59:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CA0921C001F;
        Mon, 11 May 2020 22:59:23 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:23 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add rcu_dynticks_zero_in_eqs()
 effectiveness statistics
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923076371.390.8559975619271578475.tip-bot2@tip-bot2>
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

Commit-ID:     40471509be3cb8c9c02aec1c316614cb96e6fe85
Gitweb:        https://git.kernel.org/tip/40471509be3cb8c9c02aec1c316614cb96e6fe85
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Mar 2020 13:34:34 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:52 -07:00

rcu-tasks: Add rcu_dynticks_zero_in_eqs() effectiveness statistics

This commit adds counts of the number of calls and number of successful
calls to rcu_dynticks_zero_in_eqs(), which are printed at the end
of rcutorture runs and at stall time.  This allows evaluation of the
effectiveness of rcu_dynticks_zero_in_eqs().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index f272e8f..ce65883 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -725,6 +725,11 @@ DECLARE_WAIT_QUEUE_HEAD(trc_wait);	// List of holdout tasks.
 // Record outstanding IPIs to each CPU.  No point in sending two...
 static DEFINE_PER_CPU(bool, trc_ipi_to_cpu);
 
+// The number of detections of task quiescent state relying on
+// heavyweight readers executing explicit memory barriers.
+unsigned long n_heavy_reader_attempts;
+unsigned long n_heavy_reader_updates;
+
 void call_rcu_tasks_trace(struct rcu_head *rhp, rcu_callback_t func);
 DEFINE_RCU_TASKS(rcu_tasks_trace, rcu_tasks_wait_gp, call_rcu_tasks_trace,
 		 "RCU Tasks Trace");
@@ -830,9 +835,11 @@ static bool trc_inspect_reader(struct task_struct *t, void *arg)
 		// If heavyweight readers are enabled on the remote task,
 		// we can inspect its state despite its currently running.
 		// However, we cannot safely change its state.
+		n_heavy_reader_attempts++;
 		if (!ofl && // Check for "running" idle tasks on offline CPUs.
 		    !rcu_dynticks_zero_in_eqs(cpu, &t->trc_reader_nesting))
 			return false; // No quiescent state, do it the hard way.
+		n_heavy_reader_updates++;
 		in_qs = true;
 	} else {
 		in_qs = likely(!t->trc_reader_nesting);
@@ -1147,9 +1154,11 @@ core_initcall(rcu_spawn_tasks_trace_kthread);
 
 static void show_rcu_tasks_trace_gp_kthread(void)
 {
-	char buf[32];
+	char buf[64];
 
-	sprintf(buf, "N%d", atomic_read(&trc_n_readers_need_end));
+	sprintf(buf, "N%d h:%lu/%lu", atomic_read(&trc_n_readers_need_end),
+		data_race(n_heavy_reader_updates),
+		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
 
