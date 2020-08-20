Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DF00C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F04620885
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="SaByE2Ro"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgHTR7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTR7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:59:05 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B6CC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:59:04 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d22so1412691pfn.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=XUwiiLpVjvrVKnV1nRDg0dHhuMTCGbT6M70Ypg9exF8=;
        b=SaByE2RoULCCW6JlWROyMquIEwP8kFxel2Fnjirhj9Vcgup6oM7bw881SOcNbNyNBL
         3FAIr/nKfgWRcfiH+ETGsJeXCqjggIpC29O46nfNrw52PX5WH2RRoQqAT2/HLV9+Qs2C
         L+wWjkaH7qpuOppD4bQnJkTGda3xdpNKFbjWtw2OvOiKdH4RZPLCjNgQFiASx5asMt1Z
         jypB06/FpQPj0zr8V1DfauVVeCjVKj3+FLmsPJzRN2T17I2Emkc++1D/XS5hqsYq+xLG
         91Z9HRsAy+blk3bTFn7e0+af2m1cybzhmWxKSa3/EmoedQOC60VZFCIv58vvv9fNq0qQ
         MuLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=XUwiiLpVjvrVKnV1nRDg0dHhuMTCGbT6M70Ypg9exF8=;
        b=pq1/Hj5mlk+WJpd5sS0NRRfnyPuIYu/7+4M9NMyUY1r0Tv7JuhTy8yDC+nlECq8UV1
         8rveKnnjvhMmNrE7CFffcHogZDaTbaUiSKaGTNxWM57JAoue3/er9439XWJWM4G9S/az
         bL2dqXA90zacdnKZo15EjX0KxsfPvljOKARJc4kAt894qSpPpx0zrF8wdh23nZTnx6Vp
         QrfYEPo8YIQ2WrCnaizKrU5LvqYfRRrQOVVYEZmDrwXSqy/gZTYLDr2jXkdtS5GPAfos
         f/rdMKvrguGMjIynB9DY8vfTfNXrDuO2yVVZHoTSh/Se/7gHxltkPChGUtcOTsplEhgb
         RzTA==
X-Gm-Message-State: AOAM532bUyAysy5zGayzvpFNBtIfFIvSq032RkfnceWmwhhOI/CsWE7E
        y3dmIYJXKgWYcOY/Vs1vQhplPA==
X-Google-Smtp-Source: ABdhPJyv5eJgAt0AMjgMs2+J1Lnu/M6su6SmEVB56dEhXO7V6lGWKo4QGVfYZFMrGACSUk5a7edyag==
X-Received: by 2002:aa7:9535:: with SMTP id c21mr3105531pfp.322.1597946343878;
        Thu, 20 Aug 2020 10:59:03 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u65sm3503940pfb.102.2020.08.20.10.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 10:59:03 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:59:03 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Aug 2020 10:58:59 PDT (-0700)
Subject:     Re: [PATCH v7 0/4] Dedicated CLINT timer driver
In-Reply-To: <20200817124251.508183-1-anup.patel@wdc.com>
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
Message-ID: <mhng-2e56e640-bd21-4534-97de-005e4071e3fe@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Aug 2020 05:42:47 PDT (-0700), Anup Patel wrote:
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
> The patchset is based up Linux-5.9-rc1 and can be found at riscv_clint_v7
> branch of: https://github.com/avpatel/linux.git
>
> This series is tested on:
>  1. QEMU RV64 virt machine using Linux RISC-V S-mode
>  2. QEMU RV32 virt machine using Linux RISC-V S-mode
>  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
>
> Changes since v6:
>  - Rebased series on Linux-5.9-rc1
>
> Changes since v5:
>  - Fixed order of compatible strings in PATCH4
>  - Added "additionalProperties: false" in PATCH4
>  - Fixed register space size for example DT node in PATCH4
>
> Changes since v4:
>  - Rebased series on Linux-5.8-rc6
>  - Updated Kconfig option as suggested by Daniel in PATCH2
>  - Removed per-CPU registered flag in PATCH2
>  - Addressed nit comments from Atish in PATCH2
>
> Changes since v3:
>  - Updated commit description of PATCH2
>  - Use clint_get_cycles64() in clint_rdtime() of PATCH2
>  - Call clockevents_config_and_register() only once for each CPU in
>    clint_timer_starting_cpu of PATCH2
>  - Select CLINT timer driver from platform Kconfig in PATCH3
>  - Fixed 'make dt_binding_check' for PATCH4
>
> Changes since v2:
>  - Rebased series on Linux-5.8-rc5
>  - Squashed PATCH3 onto PATCH2 to preserve GIT bisectability
>  - Moved PATCH4 before PATCH2 to preserve GIT bisectability
>  - Replaced CLINT dt-bindings text document with YAML schema
>  - Use SiFive CLINT compatible string as per SiFive IP block versioning
>
> Changes since v1:
>  - Rebased series on Linux-5.8-rc2
>  - Added pr_warn() for case where ipi_ops not available in PATCH1
>  - Updated ipi_inject() prototype to use "struct cpumask *" in PATCH1
>  - Updated CLINT_TIMER kconfig option to depend on RISCV_M_MODE in PATCH4
>  - Added riscv,clint0 compatible string in DT bindings document
>
> Anup Patel (4):
>   RISC-V: Add mechanism to provide custom IPI operations
>   clocksource/drivers: Add CLINT timer driver
>   RISC-V: Remove CLINT related code from timer and arch
>   dt-bindings: timer: Add CLINT bindings
>
>  .../bindings/timer/sifive,clint.yaml          |  60 +++++
>  arch/riscv/Kconfig                            |   2 +-
>  arch/riscv/Kconfig.socs                       |   2 +
>  arch/riscv/configs/nommu_virt_defconfig       |   7 +-
>  arch/riscv/include/asm/clint.h                |  39 ---
>  arch/riscv/include/asm/smp.h                  |  19 ++
>  arch/riscv/include/asm/timex.h                |  28 +--
>  arch/riscv/kernel/Makefile                    |   2 +-
>  arch/riscv/kernel/clint.c                     |  44 ----
>  arch/riscv/kernel/sbi.c                       |  14 ++
>  arch/riscv/kernel/setup.c                     |   2 -
>  arch/riscv/kernel/smp.c                       |  44 ++--
>  arch/riscv/kernel/smpboot.c                   |   4 +-
>  drivers/clocksource/Kconfig                   |  12 +-
>  drivers/clocksource/Makefile                  |   1 +
>  drivers/clocksource/timer-clint.c             | 226 ++++++++++++++++++
>  drivers/clocksource/timer-riscv.c             |  17 +-
>  include/linux/cpuhotplug.h                    |   1 +
>  18 files changed, 371 insertions(+), 153 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
>  delete mode 100644 arch/riscv/include/asm/clint.h
>  delete mode 100644 arch/riscv/kernel/clint.c
>  create mode 100644 drivers/clocksource/timer-clint.c

Thanks.  These are on fixes.
