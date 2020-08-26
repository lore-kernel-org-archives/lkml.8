Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E08CBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:01:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCCEE206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:01:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ocHhET+O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgHZJBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727816AbgHZJBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:01:08 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4579AC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LWB8kupl2aQ0xANaNIkiPTanQ2SqGuz+Vpym63rGg1A=; b=ocHhET+OTpJXn3pM9znuAp/GOA
        YieMAdUpg28WEz+Ejj2hnPBJoLZ+a7uZZHyCnC25hQuBkq9VE8T3rHadPCUsZVTPhsJ5ToCXasFa2
        AVtGuNUZN3AM4bOJq8VTikLN0LSxL/99P60FW/B6pyCW4Gnflc0MAxdXEba7UYX96pjv7jsemAiAN
        xMQUmJbwEHTv4lj5wU7gcjQXcEQutbi1kY361MYbCTAxm82U9a/Nj0q3tDI+NrR/NCmzUxFGzdS9X
        zqMlFd6TY/wuiNOOntoGdcr5gjvtwnqjcOI/dGsxOIfYMx6VdYh2xhpQT4+SsWqX71/ryHaZEaoxE
        EPIeL3FA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kArIl-0002rX-Mk; Wed, 26 Aug 2020 09:01:03 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8F28C303A02;
        Wed, 26 Aug 2020 11:01:02 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8016D2B79CD3F; Wed, 26 Aug 2020 11:01:02 +0200 (CEST)
Date:   Wed, 26 Aug 2020 11:01:02 +0200
From:   peterz@infradead.org
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200826090102.GC1362448@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 07:07:09AM +0000, Eddy_Wu@trendmicro.com wrote:
> llist operations require atomic cmpxchg, for some arch doesn't have
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG, in_nmi() check might still needed.
> (HAVE_KRETPROBES && !CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG): arc, arm,
> csky, mips
> 

Look at the MIPS NMI handler, it's brilliant ;-)

Anyway, I think that CONFIG could use a little help, the point was to
opt-in to some code, and it was supposed to leave out known broken
architectures.

If your architecture has NMIs (not all of them do) or SMP, and doesn't
have sane atomic ops (CAS or LL/SC), then it's broken crap and I don't
care about it, full stop.

Those architectures are known broken and limp along on pure luck, that
CONFIG flag lets them disable some code that makes them crash faster.

The same with non-coherent SMP, some archs tried to limp along, nobody
cared about them, and I think we've since deleted them. I long for the
day we get to delete the last of these broken atomic archs.

Known broken archs include: Sparc32-SMP, PARISC, ARC-v1-SMP.
There might be a few more, but I've forgotten.


