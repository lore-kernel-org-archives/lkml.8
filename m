Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71742C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5176A207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 14:51:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgEOOvx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 10:51:53 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:46947 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgEOOvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 10:51:52 -0400
X-Originating-IP: 90.65.91.255
Received: from localhost (lfbn-lyo-1-1912-bdcst.w90-65.abo.wanadoo.fr [90.65.91.255])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id D2319240032;
        Fri, 15 May 2020 14:51:49 +0000 (UTC)
Date:   Fri, 15 May 2020 16:51:49 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Tudor.Ambarus@microchip.com
Cc:     Ludovic.Desroches@microchip.com, Nicolas.Ferre@microchip.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Codrin.Ciubotariu@microchip.com
Subject: Re: [PATCH 00/16] ARM: dts: at91: sama5d2: Rework Flexcom definitions
Message-ID: <20200515145149.GU34497@piout.net>
References: <20200514050301.147442-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514050301.147442-1-tudor.ambarus@microchip.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/05/2020 05:03:06+0000, Tudor.Ambarus@microchip.com wrote:
> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> Rework the sama5d2 SoC flexcom definitions. The Flexcom IPs are
> in the SoC. Move all the flexcom nodes together with their function
> definitions in the SoC dtsi. Boards will just fill the pins and enable
> the desired functions. With this we remove the duplication of the
> flexcom definitions across the sama5d2 boards.
> 
> Round the flexcom support and add the missing flexcom definitions.
> All the flexcom functions are now defined.
> 
> Apart of the aliases and the new flx0 i2c function on sama5d2_xplained,
> the only functional change that this patch set adds, is that it uart5,
> uart6 and uart7 inherit the atmel,fifo-size = <32>; optional property.
> These nodes have both the FIFO size described and the DMA enabled.
> uart5 was tested on sama5d27-wlsom1-ek. On uart6 and uart7 a
> Bluetooth module can be connected. Tested BT uart7 on sama5d2-icp.
> 
> Tudor Ambarus (16):
>   ARM: dts: at91: sama5d2: Fix the label numbering for flexcom functions
>   ARM: dts: at91: sama5d2: Move flx4 definitions in the SoC dtsi
>   ARM: dts: at91: sama5d2: Move flx3 definitions in the SoC dtsi
>   ARM: dts: at91: sama5d2: Move flx2 definitions in the SoC dtsi
>   ARM: dts: at91: sama5d2: Move flx1 definitions in the SoC dtsi
>   ARM: dts: at91: sama5d2: Move flx0 definitions in the SoC dtsi
>   ARM: dts: at91: sama5d2: Specify the FIFO size for the Flexcom UART
>   ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and UART flx4
>     functions
>   ARM: dts: at91: sama5d2: Add DMA bindings for the flx3 SPI function
>   ARM: dts: at91: sama5d2: Add DMA bindings for the flx1 I2C function
>   ARM: dts: at91: sama5d2: Add DMA bindings for the SPI and I2C flx0
>     functions
>   ARM: dts: at91: sama5d2: Add missing flexcom definitions
>   ARM: dts: at91: sama5d2: Remove i2s and tcb aliases from SoC dtsi
>   ARM: dts: at91: sama5d2_xplained: Add alias for DBGU
>   ARM: dts: at91: sama5d2_xplained: Describe the flx0 I2C function
>   ARM: dts: at91: sama5d2_ptc_ek: Add comments to describe the aliases
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
