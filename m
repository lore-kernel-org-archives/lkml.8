Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDA4C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 087EF207DD
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:38:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728475AbgGUCi5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:38:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:39134 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726264AbgGUCi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:38:57 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 063F2A048BC6B8FFA1AF;
        Tue, 21 Jul 2020 10:38:52 +0800 (CST)
Received: from [10.57.101.250] (10.57.101.250) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Tue, 21 Jul 2020 10:38:43 +0800
Subject: Re: [RESEND][PATCH] dts: hi3660: Add support for basic usb gadget on
 Hikey960
To:     John Stultz <john.stultz@linaro.org>,
        lkml <linux-kernel@vger.kernel.org>
References: <20200721012547.83743-1-john.stultz@linaro.org>
CC:     Yu Chen <chenyu56@huawei.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        YongQin Liu <yongqin.liu@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
From:   Wei Xu <xuwei5@hisilicon.com>
Message-ID: <5F165532.40202@hisilicon.com>
Date:   Tue, 21 Jul 2020 10:38:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
In-Reply-To: <20200721012547.83743-1-john.stultz@linaro.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.57.101.250]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi John,

On 2020/7/21 9:25, John Stultz wrote:
> This patch adds basic core dwc3, usb phy and rt1711h nodes for
> usb support on Hikey960.
> 
> This does not enable the mux/hub functionality on the board, so
> the USB-A host ports will not function, but does allow the USB-C
> port to function in gadget mode (unfortunately not in host, as
> the hub/mux functionality is needed to enable vbus output to
> power devices in host mode).
> 
> This is based on an old patch originally by Yu Chen.
> 
> Cc: Yu Chen <chenyu56@huawei.com>
> Cc: Chunfeng Yun <chunfeng.yun@mediatek.com>
> Cc: Wei Xu <xuwei5@hisilicon.com>
> Cc: Binghui Wang <wangbinghui@hisilicon.com>
> Cc: YongQin Liu <yongqin.liu@linaro.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: devicetree@vger.kernel.org
> Signed-off-by: John Stultz <john.stultz@linaro.org>

Thanks!
Applied to the hisilicon arm64 dt tree.

Best Regards,
Wei

> ---
>  .../boot/dts/hisilicon/hi3660-hikey960.dts    | 72 +++++++++++++++++++
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi     | 34 +++++++++
>  2 files changed, 106 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> index e035cf195b19..ff392a47562c 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts
> @@ -13,6 +13,7 @@
>  #include <dt-bindings/gpio/gpio.h>
>  #include <dt-bindings/input/input.h>
>  #include <dt-bindings/interrupt-controller/irq.h>
> +#include <dt-bindings/usb/pd.h>
>  
>  / {
>  	model = "HiKey960";
> @@ -526,6 +527,48 @@
>  &i2c1 {
>  	status = "okay";
>  
> +	rt1711h: rt1711h@4e {
> +		compatible = "richtek,rt1711h";
> +		reg = <0x4e>;
> +		status = "ok";
> +		interrupt-parent = <&gpio27>;
> +		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&usb_cfg_func>;
> +
> +		usb_con: connector {
> +			compatible = "usb-c-connector";
> +			label = "USB-C";
> +			data-role = "dual";
> +			power-role = "dual";
> +			try-power-role = "sink";
> +			source-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)>;
> +			sink-pdos = <PDO_FIXED(5000, 500, PDO_FIXED_USB_COMM)
> +				PDO_VAR(5000, 5000, 1000)>;
> +			op-sink-microwatt = <10000000>;
> +
> +			ports {
> +				#address-cells = <1>;
> +				#size-cells = <0>;
> +				port@1 {
> +					reg = <1>;
> +					usb_con_ss: endpoint {
> +						remote-endpoint = <&dwc3_ss>;
> +					};
> +				};
> +			};
> +		};
> +		port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +
> +			rt1711h_ep: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&dwc3_role_switch>;
> +			};
> +		};
> +	};
> +
>  	adv7533: adv7533@39 {
>  		status = "ok";
>  		compatible = "adi,adv7533";
> @@ -612,3 +655,32 @@
>  		interrupts = <3 IRQ_TYPE_EDGE_RISING>;
>  	};
>  };
> +
> +&dwc3 { /* USB */
> +	dr_mode = "otg";
> +	maximum-speed = "super-speed";
> +	phy_type = "utmi";
> +	snps,dis-del-phy-power-chg-quirk;
> +	snps,lfps_filter_quirk;
> +	snps,dis_u2_susphy_quirk;
> +	snps,dis_u3_susphy_quirk;
> +	snps,tx_de_emphasis_quirk;
> +	snps,tx_de_emphasis = <1>;
> +	snps,dis_enblslpm_quirk;
> +	snps,gctl-reset-quirk;
> +	usb-role-switch;
> +	role-switch-default-mode = "host";
> +	port {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +		dwc3_role_switch: endpoint@0 {
> +			reg = <0>;
> +			remote-endpoint = <&rt1711h_ep>;
> +		};
> +
> +		dwc3_ss: endpoint@1 {
> +			reg = <1>;
> +			remote-endpoint = <&usb_con_ss>;
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index c39b78989ff9..d25aac5e0bf8 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -1152,6 +1152,40 @@
>  				};
>  			};
>  		};
> +
> +		usb3_otg_bc: usb3_otg_bc@ff200000 {
> +			compatible = "syscon", "simple-mfd";
> +			reg = <0x0 0xff200000 0x0 0x1000>;
> +
> +			usb_phy: usb-phy {
> +				compatible = "hisilicon,hi3660-usb-phy";
> +				#phy-cells = <0>;
> +				hisilicon,pericrg-syscon = <&crg_ctrl>;
> +				hisilicon,pctrl-syscon = <&pctrl>;
> +				hisilicon,eye-diagram-param = <0x22466e4>;
> +			};
> +		};
> +
> +		dwc3: dwc3@ff100000 {
> +			compatible = "snps,dwc3";
> +			reg = <0x0 0xff100000 0x0 0x100000>;
> +
> +			clocks = <&crg_ctrl HI3660_CLK_ABB_USB>,
> +				 <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			clock-names = "ref", "bus_early";
> +
> +			assigned-clocks = <&crg_ctrl HI3660_ACLK_GATE_USB3OTG>;
> +			assigned-clock-rates = <229000000>;
> +
> +			resets = <&crg_rst 0x90 8>,
> +				 <&crg_rst 0x90 7>,
> +				 <&crg_rst 0x90 6>,
> +				 <&crg_rst 0x90 5>;
> +
> +			interrupts = <0 159 4>, <0 161 4>;
> +			phys = <&usb_phy>;
> +			phy-names = "usb3-phy";
> +		};
>  	};
>  };
>  
> 
