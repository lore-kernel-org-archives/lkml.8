Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648F9C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33F0124654
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 15:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CVx2Dr9O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgBSPlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 10:41:13 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:36252 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726523AbgBSPlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 10:41:12 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01JFeqVJ105038;
        Wed, 19 Feb 2020 09:40:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582126852;
        bh=ksioNvpS7Q4N+Gx5JNjfHtV4f6UgHXasRqD41emjSHE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CVx2Dr9O0eRLi6KvyeaY08SZxL+d5zQ6Lc+bAfYB4gDKnfgO6I6hLitcuTo2kUg43
         sjEf86PEEYIBSvwq09cNCnKBdTqTKc8/2TZHKesI16CzbpttFzeMOiNQ2R3oaMN7QS
         94/OrAxYw01NqaPJzrMiB8aboUYzTzf9mFvCKti0=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01JFeqOx081270
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 19 Feb 2020 09:40:52 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 19
 Feb 2020 09:40:52 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 19 Feb 2020 09:40:52 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01JFemNk026117;
        Wed, 19 Feb 2020 09:40:49 -0600
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     Christoph Hellwig <hch@lst.de>,
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
 <15d0ac5f-4919-5852-cd95-93c24d8bdbb9@ti.com>
 <827fa19d-1990-16bc-33f5-fc82ac0d4a8a@arm.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <f69835e3-61fd-ec63-1bee-2d69747d106d@ti.com>
Date:   Wed, 19 Feb 2020 17:40:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <827fa19d-1990-16bc-33f5-fc82ac0d4a8a@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/02/2020 17:25, Robin Murphy wrote:
> On 19/02/2020 2:29 pm, Roger Quadros wrote:
>> Rob,
>>
>> On 18/02/2020 19:22, Rob Herring wrote:
>>> On Tue, Feb 18, 2020 at 2:28 AM Roger Quadros <rogerq@ti.com> wrote:
>>>>
>>>> Chrishtoph,
>>>>
>>>> The branch works fine for SATA on DRA7 with CONFIG_LPAE once I
>>>> have the below DT fix.
>>>>
>>>> Do you intend to send these fixes to -stable?
>>>>
>>>> ------------------------- arch/arm/boot/dts/dra7.dtsi -------------------------
>>>> index d78b684e7fca..853ecf3cfb37 100644
>>>> @@ -645,6 +645,8 @@
>>>>                  sata: sata@4a141100 {
>>>>                          compatible = "snps,dwc-ahci";
>>>>                          reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
>>>> +                       #size-cells = <2>;
>>>> +                       dma-ranges = <0x00000000 0x00000000 0x1 0x00000000>;
>>>
>>> dma-ranges should be in the parent (bus) node, not the device node.
>>
>> I didn't understand why.
>>
>> There are many devices on the parent bus node and all devices might not have the 32-bit DMA limit
>> the SATA controller has.
>>
>> SATA controller is the bus master and the ATA devices are children of the SATA controller.
> 
> But SATA is not a memory-mapped bus - in the context of MMIO, the AHCI is the bus-master device, not a bridge or level of interconnect. The DeviceTree spec[1] clearly defines dma-ranges as an address translation between a "parent bus" and a "child bus".
> 
> If in the worst case this address-limited interconnect really only exists between the AHCI's master interface and everything else in the system, then you'll have to describe it explicitly to meet DT's expectation of a "bus" (e.g. [2]). Yes, it's a bit clunky, but any scheme has its edge cases.

I understand now. Thanks.

> 
>>  From Documentation/devicetree/booting-without-of.txt
>>
>> * DMA Bus master
>> Optional property:
>> - dma-ranges: <prop-encoded-array> encoded as arbitrary number of triplets of
>>          (child-bus-address, parent-bus-address, length). Each triplet specified
>>          describes a contiguous DMA address range.
>>          The dma-ranges property is used to describe the direct memory access (DMA)
>>          structure of a memory-mapped bus whose device tree parent can be accessed
>>          from DMA operations originating from the bus. It provides a means of
>>          defining a mapping or translation between the physical address space of
>>          the bus and the physical address space of the parent of the bus.
>>          (for more information see the Devicetree Specification)
>>
>> * DMA Bus child
>> Optional property:
>> - dma-ranges: <empty> value. if present - It means that DMA addresses
>>          translation has to be enabled for this device.
> 
> Disregarding that this was apparently never in ePAPR, so not grandfathered in to DTSpec, and effectively nobody ever has actually followed it (oh, if only...), note "<empty>" - that still doesn't imply that a *non-empty* dma-ranges would be valid on device nodes.
> 
> Robin.
> 
> [1] https://www.devicetree.org/specifications/
> [2] https://lore.kernel.org/lkml/20181010120737.30300-20-laurentiu.tudor@nxp.com/

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
