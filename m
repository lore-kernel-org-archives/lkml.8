Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28A53C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A452145D
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 09:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgCXJSt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 05:18:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44019 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbgCXJQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 05:16:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jGfg6-00084W-Gl; Tue, 24 Mar 2020 10:16:54 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 23B081C0470;
        Tue, 24 Mar 2020 10:16:42 +0100 (CET)
Date:   Tue, 24 Mar 2020 09:16:41 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: React to callback overload by boosting RCU readers
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158504140178.28353.17369551335801939291.tip-bot2@tip-bot2>
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

Commit-ID:     8c14263d351b4766a040346ee917b8d81583a460
Gitweb:        https://git.kernel.org/tip/8c14263d351b4766a040346ee917b8d81583a460
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 07 Nov 2019 01:10:55 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 20 Feb 2020 16:00:20 -08:00

rcu: React to callback overload by boosting RCU readers

RCU priority boosting currently is not applied until the grace period
is at least 250 milliseconds old (or the number of milliseconds specified
by the CONFIG_RCU_BOOST_DELAY Kconfig option).  Although this has worked
well, it can result in OOM under conditions of RCU callback flooding.
One can argue that the real-time systems using RCU priority boosting
should carefully avoid RCU callback flooding, but one can just as well
argue that an OOM is a rather obnoxious error message.

This commit therefore disables the RCU priority boosting delay when
there are excessive numbers of callbacks queued.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 0be8fad..4d4637c 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1079,7 +1079,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	    (rnp->gp_tasks != NULL &&
 	     rnp->boost_tasks == NULL &&
 	     rnp->qsmask == 0 &&
-	     ULONG_CMP_GE(jiffies, rnp->boost_time))) {
+	     (ULONG_CMP_GE(jiffies, rnp->boost_time) || rcu_state.cbovld))) {
 		if (rnp->exp_tasks == NULL)
 			rnp->boost_tasks = rnp->gp_tasks;
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
