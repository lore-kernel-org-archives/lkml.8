Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C5CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2030F20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHMIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:41:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:36216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgHMIlj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:41:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94B7CB5DA;
        Thu, 13 Aug 2020 08:41:59 +0000 (UTC)
Date:   Thu, 13 Aug 2020 10:41:36 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        kexec@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: POC: Alternative solution: Re: [PATCH 0/4] printk: reimplement
 LOG_CONT handling
Message-ID: <20200813084136.GK12903@alley>
References: <20200717234818.8622-1-john.ogness@linutronix.de>
 <CAHk-=wivdy6-i=iqJ1ZG9YrRzaS0_LHHEPwb9KJg-S8i-Wm30w@mail.gmail.com>
 <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875z9nvvl2.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-08-13 09:50:25, John Ogness wrote:
> On 2020-08-13, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > This is not an unseen pattern, I'm afraid. And the problem here can
> > be more general:
> >
> > 	pr_info("text");
> > 	pr_cont("1");
> > 	exception/IRQ/NMI
> > 		pr_alert("text\n");
> > 	pr_cont("2");
> > 	pr_cont("\n");
> >
> > I guess the solution would be to store "last log_level" in task_struct
> > and get current (new) timestamp for broken cont line?
> 
> (Warning: new ideas ahead)
> 
> The fundamental problem is that there is no real association between
> the cont parts. So any interruption results in a broken record. If we
> really want to do this correctly, we need real association.
> 
> With the new finalize flag for records, I thought about perhaps adding
> support for chaining data blocks.
> 
> A data block currently stores an unsigned long for the ID of the
> associated descriptor. But it could optionally include a second unsigned
> long, which is the lpos of the next text part. All the data blocks of a
> chain would point back to the same descriptor. The descriptor would only
> point to the first data block of the chain and include a flag that it is
> using chained data blocks.
>
> Then we would only need to track the sequence number of the open record
> and new data blocks could be added to the data block chain of the
> correct record. Readers cannot see the record until it is finalized.

Note that we still must try to append the continuous piece into the
same data block. We could not concatenate them in the reader API
because it would create the problem with unused/skipped sequence numbers.

Also it would complicate the reader code. It would need to know
whether a record has already been printed together with a previous
one.


> Also, since only finalized records can be invalidated, there are no
> races of chains becoming invalidated while being appended.
> 
> My concerns about this idea:
> 
> - What if the printk user does not correctly terminate the cont message?
>   There is no mechanism to allow that open record to be force-finalized
>   so that readers can read newer records.

This is a real problem. And it is the reason why the cont buffer is
currently flushed (finalized) by the next message from another context.


> - For tasks, the sequence number of the open record could be stored on
>   the task_struct. For non-tasks, we could use a global per-cpu variable
>   where each CPU stores 2 sequence numbers: the sequence number of the
>   open record for the non-task and the sequence number of the open
>   record for an interrupting NMI. Is that sufficient?

Yeah, it would be possible.

Anyway, this would fix an already existing problem. It might get
complicated and tricky. I am afraid that it comes from the "perfection
is the enemy of good" department.

A good compromise might be to just store "loglevel" from the previous
message in the given context. It could then be used for pr_cont()
messages in the same context.

Anyway, I would solve this later because it is already existing
problem.

Best Regards,
Petr
