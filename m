Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33F88C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10C1F2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 18:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="BD08Vr27"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387409AbgE0Swx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 14:52:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbgE0Swg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 14:52:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA497C008639
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:47:10 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id q8so12274897pfu.5
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=xlHCAxvXvnuDbx0LkafhQpSZagEzXc+hc5LOPcq5Huw=;
        b=BD08Vr27SDUI759X2/UqI1hW2/32hH0/i8frIg+EhBZ/AevuWNbGas3DT56FFR6Flz
         2W0hGsXHAq7NDZWE9C5YDABXpA2HBtcO7W+BEB3fV51ryWTU4J976+wC4/A0iXB6HPo6
         CKbDaFDF4Nkzc6j1uGIfnj8HNKXwjkl9eBdWnwY87w9w+HKjbu5JiQPEcVIea9xqc2B7
         as3YqS/wuTL+IiCnoYcoimaAhuckWqh9eOJAHsAZN5c6OeePPU8qvt+wSN8o65JsRada
         BqeRDUYhOuoODA+IdrzkmfSz3wgzh+vK51WHKs8F8gLWvuNThFdJexkr+mWABOJjhqdI
         G3jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=xlHCAxvXvnuDbx0LkafhQpSZagEzXc+hc5LOPcq5Huw=;
        b=bDoqqTGhPVJYHa6jXCdZtwNDZYrtQKSJBR7zqEfLGumhIeUsyXbkgcLCJYeDSOJFG1
         jEvDCkIhQbhIvrvvXvIgTkZwOjOD14p+RB1TV6VIZZc2floqHXhxZwqi+Hg4mhouM2KM
         vTG6VyLvF7iF7g+IaKsbo3Bs5X3xLaki7t/fTv5JuR+PdW5fLIsAxVFCL04h0IQFdEph
         NPBJ0YPCsTgEI7yAsFZsvYZiODFZa64VYOXJyejt5vvF/P5LIAH0YYsOzWEWYlo6p70S
         tWAfcbaS4XNQ9gnEqArjlA9lWobcwj7otMh5We0dhcEr8QI5PI9Y/jEOH3Y71HLFhVSH
         ZA2g==
X-Gm-Message-State: AOAM530O9UaTPTsWZxdQW7Qsgqb2HcOxr/CqNNT3YcrVaNlh1VAMX7V9
        Rd16zBZrEkzzncoqomoOdnwuiQ==
X-Google-Smtp-Source: ABdhPJzj7M85gwVANBohrhiJQMHP/qpccC0sSzvYrm6/sSpUBXen3o0geu4j+W4sR1NwhKqWavykzA==
X-Received: by 2002:a05:6a00:a:: with SMTP id h10mr5467299pfk.310.1590605229930;
        Wed, 27 May 2020 11:47:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id i8sm2578841pgr.82.2020.05.27.11.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 11:47:08 -0700 (PDT)
Date:   Wed, 27 May 2020 11:47:08 -0700 (PDT)
X-Google-Original-Date: Wed, 27 May 2020 11:47:01 PDT (-0700)
Subject:     Re: [PATCH v5 0/6] New RISC-V Local Interrupt Controller Driver
In-Reply-To: <20200521133301.816665-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>, Marc Zyngier <maz@kernel.org>
Message-ID: <mhng-72b70f0c-28d7-425b-b45a-a132cf27e894@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 May 2020 06:32:55 PDT (-0700), Anup Patel wrote:
> This patchset provides a new RISC-V Local Interrupt Controller Driver
> for managing per-CPU local interrupts. The overall approach is inspired
> from the way per-CPU local interrupts are handled by Linux ARM64 and
> ARM GICv3 driver.
>
> Few advantages of this new driver over previous one are:
> 1. All local interrupts are registered as per-CPU interrupts
> 2. The RISC-V timer driver can register timer interrupt handler
>    using kernel irq subsystem without relying on arch/riscv to
>    explicitly call it's interrupt handler
> 3. The KVM RISC-V can use this driver to implement interrupt
>    handler for per-HART guest external interrupt defined by
>    the RISC-V H-Extension
> 4. In future, we can develop drivers for devices with per-HART
>    interrupts without changing arch code or this driver (example,
>    CLINT timer driver for RISC-V M-mode kernel)
>
> With this patchset, output of "cat /proc/interrupts" looks as follows:
>            CPU0       CPU1       CPU2       CPU3
>   2:        379          0          0          0  SiFive PLIC  10  ttyS0
>   3:        591          0          0          0  SiFive PLIC   8  virtio0
>   5:       5079      10821       8435      12984  RISC-V INTC   5  riscv-timer
> IPI0:      2045       2537        891        870  Rescheduling interrupts
> IPI1:         9        269         91        168  Function call interrupts
> IPI2:         0          0          0          0  CPU stop interrupts
>
> The patchset is based up Linux-5.7-rc6 and can be found at riscv_intc_v5
> branch of: https://github.com/avpatel/linux.git
>
> This series is tested on:
>  1. QEMU RV64 virt machine using Linux RISC-V S-mode
>  2. QEMU RV32 virt machine using Linux RISC-V S-mode
>  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
>
> Changes since v4:
>  - Rebased to Linux-5.7-rc6 and multi-PLIC improvement patches
>  - Added separate patch to force select RISCV_INTC for CONFIG_RISCV
>  - Fixed the driver for Linux RISC-V NoMMU
>
> Changes since v3:
>  - Rebased to Linux-5.6-rc5 and Atish's PLIC patches
>  - Added separate patch to rename and move plic_find_hart_id()
>    to arch directory
>  - Use riscv_of_parent_hartid() in riscv_intc_init() instead of
>    atomic counter
>
> Changes since v2:
>  - Dropped PATCH2 since it was merged long-time back
>  - Rebased series from Linux-4.19-rc2 to Linux-5.6-rc2
>
> Changes since v1:
>  - Removed changes related to puggable IPI triggering
>  - Separate patch for self-contained IPI handling routine
>  - Removed patch for GENERIC_IRQ kconfig options
>  - Added patch to remove do_IRQ() function
>  - Rebased upon Atish's SMP patches
>
> Anup Patel (6):
>   RISC-V: self-contained IPI handling routine
>   RISC-V: Rename and move plic_find_hart_id() to arch directory
>   irqchip: RISC-V per-HART local interrupt controller driver
>   clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
>   RISC-V: Remove do_IRQ() function
>   RISC-V: Force select RISCV_INTC for CONFIG_RISCV
>
>  arch/riscv/Kconfig                     |   2 +
>  arch/riscv/include/asm/irq.h           |   5 -
>  arch/riscv/include/asm/processor.h     |   1 +
>  arch/riscv/include/asm/smp.h           |   3 +
>  arch/riscv/kernel/cpu.c                |  16 +++
>  arch/riscv/kernel/entry.S              |   4 +-
>  arch/riscv/kernel/irq.c                |  33 +-----
>  arch/riscv/kernel/smp.c                |  11 +-
>  arch/riscv/kernel/traps.c              |   2 -
>  drivers/clocksource/timer-riscv.c      |  30 ++++-
>  drivers/irqchip/Kconfig                |  13 +++
>  drivers/irqchip/Makefile               |   1 +
>  drivers/irqchip/irq-riscv-intc.c       | 150 +++++++++++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c      |  52 +++++----
>  include/linux/cpuhotplug.h             |   1 +
>  include/linux/irqchip/irq-riscv-intc.h |  20 ++++
>  16 files changed, 280 insertions(+), 64 deletions(-)
>  create mode 100644 drivers/irqchip/irq-riscv-intc.c
>  create mode 100644 include/linux/irqchip/irq-riscv-intc.h

So I read through this a bit, and while I haven't gone through every line of
code I'm somewhat inclined toward taking it.

During the original RISC-V port submission we went back and forth between
having this first-level interrupt controller in arch/riscv/ vs
drivers/irqchip/.  The original deciding factor was that the ISA mandated the
interrupt controller, but as that's proving to be less and less the case every
day (with the CLIC and M-mode Linux) it certainly seem sane to move all our
interrupt controller drivers out of arch/riscv/.

This is certainly a step in the right direction, and it handles some of the
more glaring issues (iscv_timer_interrupt and lacking IRQs for the CLINT).  I
think we should just go ahead and merge it, even though there might be some
more refactoring to do when we eventually end up with another interrupt
controller.

I think it's best if this all goes in through a single tree, as it seems more
work than it's worth to split it up.  I'm happy to take it through my tree if
that's OK with the irqchip folks?
