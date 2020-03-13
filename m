Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62B6C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D1D206E2
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 17:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbgCMRrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 13:47:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47699 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbgCMRrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 13:47:18 -0400
Received: from localhost ([127.0.0.1] helo=flow.W.breakpoint.cc)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jCoOv-00017r-FR; Fri, 13 Mar 2020 18:47:13 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 1/9] Documentation: Add lock ordering and nesting documentation
Date:   Fri, 13 Mar 2020 18:46:53 +0100
Message-Id: <20200313174701.148376-2-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313174701.148376-1-bigeasy@linutronix.de>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The kernel provides a variety of locking primitives. The nesting of these
lock types and the implications of them on RT enabled kernels is nowhere
documented.

Add initial documentation.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 Documentation/locking/index.rst     |   1 +
 Documentation/locking/locktypes.rst | 298 ++++++++++++++++++++++++++++
 2 files changed, 299 insertions(+)
 create mode 100644 Documentation/locking/locktypes.rst

diff --git a/Documentation/locking/index.rst b/Documentation/locking/index.=
rst
index 626a463f7e42e..5d6800a723dc6 100644
--- a/Documentation/locking/index.rst
+++ b/Documentation/locking/index.rst
@@ -7,6 +7,7 @@ locking
 .. toctree::
     :maxdepth: 1
=20
+    locktypes
     lockdep-design
     lockstat
     locktorture
diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/lo=
cktypes.rst
new file mode 100644
index 0000000000000..d4c3f2094ad20
--- /dev/null
+++ b/Documentation/locking/locktypes.rst
@@ -0,0 +1,298 @@
+.. _kernel_hacking_locktypes:
+
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+Lock types and their rules
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
+
+Introduction
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The kernel provides a variety of locking primitives which can be divided
+into two categories:
+
+ - Sleeping locks
+ - Spinning locks
+
+This document describes the lock types at least at the conceptual level and
+provides rules for nesting of lock types also under the aspect of PREEMPT_=
RT.
+
+Lock categories
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Sleeping locks
+--------------
+
+Sleeping locks can only be acquired in preemptible task context.
+
+Some of the implementations allow try_lock() attempts from other contexts,
+but that has to be really evaluated carefully including the question
+whether the unlock can be done from that context safely as well.
+
+Note, that some lock types change their implementation details when
+debugging is enabled, so this should be really only considered if there is
+no other option.
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
+On a PREEMPT_RT enabled kernel the following lock types are converted to
+sleeping locks:
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
+On a non PREEMPT_RT enabled kernel the following lock types are spinning
+locks as well:
+
+ - spinlock_t
+ - rwlock_t
+
+Spinning locks implicitly disable preemption and the lock / unlock functio=
ns
+can have suffixes which apply further protections:
+
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ _bh()                Disable / enable bottom halfs (soft interrupts)
+ _irq()               Disable / enable interrupts
+ _irqsave/restore()   Save and disable / restore interrupt disabled state
+ =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+
+rtmutex
+=3D=3D=3D=3D=3D=3D=3D
+
+RT-mutexes are mutexes with support for priority inheritance (PI).
+
+PI has limitations on non PREEMPT_RT enabled kernels due to preemption and
+interrupt disabled sections.
+
+On a PREEMPT_RT enabled kernel most of these sections are fully
+preemptible. This is possible because PREEMPT_RT forces most executions
+into task context, especially interrupt handlers and soft interrupts, which
+allows to substitute spinlock_t and rwlock_t with RT-mutex based
+implementations.
+
+
+raw_spinlock_t and spinlock_t
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
+
+raw_spinlock_t
+--------------
+
+raw_spinlock_t is a strict spinning lock implementation regardless of the
+kernel configuration including PREEMPT_RT enabled kernels.
+
+raw_spinlock_t is to be used only in real critical core code, low level
+interrupt handling and places where protecting (hardware) state is required
+to be safe against preemption and eventually interrupts.
+
+Another reason to use raw_spinlock_t is when the critical section is tiny
+to avoid the overhead of spinlock_t on a PREEMPT_RT enabled kernel in the
+contended case.
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
+ - The soft interrupt related suffix (_bh()) is still disabling the
+   execution of soft interrupts, but contrary to a non PREEMPT_RT enabled
+   kernel, which utilizes the preemption count, this is achieved by a per
+   CPU bottom half locking mechanism.
+
+All other semantics of spinlock_t are preserved:
+
+ - Migration of tasks which hold a spinlock_t is prevented. On a non
+   PREEMPT_RT enabled kernel this is implicit due to preemption disable.
+   PREEMPT_RT has a separate mechanism to achieve this. This ensures that
+   pointers to per CPU variables stay valid even if the task is preempted.
+
+ - Task state preservation. The task state is not affected when a lock is
+   contended and the task has to schedule out and wait for the lock to
+   become available. The lock wake up restores the task state unless there
+   was a regular (not lock related) wake up on the task. This ensures that
+   the task state rules are always correct independent of the kernel
+   configuration.
+
+rwlock_t
+=3D=3D=3D=3D=3D=3D=3D=3D
+
+rwlock_t is a multiple readers and single writers lock mechanism.
+
+On a non PREEMPT_RT enabled kernel rwlock_t is implemented as a spinning
+lock and the suffix rules of spinlock_t apply accordingly. The
+implementation is fair and prevents writer starvation.
+
+rwlock_t and PREEMPT_RT
+-----------------------
+
+On a PREEMPT_RT enabled kernel rwlock_t is mapped to a separate
+implementation based on rt_mutex which changes the semantics:
+
+ - Same changes as for spinlock_t
+
+ - The implementation is not fair and can cause writer starvation under
+   certain circumstances. The reason for this is that a writer cannot
+   inherit its priority to multiple readers. Readers which are blocked
+   on a writer fully support the priority inheritance protocol.
+
+
+PREEMPT_RT caveats
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+spinlock_t and rwlock_t
+-----------------------
+
+The substitution of spinlock_t and rwlock_t on PREEMPT_RT enabled kernels
+with RT-mutex based implementations has a few implications.
+
+On a non PREEMPT_RT enabled kernel the following code construct is
+perfectly fine::
+
+   local_irq_disable();
+   spin_lock(&lock);
+
+and fully equivalent to::
+
+   spin_lock_irq(&lock);
+
+Same applies to rwlock_t and the _irqsave() suffix variant.
+
+On a PREEMPT_RT enabled kernel this breaks because the RT-mutex
+substitution expects a fully preemptible context.
+
+The preferred solution is to use :c:func:`spin_lock_irq()` or
+:c:func:`spin_lock_irqsave()` and their unlock counterparts.
+
+PREEMPT_RT also offers a local_lock mechanism to substitute the
+local_irq_disable/save() constructs in cases where a separation of the
+interrupt disabling and the locking is really unavoidable. This should be
+restricted to very rare cases.
+
+
+raw_spinlock_t
+--------------
+
+As raw_spinlock_t locking disables preemption and eventually interrupts the
+code inside the critical region has to be careful to avoid calls into code
+which takes regular spinlock_t or rwlock_t. A prime example is memory
+allocation.
+
+On a non PREEMPT_RT enabled kernel the following code construct is
+perfectly fine code::
+
+  raw_spin_lock(&lock);
+  p =3D kmalloc(sizeof(*p), GFP_ATOMIC);
+
+On a PREEMPT_RT enabled kernel this breaks because the memory allocator is
+fully preemptible and therefore does not support allocations from truly
+atomic contexts.
+
+Contrary to that the following code construct is perfectly fine on
+PREEMPT_RT as spin_lock() does not disable preemption::
+
+  spin_lock(&lock);
+  p =3D kmalloc(sizeof(*p), GFP_ATOMIC);
+
+Most places which use GFP_ATOMIC allocations are safe on PREEMPT_RT as the
+execution is forced into thread context and the lock substitution is
+ensuring preemptability.
+
+
+bit spinlocks
+-------------
+
+Bit spinlocks are problematic for PREEMPT_RT as they cannot be easily
+substituted by a RT-mutex based implementation for obvious reasons.
+
+The semantics of bit spinlocks are preserved on a PREEMPT_RT enabled kernel
+and the caveats vs. raw_spinlock_t apply.
+
+Some bit spinlocks are substituted by regular spinlock_t for PREEMPT_RT but
+this requires conditional (#ifdef'ed) code changes at the usage side while
+the spinlock_t substitution is simply done by the compiler and the
+conditionals are restricted to header files and core implementation of the
+locking primitives and the usage sites do not require any changes.
+
+
+Lock type nesting rules
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+Most lock types in the Linux kernel have strict owner semantics, i.e. the
+context (task) which acquires a lock has to release it.
+
+There are two exceptions:
+
+  - semaphores
+  - rwsem
+
+semaphores have no strict owner semantics for historical reasons. They are
+often used for both serialization and waiting purposes. That's generally
+discouraged and should be replaced by separate serialization and wait
+mechanisms.
+
+rwsem have grown interfaces which allow non owner release for special
+purposes. This usage is problematic on PREEMPT_RT because PREEMPT_RT
+substitutes all locking primitives except semaphores with RT-mutex based
+implementation to provide priority inheritance for all lock types except
+the truly spinning ones. Priority inheritance on ownerless locks is
+obviously impossible.
+
+For now the rwsem non-owner release excludes code which utilizes it from
+being used on PREEMPT_RT enabled kernels. In same cases this can be
+mitigated by disabling portions of the code, in other cases the complete
+functionality has to be disabled until a workable solution has been found.
--=20
2.25.1

