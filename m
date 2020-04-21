Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A0F1C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C290206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="RvXhuxRe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbgDUTwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 15:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726039AbgDUTwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 15:52:09 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86967C0610D6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:52:09 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o10so4031991pgb.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 12:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=neTotun9xvyLxtrGYKrhEcqeY2lnlgT841hPhcr3iwk=;
        b=RvXhuxReyrpoxbZ3nHgXGf/SZuUU7csTsLgM+H0XcLuiRX4Vx3Pe9iHu4NgZhAfwJi
         c8Ok4DlFPTrlxLeuqhZD8SBj7dgBJnq3a+6LO6ENQsEHXqIS4VP2q2xq1NHi+g0kgnSR
         vAoZkntCGW3OpDOA0/1UwQPtGdiCRGCLAi4akCNn9tnwcH1h+fykVG/1xembcWHNgtUV
         wf0ZimevjRlfwlUXkxqh5SiwMq8+cCTNnosyY6XoPaLx+iN7bGKTBDVYGf9J00dW9z/X
         DFR7NMxeB+Jxd6v3E/do3uYVzaiYT7FSHfrshpXtVYbUxYqE1zndC9PWgUA6WNllQ+WZ
         MVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=neTotun9xvyLxtrGYKrhEcqeY2lnlgT841hPhcr3iwk=;
        b=VCiY5RDnKA4859wiVone6CQ4OqmU0QkUeOf6NGNUXfBohmSI6XJuWWRv+QSI2KHRiy
         6sRPujeTZp0d6mdBngjfV3pzA4cIvKBtKWbMirJOymxDAUbCr2I8KfjyrtHLwrdbVFwU
         jzSw1WH5y1OU5UlAA7T6SnGxgITqKAMSUmzkxiw02HaX0AAfZ8uWF4nBPIxiWWoNt29G
         dqOanEIkMHIWB6qV5YmCDkGVNjksfuykOTR/AvDXAc1KB5YEo89OTaGYLhL4ZCwHpgUU
         ocEP4afBet9mE9SWa6AO0yEhUBUEu5OYxuRaoKehf76S02JxKmwKrqmdGNv2Cj2NUK7t
         xatA==
X-Gm-Message-State: AGi0PuahdQU4qlrWaya/IvjiLy+TyVf3PvV5qjU4AfjQ5scZDbTvna8M
        Ew+Is+qXbimk3VjyjU1Vr9VgR5QiAC09Nw==
X-Google-Smtp-Source: APiQypKmTOXNZB7xwi87IfFfpxa8Nzp6hEUEvM5xoGvvGASLbuaDC0up054cw6JLM4XxzFHBeJCEfA==
X-Received: by 2002:a63:3306:: with SMTP id z6mr22822734pgz.147.1587498726451;
        Tue, 21 Apr 2020 12:52:06 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id p24sm2784468pff.92.2020.04.21.12.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 12:52:05 -0700 (PDT)
Date:   Tue, 21 Apr 2020 12:52:05 -0700 (PDT)
X-Google-Original-Date: Tue, 21 Apr 2020 12:47:58 PDT (-0700)
Subject:     Re: [v4 PATCH 1/3] RISC-V: Define fixmap bindings for generic early ioremap support
In-Reply-To: <20200421033336.9663-2-atish.patra@wdc.com>
CC:     linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        ardb@kernel.org, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, masahiroy@kernel.org,
        xypron.glpk@gmx.de
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Atish Patra <Atish.Patra@wdc.com>
Message-ID: <mhng-613ec31b-83df-4a01-998c-e2d682787c1b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I missed that there's a v4 now, so I'm jumping over here

On Mon, 20 Apr 2020 20:33:34 PDT (-0700), Atish Patra wrote:
> UEFI uses early IO or memory mappings for runtime services before
> normal ioremap() is usable. This patch only adds minimum necessary
> fixmap bindings and headers for generic ioremap support to work.
>
> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/riscv/Kconfig              |  1 +
>  arch/riscv/include/asm/Kbuild   |  1 +
>  arch/riscv/include/asm/fixmap.h | 18 ++++++++++++++++++
>  arch/riscv/include/asm/io.h     |  1 +
>  4 files changed, 21 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a197258595ef..f39e326a7a42 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -68,6 +68,7 @@ config RISCV
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select HAVE_COPY_THREAD_TLS
>  	select HAVE_ARCH_KASAN if MMU && 64BIT
> +	select GENERIC_EARLY_IOREMAP
>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> diff --git a/arch/riscv/include/asm/Kbuild b/arch/riscv/include/asm/Kbuild
> index 3d9410bb4de0..59dd7be55005 100644
> --- a/arch/riscv/include/asm/Kbuild
> +++ b/arch/riscv/include/asm/Kbuild
> @@ -1,4 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0
> +generic-y += early_ioremap.h
>  generic-y += extable.h
>  generic-y += flat.h
>  generic-y += kvm_para.h
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 2368d49eb4ef..ba5096d65fb0 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -30,6 +30,24 @@ enum fixed_addresses {
>  	FIX_TEXT_POKE1,
>  	FIX_TEXT_POKE0,
>  	FIX_EARLYCON_MEM_BASE,
> +	/*
> +	 * Make sure that it is 2MB aligned.
> +	 */
> +#define NR_FIX_SZ_2M	(SZ_2M / PAGE_SIZE)
> +	FIX_THOLE = NR_FIX_SZ_2M - FIX_PMD - 1,
> +
> +	__end_of_permanent_fixed_addresses,
> +	/*
> +	 * Temporary boot-time mappings, used by early_ioremap(),
> +	 * before ioremap() is functional.
> +	 */
> +#define NR_FIX_BTMAPS		(SZ_256K / PAGE_SIZE)
> +#define FIX_BTMAPS_SLOTS	7
> +#define TOTAL_FIX_BTMAPS	(NR_FIX_BTMAPS * FIX_BTMAPS_SLOTS)
> +
> +	FIX_BTMAP_END = __end_of_permanent_fixed_addresses,
> +	FIX_BTMAP_BEGIN = FIX_BTMAP_END + TOTAL_FIX_BTMAPS - 1,
> +
>  	__end_of_fixed_addresses
>  };
>
> diff --git a/arch/riscv/include/asm/io.h b/arch/riscv/include/asm/io.h
> index 0f477206a4ed..047f414b6948 100644
> --- a/arch/riscv/include/asm/io.h
> +++ b/arch/riscv/include/asm/io.h
> @@ -14,6 +14,7 @@
>  #include <linux/types.h>
>  #include <asm/mmiowb.h>
>  #include <asm/pgtable.h>
> +#include <asm/early_ioremap.h>
>
>  /*
>   * MMIO access functions are separated out to break dependency cycles

Just so it doesn't get lost (the patch is the same)

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
