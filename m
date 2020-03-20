Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B46C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB0220767
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 08:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pUzm+5eU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCTI0T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 04:26:19 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726232AbgCTI0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 04:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RAiCDcH77jHDXYkeTD8SKPLyPkTVQvNLw8kPgs7l5xU=; b=pUzm+5eUP3tPVNOkrWaFIeBxRc
        yRcTLahi18JHzsFCG6HFwFLz0Do+6lzpyphE8AszSbKwXFoUEgFrGwEx42r8QazBKt4v0nzF4e/KE
        Ybkd/YoygJOTf+ovXA8ew0amG51k21gWYNi2V615IE1hEeEvrfJ3Uz1W5ceti7ea6JiWFRq2wmJPh
        Yq4zZpyCdMfJDPc9wMdrZ4FmxIy7Xw/BriaARsAc42/DDtHmsNAiGrfPWduspu5o0NxYB3C1SCqUW
        jl2J526fddPFI3U6poBL3EueBCU72Uv/ZF7ZH3b6rDEDjsnZLzx2ZxkPmReA7OzsBC3GOLFFT61Wm
        d4SBC+Qw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jFCyu-0008KV-9t; Fri, 20 Mar 2020 08:26:16 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CFE08300235;
        Fri, 20 Mar 2020 09:26:13 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8F16E286B1726; Fri, 20 Mar 2020 09:26:13 +0100 (CET)
Date:   Fri, 20 Mar 2020 09:26:13 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: linux-next: Tree for Mar 18 (objtool)
Message-ID: <20200320082613.GA20696@hirez.programming.kicks-ass.net>
References: <20200318220920.48df2e76@canb.auug.org.au>
 <d7dc5b4a-9a7e-ccf7-e00e-2e7f0e79a9bc@infradead.org>
 <20200318182352.2dgwwl4ugbwndi4x@treble>
 <20200318200542.GK20730@hirez.programming.kicks-ass.net>
 <20200319173101.wufpymi7obhqgoqd@treble>
 <20200319173326.oj4qs24x4ly5lrgt@treble>
 <20200319174028.azzaisoj5gbss7zk@treble>
 <20200319174550.4wpx4j357nw67nzz@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319174550.4wpx4j357nw67nzz@treble>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 12:45:50PM -0500, Josh Poimboeuf wrote:
> > On Thu, Mar 19, 2020 at 12:33:31PM -0500, Josh Poimboeuf wrote:

> > > Actually I suspect it's the __builtin_unreachable() annotation which is
> > > making UBSAN add the __builtin_trap()...  because I don't see any double
> > > UD2s for WARNs.

> Actually, removing __builtin_unreachable() *does* make the extra UD2 go
> away -- I forgot I had some silly debug code.

LOL, check this:

"Built-in Function: void __builtin_unreachable (void)

    If control flow reaches the point of the __builtin_unreachable, the
    program is undefined. It is useful in situations where the compiler
    cannot deduce the unreachability of the code. "

Which, I bet, is what makes UBSAN insert that __builtin_trap().

What a friggin mess :/
