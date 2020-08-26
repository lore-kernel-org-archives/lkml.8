Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F18B6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E442078A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:07:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgHZPHe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:07:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:45834 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726873AbgHZPH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:07:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F4F5ACAF;
        Wed, 26 Aug 2020 15:07:59 +0000 (UTC)
Date:   Wed, 26 Aug 2020 17:07:27 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Paul McKenney <paulmck@kernel.org>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/7][next] printk: ringbuffer: add
 finalization/extension support
Message-ID: <20200826150726.GA4928@alley>
References: <20200824103538.31446-1-john.ogness@linutronix.de>
 <20200824103538.31446-6-john.ogness@linutronix.de>
 <87lfi1ls2g.fsf@jogness.linutronix.de>
 <20200826100113.GA8849@jagdpanzerIV.localdomain>
 <87eentlh19.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87eentlh19.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-08-26 14:43:22, John Ogness wrote:
> On 2020-08-26, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> >>> @@ -1157,6 +1431,14 @@ bool prb_reserve(struct prb_reserved_entry *e, struct printk_ringbuffer *rb,
> >>>  		goto fail;
> >>>  	}
> >>>  
> >>> +	/*
> >>> +	 * New data is about to be reserved. Once that happens, previous
> >>> +	 * descriptors are no longer able to be extended. Finalize the
> >>> +	 * previous descriptor now so that it can be made available to
> >>> +	 * readers (when committed).
> >>> +	 */
> >>> +	desc_finalize(desc_ring, DESC_ID(id - 1));
> >>> +
> >>>  	d = to_desc(desc_ring, id);
> >>>  
> >>>  	/*
> >> 
> >> Apparently this is not enough to guarantee that past descriptors are
> >> finalized. I am able to reproduce a scenario where the finalization
> >> of a certain descriptor never happens. That leaves the descriptor
> >> permanently in the reserved queried state, which prevents any new
> >> records from being created. I am investigating.
> >
> > Good to know. I also run into problems:
> > - broken dmesg (and broken journalctl -f /dev/kmsg poll) and broken
> >   syslog read
> >
> > $ strace dmesg
> >
> > ...
> > openat(AT_FDCWD, "/dev/kmsg", O_RDONLY|O_NONBLOCK) = 3
> > lseek(3, 0, SEEK_DATA)                  = 0
> > read(3, 0x55dda8c240a8, 8191)           = -1 EAGAIN (Resource temporarily unavailable)
> > close(3)                                = 0
> > syslog(10 /* SYSLOG_ACTION_SIZE_BUFFER */) = 524288
> > mmap(NULL, 528384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x7f43ea847000
> > syslog(3 /* SYSLOG_ACTION_READ_ALL */, "", 524296) = 0
> 
> Yes, this a consequence of the problem. The tail is in the reserved
> queried state, so readers will not advance beyond it.
> 
> This series makes a very naive assumption that the previous descriptor
> is either in the reserved or committed queried states. The fact is, it
> can be in any of the 4 queried states. Adding support for finalization
> of all the states then gets quite complex, since any state transition
> (cmpxchg) may have to deal with an unexpected FINAL flag.
>
> The ringbuffer was designed so that descriptors are completely
> self-contained. So adding logic where an action on one descriptor should
> affect another descriptor is far more complex than I initially expected.
> 
> Keep in mind the finalization concept satisfies 3 things:
> 
> - denote if a record can be extended (i.e. transition back to reserved)
> - denote if a reader may read the record
> - denote if a writer may recycle a record
>
> I have not yet given up on the idea of finalization (particularly
> because it allows mainline LOG_CONT behavior to be preserved locklessy),

In each case, we need to finalize the descriptor also in prb_commit()
when the descriptor is not longer the last reserved one.

It has to be done in two steps to avoid race:

prb_commit()

   + set PRB_COMMIT_MASK
   + check if it is still the last descriptor in the array
   + set PRB_FINAL_MASK when it is not the last descriptor

It should work because prb_reserve() finalizes the previous
descriptor after the new one is reserved. As a result:

   + prb_reserve() should either see PRB_COMMIT_MASK in the previous
     descriptor and be able to finalize it.

   + or prb_commit() will see that the head moved and it is not
     longer the last reserved one.

I keep my fingers crossed.

Best Regards,
Petr

PS: I am still in the middle of review. And I had a feeling that
this situatuation was not handled.
