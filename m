Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 520BEC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:51:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 167532070E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 09:51:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hQIew7Fm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgA2JvN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 04:51:13 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45699 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgA2JvM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 04:51:12 -0500
Received: by mail-yw1-f65.google.com with SMTP id a125so5238175ywe.12;
        Wed, 29 Jan 2020 01:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=msGz2ESZ2UJRzLB9AUoHtHWgVt+qM5wQRkU7yMDJeOE=;
        b=hQIew7FmRox4FI1ZZrV4uJ/4mjyprfw14dmA02jeqLrF7V2FE5hz/d+fJgDbCY9B62
         s4sczrTp5GSMQg0qgDJFMWNtRq5OqMHXzDVxf0LW7r/ZHkxwgRGnaybR/psPe0jXkh9u
         arEpL7nS61xI1wCA8F5oFN7I91s8/LSRlbH00nrOmXRz52qxXIqnH0K1X3ZJRlbiiCJ2
         fk4P9AiGahIrmm1lnWrX/nRsmMu1uBgUEFS9/ogzv417Atxvlb37xEFev1k4pyTvbU9H
         uscmz2+ZqYuWYNIDdpOFclIeS5/29ywGyYYO3L8sVVAUkSuz11uA3vKcOJIZPSmdnUI+
         V3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=msGz2ESZ2UJRzLB9AUoHtHWgVt+qM5wQRkU7yMDJeOE=;
        b=Be4H0x9cto0ZADLa6YfgFh9YwmeSBD9m9jCJb5dPSxQBuWoxeKVmFpp8Yy+cgfCCOK
         XDdDhgWhE2LXuYPafLf8tbflyi7faGXq65R1Pf3HR+JgPRBFq9AIILirOgWrcZWshpBx
         6YnY59fnsbmfyu8wpzKtm1ezULGCQTi3iUgJfNNAKMvDK68l+Cve65sfidqn80atkHpT
         5/2LQJ0C4hiZFOBts67sR05Mg0JIR49oeBACaeV6S6WrCrRjj0TOpUtU7Vs2vwrprEtW
         mbl+9i4coY6cPuYsJ2tcrXLhFO16EG8dvuLoCPV7qI5vxPsbplHgY1g02UyEQMmrARRC
         eGnA==
X-Gm-Message-State: APjAAAULj6YZIvsDCs8h/cWpLaxHCzCBWlPDTLh5O9BoF5HnR1ayVVcw
        rFapgZ8Nrofegi/AgeM2KVnUlEfI
X-Google-Smtp-Source: APXvYqyqxnX2bQoHJDkHE1V7WT4xVJx7oZZpBgSCPEYZC38pu/OQxFsRgk86QikPTFhc0qganKqffg==
X-Received: by 2002:a81:3888:: with SMTP id f130mr18461063ywa.138.1580291470885;
        Wed, 29 Jan 2020 01:51:10 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m203sm733423ywc.10.2020.01.29.01.51.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 01:51:10 -0800 (PST)
Subject: Re: [PATCH v6 2/2] dt-bindings: hwmon: (adt7475) Added missing
 adt7475 documentation
To:     Logan Shaw <Logan.Shaw@alliedtelesis.co.nz>,
        "robh@kernel.org" <robh@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Joshua Scott <Joshua.Scott@alliedtelesis.co.nz>,
        Chris Packham <Chris.Packham@alliedtelesis.co.nz>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20200126221014.2978-1-logan.shaw@alliedtelesis.co.nz>
 <20200126221014.2978-3-logan.shaw@alliedtelesis.co.nz>
 <20200127154800.GA7023@bogus>
 <b1d669567b5f9f00dfb5d6dab89262f68c5523f1.camel@alliedtelesis.co.nz>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <0849578b-c2aa-d62f-b236-7efab9489238@roeck-us.net>
Date:   Wed, 29 Jan 2020 01:51:08 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <b1d669567b5f9f00dfb5d6dab89262f68c5523f1.camel@alliedtelesis.co.nz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/28/20 8:30 PM, Logan Shaw wrote:
> On Mon, 2020-01-27 at 09:48 -0600, Rob Herring wrote:
>> On Mon, Jan 27, 2020 at 11:10:14AM +1300, Logan Shaw wrote:
>>> Added a new file documenting the adt7475 devicetree and added the
>>> four
>>> new properties to it.
>>>
>>> Signed-off-by: Logan Shaw <logan.shaw@alliedtelesis.co.nz>
>>> ---
>>> ---
>>>   .../devicetree/bindings/hwmon/adt7475.yaml    | 95
>>> +++++++++++++++++++
>>>   1 file changed, 95 insertions(+)
>>>   create mode 100644
>>> Documentation/devicetree/bindings/hwmon/adt7475.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>>> b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>>> new file mode 100644
>>> index 000000000000..450da5e66e07
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/adt7475.yaml
>>> @@ -0,0 +1,95 @@
>>> +# SPDX-License-Identifier: GPL-2.0
>>
>> Dual license new bindings please:
>>
>> (GPL-2.0-only OR BSD-2-Clause)
>>
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/adt7475.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: ADT7475 hwmon sensor
>>> +
>>> +maintainers:
>>> +  - Jean Delvare <jdelvare@suse.com>
>>> +
>>> +description: |
>>> +  The ADT7473, ADT7475, ADT7476, and ADT7490 are thermal monitors
>>> and multiple
>>> +  PWN fan controllers.
>>> +
>>> +  They support monitoring and controlling up to four fans (the
>>> ADT7490 can only
>>> +  control up to three). They support reading a single on chip
>>> temperature
>>> +  sensor and two off chip temperature sensors (the ADT7490
>>> additionally
>>> +  supports measuring up to three current external temperature
>>> sensors with
>>> +  series resistance cancellation (SRC)).
>>> +
>>> +  Datasheets:
>>> +  https://www.onsemi.com/pub/Collateral/ADT7473-D.PDF
>>> +  https://www.onsemi.com/pub/Collateral/ADT7475-D.PDF
>>> +  https://www.onsemi.com/pub/Collateral/ADT7476-D.PDF
>>> +  https://www.onsemi.com/pub/Collateral/ADT7490-D.PDF
>>> +
>>> +  Description taken from omsemiconductors specification sheets,
>>> with minor
>>
>> omsemi?
>>   ^
>>
>>> +  rephrasing.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - adi,adt7473
>>> +      - adi,adt7475
>>> +      - adi,adt7476
>>> +      - adi,adt7490
>>> +
>>> +  reg:
>>> +    maxItems: 1
>>> +
>>> +  bypass-attenuator-in0:
>>
>> Needs a vendor prefix and a type ref.
> 
> Adi (Analog Devices) sold the ADT product line (amongst other things)
> to On Semiconductor. As changing the vendor of these chips (in code)
> would break backwards compatibility should we keep the vendor as adi?
> 
> To confirm, would this make the property "adi,adt7476,bypass-
> attenuator-in0"?
> 
> So used in conjunction with patternProperties you would end up with
> something like:
> 
> "adi,(adt7473|adt7475|adt7476|adt7490),bypass-attenuator-in[0134]"
> 

That seems highly unusual and would be quite messy to implement.
I don't see the point of having the chip name in individual properties.

Guenter

>>
>>> +    description: |
>>> +      Configures bypassing the individual voltage input
>>> +      attenuator, on in0. This is supported on the ADT7476 and
>>> ADT7490.
>>> +      If set to a non-zero integer the attenuator is bypassed, if
>>> set to
>>> +      zero the attenuator is not bypassed. If the property is
>>> absent then
>>> +      the config register is not modified.
>>
>> Sounds like this could be boolean? If not, define a schema for what
>> are
>> valid values.
>>
>>> +    maxItems: 1
>>> +
>>> +  bypass-attenuator-in1:
>>> +    description: |
>>> +      Configures bypassing the individual voltage input
>>> +      attenuator, on in1. This is supported on the ADT7473,
>>> ADT7475,
>>> +      ADT7476 and ADT7490. If set to a non-zero integer the
>>> attenuator
>>> +      is bypassed, if set to zero the attenuator is not bypassed.
>>> If the
>>> +      property is absent then the config register is not modified.
>>> +    maxItems: 1
>>> +
>>> +  bypass-attenuator-in3:
>>> +    description: |
>>> +      Configures bypassing the individual voltage input
>>> +      attenuator, on in3. This is supported on the ADT7476 and
>>> ADT7490.
>>> +      If set to a non-zero integer the attenuator is bypassed, if
>>> set to
>>> +      zero the attenuator is not bypassed. If the property is
>>> absent then
>>> +      the config register is not modified.
>>> +    maxItems: 1
>>> +
>>> +  bypass-attenuator-in4:
>>
>> These 4 could be a single entry under patternProperties.
>>
>>
>>> +    description: |
>>> +      Configures bypassing the individual voltage input
>>> +      attenuator, on in4. This is supported on the ADT7476 and
>>> ADT7490.
>>> +      If set to a non-zero integer the attenuator is bypassed, if
>>> set to
>>> +      zero the attenuator is not bypassed. If the property is
>>> absent then
>>> +      the config register is not modified.
>>> +    maxItems: 1
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +examples:
>>> +  - |
>>> +    i2c {
>>> +      #address-cells = <1>;
>>> +      #size-cells = <0>;
>>> +
>>> +      hwmon@2e {
>>> +        compatible = "adi,adt7476";
>>> +        reg = <0x2e>;
>>> +        bypass-attenuator-in0 = <1>;
>>> +        bypass-attenuator-in1 = <0>;
>>> +      };
>>> +    };
>>> +...
>>> -- 
>>> 2.25.0
>>>

