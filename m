Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DD5C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79E5207ED
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 22:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgERW3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 18:29:16 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52756 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727900AbgERW3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 18:29:15 -0400
Received: from ip5f5aa64a.dynamic.kabel-deutschland.de ([95.90.166.74] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1jaoFx-00007u-F7; Tue, 19 May 2020 00:29:09 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>, kever.yang@rock-chips.com,
        Caesar Wang <wxt@rock-chips.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] arm64: dts: rockchip: rk3399: fix pd_tcpc0 and pd_tcpc1 node position
Date:   Tue, 19 May 2020 00:29:08 +0200
Message-ID: <2978296.PvbIKR7951@diego>
In-Reply-To: <20200428203003.3318-2-jbx6244@gmail.com>
References: <20200428203003.3318-1-jbx6244@gmail.com> <20200428203003.3318-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kever, Caesar,

could you double check where the type-c power-domains are located
in the power-tree, as Caesar did add them under pd_vio back in 2016.

Thanks
Heiko

Am Dienstag, 28. April 2020, 22:30:03 CEST schrieb Johan Jonker:
> The pd_tcpc0 and pd_tcpc1 nodes are currently a sub node of pd_vio.
> In the rk3399 TRM figure of the 'Power Domain Partition' and in the
> table of 'Power Domain and Voltage Domain Summary' these power domains
> are positioned directly under VD_LOGIC, so fix that in 'rk3399.dtsi'.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  arch/arm64/boot/dts/rockchip/rk3399.dtsi | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> index 37279db53..a4dc1bf2e 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
> @@ -1056,6 +1056,16 @@
>  				clocks = <&cru HCLK_SDIO>;
>  				pm_qos = <&qos_sdioaudio>;
>  			};
> +			pd_tcpc0@RK3399_PD_TCPD0 {
> +				reg = <RK3399_PD_TCPD0>;
> +				clocks = <&cru SCLK_UPHY0_TCPDCORE>,
> +					 <&cru SCLK_UPHY0_TCPDPHY_REF>;
> +			};
> +			pd_tcpc1@RK3399_PD_TCPD1 {
> +				reg = <RK3399_PD_TCPD1>;
> +				clocks = <&cru SCLK_UPHY1_TCPDCORE>,
> +					 <&cru SCLK_UPHY1_TCPDPHY_REF>;
> +			};
>  			pd_usb3@RK3399_PD_USB3 {
>  				reg = <RK3399_PD_USB3>;
>  				clocks = <&cru ACLK_USB3>;
> @@ -1088,16 +1098,6 @@
>  					pm_qos = <&qos_isp1_m0>,
>  						 <&qos_isp1_m1>;
>  				};
> -				pd_tcpc0@RK3399_PD_TCPD0 {
> -					reg = <RK3399_PD_TCPD0>;
> -					clocks = <&cru SCLK_UPHY0_TCPDCORE>,
> -						 <&cru SCLK_UPHY0_TCPDPHY_REF>;
> -				};
> -				pd_tcpc1@RK3399_PD_TCPD1 {
> -					reg = <RK3399_PD_TCPD1>;
> -					clocks = <&cru SCLK_UPHY1_TCPDCORE>,
> -						 <&cru SCLK_UPHY1_TCPDPHY_REF>;
> -				};
>  				pd_vo@RK3399_PD_VO {
>  					reg = <RK3399_PD_VO>;
>  					#address-cells = <1>;
> 




