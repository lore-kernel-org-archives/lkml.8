Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7727AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53D1B2063A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="emIMXaZp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgFOPGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729875AbgFOPGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:06:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A50C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=pdG9YeyyHFpa+KDZLF5PuhAEcav4b8GAmq2VKm/tnYI=; b=emIMXaZpW6q7kNFFjh+T+DtfAb
        /Dt0mj7nyLVO095SDNFCCpwb5WS7TOIwk1jOCcQFLZAXR8Ak6RwFIt2Fkr0XrKEi/nXPOn+h27xbR
        zHCnzHz4gS/DVbpPu0u4J2PkO9d7JxJ03P+d7iYOdrqBXKeRvizZwNfLiktWqtw1x066NwoZ7lHES
        QMTz2xdZJZJErtesFxkoe2foeRihikrPekJu2wGRVEDLpadnydis4eKH9JMByCdXrwu1D0O3Q1nZU
        eYhy8v/yfW+wTpuJZtheuETFh7v5b2BNEnehwLocQ0Dotk6hE6e4+AhVFTVMu0ay7SUykug3HhHhP
        eDZzYavw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jkqh7-00034R-BW; Mon, 15 Jun 2020 15:06:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 51A5E30604B;
        Mon, 15 Jun 2020 17:06:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3723B203C3761; Mon, 15 Jun 2020 17:06:39 +0200 (CEST)
Date:   Mon, 15 Jun 2020 17:06:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Marco Elver <elver@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 0/8] x86/entry: KCSAN/KASAN/UBSAN vs noinstr
Message-ID: <20200615150639.GX2531@hirez.programming.kicks-ass.net>
References: <20200604102241.466509982@infradead.org>
 <CANpmjNPEXdGV-ZRYrVieJJsA01QATH+1vUixirocwKGDMsuEWQ@mail.gmail.com>
 <CANpmjNP2ayM6Oehw08yFM4+5xTjXWcCT7P3u7FL=cCMxFJNkXw@mail.gmail.com>
 <20200615145718.GA1091@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200615145718.GA1091@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:57:18AM -0400, Qian Cai wrote:
> On Mon, Jun 15, 2020 at 12:07:34PM +0200, 'Marco Elver' via kasan-dev wrote:
> > On Thu, 4 Jun 2020 at 13:01, Marco Elver <elver@google.com> wrote:
> > >
> > > On Thu, 4 Jun 2020 at 12:25, Peter Zijlstra <peterz@infradead.org> wrote:
> > > >
> > > > Hai,
> > > >
> > > > Here's the remaining few patches to make KCSAN/KASAN and UBSAN work with noinstr.
> > >
> > > Thanks for assembling the series!
> > >
> > > For where it's missing (1,2,3 and last one):
> > >
> > > Acked-by: Marco Elver <elver@google.com>
> > 
> > Where was this series supposed to go? I can't find it on any tree yet.
> > 
> > How urgent is this? Boot-test seems fine without this, but likely
> > doesn't hit the corner cases. Syzbot will likely find them, and if we
> > noticeably end up breaking various sanitizers without this, I'd
> > consider this urgent.
> 
> Today's linux-next had a lot of those with this .config,
> 
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
> 
> Wondering if this patchset will cure them all?

Many, not all, you also need:

  https://lkml.kernel.org/r/20200603114051.896465666@infradead.org

and then I think you're down to only 1 kasan thing. But also read this
thread:

  https://lkml.kernel.org/r/20200611215812.GF4496@worktop.programming.kicks-ass.net

latest version of that actual patch here:

  https://lkml.kernel.org/r/20200612143034.933422660@infradead.org

