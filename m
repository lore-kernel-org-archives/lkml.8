Return-Path: <SRS0=NZ+o=5N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8E8CC43331
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:52:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4A3320716
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Mar 2020 11:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgC1LwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Mar 2020 07:52:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726045AbgC1LwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Mar 2020 07:52:09 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIA0S-0004Re-RT; Sat, 28 Mar 2020 12:52:04 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5F5421C0470;
        Sat, 28 Mar 2020 12:52:04 +0100 (CET)
Date:   Sat, 28 Mar 2020 11:52:04 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] Documentation/locking/locktypes: Further
 clarifications and wordsmithing
Cc:     Paul McKenney <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <87wo78y5yy.fsf@nanos.tec.linutronix.de>
References: <87wo78y5yy.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <158539632402.28353.9866418389571438382.tip-bot2@tip-bot2>
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

Commit-ID:     7ecc6aa522e1b812a2eacc31066945e920b0fde4
Gitweb:        https://git.kernel.org/tip/7ecc6aa522e1b812a2eacc31066945e920b0fde4
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 25 Mar 2020 13:27:49 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 28 Mar 2020 12:47:34 +01:00

Documentation/locking/locktypes: Further clarifications and wordsmithing

The documentation of rw_semaphores is wrong as it claims that the non-owner
reader release is not supported by RT. That's just history biased memory
distortion.

Split the 'Owner semantics' section up and add separate sections for
semaphore and rw_semaphore to reflect reality.

Aside of that the following updates are done:

 - Add pseudo code to document the spinlock state preserving mechanism on
   PREEMPT_RT

 - Wordsmith the bitspinlock and lock nesting sections

Co-developed-by: Paul McKenney <paulmck@kernel.org>
Signed-off-by: Paul McKenney <paulmck@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Link: https://lkml.kernel.org/r/87wo78y5yy.fsf@nanos.tec.linutronix.de

---
 Documentation/locking/locktypes.rst | 148 +++++++++++++++++----------
 1 file changed, 98 insertions(+), 50 deletions(-)

diff --git a/Documentation/locking/locktypes.rst b/Documentation/locking/locktypes.rst
index f0aa911..1c18bb8 100644
--- a/Documentation/locking/locktypes.rst
+++ b/Documentation/locking/locktypes.rst
@@ -67,6 +67,17 @@ can have suffixes which apply further protections:
  _irqsave/restore()   Save and disable / restore interrupt disabled state
  ===================  ====================================================
 
+Owner semantics
+===============
+
+The aforementioned lock types except semaphores have strict owner
+semantics:
+
+  The context (task) that acquired the lock must release it.
+
+rw_semaphores have a special interface which allows non-owner release for
+readers.
+
 
 rtmutex
 =======
@@ -83,6 +94,51 @@ interrupt handlers and soft interrupts.  This conversion allows spinlock_t
 and rwlock_t to be implemented via RT-mutexes.
 
 
+semaphore
+=========
+
+semaphore is a counting semaphore implementation.
+
+Semaphores are often used for both serialization and waiting, but new use
+cases should instead use separate serialization and wait mechanisms, such
+as mutexes and completions.
+
+semaphores and PREEMPT_RT
+----------------------------
+
+PREEMPT_RT does not change the semaphore implementation because counting
+semaphores have no concept of owners, thus preventing PREEMPT_RT from
+providing priority inheritance for semaphores.  After all, an unknown
+owner cannot be boosted. As a consequence, blocking on semaphores can
+result in priority inversion.
+
+
+rw_semaphore
+============
+
+rw_semaphore is a multiple readers and single writer lock mechanism.
+
+On non-PREEMPT_RT kernels the implementation is fair, thus preventing
+writer starvation.
+
+rw_semaphore complies by default with the strict owner semantics, but there
+exist special-purpose interfaces that allow non-owner release for readers.
+These interfaces work independent of the kernel configuration.
+
+rw_semaphore and PREEMPT_RT
+---------------------------
+
+PREEMPT_RT kernels map rw_semaphore to a separate rt_mutex-based
+implementation, thus changing the fairness:
+
+ Because an rw_semaphore writer cannot grant its priority to multiple
+ readers, a preempted low-priority reader will continue holding its lock,
+ thus starving even high-priority writers.  In contrast, because readers
+ can grant their priority to a writer, a preempted low-priority writer will
+ have its priority boosted until it releases the lock, thus preventing that
+ writer from starving readers.
+
+
 raw_spinlock_t and spinlock_t
 =============================
 
@@ -102,7 +158,7 @@ critical section is tiny, thus avoiding RT-mutex overhead.
 spinlock_t
 ----------
 
-The semantics of spinlock_t change with the state of CONFIG_PREEMPT_RT.
+The semantics of spinlock_t change with the state of PREEMPT_RT.
 
 On a non PREEMPT_RT enabled kernel spinlock_t is mapped to raw_spinlock_t
 and has exactly the same semantics.
@@ -140,7 +196,16 @@ PREEMPT_RT kernels preserve all other spinlock_t semantics:
    kernels leave task state untouched.  However, PREEMPT_RT must change
    task state if the task blocks during acquisition.  Therefore, it saves
    the current task state before blocking and the corresponding lock wakeup
-   restores it.
+   restores it, as shown below::
+
+    task->state = TASK_INTERRUPTIBLE
+     lock()
+       block()
+         task->saved_state = task->state
+	 task->state = TASK_UNINTERRUPTIBLE
+	 schedule()
+					lock wakeup
+					  task->state = task->saved_state
 
    Other types of wakeups would normally unconditionally set the task state
    to RUNNING, but that does not work here because the task must remain
@@ -148,7 +213,22 @@ PREEMPT_RT kernels preserve all other spinlock_t semantics:
    wakeup attempts to awaken a task blocked waiting for a spinlock, it
    instead sets the saved state to RUNNING.  Then, when the lock
    acquisition completes, the lock wakeup sets the task state to the saved
-   state, in this case setting it to RUNNING.
+   state, in this case setting it to RUNNING::
+
+    task->state = TASK_INTERRUPTIBLE
+     lock()
+       block()
+         task->saved_state = task->state
+	 task->state = TASK_UNINTERRUPTIBLE
+	 schedule()
+					non lock wakeup
+					  task->saved_state = TASK_RUNNING
+
+					lock wakeup
+					  task->state = task->saved_state
+
+   This ensures that the real wakeup cannot be lost.
+
 
 rwlock_t
 ========
@@ -228,17 +308,16 @@ preemption on PREEMPT_RT kernels::
 bit spinlocks
 -------------
 
-Bit spinlocks are problematic for PREEMPT_RT as they cannot be easily
-substituted by an RT-mutex based implementation for obvious reasons.
-
-The semantics of bit spinlocks are preserved on PREEMPT_RT kernels and the
-caveats vs. raw_spinlock_t apply.
+PREEMPT_RT cannot substitute bit spinlocks because a single bit is too
+small to accommodate an RT-mutex.  Therefore, the semantics of bit
+spinlocks are preserved on PREEMPT_RT kernels, so that the raw_spinlock_t
+caveats also apply to bit spinlocks.
 
-Some bit spinlocks are substituted by regular spinlock_t for PREEMPT_RT but
-this requires conditional (#ifdef'ed) code changes at the usage site while
-the spinlock_t substitution is simply done by the compiler and the
-conditionals are restricted to header files and core implementation of the
-locking primitives and the usage sites do not require any changes.
+Some bit spinlocks are replaced with regular spinlock_t for PREEMPT_RT
+using conditional (#ifdef'ed) code changes at the usage site.  In contrast,
+usage-site changes are not needed for the spinlock_t substitution.
+Instead, conditionals in header files and the core locking implemementation
+enable the compiler to do the substitution transparently.
 
 
 Lock type nesting rules
@@ -254,46 +333,15 @@ The most basic rules are:
 
   - Spinning lock types can nest inside sleeping lock types.
 
-These rules apply in general independent of CONFIG_PREEMPT_RT.
+These constraints apply both in PREEMPT_RT and otherwise.
 
-As PREEMPT_RT changes the lock category of spinlock_t and rwlock_t from
-spinning to sleeping this has obviously restrictions how they can nest with
-raw_spinlock_t.
-
-This results in the following nest ordering:
+The fact that PREEMPT_RT changes the lock category of spinlock_t and
+rwlock_t from spinning to sleeping means that they cannot be acquired while
+holding a raw spinlock.  This results in the following nesting ordering:
 
   1) Sleeping locks
   2) spinlock_t and rwlock_t
   3) raw_spinlock_t and bit spinlocks
 
-Lockdep is aware of these constraints to ensure that they are respected.
-
-
-Owner semantics
-===============
-
-Most lock types in the Linux kernel have strict owner semantics, i.e. the
-context (task) which acquires a lock has to release it.
-
-There are two exceptions:
-
-  - semaphores
-  - rwsems
-
-semaphores have no owner semantics for historical reason, and as such
-trylock and release operations can be called from any context. They are
-often used for both serialization and waiting purposes. That's generally
-discouraged and should be replaced by separate serialization and wait
-mechanisms, such as mutexes and completions.
-
-rwsems have grown interfaces which allow non owner release for special
-purposes. This usage is problematic on PREEMPT_RT because PREEMPT_RT
-substitutes all locking primitives except semaphores with RT-mutex based
-implementations to provide priority inheritance for all lock types except
-the truly spinning ones. Priority inheritance on ownerless locks is
-obviously impossible.
-
-For now the rwsem non-owner release excludes code which utilizes it from
-being used on PREEMPT_RT enabled kernels. In same cases this can be
-mitigated by disabling portions of the code, in other cases the complete
-functionality has to be disabled until a workable solution has been found.
+Lockdep will complain if these constraints are violated, both in
+PREEMPT_RT and otherwise.
