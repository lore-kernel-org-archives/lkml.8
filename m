Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC41EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8803E206DA
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="PDd3krMH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgENMTp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:19:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52804 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgENMTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:19:45 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04ECIsMf118638;
        Thu, 14 May 2020 07:18:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589458735;
        bh=voTy57HPP7kdBOyeAtwz0qnAjpwohc6zTYtH4JaYx9E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=PDd3krMHKaSrLQmWOV2qyOX+ULVGjpan6iz7kXWCxMDvtIstcNCpK2CX8pPmPaGJh
         2hNz9wmVyk4E6SbWEe7/EZYGHddk96NIC3cGGKNT8LIy0rYJ6HAKiyOjutHkgHGLG6
         CwlDDn5HGo74UXxGbRPxtUIKGgT4AkxsqwqS8SV4=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04ECIsJf127530
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 May 2020 07:18:54 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 14
 May 2020 07:18:54 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 14 May 2020 07:18:54 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ECIspR116786;
        Thu, 14 May 2020 07:18:54 -0500
Subject: Re: [PATCH v2 2/3] ASoC: tlv320adcx140: Add device tree property for
 PDM edges
To:     Ricard Wanderlof <ricardw@axis.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>, Rob Herring <robh@kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200513200549.12213-1-dmurphy@ti.com>
 <20200513200549.12213-2-dmurphy@ti.com>
 <alpine.DEB.2.20.2005141006450.30387@lnxricardw1.se.axis.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <27145913-cd16-850b-dcfc-01fcffc72d0e@ti.com>
Date:   Thu, 14 May 2020 07:09:23 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.2005141006450.30387@lnxricardw1.se.axis.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Richard

On 5/14/20 3:09 AM, Ricard Wanderlof wrote:
> On Wed, 13 May 2020, Dan Murphy wrote:
>
>> Add a device tree property to configure the PDM sampling edge for each
>> digital microphone.
>>
>> CC: Rob Herring <robh@kernel.org>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ---
>>   .../devicetree/bindings/sound/tlv320adcx140.yaml   | 14 ++++++++++++++
>>   1 file changed, 14 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
>> b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
>> index ab2268c0ee67..55668c7d261d 100644
>> --- a/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
>> +++ b/Documentation/devicetree/bindings/sound/tlv320adcx140.yaml
>> @@ -63,6 +63,19 @@ properties:
>>         - $ref: /schemas/types.yaml#/definitions/uint32
>>         - enum: [0, 1, 2]
>>   
>> +  ti,pdm-edge-select:
>> +    description: |
>> +       Defines the sampling edge configuration for the PDM inputs.  This is
>> an
>> +       array defined as <PDMIN1 PDMIN2 PDMIN3 PDMIN4>. 0 (default) is
>> negative
>> +       sampling edge and 1 is positive sampling edge.
> A bit of a nitpick, but I would think of the edges as
> negative-going/positive-going, or rising/falling. Not sure if anyone would
> misunderstand 'negative edge' in practice though.

I will re-write the description to be more descriptive.

>> +    allOf:
>> +      - $ref: /schemas/types.yaml#/definitions/uint32-array
>> +      - minItems: 1
>> +        maxItems: 4
>> +        items:
>> +          maximum: 1
>> +        default: [0, 0, 0, 0]
>> +
>>   required:
>>     - compatible
>>     - reg
>> @@ -77,6 +90,7 @@ examples:
>>           compatible = "ti,tlv320adc5140";
>>           reg = <0x4c>;
>>           ti,mic-bias-source = <6>;
>> +        ti,pdm-edge-select = < 0 1 0 1>;
> Should there really be a space between < and 0 ?

I will remove the space

Dan

>
> /Ricard
