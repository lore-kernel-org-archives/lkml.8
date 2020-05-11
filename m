Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997DDC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEA22078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732293AbgEKVB3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732087AbgEKVAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:05 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B11C061A0C;
        Mon, 11 May 2020 14:00:05 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWt-00062y-Hz; Mon, 11 May 2020 23:00:03 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id F10921C0871;
        Mon, 11 May 2020 22:59:44 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:44 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Use data_race() for RCU CPU stall-warning prints
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078488.390.438300413199414740.tip-bot2@tip-bot2>
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

Commit-ID:     47fbb074536ecca5e0af3dcce340954c09ed4d1e
Gitweb:        https://git.kernel.org/tip/47fbb074536ecca5e0af3dcce340954c09ed4d1e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 09 Feb 2020 02:29:36 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Use data_race() for RCU CPU stall-warning prints

Although the accesses used to determine whether or not a stall should
be printed are an integral part of the concurrency algorithm governing
use of the corresponding variables, the values that are simply printed
are ancillary.  As such, it is best to use data_race() for these accesses
in order to provide the greatest latitude in the use of KCSAN for the
other accesses that are an integral part of the algorithm.  This commit
therefore changes the relevant uses of READ_ONCE() to data_race().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 119ed6a..e7da111 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -360,7 +360,7 @@ static void rcu_check_gp_kthread_starvation(void)
 		pr_err("%s kthread starved for %ld jiffies! g%ld f%#x %s(%d) ->state=%#lx ->cpu=%d\n",
 		       rcu_state.name, j,
 		       (long)rcu_seq_current(&rcu_state.gp_seq),
-		       READ_ONCE(rcu_state.gp_flags),
+		       data_race(rcu_state.gp_flags),
 		       gp_state_getname(rcu_state.gp_state), rcu_state.gp_state,
 		       gpk ? gpk->state : ~0, gpk ? task_cpu(gpk) : -1);
 		if (gpk) {
@@ -421,10 +421,10 @@ static void print_other_cpu_stall(unsigned long gp_seq)
 			pr_err("INFO: Stall ended before state dump start\n");
 		} else {
 			j = jiffies;
-			gpa = READ_ONCE(rcu_state.gp_activity);
+			gpa = data_race(rcu_state.gp_activity);
 			pr_err("All QSes seen, last %s kthread activity %ld (%ld-%ld), jiffies_till_next_fqs=%ld, root ->qsmask %#lx\n",
 			       rcu_state.name, j - gpa, j, gpa,
-			       READ_ONCE(jiffies_till_next_fqs),
+			       data_race(jiffies_till_next_fqs),
 			       rcu_get_root()->qsmask);
 			/* In this case, the current CPU might be at fault. */
 			sched_show_task(current);
@@ -581,23 +581,23 @@ void show_rcu_gp_kthreads(void)
 	struct task_struct *t = READ_ONCE(rcu_state.gp_kthread);
 
 	j = jiffies;
-	ja = j - READ_ONCE(rcu_state.gp_activity);
-	jr = j - READ_ONCE(rcu_state.gp_req_activity);
-	jw = j - READ_ONCE(rcu_state.gp_wake_time);
+	ja = j - data_race(rcu_state.gp_activity);
+	jr = j - data_race(rcu_state.gp_req_activity);
+	jw = j - data_race(rcu_state.gp_wake_time);
 	pr_info("%s: wait state: %s(%d) ->state: %#lx delta ->gp_activity %lu ->gp_req_activity %lu ->gp_wake_time %lu ->gp_wake_seq %ld ->gp_seq %ld ->gp_seq_needed %ld ->gp_flags %#x\n",
 		rcu_state.name, gp_state_getname(rcu_state.gp_state),
 		rcu_state.gp_state, t ? t->state : 0x1ffffL,
-		ja, jr, jw, (long)READ_ONCE(rcu_state.gp_wake_seq),
-		(long)READ_ONCE(rcu_state.gp_seq),
-		(long)READ_ONCE(rcu_get_root()->gp_seq_needed),
-		READ_ONCE(rcu_state.gp_flags));
+		ja, jr, jw, (long)data_race(rcu_state.gp_wake_seq),
+		(long)data_race(rcu_state.gp_seq),
+		(long)data_race(rcu_get_root()->gp_seq_needed),
+		data_race(rcu_state.gp_flags));
 	rcu_for_each_node_breadth_first(rnp) {
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
 				 READ_ONCE(rnp->gp_seq_needed)))
 			continue;
 		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
-			rnp->grplo, rnp->grphi, (long)READ_ONCE(rnp->gp_seq),
-			(long)READ_ONCE(rnp->gp_seq_needed));
+			rnp->grplo, rnp->grphi, (long)data_race(rnp->gp_seq),
+			(long)data_race(rnp->gp_seq_needed));
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
@@ -607,7 +607,7 @@ void show_rcu_gp_kthreads(void)
 					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
 			pr_info("\tcpu %d ->gp_seq_needed %ld\n",
-				cpu, (long)READ_ONCE(rdp->gp_seq_needed));
+				cpu, (long)data_race(rdp->gp_seq_needed));
 		}
 	}
 	for_each_possible_cpu(cpu) {
