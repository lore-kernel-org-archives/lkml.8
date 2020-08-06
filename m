Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E371AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEE6206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596735148;
	bh=3CR47nCFqExTQ2ML0Q2q5ma+kjZk2NCJpGaKDoZNAp0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=xru5PKmbsdPhI8pS5Mr8mvD866mu1lTUhOud+mOSixJxUna2jKPzQTFIW3YGCVRZE
	 oJvqJDaerwWBONdmUmYdmcgTv8bGtOkakUg/vDSPFBMRiFMon7aGhTPtNufajXNNYS
	 yYfx92mdEeuMcpCyidLtiF/QXpWuGfB4A40Z2NI4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729774AbgHFRcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:54488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729272AbgHFRbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:31:23 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6D6E2310C;
        Thu,  6 Aug 2020 13:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596720430;
        bh=3CR47nCFqExTQ2ML0Q2q5ma+kjZk2NCJpGaKDoZNAp0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=ADXfnL9F5IxPiRumosniAILFcwP44WwOkV2KfXpn2zCUQ+j5RQzq/J9lyn1bZXQid
         f0qnMGIxOJgpQoFxUeFMWej2QiZ0sJcbXGL462KhzOt5H703XMuzejKaCV6bDplpPS
         v3AJ40qDkmnKh+NbCNNblwBjPDB36nrbvXnkSjv4=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 7476335206C1; Thu,  6 Aug 2020 06:27:10 -0700 (PDT)
Date:   Thu, 6 Aug 2020 06:27:10 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     peterz@infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, mw@semihalf.com, leoyang.li@nxp.com,
        vladimir.oltean@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level
 IRQ time accounting
Message-ID: <20200806132710.GL4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87lfiwm2bj.fsf@nanos.tec.linutronix.de>
 <20200803114112.mrcuupz4ir5uqlp6@skbuf>
 <87d047n4oh.fsf@nanos.tec.linutronix.de>
 <jhjh7tjivew.mognet@arm.com>
 <875z9zmt4i.fsf@nanos.tec.linutronix.de>
 <20200805134002.GQ2674@hirez.programming.kicks-ass.net>
 <jhja6z9i4bi.mognet@arm.com>
 <20200805153120.GU2674@hirez.programming.kicks-ass.net>
 <874kpgi025.fsf@nanos.tec.linutronix.de>
 <20200806114545.GA2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806114545.GA2674@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:45:45PM +0200, peterz@infradead.org wrote:
> On Thu, Aug 06, 2020 at 11:41:06AM +0200, Thomas Gleixner wrote:
> > peterz@infradead.org writes:
> > > On Wed, Aug 05, 2020 at 02:56:49PM +0100, Valentin Schneider wrote:
> > >
> > >> I've been tempted to say the test case is a bit bogus, but am not familiar
> > >> enough with the RT throttling details to stand that ground. That said, from
> > >> both looking at the execution and the stress-ng source code, it seems to
> > >> unconditionally spawn 32 FIFO-50 tasks (there's even an option to make
> > >> these FIFO-99!!!), which is quite a crowd on monoCPU systems.
> > >
> > > Oh, so it's a case of: we do stupid without tuning and the system falls
> > > over. I can live with that.
> > 
> > It's not a question of whether you can live with that behaviour for a
> > particular silly test case.
> > 
> > The same happens with a single RT runaway task with enough interrupt
> > load on a UP machine. Just validated that. 
> 
> Of course.
> 
> > And that has nothing to do
> > with a silly test case. Sporadic runaways due to a bug in a once per
> > week code path simply can happen and having the safety net working
> > depending on a config option selected or not is just wrong.
> 
> The safety thing is concerned with RT tasks. It doesn't pretend to help
> with runnaway IRQs, never has, never will.

Getting into the time machine back to the 1990s...

DYNIX/ptx had a discretionary mechanism to deal with excessive interrupts.
There was a function that long-running interrupt handlers were supposed
to call periodically that would return false if the system felt that
the CPU had done enough interrupts for the time being.  In that case,
the interrupt handler was supposed to schedule itself for a later time,
but leave the interrupt unacknowledged in order to prevent retriggering
in the meantime.

Of course, this mechanism would be rather less helpful in Linux.

For one, Linux has way more device drivers and way more oddball devices.
In contrast, the few devices that DYNIX/ptx supported were carefully
selected, and the selection criteria included being able to put up
with this sort of thing.  Also, the fact that there was but a handful
of device drivers meant that changes like this could be more easily
propagated through all drivers.

Also, Linux supports way more workloads.  In contrast, DYNIX/ptx could
pick a small percentage of each CPU that would be permitted to be used
by hardware interrupt handlers.  As in there are probably Linux workloads
that run >90% of some poor CPU within hardware interrupt handlers.

But reminiscing anyway on the off-chance that this inspires someone
to come up with an idea that would work well in the Linux environment.

							Thanx, Paul

> The further extreme is an interrupt storm, those have always taken a
> machine down.
> 
> Accounting unrelated IRQ time to RT tasks is equally wrong, the task
> execution is unrelated to the IRQs. The config option at least offers
> insight into where time goes -- and it's a config option because doing
> time accounting on interrupts adds overhead :/
> 
> This really is a no-win all round.
> 
> The only 'sensible' option here is threaded IRQs, where the IRQ line
> gets disabled until the handler thread has ran, that also helps with IRQ
> storms.
