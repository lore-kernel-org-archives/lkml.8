Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41658C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F9E420863
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 10:38:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727683AbgCBKiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 05:38:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41555 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727095AbgCBKiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 05:38:50 -0500
Received: from localhost ([127.0.0.1] helo=vostro.local)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <john.ogness@linutronix.de>)
        id 1j8iTF-0007Y6-Vv; Mon, 02 Mar 2020 11:38:46 +0100
From:   John Ogness <john.ogness@linutronix.de>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: misc nits Re: [PATCH 1/2] printk: add lockless buffer
References: <20200128161948.8524-1-john.ogness@linutronix.de>
        <20200128161948.8524-2-john.ogness@linutronix.de>
        <20200221120557.lxpeoy6xuuqxzu5w@pathway.suse.cz>
Date:   Mon, 02 Mar 2020 11:38:42 +0100
Message-ID: <87r1ybujm5.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
>> new file mode 100644
>> index 000000000000..796257f226ee
>> --- /dev/null
>> +++ b/kernel/printk/printk_ringbuffer.c
>> +static struct prb_data_block *to_block(struct prb_data_ring *data_ring,
>> +				       unsigned long begin_lpos)
>> +{
>> +	char *data = &data_ring->data[DATA_INDEX(data_ring, begin_lpos)];
>> +
>> +	return (struct prb_data_block *)data;
>
> Nit: Please, use "blk" instead of "data". I was slightly confused
> because "data" is also one member of struct prb_data_block.

OK.

>> +/* The possible responses of a descriptor state-query. */
>> +enum desc_state {
>> +	desc_miss,	/* ID mismatch */
>> +	desc_reserved,	/* reserved, but still in use by writer */
>> +	desc_committed, /* committed, writer is done */
>> +	desc_reusable,	/* free, not used by any writer */
>
> s/not used/not yet used/

OK.

>> +EXPORT_SYMBOL(prb_reserve);
>
> Please, do not export symbols if there are no plans to actually
> use them from modules. It will be easier to rework the code
> in the future. Nobody would need to worry about external
> users.
>
> Please, do so everywhere in the patchset.

You are correct.

The reason I exported them is that I could run my test module. But since
the test module will not be part of the kernel source, I'll just hack
the exports in when doing my testing.

>> +static char *get_data(struct prb_data_ring *data_ring,
>> +		      struct prb_data_blk_lpos *blk_lpos,
>> +		      unsigned long *data_size)
>> +{
>> +	struct prb_data_block *db;
>> +
>> +	/* Data-less data block description. */
>> +	if (blk_lpos->begin == INVALID_LPOS &&
>> +	    blk_lpos->next == INVALID_LPOS) {
>> +		return NULL;
>
> Nit: There is no need for "else" after return. checkpatch.pl usually
> complains about it ;-)

OK.

>> +/*
>> + * Read the record @id and verify that it is committed and has the sequence
>> + * number @seq. On success, 0 is returned.
>> + *
>> + * Error return values:
>> + * -EINVAL: A committed record @seq does not exist.
>> + * -ENOENT: The record @seq exists, but its data is not available. This is a
>> + *          valid record, so readers should continue with the next seq.
>> + */
>> +static int desc_read_committed(struct prb_desc_ring *desc_ring,
>> +			       unsigned long id, u64 seq,
>> +			       struct prb_desc *desc)
>> +{
>
> I was few times confused whether this function reads the descriptor
> a safe way or not.
>
> Please, rename it to make it clear that does only a check.
> For example, check_state_commited().

This function _does_ read. It is a helper function of prb_read() to
_read_ the descriptor. It is an extended version of desc_read() that
also performs various checks that the descriptor is committed.

I will update the function description to be more similar to desc_read()
so that it is obvious that it is "getting a copy of a specified
descriptor".

John Ogness
