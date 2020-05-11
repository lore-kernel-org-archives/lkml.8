Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21F6AC54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4A7D208DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732228AbgEKVA4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:00:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732136AbgEKVAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 17:00:14 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55C3C061A0C;
        Mon, 11 May 2020 14:00:14 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFX0-00063z-8v; Mon, 11 May 2020 23:00:10 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 38ED91C0854;
        Mon, 11 May 2020 22:59:46 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:46 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add READ_ONCE and data_race() to rcu_node ->boost_tasks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923078613.390.2868790204835832199.tip-bot2@tip-bot2>
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

Commit-ID:     065a6db12a80fac4eccc37e6bef14b0f4a610f31
Gitweb:        https://git.kernel.org/tip/065a6db12a80fac4eccc37e6bef14b0f4a610f31
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 03 Jan 2020 15:22:01 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:01:16 -07:00

rcu: Add READ_ONCE and data_race() to rcu_node ->boost_tasks

The rcu_node structure's ->boost_tasks field is read locklessly, so this
commit adds the READ_ONCE() to one load in order to avoid destructive
compiler optimizations.  The other load is from a diagnostic print,
so data_race() suffices.

This data race was reported by KCSAN.  Not appropriate for backporting
due to failure being unlikely.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_plugin.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 35d77db..ed6bb46 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -760,7 +760,7 @@ dump_blkd_tasks(struct rcu_node *rnp, int ncheck)
 		pr_info("%s: %d:%d ->qsmask %#lx ->qsmaskinit %#lx ->qsmaskinitnext %#lx\n",
 			__func__, rnp1->grplo, rnp1->grphi, rnp1->qsmask, rnp1->qsmaskinit, rnp1->qsmaskinitnext);
 	pr_info("%s: ->gp_tasks %p ->boost_tasks %p ->exp_tasks %p\n",
-		__func__, READ_ONCE(rnp->gp_tasks), rnp->boost_tasks,
+		__func__, READ_ONCE(rnp->gp_tasks), data_race(rnp->boost_tasks),
 		READ_ONCE(rnp->exp_tasks));
 	pr_info("%s: ->blkd_tasks", __func__);
 	i = 0;
@@ -1036,7 +1036,8 @@ static int rcu_boost_kthread(void *arg)
 	for (;;) {
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_WAITING);
 		trace_rcu_utilization(TPS("End boost kthread@rcu_wait"));
-		rcu_wait(rnp->boost_tasks || READ_ONCE(rnp->exp_tasks));
+		rcu_wait(READ_ONCE(rnp->boost_tasks) ||
+			 READ_ONCE(rnp->exp_tasks));
 		trace_rcu_utilization(TPS("Start boost kthread@rcu_wait"));
 		WRITE_ONCE(rnp->boost_kthread_status, RCU_KTHREAD_RUNNING);
 		more2boost = rcu_boost(rnp);
