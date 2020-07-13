Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575B8C433E8
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B33421473
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 23:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="DhUEEM1u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726836AbgGMXCG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 19:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbgGMXCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 19:02:04 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC698C061794
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 16:02:03 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so594673pjq.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 16:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=NL3F9IdRTwUV/ohOarjJNv1tgfWhRANdIZblqTPgQE4=;
        b=DhUEEM1u0vzXTaeeqjVUNNQPl3YxCgQHnRlU4mTXrCcP9wdXRBp5OncZ73+JYp2iU9
         BHe7m1wKgvltYJ3JO+OhQJkIbK5Nm+den0mTvXGBnjxOLjXqCUI+pIcokN9MXzcpWcmc
         VCOII1IYjV+Yzpp0W9F3wqqxPACabnIlG078rg5RQsdHLPdwxlSMch18+dA0azggRiVW
         IFAAFJ+QZ14xeG5YBbY3IYC+ciQUL3rqoBcakxR4vdIfr2oy3NLpz1ayc0LtTuQECnL+
         QyJQbHngLR+BjjiLGUqzYNzHKf5daRCGRMNmkEZljVIed7iEkE+rJhNKeNwL429FA5tE
         UEPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=NL3F9IdRTwUV/ohOarjJNv1tgfWhRANdIZblqTPgQE4=;
        b=XXfqx7CaudoGXO2Or2+hidogaGlf7KTnCcOO3rK7vroUcW2XMKoNzxDfNcji+JPbHo
         vyZhleNe6T33HN6DUARNFfPugXMJcWmhAbPPWRrVCp/kwkXEp+G9zQVt8xFSO/Pxxl3P
         tzorICTvJy1xVI5EzaEIBae0q1crF0Cs+dfgLEW+KBTy7bTvg3XnoOkWeG/cIztiLhGw
         Ffk4h4U1jiqXbdillAC+V3/3Gov8dgqXh1RZ288Wy3Fw1XqGKnKleCqWuPPandh+8B8S
         rrLgkcqBBT+F/my95DvpE2SmIAv5Izusi9FtGIeA6e/NW/UkinpS5YY2htoxr9/Z6Sp/
         HLYA==
X-Gm-Message-State: AOAM532QVCQrgdP6so/TncRPhHAwI+ziLTeRjc8IHlryNW1RlhApSUc4
        1/R+QCf13UKUnXgSF3lAKrGcuA==
X-Google-Smtp-Source: ABdhPJwOqEfS8iN03p8MO6UR4stKIF/D0XwZj5+unRESovBGwUEnpb1+mFMtrSDIDR/8Nygzc6WMCQ==
X-Received: by 2002:a17:90a:24ed:: with SMTP id i100mr1796777pje.22.1594681323100;
        Mon, 13 Jul 2020 16:02:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id a17sm13436706pgw.60.2020.07.13.16.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2020 16:02:01 -0700 (PDT)
Date:   Mon, 13 Jul 2020 16:02:01 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Jul 2020 16:01:35 PDT (-0700)
Subject:     Re: [PATCH v2 0/5] Dedicated CLINT timer driver
In-Reply-To: <20200627161957.134376-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        robh+dt@kernel.org, daniel.lezcano@linaro.org, tglx@linutronix.de,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-4d70be69-ef20-4d38-bda4-ec4101530c0a@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 09:19:52 PDT (-0700), Anup Patel wrote:
> The current RISC-V timer driver is convoluted and implements two
> distinct timers:
>  1. S-mode timer: This is for Linux RISC-V S-mode with MMU. The
>     clocksource is implemented using TIME CSR and clockevent device
>     is implemented using SBI Timer calls.
>  2. M-mode timer: This is for Linux RISC-V M-mode without MMU. The
>     clocksource is implemented using CLINT MMIO time register and
>     clockevent device is implemented using CLINT MMIO timecmp registers.
>
> This patchset removes clint related code from RISC-V timer driver and
> arch/riscv directory. Instead, the series adds a dedicated MMIO based
> CLINT driver under drivers/clocksource directory which can be used by
> Linux RISC-V M-mode (i.e NoMMU Linux RISC-V).
>
> The patchset is based up Linux-5.8-rc2 and can be found at riscv_clint_v2
> branch of: https://github.com/avpatel/linux.git
>
> This series is tested on:
>  1. QEMU RV64 virt machine using Linux RISC-V S-mode
>  2. QEMU RV32 virt machine using Linux RISC-V S-mode
>  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
>
> Changes since v1:
>  - Rebased series on Linux-5.8-rc2
>  - Added pr_warn() for case where ipi_ops not available in PATCH1
>  - Updated ipi_inject() prototype to use "struct cpumask *" in PATCH1
>  - Updated CLINT_TIMER kconfig option to depend on RISCV_M_MODE in PATCH4
>  - Added riscv,clint0 compatible string in DT bindings document
>
> Anup Patel (5):
>   RISC-V: Add mechanism to provide custom IPI operations
>   RISC-V: Remove CLINT related code
>   clocksource/drivers/timer-riscv: Remove MMIO related stuff
>   clocksource/drivers: Add CLINT timer driver
>   dt-bindings: timer: Add CLINT bindings

This all generally LGTM, though I haven't been through the code line-by-line
yet.  It touches a bunch of trees, so I'd prefer to have some Acks before
merging -- I'll dig through the RISC-V specific stuff, but the new CLINT driver
probhably deserves a look from one of the clocksource folks.

I think the only issue is that the port will be broken between patch 2 and 4,
as at that point we won't have an M-mode timer driver.  I think it shouldn't be
too much to just reorder these, LMK if you want to do it or you want me to.

Thanks!

>
>  .../bindings/timer/sifive,clint.txt           |  34 +++
>  arch/riscv/Kconfig                            |   2 +-
>  arch/riscv/include/asm/clint.h                |  39 ---
>  arch/riscv/include/asm/smp.h                  |  11 +
>  arch/riscv/include/asm/timex.h                |  28 +--
>  arch/riscv/kernel/Makefile                    |   2 +-
>  arch/riscv/kernel/clint.c                     |  44 ----
>  arch/riscv/kernel/sbi.c                       |  14 ++
>  arch/riscv/kernel/setup.c                     |   2 -
>  arch/riscv/kernel/smp.c                       |  44 ++--
>  arch/riscv/kernel/smpboot.c                   |   4 +-
>  drivers/clocksource/Kconfig                   |  12 +-
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-clint.c             | 229 ++++++++++++++++++
>  drivers/clocksource/timer-riscv.c             |  17 +-
>  include/linux/cpuhotplug.h                    |   1 +
>  16 files changed, 337 insertions(+), 147 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.txt
>  delete mode 100644 arch/riscv/include/asm/clint.h
>  delete mode 100644 arch/riscv/kernel/clint.c
>  create mode 100644 drivers/clocksource/timer-clint.c
