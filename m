Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F14C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C6B420707
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 03:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="eVgRnHVY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388437AbgE2D5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 23:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388051AbgE2D5k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 23:57:40 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57E4C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:57:39 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so1613107wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 20:57:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hTUz/DHRU5QzlOedofjSKhyi7eTdoAXNwTWC/Lv5VW0=;
        b=eVgRnHVYENb1kH9fslo7+LSj+oDvjrmTb7JfFDZMhrizogMrpyn6CZp7qhtIwI0znX
         yb0CSXeDy2IUyUvmYjvkROmdAyem5Zmr15LCJAJKd7iebKAcGWua6v2vVb8pgbOG4KHE
         r2AFmZHLhIlJWZPcO3Lh9JiR9BtdZXgVCipKZYDBiixlBAwa5U1T0wOEH0IkS/01o45s
         Li6QUoYh0qhEOfk6C2K+Mx+u4qtxQzkYqtbDrjTWyPhYLjVQQemrAReQLtlPgt0tE/Sy
         B4wov3NMpvf5CCBqkQkQF4Zt1NQtJaQYYg07EnTzQhKY0BHr8g324P+6epDLt7bG7TFa
         4nnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hTUz/DHRU5QzlOedofjSKhyi7eTdoAXNwTWC/Lv5VW0=;
        b=rUukvl+fVdjhzLcDgkH/xLdwrTQGqX7vCA1RNHNCktFLTiZvSyod7IdOz9Z2QoGJOn
         K0ZlaBai6sxK5fmr9GYuOXcs55kLcfrQ6DAUDI7OM+MEcBSwLvQabWqrmAudV11yWmBa
         fbrmu/SWZn5BP6h0WSBp7KV8Mjmuw6+k3m+CjuSWAjL5AyyPWM7X7UDGpJTqOj5cOvcG
         /uPEMivRABaPoHnQQ+IUo7u4gC3wEHLpnsqSXDe5xsT4uHd2xIiys9fvBK5QwbEMst4K
         woFbuXGXO6Z/UvnD0hSQcARQ7qH8IdVnQtZFiEUGnnpxQWHBEv90uJ/rllSMKc5Dwjw0
         DgYw==
X-Gm-Message-State: AOAM533ApwTwWUJZ8HoSdR/2mFoOueh8GoKB6DkJoxeu6kb17CCnhIJP
        zgsfHhieuKHJ/0RnOl7RELX3U1Fru3F7ZW4aOiX1JdjH+jA=
X-Google-Smtp-Source: ABdhPJyEoFD5JPpXQvMjSGeKZ0rm6eFwCWwPVyfb29G+qBk0LcMuS7b5AsH7dE+2YoIKzqwAZdNJK8dah8V1U2gjaks=
X-Received: by 2002:a1c:9ac1:: with SMTP id c184mr6263627wme.152.1590724658339;
 Thu, 28 May 2020 20:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200521133301.816665-1-anup.patel@wdc.com> <mhng-72b70f0c-28d7-425b-b45a-a132cf27e894@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-72b70f0c-28d7-425b-b45a-a132cf27e894@palmerdabbelt-glaptop1>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 29 May 2020 09:27:26 +0530
Message-ID: <CAAhSdy0zXh46P5WPZHmQ_PjwfOEWkh77EZ-_CroH1Eb1c3fDJg@mail.gmail.com>
Subject: Re: [PATCH v5 0/6] New RISC-V Local Interrupt Controller Driver
To:     Palmer Dabbelt <palmer@dabbelt.com>, Marc Zyngier <maz@kernel.org>
Cc:     Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:17 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>
> On Thu, 21 May 2020 06:32:55 PDT (-0700), Anup Patel wrote:
> > This patchset provides a new RISC-V Local Interrupt Controller Driver
> > for managing per-CPU local interrupts. The overall approach is inspired
> > from the way per-CPU local interrupts are handled by Linux ARM64 and
> > ARM GICv3 driver.
> >
> > Few advantages of this new driver over previous one are:
> > 1. All local interrupts are registered as per-CPU interrupts
> > 2. The RISC-V timer driver can register timer interrupt handler
> >    using kernel irq subsystem without relying on arch/riscv to
> >    explicitly call it's interrupt handler
> > 3. The KVM RISC-V can use this driver to implement interrupt
> >    handler for per-HART guest external interrupt defined by
> >    the RISC-V H-Extension
> > 4. In future, we can develop drivers for devices with per-HART
> >    interrupts without changing arch code or this driver (example,
> >    CLINT timer driver for RISC-V M-mode kernel)
> >
> > With this patchset, output of "cat /proc/interrupts" looks as follows:
> >            CPU0       CPU1       CPU2       CPU3
> >   2:        379          0          0          0  SiFive PLIC  10  ttyS0
> >   3:        591          0          0          0  SiFive PLIC   8  virtio0
> >   5:       5079      10821       8435      12984  RISC-V INTC   5  riscv-timer
> > IPI0:      2045       2537        891        870  Rescheduling interrupts
> > IPI1:         9        269         91        168  Function call interrupts
> > IPI2:         0          0          0          0  CPU stop interrupts
> >
> > The patchset is based up Linux-5.7-rc6 and can be found at riscv_intc_v5
> > branch of: https://github.com/avpatel/linux.git
> >
> > This series is tested on:
> >  1. QEMU RV64 virt machine using Linux RISC-V S-mode
> >  2. QEMU RV32 virt machine using Linux RISC-V S-mode
> >  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
> >
> > Changes since v4:
> >  - Rebased to Linux-5.7-rc6 and multi-PLIC improvement patches
> >  - Added separate patch to force select RISCV_INTC for CONFIG_RISCV
> >  - Fixed the driver for Linux RISC-V NoMMU
> >
> > Changes since v3:
> >  - Rebased to Linux-5.6-rc5 and Atish's PLIC patches
> >  - Added separate patch to rename and move plic_find_hart_id()
> >    to arch directory
> >  - Use riscv_of_parent_hartid() in riscv_intc_init() instead of
> >    atomic counter
> >
> > Changes since v2:
> >  - Dropped PATCH2 since it was merged long-time back
> >  - Rebased series from Linux-4.19-rc2 to Linux-5.6-rc2
> >
> > Changes since v1:
> >  - Removed changes related to puggable IPI triggering
> >  - Separate patch for self-contained IPI handling routine
> >  - Removed patch for GENERIC_IRQ kconfig options
> >  - Added patch to remove do_IRQ() function
> >  - Rebased upon Atish's SMP patches
> >
> > Anup Patel (6):
> >   RISC-V: self-contained IPI handling routine
> >   RISC-V: Rename and move plic_find_hart_id() to arch directory
> >   irqchip: RISC-V per-HART local interrupt controller driver
> >   clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
> >   RISC-V: Remove do_IRQ() function
> >   RISC-V: Force select RISCV_INTC for CONFIG_RISCV
> >
> >  arch/riscv/Kconfig                     |   2 +
> >  arch/riscv/include/asm/irq.h           |   5 -
> >  arch/riscv/include/asm/processor.h     |   1 +
> >  arch/riscv/include/asm/smp.h           |   3 +
> >  arch/riscv/kernel/cpu.c                |  16 +++
> >  arch/riscv/kernel/entry.S              |   4 +-
> >  arch/riscv/kernel/irq.c                |  33 +-----
> >  arch/riscv/kernel/smp.c                |  11 +-
> >  arch/riscv/kernel/traps.c              |   2 -
> >  drivers/clocksource/timer-riscv.c      |  30 ++++-
> >  drivers/irqchip/Kconfig                |  13 +++
> >  drivers/irqchip/Makefile               |   1 +
> >  drivers/irqchip/irq-riscv-intc.c       | 150 +++++++++++++++++++++++++
> >  drivers/irqchip/irq-sifive-plic.c      |  52 +++++----
> >  include/linux/cpuhotplug.h             |   1 +
> >  include/linux/irqchip/irq-riscv-intc.h |  20 ++++
> >  16 files changed, 280 insertions(+), 64 deletions(-)
> >  create mode 100644 drivers/irqchip/irq-riscv-intc.c
> >  create mode 100644 include/linux/irqchip/irq-riscv-intc.h
>
> So I read through this a bit, and while I haven't gone through every line of
> code I'm somewhat inclined toward taking it.
>
> During the original RISC-V port submission we went back and forth between
> having this first-level interrupt controller in arch/riscv/ vs
> drivers/irqchip/.  The original deciding factor was that the ISA mandated the
> interrupt controller, but as that's proving to be less and less the case every
> day (with the CLIC and M-mode Linux) it certainly seem sane to move all our
> interrupt controller drivers out of arch/riscv/.
>
> This is certainly a step in the right direction, and it handles some of the
> more glaring issues (iscv_timer_interrupt and lacking IRQs for the CLINT).  I
> think we should just go ahead and merge it, even though there might be some
> more refactoring to do when we eventually end up with another interrupt
> controller.
>
> I think it's best if this all goes in through a single tree, as it seems more
> work than it's worth to split it up.  I'm happy to take it through my tree if
> that's OK with the irqchip folks?

A small heads up...

Marc has queued a few PLIC improvement patches for Linux-next.
(https://patchwork.kernel.org/cover/11555051/)

This series (particularly PATCH3) is based upon above mentioned
PLIC patches.

Apart from above, I don't see any potential merge conflicts.

Regards,
Anup
