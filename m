Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E7A6C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:57:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8FAD20737
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 20:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJFr4QsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgH0U5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 16:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726147AbgH0U5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 16:57:24 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC3BAC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:57:24 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b3so4615241qtg.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 13:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rJfXwaHbG/yykBPHsUHYR3+FIiWYlEcAMtX9/Xzsg+c=;
        b=aJFr4QsYzFbEMiwLTBIQsnM40LGFQfg+Gsrddv3kW9ogalLiJfj1zhVV75Ea1aU27+
         0GkrmXRvvoPBpF2s/XdCoER+59/2L03CB92Xp+q88xt+wOYEV+cfQoqGsDHHc46KT526
         1+q/24ycdtUW49/HRko61JwNbzO9DqJp7vmA0WAj0xjS4DN6xAYh3kdX+qwDXEzQ2807
         GmiC6mImtFFMpbo02wdazfTD1BgEn4DMACnVJ1eyB+wukqEv5V2dCl6wYypDKb69PcZu
         x+7xppHOLWx1PGc2wTq6An1Vigr2HBqEdlUh+rBxWvIt8/RnG0gbt7kAkUgqGinwVHh6
         K82g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rJfXwaHbG/yykBPHsUHYR3+FIiWYlEcAMtX9/Xzsg+c=;
        b=GLpZhypC4DilFHbzzKXDwvfqy4fphkCI7ekNe5FRm+lw0UThtbbHiC/5u0x0k09fja
         KvmLuCbd0D1SkyYJnzXfaXOxvGxXVFCPvQqJu5rs8jpVXzPAdVfZxYHaSz71tiKRAP3Y
         DLDFyOWjy/IKcBayQHWIJXfN0Q4Nq5y6OPNMdX5FwRJM6PGORGyJbpbRCRyxNvmMUCV2
         /npQg5iddLE2QdWUIHpCF1s3fihUutFYQK3yjH2oVwSp9Sgv3MBfJU6dC9a/M1hJXuyl
         /Hxd6MJygtxDWVYgDjNEli7sLYyZJbbt7+dbdUZMjNysS7ZXeGUEuctG+TX+shw7kk2R
         RsGg==
X-Gm-Message-State: AOAM530wYSrqFJwUAevKTEzBBa1lqVaBCljMeCMRLDLsr2HL8vULNxWV
        XWOXSu6BgUb8xu19YvO/mzg=
X-Google-Smtp-Source: ABdhPJyJH5wOx352swjJy+MwtjI8YzjEBzWve1uOF5Z5co/I2zyXjP77V8bsW0YRMtubd1vE4CU2iA==
X-Received: by 2002:aed:35b2:: with SMTP id c47mr11445305qte.95.1598561843011;
        Thu, 27 Aug 2020 13:57:23 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:45d1:2600::1])
        by smtp.gmail.com with ESMTPSA id r6sm2742617qtu.93.2020.08.27.13.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 13:57:22 -0700 (PDT)
Date:   Thu, 27 Aug 2020 13:57:20 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Zhenyu Ye <yezhenyu2@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v2] arm64: use a common .arch preamble for inline assembly
Message-ID: <20200827205720.GA987541@ubuntu-n2-xlarge-x86>
References: <20200805181920.4013059-1-samitolvanen@google.com>
 <20200827203608.1225689-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827203608.1225689-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 01:36:08PM -0700, Sami Tolvanen wrote:
> Commit 7c78f67e9bd9 ("arm64: enable tlbi range instructions") breaks
> LLVM's integrated assembler, because -Wa,-march is only passed to
> external assemblers and therefore, the new instructions are not enabled
> when IAS is used.
> 
> This change adds a common architecture version preamble, which can be
> used in inline assembly blocks that contain instructions that require
> a newer architecture version, and uses it to fix __TLBI_0 and __TLBI_1
> with ARM64_TLB_RANGE.
> 
> Fixes: 7c78f67e9bd9 ("arm64: enable tlbi range instructions")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1106
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>

I have verified that this fixes the build with LLVM_IAS=1. Additionally,
I have booted a kernel with this patch on my Raspberry Pi and saw no
adverse affects through a compilation workload.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> Changes in v2:
> - Switched to a standard preamble for the architecture version.
> 
> ---
>  arch/arm64/Makefile               | 11 ++++++++---
>  arch/arm64/include/asm/compiler.h |  6 ++++++
>  arch/arm64/include/asm/tlbflush.h |  6 ++++--
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index b45f0124cc16..20ab5c9375a5 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -82,8 +82,8 @@ endif
>  # compiler to generate them and consequently to break the single image contract
>  # we pass it only to the assembler. This option is utilized only in case of non
>  # integrated assemblers.
> -ifneq ($(CONFIG_AS_HAS_ARMV8_4), y)
> -branch-prot-flags-$(CONFIG_AS_HAS_PAC) += -Wa,-march=armv8.3-a
> +ifeq ($(CONFIG_AS_HAS_PAC), y)
> +asm-arch := armv8.3-a
>  endif
>  endif
>  
> @@ -91,7 +91,12 @@ KBUILD_CFLAGS += $(branch-prot-flags-y)
>  
>  ifeq ($(CONFIG_AS_HAS_ARMV8_4), y)
>  # make sure to pass the newest target architecture to -march.
> -KBUILD_CFLAGS	+= -Wa,-march=armv8.4-a
> +asm-arch := armv8.4-a
> +endif
> +
> +ifdef asm-arch
> +KBUILD_CFLAGS	+= -Wa,-march=$(asm-arch) \
> +		   -DARM64_ASM_ARCH='"$(asm-arch)"'
>  endif
>  
>  ifeq ($(CONFIG_SHADOW_CALL_STACK), y)
> diff --git a/arch/arm64/include/asm/compiler.h b/arch/arm64/include/asm/compiler.h
> index 51a7ce87cdfe..6fb2e6bcc392 100644
> --- a/arch/arm64/include/asm/compiler.h
> +++ b/arch/arm64/include/asm/compiler.h
> @@ -2,6 +2,12 @@
>  #ifndef __ASM_COMPILER_H
>  #define __ASM_COMPILER_H
>  
> +#ifdef ARM64_ASM_ARCH
> +#define ARM64_ASM_PREAMBLE ".arch " ARM64_ASM_ARCH "\n"
> +#else
> +#define ARM64_ASM_PREAMBLE
> +#endif
> +
>  /*
>   * The EL0/EL1 pointer bits used by a pointer authentication code.
>   * This is dependent on TBI0/TBI1 being enabled, or bits 63:56 would also apply.
> diff --git a/arch/arm64/include/asm/tlbflush.h b/arch/arm64/include/asm/tlbflush.h
> index d493174415db..cc3f5a33ff9c 100644
> --- a/arch/arm64/include/asm/tlbflush.h
> +++ b/arch/arm64/include/asm/tlbflush.h
> @@ -28,14 +28,16 @@
>   * not. The macros handles invoking the asm with or without the
>   * register argument as appropriate.
>   */
> -#define __TLBI_0(op, arg) asm ("tlbi " #op "\n"				       \
> +#define __TLBI_0(op, arg) asm (ARM64_ASM_PREAMBLE			       \
> +			       "tlbi " #op "\n"				       \
>  		   ALTERNATIVE("nop\n			nop",		       \
>  			       "dsb ish\n		tlbi " #op,	       \
>  			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
>  			       CONFIG_ARM64_WORKAROUND_REPEAT_TLBI)	       \
>  			    : : )
>  
> -#define __TLBI_1(op, arg) asm ("tlbi " #op ", %0\n"			       \
> +#define __TLBI_1(op, arg) asm (ARM64_ASM_PREAMBLE			       \
> +			       "tlbi " #op ", %0\n"			       \
>  		   ALTERNATIVE("nop\n			nop",		       \
>  			       "dsb ish\n		tlbi " #op ", %0",     \
>  			       ARM64_WORKAROUND_REPEAT_TLBI,		       \
> 
> base-commit: 15bc20c6af4ceee97a1f90b43c0e386643c071b4
> -- 
> 2.28.0.297.g1956fa8f8d-goog
> 
