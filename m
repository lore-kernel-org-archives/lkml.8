Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AB8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C86C20720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 03:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8s6b6ep"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgGHDvB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 23:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729501AbgGHDu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 23:50:59 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77271C061755;
        Tue,  7 Jul 2020 20:50:59 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id a14so14782823pfi.2;
        Tue, 07 Jul 2020 20:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+rKAYKTeHzkVpl2RgZAS+ah4uO2OSAXr9cLPsYi3GlM=;
        b=G8s6b6epoodSGfcWcdKwAkmwLtgv7kS5wnMFJtYO4EXzbLtzO/uU644lLsjIJoDaJa
         uKRXXnZ9oMWaUzAy/ed+EB6shtesfvHrOBJp98MOiLCRd/qUsylljYgta7Y57tw/vVaQ
         dtK/njCNE3z7DxFV9SDPCXRFARdxWWSsp4eJZqiaq1g/2w8Og3KdHIYRVrgryCKcGdCK
         tLBoJSgyWkfWmEV4GGe1JCCTsicurDli0rYfqH8ofg1t4MUnH2M1FK0bYQOPbrpW6Ej0
         LMRnsc4+SpghXoCNW9q8IaNpdHblLcTqJw2rDPk8Q2vTfIDoqriPrn3ETxwRRb8qMuK1
         0k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+rKAYKTeHzkVpl2RgZAS+ah4uO2OSAXr9cLPsYi3GlM=;
        b=E27YHRDzNNVRaKuaJ8/537RFloN4WSHL3OXWR5Sr+6RzM9+9kR45PgGCm33fF0polY
         nHBe9qjAE+cN9GOdkqG0ALSNp5wpFT/2FpGnAPOjDxKp3+L+SpLmP6pZhglgFGcN6UDT
         pD6plAGKl1Dk1e3GMa3IX071wEp4BPsbgyGLnmdiN+N5QrsCa4e+5Nwbd84HHI3zJNEt
         OUaLmzJX1gKakF8up30e03RWI7fOZbTy2r/iwAg9F3QimWk+yB2A6NFmJSUIYi9jIPOY
         IkWvFjTaE2tfHCi29xcsejlNlfUKkOkqnPlpBLGfJjU/gpyrv4g0xMHqzqUxEn0cQSmK
         lxNg==
X-Gm-Message-State: AOAM5333kXwbn0OD4JT/LggmOUDsTzBtbdoq3/EIQh8+mZZayLu0P671
        Mu2MJXxyKvgEJQn4c18nchxdDCgRBUA=
X-Google-Smtp-Source: ABdhPJxZSTJssk8/SyY6GTSxUny789+IsGZ3tegh4qCb/4LNznoWf6N17Uio7niLDSEDnVkgPX3ZPw==
X-Received: by 2002:a65:6799:: with SMTP id e25mr49852552pgr.364.1594180258831;
        Tue, 07 Jul 2020 20:50:58 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m20sm24848529pfk.52.2020.07.07.20.50.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jul 2020 20:50:58 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
To:     Chris Ruehl <chris.ruehl@gtsys.com.hk>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200707133503.GA217263@roeck-us.net>
 <40330886-9943-d3ae-3c28-f2baa9c73ade@gtsys.com.hk>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <1fda46f1-6484-e128-8851-0f42fc92d844@roeck-us.net>
Date:   Tue, 7 Jul 2020 20:50:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <40330886-9943-d3ae-3c28-f2baa9c73ade@gtsys.com.hk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 8:34 PM, Chris Ruehl wrote:
> Hi Guenter,
> 
> On 7/7/2020 9:35 pm, Guenter Roeck wrote:
>> On Tue, Jul 07, 2020 at 04:01:03PM +0800, Chris Ruehl wrote:
>>> Add documentation for the newly added DTS support in the shtc1 driver.
>>> To align with the drivers logic to have high precision by default
>>> a boolean sensirion,low_precision is used to switch to low precision.
>>>
>>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>>> ---
>>>   .../bindings/hwmon/sensirion,shtc1.yaml       | 53 +++++++++++++++++++
>>>   1 file changed, 53 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>> new file mode 100644
>>> index 000000000000..bcccdcadd86b
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
>>
>> Did Jean agree to maintain this file ?
> 
> I thought its OK to set the maintainer from the list shown with
> get_maintainer.pl here. I don't mind take care of this file - there will be small changes only in case the dt-schema change and requires updates.
> 

No, it isn't. Jean and I are the maintainers for the hwmon
subsystem, but that doesn't mean or suggest that we should
be listed as maintainers in individual files.

> I put me here, if that is acceptable.
> 

Either you, or none.

Thanks,
Guenter

> Chris
> 
>>
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
>>> +    bool, if set the i2c bus hold until measure finished
>>> +  sensirion,low_precision: |
>>> +    bool, if set aquire data with low precision (not recommend)
>>
>> recommended
>>
>> It might make sense to mention that the default is expected to be high precision
>> if not specified.
>>
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +Example:
>>> +  &i2c1 {
>>> +    status = "okay";
>>> +    clock-frequency = <400000>;
>>> +
>>> +    shtc3@70 {
>>> +      compatible = "sensirion,shtc3";
>>> +      reg = <0x70>
>>> +      sensirion,blocking_io;
>>> +      status = "okay";
>>> +    };
>>> +  };
>>> -- 
>>> 2.20.1
>>>
> 

