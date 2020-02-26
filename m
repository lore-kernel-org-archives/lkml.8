Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156AEC4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47E52467B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBZJy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:54:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:42714 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbgBZJy7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:54:59 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4AD63AAB8;
        Wed, 26 Feb 2020 09:54:57 +0000 (UTC)
Date:   Wed, 26 Feb 2020 10:54:56 +0100
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
Subject: Re: misc details: Re: [PATCH 2/2] printk: use the lockless ringbuffer
Message-ID: <20200226095456.zrp256asr5ozvlf3@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-3-john.ogness@linutronix.de>
 <20200217144110.xiqlzhs6ynoqdpun@pathway.suse.cz>
 <87h7zeqvf0.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h7zeqvf0.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-02-25 21:11:31, John Ogness wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> - * Every record carries the monotonic timestamp in microseconds, as well as
> >> - * the standard userspace syslog level and syslog facility. The usual
> >> + * Every record meta-data carries the monotonic timestamp in microseconds, as
> >
> > I am afraid that we could not guarantee monotonic timestamp because
> > the writers are not synchronized. I hope that it will not create
> > real problems and we could just remove the word "monotonic" ;-)
> 
> I removed "monotonic". I hope userspace doesn't require the ringbuffer
> to be chronologically sorted. That would explain why the safe buffers
> use bogus timestamps. :-/

The timestamp was not stored into the safe buffers to keep the code
simple. And people request to add the proper timestamps from time
to time.

IMHO, the precise timestamps are more important than ordering. So
people should love the lockless ringbuffer from this POV ;-)


> >> @@ -1974,9 +1966,9 @@ asmlinkage int vprintk_emit(int facility, int level,
> >>  
> >>  	/* This stops the holder of console_sem just where we want him */
> >>  	logbuf_lock_irqsave(flags);
> >> -	curr_log_seq = log_next_seq;
> >> +	pending_output = !prb_read_valid(prb, console_seq, NULL);
> >>  	printed_len = vprintk_store(facility, level, dict, dictlen, fmt, args);
> >> -	pending_output = (curr_log_seq != log_next_seq);
> >> +	pending_output &= prb_read_valid(prb, console_seq, NULL);
> >
> > The original code checked whether vprintk_store() stored the text
> > into the main log buffer or only into the cont buffer.
> >
> > The new code checks whether console is behind which is something
> > different.
> 
> I would argue that they are the same thing in this context. Keep in mind
> that we are under the logbuf_lock. If there was previously nothing
> pending and now there is, this context is the only one that could have
> added it.

Right.

> This logic will change significantly when we remove the locks (and it
> will disappear once we go to kthreads). But we aren't that far at this
> stage and I'd like to keep the general logic somewhat close to the
> current mainline implementation for now.

OK, it is not a big deal from my POV. It is just an optimization.
It can be removed or improved later.

It caught my eyes primary because prb_read_valid() was relatively
complex function. I was not sure if it was worth the effort. But
I am fine with keeping your code for now. It will help to reduce
unrelated behavior changes.

Best Regards,
Petr
