Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71DD0C35243
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5153322522
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgAYKpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:11 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44322 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729697AbgAYKnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIuI-0000C5-4e; Sat, 25 Jan 2020 11:43:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 388B21C1A8D;
        Sat, 25 Jan 2020 11:42:55 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:55 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Use lockdep rather than comment to enforce lock held
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897501.396.3265036813235814262.tip-bot2@tip-bot2>
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

Commit-ID:     03bd2983d7a9f898fd89f8f7215c3e56732d8ecd
Gitweb:        https://git.kernel.org/tip/03bd2983d7a9f898fd89f8f7215c3e56732d8ecd
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 10 Oct 2019 09:05:27 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 12:37:50 -08:00

rcu: Use lockdep rather than comment to enforce lock held

The rcu_preempt_check_blocked_tasks() function has a comment
that states that the rcu_node structure's ->lock must be held,
which might be informative, but which carries little weight if
not read.  This commit therefore removes this comment in favor of
raw_lockdep_assert_held_rcu_node(), which will complain quite
visibly if the required lock is not held.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index fe5f448..ed54d36 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -648,8 +648,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
  * Check that the list of blocked tasks for the newly completed grace
  * period is in fact empty.  It is a serious bug to complete a grace
  * period that still has RCU readers blocked!  This function must be
- * invoked -before- updating this rnp's ->gp_seq, and the rnp's ->lock
- * must be held by the caller.
+ * invoked -before- updating this rnp's ->gp_seq.
  *
  * Also, if there are blocked tasks on the list, they automatically
  * block the newly created grace period, so set up ->gp_tasks accordingly.
@@ -659,6 +658,7 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
 	struct task_struct *t;
 
 	RCU_LOCKDEP_WARN(preemptible(), "rcu_preempt_check_blocked_tasks() invoked with preemption enabled!!!\n");
+	raw_lockdep_assert_held_rcu_node(rnp);
 	if (WARN_ON_ONCE(rcu_preempt_blocked_readers_cgp(rnp)))
 		dump_blkd_tasks(rnp, 10);
 	if (rcu_preempt_has_tasks(rnp) &&
