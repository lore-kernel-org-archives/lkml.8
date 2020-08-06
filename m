Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B76C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51695221E3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 20:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596746357;
	bh=q8V+QooAedDTCZwwSoD3LNTl7TcgV2NB4V/wTSRx1Pg=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=VT2IEECLQI2VRM/Qp33K5uV3gdXYqnN4H3+tLgeUniSeNa+t8+/OQkSn898wE/Pwr
	 GF/YOdUB748rsf+BcEKAGlBhdkcDiimckPstg7iDbsykTSHa4keAJUlW97iNGDvAiH
	 fKE0LqOIMOzuggZyKh/DBEDFoioDCNyPqE++u5qI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726644AbgHFUjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 16:39:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:48374 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725272AbgHFUjP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 16:39:15 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB00A20855;
        Thu,  6 Aug 2020 20:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596746355;
        bh=q8V+QooAedDTCZwwSoD3LNTl7TcgV2NB4V/wTSRx1Pg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=LDZwk8Jookz+8ELmpEdSs4hIHa/yqQi0yTAmATPUiu/FQwE9I9q7uc7L0m5bL1qOa
         htHvVr1Bk8XaKx/NbkCTIpAx20ycbLK6+vBMOV+kij4dUJOUjXMAjsiRXhiptghsnp
         mxzb9Pi0G4qkJ0rrLs168mHtyVl7FtLJozYPA2Oc=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id A95F23520734; Thu,  6 Aug 2020 13:39:14 -0700 (PDT)
Date:   Thu, 6 Aug 2020 13:39:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     peterz@infradead.org,
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
Message-ID: <20200806203914.GQ4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <87k0ybha0z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k0ybha0z.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:03:24PM +0200, Thomas Gleixner wrote:
> Paul,
> 
> "Paul E. McKenney" <paulmck@kernel.org> writes:
> > On Thu, Aug 06, 2020 at 01:45:45PM +0200, peterz@infradead.org wrote:
> >> The safety thing is concerned with RT tasks. It doesn't pretend to help
> >> with runnaway IRQs, never has, never will.
> >
> > Getting into the time machine back to the 1990s...
> >
> > DYNIX/ptx had a discretionary mechanism to deal with excessive interrupts.
> > There was a function that long-running interrupt handlers were supposed
> > to call periodically that would return false if the system felt that
> > the CPU had done enough interrupts for the time being.  In that case,
> > the interrupt handler was supposed to schedule itself for a later time,
> > but leave the interrupt unacknowledged in order to prevent retriggering
> > in the meantime.
> >
> > Of course, this mechanism would be rather less helpful in Linux.
> >
> > For one, Linux has way more device drivers and way more oddball devices.
> > In contrast, the few devices that DYNIX/ptx supported were carefully
> > selected, and the selection criteria included being able to put up
> > with this sort of thing.  Also, the fact that there was but a handful
> > of device drivers meant that changes like this could be more easily
> > propagated through all drivers.
> 
> We could do that completely at the core interrupt handling level. 

Ah, true enough if the various NAPI-like devices give up the CPU from
time to time.  Which they might well do for all I know.

> > Also, Linux supports way more workloads.  In contrast, DYNIX/ptx could
> > pick a small percentage of each CPU that would be permitted to be used
> > by hardware interrupt handlers.  As in there are probably Linux workloads
> > that run >90% of some poor CPU within hardware interrupt handlers.
> 
> Yet another tunable. /me runs

;-) ;-) ;-)

If there are workloads that would like to be able to keep one or more
CPUs completely busy handling interrupts, it should be possible to
create something that is used sort of like cond_resched() to keep RCU,
the scheduler, and the various watchdogs and lockup detectors at bay.

For example, RCU could supply a function that checked to make sure that
it was in an interrupt from idle, and if so report a quiescent state
for that CPU.  So if the CPU was idle and there wasn't anything pending
for it, that CPU could safely stay in a hardirq handler indefinitely.
I suppose that the function should return an indication in cases such
as interrupt from non-idle.

Sort of like NO_HZ_FULL, but for hardirq handlers, and also allowing
those handlers to use RCU read-side critical sections.

Or we could do what all the cool kids do these days, namely just apply
machine learning, thus automatically self-tuning in real time.

/me runs...

							Thanx, Paul
