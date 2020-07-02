Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19705C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCC772084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:35:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgGBIfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:35:22 -0400
Received: from mx2.suse.de ([195.135.220.15]:58144 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726445AbgGBIfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:35:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4E42DB1C4;
        Thu,  2 Jul 2020 08:35:19 +0000 (UTC)
Date:   Thu, 2 Jul 2020 10:35:18 +0200
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
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] printk: add lockless ringbuffer
Message-ID: <20200702083518.GB14288@alley>
References: <20200618144919.9806-1-john.ogness@linutronix.de>
 <20200618144919.9806-3-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618144919.9806-3-john.ogness@linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-06-18 16:55:18, John Ogness wrote:
> Introduce a multi-reader multi-writer lockless ringbuffer for storing
> the kernel log messages. Readers and writers may use their API from
> any context (including scheduler and NMI). This ringbuffer will make
> it possible to decouple printk() callers from any context, locking,
> or console constraints. It also makes it possible for readers to have
> full access to the ringbuffer contents at any time and context (for
> example from any panic situation).

Please, find few comments below. They are primary about improving
the comments. There are also 3 ideas how to clean up the code
a bit[*].

Everything might be solved by followup patches. Well, I would prefer
to update the comments in the next respin if you do it because
of the third patch.[**]

The small code changes can be done later. I do not want to introduce
eventual problems at this stage.

Feel free to use:

Reviewed-by: Petr Mladek <pmladek@suse.com>


[*] I have pretty good feeling about the code. And I really like the extensive
    comments. The remaining ideas are mostly from the nits department.

[**] We are getting close to push this into linux-next. I think that
     it makes sense only when also the 3rd patch is ready.

     Also we should have a solution for the crashdump/crash tools at hands.
     But I think that this is already the case.


> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.c
> + * Data Rings
> + * ~~~~~~~~~~
> + * The two data rings (text and dictionary) function identically. They exist
> + * separately so that their buffer sizes can be individually set and they do
> + * not affect one another.
> + *
> + * Data rings are byte arrays composed of data blocks. Data blocks are
> + * referenced by blk_lpos structs that point to the logical position of the
> + * beginning of a data block and the beginning of the next adjacent data
> + * block. Logical positions are mapped directly to index values of the byte
> + * array ringbuffer.
> + *
> + * Each data block consists of an ID followed by the raw data. The ID is the
> + * identifier of a descriptor that is associated with the data block. A data
> + * block is considered valid if all of the following conditions are met:
> + *
> + *   1) The descriptor associated with the data block is in the committed
> + *      or reusable queried state.

This sounds strange. The information in the descriptor is valid when
the descriptor is in the committed or reusable state. But the data
in the data block are valid only when the related descriptor is in
the committed state.

The data block might get reused faster than the descriptor that owned
it earlier.

> + *   2) The blk_lpos struct within the descriptor associated with the data
> + *      block references back to the same data block.

This is true. But this cross check is needed only when the assocoated
descriptor is found via the ID stored in the data block. It is not
needed when the data block is found via id/seq number stored in
the descriptor that is in commited state.


> + *   3) The data block is within the head/tail logical position range.

Also this is true. But it works by design. It does not need to be
checked when validating the data.

I would like to make this clear. So, I would write something like:


  The raw data stored in a data block can be considered valid when the
  the associated descriptor is in the committed state.

  The above condition is enough when the data block is found via
  information from the descriptor that was chosen by its ID.

  One more check is needed when the data block is found via
  blk_lpos.next stored in the descriptor for the previous data block.
  The data block might point to a descriptor in a committed state just
  by chance. It is the right one only when blk_lpos.begin points back
  to the data block.

I do not know. It might be to complicated. I actually did not mind
about the original text in previous versions. But I realize now that
it might have been the reason why the checks in data_make_reusable()
were too complicated in the previous versions.



> + * Sample reader code::
> + *
> + *	struct printk_info info;
> + *	struct printk_record r;
> + *	char text_buf[32];
> + *	char dict_buf[32];
> + *	u64 seq;
> + *
> + *	prb_rec_init_rd(&r, &info, &text_buf[0], sizeof(text_buf),
> + *			&dict_buf[0], sizeof(dict_buf));
> + *
> + *	prb_for_each_record(0, &test_rb, &seq, &r) {
> + *		if (info.seq != seq)
> + *			pr_warn("lost %llu records\n", info.seq - seq);
> + *
> + *		if (info.text_len > r.text_buf_size) {
> + *			pr_warn("record %llu text truncated\n", info.seq);
> + *			text_buf[sizeof(text_buf) - 1] = 0;
> + *		}

AFAIK, the trailing '\0' is missing even the the text is not
truncated. We need to always add it here. Otherwise, we could not
print the text using %s below.

Also it means that it is not safe to copy the text using
memcpy(new_buf, &r.text_buf[0], r.text_len) because r.text_len
might be greater than r.text_bug_size.

I would prefer a more safe API where r.text_len is set to
the length that is really stored r.text_buf. The information
about truncation might be passed via another struct member,
e.g. r.text_truncated or so.

Well, this might be done later. The printk() code does not have
this problem because the length of the stored messages is
limited on the store side. The reader side uses buffers that
are always big enough. But I consider this error prone and
non-intuitive. It might hit us in the long term.


> + *
> + *		if (info.dict_len > r.dict_buf_size) {
> + *			pr_warn("record %llu dict truncated\n", info.seq);
> + *			dict_buf[sizeof(dict_buf) - 1] = 0;
> + *		}
> + *
> + *		pr_info("%llu: %llu: %s;%s\n", info.seq, info.ts_nsec,
> + *			&text_buf[0], info.dict_len ? &dict_buf[0] : "");
> + *	}
> + *
> + * Note that additional less convenient reader functions are available to
> + * allow complex record access.
> + *
> + * ABA Issues
> + * ~~~~~~~~~~
> + * To help avoid ABA issues, descriptors are referenced by IDs (array index
> + * values with tagged states)

"array index values" makes the feeling that it is a direct position in
the array. We should make it clear that it is growing with each
overlap.

Also my understanding is that "tagged states" are the two bits.

See below for an alternative text.

> + *  and data blocks are referenced by logical
> + * positions (array index values with tagged states).

Finally, lpos does does not include the tagged state. Or the meaning of "tagged
state" is rather confusing.

I would replace this with something like:

   To help avoid ABA issues, both descriptors and data blocks are
   referenced by logical positions that are growing with each
   wrap. Where the position of the descriptor is stored together
   with the state bits so that they can be manipulated atomically.

> + * However, on 32-bit
> + * systems the number of tagged states is relatively small such that an ABA

"tagged states" ? Should it be "number of logical positions"

> + * incident is (at least theoretically) possible. For example, if 4 million
> + * maximally sized (1KiB) printk messages were to occur in NMI context on a
> + * 32-bit system, the interrupted context would not be able to recognize that
> + * the 32-bit integer completely wrapped and thus represents a different
> + * data block than the one the interrupted context expects.
> + *
> + * To help combat this possibility, additional state checking is performed
> + * (such as using cmpxchg() even though set() would suffice). These extra
> + * checks are commented as such and will hopefully catch any ABA issue that
> + * a 32-bit system might experience.
> + *
> + * Memory Barriers
> + * ~~~~~~~~~~~~~~~
> + * Multiple memory barriers are used. To simplify proving correctness and
> + * generating litmus tests, lines of code related to memory barriers
> + * (loads, stores, and the associated memory barriers) are labeled::
> + *
> + *	LMM(function:letter)
> + *
> + * Comments reference the labels using only the "function:letter" part.
> + *
> + * The memory barrier pairs and their ordering are:
> + *
> + *   desc_reserve:D / desc_reserve:B
> + *     push descriptor tail (id), then push descriptor head (id)
> + *
> + *   desc_reserve:D / data_push_tail:B
> + *     push data tail (lpos), then set new descriptor reserved (state)
> + *
> + *   desc_reserve:D / desc_push_tail:C
> + *     push descriptor tail (id), then set new descriptor reserved (state)
> + *
> + *   desc_reserve:D / prb_first_seq:C
> + *     push descriptor tail (id), then set new descriptor reserved (state)
> + *
> + *   desc_reserve:F / desc_read:D
> + *     set new descriptor id and reserved (state), then allow writer changes
> + *
> + *   data_alloc:A / desc_read:D
> + *     set old descriptor reusable (state), then modify new data block area
> + *
> + *   data_alloc:A / data_push_tail:B
> + *     push data tail (lpos), then modify new data block area
> + *
> + *   prb_commit:B / desc_read:B
> + *     store writer changes, then set new descriptor committed (state)
> + *
> + *   data_push_tail:D / data_push_tail:A
> + *     set descriptor reusable (state), then push data tail (lpos)
> + *
> + *   desc_push_tail:B / desc_reserve:D
> + *     set descriptor reusable (state), then push descriptor tail (id)

I am not sure that this list is really needs. It might get outdated
easily. It does not help me to make sure that all these barriers
are enough to keep the consistency.

That said, feel free to keep it if it helps anyone.

> + */
> +
> +#define DATA_SIZE(data_ring)		_DATA_SIZE((data_ring)->size_bits)
> +#define DATA_SIZE_MASK(data_ring)	(DATA_SIZE(data_ring) - 1)
> +
> +#define DESCS_COUNT(desc_ring)		_DESCS_COUNT((desc_ring)->count_bits)
> +#define DESCS_COUNT_MASK(desc_ring)	(DESCS_COUNT(desc_ring) - 1)
> +
> +/* Determine the data array index from a logical position. */
> +#define DATA_INDEX(data_ring, lpos)	((lpos) & DATA_SIZE_MASK(data_ring))
> +
> +/* Determine the desc array index from an ID or sequence number. */
> +#define DESC_INDEX(desc_ring, n)	((n) & DESCS_COUNT_MASK(desc_ring))
> +
> +/* Determine how many times the data array has wrapped. */
> +#define DATA_WRAPS(data_ring, lpos)	((lpos) >> (data_ring)->size_bits)
> +
> +/* Get the logical position at index 0 of the current wrap. */
> +#define DATA_THIS_WRAP_START_LPOS(data_ring, lpos) \
> +((lpos) & ~DATA_SIZE_MASK(data_ring))
> +
> +/* Get the ID for the same index of the previous wrap as the given ID. */
> +#define DESC_ID_PREV_WRAP(desc_ring, id) \
> +DESC_ID((id) - DESCS_COUNT(desc_ring))
> +
> +/* A data block: maps to the raw data within the data ring. */

"raw data" is ambiguous here. Does it mean "data" array or the entire
structure. See below for an alternative text.

> +struct prb_data_block {
> +	unsigned long	id;
> +	char		data[0];
> +};

I think that the relation between desc.state_val, id, and, and state
bits is not descried anywhere. It might be confusing for someone
trying to understand the code for the first time.

Also we should make it clear that id is the logical position without
the state bits. For example, the meaning of DESC_COUNT, DATA_SIZE

It might really help to describe of all struct members here, e.g.

/**
 * struct prb_data_block: maps to the data block stored in the data ring
 *
 * @id: logical position in desc array (without state bits)
 * @data[0]: raw data stored by the writer
 */
struct prb_data_block {
	unsigned long	id;
	char		data[0];
};

> +
> +static struct prb_desc *to_desc(struct prb_desc_ring *desc_ring, u64 n)

This might deserve a description of possible n values: id, seq, state_val.


> +{
> +	return &desc_ring->descs[DESC_INDEX(desc_ring, n)];
> +}
> +


> +/*
> + * Allocate a new data block, invalidating the oldest data block(s)
> + * if necessary. This function also associates the data block with
> + * a specified descriptor.
> + */
> +static char *data_alloc(struct printk_ringbuffer *rb,
> +			struct prb_data_ring *data_ring, unsigned int size,
> +			struct prb_data_blk_lpos *blk_lpos, unsigned long id)
> +{
> +	struct prb_data_block *blk;
> +	unsigned long begin_lpos;
> +	unsigned long next_lpos;
> +
> +	if (!data_ring->data || size == 0) {

Is there any specific reason to check data_ring->data is not NULL,
please? It is not a bit deal. I am just curious because it is
not checked on other locations.

> +		/* Specify a data-less block. */
> +		blk_lpos->begin = INVALID_LPOS;
> +		blk_lpos->next = INVALID_LPOS;
> +		return NULL;
> +	}


> +/**
> + * prb_next_seq() - Get the sequence number after the last available record.
> + *
> + * @rb:  The ringbuffer to get the sequence number from.
> + *
> + * This is the public function available to readers to see what the next
> + * newest sequence number available to readers will be.
> + *
> + * This provides readers a sequence number to jump to if all currently
> + * available records should be skipped.
> + *
> + * Context: Any context.
> + * Return: The sequence number of the next newest (not yet available) record
> + *         for readers.
> + */
> +u64 prb_next_seq(struct printk_ringbuffer *rb)
> +{
> +	u64 seq = 0;
> +
> +	do {
> +		/* Search forward from the oldest descriptor. */
> +		if (!_prb_read_valid(rb, &seq, NULL, NULL))
> +			return seq;
> +		seq++;
> +	} while (seq);

seq should never become zero here. It would take ages to overflow
and just creates false assumption about the logic. I would replace
this with for(;;)

> +
> +	return 0;
> +}
> +


> --- /dev/null
> +++ b/kernel/printk/printk_ringbuffer.h
> @@ -0,0 +1,352 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#ifndef _KERNEL_PRINTK_RINGBUFFER_H
> +#define _KERNEL_PRINTK_RINGBUFFER_H
> +
> +#include <linux/atomic.h>
> +

It might be worth to add some information. And maybe also define who
is supposed to manipulate the struct members.

/*
 * Meta information about each stored message.
 *
 * They are stored and used by printk code. The only exception are:
 * seq, text_len, dict_len that are handled also in the ringbuffer
 * code.
 */

> +struct printk_info {
> +	u64	seq;		/* sequence number */
> +	u64	ts_nsec;	/* timestamp in nanoseconds */
> +	u16	text_len;	/* length of text message */
> +	u16	dict_len;	/* length of dictionary message */
> +	u8	facility;	/* syslog facility */
> +	u8	flags:5;	/* internal record flags */
> +	u8	level:3;	/* syslog level */
> +	u32	caller_id;	/* thread id or processor id */
> +};



> +/* Specifies the position/span of a data block. */

s/position/logical position/

> +struct prb_data_blk_lpos {
> +	unsigned long	begin;
> +	unsigned long	next;
> +};
> +
> +/* A descriptor: the complete meta-data for a record. */

state_var might deserve some description, e.g.

 * @state_var combines logical position of the descriptor
 * in the array ring buffer (id) and two state bits.

> +struct prb_desc {
> +	struct printk_info		info;
> +	atomic_long_t			state_var;
> +	struct prb_data_blk_lpos	text_blk_lpos;
> +	struct prb_data_blk_lpos	dict_blk_lpos;
> +};
> +
> +/* A ringbuffer of "ID + data" elements. */
> +struct prb_data_ring {
> +	unsigned int	size_bits;
> +	char		*data;
> +	atomic_long_t	head_lpos;
> +	atomic_long_t	tail_lpos;
> +};
> +
> +/* A ringbuffer of "struct prb_desc" elements. */
> +struct prb_desc_ring {
> +	unsigned int		count_bits;
> +	struct prb_desc		*descs;
> +	atomic_long_t		head_id;
> +	atomic_long_t		tail_id;
> +};
> +
> +/* The high level structure representing the printk ringbuffer. */

@fault might desrve some comment, .e.g.

 * @fail: automatically counted number of failed prb_reserve() calls.

> +struct printk_ringbuffer {
> +	struct prb_desc_ring	desc_ring;
> +	struct prb_data_ring	text_data_ring;
> +	struct prb_data_ring	dict_data_ring;
> +	atomic_long_t		fail;
> +};
> +
> +/* Used by writers as a reserve/commit handle. */

We should emphasise that is should be manipulated only by
the ring_buffer code. Also @id and @text_space might deserve
some explanation. I think that it is better to use the full
description here:

/**
 * struct prb_reserved_entry - reserve/commit handle used
 *	by writers and readers.
 *
 * @rb:		ring buffer where the entry has been reserved
 * @irqflags:	saved irq flags to be used when the entry gets committed
 * @id:		logical position of the reserved descriptor
 * @text_space:	Really used space in text data ring, including
 *		the stored "id" and  and alignment
 *
 * It must be manipulated only by the ring buffer code.
 */

> +struct prb_reserved_entry {
> +	struct printk_ringbuffer	*rb;
> +	unsigned long			irqflags;
> +	unsigned long			id;
> +	unsigned int			text_space;
> +};


> +/**
> + * prb_for_each_record() - Iterate over a ringbuffer.
> + *
> + * @from: The sequence number to begin with.
> + * @rb:   The ringbuffer to iterate over.
> + * @s:    A u64 to store the sequence number on each iteration.
> + * @r:    A printk_record to store the record on each iteration.
> + *
> + * This is a macro for conveniently iterating over a ringbuffer.

It might be worth emphasizing that @s is internal value. The reader
should check r->seq to see that acutally read sequence number.

IMHO, it is not clearly visible from the code. At least, I had
to check prb_read_valid() to realize this,

> + *
> + * Context: Any context.
> + */
> +#define prb_for_each_record(from, rb, s, r) \
> +for ((s) = from; prb_read_valid(rb, s, r); (s) = (r)->info->seq + 1)

That's it. Uff, it is a huge relief that there was nothing memory
barriers related ;-)

Best Regards,
Petr
