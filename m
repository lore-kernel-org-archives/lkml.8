Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2840C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61D032067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 10:36:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qsvzeKgR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HFj18F+3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHXKgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 06:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbgHXKfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 06:35:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D866BC0613ED
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 03:35:43 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598265342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu6xduPdX6VNffFAGRJvtjcVHzOx2C0w8rMpE+KAEys=;
        b=qsvzeKgRsInftYtlKQ0Vd3lBd63gLM4bUC7E6jAv4/zAXDFNiM3GLa/hwypn7kTNmF0T8/
        JbCqLyBab6sYlpgTbec/A6zAbebVv+DsUFuXr2dSYzwAoYG+UhC7qJ8LNv15c+gAiU1tik
        Or05c4IT+1hdw5T/oTZVkabqjZMRFXJF7Dh3FAK2K5PQDFdmsCm++OC7L1+smVoXMhgu0e
        3sQZlU5dSY/KsiSt1EiCjtwHEkz/K9H0FZlBITEzyaCiRpIfo6x5KSRtONH2ILfLaBMNuy
        NnWQsQnJGwht43gdGOLZvR1HnCMZwNU3e4RfoOthu/qnIhbeejuBnPkbQLa5hw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598265342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Bu6xduPdX6VNffFAGRJvtjcVHzOx2C0w8rMpE+KAEys=;
        b=HFj18F+3Gcm+aerOPstEzYykqVeQmGSX5lj8DnvxJxWkJDvaJYAAZ/U4XQuGwqdeJhLd4M
        Urj8YRXdjkRsORCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7][next] printk: ringbuffer: add finalization/extension support
Date:   Mon, 24 Aug 2020 12:41:36 +0206
Message-Id: <20200824103538.31446-6-john.ogness@linutronix.de>
In-Reply-To: <20200824103538.31446-1-john.ogness@linutronix.de>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for extending the last data block. For this, introduce a new
finalization state flag that identifies if a descriptor may be extended.

When a writer calls the commit function prb_commit(), the record may still
continue to be in the reserved queried state. In order for that record to
enter into the committed queried state, that record also must be finalized.
Finalization can occur anytime while the record is in the reserved queried
state, even before the writer has called prb_commit().

Until a record is finalized (represented by "DESC_FINAL_MASK"), a writer
may "reopen" that record and extend it with more data.

Note that existing descriptors are automatically finalized whenever new
descriptors are created. A record can never be "unfinalized".

Two new memory barrier pairs are introduced, but these are really just
alternate path barriers that exactly correspond to existing memory
barriers.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk.c            |   4 +-
 kernel/printk/printk_ringbuffer.c | 386 +++++++++++++++++++++++++++---
 kernel/printk/printk_ringbuffer.h |   8 +-
 3 files changed, 364 insertions(+), 34 deletions(-)

diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index ad8d1dfe5fbe..e063edd8adc2 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -532,7 +532,7 @@ static int log_store(u32 caller_id, int facility, int level,
 	r.info->caller_id = caller_id;
 
 	/* insert message */
-	prb_commit(&e);
+	prb_commit_finalize(&e);
 
 	return (text_len + trunc_msg_len);
 }
@@ -1088,7 +1088,7 @@ static unsigned int __init add_to_rb(struct printk_ringbuffer *rb,
 	dest_r.info->ts_nsec = r->info->ts_nsec;
 	dest_r.info->caller_id = r->info->caller_id;
 
-	prb_commit(&e);
+	prb_commit_finalize(&e);
 
 	return prb_record_text_space(&e);
 }
diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index d66718e74aae..90d48973ac9e 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -49,14 +49,16 @@
  * Descriptors have three states:
  *
  *   reserved
- *     A writer is modifying the record.
+ *     A writer is modifying the record. Internally represented as either "0"
+ *     or "DESC_FINAL_MASK" or "DESC_COMMIT_MASK".
  *
  *   committed
  *     The record and all its data are complete and available for reading.
+ *     Internally represented as "DESC_COMMIT_MASK | DESC_FINAL_MASK".
  *
  *   reusable
  *     The record exists, but its text and/or dictionary data may no longer
- *     be available.
+ *     be available. Internally represented as "DESC_REUSE_MASK".
  *
  * Querying the @state_var of a record requires providing the ID of the
  * descriptor to query. This can yield a possible fourth (pseudo) state:
@@ -79,6 +81,20 @@
  * committed or reusable queried state. This makes it possible that a valid
  * sequence number of the tail is always available.
  *
+ * Descriptor Finalization
+ * ~~~~~~~~~~~~~~~~~~~~~~~
+ * When a writer calls the commit function prb_commit(), the record may still
+ * continue to be in the reserved queried state. In order for that record to
+ * enter into the committed queried state, that record also must be finalized.
+ * Finalization can occur anytime while the record is in the reserved queried
+ * state, even before the writer has called prb_commit().
+ *
+ * Until a record is finalized (represented by "DESC_FINAL_MASK"), a writer
+ * may "reopen" that record and extend it with more data.
+ *
+ * Note that existing descriptors are automatically finalized whenever new
+ * descriptors are created. A record can never be "unfinalized".
+ *
  * Data Rings
  * ~~~~~~~~~~
  * The two data rings (text and dictionary) function identically. They exist
@@ -153,9 +169,38 @@
  *
  *		r.info->ts_nsec = local_clock();
  *
+ *		prb_commit_finalize(&e);
+ *	}
+ *
+ * Note that additional writer functions are available to extend a record
+ * after it has been committed but not yet finalized. This can be done as
+ * long as no new records have been reserved and the caller is the same.
+ *
+ * Sample writer code (record extending)::
+ *
+ *		// alternate rest of previous example
+ *		r.info->ts_nsec = local_clock();
+ *		r.info->text_len = strlen(textstr);
+ *		r.info->caller_id = printk_caller_id();
+ *
+ *		// commit the record (but do not finalize yet)
  *		prb_commit(&e);
  *	}
  *
+ *	...
+ *
+ *	// specify additional 5 bytes text space to extend
+ *	prb_rec_init_wr(&r, 5, 0);
+ *
+ *	if (prb_reserve_last(&e, &test_rb, &r, printk_caller_id())) {
+ *		snprintf(&r.text_buf[r.info->text_len],
+ *			 r.text_buf_size - r.info->text_len, "hello");
+ *
+ *		r.info->text_len += 5;
+ *
+ *		prb_commit_finalize(&e);
+ *	}
+ *
  * Sample reader code::
  *
  *	struct printk_info info;
@@ -233,13 +278,13 @@
  *   desc_reserve:F / desc_read:D
  *     set new descriptor id and reserved (state), then allow writer changes
  *
- *   data_alloc:A / desc_read:D
+ *   data_alloc:A (or data_realloc:A) / desc_read:D
  *     set old descriptor reusable (state), then modify new data block area
  *
- *   data_alloc:A / data_push_tail:B
+ *   data_alloc:A (or data_realloc:A) / data_push_tail:B
  *     push data tail (lpos), then modify new data block area
  *
- *   prb_commit:B / desc_read:B
+ *   _prb_commit:B (or _prb_commit:C) / desc_read:B
  *     store writer changes, then set new descriptor committed (state)
  *
  *   data_push_tail:D / data_push_tail:A
@@ -355,16 +400,22 @@ enum desc_state {
 
 /* Query the state of a descriptor. */
 static enum desc_state get_desc_state(unsigned long id,
-				      unsigned long state_val)
+				      unsigned long state_val,
+				      bool *is_final)
 {
+	if (is_final)
+		*is_final = state_val & DESC_FINAL_MASK;
+
 	if (id != DESC_ID(state_val))
 		return desc_miss;
 
 	if (state_val & DESC_REUSE_MASK)
 		return desc_reusable;
 
-	if (state_val & DESC_COMMIT_MASK)
+	if ((state_val & (DESC_COMMIT_MASK | DESC_FINAL_MASK)) ==
+	    (DESC_COMMIT_MASK | DESC_FINAL_MASK)) {
 		return desc_committed;
+	}
 
 	return desc_reserved;
 }
@@ -384,23 +435,24 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 
 	/* Check the descriptor state. */
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:A) */
-	d_state = get_desc_state(id, state_val);
+	d_state = get_desc_state(id, state_val, NULL);
 	if (d_state != desc_committed && d_state != desc_reusable)
 		return d_state;
 
 	/*
 	 * Guarantee the state is loaded before copying the descriptor
 	 * content. This avoids copying obsolete descriptor content that might
-	 * not apply to the descriptor state. This pairs with prb_commit:B.
+	 * not apply to the descriptor state. This pairs with _prb_commit:B
+	 * and _prb_commit:C.
 	 *
 	 * Memory barrier involvement:
 	 *
-	 * If desc_read:A reads from prb_commit:B, then desc_read:C reads
-	 * from prb_commit:A.
+	 * If desc_read:A reads from _prb_commit:B or _prb_commit:C, then
+	 * desc_read:C reads from _prb_commit:A.
 	 *
 	 * Relies on:
 	 *
-	 * WMB from prb_commit:A to prb_commit:B
+	 * WMB from _prb_commit:A to (_prb_commit:B or _prb_commit:C)
 	 *    matching
 	 * RMB from desc_read:A to desc_read:C
 	 */
@@ -431,7 +483,8 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	 *
 	 * 2. Guarantee the record data is loaded before re-checking the
 	 *    state. This avoids reading an obsolete descriptor state that may
-	 *    not apply to the copied data. This pairs with data_alloc:A.
+	 *    not apply to the copied data. This pairs with data_alloc:A and
+	 *    data_realloc:A.
 	 *
 	 *    Memory barrier involvement:
 	 *
@@ -453,7 +506,7 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 
 	/* Re-check the descriptor state. */
 	state_val = atomic_long_read(state_var); /* LMM(desc_read:E) */
-	return get_desc_state(id, state_val);
+	return get_desc_state(id, state_val, NULL);
 }
 
 /*
@@ -464,7 +517,7 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 			       unsigned long id)
 {
-	unsigned long val_committed = id | DESC_COMMIT_MASK;
+	unsigned long val_committed = id | DESC_COMMIT_MASK | DESC_FINAL_MASK;
 	unsigned long val_reusable = id | DESC_REUSE_MASK;
 	struct prb_desc *desc = to_desc(desc_ring, id);
 	atomic_long_t *state_var = &desc->state_var;
@@ -610,7 +663,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb,
 			 *    data_make_reusable() may be due to a newly
 			 *    recycled data area causing the tail lpos to
 			 *    have been previously pushed. This pairs with
-			 *    data_alloc:A.
+			 *    data_alloc:A and data_realloc:A.
 			 *
 			 *    Memory barrier involvement:
 			 *
@@ -901,7 +954,7 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 	 */
 	prev_state_val = atomic_long_read(&desc->state_var); /* LMM(desc_reserve:E) */
 	if (prev_state_val &&
-	    get_desc_state(id_prev_wrap, prev_state_val) != desc_reusable) {
+	    get_desc_state(id_prev_wrap, prev_state_val, NULL) != desc_reusable) {
 		WARN_ON_ONCE(1);
 		return false;
 	}
@@ -1018,6 +1071,77 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 	return &blk->data[0];
 }
 
+/*
+ * Extend the allocation of a specified data block, invalidating the oldest
+ * data block(s) if necessary. This function also associates the data block
+ * with a specified descriptor.
+ */
+static char *data_realloc(struct printk_ringbuffer *rb,
+			  struct prb_data_ring *data_ring, unsigned int size,
+			  struct prb_data_blk_lpos *blk_lpos, unsigned long id)
+{
+	struct prb_data_block *blk;
+	unsigned long head_lpos;
+	unsigned long next_lpos;
+	bool wrapped;
+
+	/* Reallocation only works if @blk_lpos is the newest data block. */
+	head_lpos = atomic_long_read(&data_ring->head_lpos);
+	if (head_lpos != blk_lpos->next)
+		return NULL;
+
+	/* Keep track if @blk_lpos was a wrapping data block. */
+	wrapped = (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, blk_lpos->next));
+
+	size = to_blk_size(size);
+
+	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
+
+	/* If the data block does not increase, there is nothing to do. */
+	if (next_lpos == head_lpos) {
+		blk = to_block(data_ring, blk_lpos->begin);
+		return &blk->data[0];
+	}
+
+	if (!data_push_tail(rb, data_ring, next_lpos - DATA_SIZE(data_ring)))
+		return NULL;
+
+	/* The memory barrier involvement is the same as data_alloc:A. */
+	if (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &head_lpos,
+				     next_lpos)) { /* LMM(data_realloc:A) */
+		return NULL;
+	}
+
+	blk = to_block(data_ring, blk_lpos->begin);
+
+	if (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, next_lpos)) {
+		struct prb_data_block *old_blk = blk;
+
+		/* Wrapping data blocks store their data at the beginning. */
+		blk = to_block(data_ring, 0);
+
+		/*
+		 * Store the ID on the wrapped block for consistency.
+		 * The printk_ringbuffer does not actually use it.
+		 */
+		blk->id = id;
+
+		if (!wrapped) {
+			/*
+			 * Since the allocated space is now in the newly
+			 * created wrapping data block, copy the content
+			 * from the old data block.
+			 */
+			memcpy(&blk->data[0], &old_blk->data[0],
+			       (blk_lpos->next - blk_lpos->begin) - sizeof(blk->id));
+		}
+	}
+
+	blk_lpos->next = next_lpos;
+
+	return &blk->data[0];
+}
+
 /* Return the number of bytes used by a data block. */
 static unsigned int space_used(struct prb_data_ring *data_ring,
 			       struct prb_data_blk_lpos *blk_lpos)
@@ -1098,6 +1222,156 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	return &db->data[0];
 }
 
+/*
+ * Attempt to move the head descriptor back to the reserved state. This is
+ * only possible if the descriptor is in the commit+!final state.
+ */
+static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
+					 unsigned long *id_out)
+{
+	unsigned long prev_state_val;
+	struct prb_desc *d;
+	unsigned long id;
+
+	id = atomic_long_read(&desc_ring->head_id);
+
+	d = to_desc(desc_ring, id);
+
+	prev_state_val = id | DESC_COMMIT_MASK;
+	if (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val, id | 0))
+		return NULL;
+
+	*id_out = id;
+	return d;
+}
+
+/**
+ * prb_reserve_last() - Re-reserve and extend the space in the ringbuffer used
+ *                      by the newest record.
+ *
+ * @e:         The entry structure to setup.
+ * @rb:        The ringbuffer to re-reserve and extend data in.
+ * @r:         The record structure to allocate buffers for.
+ * @caller_id: The caller ID of the caller (reserving writer).
+ *
+ * This is the public function available to writers to re-reserve and extend
+ * data.
+ *
+ * The writer specifies the text size to extend (not the new total size) by
+ * setting the @text_buf_size field of @r. Dictionaries cannot be extended so
+ * @dict_buf_size of @r should be set to 0. To ensure proper initialization of
+ * @r, prb_rec_init_wr() should be used.
+ *
+ * This function will fail if @caller_id does not match the caller ID of the
+ * newest record. In that case the caller must reserve new data using
+ * prb_reserve().
+ *
+ * Context: Any context. Disables local interrupts on success.
+ * Return: true if text data could be extended, otherwise false.
+ *
+ * On success, the fields @info, @text_buf, @dict_buf of @r will be set by
+ * this function (@dict_buf is always set to NULL.) Also on success, the field
+ * @text_buf_size of @r is set to the new total size (@dict_buf_size is always
+ * set to 0). Also on success prb_record_text_space() can be used on @e to
+ * query the actual space used for the newly extended text data block.
+ *
+ * Important: All @info fields will already be set with the current values for
+ *            the record. I.e. @info->text_len will be less than @text_buf_size
+ *            and @info->dict_len may be set, even though @dict_buf_size is 0.
+ *            Writers can use @info->text_len to know where concatenation
+ *            begins and writers should update @info->text_len after
+ *            concatenating.
+ */
+bool prb_reserve_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		      struct printk_record *r, u32 caller_id)
+{
+	unsigned int data_size;
+	struct prb_desc *d;
+	unsigned long id;
+
+	local_irq_save(e->irqflags);
+
+	/* Transition the newest descriptor back to the reserved state. */
+	d = desc_reopen_last(&rb->desc_ring, &id);
+	if (!d) {
+		local_irq_restore(e->irqflags);
+		goto fail;
+	}
+
+	/* Back in the reserved state, exclusive access is guaranteed. */
+
+	/*
+	 * Set the @e fields here so that prb_commit() can be used if
+	 * anything fails from now on.
+	 */
+	e->rb = rb;
+	e->id = id;
+
+	if (caller_id != d->info.caller_id) {
+		prb_commit(e);
+		/* prb_commit() re-enabled interrupts. */
+		goto fail;
+	}
+
+	if (BLK_DATALESS(&d->text_blk_lpos)) {
+		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
+					 &d->text_blk_lpos, id);
+	} else {
+		if (!get_data(&rb->text_data_ring, &d->text_blk_lpos, &data_size)) {
+			prb_commit(e);
+			/* prb_commit() re-enabled interrupts. */
+			goto fail;
+		}
+		/* Use the size from the meta data (if it is sane). */
+		if (d->info.text_len < data_size)
+			data_size = d->info.text_len;
+		r->text_buf_size += data_size;
+		r->text_buf = data_realloc(rb, &rb->text_data_ring, r->text_buf_size,
+					   &d->text_blk_lpos, id);
+	}
+	if (r->text_buf_size && !r->text_buf) {
+		prb_commit(e);
+		/* prb_commit() re-enabled interrupts. */
+		goto fail;
+	}
+
+	/* Although dictionary data may be in use, it cannot be extended. */
+	r->dict_buf = NULL;
+	r->dict_buf_size = 0;
+
+	r->info = &d->info;
+
+	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
+
+	return true;
+fail:
+	/* Make it clear to the caller that the re-reserve failed. */
+	memset(r, 0, sizeof(*r));
+	return false;
+}
+
+/*
+ * Attempt to finalize a specified descriptor. Finalization only happens if
+ * the descriptor is in the !final or commit+!final state, both of which
+ * yield a state query result of desc_reserved.
+ */
+static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
+{
+	unsigned long prev_state_val = id | DESC_COMMIT_MASK;
+	struct prb_desc *d = to_desc(desc_ring, id);
+	bool is_final;
+
+	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
+						prev_state_val | DESC_FINAL_MASK)) {
+
+		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
+			break;
+
+		if (is_final)
+			break;
+	}
+}
+
 /**
  * prb_reserve() - Reserve space in the ringbuffer.
  *
@@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		goto fail;
 	}
 
+	/*
+	 * New data is about to be reserved. Once that happens, previous
+	 * descriptors are no longer able to be extended. Finalize the
+	 * previous descriptor now so that it can be made available to
+	 * readers (when committed).
+	 */
+	desc_finalize(desc_ring, DESC_ID(id - 1));
+
 	d = to_desc(desc_ring, id);
 
 	/*
@@ -1218,22 +1500,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	return false;
 }
 
-/**
- * prb_commit() - Commit (previously reserved) data to the ringbuffer.
- *
- * @e: The entry containing the reserved data information.
- *
- * This is the public function available to writers to commit data.
- *
- * Context: Any context. Enables local interrupts.
- */
-void prb_commit(struct prb_reserved_entry *e)
+/* Commit the data (possibly finalizing it) and restore interrupts. */
+static void _prb_commit(struct prb_reserved_entry *e, unsigned long final_mask)
 {
 	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
 	struct prb_desc *d = to_desc(desc_ring, e->id);
 	unsigned long prev_state_val = e->id | 0;
 
-	/* Now the writer has finished all writing: LMM(prb_commit:A) */
+	/* Now the writer has finished all writing: LMM(_prb_commit:A) */
 
 	/*
 	 * Set the descriptor as committed. See "ABA Issues" about why
@@ -1244,14 +1518,66 @@ void prb_commit(struct prb_reserved_entry *e)
 	 * this. This pairs with desc_read:B.
 	 */
 	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
-				     e->id | DESC_COMMIT_MASK)) { /* LMM(prb_commit:B) */
-		WARN_ON_ONCE(1);
+				     e->id | DESC_COMMIT_MASK |
+					     final_mask)) { /* LMM(_prb_commit:B) */
+		/*
+		 * This reserved descriptor must have been finalized already.
+		 * Retry with a reserved+final expected value.
+		 */
+		prev_state_val = e->id | 0 | DESC_FINAL_MASK;
+
+		if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
+					     e->id | DESC_COMMIT_MASK |
+						     DESC_FINAL_MASK)) { /* LMM(_prb_commit:C) */
+			WARN_ON_ONCE(1);
+		}
 	}
 
 	/* Restore interrupts, the reserve/commit window is finished. */
 	local_irq_restore(e->irqflags);
 }
 
+/**
+ * prb_commit() - Commit (previously reserved) data to the ringbuffer.
+ *
+ * @e: The entry containing the reserved data information.
+ *
+ * This is the public function available to writers to commit data.
+ *
+ * Note that the data is not yet available to readers until it is finalized.
+ * Finalizing happens automatically when space for the next record is
+ * reserved.
+ *
+ * See prb_commit_finalize() for a version of this function that finalizes
+ * immediately.
+ *
+ * Context: Any context. Enables local interrupts.
+ */
+void prb_commit(struct prb_reserved_entry *e)
+{
+	_prb_commit(e, 0);
+}
+
+/**
+ * prb_commit_finalize() - Commit and finalize (previously reserved) data to
+ *                         the ringbuffer.
+ *
+ * @e: The entry containing the reserved data information.
+ *
+ * This is the public function available to writers to commit+finalize data.
+ *
+ * By finalizing, the data is made immediately available to readers.
+ *
+ * This function should only be used if there are no intentions of extending
+ * this data using prb_reserve_last().
+ *
+ * Context: Any context. Enables local interrupts.
+ */
+void prb_commit_finalize(struct prb_reserved_entry *e)
+{
+	_prb_commit(e, DESC_FINAL_MASK);
+}
+
 /*
  * Count the number of lines in provided text. All text has at least 1 line
  * (even if @text_size is 0). Each '\n' processed is counted as an additional
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 96ef997d7bd6..8ed1f1f154ec 100644
--- a/kernel/printk/printk_ringbuffer.h
+++ b/kernel/printk/printk_ringbuffer.h
@@ -116,8 +116,9 @@ struct prb_reserved_entry {
 #define _DESCS_COUNT(ct_bits)		(1U << (ct_bits))
 #define DESC_SV_BITS			(sizeof(unsigned long) * 8)
 #define DESC_COMMIT_MASK		(1UL << (DESC_SV_BITS - 1))
-#define DESC_REUSE_MASK			(1UL << (DESC_SV_BITS - 2))
-#define DESC_FLAGS_MASK			(DESC_COMMIT_MASK | DESC_REUSE_MASK)
+#define DESC_FINAL_MASK			(1UL << (DESC_SV_BITS - 2))
+#define DESC_REUSE_MASK			(1UL << (DESC_SV_BITS - 3))
+#define DESC_FLAGS_MASK			(DESC_COMMIT_MASK | DESC_FINAL_MASK | DESC_REUSE_MASK)
 #define DESC_ID_MASK			(~DESC_FLAGS_MASK)
 #define DESC_ID(sv)			((sv) & DESC_ID_MASK)
 #define FAILED_LPOS			0x1
@@ -318,7 +319,10 @@ static inline void prb_rec_init_wr(struct printk_record *r,
 
 bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 		 struct printk_record *r);
+bool prb_reserve_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+		      struct printk_record *r, u32 caller_id);
 void prb_commit(struct prb_reserved_entry *e);
+void prb_commit_finalize(struct prb_reserved_entry *e);
 
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int text_buf_size,
-- 
2.20.1

