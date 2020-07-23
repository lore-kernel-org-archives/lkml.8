Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB29C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F05020714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 20:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="KT0PF3bi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726918AbgGWUj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 16:39:29 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:40604 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725979AbgGWUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 16:39:29 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06NKdPpL076293;
        Thu, 23 Jul 2020 15:39:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595536765;
        bh=kVZNfhKHbyHmTCPMwDlSUNXeOG4dXmiHD5nfEJkzKRg=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=KT0PF3bia3hH+0ZqOB3sT51jOSmGtNUQDu8BSdh+F3PrT4AuudMVEcK2Z+1m3XHgU
         9Bvq+4wDY0tPseVDL84Kx61e2CRTy5cQDCs7BPPJvCvzQ7OkrRR5wjN+37iRw1x090
         /j1XDmere0Y+5YLLhtZkSVDnL5ie2YZx6zi3EVp8=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06NKdPeZ030811
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jul 2020 15:39:25 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Jul 2020 15:39:24 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Jul 2020 15:39:24 -0500
Received: from [10.250.34.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06NKdOU8086406;
        Thu, 23 Jul 2020 15:39:24 -0500
Subject: Re: [PATCH 4/4] arm64: dts: ti: Add support for J7200 Common
 Processor Board
To:     Lokesh Vutla <lokeshvutla@ti.com>, Tero Kristo <t-kristo@ti.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
 <20200723084628.19241-5-lokeshvutla@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <13e428a8-1c8d-62d6-3d31-84eeba43c9b3@ti.com>
Date:   Thu, 23 Jul 2020 15:39:24 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723084628.19241-5-lokeshvutla@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/20 3:46 AM, Lokesh Vutla wrote:
> Add support for J7200 Common Processor Board.
> The EVM architecture is very similar to J721E as follows:
> 
> +------------------------------------------------------+
> |   +-------------------------------------------+      |
> |   |                                           |      |
> |   |        Add-on Card 1 Options              |      |
> |   |                                           |      |
> |   +-------------------------------------------+      |
> |                                                      |
> |                                                      |
> |                     +-------------------+            |
> |                     |                   |            |
> |                     |   SOM             |            |
> |  +--------------+   |                   |            |
> |  |              |   |                   |            |
> |  |  Add-on      |   +-------------------+            |
> |  |  Card 2      |                                    |    Power Supply
> |  |  Options     |                                    |    |
> |  |              |                                    |    |
> |  +--------------+                                    | <---
> +------------------------------------------------------+
>                                  Common Processor Board
> 
> Common Processor board is the baseboard that has most of the actual
> connectors, power supply etc. A SOM (System on Module) is plugged on
> to the common processor board and this contains the SoC, PMIC, DDR and
> basic high speed components necessary for functionality.
> 
> Note:
> * The minimum configuration required to boot up the board is System On
>    Module(SOM) + Common Processor Board.
> * Since there is just a single SOM and Common Processor Board, we are
>    maintaining common processor board as the base dts and SOM as the dtsi
>    that we include. In the future as more SOM's appear, we should move
>    common processor board as a dtsi and include configurations as dts.
> * All daughter cards beyond the basic boards shall be maintained as
>    overlays.
> * Since J7200 is derivative of J721E re-using the CONFIG_ARCH_K3_J721E_SOC
>    config for building J7200 dts files.
> 
> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Suman Anna <s-anna@ti.com>

> ---
>   arch/arm64/boot/dts/ti/Makefile               |  3 +-
>   .../dts/ti/k3-j7200-common-proc-board.dts     | 64 +++++++++++++++++++
>   arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi   | 29 +++++++++
>   3 files changed, 95 insertions(+), 1 deletion(-)
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> 
> diff --git a/arch/arm64/boot/dts/ti/Makefile b/arch/arm64/boot/dts/ti/Makefile
> index b397945fdf73..7b0b176eab1b 100644
> --- a/arch/arm64/boot/dts/ti/Makefile
> +++ b/arch/arm64/boot/dts/ti/Makefile
> @@ -8,4 +8,5 @@
>   
>   dtb-$(CONFIG_ARCH_K3_AM6_SOC) += k3-am654-base-board.dtb
>   
> -dtb-$(CONFIG_ARCH_K3_J721E_SOC) += k3-j721e-common-proc-board.dtb
> +dtb-$(CONFIG_ARCH_K3_J721E_SOC) += k3-j721e-common-proc-board.dtb \
> +				   k3-j7200-common-proc-board.dtb
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> new file mode 100644
> index 000000000000..e27069317c4e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-common-proc-board.dts
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-j7200-som-p0.dtsi"
> +
> +/ {
> +	chosen {
> +		stdout-path = "serial2:115200n8";
> +		bootargs = "console=ttyS2,115200n8 earlycon=ns16550a,mmio32,0x02800000";
> +	};
> +};
> +
> +&wkup_uart0 {
> +	/* Wakeup UART is used by System firmware */
> +	status = "disabled";
> +};
> +
> +&main_uart0 {
> +	power-domains = <&k3_pds 146 TI_SCI_PD_SHARED>;
> +};
> +
> +&main_uart2 {
> +	/* MAIN UART 2 is used by R5F firmware */
> +	status = "disabled";
> +};
> +
> +&main_uart3 {
> +	/* UART not brought out */
> +	status = "disabled";
> +};
> +
> +&main_uart4 {
> +	/* UART not brought out */
> +	status = "disabled";
> +};
> +
> +&main_uart5 {
> +	/* UART not brought out */
> +	status = "disabled";
> +};
> +
> +&main_uart6 {
> +	/* UART not brought out */
> +	status = "disabled";
> +};
> +
> +&main_uart7 {
> +	/* UART not brought out */
> +	status = "disabled";
> +};
> +
> +&main_uart8 {
> +	/* UART not brought out */
> +	status = "disabled";
> +};
> +
> +&main_uart9 {
> +	/* UART not brought out */
> +	status = "disabled";
> +};
> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> new file mode 100644
> index 000000000000..22fc50bd5c4c
> --- /dev/null
> +++ b/arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi
> @@ -0,0 +1,29 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Texas Instruments Incorporated - https://www.ti.com/
> + */
> +
> +/dts-v1/;
> +
> +#include "k3-j7200.dtsi"
> +
> +/ {
> +	memory@80000000 {
> +		device_type = "memory";
> +		/* 4G RAM */
> +		reg = <0x00000000 0x80000000 0x00000000 0x80000000>,
> +		      <0x00000008 0x80000000 0x00000000 0x80000000>;
> +	};
> +
> +	reserved_memory: reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		secure_ddr: optee@9e800000 {
> +			reg = <0x00 0x9e800000 0x00 0x01800000>;
> +			alignment = <0x1000>;
> +			no-map;
> +		};
> +	};
> +};
> 

