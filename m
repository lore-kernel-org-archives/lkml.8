Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A84C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C463120771
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:39:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgHLQjM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:39:12 -0400
Received: from mx2.suse.de ([195.135.220.15]:45672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgHLQjK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:39:10 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9F277ACB0;
        Wed, 12 Aug 2020 16:39:30 +0000 (UTC)
Date:   Wed, 12 Aug 2020 18:39:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200812163908.GH12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811160551.GC12903@alley>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-08-11 18:05:51, Petr Mladek wrote:
> On Sat 2020-07-18 16:48:55, John Ogness wrote:
> > On 2020-07-17, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > > Make sure you test the case of "fast concurrent readers". The last
> > > time we did things like this, it was a disaster, because a concurrent
> > > reader would see and return the _incomplete_ line, and the next entry
> > > was still being generated on another CPU.
> > >
> > > The reader would then decide to return that incomplete line, because
> > > it had something.
> > >
> > > And while in theory this could then be handled properly in user space,
> > > in practice it wasn't. So you'd see a lot of logging tools that would
> > > then report all those continuations as separate log events.
> > >
> > > Which is the whole point of LOG_CONT - for that *not* to happen.
> > 
> > I expect this is handled correctly since the reader is not given any
> > parts until a full line is ready, but I will put more focus on testing
> > this to make sure. Thanks for the regression and testing tips.
> 
> Hmm, the current patchset has different problem. The continuation
> pieces are correctly passed as a single lines. But empty line is
> printed for each unused sequence number to avoid warnings about
> missed messages in journactl. It looks like:
> 
> I am afraid that the only working solution is to store all pieces
> in a single lockless transaction. I think that John already
> proposed using 2nd small lockless buffer for this. The problem
> might be how to synchronize flushing the pieces into the final
> buffer.

Do not panic! It might look scary. But I am less scared
after I wrote some pieces of the pseudo code.

So, I have one crazy idea to add one more state bit so that we
could have:

  + committed: set when the data are written into the data ring.
  + final: set when the data block could not longer get reopened
  + reuse: set when the desctiptor/data block could get reused


"final" bit will define when the descriptor could not longer
get reopened (cleared committed bit) and the data block could
not get extended.

The logic would be the following:

bool prb_reserve() {

	desc = try_reopen_desc(seq);
	if (desc) {
		text_buf = data_alloc_continuous();
		if (text_buf)
			goto success;
		else
			/* commit the reopened desc back again */
			prb_commit(desc);
	}

	/* Otherwise, do as before */
	desc = desc_reserve();
	if (!desc)
		goto fail;

	text_buf = data_alloc();
	...

where:

static struct prb_desc *try_reopen_desc(seq)
{
	struct prb_desc *desc;

	enum desc_state d_state;
	struct prb_desc desc;

	d_state = desc_read(desc_ring, seq, &desc);
	if (d_state != committed_and_not_finalized)
		return NULL;

	if (!is_same_context(desc))
		return NULL;

	/* try to reopen only when the state is still the same */
	if(!atomic_long_cmpxchg_relaxed(state_var,
					val_committed_and_not_finished,
					val_reserved))
		return NULL;

	return desc;
}

static char *data_alloc_continuous()
{
	/*
	 * Same as data_alloc() with one added parameter:
	 * unsigned long requested_begin_lpos;
	 */

	begin_lpos = atomic_long_read(&data_ring->head_lpos);

	do {
		if (begin_lpos != requested_begin_lpos)
			return NULL;

	... same as before

	} while (!atomic_long_try_cmpxchg(&data_ring->head_lpos, &begin_lpos,
					  next_lpos)); /* LMM(data_alloc:A) */

	if (requested_begin_lpos) {
		/* only update tail lpos */
		blk_lpos->next = next_lpos;
		/* return pointer to the new data space */
		return &blk->data[0];
	}

	/* For completely new block do everything as before */
	blk = to_block(data_ring, begin_lpos);
	blk->id = id; /* LMM(data_alloc:B) */
	...
}

void prb_commit_and_finalize()
{
	/* Same as prb_commit() + it will set also 'final' bit */
}


Addintional changes in the code:

+ desc_resrved() will also set 'final' bit in the previous
  descriptor so that the descriptor could not longer get reopended
  once committed.

+ prb_commit_and_finalize() will be called instead of prb_commit()
  when the message ends with '\n'.

+ prb_read() will allow to read the data only when
  the state is "committed_and_finalized".

+ desc_make_reusable() can be called only when the desciptor
  is in "commited_and_finalized" state.


I am not sure if it is everything. Also it might need some code
refactoring.

But it looks like it might work. And it should not require new barriers.
