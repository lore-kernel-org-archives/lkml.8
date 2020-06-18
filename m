Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0809AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6F412070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592484103;
	bh=eJbZQP0xNHsWf9mN+hL/U5ulTsXIkdm9Muq9GcZ9Tow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=gCjdArLuqXEyqtcqCMeQoyp3P0X43ReYnNXa1PRX5HlIxWNzLiJBaZGA2a3QsZseW
	 CsxswnDb93SHZKkaCwTn+PbNpuAsj8OZELotMu5dhk22kvaTKcPFQrWQE4WXmMqGMV
	 BN0FpU9LutiF2Q4mWkyQMuCPlCN5HWadX0pb8rDo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729864AbgFRMlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:41:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:54138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727091AbgFRMll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:41:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1FED20663;
        Thu, 18 Jun 2020 12:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592484101;
        bh=eJbZQP0xNHsWf9mN+hL/U5ulTsXIkdm9Muq9GcZ9Tow=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hnf18fDQZpQw+uU2EuqznUf8S5+8LXIsEcdu3cMYyCVnbqseEbstRF3Foj9NJaFqV
         cd2rRx9G71nz2N2DksMNqHGzFP1fOl1v34wM+tRYYWHlhDmMbABFk6UDyuhG6sJS7w
         5JX7vkqYlau1RjMT1d029sotH6bt9MegLrmE0JaA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jltrP-004A7y-Cd; Thu, 18 Jun 2020 13:41:39 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 18 Jun 2020 13:41:39 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH 1/1] irqchip: Add config MTK_SYSIRQ and MTK_CIRQ
In-Reply-To: <1592483471-14806-1-git-send-email-hanks.chen@mediatek.com>
References: <1592483471-14806-1-git-send-email-hanks.chen@mediatek.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <f47e8a1e70c982ecf6245db573630f51@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: hanks.chen@mediatek.com, tglx@linutronix.de, jason@lakedaemon.net, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, wsd_upstream@mediatek.com, cc.hwang@mediatek.com, loda.chou@mediatek.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-18 13:31, Hanks Chen wrote:
> Mediatek sysirq and cirq drivers as-is were bound together to the 
> config
> of ARCH_MEDIATEK.  These two drivers should be able to be configured
> separately.  For example, on new Mediatek mobile chips such as 
> Dimensity
> 820, the sysirq driver is not used since the hardware module is 
> removed.
> 
> Add two new configs to sysirq and cirq drivers.
> - config MTK_SYSIRQ for the interrupt polarity controller driver: 
> sysirq
> - config MTK_CIRQ for the low-power interrupt driver: cirq
> 
> Signed-off-by: cc.hwang <cc.hwang@mediatek.com>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> ---
>  drivers/irqchip/Kconfig  |   12 ++++++++++++
>  drivers/irqchip/Makefile |    3 ++-
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
> index 29fead2..cc9aa18 100644
> --- a/drivers/irqchip/Kconfig
> +++ b/drivers/irqchip/Kconfig
> @@ -572,4 +572,16 @@ config LOONGSON_PCH_MSI
>  	help
>  	  Support for the Loongson PCH MSI Controller.
> 
> +config MTK_SYSIRQ
> +	tristate "Mediatek interrupt polarity controller"

How do you expect this to work as a module?

> +	help
> +	  Interrupt polarity controller driver to swap polarity for
> +	  interrupts for Mediatek mobile chips.
> +
> +config MTK_CIRQ
> +	bool "Mediatek low-power interrupt controller"
> +	help
> +	  Low-power interrupt controller driver to monitor IRQS
> +	  in the sleep mode for Mediatek mobile chips.
> +
>  endmenu
> diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
> index 133f9c4..30421d2 100644
> --- a/drivers/irqchip/Makefile
> +++ b/drivers/irqchip/Makefile
> @@ -69,7 +69,8 @@ obj-$(CONFIG_BCM7120_L2_IRQ)		+= irq-bcm7120-l2.o
>  obj-$(CONFIG_BRCMSTB_L2_IRQ)		+= irq-brcmstb-l2.o
>  obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
>  obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
> -obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o irq-mtk-cirq.o
> +obj-$(CONFIG_MTK_SYSIRQ)		+= irq-mtk-sysirq.o
> +obj-$(CONFIG_MTK_CIRQ)			+= irq-mtk-cirq.o
>  obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
>  obj-$(CONFIG_RENESAS_H8300H_INTC)	+= irq-renesas-h8300h.o
>  obj-$(CONFIG_RENESAS_H8S_INTC)		+= irq-renesas-h8s.o

In general, this approach doesn't look right. As it stands, this is just 
breaking existing configurations

Do you really expect users to know exactly which interrupt controllers 
their system is going to use? This seems like the wrong assumption. If 
you really want to save the handful of bytes these drivers take in your 
image, then add the relevant dependency information in Kconfig.

         M.
-- 
Jazz is not dead. It just smells funny...
