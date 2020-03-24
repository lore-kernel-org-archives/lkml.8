Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172C1C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF61A20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgCXJRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44100 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727773AbgCXJRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgJ-0008Fz-7n; Tue, 24 Mar 2020 10:17:07 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BB61D1C07EC;
        Tue, 24 Mar 2020 10:16:51 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:51 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE() to rcu_data ->gpwrap
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141140.28353.18318011019911714645.tip-bot2@tip-bot2>
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

Commit-ID:     a5b8950180f8e5acb802d1672e0b4d0ceee6126e
Gitweb:        https://git.kernel.org/tip/a5b8950180f8e5acb802d1672e0b4d0ceee6126e
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 07 Jan 2020 15:48:39 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

rcu: Add READ_ONCE() to rcu_data ->gpwrap

The rcu_data structure's ->gpwrap field is read locklessly, and so
this commit adds the required READ_ONCE() to a pair of laods in order
to avoid destructive compiler optimizations.

This data race was reported by KCSAN.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 2 +-
 kernel/rcu/tree_stall.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index a70f56b..e851a12 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1322,7 +1322,7 @@ static void rcu_accelerate_cbs_unlocked(struct rcu_node *rnp,
 
 	rcu_lockdep_assert_cblist_protected(rdp);
 	c = rcu_seq_snap(&rcu_state.gp_seq);
-	if (!rdp->gpwrap && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
+	if (!READ_ONCE(rdp->gpwrap) && ULONG_CMP_GE(rdp->gp_seq_needed, c)) {
 		/* Old request still live, so mark recent callbacks. */
 		(void)rcu_segcblist_accelerate(&rdp->cblist, c);
 		return;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 43dc688..bca637b 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -602,7 +602,7 @@ void show_rcu_gp_kthreads(void)
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
 			rdp = per_cpu_ptr(&rcu_data, cpu);
-			if (rdp->gpwrap ||
+			if (READ_ONCE(rdp->gpwrap) ||
 			    ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
 					 READ_ONCE(rdp->gp_seq_needed)))
 				continue;
