Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35E2C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA860206F0
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 19:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgH3TIc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 15:08:32 -0400
Received: from gloria.sntech.de ([185.11.138.130]:47744 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgH3TIb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 15:08:31 -0400
Received: from p508fca7b.dip0.t-ipconnect.de ([80.143.202.123] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1kCSgh-00023t-Th; Sun, 30 Aug 2020 21:08:23 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Katsuhiro Suzuki <katsuhiro@katsuster.net>
Cc:     linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>
Subject: Re: [PATCH v2] arm64: dts: rockchip: add SPDIF node for rk3399-rockpro64
Date:   Sun, 30 Aug 2020 21:08:18 +0200
Message-ID: <9694178.H46bfk3Hth@phil>
In-Reply-To: <20200810091619.3170534-1-katsuhiro@katsuster.net>
References: <20200810091619.3170534-1-katsuhiro@katsuster.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Am Montag, 10. August 2020, 11:16:19 CEST schrieb Katsuhiro Suzuki:
> This patch adds 'disabled' SPDIF sound node and related settings
> for rk3399-rockpro64.
> 
> There are 2 reasons:
>   - All RK3399 dma-bus channels have been already used by I2S0/1/2
>   - RockPro64 does not have SPDIF optical nor coaxial connector,
>     just have 3pins

I don't really understand what you mean here.

Like is there spdif on the board or not? Because you call it "disabled"
and also indicate that no i2s is available anymore, yet you mention 3 pins.
What do they do then?

Thanks
Heiko


> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> 
> ---
> 
> Changes in v2:
>   - Remove redundant status property
> ---
>  .../boot/dts/rockchip/rk3399-rockpro64.dtsi   | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> index 6e553ff47534..58097245994a 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dtsi
> @@ -76,6 +76,23 @@ sound {
>  		dais = <&i2s1_p0>;
>  	};
>  
> +	sound-dit {
> +		compatible = "audio-graph-card";
> +		label = "rockchip,rk3399";
> +		dais = <&spdif_p0>;
> +	};
> +
> +	spdif-dit {
> +		compatible = "linux,spdif-dit";
> +		#sound-dai-cells = <0>;
> +
> +		port {
> +			dit_p0_0: endpoint {
> +				remote-endpoint = <&spdif_p0_0>;
> +			};
> +		};
> +	};
> +
>  	vcc12v_dcin: vcc12v-dcin {
>  		compatible = "regulator-fixed";
>  		regulator-name = "vcc12v_dcin";
> @@ -698,6 +715,16 @@ &sdhci {
>  	status = "okay";
>  };
>  
> +&spdif {
> +	pinctrl-0 = <&spdif_bus_1>;
> +
> +	spdif_p0: port {
> +		spdif_p0_0: endpoint {
> +			remote-endpoint = <&dit_p0_0>;
> +		};
> +	};
> +};
> +
>  &spi1 {
>  	status = "okay";
>  
> 




