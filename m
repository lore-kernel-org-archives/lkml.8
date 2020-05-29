Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C1C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703072078C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 04:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="kSV77T3N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbgE2ENb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 00:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgE2EN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 00:13:29 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 372CDC08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:13:29 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a45so1309916pje.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 21:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=8zvB/PWAc03/bXy1kS3cVXZDBJ6t9o/VOp1x3C8nEAM=;
        b=kSV77T3NXq16MQtfa4cFHHytD4QGyxt1vZA31i8c3Bv1LkvDS71htb2ZSvCgi1EElX
         nyAJiQm8K8PKMfhiHiKG9c6m7d7saRI6YXQN5Z4V5pmUlhee0VQA486CEin6d7o00hQM
         6+OE/cRhPm1BAMcPB/9Zd8YOcmh+TzQFxfq3M3PZlmlSiUNafDfGYxE1O9uetskl2J2o
         dcjb7bC798Bx8eEzT3c7CyTF0792g2Jgw+tS6/AwjVXnuqvMdbDOwHCAMRofU8ZYw/mX
         Ht9n89AbS852fp6Hm4zwmwmwQjvpidVz/C/GomqfJmUwLMsufHxfMfvWrkaDOBekrAXN
         bSAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=8zvB/PWAc03/bXy1kS3cVXZDBJ6t9o/VOp1x3C8nEAM=;
        b=npA9QGNZCKsvMCEn3778Pj9YXq6m2VGJmaCrLL9i5i0zcHNUwRhjaOZD6N2aH6u2Iz
         RyKCXP28bv+Dovp44E5J//IvjrwBq8rCfKSf/Nd7NoS6aqV0kQt9xY5JCoz4Y8MIwDO8
         FJGsOxGp/Te8s1tEsXwJRVwVchz4WYL5TG+xGO5NGFdRlqt8jCiPtPQicMS4+W01sPRu
         qdhUVAghtX8pJCaSodERQnbMx8+n27diRSl5p5GILeQILbwsKz4z2o2l2Pbs7/OaQzqu
         i7pkQZAIqadXE3wBzVQDUzPodo23ujocLr2CqgBRPAe1CGPgM+LIZZMM55mFLkylKQXZ
         wC0Q==
X-Gm-Message-State: AOAM532dtvVMQpid39gA46uhjp4rJA2Y2QjmjfL0MNM2GSW4sDfoPC0y
        9uQ80SVoJU8tD8zTMdrWZxyISg==
X-Google-Smtp-Source: ABdhPJx63TYCmfV45ENv6rkFK3AOMfUO0iJ3vD4RLOgwxG6k61GLZINXBWYJBBpsoMr0tkb95GHDWA==
X-Received: by 2002:a17:902:d90c:: with SMTP id c12mr6810664plz.113.1590725608366;
        Thu, 28 May 2020 21:13:28 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id c2sm7304799pjg.51.2020.05.28.21.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 21:13:27 -0700 (PDT)
Date:   Thu, 28 May 2020 21:13:27 -0700 (PDT)
X-Google-Original-Date: Thu, 28 May 2020 21:13:24 PDT (-0700)
Subject:     Re: [PATCH v5 0/6] New RISC-V Local Interrupt Controller Driver
In-Reply-To: <CAAhSdy0zXh46P5WPZHmQ_PjwfOEWkh77EZ-_CroH1Eb1c3fDJg@mail.gmail.com>
CC:     Marc Zyngier <maz@kernel.org>, Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, daniel.lezcano@linaro.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     anup@brainfault.org
Message-ID: <mhng-69ba2cf1-862f-49fc-ab79-eda329f69aee@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 May 2020 20:57:26 PDT (-0700), anup@brainfault.org wrote:
> On Thu, May 28, 2020 at 12:17 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>>
>> On Thu, 21 May 2020 06:32:55 PDT (-0700), Anup Patel wrote:
>> > This patchset provides a new RISC-V Local Interrupt Controller Driver
>> > for managing per-CPU local interrupts. The overall approach is inspired
>> > from the way per-CPU local interrupts are handled by Linux ARM64 and
>> > ARM GICv3 driver.
>> >
>> > Few advantages of this new driver over previous one are:
>> > 1. All local interrupts are registered as per-CPU interrupts
>> > 2. The RISC-V timer driver can register timer interrupt handler
>> >    using kernel irq subsystem without relying on arch/riscv to
>> >    explicitly call it's interrupt handler
>> > 3. The KVM RISC-V can use this driver to implement interrupt
>> >    handler for per-HART guest external interrupt defined by
>> >    the RISC-V H-Extension
>> > 4. In future, we can develop drivers for devices with per-HART
>> >    interrupts without changing arch code or this driver (example,
>> >    CLINT timer driver for RISC-V M-mode kernel)
>> >
>> > With this patchset, output of "cat /proc/interrupts" looks as follows:
>> >            CPU0       CPU1       CPU2       CPU3
>> >   2:        379          0          0          0  SiFive PLIC  10  ttyS0
>> >   3:        591          0          0          0  SiFive PLIC   8  virtio0
>> >   5:       5079      10821       8435      12984  RISC-V INTC   5  riscv-timer
>> > IPI0:      2045       2537        891        870  Rescheduling interrupts
>> > IPI1:         9        269         91        168  Function call interrupts
>> > IPI2:         0          0          0          0  CPU stop interrupts
>> >
>> > The patchset is based up Linux-5.7-rc6 and can be found at riscv_intc_v5
>> > branch of: https://github.com/avpatel/linux.git
>> >
>> > This series is tested on:
>> >  1. QEMU RV64 virt machine using Linux RISC-V S-mode
>> >  2. QEMU RV32 virt machine using Linux RISC-V S-mode
>> >  3. QEMU RV64 virt machine using Linux RISC-V M-mode (i.e. NoMMU)
>> >
>> > Changes since v4:
>> >  - Rebased to Linux-5.7-rc6 and multi-PLIC improvement patches
>> >  - Added separate patch to force select RISCV_INTC for CONFIG_RISCV
>> >  - Fixed the driver for Linux RISC-V NoMMU
>> >
>> > Changes since v3:
>> >  - Rebased to Linux-5.6-rc5 and Atish's PLIC patches
>> >  - Added separate patch to rename and move plic_find_hart_id()
>> >    to arch directory
>> >  - Use riscv_of_parent_hartid() in riscv_intc_init() instead of
>> >    atomic counter
>> >
>> > Changes since v2:
>> >  - Dropped PATCH2 since it was merged long-time back
>> >  - Rebased series from Linux-4.19-rc2 to Linux-5.6-rc2
>> >
>> > Changes since v1:
>> >  - Removed changes related to puggable IPI triggering
>> >  - Separate patch for self-contained IPI handling routine
>> >  - Removed patch for GENERIC_IRQ kconfig options
>> >  - Added patch to remove do_IRQ() function
>> >  - Rebased upon Atish's SMP patches
>> >
>> > Anup Patel (6):
>> >   RISC-V: self-contained IPI handling routine
>> >   RISC-V: Rename and move plic_find_hart_id() to arch directory
>> >   irqchip: RISC-V per-HART local interrupt controller driver
>> >   clocksource/drivers/timer-riscv: Use per-CPU timer interrupt
>> >   RISC-V: Remove do_IRQ() function
>> >   RISC-V: Force select RISCV_INTC for CONFIG_RISCV
>> >
>> >  arch/riscv/Kconfig                     |   2 +
>> >  arch/riscv/include/asm/irq.h           |   5 -
>> >  arch/riscv/include/asm/processor.h     |   1 +
>> >  arch/riscv/include/asm/smp.h           |   3 +
>> >  arch/riscv/kernel/cpu.c                |  16 +++
>> >  arch/riscv/kernel/entry.S              |   4 +-
>> >  arch/riscv/kernel/irq.c                |  33 +-----
>> >  arch/riscv/kernel/smp.c                |  11 +-
>> >  arch/riscv/kernel/traps.c              |   2 -
>> >  drivers/clocksource/timer-riscv.c      |  30 ++++-
>> >  drivers/irqchip/Kconfig                |  13 +++
>> >  drivers/irqchip/Makefile               |   1 +
>> >  drivers/irqchip/irq-riscv-intc.c       | 150 +++++++++++++++++++++++++
>> >  drivers/irqchip/irq-sifive-plic.c      |  52 +++++----
>> >  include/linux/cpuhotplug.h             |   1 +
>> >  include/linux/irqchip/irq-riscv-intc.h |  20 ++++
>> >  16 files changed, 280 insertions(+), 64 deletions(-)
>> >  create mode 100644 drivers/irqchip/irq-riscv-intc.c
>> >  create mode 100644 include/linux/irqchip/irq-riscv-intc.h
>>
>> So I read through this a bit, and while I haven't gone through every line of
>> code I'm somewhat inclined toward taking it.
>>
>> During the original RISC-V port submission we went back and forth between
>> having this first-level interrupt controller in arch/riscv/ vs
>> drivers/irqchip/.  The original deciding factor was that the ISA mandated the
>> interrupt controller, but as that's proving to be less and less the case every
>> day (with the CLIC and M-mode Linux) it certainly seem sane to move all our
>> interrupt controller drivers out of arch/riscv/.
>>
>> This is certainly a step in the right direction, and it handles some of the
>> more glaring issues (iscv_timer_interrupt and lacking IRQs for the CLINT).  I
>> think we should just go ahead and merge it, even though there might be some
>> more refactoring to do when we eventually end up with another interrupt
>> controller.
>>
>> I think it's best if this all goes in through a single tree, as it seems more
>> work than it's worth to split it up.  I'm happy to take it through my tree if
>> that's OK with the irqchip folks?
>
> A small heads up...
>
> Marc has queued a few PLIC improvement patches for Linux-next.
> (https://patchwork.kernel.org/cover/11555051/)
>
> This series (particularly PATCH3) is based upon above mentioned
> PLIC patches.
>
> Apart from above, I don't see any potential merge conflicts.

Thanks.  I hit some merge issues when pulling it into a staging branch, but
nothing seemed interesting.  I think the best bet here is to just pull it in
through the RISC-V tree.

Aside from this, I'm ready to send out my first 5.8 PR.  I'm going to put this
on a staging branch and send it up as a second 5.8 merge window PR once
everything else settles.  IIRC our other irqchip changes have been around for a
while, so they should be going up early in the merge window.

LMK if anyone has issues with that.

>
> Regards,
> Anup
