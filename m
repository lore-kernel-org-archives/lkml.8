Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52373CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EBA220659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589373628;
	bh=Cg5V0mi6bfLZlbCrv5J0nHN1a5bpXPRTg/ycCZE8VEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KSOsQgkyj4BCsNxtGCzdeuenLbT1tupnZIgnwBSuXIXnAJFsoX/ktNpBriBnYoLFn
	 bxgH+UBnejc4ZZ1cZp/6kZvLUbKicP5l99MIxJE5eyk6+R/xhTx/BAI8bmQHUAW45e
	 C9IPOIH14GNC7CV3bCp1l87WfIikPglErcs1MxpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732649AbgEMMk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728939AbgEMMk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:40:27 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6DAF2206B7;
        Wed, 13 May 2020 12:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589373626;
        bh=Cg5V0mi6bfLZlbCrv5J0nHN1a5bpXPRTg/ycCZE8VEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ebit9jB5vrfqgXQA2ie/3/gcV9zbGpXtdyKF/JTUTlF1A8KpHJfsngq1oUZsyrfX9
         pScwolN1Gp/o/QQeDu0957+YefK6KOZCS8t4ABxG6MFRxoX2noU3mM/9jOVbuY8JtE
         +TMS/aek5NKA6vTO9K7QoNM7wDRCetXMlLPdlMFs=
Date:   Wed, 13 May 2020 13:40:22 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513124021.GB20278@willie-the-truck>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513123243.GO2957@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
> On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
> 
> > Disabling most instrumentation for arch/x86 is reasonable. Also fine
> > with the __READ_ONCE/__WRITE_ONCE changes (your improved
> > compiler-friendlier version).
> > 
> > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> > now.

I agree that Peter's patch is the right thing to do for now. I was hoping we
could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
__no_sanitize_or_inline doesn't seem to do anything.

> Right, if/when people want sanitize crud enabled for x86 I need
> something that:
> 
>  - can mark a function 'no_sanitize' and all code that gets inlined into
>    that function must automagically also not get sanitized. ie. make
>    inline work like macros (again).
> 
> And optionally:
> 
>  - can mark a function explicitly 'sanitize', and only when an explicit
>    sanitize and no_sanitize mix in inlining give the current
>    incompatible attribute splat.
> 
> That way we can have the noinstr function attribute imply no_sanitize
> and frob the DEFINE_IDTENTRY*() macros to use (a new) sanitize_or_inline
> helper instead of __always_inline for __##func().

Sounds like a good plan to me, assuming the compiler folks are onboard.
In the meantime, can we kill __no_sanitize_or_inline and put it back to
the old __no_kasan_or_inline, which I think simplifies compiler.h and
doesn't mislead people into using the function annotation to avoid KCSAN?

READ_ONCE_NOCHECK should also probably be READ_ONCE_NOKASAN, but I
appreciate that's a noisier change.

Will
