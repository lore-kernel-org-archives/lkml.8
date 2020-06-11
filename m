Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38ABC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC70B20836
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 17:54:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="XYmWm9CQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgFKRyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725824AbgFKRyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 13:54:02 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8332CC03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:54:02 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s135so2172280pgs.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8+o9YdUy1R3iGSXvhBrlmrEImQIeD4lan+/ShhbGSCU=;
        b=XYmWm9CQ1xjUBY6mMcgBCGNdhwi1oLpwDJXaiw/I9Y63S+L4+OwbnmHzI2FTk3gJdk
         OOVdZ/LjZi1tg9kUvSPcrAyIMFQ8nBsGoXiLX+v6ENyyEYdqH5+qOleChI+xeVclXSj9
         nXmz/tNy1XGvhuOXf98IioiGRyWYe+qqVyB9f4BvlqlI5nWtlMOMdT8B12YlIE5QKlIu
         fVJANzM88Q39QOLLHp18q70G9i0AxvyoAIuazqFgkuGMycKwl8qH0oNw4r1659IniAYJ
         UPJOjDfCtFHWIrTonR5wUXxjQEkbD2XNq2QzPdFD7BiWN9MRt2aSl1whU7RNSrvFX0dF
         4iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8+o9YdUy1R3iGSXvhBrlmrEImQIeD4lan+/ShhbGSCU=;
        b=DF33ECm+puJwqQL38rCPoLaLLx8FcFigXabF0R/jORBpxAxqKHhfnlJfJQqE0x+ZQd
         C/rvFeNO/OhE6bHB4XWus91S1s/ByVLY5Rf7AvU9y/Dvr8TEL4V+HW+xq9YWM9rROO57
         UhE9+kJqt5P+wyMvcEH9pW9pnkV93YH4kkyrp7H6BE9s6McmDKwTtl2xEAbAEzE4AF6R
         U+bXFybYeNRn9LVOA/p4MVREE0Z2Zp9P9Zcm9NVzcohBpUZSdnMZIdxx47Rd3Cf6tepX
         hrHhZtCtsOSGV62ibyw90VM5DnvxooNc+9PEgSdLn56x9TfTSmSUndBKFf8ioz020ZhD
         ymbg==
X-Gm-Message-State: AOAM5308E0LogrgnEASc5z5bl9tV2KUe05k6FpJJxJICIC0yPMKDRXDZ
        hv4J87/S+HQJ5lfVbH4PamY0MA==
X-Google-Smtp-Source: ABdhPJyp4yQTpDezyVJ9iCZdYTisudhAEoGsZdHysnNs+sDyltgcq02GQmvi7JwQ5WX3APidRZZjpA==
X-Received: by 2002:a63:e707:: with SMTP id b7mr1741074pgi.35.1591898041804;
        Thu, 11 Jun 2020 10:54:01 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id m10sm3234324pjs.27.2020.06.11.10.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:54:00 -0700 (PDT)
Date:   Thu, 11 Jun 2020 10:54:00 -0700 (PDT)
X-Google-Original-Date: Thu, 11 Jun 2020 10:49:50 PDT (-0700)
Subject:     Re: [PATCH v8 0/6] New RISC-V Local Interrupt Controller Driver
In-Reply-To: <20200611061350.434293-1-anup.patel@wdc.com>
CC:     Paul Walmsley <paul.walmsley@sifive.com>, aou@eecs.berkeley.edu,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        jason@lakedaemon.net, Marc Zyngier <maz@kernel.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        anup@brainfault.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Anup Patel <Anup.Patel@wdc.com>
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Anup Patel <Anup.Patel@wdc.com>
Message-ID: <mhng-dd6e3d07-ef2d-4338-863a-84e83dc9be7e@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jun 2020 23:13:44 PDT (-0700), Anup Patel wrote:
> This patchset provides a new RISC-V Local Interrupt Controller Driver
> for managing per-CPU local interrupts. The overall approach is inspired
> from the way per-CPU local interrupts are handled by Linux ARM64 and
> ARM GICv3 driver.
>
> It is a major re-write over perviously submitted version.
> (Refer, https://www.spinics.net/lists/devicetree/msg241230.html)
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
> The patchset is based upon Linux-5.7 and can be found at riscv_intc_v7
> branch of: https://github.com/avpatel/linux.git
>
> This series is tested on:
>  1. QEMU RV64 virt machine using Linux RISC-V S-mode
>  2. QEMU RV32 virt machine using Linux RISC-V S-mode
>  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
>
> Changes since v7:
>  - Rebased on Linux-5.7 release
>  - Minor typo-fix in pr_warn() of PATCH3

My PR was tagged before v8 was sent out, and while I haven't sent it yet (I
like to give the autobuilders at least a day to chew on it) I don't want to
re-spin everything this late in the merge window for a spelling issue in a
warning message.  I'll split the fix out as its own patch.

Thanks for fixing it, though!

> Changes since v6:
>  - Rebased patches on Linux-5.7 and tested with runtime CPU hotplug
>  - Minor changes in PATCH3 as suggested by Marc Z
>  - Don't programm PLIC threshold for CPU_OFF in PATCH3
>  - Simplified finding IRQ domain in riscv_timer_init_dt() of PATCH4
>
> Changes since v5:
>  - Rebased to Linux-5.7-rc7 with PLIC improvement patches
>  - Removed riscv_of_parent_hartid() from PATCH3
>  - Addressed other minor comments from Palmer and Marc Z
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
>  arch/riscv/Kconfig                 |   2 +
>  arch/riscv/include/asm/irq.h       |   5 --
>  arch/riscv/include/asm/processor.h |   1 +
>  arch/riscv/include/asm/smp.h       |   3 +
>  arch/riscv/kernel/cpu.c            |  16 ++++
>  arch/riscv/kernel/entry.S          |   4 +-
>  arch/riscv/kernel/irq.c            |  33 +------
>  arch/riscv/kernel/smp.c            |  11 ++-
>  arch/riscv/kernel/traps.c          |   2 -
>  drivers/clocksource/timer-riscv.c  |  43 ++++++++-
>  drivers/irqchip/Kconfig            |  13 +++
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-riscv-intc.c   | 138 +++++++++++++++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c  |  44 ++++-----
>  include/linux/cpuhotplug.h         |   1 +
>  15 files changed, 252 insertions(+), 65 deletions(-)
>  create mode 100644 drivers/irqchip/irq-riscv-intc.c
