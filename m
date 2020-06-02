Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D564C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:20:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67C5C206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:20:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A7zYw3qK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgFBTUF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBTUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:20:05 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29397C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mG+CJQG33NKFFc3Wsgq89KyUGRH2llxotrBKMYPSKBw=; b=A7zYw3qKvN+sUEEd1l+RDb7xsL
        nTFkluOFXaj/tHfRZFlcJGPKmJpZSfR1lk0UUp0UhtY8NQ6x03Mw9E93L2VmIo8drmuLlKP1Dtvmk
        JpmcVOexlW6P3nfG/ZqQeNQ0vBmszvXCkWHFijfdfirdbauPKM8VkwzNUb9RLGWR0US0MhY3dnzX/
        K+imrPtq07+qEiZc7eDjx8GjRSVgi0zME5dC1rj1QqlRi+gULdNkkglEuCxNHeRPaLQUQoP9YF6Jq
        q5EMTWhQ7DdcWTtAl6vy4HQfOUU4bw2tIKA5uz2CEN3NiCXpuxnKOJEJvcJP8UcW3oHrw/K/GnJPp
        TXTmjbBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgCRn-0002rw-If; Tue, 02 Jun 2020 19:19:39 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 40F5930047A;
        Tue,  2 Jun 2020 21:19:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 323CF202436F2; Tue,  2 Jun 2020 21:19:36 +0200 (CEST)
Date:   Tue, 2 Jun 2020 21:19:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Marco Elver <elver@google.com>, Will Deacon <will@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -tip 1/2] Kconfig: Bump required compiler version of
 KASAN and UBSAN
Message-ID: <20200602191936.GE2604@hirez.programming.kicks-ass.net>
References: <20200602184409.22142-1-elver@google.com>
 <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 11:57:15AM -0700, Nick Desaulniers wrote:
> On Tue, Jun 2, 2020 at 11:44 AM 'Marco Elver' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > Adds config variable CC_HAS_WORKING_NOSANITIZE, which will be true if we
> > have a compiler that does not fail builds due to no_sanitize functions.
> > This does not yet mean they work as intended, but for automated
> > build-tests, this is the minimum requirement.
> >
> > For example, we require that __always_inline functions used from
> > no_sanitize functions do not generate instrumentation. On GCC <= 7 this
> > fails to build entirely, therefore we make the minimum version GCC 8.
> >
> > For KCSAN this is a non-functional change, however, we should add it in
> > case this variable changes in future.
> >
> > Link: https://lkml.kernel.org/r/20200602175859.GC2604@hirez.programming.kicks-ass.net
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Marco Elver <elver@google.com>
> 
> Is this a problem only for x86?  If so, that's quite a jump in minimal
> compiler versions for a feature that I don't think is currently
> problematic for other architectures?  (Based on
> https://lore.kernel.org/lkml/20200529171104.GD706518@hirez.programming.kicks-ass.net/
> )

Currently x86 only, but I know other arch maintainers are planning to
have a hard look at their code based on our findings.
