Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF54C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6D720A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgCXJRS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:17:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44106 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgCXJRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgK-0008Fd-BN; Tue, 24 Mar 2020 10:17:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 50BDB1C07A5;
        Tue, 24 Mar 2020 10:16:51 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:50 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add *_ONCE() to rcu_data ->rcu_forced_tick
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504141099.28353.12947003090186967525.tip-bot2@tip-bot2>
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

Commit-ID:     2a2ae872ef7aa958f2152b8b24c6e94cf5f1d0df
Gitweb:        https://git.kernel.org/tip/2a2ae872ef7aa958f2152b8b24c6e94cf5f1d0df
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 08 Jan 2020 20:06:25 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:22 -08:00

rcu: Add *_ONCE() to rcu_data ->rcu_forced_tick

The rcu_data structure's ->rcu_forced_tick field is read locklessly, so
this commit adds WRITE_ONCE() to all updates and READ_ONCE() to all
lockless reads.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e851a12..be59a5d 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -818,11 +818,12 @@ static __always_inline void rcu_nmi_enter_common(bool irq)
 		incby = 1;
 	} else if (tick_nohz_full_cpu(rdp->cpu) &&
 		   rdp->dynticks_nmi_nesting == DYNTICK_IRQ_NONIDLE &&
-		   READ_ONCE(rdp->rcu_urgent_qs) && !rdp->rcu_forced_tick) {
+		   READ_ONCE(rdp->rcu_urgent_qs) &&
+		   !READ_ONCE(rdp->rcu_forced_tick)) {
 		raw_spin_lock_rcu_node(rdp->mynode);
 		// Recheck under lock.
 		if (rdp->rcu_urgent_qs && !rdp->rcu_forced_tick) {
-			rdp->rcu_forced_tick = true;
+			WRITE_ONCE(rdp->rcu_forced_tick, true);
 			tick_dep_set_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
 		}
 		raw_spin_unlock_rcu_node(rdp->mynode);
@@ -899,7 +900,7 @@ static void rcu_disable_urgency_upon_qs(struct rcu_data *rdp)
 	WRITE_ONCE(rdp->rcu_need_heavy_qs, false);
 	if (tick_nohz_full_cpu(rdp->cpu) && rdp->rcu_forced_tick) {
 		tick_dep_clear_cpu(rdp->cpu, TICK_DEP_BIT_RCU);
-		rdp->rcu_forced_tick = false;
+		WRITE_ONCE(rdp->rcu_forced_tick, false);
 	}
 }
 
