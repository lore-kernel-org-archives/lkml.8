Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA57EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0B252072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgIBK6i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:58:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:55574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBK63 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:58:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2EA8AAD49;
        Wed,  2 Sep 2020 10:58:28 +0000 (UTC)
Date:   Wed, 2 Sep 2020 12:58:26 +0200
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
Subject: Re: [PATCH next v3 6/8] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200902105826.GB15764@alley>
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
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> +/*
> + * Try to resize an existing data block associated with the descriptor
> + * specified by @id. If the resized datablock should become wrapped, it
> + * copies the old data to the new data block.
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
> +	if (next_lpos == head_lpos) {
> +		blk = to_block(data_ring, blk_lpos->begin);
> +		return &blk->data[0];
> +	}

We might be here even when the data are shrinked but the code below
is not fully ready for this.

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

It took me quite some time to check whether this code is correct or not.

First, I wondered whether the size was correctly calculated.
It is because the original block was not wrapped, so
lpos->next - lpos->beging defines the real data buffer size.

Second, I wondered whether the target block might be smaller
than the original (the above check allows shrinking). It can't
be smaller because then the new block won't be wrapped as well.

Sigh, it is a bit tricky. And there is 3rd possibility that
is not handled. The original block might be wrapped but
the new shrunken one might not longer be wrapped.
Then we would need to copy the data the other way.


I know that this function is not currently used for shrinking.
But I would prefer to be on the safe side. Either make
the copying generic, e.g. by calculating the real data size
using the code from get_data(). Or simply comletely
refuse shrinking by the above check.

Best Regards,
Petr

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
