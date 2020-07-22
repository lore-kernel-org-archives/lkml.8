Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D7BC433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:08:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE0F1208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 18:08:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731811AbgGVSIA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 14:08:00 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:17322 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727044AbgGVSH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 14:07:57 -0400
Received: from fsav303.sakura.ne.jp (fsav303.sakura.ne.jp [153.120.85.134])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06MI7mBv038876;
        Thu, 23 Jul 2020 03:07:48 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav303.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp);
 Thu, 23 Jul 2020 03:07:48 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav303.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06MI7lJ8038871
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Thu, 23 Jul 2020 03:07:48 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] dt-bindings: sound: convert ROHM BD28623 amplifier
 binding to yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200714081000.177914-1-katsuhiro@katsuster.net>
 <20200721021211.GA3388250@bogus>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <b6ecd278-d085-ad1a-03b7-5a15164c85bd@katsuster.net>
Date:   Thu, 23 Jul 2020 03:07:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200721021211.GA3388250@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thanks a lot for your review!

Best Regards,
Katsuhiro Suzuki

On 2020/07/21 11:12, Rob Herring wrote:
> On Tue, Jul 14, 2020 at 05:09:59PM +0900, Katsuhiro Suzuki wrote:
>> This patch converts ROHM BD28623UMV class D speaker amplifier binding
>> to DT schema.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../bindings/sound/rohm,bd28623.txt           | 29 ---------
>>   .../bindings/sound/rohm,bd28623.yaml          | 65 +++++++++++++++++++
>>   2 files changed, 65 insertions(+), 29 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt b/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
>> deleted file mode 100644
>> index d84557c2686e..000000000000
>> --- a/Documentation/devicetree/bindings/sound/rohm,bd28623.txt
>> +++ /dev/null
>> @@ -1,29 +0,0 @@
>> -ROHM BD28623MUV Class D speaker amplifier for digital input
>> -
>> -This codec does not have any control buses such as I2C, it detect format and
>> -rate of I2S signal automatically. It has two signals that can be connected
>> -to GPIOs: reset and mute.
>> -
>> -Required properties:
>> -- compatible      : should be "rohm,bd28623"
>> -- #sound-dai-cells: should be 0.
>> -- VCCA-supply     : regulator phandle for the VCCA supply
>> -- VCCP1-supply    : regulator phandle for the VCCP1 supply
>> -- VCCP2-supply    : regulator phandle for the VCCP2 supply
>> -
>> -Optional properties:
>> -- reset-gpios     : GPIO specifier for the active low reset line
>> -- mute-gpios      : GPIO specifier for the active low mute line
>> -
>> -Example:
>> -
>> -	codec {
>> -		compatible = "rohm,bd28623";
>> -		#sound-dai-cells = <0>;
>> -
>> -		VCCA-supply = <&vcc_reg>;
>> -		VCCP1-supply = <&vcc_reg>;
>> -		VCCP2-supply = <&vcc_reg>;
>> -		reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
>> -		mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
>> -	};
>> diff --git a/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml b/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
>> new file mode 100644
>> index 000000000000..acd8609252b4
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/rohm,bd28623.yaml
>> @@ -0,0 +1,65 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/rohm,bd28623.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: ROHM BD28623MUV Class D speaker amplifier for digital input
>> +
>> +description:
>> +  This codec does not have any control buses such as I2C, it detect
>> +  format and rate of I2S signal automatically. It has two signals
>> +  that can be connected to GPIOs reset and mute.
>> +
>> +maintainers:
>> +  - Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> +
>> +properties:
>> +  compatible:
>> +    const: rohm,bd28623
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +  VCCA-supply:
>> +    description:
>> +      regulator phandle for the VCCA (for analog) power supply
>> +
>> +  VCCP1-supply:
>> +    description:
>> +      regulator phandle for the VCCP1 (for ch1) power supply
>> +
>> +  VCCP2-supply:
>> +    description:
>> +      regulator phandle for the VCCP2 (for ch2) power supply
>> +
>> +  reset-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO specifier for the active low reset line
>> +
>> +  mute-gpios:
>> +    maxItems: 1
>> +    description:
>> +      GPIO specifier for the active low mute line
>> +
>> +required:
>> +  - compatible
>> +  - VCCA-supply
>> +  - VCCP1-supply
>> +  - VCCP2-supply
>> +  - "#sound-dai-cells"
> 
> Needs an:
> 
> additionalProperties: false
> 
> With that,
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> 
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/gpio/gpio.h>
>> +    codec {
>> +      compatible = "rohm,bd28623";
>> +      #sound-dai-cells = <0>;
>> +
>> +      VCCA-supply = <&vcc_reg>;
>> +      VCCP1-supply = <&vcc_reg>;
>> +      VCCP2-supply = <&vcc_reg>;
>> +      reset-gpios = <&gpio 0 GPIO_ACTIVE_LOW>;
>> +      mute-gpios = <&gpio 1 GPIO_ACTIVE_LOW>;
>> +    };
>> -- 
>> 2.27.0
>>

