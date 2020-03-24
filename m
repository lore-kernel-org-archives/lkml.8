Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B173BC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F15120A8B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgCXJSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44009 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727504AbgCXJQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg4-000849-Er; Tue, 24 Mar 2020 10:16:52 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4452B1C0475;
        Tue, 24 Mar 2020 10:16:41 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:40 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Update __call_rcu() comments
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140084.28353.10213566122749616532.tip-bot2@tip-bot2>
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

Commit-ID:     b692dc4adfcff5430467bec8efed3c07d1772eaf
Gitweb:        https://git.kernel.org/tip/b692dc4adfcff5430467bec8efed3c07d1772eaf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 11 Feb 2020 07:29:02 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:00:20 -08:00

rcu: Update __call_rcu() comments

The __call_rcu() function's header comment refers to a cpu argument
that no longer exists, and the comment of the return path from
rcu_nocb_try_bypass() ignores the non-no-CBs CPU case.  This commit
therefore update both comments.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c |  9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 48fba22..0a9de9f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2642,12 +2642,7 @@ static void check_cb_ovld(struct rcu_data *rdp)
 	raw_spin_unlock_rcu_node(rnp);
 }
 
-/*
- * Helper function for call_rcu() and friends.  The cpu argument will
- * normally be -1, indicating "currently running CPU".  It may specify
- * a CPU only if that CPU is a no-CBs CPU.  Currently, only rcu_barrier()
- * is expected to specify a CPU.
- */
+/* Helper function for call_rcu() and friends.  */
 static void
 __call_rcu(struct rcu_head *head, rcu_callback_t func)
 {
@@ -2688,7 +2683,7 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
 	check_cb_ovld(rdp);
 	if (rcu_nocb_try_bypass(rdp, head, &was_alldone, flags))
 		return; // Enqueued onto ->nocb_bypass, so just leave.
-	/* If we get here, rcu_nocb_try_bypass() acquired ->nocb_lock. */
+	// If no-CBs CPU gets here, rcu_nocb_try_bypass() acquired ->nocb_lock.
 	rcu_segcblist_enqueue(&rdp->cblist, head);
 	if (__is_kfree_rcu_offset((unsigned long)func))
 		trace_rcu_kfree_callback(rcu_state.name, head,
