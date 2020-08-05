Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDAAC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0418D2067C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 09:38:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="pqRKHVVu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgHEJiW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 05:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgHEJhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 05:37:47 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5511CC061757
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 02:37:26 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x5so5198227wmi.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 02:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sa5qXdemmtPrCWAxdmJHhP03xcaLaJDyrq3fN/vAu4U=;
        b=pqRKHVVurNL9xDGPRzkBqZKrsvlm6ebrdoTbuCmUbHaR2igYkNqOTrIraIk2xK9bfX
         TichTCfgIeuOXRE8tgE+68RKy1i/mJ/3BMxiYvvhFbidZi3wX0AxO+u7zDclOKZHxTYQ
         div7bohh2QkW6VYS10xA6cLHdzbthzAO2RWe8vzWPV6vhyuM7aguyEblWQwyJZKvNA86
         fA+/ZDxNUVrQM5nPu5QLKNhhPoJV10CnEeQjrTdpyxqMswPzD6UEHEr9K6bVPBaXVaKp
         V0VaYjFQ5LHtBdnQDQF1KGTFuOjztEngxG+sZe1Irj0/uB8n1qEfYxJ3T//RKOZXGXdi
         y2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sa5qXdemmtPrCWAxdmJHhP03xcaLaJDyrq3fN/vAu4U=;
        b=d5CsQKwZ16SR7RNbYXSGbkLxvH9FAQhbxAuv1H78ckWQ/dmNyCtUG3bH43iE8iwOrI
         8atyHhYQckPWhnwmWReDBtIXDLlREtmUeMWFT55S07Iob+wAEN1FymI8BUdOrG3hZRhf
         nsscBR0Yuyg4ApQ+VEa1iP5Pge7rpuXLCC6u1886d6ZppJcXhkY2sAgCrT8p7JGnTsrC
         cUm4lpTavw9XukcVflwJf1tFyMlcAEds060/PIFDnZNA7xQ8/Iwvf+V1ffv5mdGyhvwQ
         Yjf3FiSNvMIAu4xQrP/+e7LYwXorMzWgutc19Q5xw8TppHI4JmjTbFNcFJuX3MLSI8zi
         TLXQ==
X-Gm-Message-State: AOAM533Z+ciYNTrOsQnsUdT1bREHEsMEejZo2T3L6gnacMPFN8z5C0W2
        ALVKq2mxm8CPWFSGIGrcMezWpEYf8ejJ/7ugmkwZbQ==
X-Google-Smtp-Source: ABdhPJyrfugmunkVBA6Tq7v4TZjnpR1y3YD1khUpx+jbC4LaW34FDjfZSGZdsHD8cnc/wODH4xvSTWE9kR1//gQ7KvY=
X-Received: by 2002:a1c:6689:: with SMTP id a131mr2349662wmc.157.1596620244449;
 Wed, 05 Aug 2020 02:37:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200724071822.126758-1-anup.patel@wdc.com> <mhng-54a5823f-7fa3-42c9-ad28-ee5a4d28c726@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-54a5823f-7fa3-42c9-ad28-ee5a4d28c726@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Wed, 5 Aug 2020 15:07:03 +0530
Message-ID: <CAAhSdy1cR8aBkiyR3ErmTBECm_cgRtd9KNb=91LhPEte0QOGBA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] Dedicated CLINT timer driver
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 7:17 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Fri, 24 Jul 2020 00:18:18 PDT (-0700), Anup Patel wrote:
> > The current RISC-V timer driver is convoluted and implements two
> > distinct timers:
> >  1. S-mode timer: This is for Linux RISC-V S-mode with MMU. The
> >     clocksource is implemented using TIME CSR and clockevent device
> >     is implemented using SBI Timer calls.
> >  2. M-mode timer: This is for Linux RISC-V M-mode without MMU. The
> >     clocksource is implemented using CLINT MMIO time register and
> >     clockevent device is implemented using CLINT MMIO timecmp registers.
> >
> > This patchset removes clint related code from RISC-V timer driver and
> > arch/riscv directory. Instead, the series adds a dedicated MMIO based
> > CLINT driver under drivers/clocksource directory which can be used by
> > Linux RISC-V M-mode (i.e NoMMU Linux RISC-V).
> >
> > The patchset is based up Linux-5.8-rc6 and can be found at riscv_clint_v6
> > branch of: https://github.com/avpatel/linux.git
> >
> > This series is tested on:
> >  1. QEMU RV64 virt machine using Linux RISC-V S-mode
> >  2. QEMU RV32 virt machine using Linux RISC-V S-mode
> >  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
> >
> > Changes since v5:
> >  - Fixed order of compatible strings in PATCH4
> >  - Added "additionalProperties: false" in PATCH4
> >  - Fixed register space size for example DT node in PATCH4
> >
> > Changes since v4:
> >  - Rebased series on Linux-5.8-rc6
> >  - Updated Kconfig option as suggested by Daniel in PATCH2
> >  - Removed per-CPU registered flag in PATCH2
> >  - Addressed nit comments from Atish in PATCH2
> >
> > Changes since v3:
> >  - Updated commit description of PATCH2
> >  - Use clint_get_cycles64() in clint_rdtime() of PATCH2
> >  - Call clockevents_config_and_register() only once for each CPU in
> >    clint_timer_starting_cpu of PATCH2
> >  - Select CLINT timer driver from platform Kconfig in PATCH3
> >  - Fixed 'make dt_binding_check' for PATCH4
> >
> > Changes since v2:
> >  - Rebased series on Linux-5.8-rc5
> >  - Squashed PATCH3 onto PATCH2 to preserve GIT bisectability
> >  - Moved PATCH4 before PATCH2 to preserve GIT bisectability
> >  - Replaced CLINT dt-bindings text document with YAML schema
> >  - Use SiFive CLINT compatible string as per SiFive IP block versioning
> >
> > Changes since v1:
> >  - Rebased series on Linux-5.8-rc2
> >  - Added pr_warn() for case where ipi_ops not available in PATCH1
> >  - Updated ipi_inject() prototype to use "struct cpumask *" in PATCH1
> >  - Updated CLINT_TIMER kconfig option to depend on RISCV_M_MODE in PATCH4
> >  - Added riscv,clint0 compatible string in DT bindings document
> >
> > Anup Patel (4):
> >   RISC-V: Add mechanism to provide custom IPI operations
> >   clocksource/drivers: Add CLINT timer driver
> >   RISC-V: Remove CLINT related code from timer and arch
> >   dt-bindings: timer: Add CLINT bindings
> >
> >  .../bindings/timer/sifive,clint.yaml          |  60 +++++
> >  arch/riscv/Kconfig                            |   2 +-
> >  arch/riscv/Kconfig.socs                       |   2 +
> >  arch/riscv/configs/nommu_virt_defconfig       |   7 +-
> >  arch/riscv/include/asm/clint.h                |  39 ---
> >  arch/riscv/include/asm/smp.h                  |  19 ++
> >  arch/riscv/include/asm/timex.h                |  28 +--
> >  arch/riscv/kernel/Makefile                    |   2 +-
> >  arch/riscv/kernel/clint.c                     |  44 ----
> >  arch/riscv/kernel/sbi.c                       |  14 ++
> >  arch/riscv/kernel/setup.c                     |   2 -
> >  arch/riscv/kernel/smp.c                       |  44 ++--
> >  arch/riscv/kernel/smpboot.c                   |   4 +-
> >  drivers/clocksource/Kconfig                   |  12 +-
> >  drivers/clocksource/Makefile                  |   1 +
> >  drivers/clocksource/timer-clint.c             | 226 ++++++++++++++++++
> >  drivers/clocksource/timer-riscv.c             |  17 +-
> >  include/linux/cpuhotplug.h                    |   1 +
> >  18 files changed, 371 insertions(+), 153 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >  delete mode 100644 arch/riscv/include/asm/clint.h
> >  delete mode 100644 arch/riscv/kernel/clint.c
> >  create mode 100644 drivers/clocksource/timer-clint.c
>
> Thanks, this is way cleaner.  Patchwork is still broken but IIRC we reached
> consensus on these.  I'm not going to include these in my first 5.9 PR, as I
> want to get that out tomorrow to avoid more merge conflicts, but assuming
> there's reviews from the other maintainers I'd like to take this for my second
> 5.9 merge window PR.
>
> Assuming you've been collecting reviews and acks, do you mind posting another
> version with them?  If not I have some scripts to dig them out, so it's not a
> big deal.

Most of the Reviewed-by and Ack-by are already there, except yours and
Rob Herring's Reviewed-by. I will post v7 based on Linux-5.9-rc1

Regards,
Anup
