Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD18CC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B65820870
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 10:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387727AbgCDKJk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 05:09:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:40390 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726860AbgCDKJk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 05:09:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 79181AF62;
        Wed,  4 Mar 2020 10:09:37 +0000 (UTC)
Date:   Wed, 4 Mar 2020 11:09:36 +0100
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
Message-ID: <20200304100936.dfsdfd3wgabopfzd@pathway.suse.cz>
References: <20200128161948.8524-1-john.ogness@linutronix.de>
 <20200128161948.8524-2-john.ogness@linutronix.de>
 <20200221120557.lxpeoy6xuuqxzu5w@pathway.suse.cz>
 <87r1ybujm5.fsf@linutronix.de>
 <20200302123249.6khdqpneu7t6l35s@pathway.suse.cz>
 <87a74yrhwy.fsf@linutronix.de>
 <20200303094758.ubylqjqns7zbg6gb@pathway.suse.cz>
 <87d09tcunk.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d09tcunk.fsf@linutronix.de>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-03-03 16:42:07, John Ogness wrote:
> On 2020-03-03, Petr Mladek <pmladek@suse.com> wrote:
> >>>>>> diff --git a/kernel/printk/printk_ringbuffer.c b/kernel/printk/printk_ringbuffer.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..796257f226ee
> >>>>>> --- /dev/null
> >>>>>> +++ b/kernel/printk/printk_ringbuffer.c
> >>>>>> +/*
> >>>>>> + * Read the record @id and verify that it is committed and has the sequence
> >>>>>> + * number @seq. On success, 0 is returned.
> >>>>>> + *
> >>>>>> + * Error return values:
> >>>>>> + * -EINVAL: A committed record @seq does not exist.
> >>>>>> + * -ENOENT: The record @seq exists, but its data is not available. This is a
> >>>>>> + *          valid record, so readers should continue with the next seq.
> >>>>>> + */
> >>>>>> +static int desc_read_committed(struct prb_desc_ring *desc_ring,
> >>>>>> +			       unsigned long id, u64 seq,
> >>>>>> +			       struct prb_desc *desc)
> >>>>>> +{
> >>>
> @id _is_ very important because that is how descriptors are
> read. desc_read() takes @id as an argument and it is @id that identifies
> the descriptor. @seq is only meta-data within a descriptor. The only
> reason @seq is even checked is because of possible ABA issues with @id
> on 32-bit systems.

I think that the different view is because I look at this API
from the reader API side. It is called the following way:

prb_read_valid(, seq, )
  _prb_read_valid( , &seq, )
    prb_read( , *seq, )
        # id is read from address defined by seq
	rdesc = dr->descs[seq & MASK];
	id = rdesc->state_var && MASK_ID;

        desc_read_commited( , id, seq, )
	  desc_read( , id, )
	    # desc is the same as rdesc above because
	    # seq & MASK == id & MASK
	    desc = dr->descs[id & MASK];

Note that prb_read_valid() and prb_read() are addressed by seq.

It would be perfectly fine to pass only seq to desc_read_committed()
and read id from inside.

The name desc_read_committed() suggests that the important condition
is that the descriptor is in the committed state. It is not obvious
that seq is important as well.

From my POV, it will be more clear to pass only seq and rename the
function to desc_read_by_seq() or so:

  + seq is enough for addressing
  + function returns true only when the stored seq matches
  + the stored seq is valid only when the state is committed
    or reusable


Please, do not reply to this mail. Either take the idea or keep
the code as is. I could live with it. And it is not important
enough to spend more time on it. I just wanted to explain my view.
But it is obviously just a personal preference.

Best Regards,
Petr
