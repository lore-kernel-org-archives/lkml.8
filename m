Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3235BC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C38E2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 10:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GocvHu11"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgGPK3q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 06:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbgGPK3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 06:29:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB1AC061755;
        Thu, 16 Jul 2020 03:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UGfEIAVGBslnhOk9bUWaQvdaga2Bo8BTkjToLxz4Tw4=; b=GocvHu112MzRfzSwjECQ4rYSL5
        W++XBPYrqZgrfrPNJDD3TkcbQjCZSUhq+rgEeDKfDfwZJXkDz6bCknqoxE8hMZJxdOyFH0c9YJZDF
        w521UbalxHgfHAtt7IvOwMJ4q3Bph2YPtw2uwbU0+WIRHN2VIetxGJ28iIDFbg4OZHLafM7H7XdaB
        jyWLxOKbni/fA2g+Bx1rVAt4qQNlRNX/wZbpZ0LQp6jBsrBTATtnF7dg5/KEAlSqaJ8NTmsTPgqcp
        N9ieMLzIs9l/XMUnzvHKG1PPstkwQOPV+msmBaPniLb+G+BF3NQmGr/C3+bkH60s7j6smXPi3eeR+
        fUHZbb7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw190-0007Ax-07; Thu, 16 Jul 2020 10:29:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B9D78300130;
        Thu, 16 Jul 2020 12:29:34 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6FA2A234E2C5C; Thu, 16 Jul 2020 12:29:34 +0200 (CEST)
Date:   Thu, 16 Jul 2020 12:29:34 +0200
From:   peterz@infradead.org
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200716102934.GC43129@hirez.programming.kicks-ass.net>
References: <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <CAMuHMdUre2-fRgLP8YiwjAKN6J=m1vGhPSMMUdpof7jPJfcWuw@mail.gmail.com>
 <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:40:39AM +0200, Peter Zijlstra wrote:
> On Wed, Jul 15, 2020 at 08:21:27PM +0200, Geert Uytterhoeven wrote:
> 
> > Oh, we actually discussed that:
> > https://lore.kernel.org/linux-mm/20191204133454.GW2844@hirez.programming.kicks-ass.net/
> > but there was no conclusion...
> 
> Urgh.. clearly that fell off the table :-(
> 
> So yes, that patch works, but as I wrote, I think it's still broken.
> Then again, that particular breakage has been there for a long time.
> 
> Ooohh.. I have another whole patch-set that fixes that across
> architectures which I forgot about too:
> 
>   https://lkml.kernel.org/r/20191211120713.360281197@infradead.org
> 
> that actually included the SH fix.
> 
> Then Aneesh got a bunch of those patches merged because he needed it for
> Power, but the rest bitrotted again.
> 
> Let me rebase/refresh the rest of that and send it out again.

OK, latest patches here:

  git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git mm/tlb

I'll post once the robot is all green.
