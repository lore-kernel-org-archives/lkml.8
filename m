Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E99A9C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD5F622201
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727770AbgCXJRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44025 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbgCXJQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg3-00085F-Iu; Tue, 24 Mar 2020 10:16:51 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A03D1C04D5;
        Tue, 24 Mar 2020 10:16:43 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:42 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Clear ->core_needs_qs at GP end or self-reported QS
Cc:     kernel test robot <rong.a.chen@intel.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140265.28353.2212857641481536328.tip-bot2@tip-bot2>
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

Commit-ID:     b5ea03709d12e98fa341aecfa6940cc9f49e8817
Gitweb:        https://git.kernel.org/tip/b5ea03709d12e98fa341aecfa6940cc9f49e8817
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 09 Dec 2019 15:19:45 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:00:20 -08:00

rcu: Clear ->core_needs_qs at GP end or self-reported QS

The rcu_data structure's ->core_needs_qs field does not necessarily get
cleared in a timely fashion after the corresponding CPUs' quiescent state
has been reported.  From a functional viewpoint, no harm done, but this
can result in excessive invocation of RCU core processing, as witnessed
by the kernel test robot, which saw greatly increased softirq overhead.

This commit therefore restores the rcu_report_qs_rdp() function's
clearing of this field, but only when running on the corresponding CPU.
Cases where some other CPU reports the quiescent state (for example, on
behalf of an idle CPU) are handled by setting this field appropriately
within the __note_gp_changes() function's end-of-grace-period checks.
This handling is carried out regardless of whether the end of a grace
period actually happened, thus handling the case where a CPU goes non-idle
after a quiescent state is reported on its behalf, but before the grace
period ends.  This fix also avoids cross-CPU updates to ->core_needs_qs,

While in the area, this commit changes the __note_gp_changes() need_gp
variable's name to need_qs because it is a quiescent state that is needed
from the CPU in question.

Fixes: ed93dfc6bc00 ("rcu: Confine ->core_needs_qs accesses to the corresponding CPU")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index d91c915..31d01f8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1386,7 +1386,7 @@ static void __maybe_unused rcu_advance_cbs_nowake(struct rcu_node *rnp,
 static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 {
 	bool ret = false;
-	bool need_gp;
+	bool need_qs;
 	const bool offloaded = IS_ENABLED(CONFIG_RCU_NOCB_CPU) &&
 			       rcu_segcblist_is_offloaded(&rdp->cblist);
 
@@ -1400,10 +1400,13 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 	    unlikely(READ_ONCE(rdp->gpwrap))) {
 		if (!offloaded)
 			ret = rcu_advance_cbs(rnp, rdp); /* Advance CBs. */
+		rdp->core_needs_qs = false;
 		trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuend"));
 	} else {
 		if (!offloaded)
 			ret = rcu_accelerate_cbs(rnp, rdp); /* Recent CBs. */
+		if (rdp->core_needs_qs)
+			rdp->core_needs_qs = !!(rnp->qsmask & rdp->grpmask);
 	}
 
 	/* Now handle the beginnings of any new-to-this-CPU grace periods. */
@@ -1415,9 +1418,9 @@ static bool __note_gp_changes(struct rcu_node *rnp, struct rcu_data *rdp)
 		 * go looking for one.
 		 */
 		trace_rcu_grace_period(rcu_state.name, rnp->gp_seq, TPS("cpustart"));
-		need_gp = !!(rnp->qsmask & rdp->grpmask);
-		rdp->cpu_no_qs.b.norm = need_gp;
-		rdp->core_needs_qs = need_gp;
+		need_qs = !!(rnp->qsmask & rdp->grpmask);
+		rdp->cpu_no_qs.b.norm = need_qs;
+		rdp->core_needs_qs = need_qs;
 		zero_cpu_stall_ticks(rdp);
 	}
 	rdp->gp_seq = rnp->gp_seq;  /* Remember new grace-period state. */
@@ -1987,6 +1990,8 @@ rcu_report_qs_rdp(int cpu, struct rcu_data *rdp)
 		return;
 	}
 	mask = rdp->grpmask;
+	if (rdp->cpu == smp_processor_id())
+		rdp->core_needs_qs = false;
 	if ((rnp->qsmask & mask) == 0) {
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	} else {
