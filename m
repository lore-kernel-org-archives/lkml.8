Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEE7C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:46:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00800206B5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 15:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgIIPq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 11:46:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:53028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730433AbgIIPnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:43:47 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2864BAE4B;
        Wed,  9 Sep 2020 15:23:15 +0000 (UTC)
Date:   Wed, 9 Sep 2020 17:22:58 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
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
Subject: Re: [PATCH printk v4 5/6] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200909152258.GG3864@alley>
References: <20200908202859.2736-1-john.ogness@linutronix.de>
 <20200908202859.2736-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908202859.2736-6-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-09-08 22:34:58, John Ogness wrote:
> Add support for extending the newest data block. For this, introduce
> a new finalization state (desc_finalized) denoting a committed
> descriptor that cannot be extended.
> 
> Until a record is finalized, a writer can reopen that record to
> append new data. Reopening a record means transitioning from the
> desc_committed state back to the desc_reserved state.
> 
> A writer can explicitly finalize a record if there is no intention
> of extending it. Also, records are automatically finalized when a
> new record is reserved. This relieves writers of needing to
> explicitly finalize while also making such records available to
> readers sooner. (Readers can only traverse finalized records.)
> 
> Four new memory barrier pairs are introduced. Two of them are
> insignificant additions (data_realloc:A/desc_read:D and
> data_realloc:A/data_push_tail:B) because they are alternate path
> memory barriers that exactly match the purpose, pairing, and
> context of the two existing memory barrier pairs they provide an
> alternate path for. The other two new memory barrier pairs are
> significant additions:
> 
> desc_reopen_last:A / _prb_commit:B - When reopening a descriptor,
>     ensure the state transitions back to desc_reserved before
>     fully trusting the descriptor data.
> 
> _prb_commit:B / desc_reserve:D - When committing a descriptor,
>     ensure the state transitions to desc_committed before checking
>     the head ID to see if the descriptor needs to be finalized.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>
> ---
>  Documentation/admin-guide/kdump/gdbmacros.txt |   3 +-
>  kernel/printk/printk_ringbuffer.c             | 541 ++++++++++++++++--
>  kernel/printk/printk_ringbuffer.h             |   6 +-
>  scripts/gdb/linux/dmesg.py                    |   3 +-
>  4 files changed, 491 insertions(+), 62 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kdump/gdbmacros.txt b/Documentation/admin-guide/kdump/gdbmacros.txt
> index 8f533b751c46..94fabb165abf 100644
> --- a/Documentation/admin-guide/kdump/gdbmacros.txt
> +++ b/Documentation/admin-guide/kdump/gdbmacros.txt
> @@ -297,6 +297,7 @@ end
>  define dmesg
>  	# definitions from kernel/printk/printk_ringbuffer.h
>  	set var $desc_committed = 1
> +	set var $desc_finalized = 2
>  	set var $desc_sv_bits = sizeof(long) * 8
>  	set var $desc_flags_shift = $desc_sv_bits - 2
>  	set var $desc_flags_mask = 3 << $desc_flags_shift
> @@ -313,7 +314,7 @@ define dmesg
>  
>  		# skip non-committed record
>  		set var $state = 3 & ($desc->state_var.counter >> $desc_flags_shift)
> -		if ($state == $desc_committed)
> +		if ($state == $desc_committed || $state == $desc_finalized)
>  			dump_record $desc $prev_flags
>  			set var $prev_flags = $desc->info.flags
>  		end
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index 911fbe150e9a..f1fab8c82819 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -360,8 +423,8 @@ static enum desc_state get_desc_state(unsigned long id,
>  
>  /*
>   * Get a copy of a specified descriptor and its queried state. A descriptor
> - * that is not in the committed or reusable state must be considered garbage
> - * by the reader.
> + * that is not in the finalized or reusable state must be considered garbage
> + * by readers.

There is one exception. The entire descriptor is read also in
committed state. The content is considered valid when the stored
desc.info.caller_id matches @caller_id of the reader. It is
used when the descriptor gets reopened.

Well, it seems that only desc_out->caller_id value is used
in desc_reopen_last(). All the other values are accessed
directly when the descriptor is successfully reopened.

We should mention this exception in the comment at least.

>   */
>  static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
>  				 unsigned long id, struct prb_desc *desc_out)
> @@ -374,22 +437,29 @@ static enum desc_state desc_read(struct prb_desc_ring *desc_ring,
>  	/* Check the descriptor state. */
>  	state_val = atomic_long_read(state_var); /* LMM(desc_read:A) */
>  	d_state = get_desc_state(id, state_val);
> -	if (d_state != desc_committed && d_state != desc_reusable)
> +	if (d_state == desc_miss || d_state == desc_reserved) {
> +		/*
> +		 * The descriptor is in an inconsistent state. Set at least
> +		 * @state_var so that the caller can see the details of
> +		 * the inconsistent state.
> +		 */
> +		atomic_long_set(&desc_out->state_var, state_val);

This change looks unrelated. If I get it correctly, the value is
needed in desc_push_tail() to check whether the descriptor still
contains ID from the previous wrap. It fixes an older bug.
And it is a great catch!

We also should decide/comment whether it is needed to do the same
at the end of this function when re-checking the state returns
desc_miss.

It is not strictly needed because the value is used only to check
whether tail still points to the previous wrap. This would get caught
already during this first check. Any later desc_miss is not
interesting. We should mentions this in a comment.

Anyway, could we please move it into separate patch, so that the fix does
not get lost when this patch gets reverted from some reasons in the
future?

>  		return d_state;
> +	}
>  

> @@ -712,8 +783,9 @@ static bool desc_push_tail(struct printk_ringbuffer *rb,
>  		 */
>  		return true;
>  	case desc_reserved:
> -		return false;
>  	case desc_committed:
> +		return false;
> +	case desc_finalized:
>  		desc_make_reusable(desc_ring, tail_id);
>  		break;
>  	case desc_reusable:
> @@ -734,7 +806,7 @@ static bool desc_push_tail(struct printk_ringbuffer *rb,
>  
>  	/*
>  	 * Check the next descriptor after @tail_id before pushing the tail
> -	 * to it because the tail must always be in a committed or reusable
> +	 * to it because the tail must always be in a finalized or reusable
>  	 * state. The implementation of prb_first_seq() relies on this.

Just for record. The sequence number is valid even in the committed
state. It is not modified when the descriptor gets reopened.

Well, it is not a big deal. It is highly unlikely scenario. It would
mean that a descriptor from the previous wrap has not been finalized
even though it is committed and many new descriptors have been
reserved in the meantime (we are wrap ahead now).

It might happen only when the finalizing is delayed by NMI
and many messages appeared in the meantime.  It is the situation
when new space could not get reserved anyway.

I am fine with keeping it as is.


>  	 *
>  	 * A successful read implies that the next descriptor is less than or
> @@ -743,7 +815,7 @@ static bool desc_push_tail(struct printk_ringbuffer *rb,
>  	 */
>  	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1), &desc); /* LMM(desc_push_tail:A) */
>  
> -	if (d_state == desc_committed || d_state == desc_reusable) {
> +	if (d_state == desc_finalized || d_state == desc_reusable) {
>  		/*
>  		 * Guarantee any descriptor states that have transitioned to
>  		 * reusable are stored before pushing the tail ID. This allows
> @@ -878,6 +950,10 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  		 *    another CPU may have pushed the tail ID. This pairs
>  		 *    with desc_push_tail:C and this also pairs with
>  		 *    prb_first_seq:C.
> +		 *
> +		 * 5. Guarantee the head ID is stored before trying to
> +		 *    finalize the previous descriptor. This pairs with
> +		 *    _prb_commit:B.
>  		 */
>  	} while (!atomic_long_try_cmpxchg(&desc_ring->head_id, &head_id,
>  					  id)); /* LMM(desc_reserve:D) */
> @@ -904,7 +980,7 @@ static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
>  	 * This pairs with desc_read:D.
>  	 */
>  	if (!atomic_long_try_cmpxchg(&desc->state_var, &prev_state_val,
> -			DESC_SV(id, desc_reserved))) { /* LMM(desc_reserve:F) */
> +				     id | 0)) { /* LMM(desc_reserve:F) */

This restores the old code before 4th patch. It was probably not updated
when rebasing.

>  		WARN_ON_ONCE(1);
>  		return false;
>  	}
> @@ -1007,6 +1083,84 @@ static char *data_alloc(struct printk_ringbuffer *rb,
>  	return &blk->data[0];
>  }
>  
> +/*
> + * Try to resize an existing data block associated with the descriptor
> + * specified by @id. If the resized data block should become wrapped, it
> + * copies the old data to the new data block. If @size yields a data block
> + * with the same or less size, the data block is left as is.
> + *
> + * Fail if this is not the last allocated data block or if there is not
> + * enough space or it is not possible make enough space.
> + *
> + * Return a pointer to the beginning of the entire data buffer or NULL on
> + * failure.
> + */
> +static char *data_realloc(struct printk_ringbuffer *rb,
> +			  struct prb_data_ring *data_ring, unsigned int size,
> +			  struct prb_data_blk_lpos *blk_lpos, unsigned long id)
> +{
> +	struct prb_data_block *blk;
> +	unsigned long head_lpos;
> +	unsigned long next_lpos;
> +	bool wrapped;
> +
> +	/* Reallocation only works if @blk_lpos is the newest data block. */
> +	head_lpos = atomic_long_read(&data_ring->head_lpos);
> +	if (head_lpos != blk_lpos->next)
> +		return NULL;
> +
> +	/* Keep track if @blk_lpos was a wrapping data block. */
> +	wrapped = (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, blk_lpos->next));
> +
> +	size = to_blk_size(size);
> +
> +	next_lpos = get_next_lpos(data_ring, blk_lpos->begin, size);
> +
> +	/* If the data block does not increase, there is nothing to do. */
> +	if ((head_lpos - next_lpos) - 1 < DATA_SIZE(data_ring)) {

It should be:

	if ((head_lpos - next_lpos)  < DATA_SIZE(data_ring))

There is nothing to do when the positions are the same.


> +		blk = to_block(data_ring, blk_lpos->begin);
> +		return &blk->data[0];
> +	}
> +
> +	if (!data_push_tail(rb, data_ring, next_lpos - DATA_SIZE(data_ring)))
> +		return NULL;
> +
> +	/* The memory barrier involvement is the same as data_alloc:A. */
> +	if (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &head_lpos,
> +				     next_lpos)) { /* LMM(data_realloc:A) */
> +		return NULL;
> +	}
> +
> +	blk = to_block(data_ring, blk_lpos->begin);
> +
> +	if (DATA_WRAPS(data_ring, blk_lpos->begin) != DATA_WRAPS(data_ring, next_lpos)) {
> +		struct prb_data_block *old_blk = blk;
> +
> +		/* Wrapping data blocks store their data at the beginning. */
> +		blk = to_block(data_ring, 0);
> +
> +		/*
> +		 * Store the ID on the wrapped block for consistency.
> +		 * The printk_ringbuffer does not actually use it.
> +		 */
> +		blk->id = id;
> +
> +		if (!wrapped) {
> +			/*
> +			 * Since the allocated space is now in the newly
> +			 * created wrapping data block, copy the content
> +			 * from the old data block.
> +			 */
> +			memcpy(&blk->data[0], &old_blk->data[0],
> +			       (blk_lpos->next - blk_lpos->begin) - sizeof(blk->id));
> +		}
> +	}
> +
> +	blk_lpos->next = next_lpos;
> +
> +	return &blk->data[0];
> +}
> +
>  /* Return the number of bytes used by a data block. */
>  static unsigned int space_used(struct prb_data_ring *data_ring,
>  			       struct prb_data_blk_lpos *blk_lpos)
> @@ -1087,6 +1241,205 @@ static const char *get_data(struct prb_data_ring *data_ring,
>  	return &db->data[0];
>  }
>  
> +/*
> + * Attempt to remove the commit flag so that the record can be modified by a
> + * writer again. This is only possible if the descriptor is not yet finalized.
> + *
> + * Note that on success, the queried state did not change. A non-finalized
> + * record (even with the commit flag set) is in the reserved queried state.

This comment does not longer fit the new representation of the state
bits. It should be something like:

"Attempt to transit the descriptor back from committed to reserved
state so that the record can be modified by a writer again.
This is only possible if the descriptor is not yet finalized."


> + */
> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
> +					 u32 caller_id, unsigned long *id_out)
> +{
> +	unsigned long prev_state_val;
> +	enum desc_state d_state;
> +	struct prb_desc desc;
> +	struct prb_desc *d;
> +	unsigned long id;
> +
> +	id = atomic_long_read(&desc_ring->head_id);
> +
> +	/*
> +	 * To reduce unnecessarily reopening, first check if the descriptor
> +	 * state and caller ID are correct.
> +	 */
> +	d_state = desc_read(desc_ring, id, &desc);
> +	if (d_state != desc_committed || desc.info.caller_id != caller_id)
> +		return NULL;
> +
> +	d = to_desc(desc_ring, id);
> +
> +	prev_state_val = DESC_SV(id, desc_committed);
> +
> +	/*
> +	 * Guarantee the commit flag is removed from the state before
> +	 * reading any record data. A full memory barrier is needed
> +	 * because @state_var is modified for the read. This pairs with
> +	 * _prb_commit:B.
> +	 *
> +	 * Memory barrier involvement:
> +	 *
> +	 * If desc_reopen_last:A reads from _prb_commit:B, then
> +	 * prb_reserve_in_last:A reads from _prb_commit:A.
> +	 *
> +	 * Relies on:
> +	 *
> +	 * WMB from _prb_commit:A to _prb_commit:B
> +	 *    matching
> +	 * MB If desc_reopen_last:A to prb_reserve_in_last:A
> +	 */
> +	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
> +			DESC_SV(id, desc_reserved))) { /* LMM(desc_reopen_last:A) */
> +		return NULL;
> +	}
> +
> +	*id_out = id;
> +	return d;
> +}
> +
> +/**
> + * prb_reserve_in_last() - Re-reserve and extend the space in the ringbuffer
> + *                         used by the newest record.
> + *
> + * @e:         The entry structure to setup.
> + * @rb:        The ringbuffer to re-reserve and extend data in.
> + * @r:         The record structure to allocate buffers for.
> + * @caller_id: The caller ID of the caller (reserving writer).
> + *
> + * This is the public function available to writers to re-reserve and extend
> + * data.
> + *
> + * The writer specifies the text size to extend (not the new total size) by
> + * setting the @text_buf_size field of @r. Extending dictionaries is not
> + * supported, so @dict_buf_size of @r should be set to 0. To ensure proper
> + * initialization of @r, prb_rec_init_wr() should be used.
> + *
> + * This function will fail if @caller_id does not match the caller ID of the
> + * newest record. In that case the caller must reserve new data using
> + * prb_reserve().
> + *
> + * Context: Any context. Disables local interrupts on success.
> + * Return: true if text data could be extended, otherwise false.
> + *
> + * On success:
> + *
> + *   - @r->text_buf points to the beginning of the entire text buffer.
> + *
> + *   - @r->text_buf_size is set to the new total size of the buffer.
> + *
> + *   - @r->dict_buf and @r->dict_buf_size are cleared because extending
> + *     the dict buffer is not supported.
> + *
> + *   - @r->info is not touched so that @r->info->text_len could be used
> + *     to append the text.
> + *
> + *   - prb_record_text_space() can be used on @e to query the new
> + *     actually used space.
> + *
> + * Important: All @r->info fields will already be set with the current values
> + *            for the record. I.e. @r->info->text_len will be less than
> + *            @text_buf_size and @r->info->dict_len may be set, even though
> + *            @dict_buf_size is 0. Writers can use @r->info->text_len to know
> + *            where concatenation begins and writers should update
> + *            @r->info->text_len after concatenating.
> + */
> +bool prb_reserve_in_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> +			 struct printk_record *r, u32 caller_id)
> +{
> +	unsigned int data_size;
> +	struct prb_desc *d;
> +	unsigned long id;
> +
> +	local_irq_save(e->irqflags);
> +
> +	/* Transition the newest descriptor back to the reserved state. */
> +	d = desc_reopen_last(&rb->desc_ring, caller_id, &id);
> +	if (!d) {
> +		local_irq_restore(e->irqflags);
> +		goto fail_reopen;
> +	}
> +
> +	/* Now the writer has exclusive access: LMM(prb_reserve_in_last:A) */
> +
> +	/*
> +	 * Set the @e fields here so that prb_commit() can be used if
> +	 * anything fails from now on.
> +	 */
> +	e->rb = rb;
> +	e->id = id;
> +
> +	/*
> +	 * desc_reopen_last() checked the caller_id, but there was no
> +	 * exclusive access at that point. The descriptor may have
> +	 * changed since then.
> +	 */
> +	if (caller_id != d->info.caller_id)
> +		goto fail;
> +
> +	if (BLK_DATALESS(&d->text_blk_lpos)) {
> +		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
> +					 &d->text_blk_lpos, id);
> +		if (WARN_ON_ONCE(d->info.text_len != 0)) {
> +			pr_warn_once("wrong text_len value (%u, expecting 0)\n",
> +				     d->info.text_len);
> +			d->info.text_len = data_size;

Should be:

			d->info.text_len = 0;;

> +		}
> +	} else {
> +		if (!get_data(&rb->text_data_ring, &d->text_blk_lpos, &data_size))
> +			goto fail;
> +
> +		/*
> +		 * Increase the buffer size to include the original size. If
> +		 * the meta data (@text_len) is not sane, use the full data
> +		 * block size.
> +		 */
> +		if (WARN_ON_ONCE(d->info.text_len > data_size)) {
> +			pr_warn_once("wrong text_len value (%u, expecting <=%hu)\n",
> +				     d->info.text_len, data_size);
> +			d->info.text_len = data_size;
> +		}
> +		r->text_buf_size += d->info.text_len;
> +
> +		if (!data_check_size(&rb->text_data_ring, r->text_buf_size))
> +			goto fail;
> +
> +		r->text_buf = data_realloc(rb, &rb->text_data_ring, r->text_buf_size,
> +					   &d->text_blk_lpos, id);
> +	}
> +	if (r->text_buf_size && !r->text_buf)
> +		goto fail;
> +
> +	/* Although dictionary data may be in use, it cannot be extended. */
> +	r->dict_buf = NULL;
> +	r->dict_buf_size = 0;
> +
> +	r->info = &d->info;
> +
> +	e->text_space = space_used(&rb->text_data_ring, &d->text_blk_lpos);
> +
> +	return true;
> +fail:
> +	prb_commit(e);
> +	/* prb_commit() re-enabled interrupts. */
> +fail_reopen:
> +	/* Make it clear to the caller that the re-reserve failed. */
> +	memset(r, 0, sizeof(*r));
> +	return false;
> +}
> +
> @@ -1316,16 +1738,16 @@ static bool copy_data(struct prb_data_ring *data_ring,
>  
>  /*
>   * This is an extended version of desc_read(). It gets a copy of a specified
> - * descriptor. However, it also verifies that the record is committed and has
> + * descriptor. However, it also verifies that the record is
>  finaized and has

s/finaized/finalized/

>   * the sequence number @seq. On success, 0 is returned.
>   *
>   * Error return values:
> - * -EINVAL: A committed record with sequence number @seq does not exist.
> - * -ENOENT: A committed record with sequence number @seq exists, but its data
> + * -EINVAL: A finalized record with sequence number @seq does not exist.
> + * -ENOENT: A finalized record with sequence number @seq exists, but its data
>   *          is not available. This is a valid record, so readers should
>   *          continue with the next record.
>   */
> -static int desc_read_committed_seq(struct prb_desc_ring *desc_ring,
> +static int desc_read_finalized_seq(struct prb_desc_ring *desc_ring,
>  				   unsigned long id, u64 seq,
>  				   struct prb_desc *desc_out)
>  {

It seems that we are getting close.

Best Regards,
Petr
