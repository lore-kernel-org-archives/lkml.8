Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3F6C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D698E206F7
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 17:26:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aBj6/lGP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDGR0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 13:26:40 -0400
Received: from merlin.infradead.org ([205.233.59.134]:45696 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgDGR0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 13:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=QHtKlTs2KaIESq55FMaA9+K4wJtVD9YC1RoEo72D/Xg=; b=aBj6/lGPkdMbz8tsqagUCQuEfi
        4Eaneh2MHE6feFLtR/4iAWcOGiiqFluGWIZRIqTACrSlgc8O9mk2/qQNTsLd/DTb4NmtDhk4WXOmf
        3bnc5eybaCrkd8rd8uQokPi7CiRLYr023r5lIDFeJ9cmFGwijaJOX108M15YwEIvCPIwBvxtgBVuw
        O5Vj+EeEYVYEWTx7a+qc48r3mJMHqTZ6cqXkljDMPRaOXi9L6+shxxaEmavmMNiwwgxqGGUy0p1nv
        UztOgnaAKZsS268OgV+t90IP2TllJZsXUDxtYoaYI/P/Y/V6tkW9sLeefzxdOwVz4r68s0ZDVxdOo
        Fh7YDcBw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLrzd-0005w4-2Y; Tue, 07 Apr 2020 17:26:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B73CB3010C8;
        Tue,  7 Apr 2020 19:26:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A34D42B0A1247; Tue,  7 Apr 2020 19:26:30 +0200 (CEST)
Date:   Tue, 7 Apr 2020 19:26:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Alexandre Chartre <alexandre.chartre@oracle.com>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de
Subject: Re: [PATCH V2 9/9] x86/speculation: Remove all
 ANNOTATE_NOSPEC_ALTERNATIVE directives
Message-ID: <20200407172630.GH20730@hirez.programming.kicks-ass.net>
References: <20200407073142.20659-1-alexandre.chartre@oracle.com>
 <20200407073142.20659-10-alexandre.chartre@oracle.com>
 <20200407132837.GA20730@hirez.programming.kicks-ass.net>
 <20200407133454.n55u5nx33ruj73gx@treble>
 <89b10eb8-c030-b954-6be3-8830fc6a8daa@oracle.com>
 <3eb36fd2-9827-4c1b-681c-9c1d65c7582f@oracle.com>
 <20200407162838.5hlh6oom4oa45ugt@treble>
 <06605b1c-c9ae-fd18-bcb1-e4a48f2cb60e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <06605b1c-c9ae-fd18-bcb1-e4a48f2cb60e@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 07:01:43PM +0200, Alexandre Chartre wrote:

> I think that's the case with smap_save:
> 
> static __always_inline unsigned long smap_save(void)
> {
>         unsigned long flags;
> 
>         asm volatile (ALTERNATIVE("", "pushf; pop %0; " __ASM_CLAC,
>                                   X86_FEATURE_SMAP)
>                       : "=rm" (flags) : : "memory", "cc");
> 
>         return flags;
> }
> 
> The alternative does change the stack but objtool won't complain
> because it handles the pushf and pop instruction.

Oh bugger; indeed! That'll wreck unwinding.
