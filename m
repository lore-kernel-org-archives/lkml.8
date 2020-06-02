Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DA9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 715F2206A2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 19:39:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Y97cQnPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728254AbgFBTjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 15:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgFBTjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 15:39:21 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A215C08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 12:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=07uMamPsL7K8+1SyUHisvSOhlqTxoE0W90sdhD4QMmw=; b=Y97cQnPwok8IfPYNnHXAxYFLE9
        WdQLHiOQg9IagRkIMwtUp1HAau/GbFgTi2G3wacHKgYLdxa0zK3cdzR2QqYPg9VlhiMrVnefwynHH
        w74VxgLvnJfHT7JdRRFJfeR3VWvNEBKI4IL73PWtqfcDlyK1b8TmonSNb6mm+Loa+aCBSo86diW4Y
        q73nrxkVnRGEMKbnqlbIoKzPjuUde5eeyIDA9IXIZ50allf/C84wOs96jQ+Xwlpjrug+w0tIK0niX
        nM47c6PpjjLO2qPj+j7lj9g2XfdMJG0Alh5CjgwJsCiYyCt2lGboKn3F2nKzU1M1nzvWPn5w2k2zI
        AGllSQRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jgCkQ-0003KJ-JB; Tue, 02 Jun 2020 19:38:54 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1B30A30081A;
        Tue,  2 Jun 2020 21:38:53 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0EB462020B7BF; Tue,  2 Jun 2020 21:38:53 +0200 (CEST)
Date:   Tue, 2 Jun 2020 21:38:53 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>,
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
Message-ID: <20200602193853.GF2604@hirez.programming.kicks-ass.net>
References: <20200602184409.22142-1-elver@google.com>
 <CAKwvOd=5_pgx2+yQt=V_6h7YKiCnVp_L4nsRhz=EzawU1Kf1zg@mail.gmail.com>
 <20200602191936.GE2604@hirez.programming.kicks-ass.net>
 <CANpmjNP3kAZt3kXuABVqJLAJAW0u9-=kzr-QKDLmO6V_S7qXvQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP3kAZt3kXuABVqJLAJAW0u9-=kzr-QKDLmO6V_S7qXvQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 09:25:47PM +0200, Marco Elver wrote:
> On Tue, 2 Jun 2020 at 21:19, Peter Zijlstra <peterz@infradead.org> wrote:

> > Currently x86 only, but I know other arch maintainers are planning to
> > have a hard look at their code based on our findings.
> 
> I've already spotted a bunch of 'noinstr' outside arch/x86 e.g. in
> kernel/{locking,rcu}, and a bunch of these functions use atomic_*, all
> of which are __always_inline. The noinstr uses outside arch/x86 would
> break builds on all architecture with GCC <= 7 when using sanitizers.
> At least that's what led me to conclude we need this for all
> architectures.

True; but !x86 could, probably, get away with not fully respecting
noinstr at this time. But that'd make a mess of things again, so my
preference is as you did, unilaterally raise the min version for *SAN.

That said; noinstr's __no_sanitize combined with atomic_t might be
'interesting', because the regular atomic things have explicit
annotations in them. That should give validation warnings for the right
.config, I'll have to go try -- so far I've made sure to never enable
the *SAN stuff.


