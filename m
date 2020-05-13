Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBE5DCA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72404204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RxMSWSe/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387602AbgEMNYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:24:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733225AbgEMNYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:24:46 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F5AC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 06:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0A+CA41zwy6qhmtprl6gwc/xxp4FPDpIHB/1ri3llcQ=; b=RxMSWSe/SQPWxkwYFAl/1GORyC
        XVZHwka/U74+TVDM6QOl2gzO0C/Fl7k99wrfLX/iwbqe272E/kO9o/J16mlbj2VKil2YaFmcUggEz
        OsYjAu2eSVyAik66f++0rIv8a73D5F6mWxPT0oPeqr4PnL8PjL1gGVqkb3oxEbTMQOPV21gdnLpJf
        iJajonJhkjbhxBljD+CNm0jYlNiaOHmE1Wh+KIIGSHDoANTCt1l33lfkl4Esno8oxlTveikdMa4h4
        XGd2+nwoOQJzLOqU8zLEUNXG1zQjD1kg2rbrXposDmXddc14pXuwG17kod8diQaCuT1COG1lmhJ86
        JIymcAbw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYrNK-00020d-Sr; Wed, 13 May 2020 13:24:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 972A7305EEF;
        Wed, 13 May 2020 15:24:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7CE88285D660D; Wed, 13 May 2020 15:24:40 +0200 (CEST)
Date:   Wed, 13 May 2020 15:24:40 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Message-ID: <20200513132440.GN2978@hirez.programming.kicks-ass.net>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
 <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNM5XW+ufJ6Mw2Tn7aShRCZaUPGcH=u=4Sk5kqLKyf3v5A@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 03:15:55PM +0200, Marco Elver wrote:
> So far so good, except: both __no_sanitize_or_inline and
> __no_kcsan_or_inline *do* avoid KCSAN instrumenting plain accesses, it
> just doesn't avoid explicit kcsan_check calls, like those in
> READ/WRITE_ONCE if KCSAN is enabled for the compilation unit. That's
> just because macros won't be redefined just for __no_sanitize
> functions. Similarly, READ_ONCE_NOCHECK does work as expected, and its
> access is unchecked.
> 
> This will have the expected result:
> __no_sanitize_or_inline void foo(void) { x++; } // no data races reported
> 
> This will not work as expected:
> __no_sanitize_or_inline void foo(void) { READ_ONCE(x); }  // data
> races are reported
> 
> All this could be fixed if GCC devs would finally take my patch to
> make -fsanitize=thread distinguish volatile [1], but then we have to
> wait ~years for the new compilers to reach us. So please don't hold
> your breath for this one any time soon.
> [1] https://gcc.gnu.org/pipermail/gcc-patches/2020-April/544452.html

Right, but that does not address the much larger issue of the attribute
vs inline tranwreck :/

Also, could not this compiler instrumentation live as a kernel specific
GCC-plugin instead of being part of GCC proper? Because in that case,
we'd have much better control over it.
