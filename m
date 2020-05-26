Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UPPERCASE_50_75 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E294CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7E020776
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 19:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="vS7fMYrr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729215AbgEZTbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728986AbgEZTbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 15:31:45 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C758C03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:31:45 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so10528947pgb.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=YFRI8Pzmi8Hkgh9xlFXYHyu3aYx5I7yE+6THkxrPB8I=;
        b=vS7fMYrrAgg3oUBGa3cYcSiEpyRDaWgj11jtVR7CjRp4pnKrHNU7NTOnemnYkB25eH
         2vlyjn5eK/YrvhhtNTGrdGOtMzQtXOFGCeDNsTVjIdts8nhNoF//GK8Uk4zkQJZ3l/FE
         jwjFlTFdVaxtBWbXt1VQcFnYhGZYrxybxa3sysnJVEs1ztOhd8JnIvTA25P7TbsI2Urk
         Vst1Z2KUJ2TwNHGQlj2QR6AioGdlYUileOiWYqvlKJrm5FllyzZseAWzHHGcTlC8jMjt
         oASNMVbCiQkQ5RvIvbvkOBTKbyGva0jrx6L7Rs0VKJ2ljfP7VVb67hqEaZdQKNSYIwRi
         6rlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=YFRI8Pzmi8Hkgh9xlFXYHyu3aYx5I7yE+6THkxrPB8I=;
        b=cQr1+5/lLxKZcSsRIfq3h0nRh639RCMEWV7DslOrEOdLcw/aaQ1ws7gIvI5VgYFd60
         /7rFPALrkPSiEk/gTNReEftAUC+UG/tLNZMsiBDvxcasngjC+3AIHNdB254UyxBoty5F
         aiMshscui1lsHlnmg9C6N0C6nf+kVpNNNtg8lmGPQk3kCQ/xwJuf9j5Gwp9nRoNe7jCK
         dlaHo5c/ZVmB5HPAh5yiO8K2nQrwFUwUaJLf+NxTp8tpOv3SpBf+8KktsyRED4cnOtlp
         eGkVNHLn3owo/lkT8itbdkOFCrhO5HDRheLOEbFSawzWr+VX+u4ODRaNIxI1MzwOd8aT
         w8fQ==
X-Gm-Message-State: AOAM5329qPttoEYe64rj6nCNUIIZNsveQRlBZQy8rNsTQxcsTK8P1LJO
        nnJ+CVXdiDzm/5onS+F0JIZ6kw==
X-Google-Smtp-Source: ABdhPJx7PaDMUCSP3dWG8db1wbzMCLv5XsRADqttAo+C1oTetQidFR58rZotM4lHGR9W7RN7Be9DSA==
X-Received: by 2002:a63:de06:: with SMTP id f6mr475817pgg.238.1590521504497;
        Tue, 26 May 2020 12:31:44 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id d18sm238566pjv.34.2020.05.26.12.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 12:31:43 -0700 (PDT)
Date:   Tue, 26 May 2020 12:31:43 -0700 (PDT)
X-Google-Original-Date: Tue, 26 May 2020 12:31:41 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: sort select statements alphanumerically
In-Reply-To: <0609f8f0c0c7182fda08fc395161ec11309c63fb.1589859647.git.zong.li@sifive.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        zong.li@sifive.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     zong.li@sifive.com
Message-ID: <mhng-7c33e65d-d59d-400e-a056-cd44958c9222@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 May 2020 20:42:04 PDT (-0700), zong.li@sifive.com wrote:
> Like patch b1b3f49 ("ARM: config: sort select statements alphanumerically")
> , we sort all our select statements alphanumerically by using the perl
> script in patch b1b3f49 as above.
>
> As suggested by Andrew Morton:
>
>   This is a pet peeve of mine.  Any time there's a long list of items
>   (header file inclusions, kconfig entries, array initalisers, etc) and
>   someone wants to add a new item, they *always* go and stick it at the
>   end of the list.
>
>   Guys, don't do this.  Either put the new item into a randomly-chosen
>   position or, probably better, alphanumerically sort the list.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/Kconfig | 70 +++++++++++++++++++++++-----------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 74ce5c5249e9..8244b8f7e7c3 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -12,64 +12,64 @@ config 32BIT
>
>  config RISCV
>  	def_bool y
> -	select OF
> -	select OF_EARLY_FLATTREE
> -	select OF_IRQ
>  	select ARCH_HAS_BINFMT_FLAT
> +	select ARCH_HAS_DEBUG_VIRTUAL if MMU
> +	select ARCH_HAS_DEBUG_WX
> +	select ARCH_HAS_GCOV_PROFILE_ALL
> +	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_MMIOWB
> +	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_SET_DIRECT_MAP
> +	select ARCH_HAS_SET_MEMORY
> +	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>  	select ARCH_WANT_FRAME_POINTERS
> +	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>  	select CLONE_BACKWARDS
>  	select COMMON_CLK
> +	select EDAC_SUPPORT
> +	select GENERIC_ARCH_TOPOLOGY if SMP
> +	select GENERIC_ATOMIC64 if !64BIT
>  	select GENERIC_CLOCKEVENTS
> +	select GENERIC_IOREMAP
> +	select GENERIC_IRQ_MULTI_HANDLER
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
> +	select GENERIC_PTDUMP if MMU
>  	select GENERIC_SCHED_CLOCK
> +	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_STRNCPY_FROM_USER if MMU
>  	select GENERIC_STRNLEN_USER if MMU
> -	select GENERIC_SMP_IDLE_THREAD
> -	select GENERIC_ATOMIC64 if !64BIT
> -	select GENERIC_IOREMAP
> -	select GENERIC_PTDUMP if MMU
>  	select HAVE_ARCH_AUDITSYSCALL
> +	select HAVE_ARCH_KASAN if MMU && 64BIT
> +	select HAVE_ARCH_KGDB
> +	select HAVE_ARCH_KGDB_QXFER_PKT
> +	select HAVE_ARCH_MMAP_RND_BITS if MMU
>  	select HAVE_ARCH_SECCOMP_FILTER
> +	select HAVE_ARCH_TRACEHOOK
>  	select HAVE_ASM_MODVERSIONS
> +	select HAVE_COPY_THREAD_TLS
>  	select HAVE_DMA_CONTIGUOUS if MMU
> +	select HAVE_EBPF_JIT if MMU
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
> +	select HAVE_PCI
>  	select HAVE_PERF_EVENTS
>  	select HAVE_PERF_REGS
>  	select HAVE_PERF_USER_STACK_DUMP
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select IRQ_DOMAIN
> -	select SPARSE_IRQ
> -	select SYSCTL_EXCEPTION_TRACE
> -	select HAVE_ARCH_TRACEHOOK
> -	select HAVE_PCI
>  	select MODULES_USE_ELF_RELA if MODULES
>  	select MODULE_SECTIONS if MODULES
> -	select THREAD_INFO_IN_TASK
> +	select OF
> +	select OF_EARLY_FLATTREE
> +	select OF_IRQ
>  	select PCI_DOMAINS_GENERIC if PCI
>  	select PCI_MSI if PCI
>  	select RISCV_TIMER
> -	select GENERIC_IRQ_MULTI_HANDLER
> -	select GENERIC_ARCH_TOPOLOGY if SMP
> -	select ARCH_HAS_PTE_SPECIAL
> -	select ARCH_HAS_MMIOWB
> -	select ARCH_HAS_DEBUG_VIRTUAL if MMU
> -	select HAVE_EBPF_JIT if MMU
> -	select EDAC_SUPPORT
> -	select ARCH_HAS_GIGANTIC_PAGE
> -	select ARCH_HAS_SET_DIRECT_MAP
> -	select ARCH_HAS_SET_MEMORY
> -	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
> -	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>  	select SPARSEMEM_STATIC if 32BIT
> -	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
> -	select HAVE_ARCH_MMAP_RND_BITS if MMU
> -	select ARCH_HAS_GCOV_PROFILE_ALL
> -	select HAVE_COPY_THREAD_TLS
> -	select HAVE_ARCH_KASAN if MMU && 64BIT
> -	select HAVE_ARCH_KGDB
> -	select HAVE_ARCH_KGDB_QXFER_PKT
> -	select ARCH_HAS_DEBUG_WX
> +	select SPARSE_IRQ
> +	select SYSCTL_EXCEPTION_TRACE
> +	select THREAD_INFO_IN_TASK
>
>  config ARCH_MMAP_RND_BITS_MIN
>  	default 18 if 64BIT
> @@ -196,11 +196,11 @@ config ARCH_RV64I
>  	bool "RV64I"
>  	select 64BIT
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
> -	select HAVE_FUNCTION_TRACER
> -	select HAVE_FUNCTION_GRAPH_TRACER
> -	select HAVE_FTRACE_MCOUNT_RECORD
>  	select HAVE_DYNAMIC_FTRACE if MMU
>  	select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
> +	select HAVE_FTRACE_MCOUNT_RECORD
> +	select HAVE_FUNCTION_GRAPH_TRACER
> +	select HAVE_FUNCTION_TRACER
>  	select SWIOTLB if MMU
>
>  endchoice

Thanks.  This is on for-next, except I re-ran the script as there have been
some changes.
