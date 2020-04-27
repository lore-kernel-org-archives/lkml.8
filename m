Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBB0C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BD582074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="diOEyOh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgD0KJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:09:53 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:45640 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgD0KJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:09:52 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RA9jdG122958;
        Mon, 27 Apr 2020 05:09:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587982185;
        bh=2gZqUqCzi7AFRq8mRGo3ZoQLutalkhB+Fu89IDdfbgI=;
        h=Subject:To:References:From:Date:In-Reply-To;
        b=diOEyOh/+/DnNA0ea8aWSqxZDUaPgxYrX2YLN7XbQnf0VKLcovy6kyW7Elgj0P+tn
         6tDmy09OcWkVxrNMwIJ7Nx2rDg3zXtCvs8H+0koNCsmeZoZf+/lp78r8Z+MrlANcaD
         FwCSy5BSdy+/TpdzN8RxPEB+ilPH0oIodLKiNIc4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03RA9ji4031080
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Apr 2020 05:09:45 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 05:09:45 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 05:09:45 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RA9gBX030680;
        Mon, 27 Apr 2020 05:09:43 -0500
Subject: Re: [PATCH 2/3] arm64: dts: ti: k3-j721e-main.dtsi: Add DSS node
To:     Tomi Valkeinen <tomi.valkeinen@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jyri Sarha <jsarha@ti.com>
References: <20200422091512.950-1-tomi.valkeinen@ti.com>
 <20200422091512.950-2-tomi.valkeinen@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <ade3a177-f060-bc40-bcc1-494093e3071d@ti.com>
Date:   Mon, 27 Apr 2020 13:09:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200422091512.950-2-tomi.valkeinen@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/04/2020 12:15, Tomi Valkeinen wrote:
> Add DSS node for J721E SoC.

Subject should drop .dtsi, I can fix that locally though. Got a question 
below.

> 
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 57 +++++++++++++++++++++++
>   1 file changed, 57 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> index 0b9d14b838a1..21c362042ecf 100644
> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
> @@ -736,6 +736,63 @@
>   		};
>   	};
>   
> +	dss: dss@04a00000 {
> +		compatible = "ti,j721e-dss";
> +		reg =
> +			<0x00 0x04a00000 0x00 0x10000>, /* common_m */
> +			<0x00 0x04a10000 0x00 0x10000>, /* common_s0*/
> +			<0x00 0x04b00000 0x00 0x10000>, /* common_s1*/
> +			<0x00 0x04b10000 0x00 0x10000>, /* common_s2*/
> +
> +			<0x00 0x04a20000 0x00 0x10000>, /* vidl1 */
> +			<0x00 0x04a30000 0x00 0x10000>, /* vidl2 */
> +			<0x00 0x04a50000 0x00 0x10000>, /* vid1 */
> +			<0x00 0x04a60000 0x00 0x10000>, /* vid2 */
> +
> +			<0x00 0x04a70000 0x00 0x10000>, /* ovr1 */
> +			<0x00 0x04a90000 0x00 0x10000>, /* ovr2 */
> +			<0x00 0x04ab0000 0x00 0x10000>, /* ovr3 */
> +			<0x00 0x04ad0000 0x00 0x10000>, /* ovr4 */
> +
> +			<0x00 0x04a80000 0x00 0x10000>, /* vp1 */
> +			<0x00 0x04aa0000 0x00 0x10000>, /* vp2 */
> +			<0x00 0x04ac0000 0x00 0x10000>, /* vp3 */
> +			<0x00 0x04ae0000 0x00 0x10000>, /* vp4 */
> +			<0x00 0x04af0000 0x00 0x10000>; /* wb */
> +
> +		reg-names = "common_m", "common_s0",
> +			"common_s1", "common_s2",
> +			"vidl1", "vidl2","vid1","vid2",
> +			"ovr1", "ovr2", "ovr3", "ovr4",
> +			"vp1", "vp2", "vp3", "vp4",
> +			"wb";
> +
> +		clocks =	<&k3_clks 152 0>,
> +				<&k3_clks 152 1>,
> +				<&k3_clks 152 4>,
> +				<&k3_clks 152 9>,
> +				<&k3_clks 152 13>;
> +		clock-names = "fck", "vp1", "vp2", "vp3", "vp4";
> +
> +		power-domains = <&k3_pds 152 TI_SCI_PD_EXCLUSIVE>;
> +
> +		interrupts = <GIC_SPI 602 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 603 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 604 IRQ_TYPE_LEVEL_HIGH>,
> +			     <GIC_SPI 605 IRQ_TYPE_LEVEL_HIGH>;
> +		interrupt-names = "common_m",
> +				  "common_s0",
> +				  "common_s1",
> +				  "common_s2";
> +
> +		status = "disabled";

Again, why disabled by default?

-Tero

> +
> +		dss_ports: ports {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +		};
> +	};
> +
>   	mcasp0: mcasp@2b00000 {
>   		compatible = "ti,am33xx-mcasp-audio";
>   		reg = <0x0 0x02b00000 0x0 0x2000>,
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
