Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751A2C2BBC7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:03:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B7BC20732
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 10:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438096AbgDNKDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 06:03:02 -0400
Received: from foss.arm.com ([217.140.110.172]:52260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438072AbgDNKDA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 06:03:00 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3CE641FB;
        Tue, 14 Apr 2020 03:02:59 -0700 (PDT)
Received: from [10.57.33.145] (unknown [10.57.33.145])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4E63F6C4;
        Tue, 14 Apr 2020 03:02:57 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: rockchip: remove bus-width from mmc nodes in
 rk3308.dtsi
To:     Johan Jonker <jbx6244@gmail.com>, heiko@sntech.de
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <20200413193652.1952-1-jbx6244@gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <20c81edc-247c-8db0-2b3c-a6c2fcad6b4e@arm.com>
Date:   Tue, 14 Apr 2020 11:02:46 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200413193652.1952-1-jbx6244@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-04-13 8:36 pm, Johan Jonker wrote:
> The 'bus-width' property for mmc nodes is defined both in
> 'rk3308.dtsi' and 'rk3308-roc-cc.dts'.
> In line with the other Rockchip SoCs define that in a user dts only,
> so remove all entries from mmc nodes in 'rk3308.dtsi'.

Judging by the pinctrl entries, these represent the number of pins 
provided by the SoC itself. Obviously boards need to override that if 
for some reason they don't wire up all the available data lines, but it 
seems backwards to have every board restate the SoC's default value.

In fact, having brought it up, for this particular case the pinctrl 
setting is inherently related to the bus width, so having one without 
the other in either place doesn't smell right.

Robin.

> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>   arch/arm64/boot/dts/rockchip/rk3308.dtsi | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> index a9b98555d..130771ede 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
> @@ -587,7 +587,6 @@
>   		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
>   		reg = <0x0 0xff480000 0x0 0x4000>;
>   		interrupts = <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>;
> -		bus-width = <4>;
>   		clocks = <&cru HCLK_SDMMC>, <&cru SCLK_SDMMC>,
>   			 <&cru SCLK_SDMMC_DRV>, <&cru SCLK_SDMMC_SAMPLE>;
>   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> @@ -602,7 +601,6 @@
>   		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
>   		reg = <0x0 0xff490000 0x0 0x4000>;
>   		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
> -		bus-width = <8>;
>   		clocks = <&cru HCLK_EMMC>, <&cru SCLK_EMMC>,
>   			 <&cru SCLK_EMMC_DRV>, <&cru SCLK_EMMC_SAMPLE>;
>   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> @@ -615,7 +613,6 @@
>   		compatible = "rockchip,rk3308-dw-mshc", "rockchip,rk3288-dw-mshc";
>   		reg = <0x0 0xff4a0000 0x0 0x4000>;
>   		interrupts = <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
> -		bus-width = <4>;
>   		clocks = <&cru HCLK_SDIO>, <&cru SCLK_SDIO>,
>   			 <&cru SCLK_SDIO_DRV>, <&cru SCLK_SDIO_SAMPLE>;
>   		clock-names = "biu", "ciu", "ciu-drive", "ciu-sample";
> 
