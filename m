Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E828CC55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C826F21569
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 07:03:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TPKfetaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgDWHDV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 03:03:21 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36038 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726254AbgDWHDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 03:03:20 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03N73I2Z098273;
        Thu, 23 Apr 2020 02:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587625398;
        bh=wHkNrNpLwPyDidLzLh0cr2HlLzONahMMqBFlRlGS2a4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TPKfetaHcEPUvDfcMoiZjjdYg2GvafzdAM8VTjrfDmfT7wY+F+Dn0Vr4NumTaHImX
         DqaFvUmt7X0Wkr4AidY50QgT7bQTLl+VKcCUsI75scT16p80UMcXYUqbikntcsjKOI
         FcEb2VZWD0GqekNBU3ZyXpQHE9l6ctSy6R3Sb8D4=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03N73IJw042644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Apr 2020 02:03:18 -0500
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 02:03:17 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 02:03:17 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03N73FiI013793;
        Thu, 23 Apr 2020 02:03:16 -0500
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl
 node to select SERDES lane mux
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>
CC:     <t-kristo@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200303101722.26052-1-rogerq@ti.com>
 <20200303101722.26052-4-rogerq@ti.com> <20200310210904.GA11275@bogus>
 <247a115e-6b44-2906-07cf-771236d492d6@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <6940e725-aebc-dcc6-7b25-1026b9b3c653@ti.com>
Date:   Thu, 23 Apr 2020 10:03:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <247a115e-6b44-2906-07cf-771236d492d6@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon, Rob,

On 19/03/2020 13:37, Kishon Vijay Abraham I wrote:
> Hi Rob,
> 
> On 11/03/20 2:39 am, Rob Herring wrote:
>> On Tue, Mar 03, 2020 at 12:17:19PM +0200, Roger Quadros wrote:
>>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>>
>>> Add serdes_ln_ctrl node used for selecting SERDES lane mux.
>>>
>>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>> ---
>>>   arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 27 ++++++++++++
>>>   include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
>>>   2 files changed, 80 insertions(+)
>>>   create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
>>>
>>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> index cbaadee5bfdc..c5d54af37e91 100644
>>> --- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> +++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>>> @@ -5,6 +5,8 @@
>>>    * Copyright (C) 2016-2019 Texas Instruments Incorporated - http://www.ti.com/
>>>    */
>>>   #include <dt-bindings/phy/phy.h>
>>> +#include <dt-bindings/mux/mux.h>
>>> +#include <dt-bindings/mux/mux-j721e-wiz.h>
>>>   
>>>   &cbass_main {
>>>   	msmc_ram: sram@70000000 {
>>> @@ -19,6 +21,31 @@
>>>   		};
>>>   	};
>>>   
>>> +	scm_conf: scm-conf@100000 {
>>> +		compatible = "syscon", "simple-mfd", "ti,j721e-system-controller";
>>
>> Wrong ordering. Most significant first.
>>
>>> +		reg = <0 0x00100000 0 0x1c000>;
>>> +		#address-cells = <1>;
>>> +		#size-cells = <1>;
>>> +		ranges = <0x0 0x0 0x00100000 0x1c000>;
>>> +
>>> +		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
>>
>> Your syscon.yaml change is not valid if you have child nodes. Do a
>> specific binding for this block.
> 
> Do you mean in addition to having platform specific binding for
> scm-conf, I need to have platform specific binding for serdes-ln-ctrl.
> 
> Since the driver doesn't do any platform specific stuff, the driver
> doesn't have to change. Is that correct?
> 

Any resolution on this?

cheers,
-roger

> Thanks
> Kishon
>>
>>> +			compatible = "mmio-mux";
>>> +			reg = <0x00004080 0x50>;
>>> +			#mux-control-cells = <1>;
>>> +			mux-reg-masks = <0x4080 0x3>, <0x4084 0x3>, /* SERDES0 lane0/1 select */
>>> +					<0x4090 0x3>, <0x4094 0x3>, /* SERDES1 lane0/1 select */
>>> +					<0x40a0 0x3>, <0x40a4 0x3>, /* SERDES2 lane0/1 select */
>>> +					<0x40b0 0x3>, <0x40b4 0x3>, /* SERDES3 lane0/1 select */
>>> +					<0x40c0 0x3>, <0x40c4 0x3>, <0x40c8 0x3>, <0x40cc 0x3>;
>>> +					/* SERDES4 lane0/1/2/3 select */
>>> +			idle-states = <SERDES0_LANE0_PCIE0_LANE0>, <SERDES0_LANE1_PCIE0_LANE1>,
>>> +				      <SERDES1_LANE0_PCIE1_LANE0>, <SERDES1_LANE1_PCIE1_LANE1>,
>>> +				      <SERDES2_LANE0_PCIE2_LANE0>, <SERDES2_LANE1_PCIE2_LANE1>,
>>> +				      <MUX_IDLE_AS_IS>, <SERDES3_LANE1_USB3_0>,
>>> +				      <SERDES4_LANE0_EDP_LANE0>, <SERDES4_LANE1_EDP_LANE1>, <SERDES4_LANE2_EDP_LANE2>, <SERDES4_LANE3_EDP_LANE3>;
>>> +		};
>>> +	};
>>> +
>>>   	gic500: interrupt-controller@1800000 {
>>>   		compatible = "arm,gic-v3";
>>>   		#address-cells = <2>;
>>> diff --git a/include/dt-bindings/mux/mux-j721e-wiz.h b/include/dt-bindings/mux/mux-j721e-wiz.h
>>> new file mode 100644
>>> index 000000000000..fd1c4ea9fc7f
>>> --- /dev/null
>>> +++ b/include/dt-bindings/mux/mux-j721e-wiz.h
>>> @@ -0,0 +1,53 @@
>>> +/* SPDX-License-Identifier: GPL-2.0 */
>>> +/*
>>> + * This header provides constants for J721E WIZ.
>>> + */
>>> +
>>> +#ifndef _DT_BINDINGS_J721E_WIZ
>>> +#define _DT_BINDINGS_J721E_WIZ
>>> +
>>> +#define SERDES0_LANE0_QSGMII_LANE1	0x0
>>> +#define SERDES0_LANE0_PCIE0_LANE0	0x1
>>> +#define SERDES0_LANE0_USB3_0_SWAP	0x2
>>> +
>>> +#define SERDES0_LANE1_QSGMII_LANE2	0x0
>>> +#define SERDES0_LANE1_PCIE0_LANE1	0x1
>>> +#define SERDES0_LANE1_USB3_0		0x2
>>> +
>>> +#define SERDES1_LANE0_QSGMII_LANE3	0x0
>>> +#define SERDES1_LANE0_PCIE1_LANE0	0x1
>>> +#define SERDES1_LANE0_USB3_1_SWAP	0x2
>>> +#define SERDES1_LANE0_SGMII_LANE0	0x3
>>> +
>>> +#define SERDES1_LANE1_QSGMII_LANE4	0x0
>>> +#define SERDES1_LANE1_PCIE1_LANE1	0x1
>>> +#define SERDES1_LANE1_USB3_1		0x2
>>> +#define SERDES1_LANE1_SGMII_LANE1	0x3
>>> +
>>> +#define SERDES2_LANE0_PCIE2_LANE0	0x1
>>> +#define SERDES2_LANE0_SGMII_LANE0	0x3
>>> +#define SERDES2_LANE0_USB3_1_SWAP	0x2
>>> +
>>> +#define SERDES2_LANE1_PCIE2_LANE1	0x1
>>> +#define SERDES2_LANE1_USB3_1		0x2
>>> +#define SERDES2_LANE1_SGMII_LANE1	0x3
>>> +
>>> +#define SERDES3_LANE0_PCIE3_LANE0	0x1
>>> +#define SERDES3_LANE0_USB3_0_SWAP	0x2
>>> +
>>> +#define SERDES3_LANE1_PCIE3_LANE1	0x1
>>> +#define SERDES3_LANE1_USB3_0		0x2
>>> +
>>> +#define SERDES4_LANE0_EDP_LANE0		0x0
>>> +#define SERDES4_LANE0_QSGMII_LANE5	0x2
>>> +
>>> +#define SERDES4_LANE1_EDP_LANE1		0x0
>>> +#define SERDES4_LANE1_QSGMII_LANE6	0x2
>>> +
>>> +#define SERDES4_LANE2_EDP_LANE2		0x0
>>> +#define SERDES4_LANE2_QSGMII_LANE7	0x2
>>> +
>>> +#define SERDES4_LANE3_EDP_LANE3		0x0
>>> +#define SERDES4_LANE3_QSGMII_LANE8	0x2
>>> +
>>> +#endif /* _DT_BINDINGS_J721E_WIZ */
>>> -- 
>>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>>

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
