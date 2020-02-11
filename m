Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A60C3B186
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AD44214DB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 12:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgBKMsg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 07:48:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46107 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729003AbgBKMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 07:48:34 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j1Uxk-0007nF-Tp; Tue, 11 Feb 2020 13:48:25 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 775121C2018;
        Tue, 11 Feb 2020 13:48:24 +0100 (CET)
Date:   Tue, 11 Feb 2020 12:48:24 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/percpu-rwsem, lockdep: Make percpu-rwsem
 use its own lockdep_map
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200131151539.927625541@infradead.org>
References: <20200131151539.927625541@infradead.org>
MIME-Version: 1.0
Message-ID: <158142530424.411.10312400616542936335.tip-bot2@tip-bot2>
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

Commit-ID:     1751060e2527462714359573a39dca10451ffbf8
Gitweb:        https://git.kernel.org/tip/1751060e2527462714359573a39dca10451ffbf8
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2019 20:01:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 11 Feb 2020 13:10:53 +01:00

locking/percpu-rwsem, lockdep: Make percpu-rwsem use its own lockdep_map

As preparation for replacing the embedded rwsem, give percpu-rwsem its
own lockdep_map.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Davidlohr Bueso <dbueso@suse.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20200131151539.927625541@infradead.org
---
 include/linux/percpu-rwsem.h  | 29 +++++++++++++++++++----------
 kernel/cpu.c                  |  4 ++--
 kernel/locking/percpu-rwsem.c | 16 ++++++++++++----
 kernel/locking/rwsem.c        |  4 ++--
 kernel/locking/rwsem.h        |  2 ++
 5 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/include/linux/percpu-rwsem.h b/include/linux/percpu-rwsem.h
index ad2ca2a..f2c36fb 100644
--- a/include/linux/percpu-rwsem.h
+++ b/include/linux/percpu-rwsem.h
@@ -15,8 +15,17 @@ struct percpu_rw_semaphore {
 	struct rw_semaphore	rw_sem; /* slowpath */
 	struct rcuwait          writer; /* blocked writer */
 	int			readers_block;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+#endif
 };
 
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)	.dep_map = { .name = #lockname },
+#else
+#define __PERCPU_RWSEM_DEP_MAP_INIT(lockname)
+#endif
+
 #define __DEFINE_PERCPU_RWSEM(name, is_static)				\
 static DEFINE_PER_CPU(unsigned int, __percpu_rwsem_rc_##name);		\
 is_static struct percpu_rw_semaphore name = {				\
@@ -24,7 +33,9 @@ is_static struct percpu_rw_semaphore name = {				\
 	.read_count = &__percpu_rwsem_rc_##name,			\
 	.rw_sem = __RWSEM_INITIALIZER(name.rw_sem),			\
 	.writer = __RCUWAIT_INITIALIZER(name.writer),			\
+	__PERCPU_RWSEM_DEP_MAP_INIT(name)				\
 }
+
 #define DEFINE_PERCPU_RWSEM(name)		\
 	__DEFINE_PERCPU_RWSEM(name, /* not static */)
 #define DEFINE_STATIC_PERCPU_RWSEM(name)	\
@@ -37,7 +48,7 @@ static inline void percpu_down_read(struct percpu_rw_semaphore *sem)
 {
 	might_sleep();
 
-	rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 0, _RET_IP_);
+	rwsem_acquire_read(&sem->dep_map, 0, 0, _RET_IP_);
 
 	preempt_disable();
 	/*
@@ -76,13 +87,15 @@ static inline int percpu_down_read_trylock(struct percpu_rw_semaphore *sem)
 	 */
 
 	if (ret)
-		rwsem_acquire_read(&sem->rw_sem.dep_map, 0, 1, _RET_IP_);
+		rwsem_acquire_read(&sem->dep_map, 0, 1, _RET_IP_);
 
 	return ret;
 }
 
 static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, _RET_IP_);
+
 	preempt_disable();
 	/*
 	 * Same as in percpu_down_read().
@@ -92,8 +105,6 @@ static inline void percpu_up_read(struct percpu_rw_semaphore *sem)
 	else
 		__percpu_up_read(sem); /* Unconditional memory barrier */
 	preempt_enable();
-
-	rwsem_release(&sem->rw_sem.dep_map, _RET_IP_);
 }
 
 extern void percpu_down_write(struct percpu_rw_semaphore *);
@@ -110,15 +121,13 @@ extern void percpu_free_rwsem(struct percpu_rw_semaphore *);
 	__percpu_init_rwsem(sem, #sem, &rwsem_key);		\
 })
 
-#define percpu_rwsem_is_held(sem) lockdep_is_held(&(sem)->rw_sem)
-
-#define percpu_rwsem_assert_held(sem)				\
-	lockdep_assert_held(&(sem)->rw_sem)
+#define percpu_rwsem_is_held(sem)	lockdep_is_held(sem)
+#define percpu_rwsem_assert_held(sem)	lockdep_assert_held(sem)
 
 static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_release(&sem->rw_sem.dep_map, ip);
+	lock_release(&sem->dep_map, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		atomic_long_set(&sem->rw_sem.owner, RWSEM_OWNER_UNKNOWN);
@@ -128,7 +137,7 @@ static inline void percpu_rwsem_release(struct percpu_rw_semaphore *sem,
 static inline void percpu_rwsem_acquire(struct percpu_rw_semaphore *sem,
 					bool read, unsigned long ip)
 {
-	lock_acquire(&sem->rw_sem.dep_map, 0, 1, read, 1, NULL, ip);
+	lock_acquire(&sem->dep_map, 0, 1, read, 1, NULL, ip);
 #ifdef CONFIG_RWSEM_SPIN_ON_OWNER
 	if (!read)
 		atomic_long_set(&sem->rw_sem.owner, (long)current);
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9c706af..221bf6a 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -331,12 +331,12 @@ void lockdep_assert_cpus_held(void)
 
 static void lockdep_acquire_cpus_lock(void)
 {
-	rwsem_acquire(&cpu_hotplug_lock.rw_sem.dep_map, 0, 0, _THIS_IP_);
+	rwsem_acquire(&cpu_hotplug_lock.dep_map, 0, 0, _THIS_IP_);
 }
 
 static void lockdep_release_cpus_lock(void)
 {
-	rwsem_release(&cpu_hotplug_lock.rw_sem.dep_map, _THIS_IP_);
+	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
 }
 
 /*
diff --git a/kernel/locking/percpu-rwsem.c b/kernel/locking/percpu-rwsem.c
index 364d38a..aa2b118 100644
--- a/kernel/locking/percpu-rwsem.c
+++ b/kernel/locking/percpu-rwsem.c
@@ -11,7 +11,7 @@
 #include "rwsem.h"
 
 int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
-			const char *name, struct lock_class_key *rwsem_key)
+			const char *name, struct lock_class_key *key)
 {
 	sem->read_count = alloc_percpu(int);
 	if (unlikely(!sem->read_count))
@@ -19,9 +19,13 @@ int __percpu_init_rwsem(struct percpu_rw_semaphore *sem,
 
 	/* ->rw_sem represents the whole percpu_rw_semaphore for lockdep */
 	rcu_sync_init(&sem->rss);
-	__init_rwsem(&sem->rw_sem, name, rwsem_key);
+	init_rwsem(&sem->rw_sem);
 	rcuwait_init(&sem->writer);
 	sem->readers_block = 0;
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	debug_check_no_locks_freed((void *)sem, sizeof(*sem));
+	lockdep_init_map(&sem->dep_map, name, key, 0);
+#endif
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__percpu_init_rwsem);
@@ -142,10 +146,12 @@ static bool readers_active_check(struct percpu_rw_semaphore *sem)
 
 void percpu_down_write(struct percpu_rw_semaphore *sem)
 {
+	rwsem_acquire(&sem->dep_map, 0, 0, _RET_IP_);
+
 	/* Notify readers to take the slow path. */
 	rcu_sync_enter(&sem->rss);
 
-	down_write(&sem->rw_sem);
+	__down_write(&sem->rw_sem);
 
 	/*
 	 * Notify new readers to block; up until now, and thus throughout the
@@ -168,6 +174,8 @@ EXPORT_SYMBOL_GPL(percpu_down_write);
 
 void percpu_up_write(struct percpu_rw_semaphore *sem)
 {
+	rwsem_release(&sem->dep_map, _RET_IP_);
+
 	/*
 	 * Signal the writer is done, no fast path yet.
 	 *
@@ -183,7 +191,7 @@ void percpu_up_write(struct percpu_rw_semaphore *sem)
 	/*
 	 * Release the write lock, this will allow readers back in the game.
 	 */
-	up_write(&sem->rw_sem);
+	__up_write(&sem->rw_sem);
 
 	/*
 	 * Once this completes (at least one RCU-sched grace period hence) the
diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 0d9b6be..30df8df 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1383,7 +1383,7 @@ static inline int __down_read_trylock(struct rw_semaphore *sem)
 /*
  * lock for writing
  */
-static inline void __down_write(struct rw_semaphore *sem)
+inline void __down_write(struct rw_semaphore *sem)
 {
 	long tmp = RWSEM_UNLOCKED_VALUE;
 
@@ -1446,7 +1446,7 @@ inline void __up_read(struct rw_semaphore *sem)
 /*
  * unlock after writing
  */
-static inline void __up_write(struct rw_semaphore *sem)
+inline void __up_write(struct rw_semaphore *sem)
 {
 	long tmp;
 
diff --git a/kernel/locking/rwsem.h b/kernel/locking/rwsem.h
index 2534ce4..d0d33a5 100644
--- a/kernel/locking/rwsem.h
+++ b/kernel/locking/rwsem.h
@@ -6,5 +6,7 @@
 
 extern void __down_read(struct rw_semaphore *sem);
 extern void __up_read(struct rw_semaphore *sem);
+extern void __down_write(struct rw_semaphore *sem);
+extern void __up_write(struct rw_semaphore *sem);
 
 #endif /* __INTERNAL_RWSEM_H */
