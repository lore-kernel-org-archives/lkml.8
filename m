Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6763CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D5F5206C1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nh/dOd3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgGPLCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726350AbgGPLCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:02:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123D3C061755;
        Thu, 16 Jul 2020 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=e31p62iGYKy+vgmRoyuczROmqwdKAPPJmVxsEICRpk0=; b=nh/dOd3GGcljWzx0ky0SfaWPQo
        ZRl9DeamjbNa8TE+Ro3fIW9Qsm5xQrBiKY3AH2abAYBhEEjcLjENFBwWgAUdz0ydCw/s7jd+ARbYb
        /3YOozvf3YEQFtqAtd8LTlxhF3RZKAxH+W87v6WXIrlAwobRyxukGjZdZ+7UxYtl3oXcpXxqqg1/M
        FbLgpTjdMa/jZ7D3SdMX5hfXu3xiFSHPbbB74cC1b86tcnQkMy0GlIPiBNpPZDqTOj/vooVTISRoJ
        u4hdrtFNpPv4TS+hG+/UurgNxwkby8cYSAG0WabsRz0XV4BqDwIolXHAY25p4/pDixYSm+Kojp4Oc
        y8VcE9Cw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw1e9-00017a-Sc; Thu, 16 Jul 2020 11:01:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2D692304B90;
        Thu, 16 Jul 2020 13:01:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EEB3E26501E50; Thu, 16 Jul 2020 13:01:46 +0200 (CEST)
Date:   Thu, 16 Jul 2020 13:01:46 +0200
From:   peterz@infradead.org
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Rich Felker <dalias@libc.org>, Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200716110146.GB119549@hirez.programming.kicks-ass.net>
References: <def65208-a38b-8663-492a-cae150027003@physik.fu-berlin.de>
 <b5f1853e-031d-c09d-57d2-fb4baffa01ea@physik.fu-berlin.de>
 <CAMuHMdW8RtJKk3u7RWQKP2tA3AYT2rB2aqhUT1KnJ4tJwWWKDA@mail.gmail.com>
 <b5cd845f-7b5e-af8e-a15d-3ede7e61ced4@physik.fu-berlin.de>
 <0322def7-fc16-c805-8f2b-c88fffce2f1e@physik.fu-berlin.de>
 <2df7ca7f-7e26-c916-b6ac-4ec1913fb8d7@physik.fu-berlin.de>
 <CAMuHMdXjfq=RjJ2doR7XyQMnZUA8ccxKc7_tyUzTX29tpyZojw@mail.gmail.com>
 <20200716094039.GQ10769@hirez.programming.kicks-ass.net>
 <20200716102934.GC43129@hirez.programming.kicks-ass.net>
 <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f4fcb2e7-eca3-9a70-8e32-e3bf341b62eb@physik.fu-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 12:54:51PM +0200, John Paul Adrian Glaubitz wrote:
> Hi Peter!
> 
> On 7/16/20 12:29 PM, peterz@infradead.org wrote:
> >> Then Aneesh got a bunch of those patches merged because he needed it for
> >> Power, but the rest bitrotted again.
> >>
> >> Let me rebase/refresh the rest of that and send it out again.
> > 
> > OK, latest patches here:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git mm/tlb
> > 
> > I'll post once the robot is all green.
> 
> Thanks. I just cherry-picked the two patches for SH and applied them on top
> of Linus' tree plus the patch 73c348f31b63d28d ("sh: Fix unneeded constructor
> in page table allocation") from next-20200710.
> 
> The build fails with:
> 
>   CC      mm/mmu_gather.o
> mm/mmu_gather.c: In function ‘tlb_table_invalidate’:
> mm/mmu_gather.c:180:6: error: implicit declaration of function ‘tlb_needs_table_invalidate’; did you mean ‘tlb_table_invalidate’? [-Werror=implicit-function-declaration]
>   180 |  if (tlb_needs_table_invalidate()) {
>       |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
>       |      tlb_table_invalidate
> cc1: some warnings being treated as errors
> make[1]: *** [scripts/Makefile.build:281: mm/mmu_gather.o] Error 1
> make: *** [Makefile:1756: mm] Error 2

*sigh*, thanks, I'll go dig out the local cross compiler set then.
