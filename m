Return-Path: <SRS0=DSgr=5G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F045C4332E
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FF320781
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Mar 2020 15:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgCUPyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Mar 2020 11:54:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39018 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727593AbgCUPxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Mar 2020 11:53:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFgRY-0005SR-DF; Sat, 21 Mar 2020 16:53:48 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 060D31C22EE;
        Sat, 21 Mar 2020 16:53:48 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:53:47 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Documentation: Add lock ordering and nesting
 documentation
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200321113242.026561244@linutronix.de>
References: <20200321113242.026561244@linutronix.de>
MIME-Version: 1.0
Message-ID: <158480602768.28353.9549972836057301811.tip-bot2@tip-bot2>
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

Commit-ID:     919e9e6395cfac23b7e71ed88930367459055daf
Gitweb:        https://git.kernel.org/tip/919e9e6395cfac23b7e71ed88930367459055daf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 21 Mar 2020 12:25:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 21 Mar 2020 16:00:23 +01:00

Documentation: Add lock ordering and nesting documentation

The kernel provides a variety of locking primitives. The nesting of these
lock types and the implications of them on RT enabled kernels is nowhere
documented.

Add initial documentation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200321113242.026561244@linutronix.de
---
 Documentation/locking/index.rst     |   1 +-
 Documentation/locking/locktypes.rst | 299 +++++++++++++++++++++++++++-
 2 files changed, 300 insertions(+)
 create mode 100644 Documentation/locking/locktypes.rst

diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.rst
index 626a463..5d6800a 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -7,6 +7,7 @@ locking
 .. toctree::
     :maxdepth: 1
 
+    locktypes
     lockdep-design
     lockstat
     locktorture
diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
new file mode 100644
index 0000000..f0aa911
--- /dev/null
+++ b/Documentation/locking/locktypes.rst
@@ -0,0 +1,299 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+.. _kernel_hacking_locktypes:
+
+==========================
+Lock types and their rules
+==========================
+
+Introduction
+============
+
+The kernel provides a variety of locking primitives which can be divided
+into two categories:
+
+ - Sleeping locks
+ - Spinning locks
+
+This document conceptually describes these lock types and provides rules
+for their nesting, including the rules for use under PREEMPT_RT.
+
+
+Lock categories
+===============
+
+Sleeping locks
+--------------
+
+Sleeping locks can only be acquired in preemptible task context.
+
+Although implementations allow try_lock() from other contexts, it is
+necessary to carefully evaluate the safety of unlock() as well as of
+try_lock().  Furthermore, it is also necessary to evaluate the debugging
+versions of these primitives.  In short, don't acquire sleeping locks from
+other contexts unless there is no other option.
+
+Sleeping lock types:
+
+ - mutex
+ - rt_mutex
+ - semaphore
+ - rw_semaphore
+ - ww_mutex
+ - percpu_rw_semaphore
+
+On PREEMPT_RT kernels, these lock types are converted to sleeping locks:
+
+ - spinlock_t
+ - rwlock_t
+
+Spinning locks
+--------------
+
+ - raw_spinlock_t
+ - bit spinlocks
+
+On non-PREEMPT_RT kernels, these lock types are also spinning locks:
+
+ - spinlock_t
+ - rwlock_t
+
+Spinning locks implicitly disable preemption and the lock / unlock functions
+can have suffixes which apply further protections:
+
+ ===================  ====================================================
+ _bh()                Disable / enable bottom halves (soft interrupts)
+ _irq()               Disable / enable interrupts
+ _irqsave/restore()   Save and disable / restore interrupt disabled state
+ ===================  ====================================================
+
+
+rtmutex
+=======
+
+RT-mutexes are mutexes with support for priority inheritance (PI).
+
+PI has limitations on non PREEMPT_RT enabled kernels due to preemption and
+interrupt disabled sections.
+
+PI clearly cannot preempt preemption-disabled or interrupt-disabled
+regions of code, even on PREEMPT_RT kernels.  Instead, PREEMPT_RT kernels
+execute most such regions of code in preemptible task context, especially
+interrupt handlers and soft interrupts.  This conversion allows spinlock_t
+and rwlock_t to be implemented via RT-mutexes.
+
+
+raw_spinlock_t and spinlock_t
+=============================
+
+raw_spinlock_t
+--------------
+
+raw_spinlock_t is a strict spinning lock implementation regardless of the
+kernel configuration including PREEMPT_RT enabled kernels.
+
+raw_spinlock_t is a strict spinning lock implementation in all kernels,
+including PREEMPT_RT kernels.  Use raw_spinlock_t only in real critical
+core code, low level interrupt handling and places where disabling
+preemption or interrupts is required, for example, to safely access
+hardware state.  raw_spinlock_t can sometimes also be used when the
+critical section is tiny, thus avoiding RT-mutex overhead.
+
+spinlock_t
+----------
+
+The semantics of spinlock_t change with the state of CONFIG_PREEMPT_RT.
+
+On a non PREEMPT_RT enabled kernel spinlock_t is mapped to raw_spinlock_t
+and has exactly the same semantics.
+
+spinlock_t and PREEMPT_RT
+-------------------------
+
+On a PREEMPT_RT enabled kernel spinlock_t is mapped to a separate
+implementation based on rt_mutex which changes the semantics:
+
+ - Preemption is not disabled
+
+ - The hard interrupt related suffixes for spin_lock / spin_unlock
+   operations (_irq, _irqsave / _irqrestore) do not affect the CPUs
+   interrupt disabled state
+
+ - The soft interrupt related suffix (_bh()) still disables softirq
+   handlers.
+
+   Non-PREEMPT_RT kernels disable preemption to get this effect.
+
+   PREEMPT_RT kernels use a per-CPU lock for serialization which keeps
+   preemption disabled. The lock disables softirq handlers and also
+   prevents reentrancy due to task preemption.
+
+PREEMPT_RT kernels preserve all other spinlock_t semantics:
+
+ - Tasks holding a spinlock_t do not migrate.  Non-PREEMPT_RT kernels
+   avoid migration by disabling preemption.  PREEMPT_RT kernels instead
+   disable migration, which ensures that pointers to per-CPU variables
+   remain valid even if the task is preempted.
+
+ - Task state is preserved across spinlock acquisition, ensuring that the
+   task-state rules apply to all kernel configurations.  Non-PREEMPT_RT
+   kernels leave task state untouched.  However, PREEMPT_RT must change
+   task state if the task blocks during acquisition.  Therefore, it saves
+   the current task state before blocking and the corresponding lock wakeup
+   restores it.
+
+   Other types of wakeups would normally unconditionally set the task state
+   to RUNNING, but that does not work here because the task must remain
+   blocked until the lock becomes available.  Therefore, when a non-lock
+   wakeup attempts to awaken a task blocked waiting for a spinlock, it
+   instead sets the saved state to RUNNING.  Then, when the lock
+   acquisition completes, the lock wakeup sets the task state to the saved
+   state, in this case setting it to RUNNING.
+
+rwlock_t
+========
+
+rwlock_t is a multiple readers and single writer lock mechanism.
+
+Non-PREEMPT_RT kernels implement rwlock_t as a spinning lock and the
+suffix rules of spinlock_t apply accordingly. The implementation is fair,
+thus preventing writer starvation.
+
+rwlock_t and PREEMPT_RT
+-----------------------
+
+PREEMPT_RT kernels map rwlock_t to a separate rt_mutex-based
+implementation, thus changing semantics:
+
+ - All the spinlock_t changes also apply to rwlock_t.
+
+ - Because an rwlock_t writer cannot grant its priority to multiple
+   readers, a preempted low-priority reader will continue holding its lock,
+   thus starving even high-priority writers.  In contrast, because readers
+   can grant their priority to a writer, a preempted low-priority writer
+   will have its priority boosted until it releases the lock, thus
+   preventing that writer from starving readers.
+
+
+PREEMPT_RT caveats
+==================
+
+spinlock_t and rwlock_t
+-----------------------
+
+These changes in spinlock_t and rwlock_t semantics on PREEMPT_RT kernels
+have a few implications.  For example, on a non-PREEMPT_RT kernel the
+following code sequence works as expected::
+
+   local_irq_disable();
+   spin_lock(&lock);
+
+and is fully equivalent to::
+
+   spin_lock_irq(&lock);
+
+Same applies to rwlock_t and the _irqsave() suffix variants.
+
+On PREEMPT_RT kernel this code sequence breaks because RT-mutex requires a
+fully preemptible context.  Instead, use spin_lock_irq() or
+spin_lock_irqsave() and their unlock counterparts.  In cases where the
+interrupt disabling and locking must remain separate, PREEMPT_RT offers a
+local_lock mechanism.  Acquiring the local_lock pins the task to a CPU,
+allowing things like per-CPU irq-disabled locks to be acquired.  However,
+this approach should be used only where absolutely necessary.
+
+
+raw_spinlock_t
+--------------
+
+Acquiring a raw_spinlock_t disables preemption and possibly also
+interrupts, so the critical section must avoid acquiring a regular
+spinlock_t or rwlock_t, for example, the critical section must avoid
+allocating memory.  Thus, on a non-PREEMPT_RT kernel the following code
+works perfectly::
+
+  raw_spin_lock(&lock);
+  p = kmalloc(sizeof(*p), GFP_ATOMIC);
+
+But this code fails on PREEMPT_RT kernels because the memory allocator is
+fully preemptible and therefore cannot be invoked from truly atomic
+contexts.  However, it is perfectly fine to invoke the memory allocator
+while holding normal non-raw spinlocks because they do not disable
+preemption on PREEMPT_RT kernels::
+
+  spin_lock(&lock);
+  p = kmalloc(sizeof(*p), GFP_ATOMIC);
+
+
+bit spinlocks
+-------------
+
+Bit spinlocks are problematic for PREEMPT_RT as they cannot be easily
+substituted by an RT-mutex based implementation for obvious reasons.
+
+The semantics of bit spinlocks are preserved on PREEMPT_RT kernels and the
+caveats vs. raw_spinlock_t apply.
+
+Some bit spinlocks are substituted by regular spinlock_t for PREEMPT_RT but
+this requires conditional (#ifdef'ed) code changes at the usage site while
+the spinlock_t substitution is simply done by the compiler and the
+conditionals are restricted to header files and core implementation of the
+locking primitives and the usage sites do not require any changes.
+
+
+Lock type nesting rules
+=======================
+
+The most basic rules are:
+
+  - Lock types of the same lock category (sleeping, spinning) can nest
+    arbitrarily as long as they respect the general lock ordering rules to
+    prevent deadlocks.
+
+  - Sleeping lock types cannot nest inside spinning lock types.
+
+  - Spinning lock types can nest inside sleeping lock types.
+
+These rules apply in general independent of CONFIG_PREEMPT_RT.
+
+As PREEMPT_RT changes the lock category of spinlock_t and rwlock_t from
+spinning to sleeping this has obviously restrictions how they can nest with
+raw_spinlock_t.
+
+This results in the following nest ordering:
+
+  1) Sleeping locks
+  2) spinlock_t and rwlock_t
+  3) raw_spinlock_t and bit spinlocks
+
+Lockdep is aware of these constraints to ensure that they are respected.
+
+
+Owner semantics
+===============
+
+Most lock types in the Linux kernel have strict owner semantics, i.e. the
+context (task) which acquires a lock has to release it.
+
+There are two exceptions:
+
+  - semaphores
+  - rwsems
+
+semaphores have no owner semantics for historical reason, and as such
+trylock and release operations can be called from any context. They are
+often used for both serialization and waiting purposes. That's generally
+discouraged and should be replaced by separate serialization and wait
+mechanisms, such as mutexes and completions.
+
+rwsems have grown interfaces which allow non owner release for special
+purposes. This usage is problematic on PREEMPT_RT because PREEMPT_RT
+substitutes all locking primitives except semaphores with RT-mutex based
+implementations to provide priority inheritance for all lock types except
+the truly spinning ones. Priority inheritance on ownerless locks is
+obviously impossible.
+
+For now the rwsem non-owner release excludes code which utilizes it from
+being used on PREEMPT_RT enabled kernels. In same cases this can be
+mitigated by disabling portions of the code, in other cases the complete
+functionality has to be disabled until a workable solution has been found.
