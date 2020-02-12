Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81516C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:33:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5761E20848
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="fQ9k0Btk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBLMdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:33:39 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57824 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgBLMdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:33:39 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01CCXLmU030105;
        Wed, 12 Feb 2020 06:33:21 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1581510801;
        bh=K6qgJbEP26dBLKsUCBT4QaNFX+1T9GJLT3p+5OtjdJc=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=fQ9k0BtkRw75in41sn6sjUZTHDp5MptGKy6A/3EAGQ9+fPf9SKaWV00a395AQIEO8
         yVW0R5lxS+FaK4tMtQx1Ax+9Tv8x3EMYajIALoUMcvPpbsV+lNfslGin1dzlOqYe0j
         UTfSadygqQV5UqidUh9JGq5GOsrNqXJRSKOADlA4=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CCXLBB042817;
        Wed, 12 Feb 2020 06:33:21 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 12
 Feb 2020 06:33:21 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 12 Feb 2020 06:33:21 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01CCXH2C001262;
        Wed, 12 Feb 2020 06:33:18 -0600
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>
CC:     <stefan.wahren@i2se.com>, <afaerber@suse.de>, <hverkuil@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>
References: <c1c75923-3094-d3fc-fe8e-ee44f17b1a0a@ti.com>
 <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <56314192-f3c6-70c5-6b9a-3d580311c326@ti.com>
Date:   Wed, 12 Feb 2020 14:33:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <3a91f306-f544-a63c-dfe2-7eae7b32bcca@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/02/2020 13:37, Robin Murphy wrote:
> On 2020-02-12 10:49 am, Roger Quadros wrote:
>> Hi,
>>
>> I'd like to understand why of_dma_configure() is limiting the dma and coherent masks
>> instead of overriding them.
>>
>> see commits
>> a5516219b102 ("of/platform: Initialise default DMA masks")
>> ee7b1f31200d ("of: fix DMA mask generation")
>>
>> In of_platform_device_create_pdata(), we initialize both masks to 32-bits unconditionally,
>> which is fine to support legacy cases.
>>
>>      dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>>          if (!dev->dev.dma_mask)
>>                  dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
>>
>> Then in of_dma_configure() we limit it like so.
>>
>>          dev->coherent_dma_mask &= mask;
>>          *dev->dma_mask &= mask;
>>
>> This way, legitimate devices which correctly set dma-ranges in DT
>> will never get a dma_mask above 32-bits at all. How is this expected to work?
> 
> Because these are still just the *default* masks - although drivers are all expected to call dma_set_mask() and friends explicitly nowadays, there are sure to be some out there for 32-bit devices still assuming the default 32-bit masks are in place. Thus if platform code secretly makes them larger, Bad Things ensue. Making them *smaller* where there are platform limitations shouldn't really matter now that we have the bus_dma_limit mechanism working well, but also doesn't do any harm, so it was left in for good measure.
> 
> The current paradigm is that the device masks represent the inherent capability of the device as far as the driver knows, and external interconnect constraints are kept separately as private DMA API internals via the bus limit.
> 
>> For a test, I added this in dra7.dtsi sata node. (NOTE: CONFIG_ARM_LPAE=y)
>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 93aa65c75b45..cd8c6cea23d5 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -571,6 +571,8 @@
>>           sata: sata@4a141100 {
>>               compatible = "snps,dwc-ahci";
>>               reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
>> +            #size-cells = <2>;
>> +            dma-ranges = <0x00000000 0x00000000 0x10 0x00000000>;
>>               interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>>               phys = <&sata_phy>;
>>               phy-names = "sata-phy";
>>
>> ----------------------------- drivers/of/device.c -----------------------------
>> index e9127db7b067..1072cebad57a 100644
>> @@ -95,6 +95,7 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>>       const struct iommu_ops *iommu;
>>       u64 mask, end;
>>
>> +    dev_info(dev, "of_dma_configure\n");
>>       ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>       if (ret < 0) {
>>           /*
>> @@ -123,7 +124,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>>               dev_err(dev, "Adjusted size 0x%llx invalid\n", size);
>>               return -EINVAL;
>>           }
>> -        dev_dbg(dev, "dma_pfn_offset(%#08lx)\n", offset);
>> +        dev_info(dev, "dma %llx paddr %llx size %llx\n", dma_addr, paddr, size);
>> +        dev_info(dev, "dma_pfn_offset(%#08lx)\n", offset);
>>       }
>>
>>       /*
>> @@ -152,6 +154,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
>>       mask = DMA_BIT_MASK(ilog2(end) + 1);
>>       dev->coherent_dma_mask &= mask;
>>       *dev->dma_mask &= mask;
>> +
>> +    dev_info(dev, "end %llx, mask %llx\n", end, mask);
>>       /* ...but only set bus limit if we found valid dma-ranges earlier */
>>       if (!ret)
>>           dev->bus_dma_limit = end;
>>
>> And I see.
>>
>> [    1.134294]  4a140000.sata: of_platform
>> [   13.203917] ahci 4a140000.sata: of_dma_configure
>> [   13.225635] ahci 4a140000.sata: dma 0 paddr 0 size 1000000000
>> [   13.266178] ahci 4a140000.sata: dma_pfn_offset(0x000000)
>> [   13.297621] ahci 4a140000.sata: end fffffffff, mask fffffffff
>> [   13.585499] ahci 4a140000.sata: dma_mask 0xffffffff, coherent_mask 0xffffffff
>> [   13.599082] ahci 4a140000.sata: setting 64-bit mask ffffffffffffffff
>>
>> Truncation of dma_mask and coherent_mask is undesired in this case.
> 
> Again, it's only the initial default masks that are truncated, and the driver appropriately replaces them with its 64-bit masks anyway once it probes. However, bus_dma_limit should still reflect that 36-bit upstream constraint, and that's what really matters. If you've found a path through a DMA API implementation which is subsequently failing to respect that limit, that's a bug in that implementation.
> 

For now, let's say that we limit dma-ranges to 4GB size. with "dma-ranges = <0x00000000 0x00000000 0x1 0x00000000>;"
Then, dma_bus_limit is set correctly to 0xffffffff, SATA driver sets masks to 64-bit as IP supports that.

[   13.306847] ahci 4a140000.sata: dma_mask 0xffffffffffffffff, coherent_mask 0xffffffffffffffff, dma_bus_limit 0xffffffff

However, the SATA controller still tries to do DMA above 32-bits.
dma_alloc() doesn't seem to be taking dma_bus_limit into account?

>> How about fixing it like so?
>>
>> -     dev->coherent_dma_mask &= mask;
>> -    *dev->dma_mask &= mask;
>> +     dev->coherent_dma_mask = mask;
>> +     *dev->dma_mask = mask;
> 
> As above, making the "32-bit default" larger than 32 bits stands to break 32-bit devices with old drivers, and there's nothing to "fix" at this point anyway.
> 
>> Also this comment doesn't make sense anymore?
>>
>>          /*
>>           * Limit coherent and dma mask based on size and default mask
>>           * set by the driver.
>>           */
> 
> TBH that's never made much sense, unless "driver" was supposed to refer to bus code. Its continued presence is down to inertia more than any other reason :)
> 
> Robin.

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
