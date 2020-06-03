Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F50DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6956A205CB
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 16:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qUTdWW7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCQH3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 12:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgFCQH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 12:07:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5744AC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 09:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=I0LdSJBp4zoME7tY6bpA1Q8Wf4c6QK8RY6BCgD6eGqY=; b=qUTdWW7guRe9VWgZIeXbB+OVC/
        jM21pt57kjAQeI6xeEGtddZREKcmIQZW3FYr4P7gHHVx35KMZRIylBAsmidpCFsbp/9TPb4I6o4XB
        VgaI2rJtiu8HgEj13YrHLa8ab29X+cA05CeKbhR4TrNKQDt3DFfcOwwbLHsZDOY3sU4bSNDNvOcLF
        zggYnI7oxmE07Ew8C8xvaX/3JmQgaO3r6+02UAZAYaExr/dq/mwOpO4IyHliWIAu2hBwPJWov5JTc
        E6eB6Xm/WKP77mZ4aRZAQStJ12OgXSoNgB17xQJuQpf3hlrreUn4Ywh/oZoJAhU3xlDoB0DbkdbI1
        hmg1dPFA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgVvI-0003p3-Up; Wed, 03 Jun 2020 16:07:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5B0E930008D;
        Wed,  3 Jun 2020 18:07:22 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4657320707D4F; Wed,  3 Jun 2020 18:07:22 +0200 (CEST)
Date:   Wed, 3 Jun 2020 18:07:22 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 0/9] x86/entry fixes
Message-ID: <20200603160722.GD2570@hirez.programming.kicks-ass.net>
References: <20200603114014.152292216@infradead.org>
 <20200603120037.GA2570@hirez.programming.kicks-ass.net>
 <20200603120818.GC2627@hirez.programming.kicks-ass.net>
 <CANpmjNOxLkqh=qpHQjUC_bZ0GCjkoJ4NxF3UuNGKhJSvcjavaA@mail.gmail.com>
 <20200603121815.GC2570@hirez.programming.kicks-ass.net>
 <CANpmjNPxMo0sNmkbMHmVYn=WJJwtmYR03ZtFDyPhmiMuR1ug=w@mail.gmail.com>
 <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPzmynV2X+e76roUmt_3oq8KDDKyLLsgn__qtAb8i0aXQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:47:54PM +0200, Marco Elver wrote:

> This is fun: __always_inline functions inlined into
> __no_sanitize_undefined *do* get instrumented because apparently UBSan
> passes must run before the optimizer (before inlining), contrary to
> what [ATM]SAN instrumentation does. Both GCC and Clang do this.

That's just broken :-( You can keep it marked and then strip it out at
the end if it turns out it wasn't needed after all (of course I do
realize this might not be entirely as trivial as it sounds).

> Some options to fix:
> 
> 1. Add __no_sanitize_undefined to the problematic __always_inline
> functions. I don't know if a macro like '#define
> __always_inline_noinstr __always_inline __no_sanitize_undefined' is
> useful, but it's not an automatic fix either. This option isn't great,
> because it doesn't really scale.

Agreed, that's quite horrible and fragile.

> 2. If you look at the generated code for functions with
> __ubsan_handle_*, all the calls are actually guarded by a branch. So
> if we know that there is no UBSan violation in the function, AFAIK
> we're fine. 

> What are the exact requirements for 'noinstr'?

> Is it only "do not call anything I didn't tell you to call?" If that's
> the case, and there is no bug in the function ;-), then for UBSan
> we're fine.

This; any excursion out of noinstr for an unknown reason can have
unknown side effects which we might not be able to deal with at that
point.

For instance, if we cause a #PF before the current #PF has read CR2,
we're hosed. If we hit a hardware breakpoint before we're ready for it,
we're hosed (and we explicitly disallow setting breakpoints on noinstr,
but not stuff outside it).

So IFF UBSAN only calls out when things have gone wrong, as opposed to
checking if things go wrong (say, an out-of-line bounds check), then,
indeed, assuming no bug, no harm in having them.

And in that regard they're no different from all the WARN_ON() crud we
have all over the place, those are deemed safe under the assumption they
don't happen either.

> With that in mind, you could whitelist "__ubsan_handle"-prefixed
> functions in objtool. Given the __always_inline+noinstr+__ubsan_handle
> case is quite rare, it might be reasonable.

Yes, I think so. Let me go have dinner and then I'll try and do a patch
to that effect.
