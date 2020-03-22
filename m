Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B69C4332E
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C0A42076F
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 12:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbgCVM13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 08:27:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39693 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbgCVM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 08:27:28 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1jFzhO-0007Av-3X; Sun, 22 Mar 2020 13:27:26 +0100
Date:   Sun, 22 Mar 2020 13:27:26 +0100
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>
Subject: Re: [tip: locking/core] lockdep: Annotate irq_work
Message-ID: <20200322122726.p5wpog6jfweqqxoi@linutronix.de>
References: <20200321113242.643576700@linutronix.de>
 <158480602510.28353.4851999853077941579.tip-bot2@tip-bot2>
 <20200321164057.GA9634@lenoir>
 <20200321181249.vy7xxkgrd65piapw@linutronix.de>
 <20200322023329.GC9634@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200322023329.GC9634@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-22 03:33:30 [+0100], Frederic Weisbecker wrote:
> > > > @@ -245,6 +245,7 @@ static void nohz_full_kick_func(struct irq_work *work)
> > > >  
> > > >  static DEFINE_PER_CPU(struct irq_work, nohz_full_kick_work) = {
> > > >  	.func = nohz_full_kick_func,
> > > > +	.flags = ATOMIC_INIT(IRQ_WORK_HARD_IRQ),
> > > >  };
> > > 
> > > I get why these need to be in hardirq but some basic explanations for
> > > ordinary mortals as to why those two specifically and not all the others
> > > (and there are many) would have been nice.
> > 
> > Is the documentation patch in this series any good?
> 
> That describes the general rules but it doesn't tell anything about the
> details of this patch. Especially why RCU and nohz_full irq works in particular
> are special here and why it's fine for others to execute in softirq.

Hmm. You need to know the details of the code. RCU is used in hardirq
context, uses (carefully) raw_spinlock_t and so on.
If my memory serves me well in regard to the "nohz kick" part here
NOHZ_FULL needs to observe the CPU if it idle or a task is running. If
this is invoked as part of softirq, which is threaded, then it will
never observe an idle CPU because there is always a task RUNNING with
the softirq doing this callback.

> Thanks.

Sebastian
