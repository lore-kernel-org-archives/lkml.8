Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 468D1C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14C552064A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 18:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586975071;
	bh=oYF6YiF0hoDNaQ72fWyPZKT7WWEUhbNetShskhhAuks=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0smO7KJhcTXCsWCU87mMw+sqVgL7nc+2LBw1RmFAnmK2XMl3hBqTk7tmEguAkc37
	 vQUKBtybQPIYgiOn5ibymL0atNDBU5t0HQ+Go45Wo/VSLez3r1mZF0ebXEiZEXXE3U
	 ah512YHJXVfAyjB7rqa49h8POHNZHKVLBSajZn0U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1416740AbgDOSY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 14:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2441103AbgDOSTq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 14:19:46 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C3BA215A4;
        Wed, 15 Apr 2020 18:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586974786;
        bh=oYF6YiF0hoDNaQ72fWyPZKT7WWEUhbNetShskhhAuks=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D4Tn84QTsk7BZ++HW1gnT9NK2usu76jyQah05rCVgjpu5CxrbCvIYCCpgC15nwLqR
         MYWwyRtRpUesKmy1VbTi51vHzxNplXtJyIjgVHgY7bEJDWUEtxhJWpGDboo7YX14Ae
         pUo8ogewHgrRXWBTylExu5Jr2Ppj782zcDp2nA0s=
From:   paulmck@kernel.org
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, mingo@kernel.org,
        jiangshanlai@gmail.com, dipankar@in.ibm.com,
        akpm@linux-foundation.org, mathieu.desnoyers@efficios.com,
        josh@joshtriplett.org, tglx@linutronix.de, peterz@infradead.org,
        rostedt@goodmis.org, dhowells@redhat.com, edumazet@google.com,
        fweisbec@gmail.com, oleg@redhat.com, joel@joelfernandes.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH v4 tip/core/rcu 08/38] rcutorture: Add a test for synchronize_rcu_mult()
Date:   Wed, 15 Apr 2020 11:19:11 -0700
Message-Id: <20200415181941.11653-8-paulmck@kernel.org>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20200415181856.GA11037@paulmck-ThinkPad-P72>
References: <20200415181856.GA11037@paulmck-ThinkPad-P72>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Paul E. McKenney" <paulmck@kernel.org>

This commit adds a crude test for synchronize_rcu_mult().  This is
currently a smoke test rather than a high-quality stress test.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 9 +++++++--
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
-- 
2.9.5

