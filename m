Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BF6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CAEF20722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589454344;
	bh=nELbYhLTLS46UT3eKWckMNnd9vi5dumK/DwGj29Jobo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aBfaWhHVlWPj2e3KGSlgRtTJNaz2q1F6MMrxtIU8MyhsaxEgTj+E1V8I2RNhvNhrQ
	 RBltNpVO4/DEU/lxiZl/0tN9RW1UoBZN8+YyxA0k9Qduhn/QhylgBd0IHjBcvifDH5
	 vgOqRKjZzNPdqdPkhsuTU4rsjYvPvxYLq4RQTnFk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgENLFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:41642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENLFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:05:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B51CD20727;
        Thu, 14 May 2020 11:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589454343;
        bh=nELbYhLTLS46UT3eKWckMNnd9vi5dumK/DwGj29Jobo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NSf+2fJl0lCmVb5fGzNcpEhEWCWFrGtxrUiCqBb5UFXyMDXgO1LtsHtEjk6wL6RzX
         mWlRJwJE99bnt6w7+8Az2L/q+pxZepBUaqFhbdi/+USl20Ms3kfRd5K/7kOaI+4GGP
         CGiqmpDcCeJuWPUZSLAdQkbRfu3Gi8qpWGY4zgv4=
Date:   Thu, 14 May 2020 12:05:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Marco Elver <elver@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514110537.GC4280@willie-the-truck>
References: <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

On Thu, May 14, 2020 at 09:31:49AM +0200, Marco Elver wrote:
> Ouch. With the __{READ,WRITE}_ONCE requirement, we're going to need
> Clang 11 though.
> 
> Because without the data_race() around __*_ONCE,
> arch_atomic_{read,set} will be broken for KCSAN, but we can't have
> data_race() because it would still add
> kcsan_{enable,disable}_current() calls to __no_sanitize functions (if
> compilation unit is instrumented). We can't make arch_atomic functions
> __no_sanitize_or_inline, because even in code that we want to
> sanitize, they should remain __always_inline (so they work properly in
> __no_sanitize functions). Therefore, Clang 11 with support for
> distinguishing volatiles will be the compiler that will satisfy all
> the constraints.
> 
> If this is what we want, let me prepare a series on top of
> -tip/locking/kcsan with all the things I think we need.

Stepping back a second, the locking/kcsan branch is at least functional at
the moment by virtue of KCSAN_SANITIZE := n being used liberally in
arch/x86/. However, I still think we want to do better than that because (a)
it would be good to get more x86 coverage and (b) enabling this for arm64,
where objtool is not yet available, will be fragile if we have to whitelist
object files. There's also a fair bit of arm64 low-level code spread around
drivers/, so it feels like we'd end up with a really bad case of whack-a-mole.

Talking off-list, Clang >= 7 is pretty reasonable wrt inlining decisions
and the behaviour for __always_inline is:

  * An __always_inline function inlined into a __no_sanitize function is
    not instrumented
  * An __always_inline function inlined into an instrumented function is
    instrumented
  * You can't mark a function as both __always_inline __no_sanitize, because
    __no_sanitize functions are never inlined

GCC, on the other hand, may still inline __no_sanitize functions and then
subsequently instrument them.

So if were willing to make KCSAN depend on Clang >= 7, then we could:

  - Remove the data_race() from __{READ,WRITE}_ONCE()
  - Wrap arch_atomic*() in data_race() when called from the instrumented
    atomic wrappers

At which point, I *think* everything works as expected. READ_ONCE_NOCHECK()
won't generate any surprises, and Peter can happily use arch_atomic()
from non-instrumented code.

Thoughts? I don't see the need to support buggy compilers when enabling
a new debug feature.

Will
