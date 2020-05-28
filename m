Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FE6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6C1F2075A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:19:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="cxBbzS5f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406273AbgE1TTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406264AbgE1TTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:19:37 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21ABAC08C5C7
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:19:37 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id k22so12021792pls.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 12:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=mmM2VvrmQ5V/fdjPQ7PkRywpyNOwhjbBRHuXd3YqIPA=;
        b=cxBbzS5fnQIpBOKLY+4r8oqienqmA//ahqblebZBOQKpKuoKO/Oa9nG3f5edYuZDDh
         ZL47P9ZZn/s65GUm1SdlokHyt05vcsa4mVVrf+JF3yKsKjmoqaCGINAjfi2QmjgjL8n6
         KjDbGedCt7usLAuCyAZewKHC5f3nF4sQQL4fmh5z1HDRvyBf36efSZrXUZaQMlwJCG1V
         YDNW4UNylLMNdCKXtTpCU/bwWuAoXhs3AzvhOBwmEfb/Fr/HYcwjMJmIVB8u7Dt8+gQC
         mNctIxFS9NxQg8PGKIwBYKgkTcb8HC7oA/kL88AWGP37LHToh7ftiE1r/aDwI5pcNXhH
         Sh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=mmM2VvrmQ5V/fdjPQ7PkRywpyNOwhjbBRHuXd3YqIPA=;
        b=sVVOL/mbLrZZMWKrEd2F4iP9q4+l+lJgFUExTUuG8jorhZHJjIgZTPR7ZXIjZTQEWf
         j76/jijdPEYFiT/chAjt3p36RkrPS5KV2PFOtKDouwDKESHLvKs9rF34hLcS3vkSsDVA
         QZ0yYHo7QXJcc7inDoT58rKlUypmmXdyMO6/kikZpHS867dR03QsT59SQ32RE7n4fRLi
         kMWi4FBbrGAEAtSM+Ps8ajEQzvFuBHZTlx2i++y0DBx92mR2309rPExgcdTG2V4q1R4B
         KsqIQO5zdOX0iuLQ5yu9Qc32PE/1jUKr51OL4hpIQmYC3EsKekoH4y/t1jVVUIWRrzNz
         ogNA==
X-Gm-Message-State: AOAM530SK65nAHElw+HFpjpKJkV97UC8Uj6Yr6sLuNMBLSR4T78W3Spe
        +UYdXpZQMpJhlE5RSX+sshAj1g==
X-Google-Smtp-Source: ABdhPJwBcV5uxi0C9jMGFrJiTcKMZ9y+lYUf5miQuFG/Sel6U7MNBhPMAq0i/mfT5dafO6yexVdT7Q==
X-Received: by 2002:a17:90b:3648:: with SMTP id nh8mr5030761pjb.14.1590693576227;
        Thu, 28 May 2020 12:19:36 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id v17sm5613275pfc.190.2020.05.28.12.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 12:19:35 -0700 (PDT)
Date:   Thu, 28 May 2020 12:19:35 -0700 (PDT)
X-Google-Original-Date: Thu, 28 May 2020 10:26:04 PDT (-0700)
Subject:     Re: linux-next: manual merge of the akpm-current tree with the rsic-v tree
In-Reply-To: <20200528192211.2449bd4f@canb.auug.org.au>
CC:     Paul Walmsley <paul@pwsan.com>, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, zong.li@sifive.com,
        rppt@linux.ibm.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, akpm@linux-foundation.org
Message-ID: <mhng-42a49fa7-9216-40d3-9862-d5bed0d97eec@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 02:22:11 PDT (-0700), Stephen Rothwell wrote:
> Hi all,
>
> Today's linux-next merge of the akpm-current tree got a conflict in:
>
>   arch/riscv/Kconfig
>
> between commit:
>
>   b151fefd23b7 ("riscv: sort select statements alphanumerically")

Andrew: Maybe it's easier if just drop the patch?  It comes from a script, so I
can just resurrect it when things are less busy.

>
> from the rsic-v tree and commits:
>
>   e8d3552c4f20 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
>   4d01b8e6220f ("riscv: support DEBUG_WX")
>
> from the akpm-current tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
>
> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/riscv/Kconfig
> index de5c95119de9,68418201734a..000000000000
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@@ -12,47 -12,29 +12,47 @@@ config 32BI
>   
>   config RISCV
>   	def_bool y
>  -	select OF
>  -	select OF_EARLY_FLATTREE
>  -	select OF_IRQ
>   	select ARCH_HAS_BINFMT_FLAT
>  +	select ARCH_HAS_DEBUG_VIRTUAL if MMU
> + 	select ARCH_HAS_DEBUG_WX
>  +	select ARCH_HAS_GCOV_PROFILE_ALL
>  +	select ARCH_HAS_GIGANTIC_PAGE
>  +	select ARCH_HAS_MMIOWB
>  +	select ARCH_HAS_PTE_SPECIAL
>  +	select ARCH_HAS_SET_DIRECT_MAP
>  +	select ARCH_HAS_SET_MEMORY
>  +	select ARCH_HAS_STRICT_KERNEL_RWX if MMU
>  +	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>   	select ARCH_WANT_FRAME_POINTERS
>  +	select ARCH_WANT_HUGE_PMD_SHARE if 64BIT
>   	select CLONE_BACKWARDS
>   	select COMMON_CLK
>  +	select EDAC_SUPPORT
>  +	select GENERIC_ARCH_TOPOLOGY if SMP
>  +	select GENERIC_ATOMIC64 if !64BIT
>   	select GENERIC_CLOCKEVENTS
>  +	select GENERIC_IOREMAP
>  +	select GENERIC_IRQ_MULTI_HANDLER
>   	select GENERIC_IRQ_SHOW
>   	select GENERIC_PCI_IOMAP
>  +	select GENERIC_PTDUMP if MMU
>   	select GENERIC_SCHED_CLOCK
>  +	select GENERIC_SMP_IDLE_THREAD
>   	select GENERIC_STRNCPY_FROM_USER if MMU
>   	select GENERIC_STRNLEN_USER if MMU
>  -	select GENERIC_SMP_IDLE_THREAD
>  -	select GENERIC_ATOMIC64 if !64BIT
>  -	select GENERIC_IOREMAP
>  -	select GENERIC_PTDUMP if MMU
>   	select HAVE_ARCH_AUDITSYSCALL
>  +	select HAVE_ARCH_KASAN if MMU && 64BIT
>  +	select HAVE_ARCH_KGDB
>  +	select HAVE_ARCH_KGDB_QXFER_PKT
>  +	select HAVE_ARCH_MMAP_RND_BITS if MMU
>   	select HAVE_ARCH_SECCOMP_FILTER
>  +	select HAVE_ARCH_TRACEHOOK
>   	select HAVE_ASM_MODVERSIONS
>  +	select HAVE_COPY_THREAD_TLS
>   	select HAVE_DMA_CONTIGUOUS if MMU
>  +	select HAVE_EBPF_JIT if MMU
>   	select HAVE_FUTEX_CMPXCHG if FUTEX
> - 	select HAVE_MEMBLOCK_NODE_MAP
>  +	select HAVE_PCI
>   	select HAVE_PERF_EVENTS
>   	select HAVE_PERF_REGS
>   	select HAVE_PERF_USER_STACK_DUMP
