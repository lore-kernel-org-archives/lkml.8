Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A701C3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 500772173E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgCBMcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:32:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:55726 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727644AbgCBMcx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:32:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8467FAC9A;
        Mon,  2 Mar 2020 12:32:51 +0000 (UTC)
Date:   Mon, 2 Mar 2020 13:32:49 +0100
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
Subject: Re: misc nits Re: [PATCH 1/2] printk: add lockless buffer
Message-ID: <20200302123249.6khdqpneu7t6l35s@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-2-john.ogness@linutronix.de>
 <20200221120557.lxpeoy6xuuqxzu5w@pathway.suse.cz>
 <87r1ybujm5.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1ybujm5.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-03-02 11:38:42, John Ogness wrote:
> On 2020-02-21, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >> new file mode 100644
> >> index 000000000000..796257f226ee
> >> --- /dev/null
> >> +++ b/kernel/printk/printk_ringbuffer.c
> >> +/*
> >> + * Read the record @id and verify that it is committed and has the sequence
> >> + * number @seq. On success, 0 is returned.
> >> + *
> >> + * Error return values:
> >> + * -EINVAL: A committed record @seq does not exist.
> >> + * -ENOENT: The record @seq exists, but its data is not available. This is a
> >> + *          valid record, so readers should continue with the next seq.
> >> + */
> >> +static int desc_read_committed(struct prb_desc_ring *desc_ring,
> >> +			       unsigned long id, u64 seq,
> >> +			       struct prb_desc *desc)
> >> +{
> >
> > I was few times confused whether this function reads the descriptor
> > a safe way or not.
> >
> > Please, rename it to make it clear that does only a check.
> > For example, check_state_commited().
> 
> This function _does_ read. It is a helper function of prb_read() to
> _read_ the descriptor. It is an extended version of desc_read() that
> also performs various checks that the descriptor is committed.

I see.

> I will update the function description to be more similar to desc_read()
> so that it is obvious that it is "getting a copy of a specified
> descriptor".

OK, what about having desc_read_by_seq() instead?

Also there is a bug in current desc_read_commited().
desc->info.seq might contain a garbage when d_state is desc_miss
or desc_reserved.

I would change it to:

static enum desc_state
desc_read_by_seq(struct prb_desc_ring *desc_ring,
		 u64 seq, struct prb_desc *desc)
{
	struct prb_desc *rdesc = to_desc(desc_ring, seq);
	atomic_long_t *state_var = &rdesc->state_var;
	id = DESC_ID(atomic_long_read(state_var));
	enum desc_state d_state;

	d_state = desc_read(desc_ring, id, desc);
	if (d_state == desc_miss ||
	    d_state == desc_reserved ||
	    desc->info.seq != seq)
		return -EINVAL;

	if (d_state == desc_reusable)
		return -ENOENT;

	if (d_state != desc_committed)
		return -EINVAL;

	return 0;
}

Best Regards,
Petr

PS: I am going to dive into the barriers again to answer the last
letter about them.
