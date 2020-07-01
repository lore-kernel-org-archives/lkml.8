Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87147C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66A65206B6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593598797;
	bh=9Kej8N7/444vyXQnl8/ioGdJ8CvpVggYRN8p0S6A3hA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=njdFl1QxG/diM4XZ5DyWJND0Eq1MsDVj90fJPVrgjG0AOYuP7rNDaUr1e9Ga3mbDB
	 FR9pWLP6xdgkqta7opfknU5iHdws8BnhjjE4AVGx43VNm4RR7MulYNaPm0veausAA8
	 7lAzJMF/pt8iFChNmz72U/L5bOJXyGMpAH7Qcrv8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgGAKTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:19:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729887AbgGAKTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:19:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD328206B6;
        Wed,  1 Jul 2020 10:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593598769;
        bh=9Kej8N7/444vyXQnl8/ioGdJ8CvpVggYRN8p0S6A3hA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XMtZZ1DarIqro0ULGuCiTjSVyJcESurJDaZsh5CFvc6CBXTm3pedcUVJFRlirmjlr
         92x2fLcppQnSp5oM9ELuhyJpmszSzZJYg4gVTVdrHIX069eolAhFnwXqU1AJ25irZh
         XNHpUTaw9KdSfGins0gbmJvLeNQsCViZVDBnjSYk=
Date:   Wed, 1 Jul 2020 11:19:23 +0100
From:   Will Deacon <will@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Matt Turner <mattst88@gmail.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <rth@twiddle.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        alpha <linux-alpha@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 18/18] arm64: lto: Strengthen READ_ONCE() to acquire when
 CLANG_LTO=y
Message-ID: <20200701101922.GC14959@willie-the-truck>
References: <20200630173734.14057-1-will@kernel.org>
 <20200630173734.14057-19-will@kernel.org>
 <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2zB4z121reuy6BCqQ3-1mDBAkUkRRXeDuvSFtSr3ha2g@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 09:25:03PM +0200, Arnd Bergmann wrote:
> On Tue, Jun 30, 2020 at 7:39 PM Will Deacon <will@kernel.org> wrote:
> > +#define __READ_ONCE(x)                                                 \
> > +({                                                                     \
> > +       int atomic = 1;                                                 \
> > +       union { __unqual_scalar_typeof(x) __val; char __c[1]; } __u;    \
> > +       typeof(&(x)) __x = &(x);                                        \
> > +       switch (sizeof(x)) {                                            \
> ...
> > +       atomic ? (typeof(x))__u.__val : (*(volatile typeof(x) *)__x);   \
> > +})
> 
> This expands (x) nine times (five in __unqual_scala_typeof()), which can
> lead to significant code bloat after preprocessing if something passes a
> compound expression into READ_ONCE().
> The compiler works it out eventually, but we've seen an actual slowdown
> in compile speed from this recently, especially on clang.
> 
> I think if you move the
> 
>         typeof(&(x)) __x = &(x);
> 
> line first, all other instances can use typeof(*__x) instead of typeof(x)
> and avoid this problem.

Cheers, I was only thinking about side-effects when I wrote this, but
bloating built time is very unpopular, so I'll go with your suggestion.

> Once we make gcc-4.9 the minimum version,
> this could be further improved to
> 
>        __auto_type __x = &(x);

Is anybody working on moving to 4.9? I've seen the mails from Linus
championing it, but I thought there was a RHEL in support that people
might care about?

Will
