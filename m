Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5CFAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA2E22B40
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q7p7g5v2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E05l0kjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732905AbgGaJ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:28:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56338 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732303AbgGaJXA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:00 -0400
Date:   Fri, 31 Jul 2020 09:22:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KJT+jpRUE81LunoGqu0ctFrORdO4NTwS6wFAarY9je4=;
        b=q7p7g5v2UUGV4Qh6TBL6/Xb+DzCGUD+b4buz+LmaDiXOvQjhEmIhY4lnDyM0oJAh1BB7s7
        ASUFGOZlj+kg76YnGCPqwh11EhmTdepIgpnIfLafA4SQQOq4jEAvKcWYxe/U0NKaYYQwOq
        xxfbZlYh0xTcvi6NNkQoH/myvWYEr2I+InPfuAdhSTPKku8KeJLInu/dRAorMzXZBSd1NI
        kZUTCznPitSVyO6Ve/I+j9jsM/nV7iA53fiIXVsCWHRaJ9VW3fX1F1FCbOk/qaTCY8nd3V
        ZbZ9bql1JCczZfpJXMellC1fDMYSmH40yqjwRubfYCQt3XrZkkHyvO93wYhWYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187378;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=KJT+jpRUE81LunoGqu0ctFrORdO4NTwS6wFAarY9je4=;
        b=E05l0kjcjZFXKHAyKtLbgj78bbvPh0RaucDSdrCwB2Alfr1aXlZ4l9Yth/UA3NtI1WOdvZ
        YX0mGUartRBpSmCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refperf: Add read-side delay module parameter
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618737792.4006.1779482656946456348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b4d1e34f6502a138e32275baabdb6d593d7ea432
Gitweb:        https://git.kernel.org/tip/b4d1e34f6502a138e32275baabdb6d593d7ea432
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 28 May 2020 16:37:35 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 12:00:45 -07:00

refperf: Add read-side delay module parameter

This commit adds a refperf.readdelay module parameter that controls the
duration of each critical section.  This parameter allows gathering data
showing how the performance differences between the various primitives
vary with critical-section length.

Cc: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/refperf.c | 108 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 89 insertions(+), 19 deletions(-)

diff --git a/kernel/rcu/refperf.c b/kernel/rcu/refperf.c
index 7839237..57a750b 100644
--- a/kernel/rcu/refperf.c
+++ b/kernel/rcu/refperf.c
@@ -66,8 +66,8 @@ torture_param(long, loops, 10000000, "Number of loops per experiment.");
 torture_param(int, nreaders, -1, "Number of readers, -1 for 75% of CPUs.");
 // Number of runs.
 torture_param(int, nruns, 30, "Number of experiments to run.");
-// Reader delay in nanoseconds, 0 for no delay.
-torture_param(int, readdelay, 0, "Read-side delay in nanoseconds.");
+// Reader delay in microseconds, 0 for no delay.
+torture_param(int, readdelay, 0, "Read-side delay in microseconds.");
 
 #ifdef MODULE
 # define REFPERF_SHUTDOWN 0
@@ -111,6 +111,7 @@ struct ref_perf_ops {
 	void (*init)(void);
 	void (*cleanup)(void);
 	void (*readsection)(const int nloops);
+	void (*delaysection)(const int nloops, const int ndelay);
 	const char *name;
 };
 
@@ -126,6 +127,17 @@ static void ref_rcu_read_section(const int nloops)
 	}
 }
 
+static void ref_rcu_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		rcu_read_lock();
+		udelay(ndelay);
+		rcu_read_unlock();
+	}
+}
+
 static void rcu_sync_perf_init(void)
 {
 }
@@ -133,6 +145,7 @@ static void rcu_sync_perf_init(void)
 static struct ref_perf_ops rcu_ops = {
 	.init		= rcu_sync_perf_init,
 	.readsection	= ref_rcu_read_section,
+	.delaysection	= ref_rcu_delay_section,
 	.name		= "rcu"
 };
 
@@ -141,7 +154,7 @@ static struct ref_perf_ops rcu_ops = {
 DEFINE_STATIC_SRCU(srcu_refctl_perf);
 static struct srcu_struct *srcu_ctlp = &srcu_refctl_perf;
 
-static void srcu_ref_perf_read_section(int nloops)
+static void srcu_ref_perf_read_section(const int nloops)
 {
 	int i;
 	int idx;
@@ -152,16 +165,29 @@ static void srcu_ref_perf_read_section(int nloops)
 	}
 }
 
+static void srcu_ref_perf_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+	int idx;
+
+	for (i = nloops; i >= 0; i--) {
+		idx = srcu_read_lock(srcu_ctlp);
+		udelay(ndelay);
+		srcu_read_unlock(srcu_ctlp, idx);
+	}
+}
+
 static struct ref_perf_ops srcu_ops = {
 	.init		= rcu_sync_perf_init,
 	.readsection	= srcu_ref_perf_read_section,
+	.delaysection	= srcu_ref_perf_delay_section,
 	.name		= "srcu"
 };
 
 // Definitions for reference count
 static atomic_t refcnt;
 
-static void ref_perf_refcnt_section(const int nloops)
+static void ref_refcnt_section(const int nloops)
 {
 	int i;
 
@@ -171,45 +197,69 @@ static void ref_perf_refcnt_section(const int nloops)
 	}
 }
 
+static void ref_refcnt_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		atomic_inc(&refcnt);
+		udelay(ndelay);
+		atomic_dec(&refcnt);
+	}
+}
+
 static struct ref_perf_ops refcnt_ops = {
 	.init		= rcu_sync_perf_init,
-	.readsection	= ref_perf_refcnt_section,
+	.readsection	= ref_refcnt_section,
+	.delaysection	= ref_refcnt_delay_section,
 	.name		= "refcnt"
 };
 
 // Definitions for rwlock
 static rwlock_t test_rwlock;
 
-static void ref_perf_rwlock_init(void)
+static void ref_rwlock_init(void)
 {
 	rwlock_init(&test_rwlock);
 }
 
-static void ref_perf_rwlock_section(const int nloops)
+static void ref_rwlock_section(const int nloops)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		read_lock(&test_rwlock);
+		read_unlock(&test_rwlock);
+	}
+}
+
+static void ref_rwlock_delay_section(const int nloops, const int ndelay)
 {
 	int i;
 
 	for (i = nloops; i >= 0; i--) {
 		read_lock(&test_rwlock);
+		udelay(ndelay);
 		read_unlock(&test_rwlock);
 	}
 }
 
 static struct ref_perf_ops rwlock_ops = {
-	.init		= ref_perf_rwlock_init,
-	.readsection	= ref_perf_rwlock_section,
+	.init		= ref_rwlock_init,
+	.readsection	= ref_rwlock_section,
+	.delaysection	= ref_rwlock_delay_section,
 	.name		= "rwlock"
 };
 
 // Definitions for rwsem
 static struct rw_semaphore test_rwsem;
 
-static void ref_perf_rwsem_init(void)
+static void ref_rwsem_init(void)
 {
 	init_rwsem(&test_rwsem);
 }
 
-static void ref_perf_rwsem_section(const int nloops)
+static void ref_rwsem_section(const int nloops)
 {
 	int i;
 
@@ -219,12 +269,32 @@ static void ref_perf_rwsem_section(const int nloops)
 	}
 }
 
+static void ref_rwsem_delay_section(const int nloops, const int ndelay)
+{
+	int i;
+
+	for (i = nloops; i >= 0; i--) {
+		down_read(&test_rwsem);
+		udelay(ndelay);
+		up_read(&test_rwsem);
+	}
+}
+
 static struct ref_perf_ops rwsem_ops = {
-	.init		= ref_perf_rwsem_init,
-	.readsection	= ref_perf_rwsem_section,
+	.init		= ref_rwsem_init,
+	.readsection	= ref_rwsem_section,
+	.delaysection	= ref_rwsem_delay_section,
 	.name		= "rwsem"
 };
 
+static void rcu_perf_one_reader(void)
+{
+	if (readdelay <= 0)
+		cur_ops->readsection(loops);
+	else
+		cur_ops->delaysection(loops, readdelay);
+}
+
 // Reader kthread.  Repeatedly does empty RCU read-side
 // critical section, minimizing update-side interference.
 static int
@@ -265,16 +335,16 @@ repeat:
 
 	// To reduce noise, do an initial cache-warming invocation, check
 	// in, and then keep warming until everyone has checked in.
-	cur_ops->readsection(loops);
+	rcu_perf_one_reader();
 	if (!atomic_dec_return(&n_warmedup))
 		while (atomic_read_acquire(&n_warmedup))
-			cur_ops->readsection(loops);
+			rcu_perf_one_reader();
 	// Also keep interrupts disabled.  This also has the effect
 	// of preventing entries into slow path for rcu_read_unlock().
 	local_irq_save(flags);
 	start = ktime_get_mono_fast_ns();
 
-	cur_ops->readsection(loops);
+	rcu_perf_one_reader();
 
 	duration = ktime_get_mono_fast_ns() - start;
 	local_irq_restore(flags);
@@ -284,7 +354,7 @@ repeat:
 	// everyone is done.
 	if (!atomic_dec_return(&n_cooleddown))
 		while (atomic_read_acquire(&n_cooleddown))
-			cur_ops->readsection(loops);
+			rcu_perf_one_reader();
 
 	if (atomic_dec_and_test(&nreaders_exp))
 		wake_up(&main_wq);
@@ -449,8 +519,8 @@ static void
 ref_perf_print_module_parms(struct ref_perf_ops *cur_ops, const char *tag)
 {
 	pr_alert("%s" PERF_FLAG
-		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d\n", perf_type, tag,
-		 verbose, shutdown, holdoff, loops, nreaders, nruns);
+		 "--- %s:  verbose=%d shutdown=%d holdoff=%d loops=%ld nreaders=%d nruns=%d readdelay=%d\n", perf_type, tag,
+		 verbose, shutdown, holdoff, loops, nreaders, nruns, readdelay);
 }
 
 static void
