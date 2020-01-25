Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB903C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B907524125
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 10:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729410AbgAYKps (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 05:45:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:44251 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729486AbgAYKnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 05:43:06 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ivIu7-00007L-W4; Sat, 25 Jan 2020 11:43:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A5A2A1C1A88;
        Sat, 25 Jan 2020 11:42:51 +0100 (CET)
Date:   Sat, 25 Jan 2020 10:42:51 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Dynamically allocate rcu_fwds structure
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157994897148.396.4031348139577445630.tip-bot2@tip-bot2>
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

Commit-ID:     5155be9994e557618a8312389fb4e52dfbf28a3c
Gitweb:        https://git.kernel.org/tip/5155be9994e557618a8312389fb4e52dfbf28a3c
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 06 Nov 2019 08:35:08 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 09 Dec 2019 13:00:29 -08:00

rcutorture: Dynamically allocate rcu_fwds structure

This commit switches from static structure to dynamic allocation
for rcu_fwds as another step towards providing multiple call_rcu()
forward-progress kthreads.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 394baac..f77f4d8 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1686,7 +1686,7 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
-struct rcu_fwd rcu_fwds;
+struct rcu_fwd *rcu_fwds;
 bool rcu_fwd_emergency_stop;
 
 static void rcu_torture_fwd_cb_hist(struct rcu_fwd *rfp)
@@ -1952,7 +1952,7 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 static int rcutorture_oom_notify(struct notifier_block *self,
 				 unsigned long notused, void *nfreed)
 {
-	struct rcu_fwd *rfp = &rcu_fwds;
+	struct rcu_fwd *rfp = rcu_fwds;
 
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
@@ -2010,7 +2010,7 @@ static int rcu_torture_fwd_prog(void *args)
 /* If forward-progress checking is requested and feasible, spawn the thread. */
 static int __init rcu_torture_fwd_prog_init(void)
 {
-	struct rcu_fwd *rfp = &rcu_fwds;
+	struct rcu_fwd *rfp;
 
 	if (!fwd_progress)
 		return 0; /* Not requested, so don't do it. */
@@ -2026,12 +2026,15 @@ static int __init rcu_torture_fwd_prog_init(void)
 		WARN_ON(1); /* Make sure rcutorture notices conflict. */
 		return 0;
 	}
-	spin_lock_init(&rfp->rcu_fwd_lock);
-	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
 	if (fwd_progress_holdoff <= 0)
 		fwd_progress_holdoff = 1;
 	if (fwd_progress_div <= 0)
 		fwd_progress_div = 4;
+	rfp = kzalloc(sizeof(*rfp), GFP_KERNEL);
+	if (!rfp)
+		return -ENOMEM;
+	spin_lock_init(&rfp->rcu_fwd_lock);
+	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
