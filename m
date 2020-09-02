Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96197C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B0DA20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 12:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgIBMkH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 08:40:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:55092 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgIBMjj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 08:39:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B4F83B12A;
        Wed,  2 Sep 2020 12:39:38 +0000 (UTC)
Date:   Wed, 2 Sep 2020 14:39:36 +0200
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
Subject: Re: state names: vas: Re: [PATCH next v3 6/8] printk: ringbuffer:
 add finalization/extension support
Message-ID: <20200902123936.GC9496@alley>
References: <20200831011058.6286-1-john.ogness@linutronix.de>
 <20200831011058.6286-7-john.ogness@linutronix.de>
 <20200902105250.GA15764@alley>
 <87r1rkctn5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1rkctn5.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-09-02 13:26:14, John Ogness wrote:
> On 2020-09-02, Petr Mladek <pmladek@suse.com> wrote:
> >> +static struct prb_desc *desc_reopen_last(struct prb_desc_ring *desc_ring,
> >> +					 u32 caller_id, unsigned long *id_out)
> >> +{
> >> +	unsigned long prev_state_val;
> >> +	enum desc_state d_state;
> >> +	struct prb_desc desc;
> >> +	struct prb_desc *d;
> >> +	unsigned long id;
> >> +
> >> +	id = atomic_long_read(&desc_ring->head_id);
> >> +
> >> +	/*
> >> +	 * To minimize unnecessarily reopening a descriptor, first check the
> >> +	 * descriptor is in the correct state and has a matching caller ID.
> >> +	 */
> >> +	d_state = desc_read(desc_ring, id, &desc);
> >> +	if (d_state != desc_reserved ||
> >> +	    !(atomic_long_read(&desc.state_var) & DESC_COMMIT_MASK) ||
> >
> > First, define 5 desc_states, something like:
> >
> > enum desc_state {
> > 	desc_miss = -1,		/* ID mismatch */
> > 	desc_modified =	 0x0,	/* reserved, being modified by writer */
> 
> I prefer the "desc_reserved" name. It may or may not have be modified yet.

Yeah, "desc_reserved" sounds better. I probably just wanted to free my
fantasy from the current code ;-)


> > 	desc_committed = 0x1,	/* committed by writer, could get reopened */
> > 	desc_finalized = 0x2,	/* committed, could not longer get modified */
> > 	desc_reusable =	 0x3,	/* free, not yet used by any writer */
> > };
> >
> > Second, only 4 variants of the 3 state bits are currently used.
> > It means that two bits are enough and they might use exactly
> > the above names:
> >
> > I mean to do something like:
> >
> > #define DESC_SV_BITS		(sizeof(unsigned long) * 8)
> > #define DESC_SV(desc_state)	((unsigned long)desc_state << (DESC_SV_BITS - 2))
> > #define DESC_ST(state_val)	((unsigned long)state_val >> (DESC_SV_BITS - 2))
> 
> This makes sense and will get us back the bit we lost because of
> finalization.

Yup. Which is good especially on 32-bit architectures.

> I am wondering if VMCOREINFO should include a DESC_FLAGS_MASK so that
> crash tools could at least successfully iterate the ID's, even if they
> didn't know what all the flag values mean (in the case that more bits
> are added later).

Good point. I am just not sure whether they should try read all ids
or they should refuse reading anything when a new bit is added.

Well, I really hope that we will not need new states anytime soon.
It would need a really strong reason.

I personally can't think about any use case. pr_cont() was special
because it was the writer side. All other steps of the printk rework
are on the reader side.

I believe that we are getting close with all the ring buffer code.
And I have good feeling about it.

Best Regards,
Petr
