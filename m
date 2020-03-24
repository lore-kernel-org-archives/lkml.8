Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C04C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F3D20A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728034AbgCXJSV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44075 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727736AbgCXJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:17:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfgC-00089L-8o; Tue, 24 Mar 2020 10:17:00 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 258D51C04D1;
        Tue, 24 Mar 2020 10:16:46 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:45 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make nocb_gp_wait() double-check
 unexpected-callback warning
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140582.28353.1542065767349968391.tip-bot2@tip-bot2>
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

Commit-ID:     3d05031ae6de6ad084aa41263aed1343065233d5
Gitweb:        https://git.kernel.org/tip/3d05031ae6de6ad084aa41263aed1343065233d5
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 04 Feb 2020 14:55:29 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 15:58:23 -08:00

rcu: Make nocb_gp_wait() double-check unexpected-callback warning

Currently, nocb_gp_wait() unconditionally complains if there is a
callback not already associated with a grace period.  This assumes that
either there was no such callback initially on the one hand, or that
the rcu_advance_cbs() function assigned all such callbacks to a grace
period on the other.  However, in theory there are some situations that
would prevent rcu_advance_cbs() from assigning all of the callbacks.

This commit therefore checks for unassociated callbacks immediately after
rcu_advance_cbs() returns, while the corresponding rcu_node structure's
->lock is still held.  If there are unassociated callbacks at that point,
the subsequent WARN_ON_ONCE() is disabled.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 70b3c0f..36e71c9 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1931,6 +1931,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	struct rcu_data *rdp;
 	struct rcu_node *rnp;
 	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
+	bool wasempty = false;
 
 	/*
 	 * Each pass through the following loop checks for CBs and for the
@@ -1970,10 +1971,13 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		     rcu_seq_done(&rnp->gp_seq, cur_gp_seq))) {
 			raw_spin_lock_rcu_node(rnp); /* irqs disabled. */
 			needwake_gp = rcu_advance_cbs(rnp, rdp);
+			wasempty = rcu_segcblist_restempty(&rdp->cblist,
+							   RCU_NEXT_READY_TAIL);
 			raw_spin_unlock_rcu_node(rnp); /* irqs disabled. */
 		}
 		// Need to wait on some grace period?
-		WARN_ON_ONCE(!rcu_segcblist_restempty(&rdp->cblist,
+		WARN_ON_ONCE(wasempty &&
+			     !rcu_segcblist_restempty(&rdp->cblist,
 						      RCU_NEXT_READY_TAIL));
 		if (rcu_segcblist_nextgp(&rdp->cblist, &cur_gp_seq)) {
 			if (!needwait_gp ||
