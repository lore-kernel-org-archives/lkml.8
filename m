Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 758D9C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:48:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4083920722
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:48:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E7ZjUPSC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCSGsl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 02:48:41 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:33476 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgCSGsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 02:48:40 -0400
Received: by mail-pj1-f67.google.com with SMTP id dw20so1971648pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fCmJsQA7Pe5pBsOadpMtdc8u8RXTmbMScn41zfd86gE=;
        b=E7ZjUPSCnXRjmn9f4oqhuuw5FNZw0J9UtV8TEGqCNL0/DXjQAMQQPPe61HdjrXs/Qq
         CMkdBXCETSdbkd28pKPP1m5VcUS+DFEHwUrm0j0qRXX/B1yRVRQFl9JCmhEEecAPwr33
         Rn2McgQfMGMyj3Ncp5AFhGtBAqBWPBNR5U4pCTdjvtM/hyqoEW5/c26n4xpbaQQyNFcT
         XR46M/mgLbhRlVwOUV5fA4uFMDON4D89/qABJ2X6p8/4SKfsWTSc9kQ4dDntKYHGZjZ+
         61GoJYpKg2+U1m3S/CMaGtlIWUYw1LVV8v8Xc1jwmY7K36sCFHgkls0EKjvbcNEdDpnY
         Sseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fCmJsQA7Pe5pBsOadpMtdc8u8RXTmbMScn41zfd86gE=;
        b=naq2wvd7xbp8rth4FTKk7NUURiueTmOkOuB1ucmfa11E42EvKg2BEXAHdHjg+baO5r
         +N7u8KxQ0nO84+y8QizKbMdx2jUOf4lIU7W9Z6RTOyK5W17cYsgT5kBkqIqbvMvq73hT
         V5OFhKRv/oGuTIReXhMLQ0TyDS5WL+QzP0pRn3I8qepERJ4vOpeRI5a5VpbRbPpa5Run
         KZrrcO358L+n/b5gEPcT0Q0kdygiEZNaUaFqDYmcjc0QlMjeh/eAR9vV0v8Q8Yn/z2mZ
         jU15cJf3fHt04VNXdKKZHNNh/TOVvCvtDnBb0mI6H74F6IeFV15GwD+F3Is+s4ORXPX4
         VeFg==
X-Gm-Message-State: ANhLgQ0Zi6FtCFAwKKVf9t6EUBpof9R9851vavE9pryK05YMiKQaWfGr
        Eolipuxw0O85HrAobCew/Oc=
X-Google-Smtp-Source: ADFU+vvO08GfIb5h+Pi1Eftt/0UfQpxUcsZp3eExFLNZM5lKDIV+IdnCmLjaeCclQvANqGo9fHbgCA==
X-Received: by 2002:a17:902:7c8e:: with SMTP id y14mr1847357pll.139.1584600519316;
        Wed, 18 Mar 2020 23:48:39 -0700 (PDT)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 136sm1076840pgh.26.2020.03.18.23.48.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 23:48:38 -0700 (PDT)
Date:   Thu, 19 Mar 2020 15:48:36 +0900
From:   Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To:     Eugeniu Rosca <erosca@de.adit-jv.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        linux-kernel@vger.kernel.org,
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
        Eugeniu Rosca <roscaeugeniu@gmail.com>
Subject: Re: [RFC PATCH 3/3] watchdog: Turn console verbosity on when
 reporting softlockup
Message-ID: <20200319064836.GB24020@google.com>
References: <20200315170903.17393-1-erosca@de.adit-jv.com>
 <20200315170903.17393-4-erosca@de.adit-jv.com>
 <20200317021818.GD219881@google.com>
 <20200318180525.GA5790@lxhi-065.adit-jv.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318180525.GA5790@lxhi-065.adit-jv.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On (20/03/18 19:05), Eugeniu Rosca wrote:
[..]
> > I'm afraid, as of now, this approach is not going to work the way it's
> > supposed to work in 100% of cases. Because the only thing that printk()
> > call sort of guarantees is that the message will be stored somewhere.
> > Either in the main kernel log buffer, on in one of auxiliary per-CPU
> > log buffers. It does not guarantee, generally speaking, that the message
> > will be printed on the console immediately.
> 
> I take this passage as an acknowledgement of the problem being _real_,
> in spite of the fix being not perfect.
> 
> One aspect I would like to emphasize is that (please, NAK this
> statement if it's not accurate) the problem reported in this patch is
> not specific to the existing printk mechanism, but also applies to the
> upcoming kthread-based printk. If that's true, then IMHO this is a
> compelling argument to join forces and try to find a working, safe and
> future-proof solution.

Yes, this is a "known issue".

> > Consider the following example:
> > 
> > 	CPU0				CPU1
> > 	console_lock();
> > 	schedule();
> > 
> > 					watchdog()
> > 					 console_verbose_start();
> > 					  printk()
> > 					   log_store()
> > 					    if (!console_trylock())
> > 					      return;
> > 					 console_verbose_end();
> > 
> > 	...
> > 	console_unlock()
> > 	 print logbuf messages to the consoles
> > 	 we missed the console_verbose_start/end
> > 	 on CPU1
> 
> This looks plausible. However, I wonder to which degree the same
> scenario is a concern in the kthread-based approach?

This is a problem for any async/deferred printk() printout. When we
print messages on the consoles we don't have any idea anymore if the
CPU which added those messages to the logbuf had any issues going on.

> My current standpoint is that as long as points [A-D] are met, it
> should do no harm to accept a (partial) fix like seen in my series:
> 
>  - [A] the patch tackles at least a subset of problematic use-cases
>  - [B] the fix is non-intrusive and easy to review
>  - [C] there is hope to reuse it in the new lockless buffer based printk
>  - [D] there are no regressions employing the major console knobs
>        (ignore_loglevel, quiet, loglevel, etc) as it happened in
>   a6ae928c25835c ("Revert "printk: make sure to print log on console."")

So the issue is that when we bump `console_loglevel' or `ignore_loglevel'
we lift restrictions globally. For all CPUs, for all contexts which call
printk(). This may have negative impact. Fuzzing is one example. It
usually generates a lot of printk() noise, so lifting global printk()
log_level restrictions does cause problems. I recall that fuzzing people
really disliked the
			old_level = console_loglevel
			console_loglevel = new_level
			....
			console_loglevel = old_level

approach. Because if lets all CPUs and tasks to pollute serial logs.
While what we want is to print messages from a particular CPU/task.

So _maybe_ we can explore the per-context printk() flags instead. The idea
is to store a "desired"/emergency ->log_level. When a context sets that
->log_level we need to make any printk() messages issued by that context
at least of that ->log_level. IOW we overwrite messages log_levels, because
printk() is not synchronous by design.

We had similar discussion before [0].
I was misunderstood back then and in order to avoid the same
misunderstanding this time around, let me first state that - *I DO NOT*
propose to disable preemption for printk(). The code in question
was *just a POC snippet*.

To move that POC further - we can have the same per-context printk()
fields in every task_struct struct. Ideally without consuming additional
memory, or consuming as few extra bytes per task_struct as possible.
But even if we will have ->log_level embedded into every task_struct, we
still need to distinguish various cases (contexts):

- when current task wants to declare printk() emergency and sets
  current->log_level, only this process is in printk() emergency.
  - IRQs and NMIs which interrupt current should not be in printk()
    emergency, unless IRQ and/or NMI explicitly declare printk()
    emergency.

- when IRQ declares printk() emergency and sets current->log_level, only
  this IRQ is in printk() emergency

- when NMI declares printk() emergency and sets current->log_level, only
  this NMI is in printk() emergency

Another thing is. Suppose current sets ->log_level, and then encounters
a page_fault, which printk-s from exception handler. We shall distinguish
such cases too, I think.

So something like

	printk_emergency_enter(LOG_LEVEL)
		current->context[ctx] = LOG_LEVEL;
	...
		printk()
		// overwrite message log_level to current->context[ctx] level
		dump_stack()
		// same log_level overwrite
	...
	printk_emergency_exit()
		current->context[ctx] = -1

So when we iterate pending logbuf messages (CPU0->console_unlock() in
the example from my first email) messages from CPU1 will have appropriate
"desired" log_level and we will print those messages on the consoles.

Well. Something like this.


[0] https://lore.kernel.org/linuxppc-dev/20191112021747.GA68506@google.com/

	-ss
