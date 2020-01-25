Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D02AC35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE58B24125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgAYKnv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:43:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44397 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729882AbgAYKn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:28 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuS-0000IJ-G9; Sat, 25 Jan 2020 11:43:24 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5B9A51C1A96;
        Sat, 25 Jan 2020 11:42:59 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:59 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Use *_ONCE() to protect lockless ->expmask accesses
Cc:     syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com>
References: <CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <157994897918.396.6800818639959231688.tip-bot2@tip-bot2>
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

Commit-ID:     15c7c972cd26d89a26788e609c53b5a465324a6c
Gitweb:        https://git.kernel.org/tip/15c7c972cd26d89a26788e609c53b5a465324a6c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 18:53:18 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:24:56 -08:00

rcu: Use *_ONCE() to protect lockless ->expmask accesses

The rcu_node structure's ->expmask field is accessed locklessly when
starting a new expedited grace period and when reporting an expedited
RCU CPU stall warning.  This commit therefore handles the former by
taking a snapshot of ->expmask while the lock is held and the latter
by applying READ_ONCE() to lockless reads and WRITE_ONCE() to the
corresponding updates.

Link: https://lore.kernel.org/lkml/CANpmjNNmSOagbTpffHr4=Yedckx9Rm2NuGqC9UqE+AOz5f1-ZQ@mail.gmail.com
Reported-by: syzbot+134336b86f728d6e55a0@syzkaller.appspotmail.com
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Acked-by: Marco Elver <elver@google.com>
---
 kernel/rcu/tree_exp.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d632cd0..69c5aa6 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -134,7 +134,7 @@ static void __maybe_unused sync_exp_reset_tree(void)
 	rcu_for_each_node_breadth_first(rnp) {
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
 		WARN_ON_ONCE(rnp->expmask);
-		rnp->expmask = rnp->expmaskinit;
+		WRITE_ONCE(rnp->expmask, rnp->expmaskinit);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 }
@@ -211,7 +211,7 @@ static void __rcu_report_exp_rnp(struct rcu_node *rnp,
 		rnp = rnp->parent;
 		raw_spin_lock_rcu_node(rnp); /* irqs already disabled */
 		WARN_ON_ONCE(!(rnp->expmask & mask));
-		rnp->expmask &= ~mask;
+		WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
 	}
 }
 
@@ -241,7 +241,7 @@ static void rcu_report_exp_cpu_mult(struct rcu_node *rnp,
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		return;
 	}
-	rnp->expmask &= ~mask;
+	WRITE_ONCE(rnp->expmask, rnp->expmask & ~mask);
 	__rcu_report_exp_rnp(rnp, wake, flags); /* Releases rnp->lock. */
 }
 
@@ -372,12 +372,10 @@ static void sync_rcu_exp_select_node_cpus(struct work_struct *wp)
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 
 	/* IPI the remaining CPUs for expedited quiescent state. */
-	for_each_leaf_node_cpu_mask(rnp, cpu, rnp->expmask) {
+	for_each_leaf_node_cpu_mask(rnp, cpu, mask_ofl_ipi) {
 		unsigned long mask = leaf_node_cpu_bit(rnp, cpu);
 		struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
 
-		if (!(mask_ofl_ipi & mask))
-			continue;
 retry_ipi:
 		if (rcu_dynticks_in_eqs_since(rdp, rdp->exp_dynticks_snap)) {
 			mask_ofl_test |= mask;
@@ -491,7 +489,7 @@ static void synchronize_sched_expedited_wait(void)
 				struct rcu_data *rdp;
 
 				mask = leaf_node_cpu_bit(rnp, cpu);
-				if (!(rnp->expmask & mask))
+				if (!(READ_ONCE(rnp->expmask) & mask))
 					continue;
 				ndetected++;
 				rdp = per_cpu_ptr(&rcu_data, cpu);
@@ -503,7 +501,8 @@ static void synchronize_sched_expedited_wait(void)
 		}
 		pr_cont(" } %lu jiffies s: %lu root: %#lx/%c\n",
 			jiffies - jiffies_start, rcu_state.expedited_sequence,
-			rnp_root->expmask, ".T"[!!rnp_root->exp_tasks]);
+			READ_ONCE(rnp_root->expmask),
+			".T"[!!rnp_root->exp_tasks]);
 		if (ndetected) {
 			pr_err("blocking rcu_node structures:");
 			rcu_for_each_node_breadth_first(rnp) {
@@ -513,7 +512,7 @@ static void synchronize_sched_expedited_wait(void)
 					continue;
 				pr_cont(" l=%u:%d-%d:%#lx/%c",
 					rnp->level, rnp->grplo, rnp->grphi,
-					rnp->expmask,
+					READ_ONCE(rnp->expmask),
 					".T"[!!rnp->exp_tasks]);
 			}
 			pr_cont("\n");
@@ -521,7 +520,7 @@ static void synchronize_sched_expedited_wait(void)
 		rcu_for_each_leaf_node(rnp) {
 			for_each_leaf_node_possible_cpu(rnp, cpu) {
 				mask = leaf_node_cpu_bit(rnp, cpu);
-				if (!(rnp->expmask & mask))
+				if (!(READ_ONCE(rnp->expmask) & mask))
 					continue;
 				dump_cpu_task(cpu);
 			}
