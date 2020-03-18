Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D67EC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:41:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0A9A20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:41:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpLKPzDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCRRlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:41:42 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38381 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgCRRlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:41:39 -0400
Received: by mail-pj1-f65.google.com with SMTP id m15so1504712pje.3
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+kKBb8kG12UUwkftgPYtPm16TCFFiuszQ2Fu/VKTR78=;
        b=OpLKPzDziVVVpuoeV1G8N50XKUo2Aq/17dla6ZYaoPGv0IGY4srGVx1qBDLH+HE0Xv
         F8Re8b8u14lWXQ+EfHKIcaKuIa5x8MkSi0iPTfu2vkz5Zk3pPY979P6Uu+pwkPoXUPsH
         mGfCX9hxdn6bsRTU4GOZngD5zZtQeQa9/ay5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+kKBb8kG12UUwkftgPYtPm16TCFFiuszQ2Fu/VKTR78=;
        b=KTPa+wcCl1wm5bPgn5OfHN6Bh1B5xbIXFaGByq6esYkMkZG30jdfDxG0aECqnjRVrg
         s5VJhYmm4ldBBgW5P2xExAY+FXbMEeEFWPTt1NY6iX4C8GgPvjjoaEfbK+4m1lht9o5I
         0864JquUFtrQ9G8O4MZ8cv0nnM4rUm5Vtp/XXpn7XtLJRrPDz+qxZ5yMfyWK6xjPRowL
         vYYgdYubmaAWKoUxMgX3wjwngSlrBdkh7Wi+aPrzJ2PqpAdUUG3LjBxV5yn+jGCKxEP0
         2yKhNK0zhx+3CaRT8YxpjM6mRDSQ/8FqDEZlunnBh6QBgNy7CVJHO1AuXbwUh/QtDbgw
         iVjQ==
X-Gm-Message-State: ANhLgQ3v7JFgz6ehqUjOrT1nmhYjsTwwhRRyoLVAksVzv08yxPDuYq2A
        gi0HvQD7fpDBThVpIngqlmLUW/O2tdA=
X-Google-Smtp-Source: ADFU+vuUVtcwgb61DRT0ROP8mn40Wdf1TBXHEUje7thO1B+6KgqNI49vUc/lQwpJobbTDYfy6xkj/w==
X-Received: by 2002:a17:90b:11d5:: with SMTP id gv21mr5923339pjb.191.1584553296336;
        Wed, 18 Mar 2020 10:41:36 -0700 (PDT)
Received: from smtp.gmail.com ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id k5sm2934127pju.29.2020.03.18.10.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:41:35 -0700 (PDT)
From:   Stephen Boyd <swboyd@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: [PATCH v2 2/2] docs: locking: Drop :c:func: throughout
Date:   Wed, 18 Mar 2020 10:41:33 -0700
Message-Id: <20200318174133.160206-3-swboyd@chromium.org>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200318174133.160206-1-swboyd@chromium.org>
References: <20200318174133.160206-1-swboyd@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel doc tooling knows how to do this itself so drop this markup
throughout this file to simplify.

Suggested-by: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
---
 Documentation/kernel-hacking/locking.rst | 176 +++++++++++------------
 1 file changed, 88 insertions(+), 88 deletions(-)

diff --git a/Documentation/kernel-hacking/locking.rst b/Documentation/kernel-hacking/locking.rst
index 9850c1e52607..6ed806e6061b 100644
--- a/Documentation/kernel-hacking/locking.rst
+++ b/Documentation/kernel-hacking/locking.rst
@@ -150,17 +150,17 @@ Locking Only In User Context
 If you have a data structure which is only ever accessed from user
 context, then you can use a simple mutex (``include/linux/mutex.h``) to
 protect it. This is the most trivial case: you initialize the mutex.
-Then you can call :c:func:`mutex_lock_interruptible()` to grab the
-mutex, and :c:func:`mutex_unlock()` to release it. There is also a
-:c:func:`mutex_lock()`, which should be avoided, because it will
+Then you can call mutex_lock_interruptible() to grab the
+mutex, and mutex_unlock() to release it. There is also a
+mutex_lock(), which should be avoided, because it will
 not return if a signal is received.
 
 Example: ``net/netfilter/nf_sockopt.c`` allows registration of new
-:c:func:`setsockopt()` and :c:func:`getsockopt()` calls, with
-:c:func:`nf_register_sockopt()`. Registration and de-registration
+setsockopt() and getsockopt() calls, with
+nf_register_sockopt(). Registration and de-registration
 are only done on module load and unload (and boot time, where there is
 no concurrency), and the list of registrations is only consulted for an
-unknown :c:func:`setsockopt()` or :c:func:`getsockopt()` system
+unknown setsockopt() or getsockopt() system
 call. The ``nf_sockopt_mutex`` is perfect to protect this, especially
 since the setsockopt and getsockopt calls may well sleep.
 
@@ -170,19 +170,19 @@ Locking Between User Context and Softirqs
 If a softirq shares data with user context, you have two problems.
 Firstly, the current user context can be interrupted by a softirq, and
 secondly, the critical region could be entered from another CPU. This is
-where :c:func:`spin_lock_bh()` (``include/linux/spinlock.h``) is
+where spin_lock_bh() (``include/linux/spinlock.h``) is
 used. It disables softirqs on that CPU, then grabs the lock.
-:c:func:`spin_unlock_bh()` does the reverse. (The '_bh' suffix is
+spin_unlock_bh() does the reverse. (The '_bh' suffix is
 a historical reference to "Bottom Halves", the old name for software
 interrupts. It should really be called spin_lock_softirq()' in a
 perfect world).
 
-Note that you can also use :c:func:`spin_lock_irq()` or
-:c:func:`spin_lock_irqsave()` here, which stop hardware interrupts
+Note that you can also use spin_lock_irq() or
+spin_lock_irqsave() here, which stop hardware interrupts
 as well: see `Hard IRQ Context <#hard-irq-context>`__.
 
 This works perfectly for UP as well: the spin lock vanishes, and this
-macro simply becomes :c:func:`local_bh_disable()`
+macro simply becomes local_bh_disable()
 (``include/linux/interrupt.h``), which protects you from the softirq
 being run.
 
@@ -216,8 +216,8 @@ Different Tasklets/Timers
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 
 If another tasklet/timer wants to share data with your tasklet or timer
-, you will both need to use :c:func:`spin_lock()` and
-:c:func:`spin_unlock()` calls. :c:func:`spin_lock_bh()` is
+, you will both need to use spin_lock() and
+spin_unlock() calls. spin_lock_bh() is
 unnecessary here, as you are already in a tasklet, and none will be run
 on the same CPU.
 
@@ -234,14 +234,14 @@ The same softirq can run on the other CPUs: you can use a per-CPU array
 going so far as to use a softirq, you probably care about scalable
 performance enough to justify the extra complexity.
 
-You'll need to use :c:func:`spin_lock()` and
-:c:func:`spin_unlock()` for shared data.
+You'll need to use spin_lock() and
+spin_unlock() for shared data.
 
 Different Softirqs
 ~~~~~~~~~~~~~~~~~~
 
-You'll need to use :c:func:`spin_lock()` and
-:c:func:`spin_unlock()` for shared data, whether it be a timer,
+You'll need to use spin_lock() and
+spin_unlock() for shared data, whether it be a timer,
 tasklet, different softirq or the same or another softirq: any of them
 could be running on a different CPU.
 
@@ -259,38 +259,38 @@ If a hardware irq handler shares data with a softirq, you have two
 concerns. Firstly, the softirq processing can be interrupted by a
 hardware interrupt, and secondly, the critical region could be entered
 by a hardware interrupt on another CPU. This is where
-:c:func:`spin_lock_irq()` is used. It is defined to disable
+spin_lock_irq() is used. It is defined to disable
 interrupts on that cpu, then grab the lock.
-:c:func:`spin_unlock_irq()` does the reverse.
+spin_unlock_irq() does the reverse.
 
-The irq handler does not need to use :c:func:`spin_lock_irq()`, because
+The irq handler does not need to use spin_lock_irq(), because
 the softirq cannot run while the irq handler is running: it can use
-:c:func:`spin_lock()`, which is slightly faster. The only exception
+spin_lock(), which is slightly faster. The only exception
 would be if a different hardware irq handler uses the same lock:
-:c:func:`spin_lock_irq()` will stop that from interrupting us.
+spin_lock_irq() will stop that from interrupting us.
 
 This works perfectly for UP as well: the spin lock vanishes, and this
-macro simply becomes :c:func:`local_irq_disable()`
+macro simply becomes local_irq_disable()
 (``include/asm/smp.h``), which protects you from the softirq/tasklet/BH
 being run.
 
-:c:func:`spin_lock_irqsave()` (``include/linux/spinlock.h``) is a
+spin_lock_irqsave() (``include/linux/spinlock.h``) is a
 variant which saves whether interrupts were on or off in a flags word,
-which is passed to :c:func:`spin_unlock_irqrestore()`. This means
+which is passed to spin_unlock_irqrestore(). This means
 that the same code can be used inside an hard irq handler (where
 interrupts are already off) and in softirqs (where the irq disabling is
 required).
 
 Note that softirqs (and hence tasklets and timers) are run on return
-from hardware interrupts, so :c:func:`spin_lock_irq()` also stops
-these. In that sense, :c:func:`spin_lock_irqsave()` is the most
+from hardware interrupts, so spin_lock_irq() also stops
+these. In that sense, spin_lock_irqsave() is the most
 general and powerful locking function.
 
 Locking Between Two Hard IRQ Handlers
 -------------------------------------
 
 It is rare to have to share data between two IRQ handlers, but if you
-do, :c:func:`spin_lock_irqsave()` should be used: it is
+do, spin_lock_irqsave() should be used: it is
 architecture-specific whether all interrupts are disabled inside irq
 handlers themselves.
 
@@ -304,11 +304,11 @@ Pete Zaitcev gives the following summary:
    (``copy_from_user*(`` or ``kmalloc(x,GFP_KERNEL)``).
 
 -  Otherwise (== data can be touched in an interrupt), use
-   :c:func:`spin_lock_irqsave()` and
-   :c:func:`spin_unlock_irqrestore()`.
+   spin_lock_irqsave() and
+   spin_unlock_irqrestore().
 
 -  Avoid holding spinlock for more than 5 lines of code and across any
-   function call (except accessors like :c:func:`readb()`).
+   function call (except accessors like readb()).
 
 Table of Minimum Requirements
 -----------------------------
@@ -320,7 +320,7 @@ particular thread can only run on one CPU at a time, but if it needs
 shares data with another thread, locking is required).
 
 Remember the advice above: you can always use
-:c:func:`spin_lock_irqsave()`, which is a superset of all other
+spin_lock_irqsave(), which is a superset of all other
 spinlock primitives.
 
 ============== ============= ============= ========= ========= ========= ========= ======= ======= ============== ==============
@@ -363,13 +363,13 @@ They can be used if you need no access to the data protected with the
 lock when some other thread is holding the lock. You should acquire the
 lock later if you then need access to the data protected with the lock.
 
-:c:func:`spin_trylock()` does not spin but returns non-zero if it
+spin_trylock() does not spin but returns non-zero if it
 acquires the spinlock on the first try or 0 if not. This function can be
-used in all contexts like :c:func:`spin_lock()`: you must have
+used in all contexts like spin_lock(): you must have
 disabled the contexts that might interrupt you and acquire the spin
 lock.
 
-:c:func:`mutex_trylock()` does not suspend your task but returns
+mutex_trylock() does not suspend your task but returns
 non-zero if it could lock the mutex on the first try or 0 if not. This
 function cannot be safely used in hardware or software interrupt
 contexts despite not sleeping.
@@ -490,14 +490,14 @@ easy, since we copy the data for the user, and never let them access the
 objects directly.
 
 There is a slight (and common) optimization here: in
-:c:func:`cache_add()` we set up the fields of the object before
+cache_add() we set up the fields of the object before
 grabbing the lock. This is safe, as no-one else can access it until we
 put it in cache.
 
 Accessing From Interrupt Context
 --------------------------------
 
-Now consider the case where :c:func:`cache_find()` can be called
+Now consider the case where cache_find() can be called
 from interrupt context: either a hardware interrupt or a softirq. An
 example would be a timer which deletes object from the cache.
 
@@ -566,16 +566,16 @@ which are taken away, and the ``+`` are lines which are added.
              return ret;
      }
 
-Note that the :c:func:`spin_lock_irqsave()` will turn off
+Note that the spin_lock_irqsave() will turn off
 interrupts if they are on, otherwise does nothing (if we are already in
 an interrupt handler), hence these functions are safe to call from any
 context.
 
-Unfortunately, :c:func:`cache_add()` calls :c:func:`kmalloc()`
+Unfortunately, cache_add() calls kmalloc()
 with the ``GFP_KERNEL`` flag, which is only legal in user context. I
-have assumed that :c:func:`cache_add()` is still only called in
+have assumed that cache_add() is still only called in
 user context, otherwise this should become a parameter to
-:c:func:`cache_add()`.
+cache_add().
 
 Exposing Objects Outside This File
 ----------------------------------
@@ -592,7 +592,7 @@ This makes locking trickier, as it is no longer all in one place.
 The second problem is the lifetime problem: if another structure keeps a
 pointer to an object, it presumably expects that pointer to remain
 valid. Unfortunately, this is only guaranteed while you hold the lock,
-otherwise someone might call :c:func:`cache_delete()` and even
+otherwise someone might call cache_delete() and even
 worse, add another object, re-using the same address.
 
 As there is only one lock, you can't hold it forever: no-one else would
@@ -693,8 +693,8 @@ Here is the code::
 
 We encapsulate the reference counting in the standard 'get' and 'put'
 functions. Now we can return the object itself from
-:c:func:`cache_find()` which has the advantage that the user can
-now sleep holding the object (eg. to :c:func:`copy_to_user()` to
+cache_find() which has the advantage that the user can
+now sleep holding the object (eg. to copy_to_user() to
 name to userspace).
 
 The other point to note is that I said a reference should be held for
@@ -710,7 +710,7 @@ number of atomic operations defined in ``include/asm/atomic.h``: these
 are guaranteed to be seen atomically from all CPUs in the system, so no
 lock is required. In this case, it is simpler than using spinlocks,
 although for anything non-trivial using spinlocks is clearer. The
-:c:func:`atomic_inc()` and :c:func:`atomic_dec_and_test()`
+atomic_inc() and atomic_dec_and_test()
 are used instead of the standard increment and decrement operators, and
 the lock is no longer used to protect the reference count itself.
 
@@ -802,7 +802,7 @@ name to change, there are three possibilities:
 -  You can make ``cache_lock`` non-static, and tell people to grab that
    lock before changing the name in any object.
 
--  You can provide a :c:func:`cache_obj_rename()` which grabs this
+-  You can provide a cache_obj_rename() which grabs this
    lock and changes the name for the caller, and tell everyone to use
    that function.
 
@@ -861,11 +861,11 @@ Note that I decide that the popularity count should be protected by the
 ``cache_lock`` rather than the per-object lock: this is because it (like
 the :c:type:`struct list_head <list_head>` inside the object)
 is logically part of the infrastructure. This way, I don't need to grab
-the lock of every object in :c:func:`__cache_add()` when seeking
+the lock of every object in __cache_add() when seeking
 the least popular.
 
 I also decided that the id member is unchangeable, so I don't need to
-grab each object lock in :c:func:`__cache_find()` to examine the
+grab each object lock in __cache_find() to examine the
 id: the object lock is only used by a caller who wants to read or write
 the name field.
 
@@ -887,7 +887,7 @@ trivial to diagnose: not a
 stay-up-five-nights-talk-to-fluffy-code-bunnies kind of problem.
 
 For a slightly more complex case, imagine you have a region shared by a
-softirq and user context. If you use a :c:func:`spin_lock()` call
+softirq and user context. If you use a spin_lock() call
 to protect it, it is possible that the user context will be interrupted
 by the softirq while it holds the lock, and the softirq will then spin
 forever trying to get the same lock.
@@ -985,12 +985,12 @@ you might do the following::
 
 
 Sooner or later, this will crash on SMP, because a timer can have just
-gone off before the :c:func:`spin_lock_bh()`, and it will only get
-the lock after we :c:func:`spin_unlock_bh()`, and then try to free
+gone off before the spin_lock_bh(), and it will only get
+the lock after we spin_unlock_bh(), and then try to free
 the element (which has already been freed!).
 
 This can be avoided by checking the result of
-:c:func:`del_timer()`: if it returns 1, the timer has been deleted.
+del_timer(): if it returns 1, the timer has been deleted.
 If 0, it means (in this case) that it is currently running, so we can
 do::
 
@@ -1012,9 +1012,9 @@ do::
 
 
 Another common problem is deleting timers which restart themselves (by
-calling :c:func:`add_timer()` at the end of their timer function).
+calling add_timer() at the end of their timer function).
 Because this is a fairly common case which is prone to races, you should
-use :c:func:`del_timer_sync()` (``include/linux/timer.h``) to
+use del_timer_sync() (``include/linux/timer.h``) to
 handle this case. It returns the number of times the timer had to be
 deleted before we finally stopped it from adding itself back in.
 
@@ -1086,7 +1086,7 @@ adding ``new`` to a single linked list called ``list``::
             list->next = new;
 
 
-The :c:func:`wmb()` is a write memory barrier. It ensures that the
+The wmb() is a write memory barrier. It ensures that the
 first operation (setting the new element's ``next`` pointer) is complete
 and will be seen by all CPUs, before the second operation is (putting
 the new element into the list). This is important, since modern
@@ -1097,7 +1097,7 @@ rest of the list.
 
 Fortunately, there is a function to do this for standard
 :c:type:`struct list_head <list_head>` lists:
-:c:func:`list_add_rcu()` (``include/linux/list.h``).
+list_add_rcu() (``include/linux/list.h``).
 
 Removing an element from the list is even simpler: we replace the
 pointer to the old element with a pointer to its successor, and readers
@@ -1108,7 +1108,7 @@ will either see it, or skip over it.
             list->next = old->next;
 
 
-There is :c:func:`list_del_rcu()` (``include/linux/list.h``) which
+There is list_del_rcu() (``include/linux/list.h``) which
 does this (the normal version poisons the old object, which we don't
 want).
 
@@ -1116,9 +1116,9 @@ The reader must also be careful: some CPUs can look through the ``next``
 pointer to start reading the contents of the next element early, but
 don't realize that the pre-fetched contents is wrong when the ``next``
 pointer changes underneath them. Once again, there is a
-:c:func:`list_for_each_entry_rcu()` (``include/linux/list.h``)
+list_for_each_entry_rcu() (``include/linux/list.h``)
 to help you. Of course, writers can just use
-:c:func:`list_for_each_entry()`, since there cannot be two
+list_for_each_entry(), since there cannot be two
 simultaneous writers.
 
 Our final dilemma is this: when can we actually destroy the removed
@@ -1127,14 +1127,14 @@ the list right now: if we free this element and the ``next`` pointer
 changes, the reader will jump off into garbage and crash. We need to
 wait until we know that all the readers who were traversing the list
 when we deleted the element are finished. We use
-:c:func:`call_rcu()` to register a callback which will actually
+call_rcu() to register a callback which will actually
 destroy the object once all pre-existing readers are finished.
-Alternatively, :c:func:`synchronize_rcu()` may be used to block
+Alternatively, synchronize_rcu() may be used to block
 until all pre-existing are finished.
 
 But how does Read Copy Update know when the readers are finished? The
 method is this: firstly, the readers always traverse the list inside
-:c:func:`rcu_read_lock()`/:c:func:`rcu_read_unlock()` pairs:
+rcu_read_lock()/rcu_read_unlock() pairs:
 these simply disable preemption so the reader won't go to sleep while
 reading the list.
 
@@ -1223,12 +1223,12 @@ this is the fundamental idea.
      }
 
 Note that the reader will alter the popularity member in
-:c:func:`__cache_find()`, and now it doesn't hold a lock. One
+__cache_find(), and now it doesn't hold a lock. One
 solution would be to make it an ``atomic_t``, but for this usage, we
 don't really care about races: an approximate result is good enough, so
 I didn't change it.
 
-The result is that :c:func:`cache_find()` requires no
+The result is that cache_find() requires no
 synchronization with any other functions, so is almost as fast on SMP as
 it would be on UP.
 
@@ -1240,9 +1240,9 @@ and put the reference count.
 
 Now, because the 'read lock' in RCU is simply disabling preemption, a
 caller which always has preemption disabled between calling
-:c:func:`cache_find()` and :c:func:`object_put()` does not
+cache_find() and object_put() does not
 need to actually get and put the reference count: we could expose
-:c:func:`__cache_find()` by making it non-static, and such
+__cache_find() by making it non-static, and such
 callers could simply call that.
 
 The benefit here is that the reference count is not written to: the
@@ -1260,11 +1260,11 @@ counter. Nice and simple.
 If that was too slow (it's usually not, but if you've got a really big
 machine to test on and can show that it is), you could instead use a
 counter for each CPU, then none of them need an exclusive lock. See
-:c:func:`DEFINE_PER_CPU()`, :c:func:`get_cpu_var()` and
-:c:func:`put_cpu_var()` (``include/linux/percpu.h``).
+DEFINE_PER_CPU(), get_cpu_var() and
+put_cpu_var() (``include/linux/percpu.h``).
 
 Of particular use for simple per-cpu counters is the ``local_t`` type,
-and the :c:func:`cpu_local_inc()` and related functions, which are
+and the cpu_local_inc() and related functions, which are
 more efficient than simple code on some architectures
 (``include/asm/local.h``).
 
@@ -1289,10 +1289,10 @@ irq handler doesn't use a lock, and all other accesses are done as so::
         enable_irq(irq);
         spin_unlock(&lock);
 
-The :c:func:`disable_irq()` prevents the irq handler from running
+The disable_irq() prevents the irq handler from running
 (and waits for it to finish if it's currently running on other CPUs).
 The spinlock prevents any other accesses happening at the same time.
-Naturally, this is slower than just a :c:func:`spin_lock_irq()`
+Naturally, this is slower than just a spin_lock_irq()
 call, so it only makes sense if this type of access happens extremely
 rarely.
 
@@ -1315,22 +1315,22 @@ from user context, and can sleep.
 
 -  Accesses to userspace:
 
-   -  :c:func:`copy_from_user()`
+   -  copy_from_user()
 
-   -  :c:func:`copy_to_user()`
+   -  copy_to_user()
 
-   -  :c:func:`get_user()`
+   -  get_user()
 
-   -  :c:func:`put_user()`
+   -  put_user()
 
--  :c:func:`kmalloc(GFP_KERNEL) <kmalloc>`
+-  kmalloc(GP_KERNEL) <kmalloc>`
 
--  :c:func:`mutex_lock_interruptible()` and
-   :c:func:`mutex_lock()`
+-  mutex_lock_interruptible() and
+   mutex_lock()
 
-   There is a :c:func:`mutex_trylock()` which does not sleep.
+   There is a mutex_trylock() which does not sleep.
    Still, it must not be used inside interrupt context since its
-   implementation is not safe for that. :c:func:`mutex_unlock()`
+   implementation is not safe for that. mutex_unlock()
    will also never sleep. It cannot be used in interrupt context either
    since a mutex must be released by the same task that acquired it.
 
@@ -1340,11 +1340,11 @@ Some Functions Which Don't Sleep
 Some functions are safe to call from any context, or holding almost any
 lock.
 
--  :c:func:`printk()`
+-  printk()
 
--  :c:func:`kfree()`
+-  kfree()
 
--  :c:func:`add_timer()` and :c:func:`del_timer()`
+-  add_timer() and del_timer()
 
 Mutex API reference
 ===================
@@ -1400,26 +1400,26 @@ preemption
 
 bh
   Bottom Half: for historical reasons, functions with '_bh' in them often
-  now refer to any software interrupt, e.g. :c:func:`spin_lock_bh()`
+  now refer to any software interrupt, e.g. spin_lock_bh()
   blocks any software interrupt on the current CPU. Bottom halves are
   deprecated, and will eventually be replaced by tasklets. Only one bottom
   half will be running at any time.
 
 Hardware Interrupt / Hardware IRQ
-  Hardware interrupt request. :c:func:`in_irq()` returns true in a
+  Hardware interrupt request. in_irq() returns true in a
   hardware interrupt handler.
 
 Interrupt Context
   Not user context: processing a hardware irq or software irq. Indicated
-  by the :c:func:`in_interrupt()` macro returning true.
+  by the in_interrupt() macro returning true.
 
 SMP
   Symmetric Multi-Processor: kernels compiled for multiple-CPU machines.
   (``CONFIG_SMP=y``).
 
 Software Interrupt / softirq
-  Software interrupt handler. :c:func:`in_irq()` returns false;
-  :c:func:`in_softirq()` returns true. Tasklets and softirqs both
+  Software interrupt handler. in_irq() returns false;
+  in_softirq() returns true. Tasklets and softirqs both
   fall into the category of 'software interrupts'.
 
   Strictly speaking a softirq is one of up to 32 enumerated software
-- 
Sent by a computer, using git, on the internet

