Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C85BC34051
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C5C42176D
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 14:29:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="M2b7jxAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727973AbgBSO3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 09:29:37 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:42204 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgBSO3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 09:29:37 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01JETO18039703;
        Wed, 19 Feb 2020 08:29:24 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582122564;
        bh=We7nvfpRqSLcKVgr+VzwP/JnzIrFTf8St4dXLUroBqM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=M2b7jxAkvjhmjSTqvA/H9j6yCx0Snsx38uP9U/Kir7rGkrmtbmRmUjw13a19ZAaUX
         ScrlHLKO+t/K6lgeMrbvfiOqCaDVOmuwQQ7OS0mHz27q1RLqP7vP8L5geh7XLQSVy6
         BTW/3OxGeVsW4RouwIypjMzjQAFl+4b+2/v39itU=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01JETOHr099749
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 08:29:24 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 08:29:23 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 08:29:23 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01JETKXJ008768;
        Wed, 19 Feb 2020 08:29:21 -0600
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Rob Herring <robh+dt@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
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
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <15d0ac5f-4919-5852-cd95-93c24d8bdbb9@ti.com>
Date:   Wed, 19 Feb 2020 16:29:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLxECRKWG3SoORADtZ-gVbqCHyx9mhGzrCPO+X=--w8AQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rob,

On 18/02/2020 19:22, Rob Herring wrote:
> On Tue, Feb 18, 2020 at 2:28 AM Roger Quadros <rogerq@ti.com> wrote:
>>
>> Chrishtoph,
>>
>> The branch works fine for SATA on DRA7 with CONFIG_LPAE once I
>> have the below DT fix.
>>
>> Do you intend to send these fixes to -stable?
>>
>> ------------------------- arch/arm/boot/dts/dra7.dtsi -------------------------
>> index d78b684e7fca..853ecf3cfb37 100644
>> @@ -645,6 +645,8 @@
>>                  sata: sata@4a141100 {
>>                          compatible = "snps,dwc-ahci";
>>                          reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
>> +                       #size-cells = <2>;
>> +                       dma-ranges = <0x00000000 0x00000000 0x1 0x00000000>;
> 
> dma-ranges should be in the parent (bus) node, not the device node.

I didn't understand why.

There are many devices on the parent bus node and all devices might not have the 32-bit DMA limit
the SATA controller has.

SATA controller is the bus master and the ATA devices are children of the SATA controller.

 From Documentation/devicetree/booting-without-of.txt

* DMA Bus master
Optional property:
- dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
         (child-bus-address, parent-bus-address, length). Each triplet specified
         describes a contiguous DMA address range.
         The dma-ranges property is used to describe the direct memory access (DMA)
         structure of a memory-mapped bus whose device tree parent can be accessed
         from DMA operations originating from the bus. It provides a means of
         defining a mapping or translation between the physical address space of
         the bus and the physical address space of the parent of the bus.
         (for more information see the Devicetree Specification)

* DMA Bus child
Optional property:
- dma-ranges: <empty> value. if present - It means that DMA addresses
         translation has to be enabled for this device.
- dma-coherent: Present if dma operations are coherent



> 
>>                          interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>>                          phys = <&sata_phy>;
>>                          phy-names = "sata-phy";
>>
>>
>> cheers,
>> -roger
>>
>> On 17/02/2020 15:21, Christoph Hellwig wrote:
>>> Roger,
>>>
>>> can you try the branch below and check if that helps?
>>>
>>>       git://git.infradead.org/users/hch/misc.git arm-dma-bus-limit
>>>
>>> Gitweb:
>>>
>>>       http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/arm-dma-bus-limit
>>>
>>
>> --
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
