Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879FC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F281520725
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 04:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="apwY8yjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGKE1d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 00:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbgGKE1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 00:27:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A7AC08C5DD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 21:27:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id x8so3054241plm.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 21:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=s199aw7gACo2V2pxPMbOkqhVWvVnsPCcR2goy3FQ+MM=;
        b=apwY8yjn7ouF2qoi06y4Cze6EAEsKFa0Yl8T96s1HcUYikGoquwaQJMcHPdriASRGH
         8dvO/+RFclp5XQl62YFHfXsUqRquuyq7eU6o/X+h9A/grcQ0NP9kefMsU3X7WE15lzBL
         89RNJP/tYutgq8Iaxtj2U1QoNH0/ZCOoRLGfWrzcIApD2VCsaq7WAyu0+DpMEqoIXl16
         6WApu3tHvHETag+03MvH3rcnWxQM0x8FQQYw3XJx3YxenwWrTehtW4VgkaTjjhyR9pXK
         XCrA+xkYyNsEpN0aJc9k6Ev/8r3S8r7g48p8NchyzSuzKss5SciOB5+KZOA1iawk+abC
         5LSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=s199aw7gACo2V2pxPMbOkqhVWvVnsPCcR2goy3FQ+MM=;
        b=Mt8TxHCus/uSx8dtZvdkfEj2/UTg5yOCI8ed0s3bQe8c84fc0x6LHqoIst6BTMlCAd
         DTRmwe6TvNZDr5OpUMbF20dS4sD0FWULW0w5HXcqZ1/yT9YmjpgOAnJocugdBEjv+Z0z
         miEpXPZ4Mb3GWlWhmu9xI0X9GMASj6sYrClIAqNipC9i1B1kCObharvZjaXo/7tNzR38
         +o0Y1o/uLqS7aluGqk/wghRvLoOHlQMqm9tQeSvpcqlThwTKxD3vq39Ju8+0pona5+2+
         lO1cdfeH6Y/vSqVg6XvqMjeAyH62uaXuEkY818RnjD5F/lxjTQ1Ndgn+Bki4a38T8Q5F
         y/ag==
X-Gm-Message-State: AOAM53110LXsJYrxPpVv7rHbAH7K4sKi6lbP2JDVx3ODKgR/38j96p2S
        gHwJSmfH0tSkWNiQSoiaOZWlMvHQzLU=
X-Google-Smtp-Source: ABdhPJwJO4NHu3MJeq/VfzDPjkxm32PdfxWqHvEFAkZPGoAAsGH7cOJo8jDHpVYmlpdOI17Yb7kKuw==
X-Received: by 2002:a17:90a:a413:: with SMTP id y19mr8819172pjp.59.1594441651336;
        Fri, 10 Jul 2020 21:27:31 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id 22sm7495377pfh.157.2020.07.10.21.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 21:27:30 -0700 (PDT)
Date:   Fri, 10 Jul 2020 21:27:30 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Jul 2020 21:27:21 PDT (-0700)
Subject:     Re: [PATCH v2] riscv: Allow building with kcov coverage
In-Reply-To: <20200626124056.29708-1-tklauser@distanz.ch>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Topel <bjorn.topel@gmail.com>, dvyukov@google.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     tklauser@distanz.ch
Message-ID: <mhng-5606ac04-c52e-4211-bd30-fce86df7f0fd@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Jun 2020 05:40:56 PDT (-0700), tklauser@distanz.ch wrote:
> Add ARCH_HAS_KCOV and HAVE_GCC_PLUGINS to the riscv Kconfig.
> Also disable instrumentation of some early boot code and vdso.
>
> Boot-tested on QEMU's riscv64 virt machine.

Thanks.  This is on for-next (with the ack).  I'm boot testing a config with

    CONFIG_KCOV=y
    CONFIG_KCOV_ENABLE_COMPARISONS=y

but LMK if there's something more interesting to test.  I don't see anything
coverage-related in the boot log...

> Cc: Björn Töpel <bjorn.topel@gmail.com>
> Cc: Dmitry Vyukov <dvyukov@google.com>
> Signed-off-by: Tobias Klauser <tklauser@distanz.ch>
> ---
>  arch/riscv/Kconfig              | 2 ++
>  arch/riscv/boot/Makefile        | 2 ++
>  arch/riscv/kernel/vdso/Makefile | 1 +
>  arch/riscv/mm/Makefile          | 2 ++
>  4 files changed, 7 insertions(+)
>
> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index 089293e4ad46..a7d7f8184f15 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -19,6 +19,7 @@ config RISCV
>  	select ARCH_HAS_DEBUG_WX
>  	select ARCH_HAS_GCOV_PROFILE_ALL
>  	select ARCH_HAS_GIGANTIC_PAGE
> +	select ARCH_HAS_KCOV
>  	select ARCH_HAS_MMIOWB
>  	select ARCH_HAS_PTE_SPECIAL
>  	select ARCH_HAS_SET_DIRECT_MAP
> @@ -57,6 +58,7 @@ config RISCV
>  	select HAVE_DMA_CONTIGUOUS if MMU
>  	select HAVE_EBPF_JIT if MMU
>  	select HAVE_FUTEX_CMPXCHG if FUTEX
> +	select HAVE_GCC_PLUGINS
>  	select HAVE_GENERIC_VDSO if MMU && 64BIT
>  	select HAVE_PCI
>  	select HAVE_PERF_EVENTS
> diff --git a/arch/riscv/boot/Makefile b/arch/riscv/boot/Makefile
> index 3530c59b3ea7..c59fca695f9d 100644
> --- a/arch/riscv/boot/Makefile
> +++ b/arch/riscv/boot/Makefile
> @@ -14,6 +14,8 @@
>  # Based on the ia64 and arm64 boot/Makefile.
>  #
>
> +KCOV_INSTRUMENT := n
> +
>  OBJCOPYFLAGS_Image :=-O binary -R .note -R .note.gnu.build-id -R .comment -S
>
>  targets := Image loader
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 29cf052f6541..4b0d3bcc44e5 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -29,6 +29,7 @@ CPPFLAGS_vdso.lds += -P -C -U$(ARCH)
>
>  # Disable gcov profiling for VDSO code
>  GCOV_PROFILE := n
> +KCOV_INSTRUMENT := n
>
>  # Force dependency
>  $(obj)/vdso.o: $(obj)/vdso.so
> diff --git a/arch/riscv/mm/Makefile b/arch/riscv/mm/Makefile
> index 363ef01c30b1..c0185e556ca5 100644
> --- a/arch/riscv/mm/Makefile
> +++ b/arch/riscv/mm/Makefile
> @@ -5,6 +5,8 @@ ifdef CONFIG_FTRACE
>  CFLAGS_REMOVE_init.o = -pg
>  endif
>
> +KCOV_INSTRUMENT_init.o := n
> +
>  obj-y += init.o
>  obj-y += extable.o
>  obj-$(CONFIG_MMU) += fault.o pageattr.o
