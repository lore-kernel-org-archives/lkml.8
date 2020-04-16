Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FD2C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 854E921927
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="MWDvG5+H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633350AbgDPPXS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2442465AbgDPPXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:23:06 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E159C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 08:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=M9wNHq+pJV/W7evRBOcE0MNL1FR2yu97YGtN2R1oU7o=; b=MWDvG5+H5FOuIDBVPwLMYaIisi
        huR1f3hnuAS4/wljed0KyyLYKMVzwZIC0xASn0TjWKQyM2Qcvk1nck98+1w4hkfI50cd3jz2kSXk9
        SKwDH8kZigK1n31z0kIUcKwfGhWfuaUN3mIkytP3GGZk5pTqeWCQwoEQMSwDlX4K3CuwT66XUc2OD
        9uz5zrjYVLDKYgm2RJPtWuWy4nmlfI4tJmTsOxo1m861ebXIiAtbfVZD9rohf8lm9PN89D1s7kKSb
        kT7dIKMAXhkHYEU/cezcS/+aWpoxvmWNWF2Z0DGtFzhXkRiDg3HaEmv+ZF2msCt4s9eSQCfkosBt0
        KPehcKLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jP6Ll-0004WQ-Iw; Thu, 16 Apr 2020 15:22:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ECA9530746C;
        Thu, 16 Apr 2020 17:22:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id DA4B72B0DECD1; Thu, 16 Apr 2020 17:22:42 +0200 (CEST)
Date:   Thu, 16 Apr 2020 17:22:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     jpoimboe@redhat.com, alexandre.chartre@oracle.com
Cc:     linux-kernel@vger.kernel.org, jthierry@redhat.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: [RFC][PATCH 6/7] x86/retpoline: Out-of-line retpoline
Message-ID: <20200416152242.GQ20730@hirez.programming.kicks-ass.net>
References: <20200416150752.569029800@infradead.org>
 <20200416151025.064291444@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416151025.064291444@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Bah, chunks went missing, I'll make sure to push out a working version.

On Thu, Apr 16, 2020 at 05:07:58PM +0200, Peter Zijlstra wrote:
> --- a/arch/x86/lib/retpoline.S
> +++ b/arch/x86/lib/retpoline.S
> @@ -7,15 +7,30 @@
>  #include <asm/alternative-asm.h>
>  #include <asm/export.h>
>  #include <asm/nospec-branch.h>
> +#include <asm/unwind_hints.h>
> +#include <asm/frame.h>
>  
>  .macro THUNK reg
>  	.section .text.__x86.indirect_thunk
>  
> +	.align 32
>  SYM_FUNC_START(__x86_indirect_thunk_\reg)
> -	CFI_STARTPROC
> -	JMP_NOSPEC %\reg
> -	CFI_ENDPROC
> +	JMP_NOSPEC \reg
>  SYM_FUNC_END(__x86_indirect_thunk_\reg)
> +
> +SYM_FUNC_START_NOALIGN(__x86_retpoline_\reg)
> +	ANNOTATE_INTRA_FUNCTION_CALL
> +	call	.Ldo_rop_\@
> +.Lspec_trap_\@:
	UNWIND_HINT_EMPTY
> +	pause
> +	lfence
> +	jmp	.Lspec_trap_\@
> +.Ldo_rop_\@:
> +	mov	%\reg, (%_ASM_SP)
> +	UNWIND_HINT_RET_OFFSET
> +	ret
> +SYM_FUNC_END(__x86_retpoline_\reg)
> +
>  .endm
>  
>  /*
