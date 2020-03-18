Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C9EC10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:05:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B74C320719
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:05:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCRSFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:05:46 -0400
Received: from smtp1.de.adit-jv.com ([93.241.18.167]:53408 "EHLO
        smtp1.de.adit-jv.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgCRSFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:05:46 -0400
Received: from localhost (smtp1.de.adit-jv.com [127.0.0.1])
        by smtp1.de.adit-jv.com (Postfix) with ESMTP id 8F3783C00C3;
        Wed, 18 Mar 2020 19:05:43 +0100 (CET)
Received: from smtp1.de.adit-jv.com ([127.0.0.1])
        by localhost (smtp1.de.adit-jv.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id U5k1Dee-lBIf; Wed, 18 Mar 2020 19:05:37 +0100 (CET)
Received: from HI2EXCH01.adit-jv.com (hi2exch01.adit-jv.com [10.72.92.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 3DA163C057F;
        Wed, 18 Mar 2020 19:05:30 +0100 (CET)
Received: from lxhi-065.adit-jv.com (10.72.94.23) by HI2EXCH01.adit-jv.com
 (10.72.92.24) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 18 Mar
 2020 19:05:29 +0100
Date:   Wed, 18 Mar 2020 19:05:25 +0100
From:   Eugeniu Rosca <erosca@de.adit-jv.com>
To:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
CC:     <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Dirk Behme <dirk.behme@de.bosch.com>,
        Eugeniu Rosca <roscaeugeniu@gmail.com>,
        Eugeniu Rosca <erosca@de.adit-jv.com>
Subject: Re: [RFC PATCH 3/3] watchdog: Turn console verbosity on when
 reporting softlockup
Message-ID: <20200318180525.GA5790@lxhi-065.adit-jv.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
 <20200315170903.17393-4-erosca@de.adit-jv.com>
 <20200317021818.GD219881@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200317021818.GD219881@google.com>
X-Originating-IP: [10.72.94.23]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sergey,

Many thanks for your feedback!

On Tue, Mar 17, 2020 at 11:18:18AM +0900, Sergey Senozhatsky wrote:
> On (20/03/15 18:09), Eugeniu Rosca wrote:
> 
> [..]
> 
> > @@ -428,6 +428,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  			}
> >  		}
> >  
> > +		console_verbose_start();
> > +
> >  		pr_emerg("BUG: soft lockup - CPU#%d stuck for %us! [%s:%d]\n",
> >  			smp_processor_id(), duration,
> >  			current->comm, task_pid_nr(current));
> > @@ -453,6 +455,8 @@ static enum hrtimer_restart watchdog_timer_fn(struct hrtimer *hrtimer)
> >  		if (softlockup_panic)
> >  			panic("softlockup: hung tasks");
> >  		__this_cpu_write(soft_watchdog_warn, true);
> > +
> > +		console_verbose_end();
> >  	} else
> >  		__this_cpu_write(soft_watchdog_warn, false);
> 
> 
> I'm afraid, as of now, this approach is not going to work the way it's
> supposed to work in 100% of cases. Because the only thing that printk()
> call sort of guarantees is that the message will be stored somewhere.
> Either in the main kernel log buffer, on in one of auxiliary per-CPU
> log buffers. It does not guarantee, generally speaking, that the message
> will be printed on the console immediately.

I take this passage as an acknowledgement of the problem being _real_,
in spite of the fix being not perfect.

One aspect I would like to emphasize is that (please, NAK this
statement if it's not accurate) the problem reported in this patch is
not specific to the existing printk mechanism, but also applies to the
upcoming kthread-based printk. If that's true, then IMHO this is a
compelling argument to join forces and try to find a working, safe and
future-proof solution.

> 
> Consider the following example:
> 
> 	CPU0				CPU1
> 	console_lock();
> 	schedule();
> 
> 					watchdog()
> 					 console_verbose_start();
> 					  printk()
> 					   log_store()
> 					    if (!console_trylock())
> 					      return;
> 					 console_verbose_end();
> 
> 	...
> 	console_unlock()
> 	 print logbuf messages to the consoles
> 	 we missed the console_verbose_start/end
> 	 on CPU1

This looks plausible. However, I wonder to which degree the same
scenario is a concern in the kthread-based approach?

My current standpoint is that as long as points [A-D] are met, it
should do no harm to accept a (partial) fix like seen in my series:

 - [A] the patch tackles at least a subset of problematic use-cases
 - [B] the fix is non-intrusive and easy to review
 - [C] there is hope to reuse it in the new lockless buffer based printk
 - [D] there are no regressions employing the major console knobs
       (ignore_loglevel, quiet, loglevel, etc) as it happened in
  a6ae928c25835c ("Revert "printk: make sure to print log on console."")

From the above points, my only major concern is that current series
breaks the expectations of users who pass loglevel=0 on kernel
command line and expect the system to be totally silent. This has
already been expressed in the cover letter. I would especially
appreciate if the same view is shared (or invalidated) by others.

> 
> IIRC, we had a similar approach in the past. See commit 375899cddcbb26
> ("printk: make sure to print log on console"). And we reverted it, see
> a6ae928c25835 ("Revert "printk: make sure to print log on console.").

Thanks for this reference. It looks to me that in spite of being
relatively compact, commit 375899cddcbb26 ("printk: make sure to print
log on console.") broke criteria [D] listed above. I intend to avoid
it by testing multiple console knob values on my arm64 system.

Looking forward to your feedback on the questions posted above. TIA!

-- 
Best Regards
Eugeniu Rosca
