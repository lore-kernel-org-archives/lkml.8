Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7414C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:53:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB5622177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 12:53:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbgH0Mwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 08:52:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:34532 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729245AbgH0Mut (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 08:50:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6751FAE96;
        Thu, 27 Aug 2020 12:51:20 +0000 (UTC)
Date:   Thu, 27 Aug 2020 14:50:47 +0200
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
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200827125047.GB4353@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824103538.31446-6-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this mail is based on my review that I did last two days. I haven't
seen the last code that tried to handle the finalize issues.
Anyway, this feedback might give some clueue as well.

IMPORTANT: It seems that we both had different understanding of
the DESC_FINAL_MASK behavior. It might explain some problems
and confusion. See my last comment in this mail for more.

On Mon 2020-08-24 12:41:36, John Ogness wrote:
> Add support for extending the last data block. For this, introduce a new
> finalization state flag that identifies if a descriptor may be extended.
> 
> When a writer calls the commit function prb_commit(), the record may still
> continue to be in the reserved queried state. In order for that record to
> enter into the committed queried state, that record also must be finalized.
> Finalization can occur anytime while the record is in the reserved queried
> state, even before the writer has called prb_commit().

The above paragraph is a bit confusing. The reserved state means that
that the record is being modified. prb_commit() sets DESC_COMMIT_MASK.
It means that the record is in a consistent state. It might get
reopened or finalized.

> Until a record is finalized (represented by "DESC_FINAL_MASK"), a writer
> may "reopen" that record and extend it with more data.

I would replace the above two paragrahs with something like:

"The original DESC_COMMIT_MASK is still set when the record is in
a consistent state. In this state, it can either get reopened or
finalized.

The new DESC_FINAL_MASK is set when the record can not longer get
modified. It might be set explicitely by the new prb_commit_finalize()
when the writer does not longer plan to append data. But it is also
set automatically when a new descriptor is allocated.

The automatic finalization simplifies the implementation. Only the
last datablock could get extended easily."


> Note that existing descriptors are automatically finalized whenever new
> descriptors are created. A record can never be "unfinalized".
> 
> Two new memory barrier pairs are introduced, but these are really just
> alternate path barriers that exactly correspond to existing memory
> barriers.

[...]

> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> index d66718e74aae..90d48973ac9e 100644
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -79,6 +81,20 @@
>   * committed or reusable queried state. This makes it possible that a valid
>   * sequence number of the tail is always available.
>   *
> + * Descriptor Finalization
> + * ~~~~~~~~~~~~~~~~~~~~~~~
> + * When a writer calls the commit function prb_commit(), the record may still
> + * continue to be in the reserved queried state. In order for that record to
> + * enter into the committed queried state, that record also must be finalized.
> + * Finalization can occur anytime while the record is in the reserved queried
> + * state, even before the writer has called prb_commit().

This has the same problem as the commit message ;-)

> + *
> + * Until a record is finalized (represented by "DESC_FINAL_MASK"), a writer
> + * may "reopen" that record and extend it with more data.
> + *
> + * Note that existing descriptors are automatically finalized whenever new
> + * descriptors are created. A record can never be "unfinalized".
> + *
>   * Data Rings
>   * ~~~~~~~~~~
>   * The two data rings (text and dictionary) function identically. They exist

[...]

> @@ -1018,6 +1071,77 @@ static char *data_alloc(struct printk_ringbuffer *rb,
>  	return &blk->data[0];
>  }
>  
> +/*
> + * Extend the allocation of a specified data block, invalidating the oldest
> + * data block(s) if necessary. This function also associates the data block
> + * with a specified descriptor.
> + */

data_realloc() actually allows to even reduce the buffer size. It is
used when the original buffer was larger than the original
info->text_len + requested text_buf_size.

I though a lot about it. It is a questionable behavior.

First, we did not expected this when designed the ring buffer. Well, I
do not see why it should not work. More free space in the ring buffer
does not hurt. And the cmpxchg in data_alloc() compares the exact
lpos.

Second, there is the idea to flush the existing pieces of continuous
lines to the consoles even before the record is finalized. For this,
we will need to make sure that the already committed text does not longer
change. The main responsibility has the caller (printk code). But
the ring buffer code will need to allow reading the already committed
text even when the buffer is being extended. But even this should work
when shrinking the ring buffer. It will be in the same wrap and
the reader would read only the part defined by the original info->text_len.


Anyway, the comment is too short. It does not describe what exactly
is done and the limitations. I suggest something like:

/*
 * Try to resize an existing data block defined by the given @id.
 * It copies the old data when the resized datablock is newly wrapped.
 *
 * Fail when it is not the last allocated data block. Also fail when
 * there is not enough space and the oldest data blocks could not get
 * invalidated.
 *
 * Return pointer to the beginning of the entire data buffer or
 * NULL on failure.
 *
 */

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
> +	if (next_lpos == head_lpos) {
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

Sigh, this is a lot of non-trivial code is duplicated here. But I do
not see a good was how to share it. The data extension is so special that it
needs special checks and actions on many locations.


> +
>  /* Return the number of bytes used by a data block. */
>  static unsigned int space_used(struct prb_data_ring *data_ring,
>  			       struct prb_data_blk_lpos *blk_lpos)
> @@ -1098,6 +1222,156 @@ static const char *get_data(struct prb_data_ring *data_ring,
>  	return &db->data[0];
>  }
>  
> +/*
> + * Attempt to move the head descriptor back to the reserved state. This is
> + * only possible if the descriptor is in the commit+!final state.
> + */
> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
> +					 unsigned long *id_out)
> +{
> +	unsigned long prev_state_val;
> +	struct prb_desc *d;
> +	unsigned long id;
> +
> +	id = atomic_long_read(&desc_ring->head_id);
> +
> +	d = to_desc(desc_ring, id);
> +
> +	prev_state_val = id | DESC_COMMIT_MASK;
> +	if (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val, id | 0))
> +		return NULL;

This might deserve a comment why any barrier is not needed here.
I guess that you did not add it because the reader API allows
to read data only when DESC_FINAL_MASK is set.

But this assumption looks dangerous to me. As I already wrote above.
We might later need to add an API to read the already committed
parts of a continuous lines.

Anyway, this state change has similar effect as the similar one in
desc_reserve(). The result is that the descriptor is going to be
modified and might not be in a consistent state.

Note that desc_reserve() moves the descriptor from reusable
to reserved state. The descriptor was in a consistent state
when it was reusable.

Anyway, I would feel much more comfortable when a full barrier is used here.
I mean to do:

	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,id | 0))
		return NULL;

> +
> +	*id_out = id;
> +	return d;
> +}
> +
> +/**
> + * prb_reserve_last() - Re-reserve and extend the space in the ringbuffer used
> + *                      by the newest record.

The name is a bit ambiguous. prb_reserve_in_last() sounds more clear.

It would also explain why the caller specifies only the text size
to extend and not the total one.


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
> + * setting the @text_buf_size field of @r. Dictionaries cannot be extended so
> + * @dict_buf_size of @r should be set to 0. To ensure proper initialization of
> + * @r, prb_rec_init_wr() should be used.
> + *
> + * This function will fail if @caller_id does not match the caller ID of the
> + * newest record. In that case the caller must reserve new data using
> + * prb_reserve().
> + *
> + * Context: Any context. Disables local interrupts on success.
> + * Return: true if text data could be extended, otherwise false.
> + *
> + * On success, the fields @info, @text_buf, @dict_buf of @r will be set by
> + * this function (@dict_buf is always set to NULL.) Also on success, the field
> + * @text_buf_size of @r is set to the new total size (@dict_buf_size is always
> + * set to 0). Also on success prb_record_text_space() can be used on @e to
> + * query the actual space used for the newly extended text data block.

The above paragraph is hard to read. And it does not describe what
exactly is done with @info and @text_buf fields.
What about the following?

"On success:
	+ @r->text_buf points to the beginning of the entire text buffer.
	+ @r->text_buf_len is set to the new total size of the buffer.
	+ @r->dict_buf and @r->dict+dict_buf_len are cleared because
		extending the dict buffer is not supported.
	+ @r->info is not touched so that @info.text_len could be used
	  to append the text.
	+ prb_record_text_space() can be used on @e to query the
	  new actually used space."

> + *
> + * Important: All @info fields will already be set with the current values for
> + *            the record. I.e. @info->text_len will be less than @text_buf_size
> + *            and @info->dict_len may be set, even though @dict_buf_size is 0.
> + *            Writers can use @info->text_len to know where concatenation
> + *            begins and writers should update @info->text_len after
> + *            concatenating.

Hmm, this is inconsistent with prb_reserve() behavior and thus error-prone.
I would change the behavior so that:

   + prb_reserve() clears the entire @info struct, including text_len,
     dict_len. The caller will be responsible for filling the right
     values.

   + prb_reserve_in_last() will not touch @info struct at all.


The change in prb_reserve() should be done in separate preparation patch.


> + */
> +bool prb_reserve_last(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> +		      struct printk_record *r, u32 caller_id)
> +{
> +	unsigned int data_size;
> +	struct prb_desc *d;
> +	unsigned long id;
> +
> +	local_irq_save(e->irqflags);
> +
> +	/* Transition the newest descriptor back to the reserved state. */
> +	d = desc_reopen_last(&rb->desc_ring, &id);
> +	if (!d) {
> +		local_irq_restore(e->irqflags);
> +		goto fail;
> +	}
> +
> +	/* Back in the reserved state, exclusive access is guaranteed. */
> +
> +	/*
> +	 * Set the @e fields here so that prb_commit() can be used if
> +	 * anything fails from now on.
> +	 */
> +	e->rb = rb;
> +	e->id = id;
> +
> +	if (caller_id != d->info.caller_id) {
> +		prb_commit(e);
> +		/* prb_commit() re-enabled interrupts. */
> +		goto fail;
> +	}
> +
> +	if (BLK_DATALESS(&d->text_blk_lpos)) {
> +		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
> +					 &d->text_blk_lpos, id);
> +	} else {
> +		if (!get_data(&rb->text_data_ring, &d->text_blk_lpos, &data_size)) {
> +			prb_commit(e);
> +			/* prb_commit() re-enabled interrupts. */
> +			goto fail;
> +		}
> +		/* Use the size from the meta data (if it is sane). */
> +		if (d->info.text_len < data_size)
> +			data_size = d->info.text_len;

printk() is going to write behing the buffer when info.text_len is not
sane. Therefore I would do the opposite here:

		/*
		 * Count the size of the entire text buffer. Use only
		 * the really used space from the original one.
		 * Make sure that the size of the used space is sane.
		 */
		 if (WARN_ON_ONCE(d->info.text_len > data_size))
			d->info.text_len = data_size;
		r->text_buf_size += d->info.text_len;

Also need to check that the requested size is acceptable:

	if (!data_check_size(&rb->text_data_ring, r->text_buf_size)) {
		prb_commit(e);
		/* prb_commit() re-enabled interrupts. */
		goto fail;
	}

> +		r->text_buf_size += data_size;
> +		r->text_buf = data_realloc(rb, &rb->text_data_ring, r->text_buf_size,
> +					   &d->text_blk_lpos, id);
> +	}
> +	if (r->text_buf_size && !r->text_buf) {
> +		prb_commit(e);
> +		/* prb_commit() re-enabled interrupts. */
> +		goto fail;
> +	}
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
> +	/* Make it clear to the caller that the re-reserve failed. */
> +	memset(r, 0, sizeof(*r));
> +	return false;

It would make sense to add one more fail target.

fail:
	prb_commit(e);
	/* prb_commit() re-enabled interrupts. */
fail_reopen:
	/* Make it clear to the caller that the re-reserve failed. */
	memset(r, 0, sizeof(*r));
	return false;



> +}
> +
> +/*
> + * Attempt to finalize a specified descriptor. Finalization only happens if
> + * the descriptor is in the !final or commit+!final state, both of which
> + * yield a state query result of desc_reserved.
> + */
> +static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
> +{
> +	unsigned long prev_state_val = id | DESC_COMMIT_MASK;
> +	struct prb_desc *d = to_desc(desc_ring, id);
> +	bool is_final;
> +
> +	while (!atomic_long_try_cmpxchg_relaxed(&d->state_var, &prev_state_val,
> +						prev_state_val | DESC_FINAL_MASK)) {
> +
> +		if (get_desc_state(id, prev_state_val, &is_final) != desc_reserved)
> +			break;
> +
> +		if (is_final)
> +			break;
> +	}

Do we need the cycle and check if it succeeded?
When could the cmpxchg fail?

    + It is still reserved or reserved again => it should get
      finalized by the one who reserved it. This is related to
      the problem reported/discussed in the other thread,
      see https://lore.kernel.org/r/87lfi1ls2g.fsf@jogness.linutronix.de

    + It is already in the final (committed) state => success

    + It is in reusable state => already done in the past

    + It is already reused => already done in the past

Do I miss any scenario?

IMHO, the following simple call should be enough.

	atomic_long_try_cmpxchg_relaxed(&d->state_var,	&prev_state_val,
					prev_state_val | DESC_FINAL_MASK);

Well, I am not sure about the "relaxed" variant again. I would feel
more comfortable when it is full barrier especially because it
might be done by another CPU than what did the commit. And
we need to avoid the race when nobody finalize the record.


> +static void desc_finalize(struct prb_desc_ring *desc_ring, unsigned long id)
> +{
> +}
> +
>  /**
>   * prb_reserve() - Reserve space in the ringbuffer.
>   *
> @@ -1218,22 +1500,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
>  	return false;
>  }
>  
> -/**
> - * prb_commit() - Commit (previously reserved) data to the ringbuffer.
> - *
> - * @e: The entry containing the reserved data information.
> - *
> - * This is the public function available to writers to commit data.
> - *
> - * Context: Any context. Enables local interrupts.
> - */
> -void prb_commit(struct prb_reserved_entry *e)
> +/* Commit the data (possibly finalizing it) and restore interrupts. */
> +static void _prb_commit(struct prb_reserved_entry *e, unsigned long final_mask)
>  {
>  	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
>  	struct prb_desc *d = to_desc(desc_ring, e->id);
>  	unsigned long prev_state_val = e->id | 0;
>  
> -	/* Now the writer has finished all writing: LMM(prb_commit:A) */
> +	/* Now the writer has finished all writing: LMM(_prb_commit:A) */
>  
>  	/*
>  	 * Set the descriptor as committed. See "ABA Issues" about why
> @@ -1244,14 +1518,66 @@ void prb_commit(struct prb_reserved_entry *e)
>  	 * this. This pairs with desc_read:B.
>  	 */
>  	if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
> -				     e->id | DESC_COMMIT_MASK)) { /* LMM(prb_commit:B) */
> -		WARN_ON_ONCE(1);
> +				     e->id | DESC_COMMIT_MASK |
> +					     final_mask)) { /* LMM(_prb_commit:B) */
> +		/*
> +		 * This reserved descriptor must have been finalized already.
> +		 * Retry with a reserved+final expected value.
> +		 */
> +		prev_state_val = e->id | 0 | DESC_FINAL_MASK;

This does not make sense to me. The state "e->id | 0 | DESC_FINAL_MASK"
must never happen. It would mean that someone finalized
record that is still being modified.

Or we both have different understanding of the logic.

Well, there are actually two approaches:

   + I originally expected that FINAL bit could be set only when
     COMMIT bit is set. But this brings the problems that prb_commit()
     would need to set FINAL when it is not longer the last descriptor.

   + Another approach is that FINAL bit could be set even when the
     COMMIT is not set. It would always be set by the next
     prb_reserve(). But it causes that there are more possible
     combinations of COMMIT and FINAL bits. As a result, the caller
     would  need try more variants of the cmpxchg() calls. And
     it creates another races/cycles, ...

     In this case, a better name for the bit would be NON_REOPENABLE
     or something like this.


I guess that you wanted to implement the 2nd approach and ended in
many troubles. I wonder if the 1st approach might be easier.



> +		if (!atomic_long_try_cmpxchg(&d->state_var, &prev_state_val,
> +					     e->id | DESC_COMMIT_MASK |
> +						     DESC_FINAL_MASK)) { /* LMM(_prb_commit:C) */
> +			WARN_ON_ONCE(1);
> +		}
>  	}
>  
>  	/* Restore interrupts, the reserve/commit window is finished. */
>  	local_irq_restore(e->irqflags);
>  }
>  

Best Regards,
Petr
