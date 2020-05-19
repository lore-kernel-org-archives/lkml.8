Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F256C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 015E72070A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgESUTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbgESUTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:19:48 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7E0C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 13:19:48 -0700 (PDT)
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jb8iI-00012c-N2; Tue, 19 May 2020 22:19:46 +0200
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/8] locking: Introduce local_lock()
Date:   Tue, 19 May 2020 22:19:05 +0200
Message-Id: <20200519201912.1564477-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200519201912.1564477-1-bigeasy@linutronix.de>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

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
---
 Documentation/locking/locktypes.rst | 215 ++++++++++++++++++++++++++--
 include/linux/locallock.h           |  68 +++++++++
 include/linux/locallock_internal.h  |  97 +++++++++++++
 3 files changed, 369 insertions(+), 11 deletions(-)
 create mode 100644 include/linux/locallock.h
 create mode 100644 include/linux/locallock_internal.h

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/lo=
cktypes.rst
index 09f45ce38d262..1b577a8bf9829 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -13,6 +13,7 @@ The kernel provides a variety of locking primitives which=
 can be divided
 into two categories:
=20
  - Sleeping locks
+ - CPU local locks
  - Spinning locks
=20
 This document conceptually describes these lock types and provides rules
@@ -44,9 +45,23 @@ other contexts unless there is no other option.
=20
 On PREEMPT_RT kernels, these lock types are converted to sleeping locks:
=20
+ - local_lock
  - spinlock_t
  - rwlock_t
=20
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
=20
@@ -67,6 +82,7 @@ Spinning locks implicitly disable preemption and the lock=
 / unlock functions
  _irqsave/restore()   Save and disable / restore interrupt disabled state
  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
+
 Owner semantics
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
@@ -139,6 +155,56 @@ PREEMPT_RT kernels map rw_semaphore to a separate rt_m=
utex-based
  writer from starving readers.
=20
=20
+local_lock
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+local_lock provides a named scope to critical sections which are protected
+by disabling preemption or interrupts.
+
+On non-PREEMPT_RT kernels local_lock operations map to the preemption and
+interrupt disabling and enabling primitives:
+
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ local_lock(&llock)          preempt_disable()
+ local_unlock(&llock)        preempt_enable()
+ local_lock_irq(&llock)      local_irq_disable()
+ local_unlock_irq(&llock)    local_irq_enable()
+ local_lock_save(&llock)     local_irq_save()
+ local_lock_restore(&llock)  local_irq_save()
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
=20
@@ -258,10 +324,82 @@ PREEMPT_RT kernels map rwlock_t to a separate rt_mute=
x-based
 PREEMPT_RT caveats
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
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
+    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_1, flag=
s);
+  }
+
+  func2()
+  {
+    local_irq_save(flags);    -> local_lock_irqsave(&local_lock_2, flags);
+    func3();
+    local_irq_restore(flags); -> local_lock_irqrestore(&local_lock_2, flag=
s);
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
=20
-These changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
+The changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
 have a few implications.  For example, on a non-PREEMPT_RT kernel the
 following code sequence works as expected::
=20
@@ -282,9 +420,61 @@ local_lock mechanism.  Acquiring the local_lock pins t=
he task to a CPU,
 allowing things like per-CPU interrupt disabled locks to be acquired.
 However, this approach should be used only where absolutely necessary.
=20
+A typical scenario is protection of per-CPU variables in thread context::
=20
-raw_spinlock_t
---------------
+  struct foo *p =3D get_cpu_ptr(&var1);
+
+  spin_lock(&p->lock);
+  p->count +=3D this_cpu_read(var2);
+
+This is correct code on a non-PREEMPT_RT kernel, but on a PREEMPT_RT kernel
+this breaks. The PREEMPT_RT-specific change of spinlock_t semantics does
+not allow to acquire p->lock because get_cpu_ptr() implicitly disables
+preemption. The following substitution works on both kernels::
+
+  struct foo *p;
+
+  migrate_disable();
+  p =3D this_cpu_ptr(&var1);
+  spin_lock(&p->lock);
+  p->count +=3D this_cpu_read(var2);
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
+    p =3D this_cpu_ptr(&var1);
+    p->val =3D func2();
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
+    p =3D this_cpu_ptr(&var1);
+    p->val =3D func2();
+
+On a non-PREEMPT_RT kernel this protects against reentrancy by disabling
+preemption. On a PREEMPT_RT kernel this is achieved by acquiring the
+underlying per-CPU spinlock.
+
+
+raw_spinlock_t on RT
+--------------------
=20
 Acquiring a raw_spinlock_t disables preemption and possibly also
 interrupts, so the critical section must avoid acquiring a regular
@@ -325,22 +515,25 @@ Lock type nesting rules
=20
 The most basic rules are:
=20
-  - Lock types of the same lock category (sleeping, spinning) can nest
-    arbitrarily as long as they respect the general lock ordering rules to
-    prevent deadlocks.
+  - Lock types of the same lock category (sleeping, CPU local, spinning)
+    can nest arbitrarily as long as they respect the general lock ordering
+    rules to prevent deadlocks.
=20
-  - Sleeping lock types cannot nest inside spinning lock types.
+  - Sleeping lock types cannot nest inside CPU local and spinning lock typ=
es.
=20
-  - Spinning lock types can nest inside sleeping lock types.
+  - CPU local and spinning lock types can nest inside sleeping lock types.
+
+  - Spinning lock types can nest inside all lock types
=20
 These constraints apply both in PREEMPT_RT and otherwise.
=20
 The fact that PREEMPT_RT changes the lock category of spinlock_t and
-rwlock_t from spinning to sleeping means that they cannot be acquired while
-holding a raw spinlock.  This results in the following nesting ordering:
+rwlock_t from spinning to sleeping and substitutes local_lock with a
+per-CPU spinlock_t means that they cannot be acquired while holding a raw
+spinlock.  This results in the following nesting ordering:
=20
   1) Sleeping locks
-  2) spinlock_t and rwlock_t
+  2) spinlock_t, rwlock_t, local_lock
   3) raw_spinlock_t and bit spinlocks
=20
 Lockdep will complain if these constraints are violated, both in
diff --git a/include/linux/locallock.h b/include/linux/locallock.h
new file mode 100644
index 0000000000000..15addc97d0109
--- /dev/null
+++ b/include/linux/locallock.h
@@ -0,0 +1,68 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LOCALLOCK_H
+#define _LINUX_LOCALLOCK_H
+
+#include <linux/locallock_internal.h>
+
+/**
+ * DEFINE_LOCAL_LOCK - Define and initialize a per CPU local lock
+ * @lock:	Name of the lock instance
+ */
+#define DEFINE_LOCAL_LOCK(lvar)					\
+	DEFINE_PER_CPU(struct local_lock, lvar) =3D { INIT_LOCAL_LOCK(lvar) }
+
+/**
+ * DECLARE_LOCAL_LOCK - Declare a defined per CPU local lock
+ * @lock:	Name of the lock instance
+ */
+#define DECLARE_LOCAL_LOCK(lvar)				\
+	DECLARE_PER_CPU(struct local_lock, lvar)
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
diff --git a/include/linux/locallock_internal.h b/include/linux/locallock_i=
nternal.h
new file mode 100644
index 0000000000000..e79641c2ae9a7
--- /dev/null
+++ b/include/linux/locallock_internal.h
@@ -0,0 +1,97 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LOCALLOCK_H
+# error "Do not include directly, include linux/locallock.h"
+#endif
+
+#include <linux/percpu-defs.h>
+#include <linux/lockdep.h>
+
+struct local_lock {
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+	struct lockdep_map	dep_map;
+	struct task_struct	*owner;
+#endif
+};
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+# define LL_DEP_MAP_INIT(lockname)	.dep_map =3D { .name =3D #lockname }
+#else
+# define LL_DEP_MAP_INIT(lockname)
+#endif
+
+#define INIT_LOCAL_LOCK(lockname)	LL_DEP_MAP_INIT(lockname)
+
+#define local_lock_lockdep_init(lock)				\
+do {								\
+	static struct lock_class_key __key;			\
+								\
+	debug_check_no_locks_freed((void *)lock, sizeof(*lock));\
+	lockdep_init_map(&lock->dep_map, #lock, &__key, 0);	\
+} while (0)
+
+#define __local_lock_init(lockvar)				\
+do {								\
+	struct local_lock *__lock;				\
+	int __cpu;						\
+								\
+	for_each_possible_cpu(__cpu) {				\
+		__lock =3D &per_cpu(lockvar, __cpu));		\
+		local_lock_lockdep_init(__lock);		\
+	}							\
+} while (0)
+
+#ifdef CONFIG_DEBUG_LOCK_ALLOC
+static inline void local_lock_acquire(struct local_lock *l)
+{
+	lock_map_acquire(&l->dep_map);
+	DEBUG_LOCKS_WARN_ON(l->owner);
+	l->owner =3D current;
+}
+
+static inline void local_lock_release(struct local_lock *l)
+{
+	DEBUG_LOCKS_WARN_ON(l->owner !=3D current);
+	l->owner =3D NULL;
+	lock_map_release(&l->dep_map);
+}
+
+#else /* CONFIG_DEBUG_LOCK_ALLOC */
+static inline void local_lock_acquire(struct local_lock *l) { }
+static inline void local_lock_release(struct local_lock *l) { }
+#endif /* !CONFIG_DEBUG_LOCK_ALLOC */
+
+#define __local_lock(lock)					\
+	do {							\
+		preempt_disable();				\
+		local_lock_acquire(this_cpu_ptr(&(lock)));	\
+	} while (0)
+
+#define __local_lock_irq(lock)					\
+	do {							\
+		local_irq_disable();				\
+		local_lock_acquire(this_cpu_ptr(&(lock)));	\
+	} while (0)
+
+#define __local_lock_irqsave(lock, flags)			\
+	do {							\
+		local_irq_save(flags);				\
+		local_lock_acquire(this_cpu_ptr(&(lock)));	\
+	} while (0)
+
+#define __local_unlock(lock)					\
+	do {							\
+		local_lock_release(this_cpu_ptr(&lock));	\
+		preempt_enable();				\
+	} while (0)
+
+#define __local_unlock_irq(lock)				\
+	do {							\
+		local_lock_release(this_cpu_ptr(&lock));	\
+		local_irq_enable();				\
+	} while (0)
+
+#define __local_unlock_irqrestore(lock, flags)			\
+	do {							\
+		local_lock_release(this_cpu_ptr(&lock));	\
+		local_irq_restore(flags);			\
+	} while (0)
--=20
2.26.2

