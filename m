Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B90BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFCA920706
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s34jC1RX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgFZPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729850AbgFZPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:43:50 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0FAC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I9uowJrxVb6GhLBF/C43HzVtSBG25Vcjc2ER4uZdVfw=; b=s34jC1RXKo2o9D5TX36keEXiLT
        ubdiMGZ9FinvTpxl4gzVXsXiAX9pltcU+rFx1yYKUSVSIZiYdoXGjoicO/TT6mdOJ+XnucLTTKOPZ
        Od7v1aZ0i+NO4YjsL2wRX7ERHCC3rt+hMhLzt2m+G4oE2Gw5UxHzadIelYl6UaxkCQHLxLKM/WcAU
        +adb8hp6xlZjqYRVQXeua5AsTeT0NsIzvbpNbbayqQi1TjxIXjD6uk9ECoi2o1e4Djklctu/P9OTt
        CfHTatahsWXYULGJ30mfX75EDQp5ipWS4TSkj2Gl2Ts7thJs/MFtCZPPfwECz5vdVFGXZFBbqYpUs
        mzAdajhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1joqVZ-00022p-Ix; Fri, 26 Jun 2020 15:43:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1BC5730280D;
        Fri, 26 Jun 2020 17:43:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0D6FD2B0AEC81; Fri, 26 Jun 2020 17:43:13 +0200 (CEST)
Date:   Fri, 26 Jun 2020 17:43:13 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Oleg Nesterov <oleg@redhat.com>, Nick Piggin <npiggin@gmail.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Jan Kara <jack@suse.cz>, Davidlohr Bueso <dave@stgolabs.net>,
        Andi Kleen <ak@linux.intel.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: wait_on_page_bit_common(TASK_KILLABLE, EXCLUSIVE) can miss
 wakeup?
Message-ID: <20200626154313.GI4817@hirez.programming.kicks-ass.net>
References: <20200624161142.GA12184@redhat.com>
 <20200624162042.GA12238@redhat.com>
 <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJA2Z3kUFb-5s=6+n0qbTs8ELqKFt9B3pH85a8fGD73w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 09:36:54AM -0700, Linus Torvalds wrote:
> But I think the bug still exists.
> 
> So the requirement is:
> 
>  - bit_is_set returns false so we don't call io_schedule: we're still
> TASK_KILLABLE
> 
>  - somebody else gets the lock, so the test_and_set_bit_lock() fails
> 
>  - that somebody else releases the lock almost immediately, and wakes
> us up because we're still on the wait-queue (and still TASK_KILLABLE,
> not TASK_RUNNING)
> 
>  - another party sends us a SIGKILL
> 
>  - we see the signal_pending_state() and exit
> 
>  - we've now been woken up, but didn't wake anybody else up, and the
> lock is released but there may be waiters who came in at the same time
> and never saw the wakeup.
> 
> I think this is basically impossible to hit in practice, but it does
> look like a real bug.
> 
> Maybe I'm missing something. This code is subtle.

I ended up with something like the below.. but it is too warm to think
properly.

I don't particularly like WQ_FLAG_PAGEWAITERS, but I liked open-coding
all that even less.

---
 include/linux/wait.h | 16 +++++++++++--
 kernel/sched/wait.c  | 12 ++++++++++
 mm/filemap.c         | 68 ++++++++++++++++++----------------------------------
 3 files changed, 49 insertions(+), 47 deletions(-)

diff --git a/include/linux/wait.h b/include/linux/wait.h
index 898c890fc153..760d0a6e10e8 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -11,7 +11,7 @@
 #include <asm/current.h>
 #include <uapi/linux/wait.h>
 
-typedef struct wait_queue_entry wait_queue_entry_t;
+struct wait_queue_entry;
 
 typedef int (*wait_queue_func_t)(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
 int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int flags, void *key);
@@ -20,7 +20,8 @@ int default_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int
 #define WQ_FLAG_EXCLUSIVE	0x01
 #define WQ_FLAG_WOKEN		0x02
 #define WQ_FLAG_BOOKMARK	0x04
-#define WQ_FLAG_CUSTOM		0x08
+#define WQ_FLAG_PAGEWAITERS	0x08
+#define WQ_FLAG_CUSTOM		0x10
 
 /*
  * A single wait-queue entry structure:
@@ -31,6 +32,17 @@ struct wait_queue_entry {
 	wait_queue_func_t	func;
 	struct list_head	entry;
 };
+typedef struct wait_queue_entry wait_queue_entry_t;
+
+
+/*
+ * See mm/filemap.c:wait_on_page_bit_common()
+ */
+struct wait_page_queue {
+	wait_queue_entry_t	wait;
+	struct page		*page;
+	int			bit_nr;
+};
 
 struct wait_queue_head {
 	spinlock_t		lock;
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index ba059fbfc53a..9e814cdf704f 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -299,6 +299,12 @@ long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_en
 				__add_wait_queue_entry_tail(wq_head, wq_entry);
 			else
 				__add_wait_queue(wq_head, wq_entry);
+
+			if (wq_entry->flags & WQ_FLAG_PAGEWAITERS) {
+				struct wait_page_queue *wpq =
+					container_of(wq_entry, struct wait_page_queue, wait);
+				SetPageWaiters(wpq->page);
+			}
 		}
 		set_current_state(state);
 	}
@@ -379,6 +385,12 @@ void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_en
 	if (!list_empty_careful(&wq_entry->entry)) {
 		spin_lock_irqsave(&wq_head->lock, flags);
 		list_del_init(&wq_entry->entry);
+
+		if (wq_entry->flags & WQ_FLAG_PAGEWAITERS) {
+			struct wait_page_queue *wpq =
+				container_of(wq_entry, struct wait_page_queue, wait);
+			ClearPageWaiters(wpq->page);
+		}
 		spin_unlock_irqrestore(&wq_head->lock, flags);
 	}
 }
diff --git a/mm/filemap.c b/mm/filemap.c
index f0ae9a6308cb..6d03d51f2d92 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -994,12 +994,6 @@ struct wait_page_key {
 	int page_match;
 };
 
-struct wait_page_queue {
-	struct page *page;
-	int bit_nr;
-	wait_queue_entry_t wait;
-};
-
 static int wake_page_function(wait_queue_entry_t *wait, unsigned mode, int sync, void *arg)
 {
 	struct wait_page_key *key = arg;
@@ -1089,9 +1083,9 @@ static void wake_up_page(struct page *page, int bit)
 }
 
 /*
- * A choice of three behaviors for wait_on_page_bit_common():
+ * A choice of three behaviours for wait_on_page_bit_common():
  */
-enum behavior {
+enum behaviour {
 	EXCLUSIVE,	/* Hold ref to page and take the bit when woken, like
 			 * __lock_page() waiting on then setting PG_locked.
 			 */
@@ -1103,12 +1097,12 @@ enum behavior {
 			 */
 };
 
-static inline int wait_on_page_bit_common(wait_queue_head_t *q,
-	struct page *page, int bit_nr, int state, enum behavior behavior)
+static __always_inline int
+wait_on_page_bit_common(wait_queue_head_t *q, struct page *page, int bit_nr,
+			int state, enum behaviour behaviour)
 {
 	struct wait_page_queue wait_page;
 	wait_queue_entry_t *wait = &wait_page.wait;
-	bool bit_is_set;
 	bool thrashing = false;
 	bool delayacct = false;
 	unsigned long pflags;
@@ -1125,71 +1119,55 @@ static inline int wait_on_page_bit_common(wait_queue_head_t *q,
 	}
 
 	init_wait(wait);
-	wait->flags = behavior == EXCLUSIVE ? WQ_FLAG_EXCLUSIVE : 0;
+	wait->flags = WQ_FLAG_PAGEWAITERS |
+		      WQ_FLAG_EXCLUSIVE * (behaviour == EXCLUSIVE);
 	wait->func = wake_page_function;
 	wait_page.page = page;
 	wait_page.bit_nr = bit_nr;
 
+	/* ___wait_event() */
 	for (;;) {
-		spin_lock_irq(&q->lock);
-
-		if (likely(list_empty(&wait->entry))) {
-			__add_wait_queue_entry_tail(q, wait);
-			SetPageWaiters(page);
-		}
-
-		set_current_state(state);
-
-		spin_unlock_irq(&q->lock);
-
-		bit_is_set = test_bit(bit_nr, &page->flags);
-		if (behavior == DROP)
-			put_page(page);
+		int intr = prepare_to_wait_event(q, wait, state);
 
-		if (likely(bit_is_set))
-			io_schedule();
-
-		if (behavior == EXCLUSIVE) {
+		/* @cond */
+		if (behaviour == EXCLUSIVE) {
 			if (!test_and_set_bit_lock(bit_nr, &page->flags))
 				break;
-		} else if (behavior == SHARED) {
+		} else if (behaviour == SHARED) {
 			if (!test_bit(bit_nr, &page->flags))
 				break;
+		} else if (behaviour == DROP) {
+			put_page(page);
 		}
 
-		if (signal_pending_state(state, current)) {
-			ret = -EINTR;
-			break;
+		if (___wait_is_interruptible(state) && intr) {
+			ret = intr;
+			goto out;
 		}
 
-		if (behavior == DROP) {
+		/* @cmd */
+		io_schedule();
+
+		if (behaviour == DROP) {
 			/*
 			 * We can no longer safely access page->flags:
 			 * even if CONFIG_MEMORY_HOTREMOVE is not enabled,
 			 * there is a risk of waiting forever on a page reused
 			 * for something that keeps it locked indefinitely.
-			 * But best check for -EINTR above before breaking.
 			 */
+			wait->flags &= ~WQ_FLAG_PAGEWAITERS;
 			break;
 		}
 	}
-
 	finish_wait(q, wait);
 
+out:
 	if (thrashing) {
 		if (delayacct)
 			delayacct_thrashing_end();
 		psi_memstall_leave(&pflags);
 	}
 
-	/*
-	 * A signal could leave PageWaiters set. Clearing it here if
-	 * !waitqueue_active would be possible (by open-coding finish_wait),
-	 * but still fail to catch it in the case of wait hash collision. We
-	 * already can fail to clear wait hash collision cases, so don't
-	 * bother with signals either.
-	 */
-
 	return ret;
 }
 
