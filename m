Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6363EC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F769205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="obcXkXxf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgD2TF5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:05:57 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:46252 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726423AbgD2TF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:05:56 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03TJ5inn097706;
        Wed, 29 Apr 2020 14:05:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588187144;
        bh=bcQKFHevt5M2/efAd2NREwTRy1wo6Zk+3v/nh8BE9EU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=obcXkXxfKwvtsOBG3N9C8+NSR+5n2mPeUeoH8C1IASWv7teT1i321N9WBPpjEFz/5
         OvLgrRIC3CtR0aXsU0amZUstyzLtzubMQKjxtkKN0/0lRRYKtc6psRSY1NVEz6GvRq
         BeaCmUr0IImxedlYZwNYE3PlJxhmr++mLreYoH7k=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03TJ5i9N069473
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Apr 2020 14:05:44 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 29
 Apr 2020 14:05:44 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 29 Apr 2020 14:05:44 -0500
Received: from [10.250.87.22] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03TJ5fbx090604;
        Wed, 29 Apr 2020 14:05:42 -0500
Subject: Re: [PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
To:     Rob Herring <robh+dt@kernel.org>
CC:     Sumit Semwal <sumit.semwal@linaro.org>,
        John Stultz <john.stultz@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200424222740.16259-1-afd@ti.com>
 <CAL_Jsq+4mf6QHX27knoHTXA4vnsC3swuvAH7zK1DpyaV-p_qbw@mail.gmail.com>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <f46c097a-b2a6-6368-a8a4-e30995a54d17@ti.com>
Date:   Wed, 29 Apr 2020 15:05:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+4mf6QHX27knoHTXA4vnsC3swuvAH7zK1DpyaV-p_qbw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/20 11:17 AM, Rob Herring wrote:
> On Fri, Apr 24, 2020 at 5:27 PM Andrew F. Davis <afd@ti.com> wrote:
>>
>> This new export type exposes to userspace the SRAM area as a DMA-Heap,
>> this allows for allocations as DMA-BUFs that can be consumed by various
>> DMA-BUF supporting devices.
>>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> ---
>>  .../devicetree/bindings/sram/sram.yaml        |   8 +
> 
> Separate patch and needs to go to DT list...
> 


Okay, will split for v2.


>>  drivers/misc/Kconfig                          |   7 +
>>  drivers/misc/Makefile                         |   1 +
>>  drivers/misc/sram-dma-heap.c                  | 243 ++++++++++++++++++
>>  drivers/misc/sram.c                           |  20 +-
>>  drivers/misc/sram.h                           |  17 ++
>>  6 files changed, 292 insertions(+), 4 deletions(-)
>>  create mode 100644 drivers/misc/sram-dma-heap.c
>>
>> diff --git a/Documentation/devicetree/bindings/sram/sram.yaml b/Documentation/devicetree/bindings/sram/sram.yaml
>> index 7b83cc6c9bfa..b8e33c8d205d 100644
>> --- a/Documentation/devicetree/bindings/sram/sram.yaml
>> +++ b/Documentation/devicetree/bindings/sram/sram.yaml
>> @@ -105,6 +105,14 @@ patternProperties:
>>            manipulation of the page attributes.
>>          type: boolean
>>
>> +      dma-heap-export:
>> +        description:
>> +          Similar to 'pool' and 'export' this region will be exported for use
>> +          by drivers, devices, and userspace using the DMA-Heaps framework.
>> +          NOTE: This region must be page aligned on start and end in order to
>> +          properly allow manipulation of the page attributes.
>> +        type: boolean
> 
> Though I'm not sure this should be in DT. You have to change your
> firmware to enable a new kernel feature? We also already have 'export'
> which sounds like the same function. Or 'pool' though reading the
> description, I don't really understand it's use.
> 


Maybe I could just re-use 'export', right now that property causes the
SRAM region to be exported to userspace as a file one can read/write.
Exporting via dma-heaps/dma-buf allows more flexibility as one can pass
the exported regions to other devices or mmap them directly in userspace.

It's up to the SRAM driver maintainer if re-purposing that property in
the driver is acceptable.

'Pool' doesn't make much sense to me either, it creates a gen-pool out
of the region, but I cant find any users not in combination with the
other properties.


> What combination of all 3 of these options would be valid?
> 


From looking at the SRAM driver, it seems each of the option must be
used exclusively per region, combining will cause issues. I can update
the documentation for the same after we settle on a strategy for this
new property.

Andrew


> Rob
> 
