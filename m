Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE57C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F348020792
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 01:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="igGPxnex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHEBsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 21:48:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbgHEBr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:47:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CC6C061757
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 18:47:58 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id g19so11811675plq.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 18:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=z35UO6HnIK/9Vt8BxL2B6v0nyMlc7In4S/tkPr3TwVg=;
        b=igGPxnexlmFuwPE5EeGmP88OmQ0gYYBKcx+dy0mb9uojAg+3c+f7jLHBfAi94BHKBC
         Fm0aX5kXYqjZy1rq62M7cFj6jgQROB98nmE+4ie/StMubkrAJOilq1PHRmqpUyJm61dJ
         kwE7NgDAqLg09x1KIWeZD195aqJxso//JbPlyipGXdgTx2pZLgDIQlFMLk/xQXVTC7qv
         34thvBJ7o4rywZ8Pac7YgdOVF16C+hYYyBU8FBGne0UG5MbbLCDDeCChNUA7NdQ7C4Js
         ckUiL1jye/WGbYA5SIGq/7OOzwplsx/CvtMbmD4xJVpIQA6NeJnt72aPHghY8HgD/bbr
         p6Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=z35UO6HnIK/9Vt8BxL2B6v0nyMlc7In4S/tkPr3TwVg=;
        b=NGiV5RIBccfHsz4hRKMluLNnVQfR4TEF572bzdpDv9CDNjzHxlOAyfWGMT/3oUa1KN
         ma01uQZ2pbmHDHqdazSItxCg5OBl2JNf6uar/Xsa7bMMqdcOTo3i5aBUyULo1ND3kPKw
         RfpYLQ0euPFHwzpHfSl82vbzwceIQ2lZFxVEw8qwA7Rb9Muwnoi8yn/GkO6gzM0NRhOz
         Gxj4H0IhO2Yy/BevVuF4fii5rqwSJiLtk4P0NLHSlE3LBBdXKijHEHB37F+1mSJaHqT3
         YatavUgw3WKK6UvAe73covaZzXkPowBt/O+OylyC2+ABMNFk7MIIkvtuTD4aXrCcHfqx
         CrBw==
X-Gm-Message-State: AOAM532hs81YcTjg54zOOVz7K3SKJu7a/yXvOpiZKQa15hC42RConoes
        fRgziOtWKgkNBt1iqj9wxy49IA==
X-Google-Smtp-Source: ABdhPJwJxP8HzEV94YtKyYSnAZh4tmKqe23a9pVrM/7QxHx7gCUf115WogBqpe9RDd8sc8G4N+sliQ==
X-Received: by 2002:a17:902:ee4b:: with SMTP id 11mr949000plo.294.1596592077915;
        Tue, 04 Aug 2020 18:47:57 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c9sm517612pjr.35.2020.08.04.18.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 18:47:57 -0700 (PDT)
Date:   Tue, 04 Aug 2020 18:47:57 -0700 (PDT)
X-Google-Original-Date: Tue, 04 Aug 2020 18:47:38 PDT (-0700)
Subject:     Re: [PATCH v6 0/4] Dedicated CLINT timer driver
In-Reply-To: <20200724071822.126758-1-anup.patel@wdc.com>
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
Message-ID: <mhng-54a5823f-7fa3-42c9-ad28-ee5a4d28c726@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 00:18:18 PDT (-0700), Anup Patel wrote:
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
> The patchset is based up Linux-5.8-rc6 and can be found at riscv_clint_v6
> branch of: https://github.com/avpatel/linux.git
>
> This series is tested on:
>  1. QEMU RV64 virt machine using Linux RISC-V S-mode
>  2. QEMU RV32 virt machine using Linux RISC-V S-mode
>  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
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

Thanks, this is way cleaner.  Patchwork is still broken but IIRC we reached
consensus on these.  I'm not going to include these in my first 5.9 PR, as I
want to get that out tomorrow to avoid more merge conflicts, but assuming
there's reviews from the other maintainers I'd like to take this for my second
5.9 merge window PR.

Assuming you've been collecting reviews and acks, do you mind posting another
version with them?  If not I have some scripts to dig them out, so it's not a
big deal.
