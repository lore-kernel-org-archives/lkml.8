Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A95CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:04:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 022DF2073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 22:04:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Om+hyYPX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730888AbgFVWEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 18:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730736AbgFVWEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:04:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC36BC061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:04:42 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d10so6282777pls.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 15:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tiLvWsLlWI5Mz8yJb26QV5MdQxD2Cn7z8TLlvShCGfU=;
        b=Om+hyYPXJ8zWabYbc6j0NJhRsYt8jMK2RZ8VkZvizn/0iWwTmfV5CpCspe1f49JHQW
         6gV2PbvOVcBmbS6Dkxhwac9tkJmvLeq9OhxwTB6IOmUuEIfpwzibKOjcJaaH8shijbHK
         ngd3RTBVPCWAn6skAEgoIsGV4+tetMcj/rxhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tiLvWsLlWI5Mz8yJb26QV5MdQxD2Cn7z8TLlvShCGfU=;
        b=epbO8KT8LB9Q1IVhMLys4dOQWroGvQypxCgdqypUH3khLZMsdlzz3eDBEqouDVDGHt
         MzuaEKkIZoarWVdTdp1jUYBI2OX+58uxbaFj05MuwHlcLsV/Wm/J9BufLUNyo58Jc3+R
         gkzUDcNQ8bds/HohtziI7bxS7gLuGiQzWY8pSfJmBdV0mmapU0w4ojM7FKyDvYHbNl7o
         giXAvpcB3CFU6vuFz32e4+U1Qzzf/sKe8+zW6TOGZcwzGmRLtoEvpmdYYYLnhN6wC/BE
         UWpxpIIj+4Js6NUHfxafDtReIdcEydJWZKu49C7o/4XXo31G5ZC/gnNmKWEWgEaHfQoH
         SRDg==
X-Gm-Message-State: AOAM531jfxxKOgrNN/npt8R3ZbpPDLks5zGNT/OlitmGflITt0Wt9EsJ
        rFSTozeEhF0M4Z5wxt05aFYVpg==
X-Google-Smtp-Source: ABdhPJzYYstfMbj2bKl5qg6BjBnX7jxPh+vFVKET3pf6cfx1vakKGSEBc4Spw9TWrQtmJz0BX3mj8Q==
X-Received: by 2002:a17:902:8342:: with SMTP id z2mr21209390pln.300.1592863482442;
        Mon, 22 Jun 2020 15:04:42 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id n8sm12462000pgi.18.2020.06.22.15.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 15:04:41 -0700 (PDT)
Date:   Mon, 22 Jun 2020 15:04:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jann Horn <jannh@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Message-ID: <202006221451.2E80C90FF7@keescook>
References: <20200622193146.2985288-1-keescook@chromium.org>
 <20200622193146.2985288-4-keescook@chromium.org>
 <CAG48ez0pRtMZs3Hc3R2+XGHRwt9nZAGZu6vDpPBMbE+Askr_+Q@mail.gmail.com>
 <202006221426.CEEE0B8@keescook>
 <CAG48ez1b_wMkQGj+z=dWSVctikzzw72V3SPexEPm3Aw8LrXGWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez1b_wMkQGj+z=dWSVctikzzw72V3SPexEPm3Aw8LrXGWQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:42:29PM +0200, Jann Horn wrote:
> No, at least on x86-64 and x86 Linux overrides the normal ABI. From
> arch/x86/Makefile:

Ah! Thanks for the pointer.

> 
> # For gcc stack alignment is specified with -mpreferred-stack-boundary,
> # clang has the option -mstack-alignment for that purpose.
> ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
>       cc_stack_align4 := -mpreferred-stack-boundary=2
>       cc_stack_align8 := -mpreferred-stack-boundary=3
> else ifneq ($(call cc-option, -mstack-alignment=16),)
>       cc_stack_align4 := -mstack-alignment=4
>       cc_stack_align8 := -mstack-alignment=8
> endif
> [...]
> ifeq ($(CONFIG_X86_32),y)
> [...]
>         # Align the stack to the register width instead of using the default
>         # alignment of 16 bytes. This reduces stack usage and the number of
>         # alignment instructions.
>         KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align4))
> [...]
> else
> [...]
>         # By default gcc and clang use a stack alignment of 16 bytes for x86.
>         # However the standard kernel entry on x86-64 leaves the stack on an
>         # 8-byte boundary. If the compiler isn't informed about the actual
>         # alignment it will generate extra alignment instructions for the
>         # default alignment which keep the stack *mis*aligned.
>         # Furthermore an alignment to the register width reduces stack usage
>         # and the number of alignment instructions.
>         KBUILD_CFLAGS += $(call cc-option,$(cc_stack_align8))
> [...]
> endif

And it seems that only x86 does this. No other architecture specifies
-mpreferred-stack-boundary...

> Normal x86-64 ABI has 16-byte stack alignment; Linux kernel x86-64 ABI
> has 8-byte stack alignment.
> Similarly, the normal Linux 32-bit x86 ABI is 16-byte aligned;
> meanwhile Linux kernel x86 ABI has 4-byte stack alignment.
> 
> This is because userspace code wants the stack to be sufficiently
> aligned for fancy SSE instructions and such; the kernel, on the other
> hand, never uses those in normal code, and cares about stack usage and
> such very much.

This makes it nicer for Clang:


diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 1df0dc52cadc..f7e1f68fb50c 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -10,6 +10,14 @@ DECLARE_STATIC_KEY_MAYBE(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,
 			 randomize_kstack_offset);
 DECLARE_PER_CPU(u32, kstack_offset);
 
+#ifdef CONFIG_X86_64
+#define ARCH_STACK_ALIGN_MASK	~((1 << 8) - 1)
+#elif defined(CONFIG_X86_32)
+#define ARCH_STACK_ALIGN_MASK	~((1 << 4) - 1)
+#else
+#define ARCH_STACK_ALIGN_MASK	~(0)
+#endif
+
 /*
  * Do not use this anywhere else in the kernel. This is used here because
  * it provides an arch-agnostic way to grow the stack with correct
@@ -23,7 +31,8 @@ void *__builtin_alloca(size_t size);
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
 		u32 offset = this_cpu_read(kstack_offset);		\
-		u8 *ptr = __builtin_alloca(offset & 0x3FF);		\
+		u8 *ptr = __builtin_alloca(offset & 0x3FF &		\
+					   ARCH_STACK_ALIGN_MASK);	\
 		asm volatile("" : "=m"(*ptr));				\
 	}								\
 } while (0)


But I don't like open-coding the x86-ony stack alignment... it should be
in Kconfig or something, I think?

-- 
Kees Cook
