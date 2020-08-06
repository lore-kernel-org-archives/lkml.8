Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F41E2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6082923119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:12:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgHFRMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:12:41 -0400
Received: from foss.arm.com ([217.140.110.172]:45656 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730159AbgHFRMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:12:35 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9D8001FB;
        Thu,  6 Aug 2020 05:01:13 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1D4243F99C;
        Thu,  6 Aug 2020 05:01:12 -0700 (PDT)
Date:   Thu, 6 Aug 2020 13:01:09 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>, Zhenyu Ye <yezhenyu2@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: tlb: fix ARM64_TLB_RANGE with LLVM's integrated
 assembler
Message-ID: <20200806120109.GD23785@gaia>
References: <20200805181920.4013059-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805181920.4013059-1-samitolvanen@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:19:20AM -0700, Sami Tolvanen wrote:
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index d493174415db..66c2aab5e9cb 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -16,6 +16,16 @@
>  #include <asm/cputype.h>
>  #include <asm/mmu.h>
>  
> +/*
> + * Enable ARMv8.4-TLBI instructions with ARM64_TLB_RANGE. Note that binutils
> + * doesn't support .arch_extension tlb-rmi, so use .arch armv8.4-a instead.
> + */
> +#ifdef CONFIG_ARM64_TLB_RANGE
> +#define __TLBI_PREAMBLE	".arch armv8.4-a\n"
> +#else
> +#define __TLBI_PREAMBLE
> +#endif
> +
>  /*
>   * Raw TLBI operations.
>   *
> @@ -28,14 +38,16 @@
>   * not. The macros handles invoking the asm with or without the
>   * register argument as appropriate.
>   */
> -#define __TLBI_0(op, arg) asm ("tlbi " #op "\n"				       \
> +#define __TLBI_0(op, arg) asm (__TLBI_PREAMBLE				       \
> +			       "tlbi " #op "\n"				       \
>  		   ALTERNATIVE("nop\n			nop",		       \
>  			       "dsb ish\n		tlbi " #op,	       \
>  			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
>  			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
>  			    : : )
>  
> -#define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"			       \
> +#define __TLBI_1(op, arg) asm (__TLBI_PREAMBLE				       \
> +			       "tlbi " #op ", %0\n"			       \
>  		   ALTERNATIVE("nop\n			nop",		       \
>  			       "dsb ish\n		tlbi " #op ", %0",     \
>  			       ARM64_WORKAROUND_REPEAT_TLBI,		       \

A potential problem here is that for gas (not sure about the integrated
assembler), .arch overrides any other .arch. So if we end up with two
preambles included in the same generated .S files in the future, it will
lead to some random behaviour.

Does the LLVM integrated assembler have the same behaviour on .arch
overriding a prior .arch?

Maybe a better solution is for all inline asm on arm64 to have a
standard preamble which is the maximum supported architecture version.
We can add individual .arch_extension as those are not overriding.

-- 
Catalin
