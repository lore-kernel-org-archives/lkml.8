Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EBDCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546DD206B7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:33:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iN2AVnlo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731569AbgEMMdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgEMMdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:33:06 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEBE3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 05:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8qAIPx0yq1s4hAQzWeQ2C8PF/tM8uCNWN0DULkuw3Dw=; b=iN2AVnloTiAQR3hd9qByGDp9/b
        qCX6cfYHAvUfSdAewyg0JjMtVdbsUx15BS2DvgYdEFmU3W8RjhahNqjyWZUHAJATt0hNeFQABbAo6
        yrfhUISMyukWI+zb2jxJazCDS5pDdMhpV5Y+WxQBEOHdMFvd+bbXYKYBVVTq4qf9ZITvtkOFhangw
        EiXmU7M55a5ZSenG33GE5I3U4KCNY8LxNg7K6rRGgIN44uWIsHXRcvJ//OQL64GCLRFrufxlPOGp1
        gLEPKkYqCjGnNa2GWO6drs3DsKWSvmr8pJn9T6PuG/XpyvybzwUZg3WqlUsEatEHbo/FhiRla9p9l
        hifHly9g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYqZ3-0006nX-Ov; Wed, 13 May 2020 12:32:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 24FC4301205;
        Wed, 13 May 2020 14:32:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 11AEC24C0C64E; Wed, 13 May 2020 14:32:43 +0200 (CEST)
Date:   Wed, 13 May 2020 14:32:43 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513123243.GO2957@hirez.programming.kicks-ass.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:

> Disabling most instrumentation for arch/x86 is reasonable. Also fine
> with the __READ_ONCE/__WRITE_ONCE changes (your improved
> compiler-friendlier version).
> 
> We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> now.

Right, if/when people want sanitize crud enabled for x86 I need
something that:

 - can mark a function 'no_sanitize' and all code that gets inlined into
   that function must automagically also not get sanitized. ie. make
   inline work like macros (again).

And optionally:

 - can mark a function explicitly 'sanitize', and only when an explicit
   sanitize and no_sanitize mix in inlining give the current
   incompatible attribute splat.

That way we can have the noinstr function attribute imply no_sanitize
and frob the DEFINE_IDTENTRY*() macros to use (a new) sanitize_or_inline
helper instead of __always_inline for __##func().
