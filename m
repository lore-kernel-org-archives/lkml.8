Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F30C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 372C8207FB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:41:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="DncnV4l3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388797AbgEYGlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:41:31 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:59712 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbgEYGlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:41:31 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04P6fRS2052015;
        Mon, 25 May 2020 01:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590388887;
        bh=o/T4a+iVa5id3QHDSWuDIMh/rTsJCeFA4f07QeO6HeU=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=DncnV4l3WaMIUD5GWq0POssxEbkZFJ6cQCK3bcT5JfoLNCg0stJnAL1Mr/WdzghAL
         4LoTk8bxoFwyUZM14tGcdX8ZmDVwCEUfP/GBhuhFIenwnY88R0xoNgxJ/pxVo4B0mL
         /O7q4hR1fix1975Xna6QmwTw5Qlb9lb53Gps9JrM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04P6fRWD057808;
        Mon, 25 May 2020 01:41:27 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 25
 May 2020 01:41:27 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 25 May 2020 01:41:26 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04P6fOX6098354;
        Mon, 25 May 2020 01:41:25 -0500
Subject: Re: [PATCH 3/3] usb: dwc3: keystone: Turn on USB3 PHY before
 controller
From:   Roger Quadros <rogerq@ti.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
CC:     <robh+dt@kernel.org>, <vigneshr@ti.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200513130709.10239-1-rogerq@ti.com>
 <20200513130709.10239-4-rogerq@ti.com> <1589420265.5899.0.camel@mhfsdcap03>
 <baaaf89c-4baf-4218-e22e-53cd1a64ec02@ti.com> <87tv0i4y0v.fsf@kernel.org>
 <debe1c1d-8e84-8047-d387-42d4f6e03f91@ti.com>
Message-ID: <ec6c01d7-643f-3dd4-dcad-b492924fdf66@ti.com>
Date:   Mon, 25 May 2020 09:41:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <debe1c1d-8e84-8047-d387-42d4f6e03f91@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/05/2020 09:39, Roger Quadros wrote:
> Felipe,
> 
> On 14/05/2020 13:21, Felipe Balbi wrote:
>> Roger Quadros <rogerq@ti.com> writes:
>>
>>> On 14/05/2020 04:37, Chunfeng Yun wrote:
>>>> On Wed, 2020-05-13 at 16:07 +0300, Roger Quadros wrote:
>>>>> The Local Power Sleep Controller (LPSC) dependency on AM65
>>>>> requires SERDES0 to be powered on before USB.
>>>>>
>>>>> We need to power up SERDES0 power domain and hold it on
>>>>> throughout the reset, init, power on sequence.
>>>>>
>>>>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>>>>> ---
>>>>>    drivers/usb/dwc3/dwc3-keystone.c | 47 +++++++++++++++++++++++++++++++-
>>>>>    1 file changed, 46 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-keystone.c b/drivers/usb/dwc3/dwc3-keystone.c
>>>>> index 1e14a6f4884b..46d46f3507fc 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-keystone.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-keystone.c
>>>>> @@ -14,6 +14,7 @@
>>>>>    #include <linux/dma-mapping.h>
>>>>>    #include <linux/io.h>
>>>>>    #include <linux/of_platform.h>
>>>>> +#include <linux/phy/phy.h>
>>>>>    #include <linux/pm_runtime.h>
>>>>>    /* USBSS register offsets */
>>>>> @@ -34,6 +35,7 @@
>>>>>    struct dwc3_keystone {
>>>>>        struct device            *dev;
>>>>>        void __iomem            *usbss;
>>>>> +    struct phy            *usb3_phy;
>>>>>    };
>>>>>    static inline u32 kdwc3_readl(void __iomem *base, u32 offset)
>>>>> @@ -95,8 +97,44 @@ static int kdwc3_probe(struct platform_device *pdev)
>>>>>        if (IS_ERR(kdwc->usbss))
>>>>>            return PTR_ERR(kdwc->usbss);
>>>>> -    pm_runtime_enable(kdwc->dev);
>>>>> +    /* PSC dependency on AM65 needs SERDES0 to be powered before USB0 */
>>>>> +    kdwc->usb3_phy = devm_phy_get(dev, "usb3-phy");
>>>> Use devm_phy_optional_get() instead?
>>>
>>> Indeed, it seems better suited.
>>
>> patches 1 and 2 are in testing/next
>>
> 
> Could you please drop them as I need to make changes to make the PHY optional.
> I will send v2 of entire series.

Actually only patch 2 and 3 need to be revised. Patch 1 is fine.

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
