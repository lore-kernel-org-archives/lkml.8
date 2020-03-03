Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A72C3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 021AC2073D
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 14:06:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729265AbgCCOGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 09:06:19 -0500
Received: from foss.arm.com ([217.140.110.172]:47472 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728901AbgCCOGS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 09:06:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D18FBFEC;
        Tue,  3 Mar 2020 06:06:17 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A93B53F6C4;
        Tue,  3 Mar 2020 06:06:13 -0800 (PST)
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Roger Quadros <rogerq@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Cc:     =?UTF-8?Q?P=c3=a9ter_Ujfalusi?= <peter.ujfalusi@ti.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        "Nori, Sekhar" <nsekhar@ti.com>, "Anna, Suman" <s-anna@ti.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        Hans Verkuil <hverkuil@xs4all.nl>, devicetree@vger.kernel.org,
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
 <e898cf0a-6f52-8550-c73e-b78bc413bcc7@ti.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <98db4748-63cb-79db-50c3-a6a37d624eaa@arm.com>
Date:   Tue, 3 Mar 2020 14:06:12 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <e898cf0a-6f52-8550-c73e-b78bc413bcc7@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/2020 8:27 am, Roger Quadros wrote:
[...]
>> With the patch (in the end). dev->bus_dma_limit is still set to 0 and 
>> so is not being used.
>>
>> from of_dma_configure()
>>          ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>> ...
>>          /* ...but only set bus limit if we found valid dma-ranges 
>> earlier */
>>          if (!ret)
>>                  dev->bus_dma_limit = end;
>>
>> There is no other place bus_dma_limit is set. Looks like every device 
>> should inherit that
>> from it's parent right?
> 
> Any ideas how to expect this to work?

Is of_dma_get_range() actually succeeding, or is it tripping up on some 
aspect of the DT (in which case there should be errors in the log)?

Looking again at the fragment below, are you sure it's correct? It 
appears to me like it might actually be defining a 1-byte-long DMA 
range, which indeed I wouldn't really expect to work.

Robin.

>>
>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>> index 64a0f90f5b52..5418c31d4da7 100644
>> --- a/arch/arm/boot/dts/dra7.dtsi
>> +++ b/arch/arm/boot/dts/dra7.dtsi
>> @@ -680,15 +680,22 @@
>>           };
>>
>>           /* OCP2SCP3 */
>> -        sata: sata@4a141100 {
>> -            compatible = "snps,dwc-ahci";
>> -            reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
>> -            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> -            phys = <&sata_phy>;
>> -            phy-names = "sata-phy";
>> -            clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
>> -            ti,hwmods = "sata";
>> -            ports-implemented = <0x1>;
>> +        sata_aux_bus {
>> +            #address-cells = <2>;
>> +            #size-cells = <2>;
>> +            compatible = "simple-bus";
>> +            ranges = <0x0 0x0 0x4a140000 0x0 0x1200>;
>> +            dma-ranges = <0x0 0x0 0x0 0x0 0x1 0x00000000>;
>> +            sata: sata@4a141100 {
>> +                compatible = "snps,dwc-ahci";
>> +                reg = <0x0 0x0 0x0 0x1100>, <0x0 0x1100 0x0 0x7>;
>> +                interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>> +                phys = <&sata_phy>;
>> +                phy-names = "sata-phy";
>> +                clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
>> +                ti,hwmods = "sata";
>> +                ports-implemented = <0x1>;
>> +            };
>>           };
>>
>>           /* OCP2SCP1 */
>>
> 
