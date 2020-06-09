Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41723C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 130A320737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 14:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730446AbgFIOiP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 10:38:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:47502 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726395AbgFIOiP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 10:38:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5D16BAAC3;
        Tue,  9 Jun 2020 14:38:16 +0000 (UTC)
Date:   Tue, 9 Jun 2020 16:38:11 +0200
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
Subject: data_ring head_lpos and tail_lpos synchronization: was [PATCH v2
 2/3] printk: add lockless buffer
Message-ID: <20200609143811.GF23752@linux-b0ei>
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
> + * Advance the data ring tail to at least @lpos. This function puts
> + * descriptors into the reusable state if the tail is pushed beyond
> + * their associated data block.
> + */
> +static bool data_push_tail(struct printk_ringbuffer *rb,
> +			   struct prb_data_ring *data_ring,
> +			   unsigned long lpos)
> +{
> +	unsigned long tail_lpos;
> +	unsigned long next_lpos;
> +
> +	/* If @lpos is not valid, there is nothing to do. */
> +	if (lpos == INVALID_LPOS)
> +		return true;
> +
> +	tail_lpos = atomic_long_read(&data_ring->tail_lpos);

Hmm, I wonder whether data_ring->tail_lpos and data_ring->head_lpos
are synchronized enough between each other.

I feel that there should be read barrier here. But it seems that more
barriers are missing. For example, let's have:


CPU0				CPU1

data_alloc()
  begin_lpos = atomic_read(data_ring->head_lpos);

				data_alloc()
				  data_push_tail()
				    cmpxchg(data_ring->tail_lpos);
				    // A: no barrier
				  cmpxchg(data_ring->head_lpos);

  data_push_tail()
    // B: no barrier
    tail_lpos = atomic_read(data_ring->tail_lpos);

Problem 1:

   CPU0 might see random ordering of data_ring->tail_lpos and
   head_lpos values modified by CPU1. There are missing both
   write and read barriers.


Problem 2:

   There might be still a chance because CPU0 does:

     if (!data_make_reusable())
       smp_rmb()
       tail_lpos = atomic_read(data_ring->tail_lpos);

   But CPU0 might still see old data_ring->tail because CPU1 did not
   do write barrier.


My proposal:

1. There should be full memory barrier on the location A before
   updating data_ring->head_lpos. It will be the same as the full
   barriers needed before updating data_ring->tail_lpos.

   data_ring->tail_lpos might have been pushed by another CPU.
   We need to make sure that all CPUs see all needed changes
   before we data_alloc() pushes head_lpos.


2. There should be read memory barrier in the location B.

   It is not strictly necessary because data_push_tail() tries
   to re-read data_ring->tail_lpos after a read barrier. But
   the re-read is just a fallback.

   The read barrier before the first read should be there to
   keep "clean" design ;-) Or there should be at least some
   comment about why the barrier is not there.

Best Regards,
Petr

> +
> +	do {
> +		/* Done, if the tail lpos is already at or beyond @lpos. */
> +		if ((lpos - tail_lpos) - 1 >= DATA_SIZE(data_ring))
> +			break;
> +
> +		/*
> +		 * Make all descriptors reusable that are associated with
> +		 * data blocks before @lpos.
> +		 */
> +		if (!data_make_reusable(rb, data_ring, tail_lpos, lpos,
> +					&next_lpos)) {
> +			/*
> +			 * Guarantee the descriptor state loaded in
> +			 * data_make_reusable() is performed before reloading
> +			 * the tail lpos. The failed data_make_reusable() may
> +			 * be due to a newly recycled descriptor causing
> +			 * the tail lpos to have been previously pushed. This
> +			 * pairs with desc_reserve:D.
> +			 *
> +			 * Memory barrier involvement:
> +			 *
> +			 * If data_make_reusable:D reads from desc_reserve:G,
> +			 * then data_push_tail:B reads from data_push_tail:D.
> +			 *
> +			 * Relies on:
> +			 *
> +			 * MB from data_push_tail:D to desc_reserve:G
> +			 *    matching
> +			 * RMB from data_make_reusable:D to data_push_tail:B
> +			 *
> +			 * Note: data_push_tail:D and desc_reserve:G can be
> +			 *       different CPUs. However, the desc_reserve:G
> +			 *       CPU (which performs the full memory barrier)
> +			 *       must have previously seen data_push_tail:D.
> +			 */
> +			smp_rmb(); /* LMM(data_push_tail:A) */
> +
> +			next_lpos = atomic_long_read(&data_ring->tail_lpos
> +						); /* LMM(data_push_tail:B) */
> +			if (next_lpos == tail_lpos)
> +				return false;
> +
> +			/* Another task pushed the tail. Try again. */
> +			tail_lpos = next_lpos;
> +			continue;
> +		}
> +
> +		/*
> +		 * Guarantee any descriptor states that have transitioned to
> +		 * reusable are stored before pushing the tail lpos. This
> +		 * allows readers to identify if data has expired while
> +		 * reading the descriptor. This pairs with desc_read:D.
> +		 */
> +		smp_mb(); /* LMM(data_push_tail:C) */
> +
> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->tail_lpos,
> +			&tail_lpos, next_lpos)); /* LMM(data_push_tail:D) */
> +
> +	return true;
> +}
> +
> +/*
> + * Allocate a new data block, invalidating the oldest data block(s)
> + * if necessary. This function also associates the data block with
> + * a specified descriptor.
> + */
> +static char *data_alloc(struct printk_ringbuffer *rb,
> +			struct prb_data_ring *data_ring, unsigned long size,
> +			struct prb_data_blk_lpos *blk_lpos, unsigned long id)
> +{
> +	struct prb_data_block *blk;
> +	unsigned long begin_lpos;
> +	unsigned long next_lpos;
> +
> +	if (!data_ring->data || size == 0) {
> +		/* Specify a data-less block. */
> +		blk_lpos->begin = INVALID_LPOS;
> +		blk_lpos->next = INVALID_LPOS;
> +		return NULL;
> +	}
> +
> +	size = to_blk_size(size);
> +
> +	begin_lpos = atomic_long_read(&data_ring->head_lpos);
> +
> +	do {
> +		next_lpos = get_next_lpos(data_ring, begin_lpos, size);
> +
> +		if (!data_push_tail(rb, data_ring,
> +				    next_lpos - DATA_SIZE(data_ring))) {
> +			/* Failed to allocate, specify a data-less block. */
> +			blk_lpos->begin = INVALID_LPOS;
> +			blk_lpos->next = INVALID_LPOS;
> +			return NULL;
> +		}
> +	} while (!atomic_long_try_cmpxchg_relaxed(&data_ring->head_lpos,
> +						  &begin_lpos, next_lpos));
> +
> +	/*
> +	 * Guarantee any updated tail lpos is stored before setting the new
> +	 * block ID. This allows block IDs to be trusted based on the tail
> +	 * lpos. A full memory barrier is needed since another task may
> +	 * have updated the tail lpos. This pairs with data_make_reusable:B.
> +	 */
> +	smp_mb(); /* LMM(data_alloc:A) */
> +
> +	blk = to_block(data_ring, begin_lpos);
> +	WRITE_ONCE(blk->id, id); /* LMM(data_alloc:B) */
> +
> +	if (DATA_WRAPS(data_ring, begin_lpos) !=
> +	    DATA_WRAPS(data_ring, next_lpos)) {
> +		/* Wrapping data blocks store their data at the beginning. */
> +		blk = to_block(data_ring, 0);
> +
> +		/*
> +		 * Store the ID on the wrapped block for consistency.
> +		 * The printk_ringbuffer does not actually use it.
> +		 */
> +		blk->id = id;
> +	}
> +
> +	blk_lpos->begin = begin_lpos;
> +	blk_lpos->next = next_lpos;
> +
> +	return &blk->data[0];
> +}
