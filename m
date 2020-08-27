Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3F0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0392080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:17:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbgH0PRW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:17:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:52782 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728355AbgH0PRP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:17:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 14591AC2B;
        Thu, 27 Aug 2020 15:17:44 +0000 (UTC)
Date:   Thu, 27 Aug 2020 17:17:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200827151710.GB4928@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
 <20200826100113.GA8849@jagdpanzerIV.localdomain>
 <87eentlh19.fsf@jogness.linutronix.de>
 <20200826150726.GA4928@alley>
 <87pn7c5s0t.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pn7c5s0t.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-27 12:04:58, John Ogness wrote:
> On 2020-08-26, Petr Mladek <pmladek@suse.com> wrote:
> >> This series makes a very naive assumption that the previous
> >> descriptor is either in the reserved or committed queried states. The
> >> fact is, it can be in any of the 4 queried states. Adding support for
> >> finalization of all the states then gets quite complex, since any
> >> state transition (cmpxchg) may have to deal with an unexpected FINAL
> >> flag.
> >
> > It has to be done in two steps to avoid race:
> >
> > prb_commit()
> >
> >    + set PRB_COMMIT_MASK
> >    + check if it is still the last descriptor in the array
> >    + set PRB_FINAL_MASK when it is not the last descriptor
> >
> > It should work because prb_reserve() finalizes the previous
> > descriptor after the new one is reserved. As a result:
> >
> >    + prb_reserve() should either see PRB_COMMIT_MASK in the previous
> >      descriptor and be able to finalize it.
> >
> >    + or prb_commit() will see that the head moved and it is not
> >      longer the last reserved one.
> 
> I do not like the idea of relying on descriptors to finalize
> themselves. I worry that there might be some hole there. Failing to
> finalize basically disables printk, so that is pretty serious.
> 
> Below is a patch against this series that adds support for finalizing
> all 4 queried states. It passes all my tests. Note that the code handles
> 2 corner cases:
> 
> 1. When seq is 0, there is no previous descriptor to finalize. This
>    exception is important because we don't want to finalize the -1
>    placeholder. Otherwise, upon the first wrap, a descriptor will be
>    prematurely finalized.
> 
> 2. When a previous descriptor is being reserved for the first time, it
>    might have a state_var value of 0 because the writer is still in
>    prb_reserve() and has not set the initial value yet. I added
>    considerable comments on this special case.
> 
> I am comfortable with adding this new code, although it clearly adds
> complexity.
> 
> John Ogness
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 90d48973ac9e..1ed1e9eb930f 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -967,10 +976,25 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	 * any other changes. A write memory barrier is sufficient for this.
>  	 * This pairs with desc_read:D.
>  	 */
> -	if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
> -				     id | 0)) { /* LMM(desc_reserve:F) */
> -		WARN_ON_ONCE(1);
> -		return false;
> +	if (is_final)
> +		state_val = id | 0 | DESC_FINAL_MASK;
> +	else
> +		state_val = id | 0;
> +	if (atomic_long_cmpxchg(&desc->state_var, prev_state_val,
> +				state_val) != prev_state_val) { /* LMM(desc_reserve:F) */
> +		/*
> +		 * This reusable descriptor must have been finalized already.
> +		 * Retry with a reusable+final expected value.
> +		 */
> +		prev_state_val |= DESC_FINAL_MASK;
> +		state_val |= DESC_FINAL_MASK;
> +
> +		if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
> +					     state_val)) { /* LMM(desc_reserve:FIXME) */
> +
> +			WARN_ON_ONCE(1);
> +			return false;

IMHO, this need to be done in a cycle until is succeeds. The previous
descriptor might get reopened or commited several times in the mean time.

I have played with the code from the original patchset in parallel
and came with alreanative solution that uses DESC_FINAL_MASK
as I originally thought. See below.

I still have to shake my head around both approaches.

Anwyay, here is my code against the original patchset:

From 578a9ad6bdb536269cc03d7a65420a414ac35022 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Thu, 27 Aug 2020 16:38:03 +0200
Subject: [PATCH] printk: Alternative solution for handling non-finalized
 descriptors

The original patchset allowed to set PRB_FINAL_MASK even when PRB_COMMIT_MASK
was not set. It was used in prb_reserve() to make sure that the previous
record will always get finalized.

The result is that there are more possible combinations of the bits
and more cmpxchg calls have to be used with different combinations
of bits.

This is easy in prb_commit(). It needs to set PRB_COMMIT_MASK.
PRB_FINAL_MASK could never get removed. So it is enough to try
both possibilities in the right order.

But it gets more problematic in prb_reserve() because the previous
descriptor might get repeatedly re-reserved. It would need to
try both combinations in a cycle until it succeeds. It would
work in reality because the data block could not get extended
indefinitely. But it might make headaches when one tries
to understand the logic.

Alternative solution is to allow to set PRB_FINAL_MASK only
when PRB_COMMIT_MASK is set. This might result in a non-finalized
descriptor when PRB_COMMIT_MASK was not set when the next descriptor
was reserved and nobody later called prb_commit_finalize().

The solution is to set PRB_FINAL_MASK also from prb_commit()
when the next descriptor is already reused. The only requirement
is to set PRB_COMMIT_MASK before checking the next descriptor
to avoid race.

By other words. PRB_FINAL_MASK could be set from two locations.

    + prb_reserve() must not set it when PRB_COMMIT_MASK has not
      been set yet. But then prb_commit() must be called and
      it must see that the next descriptor has been reused.

    + prb_commit() must check if the next descriptor is already
      reused and set PRB_FINAL_MASK just in case it has not
      already been done by prb_reserve().

All new cmpxchg() are full barriers to be on the safe side.
I believe that it is necessary but I did not have time
to describe it. We might discuss it later when this approach
was used.

Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 kernel/printk/printk.c            |   6 +-
 kernel/printk/printk_ringbuffer.c | 128 +++++++++++++++++-------------
 kernel/printk/printk_ringbuffer.h |   2 +-
 3 files changed, 79 insertions(+), 57 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 80afee3cfec7..01c034ddb118 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -535,7 +535,7 @@ static int log_store(u32 caller_id, int facility, int level,
 	if ((flags & LOG_CONT) || !(flags & LOG_NEWLINE))
 		prb_commit(&e);
 	else
-		prb_commit_finalize(&e);
+		prb_final_commit(&e);
 
 	return (text_len + trunc_msg_len);
 }
@@ -1091,7 +1091,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	dest_r.info->ts_nsec = r->info->ts_nsec;
 	dest_r.info->caller_id = r->info->caller_id;
 
-	prb_commit_finalize(&e);
+	prb_final_commit(&e);
 
 	return prb_record_text_space(&e);
 }
@@ -1905,7 +1905,7 @@ static size_t log_output(int facility, int level, enum log_flags lflags, const c
 			r.info->text_len += text_len;
 			if (lflags & LOG_NEWLINE) {
 				r.info->flags |= LOG_NEWLINE;
-				prb_commit_finalize(&e);
+				prb_final_commit(&e);
 			} else {
 				prb_commit(&e);
 			}
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index 90d48973ac9e..e674d09ea27c 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -1351,25 +1351,58 @@ bool prb_reserve_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb
 }
 
 /*
- * Attempt to finalize a specified descriptor. Finalization only happens if
- * the descriptor is in the !final or commit+!final state, both of which
- * yield a state query result of desc_reserved.
+ * Attempt to finalize a specified descriptor. It is possible only
+ * when it has DESC_COMMIT_MASK set.
  */
 static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
 {
 	unsigned long prev_state_val = id | DESC_COMMIT_MASK;
 	struct prb_desc *d = to_desc(desc_ring, id);
-	bool is_final;
 
-	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
-						prev_state_val | DESC_FINAL_MASK)) {
+	/*
+	 * Failure is perfectly fine. It might happen when the descriptor
+	 * is in the following states:
+	 *
+	 *  + reserved: will be finalized in the related prb_commit()
+	 *  + committed: already finalized
+	 *  + reusable: already finalized and invalidated
+	 *  + misc: already finalized and reused again
+	 */
+	atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
+				prev_state_val | DESC_FINAL_MASK);
 
-		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
-			break;
+}
 
-		if (is_final)
-			break;
-	}
+/*
+ * Finalize the descriptor when it is not the last reserved one.
+ */
+static void desc_check_and_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
+{
+	unsigned long next_prev_id = DESC_ID_PREV_WRAP(desc_ring, id + 1);
+	struct prb_desc *next_prev_d = to_desc(desc_ring, next_prev_id);
+	unsigned long next_prev_state_val;
+	enum desc_state next_prev_d_state;
+
+	/*
+	 * reserved, committed, and reusable states mean that the next desciptor
+	 * is still used for older data from previous wrap.
+	 *
+	 * Note that it is important to check id from the previous wrap. It is
+	 * only way to be sure that the next descripter has not been reused yet.
+	 * Otherwise, the desc ring might have already been reused many times.
+	 */
+	next_prev_state_val = atomic_long_read(&next_prev_d->state_var);
+	next_prev_d_state = get_desc_state(next_prev_id, next_prev_state_val, NULL);
+	if (next_prev_d_state != desc_miss)
+		return;
+
+
+	/*
+	 * desc_miss mean the the next descriptor is already used for newer data
+	 * and this descriptor has to be finalized. It is needed to support
+	 * continuous lines even there is a missing newline.
+	 */
+	desc_finalize(desc_ring, id);
 }
 
 /**
@@ -1432,10 +1465,8 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	}
 
 	/*
-	 * New data is about to be reserved. Once that happens, previous
-	 * descriptors are no longer able to be extended. Finalize the
-	 * previous descriptor now so that it can be made available to
-	 * readers (when committed).
+	 * Try to finalize the previous descriptor. It is needed to make sure
+	 * that it will be finalized even when there is a missing newline.
 	 */
 	desc_finalize(desc_ring, DESC_ID(id - 1));
 
@@ -1501,13 +1532,13 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 }
 
 /* Commit the data (possibly finalizing it) and restore interrupts. */
-static void _prb_commit(struct prb_reserved_entry *e, unsigned long final_mask)
+void prb_commit(struct prb_reserved_entry *e)
 {
 	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
 	struct prb_desc *d = to_desc(desc_ring, e->id);
 	unsigned long prev_state_val = e->id | 0;
 
-	/* Now the writer has finished all writing: LMM(_prb_commit:A) */
+	/* Now the writer has finished all writing: LMM(prb_commit:A) */
 
 	/*
 	 * Set the descriptor as committed. See "ABA Issues" about why
@@ -1518,46 +1549,14 @@ static void _prb_commit(struct prb_reserved_entry *e, unsigned long final_mask)
 	 * this. This pairs with desc_read:B.
 	 */
 	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
-				     e->id | DESC_COMMIT_MASK |
-					     final_mask)) { /* LMM(_prb_commit:B) */
-		/*
-		 * This reserved descriptor must have been finalized already.
-		 * Retry with a reserved+final expected value.
-		 */
-		prev_state_val = e->id | 0 | DESC_FINAL_MASK;
-
-		if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
-					     e->id | DESC_COMMIT_MASK |
-						     DESC_FINAL_MASK)) { /* LMM(_prb_commit:C) */
-			WARN_ON_ONCE(1);
-		}
+				     e->id | DESC_COMMIT_MASK)) { /* LMM(_prb_commit:B) */
+				WARN_ON_ONCE(1);
 	}
 
 	/* Restore interrupts, the reserve/commit window is finished. */
 	local_irq_restore(e->irqflags);
 }
 
-/**
- * prb_commit() - Commit (previously reserved) data to the ringbuffer.
- *
- * @e: The entry containing the reserved data information.
- *
- * This is the public function available to writers to commit data.
- *
- * Note that the data is not yet available to readers until it is finalized.
- * Finalizing happens automatically when space for the next record is
- * reserved.
- *
- * See prb_commit_finalize() for a version of this function that finalizes
- * immediately.
- *
- * Context: Any context. Enables local interrupts.
- */
-void prb_commit(struct prb_reserved_entry *e)
-{
-	_prb_commit(e, 0);
-}
-
 /**
  * prb_commit_finalize() - Commit and finalize (previously reserved) data to
  *                         the ringbuffer.
@@ -1573,9 +1572,32 @@ void prb_commit(struct prb_reserved_entry *e)
  *
  * Context: Any context. Enables local interrupts.
  */
-void prb_commit_finalize(struct prb_reserved_entry *e)
+void prb_final_commit(struct prb_reserved_entry *e)
 {
-	_prb_commit(e, DESC_FINAL_MASK);
+	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
+	struct prb_desc *d = to_desc(desc_ring, e->id);
+	unsigned long prev_state_val = e->id | 0;
+
+	/* Now the writer has finished all writing: LMM(prb_commit:A) */
+
+	/*
+	 * Set the descriptor as committed and final in a single step.
+	 * See "ABA Issues" about why cmpxchg() instead of set() is used.
+	 *
+	 * Guarantee all record data is stored before the descriptor state
+	 * is stored as committed. A write memory barrier is sufficient for
+	 * this. This pairs with desc_read:B.
+	 */
+	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
+				     e->id | DESC_COMMIT_MASK | DESC_FINAL_MASK)) { /* LMM(prb_final_commit:B) */
+		WARN_ON_ONCE(1);
+	}
+
+
+	desc_check_and_finalize(desc_ring, e->id);
+
+	/* Restore interrupts, the reserve/commit window is finished. */
+	local_irq_restore(e->irqflags);
 }
 
 /*
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 8ed1f1f154ec..6fb486ab2bde 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -322,7 +322,7 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 bool prb_reserve_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		      struct printk_record *r, u32 caller_id);
 void prb_commit(struct prb_reserved_entry *e);
-void prb_commit_finalize(struct prb_reserved_entry *e);
+void prb_final_commit(struct prb_reserved_entry *e);
 
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int text_buf_size,
-- 
2.26.2

