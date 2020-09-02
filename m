Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1524DC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C923E20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIBMVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:21:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:45296 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIBMVb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:21:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3760FAD68;
        Wed,  2 Sep 2020 12:21:30 +0000 (UTC)
Date:   Wed, 2 Sep 2020 14:21:28 +0200
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
Subject: misc: was: [PATCH next v3 6/8] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200902122125.GB9496@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-7-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831011058.6286-7-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-08-31 03:16:56, John Ogness wrote:
> Add support for extending the newest data block. For this, introduce
> a new finalization state flag (DESC_FINAL_MASK) that denotes when a
> descriptor may not be extended, i.e. is finalized.
> 
> Three new memory barrier pairs are introduced. Two of them are not
> significant because they are alternate path memory barriers that
> exactly correspond to existing memory barriers.
>
> But the third (_prb_commit:B / desc_reserve:D) is new and guarantees
> that descriptors will always be finalized, either because a
> descriptor setting DESC_COMMIT_MASK sees that there is a newer
> descriptor and so finalizes itself or because a new descriptor being
> reserved sees that the previous descriptor has DESC_COMMIT_MASK set
> and finalizes that descriptor.

Just for record. All the barriers look good to me.

There are always full barriers when we change DESC_COMMIT_MASK.
It guarantees consistency of the descriptor and data rings.

The only relaxed modification is adding DESC_FINAL_MASK. It is OK.
It can be done only when DESC_COMMIT_MASK has been set before
using a full barrier. It means that all changes of the rings
has already been since before.


> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
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
> + * setting the @text_buf_size field of @r. Dictionaries cannot be extended so

Better might be to say that extending dictionaries is not
supported.

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
> + * On success:
> + *
> + *   - @r->text_buf points to the beginning of the entire text buffer.
> + *
> + *   - @r->text_buf_len is set to the new total size of the buffer.

s/buf_len/buf_size/

> + *   - @r->dict_buf and @r->dict_buf_len are cleared because extending
> + *     the dict buffer is not supported.

Same here.

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

We do not clear d->info when reopening the descriptor. I would at
least add here a consistency check similar to the one below:

		if (WARN_ON_ONCE(d->info.text_len)) {
			pr_warn_once("wrong data size (%u, expecting 0) for data\n",
				     d->info.text_len);
			d->info.text_len = 0;
		}

> +		r->text_buf = data_alloc(rb, &rb->text_data_ring, r->text_buf_size,
> +					 &d->text_blk_lpos, id);
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
> +			pr_warn_once("wrong data size (%u, expecting >=%hu) for data\n",
> +				     data_size, d->info.text_len);
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

[...]

> @@ -1261,6 +1615,59 @@ void prb_commit(struct prb_reserved_entry *e)
>  	local_irq_restore(e->irqflags);
>  }
>  
> +/**
> + * prb_commit() - Commit (previously reserved) data to the ringbuffer.
> + *
> + * @e: The entry containing the reserved data information.
> + *
> + * This is the public function available to writers to commit data.
> + *
> + * Note that the data is not yet available to readers until it is finalized.
> + * Finalizing happens automatically when space for the next record is
> + * reserved.
> + *
> + * See prb_final_commit() for a version of this function that finalizes
> + * immediately.
> + *
> + * Context: Any context. Enables local interrupts.
> + */
> +void prb_commit(struct prb_reserved_entry *e)
> +{
> +	struct prb_desc_ring *desc_ring = &e->rb->desc_ring;
> +	unsigned long head_id;
> +
> +	_prb_commit(e, 0);
> +
> +	/*
> +	 * If this descriptor is no longer the head (i.e. a new record has
> +	 * been allocated), extending the data for this record is no longer
> +	 * allowed and therefore it must be finalized.
> +	 */
> +	head_id = atomic_long_read(&desc_ring->head_id); /* LMM(prb_commit:A) */
> +	if (head_id != e->id)
> +		desc_make_final(desc_ring, e->id);

Nice trick! I wonder why I suggested to do it the complicated
way via desc_state.

> +}
> +

I finished review of this patch.

Best Regards,
Petr
