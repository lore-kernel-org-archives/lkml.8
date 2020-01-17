Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FED2C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 127E620728
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 12:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wgYOwaSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727003AbgAQM51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 07:57:27 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45022 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbgAQM51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 07:57:27 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00HCvJ5b114796;
        Fri, 17 Jan 2020 06:57:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579265839;
        bh=7f+i2QNUwMnAL6WTdKrrzAfyZ02OqWeNHk0Vudo0eYM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wgYOwaSXw8xgh4vQUH/BXjRbkULW0IZWht1MGI2VrftJ7mEHmKlrv4/z1HASCmdN1
         qxMaGxA8RzMwI/GjBhY+TNI6sUGvuNlfdsxm8B5VPVbrtm65ru47/Ej7P2A2edqe0o
         5mMhBnAy84vEKVr00EWSRZWhJCxUpaBV8SyRPy8E=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00HCvJbg093236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jan 2020 06:57:19 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Jan 2020 06:57:18 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Jan 2020 06:57:18 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00HCvGTs044775;
        Fri, 17 Jan 2020 06:57:16 -0600
Subject: Re: [PATCH] arm64: dts: ti: k3-am65-mcu: add system control module
 node
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
References: <20191216193933.31429-1-grygorii.strashko@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <48f203a7-4010-c434-6046-0089811c442f@ti.com>
Date:   Fri, 17 Jan 2020 14:57:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191216193933.31429-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/12/2019 21:39, Grygorii Strashko wrote:
> The MCU System control module support is added to the device tree to allow
> drivers to access to their System control module registers.
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Queued up for 5.6, thanks!

-Tero

> ---
>   arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi | 8 ++++++++
>   arch/arm64/boot/dts/ti/k3-am65.dtsi     | 2 ++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> index 27fc73f94cf9..3f76c2120b95 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi
> @@ -6,6 +6,14 @@
>    */
>   
>   &cbass_mcu {
> +	mcu_conf: scm_conf@40f00000 {
> +		compatible = "syscon", "simple-mfd";
> +		reg = <0x0 0x40f00000 0x0 0x20000>;
> +		#address-cells = <1>;
> +		#size-cells = <1>;
> +		ranges = <0x0 0x0 0x40f00000 0x20000>;
> +	};
> +
>   	mcu_uart0: serial@40a00000 {
>   		compatible = "ti,am654-uart";
>   			reg = <0x00 0x40a00000 0x00 0x100>;
> diff --git a/arch/arm64/boot/dts/ti/k3-am65.dtsi b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> index 6dfccd5d56c8..0923e71f663a 100644
> --- a/arch/arm64/boot/dts/ti/k3-am65.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-am65.dtsi
> @@ -74,6 +74,7 @@
>   			 /* MCUSS Range */
>   			 <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>,
>   			 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>,
> +			 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
>   			 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>,
>   			 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>,
>   			 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>,
> @@ -88,6 +89,7 @@
>   			#size-cells = <2>;
>   			ranges = <0x00 0x28380000 0x00 0x28380000 0x00 0x03880000>, /* MCU NAVSS*/
>   				 <0x00 0x40200000 0x00 0x40200000 0x00 0x00900100>, /* First peripheral window */
> +				 <0x00 0x40f00000 0x00 0x40f00000 0x00 0x00020000>, /* CTRL_MMR0 */
>   				 <0x00 0x41000000 0x00 0x41000000 0x00 0x00020000>, /* MCU R5F Core0 */
>   				 <0x00 0x41400000 0x00 0x41400000 0x00 0x00020000>, /* MCU R5F Core1 */
>   				 <0x00 0x41c00000 0x00 0x41c00000 0x00 0x00080000>, /* MCU SRAM */
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
