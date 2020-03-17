Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C50C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:26:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B054320752
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 19:26:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cW18jyzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgCQTZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 15:25:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57528 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQTZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 15:25:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vKdeCR5v4njZCDrZvSq1JQqfwi1pWZ80ukR5WlwW/rM=; b=cW18jyzkxTJQPbow+nTiRjbuKg
        6f7G/SkUyYxb0TCnl+KQZRL1T4AKnKeagViQrH4qXH14RZAVFfmWkdN6hzRft+80Tgw7we4CRo1lL
        UJzPtNh3gLR6EdSML9ZBMbIHJA4z2RbXmI1zNTyvbU3tO9nCc2DRNabDUP83klPt48FbrEL/jDGUu
        vHjEvQmNhMduVL0dz/OUWGGTz1fXFvEiBR5JK/9vJP6Tjs1+c8zol0YB818AhJKFVOmXYZC3N+MUi
        S29Koszere5CX3hY7R+UoSc7MQYVva9ita7A3lJ5u7aiVmc32ihEk7jT7QGuuzxWLAIDOIxamZclv
        e0wLNH3w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEHqV-0008ED-F2; Tue, 17 Mar 2020 19:25:47 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C6C0E304D2C;
        Tue, 17 Mar 2020 20:25:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B33D1284D7DF5; Tue, 17 Mar 2020 20:25:44 +0100 (CET)
Date:   Tue, 17 Mar 2020 20:25:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux@rasmusvillemoes.dk,
        andriy.shevchenko@intel.com, dan.j.williams@intel.com
Subject: Re: [PATCH v6 1/2] x86: fix bitops.h warning with a moved cast
Message-ID: <20200317192544.GF20713@hirez.programming.kicks-ass.net>
References: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310221747.2848474-1-jesse.brandeburg@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 03:17:46PM -0700, Jesse Brandeburg wrote:
> Fix many sparse warnings when building with C=1. These are useless
> noise from the bitops.h file and getting rid of them helps devs
> make more use of the tools and possibly find real bugs.
> 
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f becomes 7f)
> 
> CONST_MASK() is using a signed integer "1" to create the mask which is
> later cast to (u8), in order to yield an 8-bit value for the assembly
> instructions to use. Simplify the expressions used to clearly indicate
> they are working on 8-bit values only, which still keeps sparse happy
> without an accidental promotion to a 32 bit integer.
> 
> The warning was occurring because certain bitmasks that end with a bit
> set next to a natural boundary like 7, 15, 23, 31, end up with a mask
> like 0x7f, which then results in sign extension due to the integer
> type promotion rules[1]. It was really only "clear_bit" that was
> having problems, and it was only on some bit checks that resulted in a
> mask like 0xffffff7f being generated after the inversion.
> 
> Verified with a test module (see next patch) and assembly inspection
> that the patch doesn't introduce any change in generated code.
> 
> [1] https://stackoverflow.com/questions/46073295/implicit-type-promotion-rules
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Boris, can you make this happen?

> ---
> v6: reworded commit message, enhanced explanation
> v5: changed code to use simple AND and XOR, updated commit message
> v4: reverse argument order as suggested by David Laight, added reviewed-by
> v3: Clean up the header file changes as per peterz.
> v2: use correct CC: list
> ---
>  arch/x86/include/asm/bitops.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 062cdecb2f24..53f246e9df5a 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
> @@ -54,7 +54,7 @@ arch_set_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "orb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)CONST_MASK(nr))
> +			: "iq" (CONST_MASK(nr) & 0xff)
>  			: "memory");
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(bts) " %1,%0"
> @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "andb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)~CONST_MASK(nr)));
> +			: "iq" (CONST_MASK(nr) ^ 0xff));
>  	} else {
>  		asm volatile(LOCK_PREFIX __ASM_SIZE(btr) " %1,%0"
>  			: : RLONG_ADDR(addr), "Ir" (nr) : "memory");
> 
> base-commit: 8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238
> -- 
> 2.24.1
> 
