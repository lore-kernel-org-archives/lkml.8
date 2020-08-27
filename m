Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE01FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80743206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 04:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZKbmqOiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgH0Ek3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:40:29 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42028 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgH0Ek2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 00:40:28 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07R4eN0b000850;
        Wed, 26 Aug 2020 23:40:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598503223;
        bh=CunYejyhUbX9RqJPQDf6B96mnxmnWLZcPMUj0gOvnRM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZKbmqOiqUaNDOzhYTi0spuF5mpBtlFT23XdxKWorR0FChizdZldclwQ4GeC9RY0gO
         eZG2PnNUvVeFcy9Mru1GQ6atTce/uf/3/pTAmBnHdaNfNaX3NvASM0RPUMsRK3dcXA
         G8cLFknCnPjbte5BxWmoGc1bmwcYB9YYCtVvg7WM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 07R4eN0H074294
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 26 Aug 2020 23:40:23 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 26
 Aug 2020 23:40:23 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 26 Aug 2020 23:40:23 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07R4eGx8047454;
        Wed, 26 Aug 2020 23:40:19 -0500
Subject: Re: [PATCH 1/4] dt-bindings: arm: ti: Add bindings for J7200 SoC
To:     Nishanth Menon <nmenon@kernel.org>
CC:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>
References: <20200723084628.19241-1-lokeshvutla@ti.com>
 <20200723084628.19241-2-lokeshvutla@ti.com>
 <20200827002318.fumzb3w7ekciffua@ogun.localdomain>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <9650cb95-0c08-c0a5-8a21-7bba3f361f2c@ti.com>
Date:   Thu, 27 Aug 2020 10:10:16 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200827002318.fumzb3w7ekciffua@ogun.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nishanth,

On 27/08/20 5:53 am, Nishanth Menon wrote:
> On 14:16-20200723, Lokesh Vutla wrote:
>> The J7200 SoC is a part of the K3 Multicore SoC architecture platform.
>> It is targeted for automotive gateway, vehicle compute systems,
>> Vehicle-to-Vehicle (V2V) and Vehicle-to-Everything (V2X) applications.
>> The SoC aims to meet the complex processing needs of modern embedded
>> products.
>>
>> Some highlights of this SoC are:
>> * Dual Cortex-A72s in a single cluster, two clusters of lockstep
>>   capable dual Cortex-R5F MCUs and a Centralized Device Management and
>>   Security Controller (DMSC).
>> * Configurable L3 Cache and IO-coherent architecture with high data
>>   throughput capable distributed DMA architecture under NAVSS.
>> * Integrated Ethernet switch supporting up to a total of 4 external ports
>>   in addition to legacy Ethernet switch of up to 2 ports.
>> * Upto 1 PCIe-GEN3 controller, 1 USB3.0 Dual-role device subsystems,
>>   20 MCANs, 3 McASP, eMMC and SD, OSPI/HyperBus memory controller, I3C and
>>   I2C, eCAP/eQEP, eHRPWM among other peripherals.
>> * One hardware accelerator block containing AES/DES/SHA/MD5 called SA2UL
>>   management.
>>
>> See J7200 Technical Reference Manual (SPRUIU1, June 2020)
>> for further details: https://www.ti.com/lit/pdf/spruiu1
>>
>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>> ---
>>  Documentation/devicetree/bindings/arm/ti/k3.txt | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/ti/k3.txt b/Documentation/devicetree/bindings/arm/ti/k3.txt
>> index 333e7256126a..33419cce0afa 100644
>> --- a/Documentation/devicetree/bindings/arm/ti/k3.txt
>> +++ b/Documentation/devicetree/bindings/arm/ti/k3.txt
>> @@ -16,6 +16,9 @@ architecture it uses, using one of the following compatible values:
>>  - J721E
>>    compatible = "ti,j721e";
>>  
>> +- J7200
>> +  compatible = "ti,j7200";
>> +
>>  Boards
>>  ------
> 
> Lets convert the k3.txt to k3.yaml before we do anything more here.
> Looking at the full series, I see that there are pending comments from

okay, I can switch Patch 1 and 2.

> Grygorii as well which needs to be looked at. I have'nt seen a follow up
> version since this version.

Grygorii replied to the same asking to ignore his mail[0]

[0] https://patchwork.kernel.org/cover/11680441/

Thanks and regards,
Lokesh

> 
> [1] https://lore.kernel.org/linux-arm-kernel/20200723084628.19241-1-lokeshvutla@ti.com/
> 
