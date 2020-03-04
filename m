Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70139C3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:40:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5082F20848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgCDJkR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:40:17 -0500
Received: from mx2.suse.de ([195.135.220.15]:47154 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbgCDJkQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:40:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C35F3ADBB;
        Wed,  4 Mar 2020 09:40:14 +0000 (UTC)
Date:   Wed, 4 Mar 2020 10:40:14 +0100
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
Message-ID: <20200304094014.dua4ydwat5l6lvfs@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-2-john.ogness@linutronix.de>
 <20200221120557.lxpeoy6xuuqxzu5w@pathway.suse.cz>
 <87r1ybujm5.fsf@linutronix.de>
 <20200302123249.6khdqpneu7t6l35s@pathway.suse.cz>
 <87a74yrhwy.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a74yrhwy.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2020-03-02 14:43:41, John Ogness wrote:
> On 2020-03-02, Petr Mladek <pmladek@suse.com> wrote:
> >>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >>>> new file mode 100644
> >>>> index 000000000000..796257f226ee
> >>>> --- /dev/null
> >>>> +++ b/kernel/printk/printk_ringbuffer.c
> >>>> +/*
> >>>> + * Read the record @id and verify that it is committed and has the sequence
> >>>> + * number @seq. On success, 0 is returned.
> >>>> + *
> >>>> + * Error return values:
> >>>> + * -EINVAL: A committed record @seq does not exist.
> >>>> + * -ENOENT: The record @seq exists, but its data is not available. This is a
> >>>> + *          valid record, so readers should continue with the next seq.
> >>>> + */
> >>>> +static int desc_read_committed(struct prb_desc_ring *desc_ring,
> >>>> +			       unsigned long id, u64 seq,
> >>>> +			       struct prb_desc *desc)
> >>>> +{
> >
> > static enum desc_state
> > desc_read_by_seq(struct prb_desc_ring *desc_ring,
> > 		 u64 seq, struct prb_desc *desc)
> > {
> > 	struct prb_desc *rdesc = to_desc(desc_ring, seq);
> > 	atomic_long_t *state_var = &rdesc->state_var;
> > 	id = DESC_ID(atomic_long_read(state_var));
> 
> I think it is error-prone to re-read @state_var here. It is lockless
> shared data. desc_read_committed() is called twice in prb_read() and it
> is expected that both calls are using the same @id.
> 
> > 	enum desc_state d_state;
> >
> > 	d_state = desc_read(desc_ring, id, desc);
> > 	if (d_state == desc_miss ||
> > 	    d_state == desc_reserved ||
> > 	    desc->info.seq != seq)
> > 		return -EINVAL;
> >
> > 	if (d_state == desc_reusable)
> > 		return -ENOENT;
> 
> I can use this refactoring.
> 
> >
> > 	if (d_state != desc_committed)
> > 		return -EINVAL;
> 
> I suppose you meant to remove this check and leave in the @blk_lpos
> check instead. If we're trying to minimize lines of code, the @blk_lpos
> check could be combined with the "== desc_reusable" check as well.

I am an idiot. I missed that the check "d_state != desc_committed"
will return -EINVAL also when desc_miss or desc_reserved.

I was too concentrated by the fact that desc->info.seq was checked
first even though it might contain garbage.

Also it did not help me much the note about blk_lpos. I did not
see how it was related to this code.

To sum up. The original code worked fine. But I would prefer my variant
that has more lines but it is somehow cleaner.

Best Regards,
Petr
