Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DB8C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A23FD20656
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:35:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9UJ/30e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGECfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 22:35:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGECfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:35:16 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68301C061794;
        Sat,  4 Jul 2020 19:35:16 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id x11so13996580plo.7;
        Sat, 04 Jul 2020 19:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UjdkL1lYOPrMALY9zd24PbKxTHBgY0e/WnDVKzvioqc=;
        b=B9UJ/30e1DKKvKUxDkmuESsL7WhhrE1avcqi4s6sgO3BzoHdW43p4mfZaDtgRBycbq
         4HvF5SO3ao8q2kjP/N37UoLLBHflWyhF1wfRuBM+GKAJrujsHvuns0HRbKffi6P2o0hU
         fDcdFUOnzgzaG36Lhzix1gjrfy1TrAt9pRBD8jvbR50r1uSocE+8gi5DInUINcuI2knp
         tflr2wxL6gRZMBfoT/DzyCLGXSaoN9AmLLmY9WPI4p4W9Up0VMnY+KdgDUinxlYhlEhs
         cqA4N88vwPwQwFv/K77YBZ1m/J/GnzRQKAtOySH0uySx6c4OD+ezoEwm0fVeHlJYsGHu
         QsPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=UjdkL1lYOPrMALY9zd24PbKxTHBgY0e/WnDVKzvioqc=;
        b=NV99yZSY0Je6fU9uk0Wy0K4Z1saXeNcDbWp0jZIRW9L1NpP+lM3aN/gPoVuK+TLDDb
         qDa/xVhmqSDS1Q1dIROrjUExO8oL/LCstSar8XMWbjM5clqp8wKyCFvDO4Z7V/HSQ+Ra
         gGmugFAfw3KVx1Fi40BecrW9J1J5O1rniI76nuyRG/CtgVwKk3yy5y42xsDo5Wbfn+3b
         G0InmdppxGDbSo+gtG8jyzbFN94sNEPr13c3cAXyYXGffL3Ixgz7MDhFoalNxquwTqWW
         wfY5qHRYNCH92uVHMY8VIx9DcbCo76TDZpLvafSlwLIB01AO4v00W5SRPH6C700Fu8AB
         HdWQ==
X-Gm-Message-State: AOAM531t+kgX8UBa4kKQBaLNT7Y1bXvPT9Sx0RwoE2tVG85P+D6guvOx
        UVMTTW0gK+EMVRKu7l6m1j3HRNmqCx8=
X-Google-Smtp-Source: ABdhPJxFosN3aXgEasT3wHv7s+LAvmRAxMlDX+LZ9ttWIx+reGxfDiuLPnDb2PxOMrDaBIAQAuhRWA==
X-Received: by 2002:a17:902:7897:: with SMTP id q23mr37240812pll.5.1593916515604;
        Sat, 04 Jul 2020 19:35:15 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id r6sm15200836pfl.142.2020.07.04.19.35.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Jul 2020 19:35:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200703034856.12846-1-chris.ruehl@gtsys.com.hk>
 <20200703034856.12846-3-chris.ruehl@gtsys.com.hk>
 <00c1b143-46c4-2621-bd77-fa465fb77774@roeck-us.net>
 <9d473b54-94ca-0fc2-2ce7-2c88364c9e94@gtsys.com.hk>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <4dee7e09-4cfd-c319-ba31-270fa0e7883c@roeck-us.net>
Date:   Sat, 4 Jul 2020 19:35:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <9d473b54-94ca-0fc2-2ce7-2c88364c9e94@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/20 5:30 PM, Chris Ruehl wrote:
> Hi Guenter,
> 
> On 3/7/2020 1:49 pm, Guenter Roeck wrote:
>> On 7/2/20 8:48 PM, Chris Ruehl wrote:
>>> Add documentation for the newly added DTS support in the shtc1 driver.
>>>
>>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>>> ---
>>>   .../bindings/hwmon/sensirion,shtc1.yaml       | 53 +++++++++++++++++++
>>>   1 file changed, 53 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>> new file mode 100644
>>> index 000000000000..e3e292bc6d7d
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>> @@ -0,0 +1,53 @@
>>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/hwmon/sensirion,shtc1.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sensirion SHTC1 Humidity and Temperature Sensor IC
>>> +
>>> +maintainers:
>>> +  - jdelvare@suse.com
>>> +
>>> +description: |
>>> +  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
>>> +  designed especially for battery-driven high-volume consumer electronics
>>> +  applications.
>>> +  For further information refere to Documentation/hwmon/shtc1.rst
>>> +
>>> +  This binding document describes the binding for the hardware monitor
>>> +  portion of the driver.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - sensirion,shtc1
>>> +      - sensirion,shtw1
>>> +      - sensirion,shtc3
>>> +
>>> +  reg: I2C address 0x70
>>> +
>>> +Optional properties:
>>> +  sensirion,blocking_io: |
>>> +    u8, if > 0 the i2c bus hold until measure finished (default 0)
>>> +  sensirion,high_precision: |
>>> +    u8, if > 0 aquire data with high precision (default 1)
>>> +
>> Why u8 and not boolean ?
>>
>> Guenter
> The author of the driver make high_precision default (recommend) in the code,
> if I use boolean, then the device tree _must_ have have the sensirion,high_precision set
> or I need to do the opposite and define sensirion,low_precision.
> (blocking_io = false default, high_precision = true default)
> 
> that's the reason I was thinking use a u8 and test with of_property_read_bool to check
> the presence of it and set it if value > 0.
> 

Devicetree properties are supposed to be independent from actual implementations.
Declaring "we must do so because of an existing implementation" would set a really
bad precedence - everyone could use that later on to push through arbitrary sets
of devicetree properties. On top of that, this is supposed to be a new set of
bindings, with no one using it today. Any argument along the line of "must have"
seems irrelevant, since there is no real concern about devicetree backwards
compatibility. And on top of all that, I find the currently suggested code
really awkward and convoluted.

With that in mind, I personally would neither accept your argument nor your code.
If you object to defining sensirion,high_precision as boolean, and at the same
time object to defining sensirion,low_precision as well, I'd say, fine, then
let's stick with what we have today.

Anyway, I'll follow Rob's guidance.

Guenter
