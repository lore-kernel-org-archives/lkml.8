Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E53E4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C181E206D7
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 15:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgGXPuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 11:50:50 -0400
Received: from www1102.sakura.ne.jp ([219.94.129.142]:16777 "EHLO
        www1102.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGXPut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 11:50:49 -0400
Received: from fsav301.sakura.ne.jp (fsav301.sakura.ne.jp [153.120.85.132])
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06OFoYMS078994;
        Sat, 25 Jul 2020 00:50:34 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Received: from www1102.sakura.ne.jp (219.94.129.142)
 by fsav301.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp);
 Sat, 25 Jul 2020 00:50:34 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav301.sakura.ne.jp)
Received: from [192.168.1.2] (121.252.232.153.ap.dti.ne.jp [153.232.252.121])
        (authenticated bits=0)
        by www1102.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06OFoXpE078987
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 25 Jul 2020 00:50:34 +0900 (JST)
        (envelope-from katsuhiro@katsuster.net)
Subject: Re: [PATCH] dt-bindings: sound: convert Everest ES8316 binding to
 yaml
To:     Rob Herring <robh@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20200722180728.993812-1-katsuhiro@katsuster.net>
 <20200723212623.GA882284@bogus>
From:   Katsuhiro Suzuki <katsuhiro@katsuster.net>
Message-ID: <58f31856-226b-41d5-deae-593e90d03598@katsuster.net>
Date:   Sat, 25 Jul 2020 00:50:33 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723212623.GA882284@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rob,

Thank you for review.

On 2020/07/24 6:26, Rob Herring wrote:
> On Thu, Jul 23, 2020 at 03:07:28AM +0900, Katsuhiro Suzuki wrote:
>> This patch converts Everest Semiconductor ES8316 low power audio
>> CODEC binding to DT schema.
>>
>> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
>> ---
>>   .../bindings/sound/everest,es8316.txt         | 23 ---------
>>   .../bindings/sound/everest,es8316.yaml        | 49 +++++++++++++++++++
>>   2 files changed, 49 insertions(+), 23 deletions(-)
>>   delete mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.txt
>>   create mode 100644 Documentation/devicetree/bindings/sound/everest,es8316.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.txt b/Documentation/devicetree/bindings/sound/everest,es8316.txt
>> deleted file mode 100644
>> index 1bf03c5f2af4..000000000000
>> --- a/Documentation/devicetree/bindings/sound/everest,es8316.txt
>> +++ /dev/null
>> @@ -1,23 +0,0 @@
>> -Everest ES8316 audio CODEC
>> -
>> -This device supports both I2C and SPI.
>> -
>> -Required properties:
>> -
>> -  - compatible  : should be "everest,es8316"
>> -  - reg : the I2C address of the device for I2C
>> -
>> -Optional properties:
>> -
>> -  - clocks : a list of phandle, should contain entries for clock-names
>> -  - clock-names : should include as follows:
>> -         "mclk" : master clock (MCLK) of the device
>> -
>> -Example:
>> -
>> -es8316: codec@11 {
>> -	compatible = "everest,es8316";
>> -	reg = <0x11>;
>> -	clocks = <&clks 10>;
>> -	clock-names = "mclk";
>> -};
>> diff --git a/Documentation/devicetree/bindings/sound/everest,es8316.yaml b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
>> new file mode 100644
>> index 000000000000..b713404dac4f
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/sound/everest,es8316.yaml
>> @@ -0,0 +1,49 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/sound/everest,es8316.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Everest ES8316 audio CODEC
>> +
>> +maintainers:
>> +  - Mark Brown <broonie@kernel.org>
> 
> Should be someone who knows and cares about the h/w which is not Mark.
> 

OK, so set first committer Daniel and me (I can check codes on real device)
to maintainers.

Best Regards,
Katsuhiro Suzuki


>> +
>> +properties:
>> +  compatible:
>> +    const: everest,es8316
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: clock for master clock (MCLK)
>> +
>> +  clock-names:
>> +    items:
>> +      - const: mclk
>> +
>> +  "#sound-dai-cells":
>> +    const: 0
>> +
>> +required:
>> +  - compatible
>> +  - reg
>> +  - "#sound-dai-cells"
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    i2c0 {
>> +      #address-cells = <1>;
>> +      #size-cells = <0>;
>> +      es8316: codec@11 {
>> +        compatible = "everest,es8316";
>> +        reg = <0x11>;
>> +        clocks = <&clks 10>;
>> +        clock-names = "mclk";
>> +        #sound-dai-cells = <0>;
>> +      };
>> +    };
>> -- 
>> 2.27.0
>>

