Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80952C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 11:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6153820828
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 11:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgCHLbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 07:31:32 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:45811 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgCHLbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 07:31:32 -0400
X-Originating-IP: 87.231.134.186
Received: from localhost (87-231-134-186.rev.numericable.fr [87.231.134.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 2B51460003;
        Sun,  8 Mar 2020 11:31:29 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH 16/20] ARM: orion5x: Drop unneeded select of PCI_DOMAINS_GENERIC
In-Reply-To: <20200121103722.1781-16-geert+renesas@glider.be>
References: <20200121103413.1337-1-geert+renesas@glider.be> <20200121103722.1781-1-geert+renesas@glider.be> <20200121103722.1781-16-geert+renesas@glider.be>
Date:   Sun, 08 Mar 2020 12:31:28 +0100
Message-ID: <87d09nqe0f.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

> Support for Marvell Orion SoCs depends on ARCH_MULTI_V5, and thus on
> ARCH_MULTIPLATFORM.
> As the latter selects GENERIC_CLOCKEVENTS and USE_OF, there is no need
> for ARCH_ORION5X and ARCH_ORION5X_DT to select any of them.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Cc: Gregory Clement <gregory.clement@bootlin.com>


Applied on mvebu/arm

Thanks,

Gregory

> ---
> All patches in this series are independent of each other.
> Cover letter at https://lore.kernel.org/r/20200121103413.1337-1-geert+renesas@glider.be
>
>  arch/arm/mach-orion5x/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm/mach-orion5x/Kconfig b/arch/arm/mach-orion5x/Kconfig
> index cf9cb3d2590ec19b..e94a61901ffd86b4 100644
> --- a/arch/arm/mach-orion5x/Kconfig
> +++ b/arch/arm/mach-orion5x/Kconfig
> @@ -3,7 +3,6 @@ menuconfig ARCH_ORION5X
>  	bool "Marvell Orion"
>  	depends on MMU && ARCH_MULTI_V5
>  	select CPU_FEROCEON
> -	select GENERIC_CLOCKEVENTS
>  	select GPIOLIB
>  	select MVEBU_MBUS
>  	select FORCE_PCI
> @@ -18,7 +17,6 @@ if ARCH_ORION5X
>  
>  config ARCH_ORION5X_DT
>  	bool "Marvell Orion5x Flattened Device Tree"
> -	select USE_OF
>  	select ORION_CLK
>  	select ORION_IRQCHIP
>  	select ORION_TIMER
> -- 
> 2.17.1
>

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
