Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E3C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:48:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B626E22482
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 14:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgGTOsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 10:48:33 -0400
Received: from out28-173.mail.aliyun.com ([115.124.28.173]:45415 "EHLO
        out28-173.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbgGTOsd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 10:48:33 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07615998|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0141358-0.000548583-0.985316;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03267;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I4szUVB_1595256433;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I4szUVB_1595256433)
          by smtp.aliyun-inc.com(10.147.42.135);
          Mon, 20 Jul 2020 22:47:14 +0800
Subject: Re: [PATCH v8 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200719114247.56100-1-zhouyanjie@wanyeetech.com>
 <20200719114247.56100-2-zhouyanjie@wanyeetech.com>
 <53448115-2aa0-0aa0-03d8-a5993e8c84e9@linaro.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <5b0e6a88-8eb4-a0e2-3c68-ee606635ecc3@wanyeetech.com>
Date:   Mon, 20 Jul 2020 22:47:13 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <53448115-2aa0-0aa0-03d8-a5993e8c84e9@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

在 2020/7/20 下午3:56, Daniel Lezcano 写道:
> On 19/07/2020 13:42, 周琰杰 (Zhou Yanjie) wrote:
>> Add the OST bindings for the X10000 SoC from Ingenic.
>
> Description: [v8,1/2] dt-bindings: timer: Add Ingenic X1000 OST bindings.
> Applying: dt-bindings: timer: Add Ingenic X1000 OST bindings.
> .git/rebase-apply/patch:91: space before tab in indent.
>      		compatible = "ingenic,x1000-ost";
> .git/rebase-apply/patch:92: space before tab in indent.
>      		reg = <0x12000000 0x3c>;
> .git/rebase-apply/patch:94: space before tab in indent.
>      		#clock-cells = <1>;
> .git/rebase-apply/patch:96: space before tab in indent.
>      		clocks = <&cgu X1000_CLK_OST>;
> .git/rebase-apply/patch:97: space before tab in indent.
>      		clock-names = "ost";
> warning: squelched 3 whitespace errors
> warning: 8 lines add whitespace errors.
>

OK, I will fix this and send v9.

Thanks and best regards!


>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> Notes:
>>      v1->v2:
>>      No change.
>>      
>>      v2->v3:
>>      Fix wrong parameters in "clocks".
>>      
>>      v3->v4:
>>      1.Rename "ingenic,ost.yaml" to "ingenic,sysost.yaml".
>>      2.Rename "ingenic,ost.h" to "ingenic,sysost.h".
>>      3.Modify the description in "ingenic,sysost.yaml".
>>      
>>      v4->v5:
>>      No change.
>>      
>>      v5->v6:
>>      1.Drop "oneOf" and the blank line.
>>      2.Add "additionalProperties: false".
>>      
>>      v6->v7:
>>      No change.
>>      
>>      v7->v8:
>>      No change.
>>
>>   .../devicetree/bindings/timer/ingenic,sysost.yaml  | 63 ++++++++++++++++++++++
>>   include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
>>   2 files changed, 75 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>>   create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
>>
>> diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>> new file mode 100644
>> index 000000000000..1dae2e538725
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>> @@ -0,0 +1,63 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/timer/ingenic,sysost.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for SYSOST in Ingenic XBurst family SoCs
>> +
>> +maintainers:
>> +  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> +
>> +description:
>> +  The SYSOST in an Ingenic SoC provides one 64bit timer for clocksource
>> +  and one or more 32bit timers for clockevent.
>> +
>> +properties:
>> +  "#size-cells":
>> +    const: 1
>> +
>> +  compatible:
>> +    enum:
>> +      - ingenic,x1000-ost
>> +      - ingenic,x2000-ost
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: ost
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#clock-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +
>> +additionalProperties: false
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/x1000-cgu.h>
>> +
>> +    ost: timer@12000000 {
>> +    		compatible = "ingenic,x1000-ost";
>> +    		reg = <0x12000000 0x3c>;
>> +
>> +    		#clock-cells = <1>;
>> +
>> +    		clocks = <&cgu X1000_CLK_OST>;
>> +    		clock-names = "ost";
>> +
>> +    		interrupt-parent = <&cpuintc>;
>> +    		interrupts = <3>;
>> +    	};
>> +...
>> diff --git a/include/dt-bindings/clock/ingenic,sysost.h b/include/dt-bindings/clock/ingenic,sysost.h
>> new file mode 100644
>> index 000000000000..9ac88e90babf
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/ingenic,sysost.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This header provides clock numbers for the ingenic,tcu DT binding.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>> +#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>> +
>> +#define OST_CLK_PERCPU_TIMER	0
>> +#define OST_CLK_GLOBAL_TIMER	1
>> +
>> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
>>
>
