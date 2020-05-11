Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B306EC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8A9208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732207AbgEKVAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732121AbgEKVAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BCBC061A0C;
        Mon, 11 May 2020 14:00:11 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWz-00063U-8M; Mon, 11 May 2020 23:00:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 58B321C0872;
        Mon, 11 May 2020 22:59:45 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:45 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add WRITE_ONCE() to rcu_node ->boost_tasks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078527.390.9732610515449854619.tip-bot2@tip-bot2>
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

Commit-ID:     5822b8126ff01e0baaf7d5168adc4ac8aeae088c
Gitweb:        https://git.kernel.org/tip/5822b8126ff01e0baaf7d5168adc4ac8aeae088c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 04 Jan 2020 10:44:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Add WRITE_ONCE() to rcu_node ->boost_tasks

The rcu_node structure's ->boost_tasks field is read locklessly, so this
commit adds the WRITE_ONCE() to an update in order to provide proper
documentation and READ_ONCE()/WRITE_ONCE() pairing.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ed6bb46..664d0aa 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -505,7 +505,7 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsigned long flags)
 			/* Snapshot ->boost_mtx ownership w/rnp->lock held. */
 			drop_boost_mutex = rt_mutex_owner(&rnp->boost_mtx) == t;
 			if (&t->rcu_node_entry == rnp->boost_tasks)
-				rnp->boost_tasks = np;
+				WRITE_ONCE(rnp->boost_tasks, np);
 		}
 
 		/*
@@ -1082,7 +1082,7 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags)
 	     rnp->qsmask == 0 &&
 	     (ULONG_CMP_GE(jiffies, rnp->boost_time) || rcu_state.cbovld))) {
 		if (rnp->exp_tasks == NULL)
-			rnp->boost_tasks = rnp->gp_tasks;
+			WRITE_ONCE(rnp->boost_tasks, rnp->gp_tasks);
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 		rcu_wake_cond(rnp->boost_kthread_task,
 			      READ_ONCE(rnp->boost_kthread_status));
