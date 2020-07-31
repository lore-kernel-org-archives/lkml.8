Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0889C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8655122B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3TX2hWTa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVY4DJxy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732536AbgGaJXl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:23:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732360AbgGaJXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:09 -0400
Date:   Fri, 31 Jul 2020 09:23:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XHShiH3HGiwOKZPIK0HOruHbQ85i7mLLpjLSFC31wPk=;
        b=3TX2hWTa1T0zGDV4thhRFlgP2imqJACegFMztwQH4w2nWxOBYL1IRnqtnIN9K1pQIt49h8
        0ZFHbVfj9siuWxONFaYFHCyp3iuHcjgwHu8lR0mIs4uoC14oni5jWo3JyV8yo6RcPPrk4X
        ozSqmWt4Blj1IneSMVOXutdSz8FT34x9uGXSxgcOcOs6bzmMQ6esq0Xev1yUUntOAlTcg5
        28w9AfKV9tX0RcUoHyoWBt1aePXBiXO7m/owTGO1nkMV3RyXNQviwZMMRmbBEGdmNgQ4Te
        JdZcRlls7RHUaZZqRPDXO6Iq8zFN5iqRMKGPLj+DC1ByWXLWRT7iI4W7q2qNVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XHShiH3HGiwOKZPIK0HOruHbQ85i7mLLpjLSFC31wPk=;
        b=oVY4DJxy0nsDrmu4GeMVsBjTSd6hV7gr+5iV5IjqNkS9mHv/f3DN+Pc0W4OWa83HqU0gz8
        F6D5oO3hnSRKGWAA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Hoist function-pointer calls out of the loop
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618738713.4006.8044423386724260636.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     75dd8efef56ed5959c398974c785026f84aa0d1a
Gitweb:        https://git.kernel.org/tip/75dd8efef56ed5959c398974c785026f84aa0d1a
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 25 May 2020 14:59:06 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:44 -07:00

refperf: Hoist function-pointer calls out of the loop

Current runs show PREEMPT=n rcu_read_lock()/rcu_read_unlock() pairs
consuming between 20 and 30 nanoseconds, when in fact the actual value is
zero, give or take the barrier() asm's effect on compiler optimizations.
The additional overhead is caused by function calls through pointers
(especially in these days of Spectre mitigations) and perhaps also
needless argument passing, a non-const loop limit, and an upcounting loop.

This commit therefore combines the ->readlock() and ->readunlock()
function pointers into a single ->readsection() function pointer that
takes the loop count as a const parameter and keeps any data passed
from the read-lock to the read-unlock internal to this new function.

These changes reduce the measured overhead of the aforementioned
PREEMPT=n rcu_read_lock()/rcu_read_unlock() pairs from between 20 and
30 nanoseconds to somewhere south of 500 picoseconds.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 92 +++++++++++++++++--------------------------
 1 file changed, 38 insertions(+), 54 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 4d686fd..57c7b7a 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -108,23 +108,20 @@ static int exp_idx;
 struct ref_perf_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
-	int (*readlock)(void);
-	void (*readunlock)(int idx);
+	void (*readsection)(const int nloops);
 	const char *name;
 };
 
 static struct ref_perf_ops *cur_ops;
 
-// Definitions for RCU ref perf testing.
-static int ref_rcu_read_lock(void) __acquires(RCU)
+static void ref_rcu_read_section(const int nloops)
 {
-	rcu_read_lock();
-	return 0;
-}
+	int i;
 
-static void ref_rcu_read_unlock(int idx) __releases(RCU)
-{
-	rcu_read_unlock();
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock();
+		rcu_read_unlock();
+	}
 }
 
 static void rcu_sync_perf_init(void)
@@ -133,8 +130,7 @@ static void rcu_sync_perf_init(void)
 
 static struct ref_perf_ops rcu_ops = {
 	.init		= rcu_sync_perf_init,
-	.readlock	= ref_rcu_read_lock,
-	.readunlock	= ref_rcu_read_unlock,
+	.readsection	= ref_rcu_read_section,
 	.name		= "rcu"
 };
 
@@ -143,42 +139,39 @@ static struct ref_perf_ops rcu_ops = {
 DEFINE_STATIC_SRCU(srcu_refctl_perf);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
 
-static int srcu_ref_perf_read_lock(void) __acquires(srcu_ctlp)
+static void srcu_ref_perf_read_section(int nloops)
 {
-	return srcu_read_lock(srcu_ctlp);
-}
+	int i;
+	int idx;
 
-static void srcu_ref_perf_read_unlock(int idx) __releases(srcu_ctlp)
-{
-	srcu_read_unlock(srcu_ctlp, idx);
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock(srcu_ctlp);
+		srcu_read_unlock(srcu_ctlp, idx);
+	}
 }
 
 static struct ref_perf_ops srcu_ops = {
 	.init		= rcu_sync_perf_init,
-	.readlock	= srcu_ref_perf_read_lock,
-	.readunlock	= srcu_ref_perf_read_unlock,
+	.readsection	= srcu_ref_perf_read_section,
 	.name		= "srcu"
 };
 
 // Definitions for reference count
 static atomic_t refcnt;
 
-static int srcu_ref_perf_refcnt_lock(void)
+static void ref_perf_refcnt_section(const int nloops)
 {
-	atomic_inc(&refcnt);
-	return 0;
-}
+	int i;
 
-static void srcu_ref_perf_refcnt_unlock(int idx) __releases(srcu_ctlp)
-{
-	atomic_dec(&refcnt);
-	srcu_read_unlock(srcu_ctlp, idx);
+	for (i = nloops; i >= 0; i--) {
+		atomic_inc(&refcnt);
+		atomic_dec(&refcnt);
+	}
 }
 
 static struct ref_perf_ops refcnt_ops = {
 	.init		= rcu_sync_perf_init,
-	.readlock	= srcu_ref_perf_refcnt_lock,
-	.readunlock	= srcu_ref_perf_refcnt_unlock,
+	.readsection	= ref_perf_refcnt_section,
 	.name		= "refcnt"
 };
 
@@ -190,21 +183,19 @@ static void ref_perf_rwlock_init(void)
 	rwlock_init(&test_rwlock);
 }
 
-static int ref_perf_rwlock_lock(void)
+static void ref_perf_rwlock_section(const int nloops)
 {
-	read_lock(&test_rwlock);
-	return 0;
-}
+	int i;
 
-static void ref_perf_rwlock_unlock(int idx)
-{
-	read_unlock(&test_rwlock);
+	for (i = nloops; i >= 0; i--) {
+		read_lock(&test_rwlock);
+		read_unlock(&test_rwlock);
+	}
 }
 
 static struct ref_perf_ops rwlock_ops = {
 	.init		= ref_perf_rwlock_init,
-	.readlock	= ref_perf_rwlock_lock,
-	.readunlock	= ref_perf_rwlock_unlock,
+	.readsection	= ref_perf_rwlock_section,
 	.name		= "rwlock"
 };
 
@@ -216,21 +207,19 @@ static void ref_perf_rwsem_init(void)
 	init_rwsem(&test_rwsem);
 }
 
-static int ref_perf_rwsem_lock(void)
+static void ref_perf_rwsem_section(const int nloops)
 {
-	down_read(&test_rwsem);
-	return 0;
-}
+	int i;
 
-static void ref_perf_rwsem_unlock(int idx)
-{
-	up_read(&test_rwsem);
+	for (i = nloops; i >= 0; i--) {
+		down_read(&test_rwsem);
+		up_read(&test_rwsem);
+	}
 }
 
 static struct ref_perf_ops rwsem_ops = {
 	.init		= ref_perf_rwsem_init,
-	.readlock	= ref_perf_rwsem_lock,
-	.readunlock	= ref_perf_rwsem_unlock,
+	.readsection	= ref_perf_rwsem_section,
 	.name		= "rwsem"
 };
 
@@ -242,8 +231,6 @@ ref_perf_reader(void *arg)
 	unsigned long flags;
 	long me = (long)arg;
 	struct reader_task *rt = &(reader_tasks[me]);
-	unsigned long spincnt;
-	int idx;
 	u64 start;
 	s64 duration;
 
@@ -275,10 +262,7 @@ repeat:
 
 	VERBOSE_PERFOUT("ref_perf_reader %ld: experiment %d started", me, exp_idx);
 
-	for (spincnt = 0; spincnt < loops; spincnt++) {
-		idx = cur_ops->readlock();
-		cur_ops->readunlock(idx);
-	}
+	cur_ops->readsection(loops);
 
 	duration = ktime_get_mono_fast_ns() - start;
 	local_irq_restore(flags);
