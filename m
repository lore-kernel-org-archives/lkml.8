Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D980C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE83B24656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 12:06:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgBUMGA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 07:06:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:41802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726410AbgBUMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 07:06:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 245F0AC52;
        Fri, 21 Feb 2020 12:05:58 +0000 (UTC)
Date:   Fri, 21 Feb 2020 13:05:57 +0100
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
Subject: misc nits Re: [PATCH 1/2] printk: add lockless buffer
Message-ID: <20200221120557.lxpeoy6xuuqxzu5w@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-2-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200128161948.8524-2-john.ogness@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

there are few more small things that catched my eyes during review.
They are from the nits deparment.

On Tue 2020-01-28 17:25:47, John Ogness wrote:
> Introduce a multi-reader multi-writer lockless ringbuffer for storing
> the kernel log messages. Readers and writers may use their API from
> any context (including scheduler and NMI). This ringbuffer will make
> it possible to decouple printk() callers from any context, locking,
> or console constraints. It also makes it possible for readers to have
> full access to the ringbuffer contents at any time and context (for
> example from any panic situation).
> 
> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> new file mode 100644
> index 000000000000..796257f226ee
> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.c
> +/**
> + * DOC: printk_ringbuffer overview

I really like the overview.

> +/* A data block: maps to the raw data within the data ring. */
> +struct prb_data_block {
> +	unsigned long	id;
> +	char		data[0];
> +};
> +
> +
> +static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
> +				       unsigned long begin_lpos)
> +{
> +	char *data = &data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
> +
> +	return (struct prb_data_block *)data;

Nit: Please, use "blk" instead of "data". I was slightly confused
because "data" is also one member of struct prb_data_block.


> +/* The possible responses of a descriptor state-query. */
> +enum desc_state {
> +	desc_miss,	/* ID mismatch */
> +	desc_reserved,	/* reserved, but still in use by writer */
> +	desc_committed, /* committed, writer is done */
> +	desc_reusable,	/* free, not used by any writer */

s/not used/not yet used/

> +};

[...]

> +EXPORT_SYMBOL(prb_reserve);

Please, do not export symbols if there are no plans to actually
use them from modules. It will be easier to rework the code
in the future. Nobody would need to worry about external
users.

Please, do so everywhere in the patchset.

> +/*
> + * Given @blk_lpos, return a pointer to the raw data from the data block
> + * and calculate the size of the data part. A NULL pointer is returned
> + * if @blk_lpos specifies values that could never be legal.
> + *
> + * This function (used by readers) performs strict validation on the lpos
> + * values to possibly detect bugs in the writer code. A WARN_ON_ONCE() is
> + * triggered if an internal error is detected.
> + */
> +static char *get_data(struct prb_data_ring *data_ring,
> +		      struct prb_data_blk_lpos *blk_lpos,
> +		      unsigned long *data_size)
> +{
> +	struct prb_data_block *db;
> +
> +	/* Data-less data block description. */
> +	if (blk_lpos->begin == INVALID_LPOS &&
> +	    blk_lpos->next == INVALID_LPOS) {
> +		return NULL;

Nit: There is no need for "else" after return. checkpatch.pl usually
complains about it ;-)

> +
> +	/* Regular data block: @begin less than @next and in same wrap. */
> +	} else if (DATA_WRAPS(data_ring, blk_lpos->begin) ==
> +		   DATA_WRAPS(data_ring, blk_lpos->next) &&
> +		   blk_lpos->begin < blk_lpos->next) {
> +		db = to_block(data_ring, blk_lpos->begin);
> +		*data_size = blk_lpos->next - blk_lpos->begin;
> +
> +	/* Wrapping data block: @begin is one wrap behind @next. */
> +	} else if (DATA_WRAPS(data_ring,
> +			      blk_lpos->begin + DATA_SIZE(data_ring)) ==
> +		   DATA_WRAPS(data_ring, blk_lpos->next)) {
> +		db = to_block(data_ring, 0);
> +		*data_size = DATA_INDEX(data_ring, blk_lpos->next);
> +
> +	/* Illegal block description. */
> +	} else {
> +		WARN_ON_ONCE(1);
> +		return NULL;
> +	}
> +
> +	/* A valid data block will always be aligned to the ID size. */
> +	if (WARN_ON_ONCE(blk_lpos->begin !=
> +			 ALIGN(blk_lpos->begin, sizeof(db->id))) ||
> +	    WARN_ON_ONCE(blk_lpos->next !=
> +			 ALIGN(blk_lpos->next, sizeof(db->id)))) {
> +		return NULL;
> +	}
> +
> +	/* A valid data block will always have at least an ID. */
> +	if (WARN_ON_ONCE(*data_size < sizeof(db->id)))
> +		return NULL;
> +
> +	/* Subtract descriptor ID space from size to reflect data size. */
> +	*data_size -= sizeof(db->id);
> +
> +	return &db->data[0];
> +}
> +
> +/*
> + * Read the record @id and verify that it is committed and has the sequence
> + * number @seq. On success, 0 is returned.
> + *
> + * Error return values:
> + * -EINVAL: A committed record @seq does not exist.
> + * -ENOENT: The record @seq exists, but its data is not available. This is a
> + *          valid record, so readers should continue with the next seq.
> + */
> +static int desc_read_committed(struct prb_desc_ring *desc_ring,
> +			       unsigned long id, u64 seq,
> +			       struct prb_desc *desc)
> +{

I was few times confused whether this function reads the descriptor
a safe way or not.

Please, rename it to make it clear that does only a check.
For example, check_state_commited().

> +	enum desc_state d_state;
> +
> +	d_state = desc_read(desc_ring, id, desc);
> +	if (desc->info.seq != seq)
> +		return -EINVAL;
> +	else if (d_state == desc_reusable)
> +		return -ENOENT;
> +	else if (d_state != desc_committed)
> +		return -EINVAL;
> +
> +	return 0;
> +}

Best Regards,
Petr

PS: I am sorry that the review took me so much time. I was sick, had
some other work. And I wanted to have a free mind when thinking
about this lockless stuff. I think that it actually helped me to
realize the need of more barriers discussed in the other thread.
