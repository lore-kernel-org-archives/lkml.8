Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FFDC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:54:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8989F20809
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIJHyl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:54:41 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.164]:29869 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgIJHyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:54:40 -0400
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj5Qpw97WFDlSfXA0N8oI="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id n03b0dw8A7qcbdz
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Thu, 10 Sep 2020 09:52:38 +0200 (CEST)
Subject: Re: [PATCH v8 5/6] MIPS: Ingenic: Add 'cpus' node for Ingenic SoCs.
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=utf-8
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <1589898923-60048-7-git-send-email-zhouyanjie@wanyeetech.com>
Date:   Thu, 10 Sep 2020 09:52:37 +0200
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, tsbogend@alpha.franken.de,
        paulburton@kernel.org, jiaxun.yang@flygoat.com, chenhc@lemote.com,
        tglx@linutronix.de, robh+dt@kernel.org, daniel.lezcano@linaro.org,
        keescook@chromium.org, paul@crapouillou.net, krzk@kernel.org,
        ebiederm@xmission.com, dongsheng.qiu@ingenic.com,
        yanfei.li@ingenic.com, rick.tyliu@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
Content-Transfer-Encoding: 8BIT
Message-Id: <8EBCE2D3-8683-4E57-912F-41D03C943CC9@goldelico.com>
References: <1589898923-60048-1-git-send-email-zhouyanjie@wanyeetech.com> <1589898923-60048-7-git-send-email-zhouyanjie@wanyeetech.com>
To:     =?utf-8?Q?=22=E5=91=A8=E7=90=B0=E6=9D=B0_=28Zhou_Yanjie=29=22?= 
        <zhouyanjie@wanyeetech.com>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhou Yanjie,
what is the status of this series? It does not seem to have arrived in linux-next for v5.10-rc1.

BR and thanks,
Nikolaus


> Am 19.05.2020 um 16:35 schrieb 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>:
> 
> Add 'cpus' node to the jz4740.dtsi, jz4770.dtsi, jz4780.dtsi
> and x1000.dtsi files.
> 
> Tested-by: H. Nikolaus Schaller <hns@goldelico.com>
> Tested-by: Paul Boddie <paul@boddie.org.uk>
> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
> ---
> 
> Notes:
>    v1->v2:
>    No change.
> 
>    v2->v3:
>    No change.
> 
>    v3->v4:
>    Rebase on top of kernel 5.6-rc1.
> 
>    v4->v5:
>    No change.
> 
>    v5->v6:
>    No change.
> 
>    v6->v7:
>    Update compatible strings.
> 
>    v7->v8:
>    No change.
> 
> arch/mips/boot/dts/ingenic/jz4740.dtsi | 14 ++++++++++++++
> arch/mips/boot/dts/ingenic/jz4770.dtsi | 15 ++++++++++++++-
> arch/mips/boot/dts/ingenic/jz4780.dtsi | 23 +++++++++++++++++++++++
> arch/mips/boot/dts/ingenic/x1000.dtsi  | 14 ++++++++++++++
> 4 files changed, 65 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/boot/dts/ingenic/jz4740.dtsi b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> index a3301ba..1f2f896 100644
> --- a/arch/mips/boot/dts/ingenic/jz4740.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4740.dtsi
> @@ -7,6 +7,20 @@
> 	#size-cells = <1>;
> 	compatible = "ingenic,jz4740";
> 
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "ingenic,xburst-mxu1.0";
> +			reg = <0>;
> +
> +			clocks = <&cgu JZ4740_CLK_CCLK>;
> +			clock-names = "cpu";
> +		};
> +	};
> +
> 	cpuintc: interrupt-controller {
> 		#address-cells = <0>;
> 		#interrupt-cells = <1>;
> diff --git a/arch/mips/boot/dts/ingenic/jz4770.dtsi b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> index 0bfb9ed..12c7101 100644
> --- a/arch/mips/boot/dts/ingenic/jz4770.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4770.dtsi
> @@ -1,5 +1,4 @@
> // SPDX-License-Identifier: GPL-2.0
> -
> #include <dt-bindings/clock/jz4770-cgu.h>
> 
> / {
> @@ -7,6 +6,20 @@
> 	#size-cells = <1>;
> 	compatible = "ingenic,jz4770";
> 
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "ingenic,xburst-fpu1.0-mxu1.1";
> +			reg = <0>;
> +
> +			clocks = <&cgu JZ4770_CLK_CCLK>;
> +			clock-names = "cpu";
> +		};
> +	};
> +
> 	cpuintc: interrupt-controller {
> 		#address-cells = <0>;
> 		#interrupt-cells = <1>;
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> index bb89653..03aeeff 100644
> --- a/arch/mips/boot/dts/ingenic/jz4780.dtsi
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -8,6 +8,29 @@
> 	#size-cells = <1>;
> 	compatible = "ingenic,jz4780";
> 
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "ingenic,xburst-fpu1.0-mxu1.1";
> +			reg = <0>;
> +
> +			clocks = <&cgu JZ4780_CLK_CPU>;
> +			clock-names = "cpu";
> +		};
> +
> +		cpu1: cpu@1 {
> +			device_type = "cpu";
> +			compatible = "ingenic,xburst-fpu1.0-mxu1.1";
> +			reg = <1>;
> +
> +			clocks = <&cgu JZ4780_CLK_CORE1>;
> +			clock-names = "cpu";
> +		};
> +	};
> +
> 	cpuintc: interrupt-controller {
> 		#address-cells = <0>;
> 		#interrupt-cells = <1>;
> diff --git a/arch/mips/boot/dts/ingenic/x1000.dtsi b/arch/mips/boot/dts/ingenic/x1000.dtsi
> index 147f7d5..2205e1b 100644
> --- a/arch/mips/boot/dts/ingenic/x1000.dtsi
> +++ b/arch/mips/boot/dts/ingenic/x1000.dtsi
> @@ -8,6 +8,20 @@
> 	#size-cells = <1>;
> 	compatible = "ingenic,x1000", "ingenic,x1000e";
> 
> +	cpus {
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +
> +		cpu0: cpu@0 {
> +			device_type = "cpu";
> +			compatible = "ingenic,xburst-fpu1.0-mxu1.1";
> +			reg = <0>;
> +
> +			clocks = <&cgu X1000_CLK_CPU>;
> +			clock-names = "cpu";
> +		};
> +	};
> +
> 	cpuintc: interrupt-controller {
> 		#address-cells = <0>;
> 		#interrupt-cells = <1>;
> -- 
> 2.7.4
> 

