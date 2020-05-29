Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C6BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:59:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C501A2074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:59:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rYVhBf3F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgE2S7e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgE2S7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:59:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86FE6C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 11:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=sY/tG9kiE2VS5p/SHx6PtXudEGBk05lKgFcJLmAGXLg=; b=rYVhBf3FLg5OrGyxwODoGHScyk
        58uOEquR4SGJoQUp/EftzAqN8rSCOD5i4KMd5gzxv5vxASopwXmLanHpNfVEajIXyTrXGfsTvJywX
        9aSPkEL2v9aSLSBtJUu+/41JFXWevcsqaXD9sp3bgQR8h9c40BawX1v8NSOI0rpGT9LcFKRsap94E
        NLXDuaR3u53cUZX/s7VkSjTHs2fSUf6v0dfAz0GDOCsFsbVLgxzNAF3/I2UEJ9gg2i8c6f9Y7YHLo
        ID3lYmm8qL4PHR2N/sjpaaayRgEPWOFXj0IewKO/sdBopOBHTje+WNccp4Ngx9foiFwjKCDsq9z2i
        bn+8kd9A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jekE2-0006zO-66; Fri, 29 May 2020 18:59:26 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A315830047A;
        Fri, 29 May 2020 20:59:23 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 983AB2021AF65; Fri, 29 May 2020 20:59:23 +0200 (CEST)
Date:   Fri, 29 May 2020 20:59:23 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH -tip v3 05/11] kcsan: Remove 'noinline' from
 __no_kcsan_or_inline
Message-ID: <20200529185923.GO706495@hirez.programming.kicks-ass.net>
References: <20200521142047.169334-1-elver@google.com>
 <20200521142047.169334-6-elver@google.com>
 <20200529170755.GN706495@hirez.programming.kicks-ass.net>
 <CANpmjNPaL=HRvaJOC37_Cf4S4kskZezmgRiDSGn460rO2dM4+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNPaL=HRvaJOC37_Cf4S4kskZezmgRiDSGn460rO2dM4+g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 08:36:56PM +0200, Marco Elver wrote:

> > +/* Section for code which can't be instrumented at all */
> > +#define noinstr                                                                \
> > +       noinline notrace __attribute((__section__(".noinstr.text"))) __no_kcsan
> > +
> 
> Will this eventually need __no_sanitize_address?

Yes, and __no_sanitize_undefined and whatever else there is.

https://lkml.kernel.org/r/20200529171104.GD706518@hirez.programming.kicks-ass.net


> Acked -- if you send a patch, do split the test-related change, so
> that Paul can apply it to the test which is currently only in -rcu.

Ok, I'll try not forget over the weekend ;-)
