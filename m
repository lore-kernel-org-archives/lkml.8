Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA18CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91F37206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AEG3Xqx+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728260AbgGPLhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727831AbgGPLhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:37:36 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81252C061755;
        Thu, 16 Jul 2020 04:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=cAxasWlZO5rbqAfbRmZjK6evk3DtyNV2CoEc2bjIOcI=; b=AEG3Xqx+k0Yz4V/dTDwOahXYvC
        h2UnFSoC4QAKeL3tnuH00TrCnOR02Fn4rMlO2+CaFBCxsp97xS3cNW5jJI5fq86Lvpsbs2+Z9blCZ
        zsOd/Mh7cL5tXeSeEG7bEaoUUHGllZB2FoG32b4JVIutNqJeoluBxC0MK3TKJ+EUpLW6fT8INHer1
        JpMkxsFXj/jTUv+La/dmbhEWrqFgTv2sIah2s1HQb8S3FNCXX+8cbZjaWzND0AQqIIMikd9GNXdDe
        h87sZSvWge9lf8iC+zkSD9EqyP2w/a8C3hxiIDD4K3ojP9vktOgtFjjqyMN2kYI/geCcEQWkAbhbi
        xmgZVuOA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw2CY-0004Nc-Hk; Thu, 16 Jul 2020 11:37:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 10AFE300446;
        Thu, 16 Jul 2020 13:37:20 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BD0CC234E2C20; Thu, 16 Jul 2020 13:37:20 +0200 (CEST)
Date:   Thu, 16 Jul 2020 13:37:20 +0200
From:   peterz@infradead.org
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200716113720.GC119549@hirez.programming.kicks-ass.net>
References: <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
 <20200716102934.GC43129@hirez.programming.kicks-ass.net>
 <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
 <20200716110146.GB119549@hirez.programming.kicks-ass.net>
 <008b06d4-1edd-1610-2ee1-6ea402d06114@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <008b06d4-1edd-1610-2ee1-6ea402d06114@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 01:03:36PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Peter!
> 
> On 7/16/20 1:01 PM, peterz@infradead.org wrote:
> >> The build fails with:
> >>
> >>   CC      mm/mmu_gather.o
> >> mm/mmu_gather.c: In function ‘tlb_table_invalidate’:
> >> mm/mmu_gather.c:180:6: error: implicit declaration of function ‘tlb_needs_table_invalidate’; did you mean ‘tlb_table_invalidate’? [-Werror=implicit-function-declaration]
> >>   180 |  if (tlb_needs_table_invalidate()) {
> >>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >>       |      tlb_table_invalidate
> >> cc1: some warnings being treated as errors
> >> make[1]: *** [scripts/Makefile.build:281: mm/mmu_gather.o] Error 1
> >> make: *** [Makefile:1756: mm] Error 2
> > 
> > *sigh*, thanks, I'll go dig out the local cross compiler set then.
> 
> FWIW, I recommend keeping a Debian box at hand where installing the cross-compiler
> is a matter of running "apt install gcc-sh4-linux-gnu" ;-).

I happen to have Debian on most of my machines ;-) And I used to
crosstool build my own toolchains for a while, but these days I mostly
just fetch them from kernel.org, since they're being kept up-to-date
fairly often.

$ /opt/cross/bin/sh4-linux-gcc --version
sh4-linux-gcc (GCC) 10.1.0


