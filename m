Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207F8C2D0F8
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAEB520769
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:15:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589318103;
	bh=n320LhkZ6wxkYO1Y5MNF012NtzAe10rdOlykBinlwig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=jar85Kh6M/oi6vPU/NfW2V3/RVFJhejGOUy2upg3SsgPFNS1My40mSoxMcoI42huW
	 lzAmbnJd9PIEI3OOcibC4dHkiEHcG6nRaB2AAvWaq3k21ey6whrOe6R2CX2g1PXRWR
	 TnnpyF6ReG6C5DAubyFEz48K8Dd7eNf/Vx7VjjeU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731359AbgELVPC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:15:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:58134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbgELVPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:15:01 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EB08205C9;
        Tue, 12 May 2020 21:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589318101;
        bh=n320LhkZ6wxkYO1Y5MNF012NtzAe10rdOlykBinlwig=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=niq+lIwyCb1vX/1DG0ZgmWcD2CGp8EgHUBOR8+Pp4zQH3MpTXGBwOTgVXExn2cCo+
         E/CxIvJg0/v7cfuqfWO5nOrb9z8F95MPXl1ZEoCFYI35qG+ZwVdKmBu1IJLY90xu/7
         QVCENAmb4gTvChf8qLfRrfiFuJGBJhqdBLHoKqq8=
Date:   Tue, 12 May 2020 22:14:56 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200512211450.GA11062@willie-the-truck>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512190755.GL2957@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 09:07:55PM +0200, Peter Zijlstra wrote:
> On Tue, May 12, 2020 at 07:53:00PM +0200, Marco Elver wrote:
> > I just ran a bunch of KCSAN tests. While this series alone would have
> > passed the tests, there appears to be a problem with
> > __READ_ONCE/__WRITE_ONCE. I think they should already be using
> > 'data_race()', as otherwise we will get lots of false positives in
> > future.
> > 
> > I noticed this when testing -tip/locking/kcsan, which breaks
> > unfortunately, because I see a bunch of spurious data races with
> > arch_atomic_{read,set} because "locking/atomics: Flip fallbacks and
> > instrumentation" changed them to use __READ_ONCE()/__WRITE_ONCE().
> > From what I see, the intent was to not double-instrument,
> > unfortunately they are still double-instrumented because
> > __READ_ONCE/__WRITE_ONCE doesn't hide the access from KCSAN (nor KASAN
> > actually). I don't think we can use __no_sanitize_or_inline for the
> > arch_ functions, because we really want them to be __always_inline
> > (also to avoid calls to these functions in uaccess regions, which
> > objtool would notice).
> > 
> > I think the easiest way to resolve this is to wrap the accesses in
> > __*_ONCE with data_race().
> 
> But we can't... because I need arch_atomic_*() and __READ_ONCE() to not
> call out to _ANYTHING_.
> 
> Sadly, because the compilers are 'broken' that whole __no_sanitize thing
> didn't work, but I'll be moving a whole bunch of code into .c files with
> all the sanitizers killed dead. And we'll be validating it'll not be
> calling out to anything.

Hmm, I may have just run into this problem too. I'm using clang 11.0.1,
but even if I do something like:

unsigned long __no_sanitize_or_inline foo(unsigned long *p)
{
	return READ_ONCE_NOCHECK(*p);
}

then I /still/ get calls to __tcsan_func_{entry,exit} emitted by the
compiler. Marco -- how do you turn this thing off?!

I'm also not particularly fond of treating __{READ,WRITE}ONCE() as "atomic",
since they're allowed to tear and I think callers should probably either be
using data_race() explicitly or disabling instrumentation (assuming that's
possible).

Will
