Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22763C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E452920829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 10:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgIBKwy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 06:52:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:52170 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBKwx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 06:52:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CCCFAAD7B;
        Wed,  2 Sep 2020 10:52:52 +0000 (UTC)
Date:   Wed, 2 Sep 2020 12:52:50 +0200
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
Subject: state names: vas: Re: [PATCH next v3 6/8] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200902105250.GA15764@alley>
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
 
> --- a/kernel/printk/printk_ringbuffer.c
> +++ b/kernel/printk/printk_ringbuffer.c
> @@ -49,14 +49,16 @@
>   * Descriptors have three states:
>   *
>   *   reserved
> - *     A writer is modifying the record.
> + *     A writer is modifying the record. Internally represented as either "0"
> + *     or "DESC_COMMIT_MASK".

We should explain the difference between the two values. It might be
enough to add something like:

    See "Descriptor Finalization" section for more details."

> @@ -79,6 +81,25 @@
>   * committed or reusable queried state. This makes it possible that a valid
>   * sequence number of the tail is always available.
>   *
> + * Descriptor Finalization
> + * ~~~~~~~~~~~~~~~~~~~~~~~
> + * When a writer calls the commit function prb_commit(), the record may still
> + * continue to be in the reserved queried state. In order for that record to
> + * enter into the committed queried state, that record also must be finalized.
> + * A record can be finalized by three different scenarios:
> + *
> + *   1) A writer can finalize its record immediately by calling
> + *      prb_final_commit() instead of prb_commit().
> + *
> + *   2) When a new record is reserved and the previous record has been
> + *      committed via prb_commit(), that previous record is finalized.
> + *
> + *   3) When a record is committed via prb_commit() and a newer record
> + *      already exists, the record being committed is finalized.
> + *
> + * Until a record is finalized (represented by "DESC_FINAL_MASK"), a writer
> + * may "reopen" that record and extend it with more data.
> + *
>   * Data Rings
>   * ~~~~~~~~~~
>   * The two data rings (text and dictionary) function identically. They exist

[...]

> +/*
> + * Attempt to remove the commit flag so that the record can be modified by a
> + * writer again. This is only possible if the descriptor is not yet finalized.
> + *
> + * Note that on success, the queried state did not change. A non-finalized
> + * record (even with the commit flag set) is in the reserved queried state.
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
> +	 * To minimize unnecessarily reopening a descriptor, first check the
> +	 * descriptor is in the correct state and has a matching caller ID.
> +	 */
> +	d_state = desc_read(desc_ring, id, &desc);
> +	if (d_state != desc_reserved ||
> +	    !(atomic_long_read(&desc.state_var) & DESC_COMMIT_MASK) ||

This looks like a hack. And similar extra check of the bit is needed
also in desc_read(), see
https://lore.kernel.org/r/878sdvq8kd.fsf@jogness.linutronix.de

I has been actually getting less and less happy with the inconsistency
between names of the bits and states.

Sigh, you will hate me because this would mean a bigger change.
IMHO, it would be much cleaner and help with long-term maintainability
when we do the following two changes:

First, define 5 desc_states, something like:

enum desc_state {
	desc_miss = -1,		/* ID mismatch */
	desc_modified =	 0x0,	/* reserved, being modified by writer */
	desc_committed = 0x1,	/* committed by writer, could get reopened */
	desc_finalized = 0x2,	/* committed, could not longer get modified */
	desc_reusable =	 0x3,	/* free, not yet used by any writer */
};

Second, only 4 variants of the 3 state bits are currently used.
It means that two bits are enough and they might use exactly
the above names:

I mean to do something like:

#define DESC_SV_BITS		(sizeof(unsigned long) * 8)
#define DESC_SV(desc_state)	((unsigned long)desc_state << (DESC_SV_BITS - 2))
#define DESC_ST(state_val)	((unsigned long)state_val >> (DESC_SV_BITS - 2))


Then we could have:

static enum desc_state get_desc_state(unsigned long id,
				      unsigned long state_val)
{
	if (id != DESC_ID(state_val))
		return desc_miss;

	return DESC_ST(state_val);
}

and use in the code:

unsigned long val_committed = id | DESC_SV(desc_committed);


or do

#define DESC_SV(id, desc_state)	(id | (unsigned long)desc_state << (DESC_SV_BITS - 2))

and then use DESC_SV(id, DESC_COMMITTED).


I am sorry that I did not came up with this earlier. I know how
painful it is to rework bigger patchsets. But it affects format
of the ring buffer, so we should do it early.

Best Regards,
Petr

PS: I am still middle of review. It looks good so far. I wanted to
send this early and separately because it is a bigger change.
