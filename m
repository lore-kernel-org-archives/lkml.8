Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AEBC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9529D206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 19:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U7gIsbri";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sads8gc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbgHFTD2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 15:03:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59622 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgHFTD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 15:03:26 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596740604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VB5BucQx5bpvgXTjit7Tp0UjVe4bVgUOv+xvLbLyxrU=;
        b=U7gIsbriuFfDgYrSTfYmSEZxoXdCZO49gi9xVPbIJ4f/gxXyJSm/+FuFAuNe0IkJk4WX3e
        WH3NkPlXmihhh7Ln8CQ22mIbw2xl8/tYEoZJZnr+Jj4G7OTbohd+L1sLHY2gR5CX836Pr4
        pLS9t4qnhTAtPVoyD9ApWPv/oWqAJHJLkHkkry2cEsfFTU6TdL3/ohvEishyH1MIsiSyCV
        GfH1IjS+pmdKRg43a44I1NCfEgKzSCf1wQytanduVnf4RGf7TcaNLLIXCCEASpXvKEIuve
        jMfLbU1yNHSBzGsrBHfWQfM80zJ41QZJuSWcEQVRxDwXO9s0JNQN2v0LKG9Osg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596740604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VB5BucQx5bpvgXTjit7Tp0UjVe4bVgUOv+xvLbLyxrU=;
        b=Sads8gc+ZuOg1bshtFmy5iMjP2tqRRHMZgt6TZnKHEZnCAr3UtFrwwQAUVC+WsM0fiBzdQ
        G3hhFGBb+CBBVWCQ==
To:     paulmck@kernel.org, peterz@infradead.org
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>,
        Alison Wang <alison.wang@nxp.com>, catalin.marinas@arm.com,
        will@kernel.org, mw@semihalf.com, leoyang.li@nxp.com,
        vladimir.oltean@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ time accounting
In-Reply-To: <20200806132710.GL4295@paulmck-ThinkPad-P72>
References: <87lfiwm2bj.fsf@nanos.tec.linutronix.de> <20200803114112.mrcuupz4ir5uqlp6@skbuf> <87d047n4oh.fsf@nanos.tec.linutronix.de> <jhjh7tjivew.mognet@arm.com> <875z9zmt4i.fsf@nanos.tec.linutronix.de> <20200805134002.GQ2674@hirez.programming.kicks-ass.net> <jhja6z9i4bi.mognet@arm.com> <20200805153120.GU2674@hirez.programming.kicks-ass.net> <874kpgi025.fsf@nanos.tec.linutronix.de> <20200806114545.GA2674@hirez.programming.kicks-ass.net> <20200806132710.GL4295@paulmck-ThinkPad-P72>
Date:   Thu, 06 Aug 2020 21:03:24 +0200
Message-ID: <87k0ybha0z.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul,

"Paul E. McKenney" <paulmck@kernel.org> writes:
> On Thu, Aug 06, 2020 at 01:45:45PM +0200, peterz@infradead.org wrote:
>> The safety thing is concerned with RT tasks. It doesn't pretend to help
>> with runnaway IRQs, never has, never will.
>
> Getting into the time machine back to the 1990s...
>
> DYNIX/ptx had a discretionary mechanism to deal with excessive interrupts.
> There was a function that long-running interrupt handlers were supposed
> to call periodically that would return false if the system felt that
> the CPU had done enough interrupts for the time being.  In that case,
> the interrupt handler was supposed to schedule itself for a later time,
> but leave the interrupt unacknowledged in order to prevent retriggering
> in the meantime.
>
> Of course, this mechanism would be rather less helpful in Linux.
>
> For one, Linux has way more device drivers and way more oddball devices.
> In contrast, the few devices that DYNIX/ptx supported were carefully
> selected, and the selection criteria included being able to put up
> with this sort of thing.  Also, the fact that there was but a handful
> of device drivers meant that changes like this could be more easily
> propagated through all drivers.

We could do that completely at the core interrupt handling level. 

> Also, Linux supports way more workloads.  In contrast, DYNIX/ptx could
> pick a small percentage of each CPU that would be permitted to be used
> by hardware interrupt handlers.  As in there are probably Linux workloads
> that run >90% of some poor CPU within hardware interrupt handlers.

Yet another tunable. /me runs
