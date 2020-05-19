Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D059AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A271F207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728175AbgESWZX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:25:23 -0400
Received: from foss.arm.com ([217.140.110.172]:42354 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgESWZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:25:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A823330E;
        Tue, 19 May 2020 15:25:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575523F52E;
        Tue, 19 May 2020 15:25:21 -0700 (PDT)
References: <20200519161755.209565-1-maz@kernel.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>, kernel-team@android.com
Subject: Re: [PATCH 00/11] arm/arm64: Turning IPIs into normal interrupts
In-reply-to: <20200519161755.209565-1-maz@kernel.org>
Date:   Tue, 19 May 2020 23:25:14 +0100
Message-ID: <jhja723r29h.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Marc,

On 19/05/20 17:17, Marc Zyngier wrote:
>
> This has been tested on a bunch of 32 and 64bit guests.
>

I gave this a brief spin on Juno and on HiKey960, nothing to report there.

FWIW I'd like to stare a bit at the rest; I already have a rookie question
on the accounting, but the rest will be for after I get some sleep, and
maybe even a mug of coffee :-)

> Marc Zyngier (11):
>   genirq: Add fasteoi IPI flow
>   genirq: Allow interrupts to be excluded from /proc/interrupts
>   arm64: Allow IPIs to be handled as normal interrupts
>   ARM: Allow IPIs to be handled as normal interrupts
>   irqchip/gic-v3: Describe the SGI range
>   irqchip/gic-v3: Configure SGIs as standard interrupts
>   irqchip/gic: Refactor SMP configuration
>   irqchip/gic: Configure SGIs as standard interrupts
>   irqchip/gic-common: Don't enable SGIs by default
>   irqchip/bcm2836: Configure mailbox interrupts as standard interrupts
>   arm64: Kill __smp_cross_call and co
>
>  arch/arm/Kconfig                  |   1 +
>  arch/arm/include/asm/smp.h        |   5 +
>  arch/arm/kernel/smp.c             |  97 +++++++++++---
>  arch/arm64/Kconfig                |   1 +
>  arch/arm64/include/asm/irq_work.h |   4 +-
>  arch/arm64/include/asm/smp.h      |   6 +-
>  arch/arm64/kernel/smp.c           |  98 +++++++++++----
>  drivers/irqchip/irq-bcm2836.c     | 151 ++++++++++++++++++----
>  drivers/irqchip/irq-gic-common.c  |   3 -
>  drivers/irqchip/irq-gic-v3.c      | 109 ++++++++++------
>  drivers/irqchip/irq-gic.c         | 203 ++++++++++++++++++------------
>  include/linux/irq.h               |   4 +-
>  kernel/irq/chip.c                 |  26 ++++
>  kernel/irq/debugfs.c              |   1 +
>  kernel/irq/proc.c                 |   2 +-
>  kernel/irq/settings.h             |   7 ++
>  16 files changed, 515 insertions(+), 203 deletions(-)
