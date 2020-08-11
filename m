Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3EB4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:15:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B931C20782
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 13:15:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kdz19HIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgHKNPh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHKNPf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 09:15:35 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F38C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 06:15:34 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z14so13490854ljm.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 06:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QKT+MPk8nFCEoDDUTvxdWrFmnt1CyY647bES22XSrcw=;
        b=kdz19HIRXlUa0BK7zpGN7NTwqgIlU1uHtcuJFsysPX2mh0J9E9dQ1lkVp8bVmNYqZc
         txTay2UEuv4/DHBqhC5JbpUNFYGa0LYmPIj2GtM5vRFk4roSLZk0vBHtgJ/qOCgiMMJs
         jbnhhRAwnaXmdMN7Mpj6UYPuTEyq2AwnbApeVLmJI/nu+ej5NbokjShJhcPhi8aTks9t
         fMJy/+x3ov4oJ2D39Ufluib/SnoGkdphedAxECJIeMBVG3zL760gAGUsBfWCuMtRGczI
         JczrxMKdh04XRy/9/6/L0RuEOV1kJFhHf4bPBysZ/GTxqYAb65Hn/oiAhpAVtBeoHcks
         kOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QKT+MPk8nFCEoDDUTvxdWrFmnt1CyY647bES22XSrcw=;
        b=jHWzh2xHgwLfvPdmxyb4ob6kAIoA1CsCtRcl9laU9UrsiWdT0ePxxCEhF7fefmt2Te
         jo7bTXhGKE+Hn/MdMZdFGrHouJIzvKIQGyP8Fs2JwTp3rNNOnw6A4Qjev3L3OrEkcTkZ
         /WNRLzzP1sFOR4qhtnx+OCSqIIht5BL+PeSV30SwXeO+Phg+Z9SK8YAPUqA7feS/rL8M
         xKXQyBShxpNAcJQ6FIcMFL/PTsbRCfJxU0RWtCSJC3OC7SmM9rcQwMotE8hBfjajI1DK
         WSqBFvGRvJYaSqoyb0cqtr22R3YhtifM4G5rwm5avdPRBHLLrUsXpDUL0vqPum7GZLPQ
         BvhQ==
X-Gm-Message-State: AOAM532AHD68clFErNHboUpg7e49b4qBVDAEyw7DdKIpXhFn2EXjcMU+
        sFYn6XyNqtHEdsL4CHRjV50Du5XeDF4SNRG8qEXccg==
X-Google-Smtp-Source: ABdhPJyEwrrFR9W48X5X0ERH3UqScUW7Agki9mEwWOJuwFGn0OApDTdvbDqNGEC27SpEIcjuCyAeOiFoTQWp+2Skbq0=
X-Received: by 2002:a2e:9550:: with SMTP id t16mr2866244ljh.372.1597151732669;
 Tue, 11 Aug 2020 06:15:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200624195811.435857-1-maz@kernel.org>
In-Reply-To: <20200624195811.435857-1-maz@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 11 Aug 2020 18:45:21 +0530
Message-ID: <CAFA6WYNw7TgypuEdOVRQ4QzAe6BbOg8V0_6O-Xb1=8xybse=nQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/17] arm/arm64: Turning IPIs into normal interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On Thu, 25 Jun 2020 at 01:28, Marc Zyngier <maz@kernel.org> wrote:
>
> For as long as SMP ARM has existed, IPIs have been handled as
> something special. The arch code and the interrupt controller exchange
> a couple of hooks (one to generate an IPI, another to handle it).
>
> Although this is perfectly manageable, it prevents the use of features
> that we could use if IPIs were Linux IRQs (such as pseudo-NMIs). It
> also means that each interrupt controller driver has to follow an
> architecture-specific interface instead of just implementing the base
> irqchip functionalities. The arch code also duplicates a number of
> things that the core irq code already does (such as calling
> set_irq_regs(), irq_enter()...).
>
> This series tries to remedy this on arm/arm64 by offering a new
> registration interface where the irqchip gives the arch code a range
> of interrupts to use for IPIs. The arch code requests these as normal
> per-cpu interrupts.
>
> The bulk of the work is at the interrupt controller level, where all 5
> irqchips used on arm+SMP/arm64 get converted.
>
> Finally, we drop the legacy registration interface as well as the
> custom statistics accounting.
>
> Note that I have had a look at providing a "generic" interface by
> expanding the kernel/irq/ipi.c bag of helpers, but so far all
> irqchips have very different requirements, so there is hardly anything
> to consolidate for now. Maybe some as hip04 and the Marvell horror get
> cleaned up (the latter certainly could do with a good dusting).
>
> This has been tested on a bunch of 32 and 64bit guests (GICv2, GICv3),
> as well as 64bit bare metal (GICv3). The RPi part has only been tested
> in QEMU as a 64bit guest, while the HiSi and Marvell parts have only
> been compile-tested.

This series works perfectly fine on Developerbox.

I just want to follow-up regarding when you are planning to push this
series upstream? Are you waiting for other irqchips (apart from GIC)
to be reviewed?

Actually mine work to turn IPI as a pseudo NMI [1] is dependent on
this patch-set.

[1] https://lkml.org/lkml/2020/5/20/488

-Sumit

>
> * From v1:
>   - Clarified the effect of nesting irq_enter/exit (Russell)
>   - Changed the point where we tear IPIs down on (Valentin)
>   - IPIs are no longer accessible from DT
>   - HIP04 and Armada 370-XP have been converted, but are untested
>   - arch-specific kstat accounting is removed
>   - ARM's legacy interface is dropped
>
> Marc Zyngier (17):
>   genirq: Add fasteoi IPI flow
>   genirq: Allow interrupts to be excluded from /proc/interrupts
>   arm64: Allow IPIs to be handled as normal interrupts
>   ARM: Allow IPIs to be handled as normal interrupts
>   irqchip/gic-v3: Describe the SGI range
>   irqchip/gic-v3: Configure SGIs as standard interrupts
>   irqchip/gic: Atomically update affinity
>   irqchip/gic: Refactor SMP configuration
>   irqchip/gic: Configure SGIs as standard interrupts
>   irqchip/gic-common: Don't enable SGIs by default
>   irqchip/bcm2836: Configure mailbox interrupts as standard interrupts
>   irqchip/hip04: Configure IPIs as standard interrupts
>   irqchip/armada-370-xp: Configure IPIs as standard interrupts
>   arm64: Kill __smp_cross_call and co
>   arm64: Remove custom IRQ stat accounting
>   ARM: Kill __smp_cross_call and co
>   ARM: Remove custom IRQ stat accounting
>
>  arch/arm/Kconfig                    |   1 +
>  arch/arm/include/asm/hardirq.h      |  17 --
>  arch/arm/include/asm/smp.h          |   5 +-
>  arch/arm/kernel/smp.c               | 135 +++++++++-----
>  arch/arm64/Kconfig                  |   1 +
>  arch/arm64/include/asm/hardirq.h    |   9 -
>  arch/arm64/include/asm/irq_work.h   |   4 +-
>  arch/arm64/include/asm/smp.h        |   6 +-
>  arch/arm64/kernel/smp.c             | 119 ++++++++-----
>  drivers/irqchip/irq-armada-370-xp.c | 262 +++++++++++++++++++---------
>  drivers/irqchip/irq-bcm2836.c       | 151 +++++++++++++---
>  drivers/irqchip/irq-gic-common.c    |   3 -
>  drivers/irqchip/irq-gic-v3.c        |  99 ++++++-----
>  drivers/irqchip/irq-gic.c           | 183 ++++++++++---------
>  drivers/irqchip/irq-hip04.c         |  89 +++++-----
>  include/linux/irq.h                 |   5 +-
>  kernel/irq/chip.c                   |  27 +++
>  kernel/irq/debugfs.c                |   1 +
>  kernel/irq/proc.c                   |   2 +-
>  kernel/irq/settings.h               |   7 +
>  20 files changed, 713 insertions(+), 413 deletions(-)
>
> --
> 2.27.0
>
