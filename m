Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46821C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F3FE2054F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 09:12:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHNJMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 05:12:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:44802 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726012AbgHNJMm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 05:12:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 3639CADC1;
        Fri, 14 Aug 2020 09:13:04 +0000 (UTC)
Date:   Fri, 14 Aug 2020 11:12:41 +0200
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
Message-ID: <20200814091240.GL6215@alley>
References: <87blkcanps.fsf@jogness.linutronix.de>
 <20200811160551.GC12903@alley>
 <20200812163908.GH12903@alley>
 <87v9hn2y1p.fsf@jogness.linutronix.de>
 <20200813051853.GA510@jagdpanzerIV.localdomain>
 <875z9nvvl2.fsf@jogness.linutronix.de>
 <20200813084136.GK12903@alley>
 <87v9hmrg84.fsf@jogness.linutronix.de>
 <20200814033424.GA582@jagdpanzerIV.localdomain>
 <87k0y1k5gc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0y1k5gc.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2020-08-14 10:22:35, John Ogness wrote:
> On 2020-08-14, Sergey Senozhatsky <sergey.senozhatsky@gmail.com> wrote:
> > One thing that we need to handle here, I believe, is that the context
> > which crashes the kernel should flush its cont buffer, because the
> > information there is relevant to the crash:
> >
> > 	pr_cont_alloc_info(&c);
> > 	pr_cont(&c, "1");
> > 	pr_cont(&c, "2");
> > 	>>
> > 	   oops
> > 	      panic()
> > 	<<
> > 	pr_cont_flush(&c);
> >
> > We better flush that context's pr_cont buffer during panic().
> 
> I am not convinced of the general usefulness of partial messages, but as
> long as we have an API that includes registration, usage, and
> deregistration of some sort of handle, then we leave the window open for
> such implementations.

Registering some handle is an interesting idea. But it rules out
buffers on the stack. And we should avoid dynamic allocation.
printk() must be reliable also when there is not enough memory.

Please, keep it simple and do not add dependencies on new subsystems.
Using external code in printk() is always a call for problems.
The called code must be lockless and must not call printk().

Best Regards,
Petr
