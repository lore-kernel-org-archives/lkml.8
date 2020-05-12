Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFA7C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D02F020740
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 21:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="FylPsE15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731212AbgELVCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 17:02:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726885AbgELVCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 17:02:02 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE41C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:02:02 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id v63so6967596pfb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 14:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=ayvF8u1Trz98kPzut/fpymP+skmFBSVYrYtlr1DmSGU=;
        b=FylPsE15RtP6ywL7le1gyvsxrmPItQoeC/5Ryg5WHuwi0HcfkcvPiSWmUjVKs8lCMX
         bmDljyY3/7gvmviPldTdLfU4Gs8NapeSyUdlJsTReKuUfoyOHDeg65aEuEAKZWWskEYx
         ZbZUOyUzIJptP/QoXJsD/1wRwyX3QKwfRhEYzozjKVwvpZWNK+GnE594UG/v3AhgeGfv
         gofkpVIahbbP3/7V7MmAgKiAeY7fZ0ppG22okSItXuwTjx6U9Jcki7Sq5Yi7wkbznQz1
         Ch87INmwG2hjL+9unZhTUzOOtMPkkYN6BDbMCi/1bDTHkBy0AvM5TQwMGDjbf5JZ+L5m
         ZXVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=ayvF8u1Trz98kPzut/fpymP+skmFBSVYrYtlr1DmSGU=;
        b=dPbeSnkN4qheNPEIAdijPP7awIeFvhTMWNhXp0STOsdiJiV0ZMq07q/qQ8iC+kf80L
         JcGIPJRoyBPZ+xMxFu62/ERdHE2/6uZ2pB4PBH5M+UAKJIHBTyh9F6i1ECJ07wbT/WAV
         XZnnyW6Wfu3aebSfXoqOXL4h1mmAc9tIxq3/1AEJE5KldgvxddGUZCaOG6ZJhH3vLp9d
         wKLNrh0qyR//dhbLUMco3ygccxnZkLYS0Qu7ZpSVJkHCwGgKCT0sFCP2YzzssmuC0SRa
         jtSlM1gNw1ikJixvAxKfAXn906ECBQhn4b4+wWWPUkHeIotrHwxqQ8Sz0EVH1BkuwACN
         I8Zw==
X-Gm-Message-State: AGi0PuaLHtdHO0FduaPfAscCggQOvsGzQQMgSnlXE3kzKtrcs1igb7VL
        PEAUe2QLPmfm4k3E/5fSbhJ1ayTugAE=
X-Google-Smtp-Source: APiQypKlB/jxdOAsAkgCZwJcJ3f8Oon0jsH3vtTXx3EiO/PQpimL6MarV7shEWha7UHZ3nX7tUkusw==
X-Received: by 2002:aa7:9258:: with SMTP id 24mr23618884pfp.35.1589317321647;
        Tue, 12 May 2020 14:02:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id s123sm12859105pfs.170.2020.05.12.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2020 14:02:00 -0700 (PDT)
Date:   Tue, 12 May 2020 14:02:00 -0700 (PDT)
X-Google-Original-Date: Tue, 12 May 2020 13:54:00 PDT (-0700)
Subject:     Re: [PATCH -next] riscv: perf: RISCV_BASE_PMU should be closeable
In-Reply-To: <20200507150445.174390-2-wangkefeng.wang@huawei.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        wangkefeng.wang@huawei.com, alankao@andestech.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     wangkefeng.wang@huawei.com
Message-ID: <mhng-58148e77-03b6-4c56-98ea-0d0cbf99d522@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 May 2020 08:04:45 PDT (-0700), wangkefeng.wang@huawei.com wrote:
> As 178e9fc47aae("perf: riscv: preliminary RISC-V support") said,
> For RISCV_BASE_PMU, 'this option can also be disable to reduce kernel size',
> but it could not work well, we need diable both RISCV_BASE_PMU and
> PERF_EVENTS manually, or build error will occur when only disable
> RISCV_BASE_PMU.

I'm worried this belies a larger issue related to how this PMU stuff works, but
we have only one PMU right now so it's not a pressing issue.  I've taken this
onto fixes.

Thanks!

>
> Cc: Alan Kao <alankao@andestech.com>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  arch/riscv/include/asm/perf_event.h | 8 ++------
>  arch/riscv/kernel/Makefile          | 2 +-
>  2 files changed, 3 insertions(+), 7 deletions(-)
>
> diff --git a/arch/riscv/include/asm/perf_event.h b/arch/riscv/include/asm/perf_event.h
> index 0234048b12bc..062efd3a1d5d 100644
> --- a/arch/riscv/include/asm/perf_event.h
> +++ b/arch/riscv/include/asm/perf_event.h
> @@ -12,19 +12,14 @@
>  #include <linux/ptrace.h>
>  #include <linux/interrupt.h>
>
> +#ifdef CONFIG_RISCV_BASE_PMU
>  #define RISCV_BASE_COUNTERS	2
>
>  /*
>   * The RISCV_MAX_COUNTERS parameter should be specified.
>   */
>
> -#ifdef CONFIG_RISCV_BASE_PMU
>  #define RISCV_MAX_COUNTERS	2
> -#endif
> -
> -#ifndef RISCV_MAX_COUNTERS
> -#error "Please provide a valid RISCV_MAX_COUNTERS for the PMU."
> -#endif
>
>  /*
>   * These are the indexes of bits in counteren register *minus* 1,
> @@ -82,6 +77,7 @@ struct riscv_pmu {
>  	int		irq;
>  };
>
> +#endif
>  #ifdef CONFIG_PERF_EVENTS
>  #define perf_arch_bpf_user_pt_regs(regs) (struct user_regs_struct *)regs
>  #endif
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index 1f5736e996fd..b355cf485671 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -43,7 +43,7 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
>  obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
>  obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
>
> -obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
> +obj-$(CONFIG_RISCV_BASE_PMU)	+= perf_event.o
>  obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
>  obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
>  obj-$(CONFIG_RISCV_SBI)		+= sbi.o
