Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218AAC33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC9BC24654
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 05:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="oHAWBpWO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgAUFKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 00:10:16 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42294 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUFKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 00:10:16 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00L5A5UW109643;
        Mon, 20 Jan 2020 23:10:05 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579583405;
        bh=g4km0bHBqi0VKPsKp25oxKkp+0Wceu8TT0XwSBVu6I4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=oHAWBpWOt0ilV21Fv5+aZl2sbF7GMihEBDIM9iz4c2hwls8xx6AM3kqlaxYu4GeMe
         woeev1qpDGmCMudPiFpwl0zaGEspv2M7TBvfE+au6pgZjVacLepQkv8L0Mk6Qo5dd+
         t/O3Vv2MXPVzz7smzDCV011XidPZSiawHLizX6pE=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00L5A5HY056622;
        Mon, 20 Jan 2020 23:10:05 -0600
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 20
 Jan 2020 23:10:04 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 20 Jan 2020 23:10:04 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00L5A1G2057059;
        Mon, 20 Jan 2020 23:10:02 -0600
Subject: Re: [PATCH 2/5] arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl
 node to select SERDES lane mux
To:     Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>
CC:     <t-kristo@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200108111830.8482-1-rogerq@ti.com>
 <20200108111830.8482-3-rogerq@ti.com> <20200115014724.GA20772@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <1c55f0a8-99e3-934f-e8b8-d090df06a12e@ti.com>
Date:   Tue, 21 Jan 2020 10:43:04 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <20200115014724.GA20772@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 15/01/20 7:17 AM, Rob Herring wrote:
> On Wed, Jan 08, 2020 at 01:18:27PM +0200, Roger Quadros wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Add serdes_ln_ctrl node used for selecting SERDES lane mux.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 26 +++++++++++
>>  include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
>>  2 files changed, 79 insertions(+)
>>  create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index 24cb78db28e4..6741c1e67f50 100644
>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> @@ -5,6 +5,8 @@
>>   * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
>>   */
>>  #include <dt-bindings/phy/phy.h>
>> +#include <dt-bindings/mux/mux.h>
>> +#include <dt-bindings/mux/mux-j721e-wiz.h>
>>  
>>  &cbass_main {
>>  	msmc_ram: sram@70000000 {
>> @@ -19,6 +21,30 @@
>>  		};
>>  	};
>>  
>> +	scm_conf: scm_conf@100000 {
> 
> Don't use '_' in node names.

Okay.
> 
>> +		compatible = "syscon", "simple-mfd";
> 
> Needs a specific compatible especially since the child node doesn't have 
> one.

Child node has "mmio-mux" as compatible no? Are you referring to
something else here?
> 
>> +		reg = <0 0x00100000 0 0x1c000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x00100000 0x1c000>;
>> +
>> +		serdes_ln_ctrl: serdes_ln_ctrl@4080 {
> 
> 'reg' is needed if there's a unit-address. If there's a register range 
> with only the mux controls, then add 'reg'.

Sure, will add.


Thanks
Kishon

> 
>> +			compatible = "mmio-mux";
>> +			#mux-control-cells = <1>;
>> +			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
>> +					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
>> +					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
>> +					<0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
>> +					<0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
>> +					/* SERDES4 lane0/1/2/3 select */
>> +			idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
>> +				      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
>> +				      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
>> +				      <MUX_IDLE_AS_IS>, <SERDES3_LANE1_USB3_0>,
>> +				      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
>> +		};
>> +	};
>> +
>>  	gic500: interrupt-controller@1800000 {
>>  		compatible = "arm,gic-v3";
>>  		#address-cells = <2>;
>> diff --git a/include/dt-bindings/mux/mux-j721e-wiz.h b/include/dt-bindings/mux/mux-j721e-wiz.h
>> new file mode 100644
>> index 000000000000..fd1c4ea9fc7f
>> --- /dev/null
>> +++ b/include/dt-bindings/mux/mux-j721e-wiz.h
>> @@ -0,0 +1,53 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This header provides constants for J721E WIZ.
>> + */
>> +
>> +#ifndef _DT_BINDINGS_J721E_WIZ
>> +#define _DT_BINDINGS_J721E_WIZ
>> +
>> +#define SERDES0_LANE0_QSGMII_LANE1	0x0
>> +#define SERDES0_LANE0_PCIE0_LANE0	0x1
>> +#define SERDES0_LANE0_USB3_0_SWAP	0x2
>> +
>> +#define SERDES0_LANE1_QSGMII_LANE2	0x0
>> +#define SERDES0_LANE1_PCIE0_LANE1	0x1
>> +#define SERDES0_LANE1_USB3_0		0x2
>> +
>> +#define SERDES1_LANE0_QSGMII_LANE3	0x0
>> +#define SERDES1_LANE0_PCIE1_LANE0	0x1
>> +#define SERDES1_LANE0_USB3_1_SWAP	0x2
>> +#define SERDES1_LANE0_SGMII_LANE0	0x3
>> +
>> +#define SERDES1_LANE1_QSGMII_LANE4	0x0
>> +#define SERDES1_LANE1_PCIE1_LANE1	0x1
>> +#define SERDES1_LANE1_USB3_1		0x2
>> +#define SERDES1_LANE1_SGMII_LANE1	0x3
>> +
>> +#define SERDES2_LANE0_PCIE2_LANE0	0x1
>> +#define SERDES2_LANE0_SGMII_LANE0	0x3
>> +#define SERDES2_LANE0_USB3_1_SWAP	0x2
>> +
>> +#define SERDES2_LANE1_PCIE2_LANE1	0x1
>> +#define SERDES2_LANE1_USB3_1		0x2
>> +#define SERDES2_LANE1_SGMII_LANE1	0x3
>> +
>> +#define SERDES3_LANE0_PCIE3_LANE0	0x1
>> +#define SERDES3_LANE0_USB3_0_SWAP	0x2
>> +
>> +#define SERDES3_LANE1_PCIE3_LANE1	0x1
>> +#define SERDES3_LANE1_USB3_0		0x2
>> +
>> +#define SERDES4_LANE0_EDP_LANE0		0x0
>> +#define SERDES4_LANE0_QSGMII_LANE5	0x2
>> +
>> +#define SERDES4_LANE1_EDP_LANE1		0x0
>> +#define SERDES4_LANE1_QSGMII_LANE6	0x2
>> +
>> +#define SERDES4_LANE2_EDP_LANE2		0x0
>> +#define SERDES4_LANE2_QSGMII_LANE7	0x2
>> +
>> +#define SERDES4_LANE3_EDP_LANE3		0x0
>> +#define SERDES4_LANE3_QSGMII_LANE8	0x2
>> +
>> +#endif /* _DT_BINDINGS_J721E_WIZ */
>> -- 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
