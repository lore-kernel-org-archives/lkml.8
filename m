Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8EDC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122982064C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 11:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgFILh6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 07:37:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:44070 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726915AbgFILhz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 07:37:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EFE53AAC6;
        Tue,  9 Jun 2020 11:37:55 +0000 (UTC)
Date:   Tue, 9 Jun 2020 13:37:51 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Barrier before pushing desc_ring tail: was [PATCH v2 2/3] printk:
 add lockless buffer
Message-ID: <20200609113751.GD23752@linux-b0ei>
References: <20200501094010.17694-1-john.ogness@linutronix.de>
 <20200501094010.17694-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501094010.17694-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-05-01 11:46:09, John Ogness wrote:
> Introduce a multi-reader multi-writer lockless ringbuffer for storing
> the kernel log messages. Readers and writers may use their API from
> any context (including scheduler and NMI). This ringbuffer will make
> it possible to decouple printk() callers from any context, locking,
> or console constraints. It also makes it possible for readers to have
> full access to the ringbuffer contents at any time and context (for
> example from any panic situation).
> 
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.c
> +/*
> + * Advance the desc ring tail. This function advances the tail by one
> + * descriptor, thus invalidating the oldest descriptor. Before advancing
> + * the tail, the tail descriptor is made reusable and all data blocks up to
> + * and including the descriptor's data block are invalidated (i.e. the data
> + * ring tail is pushed past the data block of the descriptor being made
> + * reusable).
> + */
> +static bool desc_push_tail(struct printk_ringbuffer *rb,
> +			   unsigned long tail_id)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	enum desc_state d_state;
> +	struct prb_desc desc;
> +
> +	d_state = desc_read(desc_ring, tail_id, &desc);
> +
> +	switch (d_state) {
> +	case desc_miss:
> +		/*
> +		 * If the ID is exactly 1 wrap behind the expected, it is
> +		 * in the process of being reserved by another writer and
> +		 * must be considered reserved.
> +		 */
> +		if (DESC_ID(atomic_long_read(&desc.state_var)) ==
> +		    DESC_ID_PREV_WRAP(desc_ring, tail_id)) {
> +			return false;
> +		}
> +
> +		/*
> +		 * The ID has changed. Another writer must have pushed the
> +		 * tail and recycled the descriptor already. Success is
> +		 * returned because the caller is only interested in the
> +		 * specified tail being pushed, which it was.
> +		 */
> +		return true;
> +	case desc_reserved:
> +		return false;
> +	case desc_committed:
> +		desc_make_reusable(desc_ring, tail_id);
> +		break;
> +	case desc_reusable:
> +		break;
> +	}
> +
> +	/*
> +	 * Data blocks must be invalidated before their associated
> +	 * descriptor can be made available for recycling. Invalidating
> +	 * them later is not possible because there is no way to trust
> +	 * data blocks once their associated descriptor is gone.
> +	 */
> +
> +	if (!data_push_tail(rb, &rb->text_data_ring, desc.text_blk_lpos.next))
> +		return false;
> +	if (!data_push_tail(rb, &rb->dict_data_ring, desc.dict_blk_lpos.next))
> +		return false;
> +
> +	/*
> +	 * Check the next descriptor after @tail_id before pushing the tail
> +	 * to it because the tail must always be in a committed or reusable
> +	 * state. The implementation of prb_first_seq() relies on this.
> +	 *
> +	 * A successful read implies that the next descriptor is less than or
> +	 * equal to @head_id so there is no risk of pushing the tail past the
> +	 * head.
> +	 */
> +	d_state = desc_read(desc_ring, DESC_ID(tail_id + 1),
> +			    &desc); /* LMM(desc_push_tail:A) */
> +	if (d_state == desc_committed || d_state == desc_reusable) {
> +		/*
> +		 * Any CPU that loads the new tail ID, must see that the
> +		 * descriptor at @tail_id is in the reusable state. See the
> +		 * read memory barrier part of desc_reserve:D for details.
> +		 */

I was quite confused by the above comment. Does it mean that we need
a barrier here? Or does it explain why the cmpxchg has its own
LMM marker?

I think that we actually need a full barrier here to make sure that
all CPUs see the changes made by data_push_tail() before we
allow to rewrite the descriptor. The changes in data_push_tail() might
be done on different CPUs.

It is similar like the full barrier in data_push_tail() before changing
data_ring->tail_lpos.

Best Regards,
Petr

> +		atomic_long_cmpxchg_relaxed(&desc_ring->tail_id, tail_id,
> +			DESC_ID(tail_id + 1)); /* LMM(desc_push_tail:B) */
> +	} else {
> +		/*
> +		 * Guarantee the last state load from desc_read() is before
> +		 * reloading @tail_id in order to see a new tail ID in the
> +		 * case that the descriptor has been recycled. This pairs
> +		 * with desc_reserve:D.
> +		 *
> +		 * Memory barrier involvement:
> +		 *
> +		 * If desc_push_tail:A reads from desc_reserve:G, then
> +		 * desc_push_tail:D reads from desc_push_tail:B.
> +		 *
> +		 * Relies on:
> +		 *
> +		 * MB from desc_push_tail:B to desc_reserve:G
> +		 *    matching
> +		 * RMB from desc_push_tail:A to desc_push_tail:D
> +		 *
> +		 * Note: desc_push_tail:B and desc_reserve:G can be different
> +		 *       CPUs. However, the desc_reserve:G CPU (which performs
> +		 *       the full memory barrier) must have previously seen
> +		 *       desc_push_tail:B.
> +		 */
> +		smp_rmb(); /* LMM(desc_push_tail:C) */
> +
> +		/*
> +		 * Re-check the tail ID. The descriptor following @tail_id is
> +		 * not in an allowed tail state. But if the tail has since
> +		 * been moved by another task, then it does not matter.
> +		 */
> +		if (atomic_long_read(&desc_ring->tail_id) ==
> +					tail_id) { /* LMM(desc_push_tail:D) */
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +/* Reserve a new descriptor, invalidating the oldest if necessary. */
> +static bool desc_reserve(struct printk_ringbuffer *rb, unsigned long *id_out)
> +{
> +	struct prb_desc_ring *desc_ring = &rb->desc_ring;
> +	unsigned long prev_state_val;
> +	unsigned long id_prev_wrap;
> +	struct prb_desc *desc;
> +	unsigned long head_id;
> +	unsigned long id;
> +
> +	head_id = atomic_long_read(&desc_ring->head_id
> +						); /* LMM(desc_reserve:A) */
> +
> +	do {
> +		desc = to_desc(desc_ring, head_id);
> +
> +		id = DESC_ID(head_id + 1);
> +		id_prev_wrap = DESC_ID_PREV_WRAP(desc_ring, id);
> +
> +		/*
> +		 * Guarantee the head ID is read before reading the tail ID.
> +		 * Since the tail ID is updated before the head ID, this
> +		 * guarantees that @id_prev_wrap is never ahead of the tail
> +		 * ID. This pairs with desc_reserve:D.
> +		 *
> +		 * Memory barrier involvement:
> +		 *
> +		 * If desc_reserve:A reads from desc_reserve:E, then
> +		 * desc_reserve:C reads from desc_push_tail:B.
> +		 *
> +		 * Relies on:
> +		 *
> +		 * MB from desc_push_tail:B to desc_reserve:E
> +		 *    matching
> +		 * RMB from desc_reserve:A to desc_reserve:C
> +		 *
> +		 * Note: desc_push_tail:B and desc_reserve:E can be different
> +		 *       CPUs. However, the desc_reserve:E CPU (which performs
> +		 *       the full memory barrier) must have previously seen
> +		 *       desc_push_tail:B.
> +		 */
> +		smp_rmb(); /* LMM(desc_reserve:B) */
> +
> +		if (id_prev_wrap == atomic_long_read(&desc_ring->tail_id
> +						)) { /* LMM(desc_reserve:C) */
> +			/*
> +			 * Make space for the new descriptor by
> +			 * advancing the tail.
> +			 */
> +			if (!desc_push_tail(rb, id_prev_wrap))
> +				return false;
> +		}
> +
> +		/*
> +		 * Guarantee the tail ID is read before validating the
> +		 * recycled descriptor state. A read memory barrier is
> +		 * sufficient for this. This pairs with data_push_tail:C.
> +		 *
> +		 * Memory barrier involvement:
> +		 *
> +		 * If desc_reserve:C reads from desc_push_tail:B, then
> +		 * desc_reserve:F reads from desc_make_reusable:A.
> +		 *
> +		 * Relies on:
> +		 *
> +		 * MB from desc_make_reusable:A to desc_push_tail:B
> +		 *    matching
> +		 * RMB from desc_reserve:C to desc_reserve:F
> +		 *
> +		 * Note: desc_make_reusable:A, desc_push_tail:B, and
> +		 *       data_push_tail:C can all be different CPUs. However,
> +		 *       the desc_push_tail:B CPU must have previously seen
> +		 *       data_push_tail:D and the data_push_tail:D CPU (which
> +		 *       performs the full memory barrier) must have
> +		 *       previously seen desc_make_reusable:A.
> +		 *
> +		 * Guarantee any data ring tail changes are stored before
> +		 * recycling the descriptor. Data ring tail changes can happen
> +		 * via desc_push_tail()->data_push_tail(). A full memory
> +		 * barrier is needed since another task may have pushed the
> +		 * data ring tails. This pairs with data_push_tail:A.
> +		 *
> +		 * Guarantee a new tail ID is stored before recycling the
> +		 * descriptor. A full memory barrier is needed since another
> +		 * task may have pushed the tail ID. This pairs with
> +		 * desc_push_tail:C and prb_first_seq:C.
> +		 *
> +		 * Guarantee the tail ID is stored before storing the head ID.
> +		 * This pairs with desc_reserve:B.
> +		 */
> +		smp_mb(); /* LMM(desc_reserve:D) */
> +
> +	} while (!atomic_long_try_cmpxchg_relaxed(&desc_ring->head_id,
> +				&head_id, id)); /* LMM(desc_reserve:E) */
> +
> +	desc = to_desc(desc_ring, id);
> +
> +	/*
> +	 * If the descriptor has been recycled, verify the old state val.
> +	 * See "ABA Issues" about why this verification is performed.
> +	 */
> +	prev_state_val = atomic_long_read(&desc->state_var
> +						); /* LMM(desc_reserve:F) */
> +	if (prev_state_val && prev_state_val != (id_prev_wrap |
> +						 DESC_COMMITTED_MASK |
> +						 DESC_REUSE_MASK)) {
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/*
> +	 * Assign the descriptor a new ID and set its state to reserved.
> +	 * See "ABA Issues" about why cmpxchg() instead of set() is used.
> +	 */
> +	if (!atomic_long_try_cmpxchg_relaxed(&desc->state_var,
> +			&prev_state_val, id | 0)) { /* LMM(desc_reserve:G) */
> +		WARN_ON_ONCE(1);
> +		return false;
> +	}
> +
> +	/*
> +	 * Guarantee the new descriptor ID and state is stored before making
> +	 * any other changes. This pairs with desc_read:D.
> +	 */
> +	smp_wmb(); /* LMM(desc_reserve:H) */
> +
> +	/* Now data in @desc can be modified: LMM(desc_reserve:I) */
> +
> +	*id_out = id;
> +	return true;
> +}
