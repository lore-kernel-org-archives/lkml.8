Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD33AC2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 967CE2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 08:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581495213;
	bh=T4eFhqnFIGrFD+wHtvfDeHQzq+mCGSZ+1lYReIAedFE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OsNWmKYWIEWIiS9cY3ZOefkQ9XxM6ZjI91N3b+cskVZ3amZIFdVcumO8EoLuJOSEc
	 sdYp9wY5R/Zw/NKgtC7v6BqKIuxXNy6A0mK+FUumpjuZ0rTu00WIqncVkV4qQiqMa+
	 c7PtiphaNTb3eXOqtssQsei42fjYT9OtTrbX+B3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgBLINd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 03:13:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:59412 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728287AbgBLINc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:13:32 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 22DEF20714;
        Wed, 12 Feb 2020 08:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581495211;
        bh=T4eFhqnFIGrFD+wHtvfDeHQzq+mCGSZ+1lYReIAedFE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MFYt3vgmTGN1Vi5bdDbJXeFUPpC0AaXvxXGz0Eir4tw4whbGXLGnVva5c0RgwDHhc
         tjr7OHsttPYVv+oHNFmX+N08PY8ZQKmaUsNiAmrlGsELU4gnpJxsfIZMRD1MblkROH
         3LLxwWFIpEEM4a4lWW7CO3DlxhXO4vFVxy/rQvxI=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j1n9F-004Wgw-DL; Wed, 12 Feb 2020 08:13:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 12 Feb 2020 08:13:29 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        Serge Schneider <serge@raspberrypi.org>,
        Kristina Brooks <notstina@gmail.com>,
        Stefan Wahren <wahrenst@gmx.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Martin Sperl <kernel@martin.sperl.org>,
        Phil Elwell <phil@raspberrypi.org>
Subject: Re: [PATCH v2] irqchip/bcm2835: Quiesce IRQs left enabled by
 bootloader
In-Reply-To: <8be2f3e95fb29abdf80240f2b8a38621c42eb2a9.1581327911.git.lukas@wunner.de>
References: <713627a200d9c8fd7cac424d69e98166@kernel.org>
 <8be2f3e95fb29abdf80240f2b8a38621c42eb2a9.1581327911.git.lukas@wunner.de>
Message-ID: <d49218987c0d1d573aaa3bcccf44ffe3@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: lukas@wunner.de, tglx@linutronix.de, jason@lakedaemon.net, nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com, sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, serge@raspberrypi.org, notstina@gmail.com, wahrenst@gmx.net, mbrugger@suse.com, kernel@martin.sperl.org, phil@raspberrypi.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lukas,

Thanks for the update on this.

On 2020-02-10 09:52, Lukas Wunner wrote:
> Customers of our "Revolution Pi" open source PLCs (which are based on
> the Raspberry Pi) have reported random lockups as well as jittery eMMC,
> UART and SPI latency.  We were able to reproduce the lockups in our lab
> and hooked up a JTAG debugger:
> 
> It turns out that the USB controller's interrupt is already enabled 
> when
> the kernel boots.  All interrupts are disabled when the chip comes out
> of power-on reset, according to the spec.  So apparently the bootloader
> enables the interrupt but neglects to disable it before handing over
> control to the kernel.
> 
> The bootloader is a closed source blob provided by the Raspberry Pi
> Foundation.  Development of an alternative open source bootloader was
> begun by Kristina Brooks but it's not fully functional yet.  Usage of
> the blob is thus without alternative for the time being.
> 
> The Raspberry Pi Foundation's downstream kernel has a performance-
> optimized USB driver (which we use on our Revolution Pi products).
> The driver takes advantage of the FIQ fast interrupt.  Because the
> regular USB interrupt was left enabled by the bootloader, both the
> FIQ and the normal interrupt is enabled once the USB driver probes.
> 
> The spec has the following to say on simultaneously enabling the FIQ
> and the normal interrupt of a peripheral:
> 
> "One interrupt source can be selected to be connected to the ARM FIQ
>  input.  An interrupt which is selected as FIQ should have its normal
>  interrupt enable bit cleared.  Otherwise a normal and an FIQ interrupt
>  will be fired at the same time.  Not a good idea!"
>                                   ^^^^^^^^^^^^^^^
> https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
> page 110
> 
> On a multicore Raspberry Pi, the Foundation's kernel routes all normal
> interrupts to CPU 0 and the FIQ to CPU 1.  Because both the FIQ and the
> normal interrupt is enabled, a USB interrupt causes CPU 0 to spin in
> bcm2836_chained_handle_irq() until the FIQ on CPU 1 has cleared it.
> Interrupts with a lower priority than USB are starved as long.
> 
> That explains the jittery eMMC, UART and SPI latency:  On one occasion
> I've seen CPU 0 blocked for no less than 2.9 msec.  Basically,
> everything not USB takes a performance hit:  Whereas eMMC throughput
> on a Compute Module 3 remains relatively constant at 23.5 MB/s with
> this commit, it irregularly dips to 23.0 MB/s without this commit.
> 
> The lockups occur when CPU 0 receives a USB interrupt while holding a
> lock which CPU 1 is trying to acquire while the FIQ is temporarily
> disabled on CPU 1.
> 
> I've tested old releases of the Foundation's bootloader as far back as
> 1.20160202-1 and they all leave the USB interrupt enabled.  Still older
> releases fail to boot a contemporary kernel on a Compute Module 1 or 3,
> which are the only Raspberry Pi variants I have at my disposal for
> testing.
> 
> Fix by disabling IRQs left enabled by the bootloader.  Although the
> impact is most pronounced on the Foundation's downstream kernel,
> it seems prudent to apply the fix to the upstream kernel to guard
> against such mistakes in any present and future bootloader.

While the story is interesting, it doesn't really belong to a commit 
message.
Please trim it down to something along the lines of:

- The RPi bootloader is a bit crap, as it leaves IRQs and FIQs enabled
   and for the OS to deal with the consequences

- The kernel driver is not great either, as it doesn't properly 
initialize
   the interrupt state, resulting in both IRQ and FIQ misfiring and 
resulting
   in bizarre behaviours

- Properly initializing the irqchip fixes the issue. Add a couple a 
warnings
   for a good measure, so that people realize their favourite toy comes 
with
   sub-par SW.

> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Serge Schneider <serge@raspberrypi.org>
> Cc: Kristina Brooks <notstina@gmail.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1:
> * Use "relaxed" MMIO accessors to avoid memory barriers (Marc)
> * Use u32 instead of int for register access (Marc)
> * Quiesce FIQ as well (Marc)
> * Quiesce IRQs after mapping them for better readability
> * Drop alternative approach from commit message (Marc)
> 
> Link to v1:
> https://lore.kernel.org/lkml/988737dbbc4e499c2faaaa4e567ba3ed8deb9a89.1581089797.git.lukas@wunner.de/
> 
>  drivers/irqchip/irq-bcm2835.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-bcm2835.c 
> b/drivers/irqchip/irq-bcm2835.c
> index 418245d31921..63539c88ac3a 100644
> --- a/drivers/irqchip/irq-bcm2835.c
> +++ b/drivers/irqchip/irq-bcm2835.c
> @@ -61,6 +61,7 @@
>  					| SHORTCUT1_MASK | SHORTCUT2_MASK)
> 
>  #define REG_FIQ_CONTROL		0x0c
> +#define REG_FIQ_ENABLE		0x80
> 
>  #define NR_BANKS		3
>  #define IRQS_PER_BANK		32
> @@ -135,6 +136,7 @@ static int __init armctrl_of_init(struct 
> device_node *node,
>  {
>  	void __iomem *base;
>  	int irq, b, i;
> +	u32 reg;
> 
>  	base = of_iomap(node, 0);
>  	if (!base)
> @@ -157,6 +159,19 @@ static int __init armctrl_of_init(struct 
> device_node *node,
>  				handle_level_irq);
>  			irq_set_probe(irq);
>  		}
> +
> +		reg = readl_relaxed(intc.enable[b]);
> +		if (reg) {
> +			writel_relaxed(reg, intc.disable[b]);
> +			pr_err(FW_BUG "Bootloader left irq enabled: "
> +			       "bank %d irq %*pbl\n", b, IRQS_PER_BANK, &reg);
> +		}
> +	}
> +
> +	reg = readl_relaxed(base + REG_FIQ_CONTROL);
> +	if (reg & REG_FIQ_ENABLE) {
> +		writel_relaxed(0, base + REG_FIQ_CONTROL);
> +		pr_err(FW_BUG "Bootloader left fiq enabled\n");
>  	}
> 
>  	if (is_2836) {

It otherwise looks good. You can either resend it with a fixed commit 
message,
or provide me with a commit message that I can stick there while 
applying it.

Thanks,

        M.
-- 
Jazz is not dead. It just smells funny...
