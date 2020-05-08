Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EF4C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44417208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 08:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hXER7gFz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgEHImN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 04:42:13 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:40720 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbgEHImM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 04:42:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0488gBvN020971;
        Fri, 8 May 2020 03:42:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588927331;
        bh=j0RPwytwTGu6DXnBXsaicV6+R0ACC0J3LuDsBmxAjQ4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=hXER7gFzPsBdW1U2+5FyzdOorrvEDdsp/UzYYcmXg92H1um39+yV547pRu/ZsOq6C
         OYwIWlU1UyWh3ivKj8Dk2V+Q865+Vk1w6V1KjkU+md8ZqUNqY3MvZPXB8ZROSiN6vm
         /6pXM8XDZI6Z4LOSYIHnSNyzRWko1VRK18QR1Ioo=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488gA2I115472;
        Fri, 8 May 2020 03:42:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 8 May
 2020 03:42:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 8 May 2020 03:42:10 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0488g8hm050354;
        Fri, 8 May 2020 03:42:09 -0500
Subject: Re: [PATCH v3 1/7] dt-bindings: syscon: Add TI's J721E specific
 compatible string
To:     Kishon Vijay Abraham I <kishon@ti.com>, <t-kristo@ti.com>
CC:     <robh@kernel.org>, <nm@ti.com>, <nsekhar@ti.com>,
        <vigneshr@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200508082937.14171-1-rogerq@ti.com>
 <20200508082937.14171-2-rogerq@ti.com>
 <6efa9374-e8f2-4054-3f35-6cacead783b8@ti.com>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <e833753a-20dd-e57d-2aa4-49e96f31df4d@ti.com>
Date:   Fri, 8 May 2020 11:42:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <6efa9374-e8f2-4054-3f35-6cacead783b8@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon,

On 08/05/2020 11:40, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 5/8/2020 1:59 PM, Roger Quadros wrote:
>> From: Kishon Vijay Abraham I <kishon@ti.com>
>>
>> Add TI's J721E SoC specific compatible string.
>>
>> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> 
> This patch should be dropped given that patch 2 adds a new binding for the
> compatible added here.

Indeed, my bad.

> 
> Thanks
> Kishon
> 
>> ---
>>   Documentation/devicetree/bindings/mfd/syscon.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/syscon.yaml b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> index 39375e4313d2..f9aac75d423a 100644
>> --- a/Documentation/devicetree/bindings/mfd/syscon.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/syscon.yaml
>> @@ -38,6 +38,7 @@ properties:
>>             - allwinner,sun8i-h3-system-controller
>>             - allwinner,sun8i-v3s-system-controller
>>             - allwinner,sun50i-a64-system-controller
>> +          - ti,j721e-system-controller
>>   
>>           - const: syscon
>>   
>>

cheers,
-roger
-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
