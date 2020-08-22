Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAFEEC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 23:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A805B208E4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 23:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgHVXtc convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 19:49:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728453AbgHVXtb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 19:49:31 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 714A1206B5;
        Sat, 22 Aug 2020 23:49:30 +0000 (UTC)
Date:   Sat, 22 Aug 2020 19:49:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     peterz@infradead.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Joerg Vehlow <lkml@jv-coder.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Huang Ying <ying.huang@intel.com>,
        linux-kernel@vger.kernel.org,
        Joerg Vehlow <joerg.vehlow@aox-tech.de>, dave@stgolabs.net
Subject: Re: [BUG RT] dump-capture kernel not executed for panic in
 interrupt context
Message-ID: <20200822194928.54ee4cb5@oasis.local.home>
In-Reply-To: <20200822123252.GQ1362448@hirez.programming.kicks-ass.net>
References: <2c243f59-6d10-7abb-bab4-e7b1796cd54f@jv-coder.de>
        <20200528084614.0c949e8d@gandalf.local.home>
        <cbbf7926-148e-7acb-dc03-3f055d73364b@jv-coder.de>
        <20200727163655.8c94c8e245637b62311f5053@linux-foundation.org>
        <c6b095af-fc92-420f-303f-d2efd9f28873@jv-coder.de>
        <20200821110848.6c3183d1@oasis.local.home>
        <20200821134753.9547695c9b782275be3c95b5@linux-foundation.org>
        <20200821170334.73b52fdd@oasis.local.home>
        <20200822123252.GQ1362448@hirez.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 14:32:52 +0200
peterz@infradead.org wrote:

> On Fri, Aug 21, 2020 at 05:03:34PM -0400, Steven Rostedt wrote:
> 
> > > Sigh.  Is it too hard to make mutex_trylock() usable from interrupt
> > > context?  
> > 
> > 
> > That's a question for Thomas and Peter Z.  
> 
> You should really know that too, the TL;DR answer is it's fundamentally
> buggered, can't work.

I knew there was an issue but I couldn't remember the reasoning, and
figured you could easily answer it without having to look back at the
code.

> 
> The problem is that RT relies on being able to PI boost the mutex owner.
> 
> ISTR we had a thread about all this last year or so, let me see if I can
> find that.
> 
> Here goes:
> 
>   https://lkml.kernel.org/r/20191218135047.GS2844@hirez.programming.kicks-ass.net

From this email:

> The problem happens when that owner is the idle task, this can happen
> when the irq/softirq hits the idle task, in that case the contending
> mutex_lock() will try and PI boost the idle task, and that is a big
> no-no.

What's wrong with priority boosting the idle task? It's not obvious,
and I can't find comments in the code saying it would be bad.

I looked around the code to see if I could find "why this is bad" but
couldn't find it. There's lots of places that say "Do not use
mutex_trylock in interrupt context, the implementation is not safe to
do so" but I can't find where it says "why" it is not safe to do so.

The idle task is not mentioned at all in rtmutex.c and not mentioned in
kernel/locking except for some comments about RCU in lockdep.

I see that in the idle code the prio_change method does a BUG(), but
there's no comment to say why it does so.

The commit that added that BUG, doesn't explain why it can't happen:

a8941d7ec8167 ("sched: Simplify the idle scheduling class")

I may have once known the rationale behind all this, but it's been a
long time since I worked on the PI code, and it's out of my cache.


-- Steve
