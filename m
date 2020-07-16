Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E719C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F6612071B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 09:40:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="wCfVy1BY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgGPJkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 05:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbgGPJkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 05:40:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C4BC061755;
        Thu, 16 Jul 2020 02:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=DODVfvRjphploJcUvRl2f5HSQLQF2PLhJJB7s8CHhjQ=; b=wCfVy1BYq74yjZWXOTO2nHfY+M
        m52ZzX9/5ND6SEwsQMoMegz2OtZELaiXSuS61XrZ5RrqX7GrLrlhEfW34Swp/turxkEQIO1sIRkfM
        tNNsKlI/qGKlPhvGwhExwrpGzweEFYUtJJCWa4mux4HowvWdaY8HXPsGLZnkdfRHfC+yRQfx1gJJC
        F4yV6oFbZaj9d+SLSw95wDHKoxnwq0HL6NZoIpjGdw1Lp37udC7Y0vEGRndVCSbaLYi+fZnS0287f
        oUKpoP7jf1B9RL4C8wN9qMNWwjFWxfX9xORSixllhBZAW3AxmLs/dtJ2wEGl9El1ZmnfDwwrjvFod
        CleI6WhQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw0Ne-0004td-2E; Thu, 16 Jul 2020 09:40:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4C4A30066E;
        Thu, 16 Jul 2020 11:40:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 63B9826501E59; Thu, 16 Jul 2020 11:40:39 +0200 (CEST)
Date:   Thu, 16 Jul 2020 11:40:39 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
References: <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 08:21:27PM +0200, Geert Uytterhoeven wrote:

> Oh, we actually discussed that:
> https://lore.kernel.org/linux-mm/20191204133454.GW2844@hirez.programming.kicks-ass.net/
> but there was no conclusion...

Urgh.. clearly that fell off the table :-(

So yes, that patch works, but as I wrote, I think it's still broken.
Then again, that particular breakage has been there for a long time.

Ooohh.. I have another whole patch-set that fixes that across
architectures which I forgot about too:

  https://lkml.kernel.org/r/20191211120713.360281197@infradead.org

that actually included the SH fix.

Then Aneesh got a bunch of those patches merged because he needed it for
Power, but the rest bitrotted again.

Let me rebase/refresh the rest of that and send it out again.
