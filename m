Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC3BC4BA3B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A9A224672
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 04:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728377AbgB0ELE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 23:11:04 -0500
Received: from kernel.crashing.org ([76.164.61.194]:36614 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727735AbgB0ELE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 23:11:04 -0500
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 01R4AMqA022487
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Wed, 26 Feb 2020 22:10:25 -0600
Message-ID: <7a210c19a7793b925275dbd8392e3c1ef538b229.camel@kernel.crashing.org>
Subject: Re: [PATCH v4 4/7] ARM: dts: aspeed-g6: add usb functions
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     rentao.bupt@gmail.com, Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Colin Ian King <colin.king@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        taoren@fb.com
Date:   Thu, 27 Feb 2020 15:10:21 +1100
In-Reply-To: <20200226230346.672-5-rentao.bupt@gmail.com>
References: <20200226230346.672-1-rentao.bupt@gmail.com>
         <20200226230346.672-5-rentao.bupt@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 15:03 -0800, rentao.bupt@gmail.com wrote:
> From: Tao Ren <rentao.bupt@gmail.com>
> 
> Add USB components and according pin groups in aspeed-g6 dtsi.
> 
> Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
> Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  No change in v3/v4.
>  Changes in v2:
>    - added port/endpoint properties for vhub dt node.
> 
>  arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi | 25 +++++++++++++
>  arch/arm/boot/dts/aspeed-g6.dtsi         | 45
> ++++++++++++++++++++++++
>  2 files changed, 70 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> index 045ce66ca876..7028e21bdd98 100644
> --- a/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6-pinctrl.dtsi
> @@ -1112,6 +1112,31 @@
>  		groups = "UART9";
>  	};
>  
> +	pinctrl_usb2ah_default: usb2ah_default {
> +		function = "USB2AH";
> +		groups = "USBA";
> +	};
> +
> +	pinctrl_usb2ad_default: usb2ad_default {
> +		function = "USB2AD";
> +		groups = "USBA";
> +	};
> +
> +	pinctrl_usb2bh_default: usb2bh_default {
> +		function = "USB2BH";
> +		groups = "USBB";
> +	};
> +
> +	pinctrl_usb2bd_default: usb2bd_default {
> +		function = "USB2BD";
> +		groups = "USBB";
> +	};
> +
> +	pinctrl_usb11bhid_default: usb11bhid_default {
> +		function = "USB11BHID";
> +		groups = "USBB";
> +	};
> +
>  	pinctrl_vb_default: vb_default {
>  		function = "VB";
>  		groups = "VB";
> diff --git a/arch/arm/boot/dts/aspeed-g6.dtsi
> b/arch/arm/boot/dts/aspeed-g6.dtsi
> index 796976d275e1..0a29b3b57a9d 100644
> --- a/arch/arm/boot/dts/aspeed-g6.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g6.dtsi
> @@ -245,6 +245,51 @@
>  			status = "disabled";
>  		};
>  
> +		ehci0: usb@1e6a1000 {
> +			compatible = "aspeed,ast2600-ehci", "generic-
> ehci";
> +			reg = <0x1e6a1000 0x100>;
> +			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2ah_default>;
> +			status = "disabled";
> +		};
> +
> +		ehci1: usb@1e6a3000 {
> +			compatible = "aspeed,ast2600-ehci", "generic-
> ehci";
> +			reg = <0x1e6a3000 0x100>;
> +			interrupts = <GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT2CLK>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2bh_default>;
> +			status = "disabled";
> +		};
> +
> +		uhci: usb@1e6b0000 {
> +			compatible = "aspeed,ast2600-uhci", "generic-
> uhci";
> +			reg = <0x1e6b0000 0x100>;
> +			interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
> +			#ports = <2>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBUHCICLK>;
> +			status = "disabled";
> +			/*
> +			 * No default pinmux, it will follow EHCI, use
> an
> +			 * explicit pinmux override if EHCI is not
> enabled.
> +			 */
> +		};
> +
> +		vhub: usb-vhub@1e6a0000 {
> +			compatible = "aspeed,ast2600-usb-vhub";
> +			reg = <0x1e6a0000 0x350>;
> +			interrupts = <GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>;
> +			clocks = <&syscon ASPEED_CLK_GATE_USBPORT1CLK>;
> +			aspeed,vhub-downstream-ports = <7>;
> +			aspeed,vhub-generic-endpoints = <21>;
> +			pinctrl-names = "default";
> +			pinctrl-0 = <&pinctrl_usb2ad_default>;
> +			status = "disabled";
> +		};
> +
>  		apb {
>  			compatible = "simple-bus";
>  			#address-cells = <1>;

