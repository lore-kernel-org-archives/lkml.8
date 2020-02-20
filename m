Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FC6C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02AFB24672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:12:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ebUc8Cao"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728576AbgBTSMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:12:51 -0500
Received: from merlin.infradead.org ([205.233.59.134]:56024 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728162AbgBTSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:12:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Xlld4uxDYeBkjEV6UaxCLq5ZB6ooWTuKdK9ObyxcgUk=; b=ebUc8Caob31d8+S0M+Skfgm80m
        2QObLS2YwrYBWfP4rzvE/zrHpH8XCtUKtZmqXKJtSXUsRmleeSMitNyNNxOeW33W5XSFE65GfY2AV
        L47WfCMwJ8xoe2K0cE/yBQ+/alsKts5GHgj6n8FC8EmhD4e+UfYVJW5AKnMdgMLXv4xoq5SH1GhnV
        NpAOxbdqB6HwM8SAo2fPax67WE4zKuSaE59xfZVSW0HCeZBTH8qgDyMleK1AoQvGuuS4aCkQpq/A2
        TwtbDZ/mclIqf/i0itYYuTIBMw4vXCKQqeZMz64Iju77vo8Lx4fF9fVusahD3J2IVKWylRs9ZugLQ
        +p2N5aRA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4qJS-0002BY-Ck; Thu, 20 Feb 2020 18:12:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CCE38300565;
        Thu, 20 Feb 2020 19:10:43 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AFA712026E97F; Thu, 20 Feb 2020 19:12:36 +0100 (CET)
Date:   Thu, 20 Feb 2020 19:12:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH v2 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200220181236.GC18400@hirez.programming.kicks-ass.net>
References: <20200220173722.2034546-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220173722.2034546-1-jesse.brandeburg@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 09:37:21AM -0800, Jesse Brandeburg wrote:
> Fix many sparse warnings when building with C=1.
> 
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
> 

> @@ -72,9 +74,11 @@ static __always_inline void
>  arch_clear_bit(long nr, volatile unsigned long *addr)
>  {
>  	if (__builtin_constant_p(nr)) {
> +		u8 cmaski = ~CONST_MASK(nr);
> +
>  		asm volatile(LOCK_PREFIX "andb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)~CONST_MASK(nr)));
> +			: "iq" (cmaski));
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>  			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");

Urgh, that's sad. So why doesn't this still generate a warning, ~ should
promote your u8 to int, and then you down-cast to u8 on assignment
again.

So now you have more lines, more ugly casts and exactly the same
generated code; where the win?

Perhaps you should write it like:

		: "iq" (0xFF ^ CONST_MASK(nr))

hmm?
