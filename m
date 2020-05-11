Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F653C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E95A92078A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 21:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732107AbgEKVDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 17:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731996AbgEKU7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 16:59:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90CBC05BD09;
        Mon, 11 May 2020 13:59:49 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jYFWe-0005sY-DU; Mon, 11 May 2020 22:59:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 857CD1C0858;
        Mon, 11 May 2020 22:59:33 +0200 (CEST)
Date:   Mon, 11 May 2020 20:59:33 -0000
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Add a test for synchronize_rcu_mult()
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158923077347.390.1319409332048371894.tip-bot2@tip-bot2>
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

Commit-ID:     9cf8fc6fabd46d7f4729529f88d627ce85c6e970
Gitweb:        https://git.kernel.org/tip/9cf8fc6fabd46d7f4729529f88d627ce85c6e970
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 06 Mar 2020 14:00:46 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 27 Apr 2020 11:03:51 -07:00

rcutorture: Add a test for synchronize_rcu_mult()

This commit adds a crude test for synchronize_rcu_mult().  This is
currently a smoke test rather than a high-quality stress test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index b348cf8..fbb3e62 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -20,7 +20,7 @@
 #include <linux/err.h>
 #include <linux/spinlock.h>
 #include <linux/smp.h>
-#include <linux/rcupdate.h>
+#include <linux/rcupdate_wait.h>
 #include <linux/interrupt.h>
 #include <linux/sched/signal.h>
 #include <uapi/linux/sched/types.h>
@@ -665,6 +665,11 @@ static void rcu_tasks_torture_deferred_free(struct rcu_torture *p)
 	call_rcu_tasks(&p->rtort_rcu, rcu_torture_cb);
 }
 
+static void synchronize_rcu_mult_test(void)
+{
+	synchronize_rcu_mult(call_rcu_tasks, call_rcu);
+}
+
 static struct rcu_torture_ops tasks_ops = {
 	.ttype		= RCU_TASKS_FLAVOR,
 	.init		= rcu_sync_torture_init,
@@ -674,7 +679,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.get_gp_seq	= rcu_no_completed,
 	.deferred_free	= rcu_tasks_torture_deferred_free,
 	.sync		= synchronize_rcu_tasks,
-	.exp_sync	= synchronize_rcu_tasks,
+	.exp_sync	= synchronize_rcu_mult_test,
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
 	.fqs		= NULL,
