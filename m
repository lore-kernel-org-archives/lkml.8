Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6925C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9107920771
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 00:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbgGEAhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 20:37:20 -0400
Received: from server-x.ipv4.hkg02.ds.network ([27.111.83.178]:51316 "EHLO
        mail.gtsys.com.hk" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1727041AbgGEAhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 20:37:20 -0400
X-Greylist: delayed 411 seconds by postgrey-1.27 at vger.kernel.org; Sat, 04 Jul 2020 20:37:18 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 7F30B2016B13;
        Sun,  5 Jul 2020 08:30:26 +0800 (HKT)
X-Virus-Scanned: Debian amavisd-new at gtsys.com.hk
Received: from mail.gtsys.com.hk ([127.0.0.1])
        by localhost (mail.gtsys.com.hk [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 7NeF7PWBhov8; Sun,  5 Jul 2020 08:30:26 +0800 (HKT)
Received: from s01.gtsys.com.hk (unknown [10.128.4.2])
        by mail.gtsys.com.hk (Postfix) with ESMTP id 597D920160D4;
        Sun,  5 Jul 2020 08:30:26 +0800 (HKT)
Received: from [10.128.2.32] (unknown [124.217.189.122])
        by s01.gtsys.com.hk (Postfix) with ESMTPSA id 0907CC01F9E;
        Sun,  5 Jul 2020 08:30:25 +0800 (HKT)
Subject: Re: [PATCH 2/2] devicetree: hwmon: shtc1: Add sensirion,shtc1.yaml
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Jack Lo <jack.lo@gtsys.com.hk>, devicetree@vger.kernel.org,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200703034856.12846-1-chris.ruehl@gtsys.com.hk>
 <20200703034856.12846-3-chris.ruehl@gtsys.com.hk>
 <00c1b143-46c4-2621-bd77-fa465fb77774@roeck-us.net>
From:   Chris Ruehl <chris.ruehl@gtsys.com.hk>
Message-ID: <9d473b54-94ca-0fc2-2ce7-2c88364c9e94@gtsys.com.hk>
Date:   Sun, 5 Jul 2020 08:30:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <00c1b143-46c4-2621-bd77-fa465fb77774@roeck-us.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

On 3/7/2020 1:49 pm, Guenter Roeck wrote:
> On 7/2/20 8:48 PM, Chris Ruehl wrote:
>> Add documentation for the newly added DTS support in the shtc1 driver.
>>
>> Signed-off-by: Chris Ruehl <chris.ruehl@gtsys.com.hk>
>> ---
>>   .../bindings/hwmon/sensirion,shtc1.yaml       | 53 +++++++++++++++++++
>>   1 file changed, 53 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>> new file mode 100644
>> index 000000000000..e3e292bc6d7d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/sensirion,shtc1.yaml
>> @@ -0,0 +1,53 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/sensirion,shtc1.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Sensirion SHTC1 Humidity and Temperature Sensor IC
>> +
>> +maintainers:
>> +  - jdelvare@suse.com
>> +
>> +description: |
>> +  The SHTC1, SHTW1 and SHTC3 are digital humidity and temperature sensor
>> +  designed especially for battery-driven high-volume consumer electronics
>> +  applications.
>> +  For further information refere to Documentation/hwmon/shtc1.rst
>> +
>> +  This binding document describes the binding for the hardware monitor
>> +  portion of the driver.
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - sensirion,shtc1
>> +      - sensirion,shtw1
>> +      - sensirion,shtc3
>> +
>> +  reg: I2C address 0x70
>> +
>> +Optional properties:
>> +  sensirion,blocking_io: |
>> +    u8, if > 0 the i2c bus hold until measure finished (default 0)
>> +  sensirion,high_precision: |
>> +    u8, if > 0 aquire data with high precision (default 1)
>> +
> Why u8 and not boolean ?
>
> Guenter
The author of the driver make high_precision default (recommend) in the code,
if I use boolean, then the device tree _must_ have have the 
sensirion,high_precision set
or I need to do the opposite and define sensirion,low_precision.
(blocking_io = false default, high_precision = true default)

that's the reason I was thinking use a u8 and test with of_property_read_bool to 
check
the presence of it and set it if value > 0.


Chris.

>
>> +required:
>> +  - compatible
>> +  - reg
>> +
>> +additionalProperties: false
>> +
>> +Example:
>> +  &i2c1 {
>> +    status = "okay";
>> +    clock-frequency = <400000>;
>> +
>> +    shtc3@70 {
>> +      compatible = "sensirion,shtc3";
>> +      reg = <0x70>
>> +      sensirion,blocking_io = <1>;
>> +      status = "okay";
>> +    };
>> +  };
>>

-- 
GTSYS Limited RFID Technology
9/F, Unit E, R07, Kwai Shing Industrial Building Phase 2,
42-46 Tai Lin Pai Road, Kwai Chung, N.T., Hong Kong
Tel (852) 9079 9521

Disclaimer: https://www.gtsys.com.hk/email/classified.html

