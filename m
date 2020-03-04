Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E814C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:28:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76C0021744
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:28:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yz9OKL/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgCDI2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:28:48 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:50464 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDI2s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:28:48 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0248SW0c007548;
        Wed, 4 Mar 2020 02:28:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583310512;
        bh=oH7grBEwPdlI3HY7/tKeeO0ogpT5E6PPUFVW6ggJMBU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=yz9OKL/+iTlwBnpWqcF2OL9DVUlzbIDrGIkJ82X52343j9Q/7M2FrSTMvlaqkQ/aV
         YnQST8WdlRWVK19gC/qVaINENxyxX5SG9UeU1I3Ao7YSL3Qw5pCzyUHrfLMfBW0UGD
         kO10y7SLV21NuHRmUCMMy2iLGfGA2NLzU+9NXhU4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0248SWWi063029
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 4 Mar 2020 02:28:32 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 02:28:31 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 02:28:31 -0600
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0248SSpV099893;
        Wed, 4 Mar 2020 02:28:29 -0600
Subject: Re: dma_mask limited to 32-bits with OF platform device
To:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
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
 <3d8ea578-2ecb-1126-3bf0-2dc695687245@ti.com>
 <e898cf0a-6f52-8550-c73e-b78bc413bcc7@ti.com>
 <98db4748-63cb-79db-50c3-a6a37d624eaa@arm.com>
 <CAL_Jsq+zx5qkv1DZdj1p2HHz5siYZwv6WGLe1F7xw9b019UWbQ@mail.gmail.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <c753a232-403d-6ed2-89fd-09476c887391@ti.com>
Date:   Wed, 4 Mar 2020 10:28:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+zx5qkv1DZdj1p2HHz5siYZwv6WGLe1F7xw9b019UWbQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 03/03/2020 21:26, Rob Herring wrote:
> On Tue, Mar 3, 2020 at 8:06 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 03/03/2020 8:27 am, Roger Quadros wrote:
>> [...]
>>>> With the patch (in the end). dev->bus_dma_limit is still set to 0 and
>>>> so is not being used.
>>>>
>>>> from of_dma_configure()
>>>>           ret = of_dma_get_range(np, &dma_addr, &paddr, &size);
>>>> ...
>>>>           /* ...but only set bus limit if we found valid dma-ranges
>>>> earlier */
>>>>           if (!ret)
>>>>                   dev->bus_dma_limit = end;
>>>>
>>>> There is no other place bus_dma_limit is set. Looks like every device
>>>> should inherit that
>>>> from it's parent right?
>>>
>>> Any ideas how to expect this to work?
>>
>> Is of_dma_get_range() actually succeeding, or is it tripping up on some
>> aspect of the DT (in which case there should be errors in the log)?
>>

of_dma_get_range() was failing but no errors in the log.

>> Looking again at the fragment below, are you sure it's correct? It
>> appears to me like it might actually be defining a 1-byte-long DMA
>> range, which indeed I wouldn't really expect to work.
> 
> Indeed, though it took me a minute to see why.
> 
>>
>> Robin.
>>
>>>>
>>>> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
>>>> index 64a0f90f5b52..5418c31d4da7 100644
>>>> --- a/arch/arm/boot/dts/dra7.dtsi
>>>> +++ b/arch/arm/boot/dts/dra7.dtsi
>>>> @@ -680,15 +680,22 @@
>>>>            };
>>>>
>>>>            /* OCP2SCP3 */
>>>> -        sata: sata@4a141100 {
>>>> -            compatible = "snps,dwc-ahci";
>>>> -            reg = <0x4a140000 0x1100>, <0x4a141100 0x7>;
> 
> Based on this, the parent address size is 1 cell...
> 
>>>> -            interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>>>> -            phys = <&sata_phy>;
>>>> -            phy-names = "sata-phy";
>>>> -            clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
>>>> -            ti,hwmods = "sata";
>>>> -            ports-implemented = <0x1>;
>>>> +        sata_aux_bus {
>>>> +            #address-cells = <2>;
>>>> +            #size-cells = <2>;
>>>> +            compatible = "simple-bus";
>>>> +            ranges = <0x0 0x0 0x4a140000 0x0 0x1200>;
>>>> +            dma-ranges = <0x0 0x0 0x0 0x0 0x1 0x00000000>;
> 
> So this is:
> child addr: 0x0 0x0
> parent addr: 0x0
> size: 0x0 0x1

Good catch.
So I fixed it to

	dma-ranges = <0x0 0x0 0x0 0x1 0x00000000>;

And now it works :).
Thanks!

> 
> The last cell is just ignored I guess if you aren't seeing any errors.
> We check this in dtc for ranges, but not dma-ranges. So I'm fixing
> that.

Great!

> 
>>>> +            sata: sata@4a141100 {
>>>> +                compatible = "snps,dwc-ahci";
>>>> +                reg = <0x0 0x0 0x0 0x1100>, <0x0 0x1100 0x0 0x7>;
>>>> +                interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
>>>> +                phys = <&sata_phy>;
>>>> +                phy-names = "sata-phy";
>>>> +                clocks = <&l3init_clkctrl DRA7_L3INIT_SATA_CLKCTRL 8>;
>>>> +                ti,hwmods = "sata";
>>>> +                ports-implemented = <0x1>;
>>>> +            };
>>>>            };
>>>>
>>>>            /* OCP2SCP1 */
>>>>
>>>

-- 
cheers,
-roger
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
