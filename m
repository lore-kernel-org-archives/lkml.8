Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6014FC433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A34A2077D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgFAJwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbgFAJwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:52:38 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3418C061A0E;
        Mon,  1 Jun 2020 02:52:37 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jfh7S-0003je-1U; Mon, 01 Jun 2020 11:52:34 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id B04221C0244;
        Mon,  1 Jun 2020 11:52:33 +0200 (CEST)
Date:   Mon, 01 Jun 2020 09:52:33 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Introduce local_lock()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200527201119.1692513-2-bigeasy@linutronix.de>
References: <20200527201119.1692513-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <159100515357.17951.17080667227518510494.tip-bot2@tip-bot2>
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

Commit-ID:     91710728d1725de51d06b40674abf6e860d592c7
Gitweb:        https://git.kernel.org/tip/91710728d1725de51d06b40674abf6e860d592c7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 27 May 2020 22:11:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 28 May 2020 10:31:09 +02:00

locking: Introduce local_lock()

preempt_disable() and local_irq_disable/save() are in principle per CPU big
kernel locks. This has several downsides:

  - The protection scope is unknown

  - Violation of protection rules is hard to detect by instrumentation

  - For PREEMPT_RT such sections, unless in low level critical code, can
    violate the preemptability constraints.

To address this PREEMPT_RT introduced the concept of local_locks which are
strictly per CPU.

The lock operations map to preempt_disable(), local_irq_disable/save() and
the enabling counterparts on non RT enabled kernels.

If lockdep is enabled local locks gain a lock map which tracks the usage
context. This will catch cases where an area is protected by
preempt_disable() but the access also happens from interrupt context. local
locks have identified quite a few such issues over the years, the most
recent example is:

  b7d5dc21072cd ("random: add a spinlock_t to struct batched_entropy")

Aside of the lockdep coverage this also improves code readability as it
precisely annotates the protection scope.

PREEMPT_RT substitutes these local locks with 'sleeping' spinlocks to
protect such sections while maintaining preemtability and CPU locality.

local locks can replace:

  - preempt_enable()/disable() pairs
  - local_irq_disable/enable() pairs
  - local_irq_save/restore() pairs

They are also used to replace code which implicitly disables preemption
like:

  - get_cpu()/put_cpu()
  - get_cpu_var()/put_cpu_var()

with PREEMPT_RT friendly constructs.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20200527201119.1692513-2-bigeasy@linutronix.de
---
 Documentation/locking/locktypes.rst | 215 +++++++++++++++++++++++++--
 include/linux/local_lock.h          |  54 +++++++-
 include/linux/local_lock_internal.h |  90 +++++++++++-
 3 files changed, 348 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/local_lock.h
 create mode 100644 include/linux/local_lock_internal.h

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index 09f45ce..1b577a8 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -13,6 +13,7 @@ The kernel provides a variety of locking primitives which can be divided
 into two categories:
 
  - Sleeping locks
+ - CPU local locks
  - Spinning locks
 
 This document conceptually describes these lock types and provides rules
@@ -44,9 +45,23 @@ Sleeping lock types:
 
 On PREEMPT_RT kernels, these lock types are converted to sleeping locks:
 
+ - local_lock
  - spinlock_t
  - rwlock_t
 
+
+CPU local locks
+---------------
+
+ - local_lock
+
+On non-PREEMPT_RT kernels, local_lock functions are wrappers around
+preemption and interrupt disabling primitives. Contrary to other locking
+mechanisms, disabling preemption or interrupts are pure CPU local
+concurrency control mechanisms and not suited for inter-CPU concurrency
+control.
+
+
 Spinning locks
 --------------
 
@@ -67,6 +82,7 @@ can have suffixes which apply further protections:
  _irqsave/restore()   Save and disable / restore interrupt disabled state
  ===================  ====================================================
 
+
 Owner semantics
 ===============
 
@@ -139,6 +155,56 @@ implementation, thus changing the fairness:
  writer from starving readers.
 
 
+local_lock
+==========
+
+local_lock provides a named scope to critical sections which are protected
+by disabling preemption or interrupts.
+
+On non-PREEMPT_RT kernels local_lock operations map to the preemption and
+interrupt disabling and enabling primitives:
+
+ =========================== ======================
+ local_lock(&llock)          preempt_disable()
+ local_unlock(&llock)        preempt_enable()
+ local_lock_irq(&llock)      local_irq_disable()
+ local_unlock_irq(&llock)    local_irq_enable()
+ local_lock_save(&llock)     local_irq_save()
+ local_lock_restore(&llock)  local_irq_save()
+ =========================== ======================
+
+The named scope of local_lock has two advantages over the regular
+primitives:
+
+  - The lock name allows static analysis and is also a clear documentation
+    of the protection scope while the regular primitives are scopeless and
+    opaque.
+
+  - If lockdep is enabled the local_lock gains a lockmap which allows to
+    validate the correctness of the protection. This can detect cases where
+    e.g. a function using preempt_disable() as protection mechanism is
+    invoked from interrupt or soft-interrupt context. Aside of that
+    lockdep_assert_held(&llock) works as with any other locking primitive.
+
+local_lock and PREEMPT_RT
+-------------------------
+
+PREEMPT_RT kernels map local_lock to a per-CPU spinlock_t, thus changing
+semantics:
+
+  - All spinlock_t changes also apply to local_lock.
+
+local_lock usage
+----------------
+
+local_lock should be used in situations where disabling preemption or
+interrupts is the appropriate form of concurrency control to protect
+per-CPU data structures on a non PREEMPT_RT kernel.
+
+local_lock is not suitable to protect against preemption or interrupts on a
+PREEMPT_RT kernel due to the PREEMPT_RT specific spinlock_t semantics.
+
+
 raw_spinlock_t and spinlock_t
 =============================
 
@@ -258,10 +324,82 @@ implementation, thus changing semantics:
 PREEMPT_RT caveats
 ==================
 
+local_lock on RT
+----------------
+
+The mapping of local_lock to spinlock_t on PREEMPT_RT kernels has a few
+implications. For example, on a non-PREEMPT_RT kernel the following code
+sequence works as expected::
+
+  local_lock_irq(&local_lock);
+  raw_spin_lock(&lock);
+
+and is fully equivalent to::
+
+   raw_spin_lock_irq(&lock);
+
+On a PREEMPT_RT kernel this code sequence breaks because local_lock_irq()
+is mapped to a per-CPU spinlock_t which neither disables interrupts nor
+preemption. The following code sequence works perfectly correct on both
+PREEMPT_RT and non-PREEMPT_RT kernels::
+
+  local_lock_irq(&local_lock);
+  spin_lock(&lock);
+
+Another caveat with local locks is that each local_lock has a specific
+protection scope. So the following substitution is wrong::
+
+  func1()
+  {
+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock_1, flags);
+    func3();
+    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_1, flags);
+  }
+
+  func2()
+  {
+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock_2, flags);
+    func3();
+    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_2, flags);
+  }
+
+  func3()
+  {
+    lockdep_assert_irqs_disabled();
+    access_protected_data();
+  }
+
+On a non-PREEMPT_RT kernel this works correctly, but on a PREEMPT_RT kernel
+local_lock_1 and local_lock_2 are distinct and cannot serialize the callers
+of func3(). Also the lockdep assert will trigger on a PREEMPT_RT kernel
+because local_lock_irqsave() does not disable interrupts due to the
+PREEMPT_RT-specific semantics of spinlock_t. The correct substitution is::
+
+  func1()
+  {
+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
+    func3();
+    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock, flags);
+  }
+
+  func2()
+  {
+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock, flags);
+    func3();
+    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock, flags);
+  }
+
+  func3()
+  {
+    lockdep_assert_held(&local_lock);
+    access_protected_data();
+  }
+
+
 spinlock_t and rwlock_t
 -----------------------
 
-These changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
+The changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
 have a few implications.  For example, on a non-PREEMPT_RT kernel the
 following code sequence works as expected::
 
@@ -282,9 +420,61 @@ local_lock mechanism.  Acquiring the local_lock pins the task to a CPU,
 allowing things like per-CPU interrupt disabled locks to be acquired.
 However, this approach should be used only where absolutely necessary.
 
+A typical scenario is protection of per-CPU variables in thread context::
 
-raw_spinlock_t
---------------
+  struct foo *p = get_cpu_ptr(&var1);
+
+  spin_lock(&p->lock);
+  p->count += this_cpu_read(var2);
+
+This is correct code on a non-PREEMPT_RT kernel, but on a PREEMPT_RT kernel
+this breaks. The PREEMPT_RT-specific change of spinlock_t semantics does
+not allow to acquire p->lock because get_cpu_ptr() implicitly disables
+preemption. The following substitution works on both kernels::
+
+  struct foo *p;
+
+  migrate_disable();
+  p = this_cpu_ptr(&var1);
+  spin_lock(&p->lock);
+  p->count += this_cpu_read(var2);
+
+On a non-PREEMPT_RT kernel migrate_disable() maps to preempt_disable()
+which makes the above code fully equivalent. On a PREEMPT_RT kernel
+migrate_disable() ensures that the task is pinned on the current CPU which
+in turn guarantees that the per-CPU access to var1 and var2 are staying on
+the same CPU.
+
+The migrate_disable() substitution is not valid for the following
+scenario::
+
+  func()
+  {
+    struct foo *p;
+
+    migrate_disable();
+    p = this_cpu_ptr(&var1);
+    p->val = func2();
+
+While correct on a non-PREEMPT_RT kernel, this breaks on PREEMPT_RT because
+here migrate_disable() does not protect against reentrancy from a
+preempting task. A correct substitution for this case is::
+
+  func()
+  {
+    struct foo *p;
+
+    local_lock(&foo_lock);
+    p = this_cpu_ptr(&var1);
+    p->val = func2();
+
+On a non-PREEMPT_RT kernel this protects against reentrancy by disabling
+preemption. On a PREEMPT_RT kernel this is achieved by acquiring the
+underlying per-CPU spinlock.
+
+
+raw_spinlock_t on RT
+--------------------
 
 Acquiring a raw_spinlock_t disables preemption and possibly also
 interrupts, so the critical section must avoid acquiring a regular
@@ -325,22 +515,25 @@ Lock type nesting rules
 
 The most basic rules are:
 
-  - Lock types of the same lock category (sleeping, spinning) can nest
-    arbitrarily as long as they respect the general lock ordering rules to
-    prevent deadlocks.
+  - Lock types of the same lock category (sleeping, CPU local, spinning)
+    can nest arbitrarily as long as they respect the general lock ordering
+    rules to prevent deadlocks.
+
+  - Sleeping lock types cannot nest inside CPU local and spinning lock types.
 
-  - Sleeping lock types cannot nest inside spinning lock types.
+  - CPU local and spinning lock types can nest inside sleeping lock types.
 
-  - Spinning lock types can nest inside sleeping lock types.
+  - Spinning lock types can nest inside all lock types
 
 These constraints apply both in PREEMPT_RT and otherwise.
 
 The fact that PREEMPT_RT changes the lock category of spinlock_t and
-rwlock_t from spinning to sleeping means that they cannot be acquired while
-holding a raw spinlock.  This results in the following nesting ordering:
+rwlock_t from spinning to sleeping and substitutes local_lock with a
+per-CPU spinlock_t means that they cannot be acquired while holding a raw
+spinlock.  This results in the following nesting ordering:
 
   1) Sleeping locks
-  2) spinlock_t and rwlock_t
+  2) spinlock_t, rwlock_t, local_lock
   3) raw_spinlock_t and bit spinlocks
 
 Lockdep will complain if these constraints are violated, both in
diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
new file mode 100644
index 0000000..e55010f
--- /dev/null
+++ b/include/linux/local_lock.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LOCAL_LOCK_H
+#define _LINUX_LOCAL_LOCK_H
+
+#include <linux/local_lock_internal.h>
+
+/**
+ * local_lock_init - Runtime initialize a lock instance
+ */
+#define local_lock_init(lock)		__local_lock_init(lock)
+
+/**
+ * local_lock - Acquire a per CPU local lock
+ * @lock:	The lock variable
+ */
+#define local_lock(lock)		__local_lock(lock)
+
+/**
+ * local_lock_irq - Acquire a per CPU local lock and disable interrupts
+ * @lock:	The lock variable
+ */
+#define local_lock_irq(lock)		__local_lock_irq(lock)
+
+/**
+ * local_lock_irqsave - Acquire a per CPU local lock, save and disable
+ *			 interrupts
+ * @lock:	The lock variable
+ * @flags:	Storage for interrupt flags
+ */
+#define local_lock_irqsave(lock, flags)				\
+	__local_lock_irqsave(lock, flags)
+
+/**
+ * local_unlock - Release a per CPU local lock
+ * @lock:	The lock variable
+ */
+#define local_unlock(lock)		__local_unlock(lock)
+
+/**
+ * local_unlock_irq - Release a per CPU local lock and enable interrupts
+ * @lock:	The lock variable
+ */
+#define local_unlock_irq(lock)		__local_unlock_irq(lock)
+
+/**
+ * local_unlock_irqrestore - Release a per CPU local lock and restore
+ *			      interrupt flags
+ * @lock:	The lock variable
+ * @flags:      Interrupt flags to restore
+ */
+#define local_unlock_irqrestore(lock, flags)			\
+	__local_unlock_irqrestore(lock, flags)
+
+#endif
diff --git a/include/linux/local_lock_internal.h b/include/linux/local_lock_internal.h
new file mode 100644
index 0000000..4a8795b
--- /dev/null
+++ b/include/linux/local_lock_internal.h
@@ -0,0 +1,90 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LOCAL_LOCK_H
+# error "Do not include directly, include linux/local_lock.h"
+#endif
+
+#include <linux/percpu-defs.h>
+#include <linux/lockdep.h>
+
+typedef struct {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+	struct task_struct	*owner;
+#endif
+} local_lock_t;
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define LL_DEP_MAP_INIT(lockname)			\
+	.dep_map = {					\
+		.name = #lockname,			\
+		.wait_type_inner = LD_WAIT_CONFIG,	\
+	}
+#else
+# define LL_DEP_MAP_INIT(lockname)
+#endif
+
+#define INIT_LOCAL_LOCK(lockname)	{ LL_DEP_MAP_INIT(lockname) }
+
+#define __local_lock_init(lock)					\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map_wait(&(lock)->dep_map, #lock, &__key, 0, LD_WAIT_CONFIG);\
+} while (0)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static inline void local_lock_acquire(local_lock_t *l)
+{
+	lock_map_acquire(&l->dep_map);
+	DEBUG_LOCKS_WARN_ON(l->owner);
+	l->owner = current;
+}
+
+static inline void local_lock_release(local_lock_t *l)
+{
+	DEBUG_LOCKS_WARN_ON(l->owner != current);
+	l->owner = NULL;
+	lock_map_release(&l->dep_map);
+}
+
+#else /* CONFIG_DEBUG_LOCK_ALLOC */
+static inline void local_lock_acquire(local_lock_t *l) { }
+static inline void local_lock_release(local_lock_t *l) { }
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+#define __local_lock(lock)					\
+	do {							\
+		preempt_disable();				\
+		local_lock_acquire(this_cpu_ptr(lock));		\
+	} while (0)
+
+#define __local_lock_irq(lock)					\
+	do {							\
+		local_irq_disable();				\
+		local_lock_acquire(this_cpu_ptr(lock));		\
+	} while (0)
+
+#define __local_lock_irqsave(lock, flags)			\
+	do {							\
+		local_irq_save(flags);				\
+		local_lock_acquire(this_cpu_ptr(lock));		\
+	} while (0)
+
+#define __local_unlock(lock)					\
+	do {							\
+		local_lock_release(this_cpu_ptr(lock));		\
+		preempt_enable();				\
+	} while (0)
+
+#define __local_unlock_irq(lock)				\
+	do {							\
+		local_lock_release(this_cpu_ptr(lock));		\
+		local_irq_enable();				\
+	} while (0)
+
+#define __local_unlock_irqrestore(lock, flags)			\
+	do {							\
+		local_lock_release(this_cpu_ptr(lock));		\
+		local_irq_restore(flags);			\
+	} while (0)
