Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AFDC433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D036120782
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 01:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4wBZeCXY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJ14ZEO6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgHaBLU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 21:11:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbgHaBLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 21:11:06 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598836262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qIREBAob8PC3lDf5tNq9OgZf0YqSrU4XhpANiuL+gk=;
        b=4wBZeCXY6Y5k7arENCte884f298vZ57/aZoRzvV0oAEwrqxfAqJgXGop5QcpVBz7r0qCJ/
        RFG+i0lGIcVNZzwV7A/amPaW7D3RpUVUN+R+zmmy2iwofgXqWb2hP9rBvSM+T2ZNn2eTMG
        /komVtcMQmWEZa0qDK88iE4F/gHQMuKb8S61px0+TZkE0b4DOO9Huluo7GmHVnmDxlgyK3
        joTaBP+E4la1vtIvoTifZMM5zEexh8y4ClDCe7rpOJ7hseDLYBC9V7djp7qX6IJzij/2De
        bZnMaKTwPweTbn83IH66UI7MI0NowU88cJO071tCFRlGDWFGH3aNhu1W6siLlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598836262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4qIREBAob8PC3lDf5tNq9OgZf0YqSrU4XhpANiuL+gk=;
        b=tJ14ZEO6u2YlWgBQ0qSmkMBiiSpuaM5uHEM8OWP3Rfwgm9k+pkLUJHdhE1BV2dXysTZuq6
        qFQnPgwmmAwCBKBA==
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
Subject: [PATCH next v3 6/8] printk: ringbuffer: add finalization/extension support
Date:   Mon, 31 Aug 2020 03:16:56 +0206
Message-Id: <20200831011058.6286-7-john.ogness@linutronix.de>
In-Reply-To: <20200831011058.6286-1-john.ogness@linutronix.de>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for extending the newest data block. For this, introduce
a new finalization state flag (DESC_FINAL_MASK) that denotes when a
descriptor may not be extended, i.e. is finalized.

The DESC_COMMIT_MASK is still set when the record data is in a
consistent state, i.e. the writer is no longer modifying the record.
However, the record remains in the desc_reserved queried state until
it is finalized, in which case it transitions to the desc_committed
queried state.

Until a record is finalized, a writer can reopen that record to
append new data. Reopening a record means clearing the
DESC_COMMIT_MASK flag.

A writer can explicitly finalize a record if there is no intention
of extending it. Also, records are automatically finalized when a
new record is reserved. This relieves writers of needing to
explicitly finalize while also making such records available to
readers sooner. (Readers can only traverse finalized records.)

Three new memory barrier pairs are introduced. Two of them are not
significant because they are alternate path memory barriers that
exactly correspond to existing memory barriers.

But the third (_prb_commit:B / desc_reserve:D) is new and guarantees
that descriptors will always be finalized, either because a
descriptor setting DESC_COMMIT_MASK sees that there is a newer
descriptor and so finalizes itself or because a new descriptor being
reserved sees that the previous descriptor has DESC_COMMIT_MASK set
and finalizes that descriptor.

Signed-off-by: John Ogness <john.ogness@linutronix.de>
---
 kernel/printk/printk_ringbuffer.c | 467 ++++++++++++++++++++++++++++--
 kernel/printk/printk_ringbuffer.h |   8 +-
 2 files changed, 443 insertions(+), 32 deletions(-)

diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
index da54d4fadf96..0731d5e2dddd 100644
--- a/kernel/printk/printk_ringbuffer.c
+++ b/kernel/printk/printk_ringbuffer.c
@@ -49,14 +49,16 @@
  * Descriptors have three states:
  *
  *   reserved
- *     A writer is modifying the record.
+ *     A writer is modifying the record. Internally represented as either "0"
+ *     or "DESC_COMMIT_MASK".
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
@@ -79,6 +81,25 @@
  * committed or reusable queried state. This makes it possible that a valid
  * sequence number of the tail is always available.
  *
+ * Descriptor Finalization
+ * ~~~~~~~~~~~~~~~~~~~~~~~
+ * When a writer calls the commit function prb_commit(), the record may still
+ * continue to be in the reserved queried state. In order for that record to
+ * enter into the committed queried state, that record also must be finalized.
+ * A record can be finalized by three different scenarios:
+ *
+ *   1) A writer can finalize its record immediately by calling
+ *      prb_final_commit() instead of prb_commit().
+ *
+ *   2) When a new record is reserved and the previous record has been
+ *      committed via prb_commit(), that previous record is finalized.
+ *
+ *   3) When a record is committed via prb_commit() and a newer record
+ *      already exists, the record being committed is finalized.
+ *
+ * Until a record is finalized (represented by "DESC_FINAL_MASK"), a writer
+ * may "reopen" that record and extend it with more data.
+ *
  * Data Rings
  * ~~~~~~~~~~
  * The two data rings (text and dictionary) function identically. They exist
@@ -156,9 +177,38 @@
  *
  *		r.info->ts_nsec = local_clock();
  *
+ *		prb_final_commit(&e);
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
+ *	if (prb_reserve_in_last(&e, &test_rb, &r, printk_caller_id())) {
+ *		snprintf(&r.text_buf[r.info->text_len],
+ *			 r.text_buf_size - r.info->text_len, "hello");
+ *
+ *		r.info->text_len += 5;
+ *
+ *		prb_final_commit(&e);
+ *	}
+ *
  * Sample reader code::
  *
  *	struct printk_info info;
@@ -236,14 +286,20 @@
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
- *     store writer changes, then set new descriptor committed (state)
+ *   _prb_commit:B / desc_read:B
+ *     store writer changes, then set new descriptor commit flag (state)
+ *
+ *   desc_reopen_last:A / _prb_commit:B
+ *     store removed descriptor commit flag (state), then read descriptor data
+ *
+ *   _prb_commit:B / desc_reserve:D
+ *     set new descriptor commit flag (state), then check descriptor head (id)
  *
  *   data_push_tail:D / data_push_tail:A
  *     set descriptor reusable (state), then push data tail (lpos)
@@ -366,8 +422,10 @@ static enum desc_state get_desc_state(unsigned long id,
 	if (state_val & DESC_REUSE_MASK)
 		return desc_reusable;
 
-	if (state_val & DESC_COMMIT_MASK)
+	if ((state_val & (DESC_COMMIT_MASK | DESC_FINAL_MASK)) ==
+	    (DESC_COMMIT_MASK | DESC_FINAL_MASK)) {
 		return desc_committed;
+	}
 
 	return desc_reserved;
 }
@@ -394,16 +452,16 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	/*
 	 * Guarantee the state is loaded before copying the descriptor
 	 * content. This avoids copying obsolete descriptor content that might
-	 * not apply to the descriptor state. This pairs with prb_commit:B.
+	 * not apply to the descriptor state. This pairs with _prb_commit:B.
 	 *
 	 * Memory barrier involvement:
 	 *
-	 * If desc_read:A reads from prb_commit:B, then desc_read:C reads
-	 * from prb_commit:A.
+	 * If desc_read:A reads from _prb_commit:B, then desc_read:C reads
+	 * from _prb_commit:A.
 	 *
 	 * Relies on:
 	 *
-	 * WMB from prb_commit:A to prb_commit:B
+	 * WMB from _prb_commit:A to _prb_commit:B
 	 *    matching
 	 * RMB from desc_read:A to desc_read:C
 	 */
@@ -434,7 +492,8 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 	 *
 	 * 2. Guarantee the record data is loaded before re-checking the
 	 *    state. This avoids reading an obsolete descriptor state that may
-	 *    not apply to the copied data. This pairs with data_alloc:A.
+	 *    not apply to the copied data. This pairs with data_alloc:A and
+	 *    data_realloc:A.
 	 *
 	 *    Memory barrier involvement:
 	 *
@@ -467,7 +526,7 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
 static void desc_make_reusable(struct prb_desc_ring *desc_ring,
 			       unsigned long id)
 {
-	unsigned long val_committed = id | DESC_COMMIT_MASK;
+	unsigned long val_committed = id | DESC_COMMIT_MASK | DESC_FINAL_MASK;
 	unsigned long val_reusable = id | DESC_REUSE_MASK;
 	struct prb_desc *desc = to_desc(desc_ring, id);
 	atomic_long_t *state_var = &desc->state_var;
@@ -613,7 +672,7 @@ static bool data_push_tail(struct printk_ringbuffer *rb,
 			 *    data_make_reusable() may be due to a newly
 			 *    recycled data area causing the tail lpos to
 			 *    have been previously pushed. This pairs with
-			 *    data_alloc:A.
+			 *    data_alloc:A and data_realloc:A.
 			 *
 			 *    Memory barrier involvement:
 			 *
@@ -892,6 +951,10 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
 		 *    another CPU may have pushed the tail ID. This pairs
 		 *    with desc_push_tail:C and this also pairs with
 		 *    prb_first_seq:C.
+		 *
+		 * 5. Guarantee the head ID is stored before trying to
+		 *    finalize the previous descriptor. This pairs with
+		 *    _prb_commit:B.
 		 */
 	} while (!atomic_long_try_cmpxchg(&desc_ring->head_id, &head_id,
 					  id)); /* LMM(desc_reserve:D) */
@@ -1021,6 +1084,83 @@ static char *data_alloc(struct printk_ringbuffer *rb,
 	return &blk->data[0];
 }
 
+/*
+ * Try to resize an existing data block associated with the descriptor
+ * specified by @id. If the resized datablock should become wrapped, it
+ * copies the old data to the new data block.
+ *
+ * Fail if this is not the last allocated data block or if there is not
+ * enough space or it is not possible make enough space.
+ *
+ * Return a pointer to the beginning of the entire data buffer or NULL on
+ * failure.
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
@@ -1101,6 +1241,203 @@ static const char *get_data(struct prb_data_ring *data_ring,
 	return &db->data[0];
 }
 
+/*
+ * Attempt to remove the commit flag so that the record can be modified by a
+ * writer again. This is only possible if the descriptor is not yet finalized.
+ *
+ * Note that on success, the queried state did not change. A non-finalized
+ * record (even with the commit flag set) is in the reserved queried state.
+ */
+static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
+					 u32 caller_id, unsigned long *id_out)
+{
+	unsigned long prev_state_val;
+	enum desc_state d_state;
+	struct prb_desc desc;
+	struct prb_desc *d;
+	unsigned long id;
+
+	id = atomic_long_read(&desc_ring->head_id);
+
+	/*
+	 * To minimize unnecessarily reopening a descriptor, first check the
+	 * descriptor is in the correct state and has a matching caller ID.
+	 */
+	d_state = desc_read(desc_ring, id, &desc);
+	if (d_state != desc_reserved ||
+	    !(atomic_long_read(&desc.state_var) & DESC_COMMIT_MASK) ||
+	    desc.info.caller_id != caller_id) {
+		return NULL;
+	}
+
+	d = to_desc(desc_ring, id);
+
+	prev_state_val = id | DESC_COMMIT_MASK;
+
+	/*
+	 * Guarantee the commit flag is removed from the state before
+	 * reading any record data. A full memory barrier is needed
+	 * because @state_var is modified for the read. This pairs with
+	 * _prb_commit:B.
+	 *
+	 * Memory barrier involvement:
+	 *
+	 * If desc_reopen_last:A reads from _prb_commit:B, then
+	 * prb_reserve_in_last:A reads from _prb_commit:A.
+	 *
+	 * Relies on:
+	 *
+	 * WMB from _prb_commit:A to _prb_commit:B
+	 *    matching
+	 * MB If desc_reopen_last:A to prb_reserve_in_last:A
+	 */
+	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
+				     id | 0)) { /* LMM(desc_reopen_last:A) */
+		return NULL;
+	}
+
+	*id_out = id;
+	return d;
+}
+
+/**
+ * prb_reserve_in_last() - Re-reserve and extend the space in the ringbuffer
+ *                         used by the newest record.
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
+ * On success:
+ *
+ *   - @r->text_buf points to the beginning of the entire text buffer.
+ *
+ *   - @r->text_buf_len is set to the new total size of the buffer.
+ *
+ *   - @r->dict_buf and @r->dict_buf_len are cleared because extending
+ *     the dict buffer is not supported.
+ *
+ *   - @r->info is not touched so that @r->info->text_len could be used
+ *     to append the text.
+ *
+ *   - prb_record_text_space() can be used on @e to query the new
+ *     actually used space.
+ *
+ * Important: All @r->info fields will already be set with the current values
+ *            for the record. I.e. @r->info->text_len will be less than
+ *            @text_buf_size and @r->info->dict_len may be set, even though
+ *            @dict_buf_size is 0. Writers can use @r->info->text_len to know
+ *            where concatenation begins and writers should update
+ *            @r->info->text_len after concatenating.
+ */
+bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+			 struct printk_record *r, u32 caller_id)
+{
+	unsigned int data_size;
+	struct prb_desc *d;
+	unsigned long id;
+
+	local_irq_save(e->irqflags);
+
+	/* Transition the newest descriptor back to the reserved state. */
+	d = desc_reopen_last(&rb->desc_ring, caller_id, &id);
+	if (!d) {
+		local_irq_restore(e->irqflags);
+		goto fail_reopen;
+	}
+
+	/* Now the writer has exclusive access: LMM(prb_reserve_in_last:A) */
+
+	/*
+	 * Set the @e fields here so that prb_commit() can be used if
+	 * anything fails from now on.
+	 */
+	e->rb = rb;
+	e->id = id;
+
+	/*
+	 * desc_reopen_last() checked the caller_id, but there was no
+	 * exclusive access at that point. The descriptor may have
+	 * changed since then.
+	 */
+	if (caller_id != d->info.caller_id)
+		goto fail;
+
+	if (BLK_DATALESS(&d->text_blk_lpos)) {
+		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
+					 &d->text_blk_lpos, id);
+	} else {
+		if (!get_data(&rb->text_data_ring, &d->text_blk_lpos, &data_size))
+			goto fail;
+
+		/*
+		 * Increase the buffer size to include the original size. If
+		 * the meta data (@text_len) is not sane, use the full data
+		 * block size.
+		 */
+		if (WARN_ON_ONCE(d->info.text_len > data_size)) {
+			pr_warn_once("wrong data size (%u, expecting >=%hu) for data\n",
+				     data_size, d->info.text_len);
+			d->info.text_len = data_size;
+		}
+		r->text_buf_size += d->info.text_len;
+
+		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
+			goto fail;
+
+		r->text_buf = data_realloc(rb, &rb->text_data_ring, r->text_buf_size,
+					   &d->text_blk_lpos, id);
+	}
+	if (r->text_buf_size && !r->text_buf)
+		goto fail;
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
+	prb_commit(e);
+	/* prb_commit() re-enabled interrupts. */
+fail_reopen:
+	/* Make it clear to the caller that the re-reserve failed. */
+	memset(r, 0, sizeof(*r));
+	return false;
+}
+
+/*
+ * Attempt to finalize a specified descriptor. If this fails, the descriptor
+ * is either already final or it will finalize itself when the writer commits.
+ */
+static void desc_make_final(struct prb_desc_ring *desc_ring, unsigned long id)
+{
+	unsigned long prev_state_val = id | DESC_COMMIT_MASK;
+	struct prb_desc *d = to_desc(desc_ring, id);
+
+	atomic_long_cmpxchg_relaxed(&d->state_var, prev_state_val,
+			prev_state_val | DESC_FINAL_MASK); /* LMM(desc_make_final:A) */
+}
+
 /**
  * prb_reserve() - Reserve space in the ringbuffer.
  *
@@ -1197,6 +1534,15 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
 	else
 		d->info.seq += DESCS_COUNT(desc_ring);
 
+	/*
+	 * New data is about to be reserved. Once that happens, previous
+	 * descriptors are no longer able to be extended. Finalize the
+	 * previous descriptor now so that it can be made available to
+	 * readers. (For seq==0 there is no previous descriptor.)
+	 */
+	if (d->info.seq > 0)
+		desc_make_final(desc_ring, DESC_ID(id - 1));
+
 	r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
 				 &d->text_blk_lpos, id);
 	/* If text data allocation fails, a data-less record is committed. */
@@ -1227,33 +1573,41 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
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
 	 * cmpxchg() instead of set() is used.
 	 *
-	 * Guarantee all record data is stored before the descriptor state
-	 * is stored as committed. A write memory barrier is sufficient for
-	 * this. This pairs with desc_read:B.
+	 * 1  Guarantee all record data is stored before the descriptor state
+	 *    is stored as committed. A write memory barrier is sufficient
+	 *    for this. This pairs with desc_read:B and desc_reopen_last:A.
+	 *
+	 * 2. Guarantee the commit flag is stored before re-checking the
+	 *    head ID in order to possibly finalize this descriptor. This
+	 *    pairs with desc_reserve:D.
+	 *
+	 *    Memory barrier involvement:
+	 *
+	 *    If prb_commit:A reads from desc_reserve:D, then
+	 *    desc_make_final:A reads from _prb_commit:B.
+	 *
+	 *    Relies on:
+	 *
+	 *    MB _prb_commit:B to prb_commit:A
+	 *       matching
+	 *    MB desc_reserve:D to desc_make_final:A
 	 */
 	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
-				     e->id | DESC_COMMIT_MASK)) { /* LMM(prb_commit:B) */
+				     e->id | DESC_COMMIT_MASK |
+					     final_mask)) { /* LMM(_prb_commit:B) */
 		WARN_ON_ONCE(1);
 	}
 
@@ -1261,6 +1615,59 @@ void prb_commit(struct prb_reserved_entry *e)
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
+ * See prb_final_commit() for a version of this function that finalizes
+ * immediately.
+ *
+ * Context: Any context. Enables local interrupts.
+ */
+void prb_commit(struct prb_reserved_entry *e)
+{
+	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
+	unsigned long head_id;
+
+	_prb_commit(e, 0);
+
+	/*
+	 * If this descriptor is no longer the head (i.e. a new record has
+	 * been allocated), extending the data for this record is no longer
+	 * allowed and therefore it must be finalized.
+	 */
+	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_commit:A) */
+	if (head_id != e->id)
+		desc_make_final(desc_ring, e->id);
+}
+
+/**
+ * prb_final_commit() - Commit and finalize (previously reserved) data to
+ *                      the ringbuffer.
+ *
+ * @e: The entry containing the reserved data information.
+ *
+ * This is the public function available to writers to commit+finalize data.
+ *
+ * By finalizing, the data is made immediately available to readers.
+ *
+ * This function should only be used if there are no intentions of extending
+ * this data using prb_reserve_in_last().
+ *
+ * Context: Any context. Enables local interrupts.
+ */
+void prb_final_commit(struct prb_reserved_entry *e)
+{
+	_prb_commit(e, DESC_FINAL_MASK);
+}
+
 /*
  * Count the number of lines in provided text. All text has at least 1 line
  * (even if @text_size is 0). Each '\n' processed is counted as an additional
@@ -1312,7 +1719,7 @@ static bool copy_data(struct prb_data_ring *data_ring,
 	 * because of the trailing alignment padding.
 	 */
 	if (WARN_ON_ONCE(data_size < (unsigned int)len)) {
-		pr_warn_once("wrong data size (%u, expecting %hu) for data: %.*s\n",
+		pr_warn_once("wrong data size (%u, expecting >=%hu) for data: %.*s\n",
 			     data_size, len, data_size, data);
 		return false;
 	}
diff --git a/kernel/printk/printk_ringbuffer.h b/kernel/printk/printk_ringbuffer.h
index 96ef997d7bd6..caa6fb40dafb 100644
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
+bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
+			 struct printk_record *r, u32 caller_id);
 void prb_commit(struct prb_reserved_entry *e);
+void prb_final_commit(struct prb_reserved_entry *e);
 
 void prb_init(struct printk_ringbuffer *rb,
 	      char *text_buf, unsigned int text_buf_size,
-- 
2.20.1

