Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97297C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E57A2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 11:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lDqZJOow"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCSLcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 07:32:36 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57908 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbgCSLcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 07:32:36 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02JBWYie039016;
        Thu, 19 Mar 2020 06:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584617554;
        bh=ku+SXfUtiEPt/RRJyiXB55ygGUXJdm2rEMXxzuG3T7U=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=lDqZJOowIH/oOw82O3cHSRafck9PJMUWj1U18frjPU5RFfq1+m1+96NJDJ4Yc6tw5
         amovR4wjO7sR21x8jxxY2j6BJzEZzu+pBe2PtZg/7oXQHpRX5X36tY96gcSIhB5/7Q
         fpgZosJOj0Z3p7TJF/0n5GPBDQaNUwcRqTHBkOFE=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JBWY1T074453;
        Thu, 19 Mar 2020 06:32:34 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 19
 Mar 2020 06:32:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 19 Mar 2020 06:32:33 -0500
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02JBWUk9099128;
        Thu, 19 Mar 2020 06:32:31 -0500
Subject: Re: [PATCH v2 3/6] arm64: dts: ti: k3-j721e-main: Add serdes_ln_ctrl
 node to select SERDES lane mux
To:     Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>
CC:     <t-kristo@ti.com>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200303101722.26052-1-rogerq@ti.com>
 <20200303101722.26052-4-rogerq@ti.com> <20200310210904.GA11275@bogus>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <247a115e-6b44-2906-07cf-771236d492d6@ti.com>
Date:   Thu, 19 Mar 2020 17:07:14 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310210904.GA11275@bogus>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 11/03/20 2:39 am, Rob Herring wrote:
> On Tue, Mar 03, 2020 at 12:17:19PM +0200, Roger Quadros wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Add serdes_ln_ctrl node used for selecting SERDES lane mux.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 27 ++++++++++++
>>  include/dt-bindings/mux/mux-j721e-wiz.h   | 53 +++++++++++++++++++++++
>>  2 files changed, 80 insertions(+)
>>  create mode 100644 include/dt-bindings/mux/mux-j721e-wiz.h
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
>> index cbaadee5bfdc..c5d54af37e91 100644
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
>> @@ -19,6 +21,31 @@
>>  		};
>>  	};
>>  
>> +	scm_conf: scm-conf@100000 {
>> +		compatible = "syscon", "simple-mfd", "ti,j721e-system-controller";
> 
> Wrong ordering. Most significant first.
> 
>> +		reg = <0 0x00100000 0 0x1c000>;
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x0 0x00100000 0x1c000>;
>> +
>> +		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
> 
> Your syscon.yaml change is not valid if you have child nodes. Do a 
> specific binding for this block.

Do you mean in addition to having platform specific binding for
scm-conf, I need to have platform specific binding for serdes-ln-ctrl.

Since the driver doesn't do any platform specific stuff, the driver
doesn't have to change. Is that correct?

Thanks
Kishon
> 
>> +			compatible = "mmio-mux";
>> +			reg = <0x00004080 0x50>;
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
