Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C8FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49F42074B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591004708;
	bh=M6x8W4Mi9J9XLfLXOURQuiS1H21aTtrGLADZ3opwq3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=jdzgBnhOkZg+XIGyK1uXiKfICQEWrcJf3bVjq0TeCEWorNXp65rSy3AhqLLVvypej
	 WGLuNJFN95ADtIoTgGbjMOch6y8C9WuQiEEWnP3aiyH8GnFXx3XbCOlj2qdciiKBdh
	 w0EtzgmxVvliwDQOBzB6V/4wOkLX9LKfOtJAbOnY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726010AbgFAJpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 05:45:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:50802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAJpH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 05:45:07 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE70420734;
        Mon,  1 Jun 2020 09:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591004707;
        bh=M6x8W4Mi9J9XLfLXOURQuiS1H21aTtrGLADZ3opwq3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Kt+W89EYFKSzrtHUbuKkC9HHUfNUY2mjWqRkZs8ynwxan/ai+kG3AaFuXaPxH/XtK
         66X/Gn9Zegz/EniKLTW4e9hwsHE4IOKvuKT0FJLy+umv/jOIBKVhyRG4phOEuCsSzz
         qF3uuyKcdJmehU8sjilORHDfTstEGLNH/b5jSIMo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jfh0D-00Grna-4n; Mon, 01 Jun 2020 10:45:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 01 Jun 2020 10:45:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v7 3/6] irqchip: RISC-V per-HART local interrupt
 controller driver
In-Reply-To: <20200601091543.943678-4-anup.patel@wdc.com>
References: <20200601091543.943678-1-anup.patel@wdc.com>
 <20200601091543.943678-4-anup.patel@wdc.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <43c4770a9c8a2e03242a5176037f823c@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, daniel.lezcano@linaro.org, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, palmerdabbelt@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-01 10:15, Anup Patel wrote:
> The RISC-V per-HART local interrupt controller manages software
> interrupts, timer interrupts, external interrupts (which are routed
> via the platform level interrupt controller) and other per-HART
> local interrupts.
> 
> We add a driver for the RISC-V local interrupt controller, which
> eventually replaces the RISC-V architecture code, allowing for a
> better split between arch code and drivers.
> 
> The driver is compliant with RISC-V Hart-Level Interrupt Controller
> DT bindings located at:
> Documentation/devicetree/bindings/interrupt-controller/riscv,cpu-intc.txt
> 
> Co-developed-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Palmer Dabbelt <palmer@dabbelt.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Acked-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  arch/riscv/Kconfig                |   1 +
>  arch/riscv/include/asm/irq.h      |   2 -
>  arch/riscv/kernel/irq.c           |  33 +------
>  arch/riscv/kernel/traps.c         |   2 -
>  drivers/irqchip/Kconfig           |  13 +++
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-riscv-intc.c  | 146 ++++++++++++++++++++++++++++++
>  drivers/irqchip/irq-sifive-plic.c |  30 ++++--
>  include/linux/cpuhotplug.h        |   1 +
>  9 files changed, 188 insertions(+), 41 deletions(-)
>  create mode 100644 drivers/irqchip/irq-riscv-intc.c

Reviewed-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
