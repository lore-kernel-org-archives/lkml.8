Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF4AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D44520771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 07:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgHMHcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 03:32:01 -0400
Received: from mx2.suse.de ([195.135.220.15]:55544 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726072AbgHMHcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 03:32:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3F77DB1ED;
        Thu, 13 Aug 2020 07:32:21 +0000 (UTC)
Date:   Thu, 13 Aug 2020 09:31:58 +0200
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
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813073158.GI12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v9hn2y1p.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-13 02:30:02, John Ogness wrote:
> On 2020-08-12, Petr Mladek <pmladek@suse.com> wrote:
> > So, I have one crazy idea to add one more state bit so that we
> > could have:
> >
> >   + committed: set when the data are written into the data ring.
> >   + final: set when the data block could not longer get reopened
> >   + reuse: set when the desctiptor/data block could get reused
> >
> > "final" bit will define when the descriptor could not longer
> > get reopened (cleared committed bit) and the data block could
> > not get extended.
> 
> I implemented this solution for myself and am currently running more
> tests. Some things that I changed from your suggestion:
> 
> 1. I created a separate prb_reserve_cont() function. The reason for this
> is because the caller needs to understand what is happening. The caller
> is getting an existing record with existing data and must append new
> data. The @text_len field of the info reports how long the existing data
> is.

I see.

> So the LOG_CONT handling code in printk.c looks something like this:

Yeah, it makes sense.


> 2. I haven't yet figured out how to preserve calling context when a
> newline appears. For example:
> 
> pr_info("text");
> pr_cont(" 1");
> pr_cont(" 2\n");
> pr_cont("3");
> pr_cont(" 4\n");
> 
> For "3" the calling context (info, timestamp) is lost because with "2"
> the record is finalized. Perhaps the above is invalid usage of LOG_CONT?

I am going to answer Sergey's reply.


> 3. There are some memory barriers introduced, but it looks like it
> shouldn't add too much complexity.

Uff. I have hooped for this.

> I will continue to refine my working version and post a patch so that we
> have something to work with. This looks to be the most promising way
> forward. Thanks.

Uff, I am happy that it seems working. Several other approaches looked
much more complicated or they caused regressions.

Best Regards,
Petr
