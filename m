Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45BB8C433E6
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:47:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218E820658
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hexumMpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729668AbgGOOrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGOOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:47:47 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54246C061755;
        Wed, 15 Jul 2020 07:47:47 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id l19so1289366ybl.1;
        Wed, 15 Jul 2020 07:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bp4PVsFW0LtvTy1uSaUWcuNw+kagy97KCSipJYMggCQ=;
        b=hexumMpGeSEXA3l0fsoqLMPiTOOt6NDKYeOKLBcsvusm5J9XKouL/MnlYa2z+YTwKF
         Q0jx702KovmFtFGj7LlLBOtvIhSSRXbCTBRTqAxmx0l2gOqR+FjkeVK7aviaIKQMmP9Y
         jL5nqhY/Y1vphrr9UJSHr405mscv0dxFJTd3o1X/eHnJs3sg3qKVGGygNEr5e8Auu6IM
         +LMCj+l6x0SEqdzZGC+Rktk8J53g4ecxhH9896LP6P25noVkVpr/rxUdEQsOweaU/Iom
         EuypJIOTpJIztczqg08nWQJbXcM3SdYDmceJKVfdoxynqsJU12iTjWPAY6yyBsSnqTkS
         qygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bp4PVsFW0LtvTy1uSaUWcuNw+kagy97KCSipJYMggCQ=;
        b=q4BoGxaMSrAdFITOBIDnyLXwA0OLHqsfd/ALO9DLDh1EpGkTCEsGULRB4DPFQZw2aw
         ysdsE3m9huRfi2iQvoezSk1qoZEt84o14ET7Xu5v9H9f2rtpkw1JE5Kl6Hi1D0/SxrOA
         /HdNRFHNcvFgkuuNF8ZzW3eZxY7FNlyBdFBAPZud21IJD4W5QLvdkYs45f1nNM7jWYVf
         0tqK7yEWE8SJyvAvhRjMx6EweiI2yFwKz15DG2iYYWdRE9GpQ6CbbukFcawqfdCd4BAM
         BDLDnkHnvFUU1Qes25EkrHe+g1o8Wsoga9/LDeIqHnfOdtTHdwLybyfsNc0kf7Ccnwld
         F8gA==
X-Gm-Message-State: AOAM532KXjbQF91V6upfvQMCAyigzbnbAEIkjl1ZXY6pkMIm32GOQNWB
        +wmfEq6szgwbhCdS7x7s5IMcw66lB0RO1hHsbqA=
X-Google-Smtp-Source: ABdhPJwULUkEFDI2jqj1+CxenzjfhhhrM6xtsW5Wvy4LJwBSf/g78zVIMkZTLgLMeSC8igmLZ0CBrwb/cLvqI3Wd7MU=
X-Received: by 2002:a25:6806:: with SMTP id d6mr16438685ybc.124.1594824466559;
 Wed, 15 Jul 2020 07:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200715071506.10994-1-anup.patel@wdc.com>
In-Reply-To: <20200715071506.10994-1-anup.patel@wdc.com>
From:   Emil Renner Berthing <emil.renner.berthing@gmail.com>
Date:   Wed, 15 Jul 2020 16:47:34 +0200
Message-ID: <CANBLGcwukAUP45+UOeL_Xw3=xNX=kNcLX9nLR6mRp2-r+NO2FA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Dedicated CLINT timer driver
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 at 09:15, Anup Patel <anup.patel@wdc.com> wrote:
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
> The patchset is based up Linux-5.8-rc5 and can be found at riscv_clint_v3
> branch of: https://github.com/avpatel/linux.git
>
> This series is tested on:
>  1. QEMU RV64 virt machine using Linux RISC-V S-mode
>  2. QEMU RV32 virt machine using Linux RISC-V S-mode
>  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
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
>  .../bindings/timer/sifive,clint.yaml          |  58 +++++
>  arch/riscv/Kconfig                            |   2 +-
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
>  drivers/clocksource/timer-clint.c             | 229 ++++++++++++++++++
>  drivers/clocksource/timer-riscv.c             |  17 +-
>  include/linux/cpuhotplug.h                    |   1 +
>  16 files changed, 369 insertions(+), 147 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
>  delete mode 100644 arch/riscv/include/asm/clint.h
>  delete mode 100644 arch/riscv/kernel/clint.c
>  create mode 100644 drivers/clocksource/timer-clint.c

If it makes any difference I tested this both in Qemu and on the
HiFive Unleashed,
but I don't have a working no-mmu setup.

Tested-by: Emil Renner Berhing <kernel@esmil.dk>

/Emil
