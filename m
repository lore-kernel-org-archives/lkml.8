Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F880C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B8AD206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 09:21:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WdKgJulh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgHZJVT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 05:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727884AbgHZJVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 05:21:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C1FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 02:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NbwHyk1VAR3OEivAV0SZE4FfPvn97BA/drW79Zx1uN0=; b=WdKgJulhEjoC3edg6mrrdZ3bdE
        A/KywDLwKdzQb3RNg/XPFSaA8vL6nvFJMvnc4CtyJovROEltahA7Mq8VGUJMS4Bmm1VnCNdjwyWnz
        QZAG9xIt7VlZEJjF0L+HLo57X44HC/232qVUPG7sDrIYQyjsGekguqHYszAt+jETowe3ihQ38c22p
        l0nDByRm99ET46Mq+6niARKSQT17zR3DG/lSjaSoibLzLlbOlJTSdCVAT2L2lcyPOXpIwceE8unvn
        nbP4R85PZ/+tvO9P+GqEAUKS3bkNEcl3oRS5zL7CLxe7Ju8rjWAqS3cbIImF4wAM7wxGGh15Uh3Vq
        rUDCd+Xg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kArcJ-0004Og-GV; Wed, 26 Aug 2020 09:21:15 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3364D301A66;
        Wed, 26 Aug 2020 11:21:13 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 199322B79CD3E; Wed, 26 Aug 2020 11:21:13 +0200 (CEST)
Date:   Wed, 26 Aug 2020 11:21:13 +0200
From:   peterz@infradead.org
To:     "Eddy_Wu@trendmicro.com" <Eddy_Wu@trendmicro.com>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: x86/kprobes: kretprobe fails to triggered if kprobe at function
 entry is not optimized (trigger by int3 breakpoint)
Message-ID: <20200826092113.GS35926@hirez.programming.kicks-ass.net>
References: <8816bdbbc55c4d2397e0b02aad2825d3@trendmicro.com>
 <20200825005426.f592075d13be740cb3c9aa77@kernel.org>
 <7396e7b2079644a6aafd9670a111232b@trendmicro.com>
 <20200825151538.f856d701a34f4e0561a64932@kernel.org>
 <20200825120911.GX1362448@hirez.programming.kicks-ass.net>
 <d3027772a6834f89a1ddc07c0fefaa0a@trendmicro.com>
 <20200826090102.GC1362448@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826090102.GC1362448@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 26, 2020 at 11:01:02AM +0200, peterz@infradead.org wrote:

> Known broken archs include: Sparc32-SMP, PARISC, ARC-v1-SMP.
> There might be a few more, but I've forgotten.

Note that none of those actually have NMIs and llist is mostly OK on
those architectures too.

The problem is when you combine cmpxchg() with regular stores and
llist() doesn't do that.

The only architectures that have NMIs are: ARM, ARM64, POWERPC, s390,
SH, SPARC64, X86 and XTENSA and all of them have sane atomic ops.

(XTENSA is tricky, because it looks like it has parts that don't have
sane atomics, but I _think_ those parts also don't have NMI)
