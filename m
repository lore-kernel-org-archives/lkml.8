Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A87C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D305620848
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgCCJsB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:48:01 -0500
Received: from mx2.suse.de ([195.135.220.15]:52092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727818AbgCCJsB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:48:01 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D5375AD33;
        Tue,  3 Mar 2020 09:47:58 +0000 (UTC)
Date:   Tue, 3 Mar 2020 10:47:58 +0100
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
Message-ID: <20200303094758.ubylqjqns7zbg6gb@pathway.suse.cz>
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
> > OK, what about having desc_read_by_seq() instead?
> 
> Well, it isn't actually "reading by seq". @seq is there for additional
> verification. Yes, prb_read() is deriving @id from @seq. But it only
> does this once and uses that value for both calls.

I do not want to nitpick about words. If I get it properly,
the "id" is not important here. Any "id" is fine as long as
"seq" matches. Reading "id" once is just an optimization.

I do not resist on the change. It was just an idea how to
avoid confusion. I was confused more than once. But I might
be the only one. The more strightforward code looked more
important to me than the optimization.


> > Also there is a bug in current desc_read_commited().
> > desc->info.seq might contain a garbage when d_state is desc_miss
> > or desc_reserved.
> 
> It is not a bug. In both of those cases, -EINVAL is the correct return
> value.

No, it is a bug. If info is not read and contains garbage then the
following check may pass by chance:

	if (desc->info.seq != seq)
		return -EINVAL;

Then the function would return 0 even when desc_read() returned
desc_miss or desc_reserved.


> > I would change it to:
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

It is not error prone. If "id" changes then "seq" will not match.

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

Yes please, "else" is not needed.

> >
> > 	if (d_state != desc_committed)
> > 		return -EINVAL;
> 
> I suppose you meant to remove this check and leave in the @blk_lpos
> check instead.

Good catch, this check is superfluous.

> If we're trying to minimize lines of code, the @blk_lpos
> check could be combined with the "== desc_reusable" check as well.

Minimizing the lines of code was not my primary goal. I was just
confused by the function name. Also the fact that "seq" was the
important thing was well hidden.

Best Regards,
Petr

PS: I dived into the barriers and got lost. I hope that I will
be able to send something sensible in the end ;-)
