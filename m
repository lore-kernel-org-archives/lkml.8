Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B721FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:25:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8815C2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JyAQXOUW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgENOZM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbgENOZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:25:12 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 201D9C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 07:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Jfq3RHqQr0LXNTIpWKRuiuSUC1EarhLNtIVJLxWCknU=; b=JyAQXOUWWOei1IZOAQ7L4zIf+H
        FIy+Do8COvpZ+v4bjUk6bunJBTtX/7YTjcDzlXvNvgZ5Nnng+jwj+7vqVGNgbgMIT0L+WksIM2lwP
        XT16+4/nWS+flkuX446mR+rgREiVEkoamLwA2HPXyldFyoFSlcnGstDjbwVQgOC9Q7/tsgp1Yz0UB
        u7J6cqFMO0lrrE8B2NuMcLdmsFzWnx86TfEu/hrspbOAxhIO6R+lPuq6jGUloegcVFY9EwGlskB+M
        jt/1u7ZDGi7tW2lCBHE/XDK+q59w+iGaGzXYoHvlEa/k87Exc+SLnR3cDQX2fsVg5PNSI+xv/ifQU
        lu4sfUWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jZEn6-00012p-Cl; Thu, 14 May 2020 14:24:52 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C276F302753;
        Thu, 14 May 2020 16:24:50 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A952B2B852D47; Thu, 14 May 2020 16:24:50 +0200 (CEST)
Date:   Thu, 14 May 2020 16:24:50 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200514142450.GC2978@hirez.programming.kicks-ass.net>
References: <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
 <20200513165008.GA24836@willie-the-truck>
 <CANpmjNN=n59ue06s0MfmRFvKX=WB2NgLgbP6kG_MYCGy2R6PHg@mail.gmail.com>
 <20200513174747.GB24836@willie-the-truck>
 <CANpmjNNOpJk0tprXKB_deiNAv_UmmORf1-2uajLhnLWQQ1hvoA@mail.gmail.com>
 <20200513212520.GC28594@willie-the-truck>
 <CANpmjNOAi2K6knC9OFUGjpMo-rvtLDzKMb==J=vTRkmaWctFaQ@mail.gmail.com>
 <20200514110537.GC4280@willie-the-truck>
 <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNMTsY_8241bS7=XAfqvZHFLrVEkv_uM4aDUWE_kh3Rvbw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 03:35:58PM +0200, Marco Elver wrote:

> Let me try to spell out the requirements I see so far (this is for
> KCSAN only though -- other sanitizers might be similar):
> 
>   1. __no_kcsan functions should not call anything, not even
> kcsan_{enable,disable}_current(), when using __{READ,WRITE}_ONCE.
> [Requires leaving data_race() off of these.]
> 
>   2. __always_inline functions inlined into __no_sanitize function is
> not instrumented. [Has always been satisfied by GCC and Clang.]
> 
>   3. __always_inline functions inlined into instrumented function is
> instrumented. [Has always been satisfied by GCC and Clang.]
> 
>   4. __no_kcsan functions should never be spuriously inlined into
> instrumented functions, causing the accesses of the __no_kcsan
> function to be instrumented. [Satisfied by Clang >= 7. All GCC
> versions are broken.]
> 
>   5. we should not break atomic_{read,set} for KCSAN. [Because of #1,
> we'd need to add data_race() around the arch-calls in
> atomic_{read,set}; or rely on Clang 11's -tsan-distinguish-volatile
> support (GCC 11 might get this as well).]
> 
>   6. never emit __tsan_func_{entry,exit}. [Clang supports disabling
> this, GCC doesn't.]
> 
>   7. kernel is supported by compiler. [Clang >= 9 seems to build -tip
> for me, anything below complains about lack of asm goto. GCC trivial.]
> 
> So, because of #4 & #6 & #7 we're down to Clang >= 9. Because of #5
> we'll have to make a choice between Clang >= 9 or Clang >= 11
> (released in ~June). In an ideal world we might even fix GCC in
> future.
> 
> That's not even considering the problems around UBSan and KASAN. But
> maybe one step at a time?

Exact same requirements, KASAN even has the data_race() problem through
READ_ONCE_NOCHECK(), UBSAN doesn't and might be simpler because of it.

> Any preferences?

I suppose DTRT, if we then write the Makefile rule like:

KCSAN_SANITIZE := KCSAN_FUNCTION_ATTRIBUTES

and set that to either 'y'/'n' depending on the compiler at hand
supporting enough magic to make it all work.

I suppose all the sanitize stuff is most important for developers and
we tend to have the latest compiler versions anyway, right?
