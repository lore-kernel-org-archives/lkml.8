Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382CBC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14E4C21534
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 13:32:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="o6XRI5IH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgIBNbe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:31:34 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:35864 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgIBN2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:28:55 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 082DSZUE026423;
        Wed, 2 Sep 2020 08:28:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1599053315;
        bh=vQI22dfT496+KMI35oF7DTRni+ONmCVmidN8Fb1B6+0=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=o6XRI5IHSlSq6IaNK6ejdynXOQ4iGHZeZdFOzKOYghxXfXBoyXag8B2B21u4ZY0zm
         ork3hupljrMbFs8CAklrPjWxvbn1wxgtIb8LrDJ9aq6pv/t9N3+QWTN2qAcXrmcby4
         jvBqMn5CRpgIYbfPVbPLwhwR6fwkX9vgUMXbTkoU=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 082DSZRN095336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Sep 2020 08:28:35 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 2 Sep
 2020 08:28:34 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 2 Sep 2020 08:28:34 -0500
Received: from [192.168.2.14] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 082DSW0D080726;
        Wed, 2 Sep 2020 08:28:32 -0500
Subject: Re: [PATCH 2/3] dt-bindings: usb: cdns,usb3: Add cdns,phyrst-a-enable
 property
To:     Peter Chen <peter.chen@nxp.com>
CC:     "balbi@kernel.org" <balbi@kernel.org>,
        "pawell@cadence.com" <pawell@cadence.com>,
        "kurahul@cadence.com" <kurahul@cadence.com>,
        "nsekhar@ti.com" <nsekhar@ti.com>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20200825120059.12436-1-rogerq@ti.com>
 <20200825120059.12436-3-rogerq@ti.com> <20200827111343.GB5983@b29397-desktop>
From:   Roger Quadros <rogerq@ti.com>
Message-ID: <08a7533f-b09e-f044-64e5-d709ae220599@ti.com>
Date:   Wed, 2 Sep 2020 16:28:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200827111343.GB5983@b29397-desktop>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter,

On 27/08/2020 14:14, Peter Chen wrote:
> On 20-08-25 15:00:58, Roger Quadros wrote:
>> Controller version 0x0002450D has USB2 PHY RX sensitivity issues
>> that needs to be worked around by enabling phyrst-a-enable bit
>> in PHYRST_CFG register.
>>
>> There is no way to distinguish between the controller version
>> before the device controller is started so we need to add this
>> DT property.
> 
> Maybe you should say "There is no way to know controller version
> at host mode, but this workaround needs for both host and device
> mode, so we have to add this DT property", the same for the comments
> of your driver code patch.

I will reword it to

"There is no way to know controller version before device controller
is started and the workaround needs to be applied for both host and
device modes, so we add this DT property"

cheers,
-roger

> 
> Peter
>>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>   Documentation/devicetree/bindings/usb/cdns,usb3.yaml | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>> index 7bc0263accee..e670adc955e1 100644
>> --- a/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>> +++ b/Documentation/devicetree/bindings/usb/cdns,usb3.yaml
>> @@ -58,6 +58,10 @@ properties:
>>         buffers expressed in KB
>>       $ref: /schemas/types.yaml#/definitions/uint32
>>   
>> +  cdns,phyrst-a-enable:
>> +    description: Enable resetting of PHY if Rx fail is detected
>> +    type: boolean
>> +
>>   required:
>>     - compatible
>>     - reg
>> -- 
>> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
>> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
>>
> 

-- 
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
