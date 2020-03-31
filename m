Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD2EDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EC7720786
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HcYLrswa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgCaP3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:29:41 -0400
Received: from merlin.infradead.org ([205.233.59.134]:50002 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730391AbgCaP3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:29:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PQpgxNPCWWT+9PGI3Q9YA11D3XT0vA+mnCv838A5DxA=; b=HcYLrswaUl89zNBx5lBrRjvN+j
        zpW+u3tk5G5Pr1JffnfKGxYjX4wnwqtFMjATQ1kymjFCYX6PI7tA+g57S36MLQlVAM04RY+iLbJVM
        KVgqVDs721/1EWvgkZ3W2AYL5WyZo3aGL/n+upnTbqC4AScbLkvAKill1K/wfw2gs7qm9XjBv8v6J
        liOkNG+UrMXFbvOStKP/wtjuKOYx8xZBdNITUuzq8iJvkwtNYA5HCMzORlD91xDN/9gA5ft9atG/l
        DHkO2dkpGyCxWJMlHS/GaKjipvPm3iaFOBNgM+CPe8bF5EFeaUuIfDrUnlIicGs74aRZ8c97WUlge
        uD2wfYxQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJIow-0005jf-GM; Tue, 31 Mar 2020 15:28:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6658F3060FD;
        Tue, 31 Mar 2020 17:28:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 50D1729D75855; Tue, 31 Mar 2020 17:28:50 +0200 (CEST)
Date:   Tue, 31 Mar 2020 17:28:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: [PATCH 6/9] lockdep: Introduce wait-type checks
Message-ID: <20200331152850.GI20760@hirez.programming.kicks-ass.net>
References: <20200313174701.148376-1-bigeasy@linutronix.de>
 <20200313174701.148376-7-bigeasy@linutronix.de>
 <CAMuHMdU6s1F=DnaguZXrV4sWzEO-EqTaGQ=N7zyhgGq1M+Q1Ug@mail.gmail.com>
 <20200331145515.GR20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331145515.GR20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:55:15PM +0200, Peter Zijlstra wrote:
> On Tue, Mar 31, 2020 at 03:25:21PM +0200, Geert Uytterhoeven wrote:
> > On arm64 (e.g. R-Car H3 ES2.0):
> > 
> > +=============================
> > +[ BUG: Invalid wait context ]
> > +5.6.0-salvator-x-09423-gb29514ba13a9c459-dirty #679 Not tainted
> > +-----------------------------
> > +swapper/5/0 is trying to lock:
> > +ffffff86ff76f398 (&pool->lock){..-.}-{3:3}, at: __queue_work+0x134/0x430
> > +other info that might help us debug this:
> > +1 lock held by swapper/5/0:
> > + #0: ffffffc01103a4a0 (rcu_read_lock){....}-{1:3}, at:
> > rcu_lock_acquire.constprop.59+0x0/0x38
> > +stack backtrace:
> > +CPU: 5 PID: 0 Comm: swapper/5 Not tainted
> > 5.6.0-salvator-x-09423-gb29514ba13a9c459-dirty #679
> > +Hardware name: Renesas Salvator-X 2nd version board based on r8a77951 (DT)
> > +Call trace:
> > + dump_backtrace+0x0/0x180
> > + show_stack+0x14/0x1c
> > + dump_stack+0xdc/0x12c
> > + __lock_acquire+0x37c/0xf9c
> > + lock_acquire+0x258/0x288
> > + _raw_spin_lock+0x34/0x48
> > + __queue_work+0x134/0x430
> > + queue_work_on+0x48/0x8c
> > + timers_update_nohz+0x24/0x2c
> > + tick_nohz_activate.isra.15.part.16+0x5c/0x80
> > + tick_setup_sched_timer+0xe0/0xf0
> > + hrtimer_run_queues+0x88/0xf8
> 
> So this is complaining that it cannot take pool->lock, which is
> WAIT_CONFIG while holding RCU, which presents a WAIT_CONFIG context.
> 
> This seems to implicate something is amiss, because that should be
> allowed. The thing it doesn't print is the context, which in the above
> case is a (hrtimer) interrupt.
> 
> I suspect this really is a hardirq context and the next patch won't cure
> things. It looks nohz (full?) related.
> 
> Frederic, can you untangle this?

Sebastian is right; I completely forgot the workqueue thing was still
pending.

