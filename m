Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38D39C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 052D720873
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="vEiimkKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgCIL5d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:57:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45314 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCIL5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:57:33 -0400
Received: by mail-wr1-f65.google.com with SMTP id m9so1708230wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vrTgttkZVf+7dJzhX83Z2t1NpSWLXcGu9YGJAFx5Xqc=;
        b=vEiimkKWq0NHiQqLCBl/zNnWis5BV9Ta7t765xUFvMq/OTzlWKuMsmpB7rJQK5tVnP
         XxmPE2weoncXR1//WGh4VqsygjvoJbzPtR4XDqnux9UP+SowXvyjwB6QBm/jeWuEvRY1
         Ds6ZBqwfv/OZgSZeth6F2I9MsS1sf2gxDE1t1WkBdGxwEnhdattHNj+u8Rk8dTD8OFZN
         JR/EyECJ8xUszKKLMT/VDreswvC476fn+ORNfS2Drj7KvJuZJv7jUaaLZtwgtyHclf5N
         ZPH9j2EMxWPlEgCco/6AIDGoDdbNu3LMao3nN1OAUORt8GDZyR78AvuIFvIfIkaC8Pdv
         Bbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vrTgttkZVf+7dJzhX83Z2t1NpSWLXcGu9YGJAFx5Xqc=;
        b=SkJciiiTBNSiZIoElIjPN+L0iWE5/e6N581STg5zb0bPLOJF+b9hza71hB9SMYAoOc
         xzSO2SDSgkiitgR0WUJHAbHjW1D7jQu9yehMrbEabHA+wlnT7CehPyKIZCGMmK/zpbYc
         AflbqOBgkVo2lXYPKqgkeG8p49FrfaS+I2wYOfYkSqANfEZRz19djQOktOFQ+19wOimm
         HJyoD0mN+ypOsXHYf3n1QowXVCpIH27jYkZvR7IraL1KOiVaBA24URP/L6RfNA6cnLrv
         V9V5C5TZKp6jHgogc6WdC6dZBlrMjbHPNwyIWzmBjQPZvl3ex7xzhjqr7DGI9q1Pl2Rp
         O/WQ==
X-Gm-Message-State: ANhLgQ2PGExza/IuQCy4zYGugXI6bgzy5+4DbQy/Ui53l1C+5L/f0spo
        iCYGHeC0FURwKoSmTavekAsg0lesQANX3LYJDUgY3A==
X-Google-Smtp-Source: ADFU+vvMew+BCMC+wgpvAFNXyqhdGpFhtepZ8kbje7sd7mHHkOXIz3YohMYApyzE+QBfXAmwpEf0KlzE67eJaauIl0k=
X-Received: by 2002:adf:a512:: with SMTP id i18mr20926329wrb.61.1583755051402;
 Mon, 09 Mar 2020 04:57:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200309110211.91130-1-anup.patel@wdc.com>
In-Reply-To: <20200309110211.91130-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Mon, 9 Mar 2020 17:27:17 +0530
Message-ID: <CAAhSdy0fJHAhmW202DT+2XfY5bADBUqoiyk9bY86dupuO9zhzA@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] New RISC-V Local Interrupt Controller Driver
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed Marc's email address.

On Mon, Mar 9, 2020 at 4:32 PM Anup Patel <anup.patel@wdc.com> wrote:
>
> This patchset provides a new RISC-V Local Interrupt Controller Driver
> for managing per-CPU local interrupts. The overall approach is inspired
> from the way per-CPU local interrupts are handled by Linux ARM64 and
> ARM GICv3 driver.
>
> Few advantages of this new driver over previous one are:
> 1. It registers all local interrupts as per-CPU interrupts
> 2. The KVM RISC-V can use this driver to implement interrupt
>    handler for per-HART guest external interrupt defined by
>    the RISC-V H-Extension
> 3. In future, we can develop drivers for devices with per-HART
>    interrupts without changing arch code or this driver
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
> The patchset is based up Linux-5.6-rc5 and can be found at riscv_intc_v4
> branch of: https://github.com/avpatel/linux.git
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
> Anup Patel (5):
>   RISC-V: self-contained IPI handling routine
>   RISC-V: Rename and move plic_find_hart_id() to arch directory
>   irqchip: RISC-V Per-HART Local Interrupt Controller Driver
>   clocksource: timer-riscv: Make timer interrupt as a per-CPU interrupt
>   RISC-V: Remove do_IRQ() function
>
>  arch/riscv/Kconfig                 |   1 +
>  arch/riscv/include/asm/irq.h       |   5 --
>  arch/riscv/include/asm/processor.h |   1 +
>  arch/riscv/include/asm/smp.h       |   3 +
>  arch/riscv/kernel/cpu.c            |  16 ++++
>  arch/riscv/kernel/entry.S          |   4 +-
>  arch/riscv/kernel/irq.c            |  33 +------
>  arch/riscv/kernel/smp.c            |  11 ++-
>  arch/riscv/kernel/traps.c          |   2 -
>  drivers/clocksource/timer-riscv.c  |  79 +++++++++++------
>  drivers/irqchip/Kconfig            |  13 +++
>  drivers/irqchip/Makefile           |   1 +
>  drivers/irqchip/irq-riscv-intc.c   | 134 +++++++++++++++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c  |  40 ++++-----
>  include/linux/cpuhotplug.h         |   1 +
>  15 files changed, 256 insertions(+), 88 deletions(-)
>  create mode 100644 drivers/irqchip/irq-riscv-intc.c
>
> --
> 2.17.1
>
