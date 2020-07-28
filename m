Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB2BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09CED2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:50:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mlnXTw+2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728286AbgG1Tu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:50:28 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:45068 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728186AbgG1Tu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:50:27 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06SJoN7k056445;
        Tue, 28 Jul 2020 14:50:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1595965823;
        bh=vndVmTjUvX37x7lnwXOgQn4F7LqU8AZ1PGj455zmUWo=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=mlnXTw+2asqVvtdBgXgAiB7Oe85zfQi/68pWUqjP6FuTqznFLPN/KNE5UBSg4noGc
         kuQxcRkp1Hon534GPqrZPSU4ugEoc2KJ/pSBVYK5PjC2AIk6XMPDgmVtRu3pVY92TZ
         BI5/AqBYrtHi7nomZXXK8msh7ysI+t+cdZ0hDzz4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SJoNtd120436;
        Tue, 28 Jul 2020 14:50:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 28
 Jul 2020 14:50:23 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 28 Jul 2020 14:50:23 -0500
Received: from [10.250.34.248] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06SJoNYA003390;
        Tue, 28 Jul 2020 14:50:23 -0500
Subject: Re: [PATCH 3/4] arm64: dts: ti: Add support for J7200 SoC
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
 <20200723084628.19241-4-lokeshvutla@ti.com>
 <36788bae-ddcd-a880-ea34-a4919945009c@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <a2ebf3ea-440d-b2b1-25b6-f4e808058405@ti.com>
Date:   Tue, 28 Jul 2020 14:50:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <36788bae-ddcd-a880-ea34-a4919945009c@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Grygorii,

On 7/28/20 2:16 PM, Grygorii Strashko wrote:
> 
> 
> On 23/07/2020 11:46, Lokesh Vutla wrote:
>> The J7200 SoC is a part of the K3 Multicore SoC architecture platform.
>> It is targeted for automotive gateway, vehicle compute systems,
>> Vehicle-to-Vehicle (V2V) and Vehicle-to-Everything (V2X) applications.
>> The SoC aims to meet the complex processing needs of modern embedded
>> products.
>>
>> Some highlights of this SoC are:
>> * Dual Cortex-A72s in a single cluster, two clusters of lockstep
>>    capable dual Cortex-R5F MCUs and a Centralized Device Management and
>>    Security Controller (DMSC).
>> * Configurable L3 Cache and IO-coherent architecture with high data
>>    throughput capable distributed DMA architecture under NAVSS.
>> * Integrated Ethernet switch supporting up to a total of 4 external ports
>>    in addition to legacy Ethernet switch of up to 2 ports.
>> * Upto 1 PCIe-GEN3 controller, 1 USB3.0 Dual-role device subsystems,
>>    20 MCANs, 3 McASP, eMMC and SD, OSPI/HyperBus memory controller, I3C
>>    and I2C, eCAP/eQEP, eHRPWM among other peripherals.
>> * One hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>>    management.
>>
>> See J7200 Technical Reference Manual (SPRUIU1, June 2020)
>> for further details: https://www.ti.com/lit/pdf/spruiu1
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>   arch/arm64/boot/dts/ti/k3-j7200-main.dtsi     | 199 ++++++++++++++++++
>>   .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      |  84 ++++++++
>>   arch/arm64/boot/dts/ti/k3-j7200.dtsi          | 165 +++++++++++++++
>>   3 files changed, 448 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi
>>   create mode 100644 arch/arm64/boot/dts/ti/k3-j7200.dtsi
>>
>> diff --git a/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi 
>> b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> new file mode 100644
>> index 000000000000..70c8f7e941fb
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/ti/k3-j7200-main.dtsi
>> @@ -0,0 +1,199 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Device Tree Source for J7200 SoC Family Main Domain peripherals
>> + *
>> + * Copyright (C) 2020 Texas Instruments Incorporated - 
>> https://www.ti.com/
>> + */
>> +
>> +&cbass_main {
>> +    msmc_ram: sram@70000000 {
>> +        compatible = "mmio-sram";
>> +        reg = <0x0 0x70000000 0x0 0x100000>;
>> +        #address-cells = <1>;
>> +        #size-cells = <1>;
>> +        ranges = <0x0 0x0 0x70000000 0x100000>;
>> +
>> +        atf-sram@0 {
>> +            reg = <0x0 0x20000>;
>> +        };
>> +    };
>> +
>> +    gic500: interrupt-controller@1800000 {
>> +        compatible = "arm,gic-v3";
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges;
>> +        #interrupt-cells = <3>;
>> +        interrupt-controller;
>> +        reg = <0x00 0x01800000 0x00 0x10000>,    /* GICD */
>> +              <0x00 0x01900000 0x00 0x100000>;    /* GICR */
>> +
>> +        /* vcpumntirq: virtual CPU interface maintenance interrupt */
>> +        interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
>> +
>> +        gic_its: msi-controller@1820000 {
>> +            compatible = "arm,gic-v3-its";
>> +            reg = <0x00 0x01820000 0x00 0x10000>;
>> +            socionext,synquacer-pre-its = <0x1000000 0x400000>;
>> +            msi-controller;
>> +            #msi-cells = <1>;
>> +        };
>> +    };
>> +
>> +    main_navss: navss@30000000 {
>> +        compatible = "simple-mfd";
>> +        #address-cells = <2>;
>> +        #size-cells = <2>;
>> +        ranges = <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>;
> 
> Can we return back
> ti,sci-dev-id = <199>;
> 
> here? it's needed for DMA PSI-L pairing.

Oh, I wasn't aware of this. Lokesh removed it based on my earlier 
comments. Is this used by more than one driver? Anytime you see a 
ti,sci-dev-id, you would also expect to see the ti,sci reference in 
general for that driver to really leverage it.

The lack of a specific binding for this node also makes one think it is 
not needed.

> 
> Option: add it as part of dma/net submission.

Yeah, I think we should go with this approach on upstream if we aren't 
respinning the series. Any reason, this couldn't be added to the udma 
node itself?

regards
Suman
