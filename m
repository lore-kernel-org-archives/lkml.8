Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4517DC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26C86214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgBKMtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:49:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46088 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728617AbgBKMs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:29 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxi-0007kU-Nn; Tue, 11 Feb 2020 13:48:22 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 67AF91C2018;
        Tue, 11 Feb 2020 13:48:22 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:22 -0000
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem: Fold __percpu_up_read()
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200131151540.212415454@infradead.org>
References: <20200131151540.212415454@infradead.org>
MIME-Version: 1.0
Message-ID: <158142530217.411.5840640700611865076.tip-bot2@tip-bot2>
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

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     ac8dec420970f5cbaf2f6eda39153a60ec5b257b
Gitweb:        https://git.kernel.org/tip/ac8dec420970f5cbaf2f6eda39153a60ec5b257b
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Mon, 18 Nov 2019 15:19:35 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:58 +01:00

locking/percpu-rwsem: Fold __percpu_up_read()

Now that __percpu_up_read() is only ever used from percpu_up_read()
merge them, it's a small function.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lkml.kernel.org/r/20200131151540.212415454@infradead.org
---
 include/linux/percpu-rwsem.h  | 19 +++++++++++++++----
 kernel/exit.c                 |  1 +
 kernel/locking/percpu-rwsem.c | 15 ---------------
 3 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index f5ecf6a..5e033fe 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -43,7 +43,6 @@ is_static struct percpu_rw_semaphore name = {				\
 	__DEFINE_PERCPU_RWSEM(name, static)
 
 extern bool __percpu_down_read(struct percpu_rw_semaphore *, bool);
-extern void __percpu_up_read(struct percpu_rw_semaphore *);
 
 static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 {
@@ -103,10 +102,22 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 	/*
 	 * Same as in percpu_down_read().
 	 */
-	if (likely(rcu_sync_is_idle(&sem->rss)))
+	if (likely(rcu_sync_is_idle(&sem->rss))) {
 		__this_cpu_dec(*sem->read_count);
-	else
-		__percpu_up_read(sem); /* Unconditional memory barrier */
+	} else {
+		/*
+		 * slowpath; reader will only ever wake a single blocked
+		 * writer.
+		 */
+		smp_mb(); /* B matches C */
+		/*
+		 * In other words, if they see our decrement (presumably to
+		 * aggregate zero, as that is the only time it matters) they
+		 * will also see our critical section.
+		 */
+		__this_cpu_dec(*sem->read_count);
+		rcuwait_wake_up(&sem->writer);
+	}
 	preempt_enable();
 }
 
diff --git a/kernel/exit.c b/kernel/exit.c
index 2833ffb..f64a8f9 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -258,6 +258,7 @@ void rcuwait_wake_up(struct rcuwait *w)
 		wake_up_process(task);
 	rcu_read_unlock();
 }
+EXPORT_SYMBOL_GPL(rcuwait_wake_up);
 
 /*
  * Determine if a process group is "orphaned", according to the POSIX
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index a136677..8048a9a 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -177,21 +177,6 @@ bool __percpu_down_read(struct percpu_rw_semaphore *sem, bool try)
 }
 EXPORT_SYMBOL_GPL(__percpu_down_read);
 
-void __percpu_up_read(struct percpu_rw_semaphore *sem)
-{
-	smp_mb(); /* B matches C */
-	/*
-	 * In other words, if they see our decrement (presumably to aggregate
-	 * zero, as that is the only time it matters) they will also see our
-	 * critical section.
-	 */
-	__this_cpu_dec(*sem->read_count);
-
-	/* Prod writer to re-evaluate readers_active_check() */
-	rcuwait_wake_up(&sem->writer);
-}
-EXPORT_SYMBOL_GPL(__percpu_up_read);
-
 #define per_cpu_sum(var)						\
 ({									\
 	typeof(var) __sum = 0;						\
