Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0472C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:27:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72840208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 08:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BVjcIP8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgCCI1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 03:27:22 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:35674 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgCCI1V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 03:27:21 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0238R8Lh103139;
        Tue, 3 Mar 2020 02:27:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583224028;
        bh=ZJQqOz2wI0zasjEZOOPF1guyx88S8O3Y/tUjOlGhVig=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=BVjcIP8cAeAFgjwnlJT8gI3/31vfdtYs5+MTqv1YnWzL0r1EI2u070t4HJa0Zne17
         kRwXL9VgIV7eGB1WGEtlgi1M130tW/zmfvE1uV2uicmGOan/txioF4Ez4u8MMdFYDQ
         wYOGARz4iHghgjk9ug/suHo4JdOd2iy5xj7ZDJMs=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0238R86W045029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 Mar 2020 02:27:08 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 3 Mar
 2020 02:27:08 -0600
Received: from localhost.localdomain (10.64.41.19) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 3 Mar 2020 02:27:08 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 0238R4n4019259;
        Tue, 3 Mar 2020 02:27:05 -0600
Subject: Re: dma_mask limited to 32-bits with OF platform device
From:   Roger Quadros <rogerq@ti.com>
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>
CC:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        Vignesh Raghavendra <vigneshr@ti.com>
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com>
 <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
 <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com>
 <9bd83815-6f54-2efb-9398-42064f73ab1c@arm.com>
 <20200217132133.GA27134@lst.de> <b3c56884-128e-a7e1-2e09-0e8de3c3512d@ti.com>
 <CAL_JsqLxECRKWG3SoORADtZ-gVbqCHyx9mhGzrCPO+X=--w8AQ@mail.gmail.com>
 <15d0ac5f-4919-5852-cd95-93c24d8bdbb9@ti.com>
 <827fa19d-1990-16bc-33f5-fc82ac0d4a8a@arm.com>
 <3d8ea578-2ecb-1126-3bf0-2dc695687245@ti.com>
Message-ID: <e898cf0a-6f52-8550-c73e-b78bc413bcc7@ti.com>
Date:   Tue, 3 Mar 2020 10:27:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3d8ea578-2ecb-1126-3bf0-2dc695687245@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Robin, Christoph,

On 26/02/2020 13:33, Roger Quadros wrote:
> Hi,
> 
> On 19/02/2020 17:25, Robin Murphy wrote:
>> On 19/02/2020 2:29 pm, Roger Quadros wrote:
>>> Rob,
>>>
>>> On 18/02/2020 19:22, Rob Herring wrote:
>>>> On Tue, Feb 18, 2020 at 2:28 AM Roger Quadros <rogerq@ti.com> wrote:
>>>>>
>>>>> Chrishtoph,
>>>>>
>>>>> The branch works fine for SATA on DRA7 with CONFIG_LPAE once I
>>>>> have the below DT fix.
>>>>>
>>>>> Do you intend to send these fixes to -stable?
>>>>>
>>>>> ------------------------- arch/arm/boot/dts/dra7.dtsi -------------------------
>>>>> index d78b684e7fca..853ecf3cfb37 100644
>>>>> @@ -645,6 +645,8 @@
>>>>>                  sata: sata@4a141100 {
>>>>>                          compatible = "snps,dwc-ahci";
>>>>>                          reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
>>>>> +                       #size-cells = <2>;
>>>>> +                       dma-ranges = <0x00000000 0x00000000 0x1 0x00000000>;
>>>>
>>>> dma-ranges should be in the parent (bus) node, not the device node.
>>>
>>> I didn't understand why.
>>>
>>> There are many devices on the parent bus node and all devices might not have the 32-bit DMA limit
>>> the SATA controller has.
>>>
>>> SATA controller is the bus master and the ATA devices are children of the SATA controller.
>>
>> But SATA is not a memory-mapped bus - in the context of MMIO, the AHCI is the bus-master device, not a bridge or level of interconnect. The DeviceTree spec[1] clearly defines dma-ranges as an address translation between a "parent bus" and a "child bus".
>>
>> If in the worst case this address-limited interconnect really only exists between the AHCI's master interface and everything else in the system, then you'll have to describe it explicitly to meet DT's expectation of a "bus" (e.g. [2]). Yes, it's a bit clunky, but any scheme has its edge cases.
>>
>>>  From Documentation/devicetree/booting-without-of.txt
>>>
>>> * DMA Bus master
>>> Optional property:
>>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
>>>          (child-bus-address, parent-bus-address, length). Each triplet specified
>>>          describes a contiguous DMA address range.
>>>          The dma-ranges property is used to describe the direct memory access (DMA)
>>>          structure of a memory-mapped bus whose device tree parent can be accessed
>>>          from DMA operations originating from the bus. It provides a means of
>>>          defining a mapping or translation between the physical address space of
>>>          the bus and the physical address space of the parent of the bus.
>>>          (for more information see the Devicetree Specification)
>>>
>>> * DMA Bus child
>>> Optional property:
>>> - dma-ranges: <empty> value. if present - It means that DMA addresses
>>>          translation has to be enabled for this device.
>>
>> Disregarding that this was apparently never in ePAPR, so not grandfathered in to DTSpec, and effectively nobody ever has actually followed it (oh, if only...), note "<empty>" - that still doesn't imply that a *non-empty* dma-ranges would be valid on device nodes.
>>
>> Robin.
>>
>> [1] https://www.devicetree.org/specifications/
>> [2] https://lore.kernel.org/lkml/20181010120737.30300-20-laurentiu.tudor@nxp.com/
> 
> With the patch (in the end). dev->bus_dma_limit is still set to 0 and so is not being used.
> 
> from of_dma_configure()
>          ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
> ...
>          /* ...but only set bus limit if we found valid dma-ranges earlier */
>          if (!ret)
>                  dev->bus_dma_limit = end;
> 
> There is no other place bus_dma_limit is set. Looks like every device should inherit that
> from it's parent right?

Any ideas how to expect this to work?

> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 64a0f90f5b52..5418c31d4da7 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -680,15 +680,22 @@
>           };
> 
>           /* OCP2SCP3 */
> -        sata: sata@4a141100 {
> -            compatible = "snps,dwc-ahci";
> -            reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
> -            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> -            phys = <&sata_phy>;
> -            phy-names = "sata-phy";
> -            clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
> -            ti,hwmods = "sata";
> -            ports-implemented = <0x1>;
> +        sata_aux_bus {
> +            #address-cells = <2>;
> +            #size-cells = <2>;
> +            compatible = "simple-bus";
> +            ranges = <0x0 0x0 0x4a140000 0x0 0x1200>;
> +            dma-ranges = <0x0 0x0 0x0 0x0 0x1 0x00000000>;
> +            sata: sata@4a141100 {
> +                compatible = "snps,dwc-ahci";
> +                reg = <0x0 0x0 0x0 0x1100>, <0x0 0x1100 0x0 0x7>;
> +                interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
> +                phys = <&sata_phy>;
> +                phy-names = "sata-phy";
> +                clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
> +                ti,hwmods = "sata";
> +                ports-implemented = <0x1>;
> +            };
>           };
> 
>           /* OCP2SCP1 */
> 

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
