Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C86B9C352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 884D9214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 20:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KgnwYXHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJUsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 15:48:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56998 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726563AbgBJUsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 15:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581367680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=7Dq95HawYe7SPtFP45hL7xf2rvmrM0/5SmuJCi2FbtE=;
        b=KgnwYXHTCC9km8Us9TEfI9HpsFiesPsj8hpU6uSBm+B0yuCrebp3U2DRXAeaPwNziDWvkL
        sJxOTHGmqOwremJ83a8RwDcLJaZ7w1r31F3YoRtGh8DWID/INZ3tWeLMTe+E1Y4Tkqk221
        eAsAB3S/0CDClXQwL8plKn3cqLVXl6o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-rTgCx2b6OWKzUQpn8MGWcg-1; Mon, 10 Feb 2020 15:47:59 -0500
X-MC-Unique: rTgCx2b6OWKzUQpn8MGWcg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 620D91005502;
        Mon, 10 Feb 2020 20:47:57 +0000 (UTC)
Received: from llong.com (dhcp-17-59.bos.redhat.com [10.18.17.59])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AA9287B01;
        Mon, 10 Feb 2020 20:47:54 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Waiman Long <longman@redhat.com>
Subject: [PATCH 1/3] locking/mutex: Add mutex_timed_lock()
Date:   Mon, 10 Feb 2020 15:46:49 -0500
Message-Id: <20200210204651.21674-2-longman@redhat.com>
In-Reply-To: <20200210204651.21674-1-longman@redhat.com>
References: <20200210204651.21674-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are cases where a task wants to acquire a mutex but doesn't want
to wait for an indefinite period of time. Instead, a task may want to
bail out after a certain period of time. There are also cases where
waiting indefinitely can potentially lead to deadlock. Doing it by
using a trylock loop is inelegant as it increases cacheline contention
and is difficult to control the actual wait time.

To address this dilemma, a new mutex_timed_lock() variant is introduced
which allows an additional timeout argument in milliseconds relative to
now.  With this new API, a task can now wait for a given period of time
and bail out when the lock cannot be acquired within the given period.

In reality, the actual wait time is likely to be longer than the given
time. Timeout checking isn't done during optimistic spinning.  Timeout
accuracy isn't the design goal here. Therefore a short timeout value
smaller than the typical task scheduling period may be less accurate.

From the lockdep perspective, mutex_timed_lock() is treated similar to
mutex_trylock(). With a timeout value of 0, mutex_timed_lock() behaves
like mutex_trylock().

Signed-off-by: Waiman Long <longman@redhat.com>
---
 include/linux/mutex.h  |   3 ++
 kernel/locking/mutex.c | 105 +++++++++++++++++++++++++++++++++++++----
 2 files changed, 100 insertions(+), 8 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index aca8f36dfac9..d6b3ac84d60b 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -19,6 +19,7 @@
 #include <asm/processor.h>
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
+#include <linux/ktime.h>
 
 struct ww_acquire_ctx;
 
@@ -165,6 +166,8 @@ do {									\
 extern void mutex_lock(struct mutex *lock);
 extern int __must_check mutex_lock_interruptible(struct mutex *lock);
 extern int __must_check mutex_lock_killable(struct mutex *lock);
+extern int __must_check mutex_timed_lock(struct mutex *lock,
+					 unsigned int timeout_ms);
 extern void mutex_lock_io(struct mutex *lock);
 
 # define mutex_lock_nested(lock, subclass) mutex_lock(lock)
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 5352ce50a97e..976179a4ed9e 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -23,6 +23,7 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/wake_q.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/debug.h>
 #include <linux/export.h>
 #include <linux/spinlock.h>
@@ -101,6 +102,26 @@ static inline unsigned long __owner_flags(unsigned long owner)
 	return owner & MUTEX_FLAGS;
 }
 
+/*
+ * Set up the hrtimer to fire at a future time relative to now.
+ * Return: The hrtimer_sleeper pointer if success, or NULL if it
+ *	   has timed out.
+ */
+static inline struct hrtimer_sleeper *
+mutex_setup_hrtimer(struct hrtimer_sleeper *to, ktime_t timeout)
+{
+	ktime_t curtime = ns_to_ktime(sched_clock());
+
+	if (!ktime_before(curtime, timeout))
+		return NULL;
+
+	hrtimer_init_sleeper_on_stack(to, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_set_expires_range_ns(&to->timer, timeout - curtime,
+				     current->timer_slack_ns);
+	hrtimer_start_expires(&to->timer, HRTIMER_MODE_REL);
+	return to;
+}
+
 /*
  * Trylock variant that retuns the owning task on failure.
  */
@@ -925,12 +946,15 @@ __ww_mutex_add_waiter(struct mutex_waiter *waiter,
 static __always_inline int __sched
 __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		    struct lockdep_map *nest_lock, unsigned long ip,
-		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx)
+		    struct ww_acquire_ctx *ww_ctx, const bool use_ww_ctx,
+		    const unsigned int timeout_ms)
 {
 	struct mutex_waiter waiter;
 	bool first = false;
 	struct ww_mutex *ww;
-	int ret;
+	int ret = 0;
+	struct hrtimer_sleeper timer_sleeper, *to = NULL;
+	ktime_t timeout = 0;
 
 	might_sleep();
 
@@ -953,7 +977,18 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	}
 
 	preempt_disable();
-	mutex_acquire_nest(&lock->dep_map, subclass, 0, nest_lock, ip);
+
+	/*
+	 * Treated as a trylock if timeout value is specified.
+	 */
+	mutex_acquire_nest(&lock->dep_map, subclass, !!timeout_ms,
+			   nest_lock, ip);
+
+	/*
+	 * The timeuot value is now the end time when the timer will expire.
+	 */
+	if (timeout_ms)
+		timeout = ktime_add_ns(ms_to_ktime(timeout_ms), sched_clock());
 
 	if (__mutex_trylock(lock) ||
 	    mutex_optimistic_spin(lock, ww_ctx, use_ww_ctx, NULL)) {
@@ -1029,6 +1064,16 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 				goto err;
 		}
 
+		if (timeout_ms) {
+			if (!to)
+				to = mutex_setup_hrtimer(&timer_sleeper,
+							 timeout);
+			if (!to || !to->task) {
+				ret = -ETIMEDOUT;
+				goto err;
+			}
+		}
+
 		spin_unlock(&lock->wait_lock);
 		schedule_preempt_disabled();
 
@@ -1082,8 +1127,13 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 		ww_mutex_lock_acquired(ww, ww_ctx);
 
 	spin_unlock(&lock->wait_lock);
+out:
+	if (to) {
+		hrtimer_cancel(&to->timer);
+		destroy_hrtimer_on_stack(&to->timer);
+	}
 	preempt_enable();
-	return 0;
+	return ret;
 
 err:
 	__set_current_state(TASK_RUNNING);
@@ -1092,15 +1142,15 @@ __mutex_lock_common(struct mutex *lock, long state, unsigned int subclass,
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
 	mutex_release(&lock->dep_map, ip);
-	preempt_enable();
-	return ret;
+	goto out;
 }
 
 static int __sched
 __mutex_lock(struct mutex *lock, long state, unsigned int subclass,
 	     struct lockdep_map *nest_lock, unsigned long ip)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, NULL, false);
+	return __mutex_lock_common(lock, state, subclass, nest_lock, ip,
+				   NULL, false, 0);
 }
 
 static int __sched
@@ -1108,7 +1158,17 @@ __ww_mutex_lock(struct mutex *lock, long state, unsigned int subclass,
 		struct lockdep_map *nest_lock, unsigned long ip,
 		struct ww_acquire_ctx *ww_ctx)
 {
-	return __mutex_lock_common(lock, state, subclass, nest_lock, ip, ww_ctx, true);
+	return __mutex_lock_common(lock, state, subclass, nest_lock, ip,
+				   ww_ctx, true, 0);
+}
+
+static int __sched
+__mutex_timed_lock(struct mutex *lock, const unsigned int timeout_ms,
+		   unsigned int subclass, struct lockdep_map *nest_lock,
+		   unsigned long ip)
+{
+	return __mutex_lock_common(lock, TASK_INTERRUPTIBLE, subclass,
+				   nest_lock, ip, NULL, false, timeout_ms);
 }
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
@@ -1393,6 +1453,35 @@ __ww_mutex_lock_interruptible_slowpath(struct ww_mutex *lock,
 
 #endif
 
+/**
+ * mutex_timed_lock - acquire the mutex with timeout in ms
+ * @lock: mutex to be acquired
+ * @timeout_ms: timeout value in ms
+ *
+ * Return: 0 if mutex successfully acquired
+ *	   -ETIMEDOUT if timed out
+ *	   -EINTR if a signal is received.
+ *
+ * Wait to acquire the mutex atomically. The waiting will expires after
+ * the given timeout value in ms.
+ */
+int __sched mutex_timed_lock(struct mutex *lock, unsigned int timeout_ms)
+{
+#ifdef CONFIG_DEBUG_MUTEXES
+	DEBUG_LOCKS_WARN_ON(lock->magic != lock);
+#endif
+
+	if (__mutex_trylock(lock)) {
+		mutex_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		return 0;
+	} else if (!timeout_ms) {
+		return -ETIMEDOUT;
+	}
+
+	return __mutex_timed_lock(lock, timeout_ms, 0, NULL, _RET_IP_);
+}
+EXPORT_SYMBOL(mutex_timed_lock);
+
 /**
  * mutex_trylock - try to acquire the mutex, without waiting
  * @lock: the mutex to be acquired
-- 
2.18.1

