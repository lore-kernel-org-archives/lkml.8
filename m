Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D706DC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB741207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgGJN5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:57:25 -0400
Received: from out28-125.mail.aliyun.com ([115.124.28.125]:49219 "EHLO
        out28-125.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727810AbgGJN5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:57:20 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08971941|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0141494-0.000549441-0.985301;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16367;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I.g.h-B_1594389435;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I.g.h-B_1594389435)
          by smtp.aliyun-inc.com(10.147.41.178);
          Fri, 10 Jul 2020 21:57:16 +0800
Subject: Re: [PATCH v5 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org,
        paul@crapouillou.net, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com
References: <20200705140353.53093-1-zhouyanjie@wanyeetech.com>
 <20200705140353.53093-2-zhouyanjie@wanyeetech.com>
 <20200709224923.GA1029808@bogus>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <d3d239df-cbd3-e495-a3c2-af3407bfaf73@wanyeetech.com>
Date:   Fri, 10 Jul 2020 21:57:10 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <20200709224923.GA1029808@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

在 2020/7/10 上午6:49, Rob Herring 写道:
> On Sun, Jul 05, 2020 at 10:03:52PM +0800, 周琰杰 (Zhou Yanjie) wrote:
>> Add the OST bindings for the X10000 SoC from Ingenic.
>>
>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> Reviewed-by: Paul Cercueil <paul@crapouillou.net>
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
>>   .../devicetree/bindings/timer/ingenic,sysost.yaml  | 60 ++++++++++++++++++++++
>>   include/dt-bindings/clock/ingenic,sysost.h         | 12 +++++
>>   2 files changed, 72 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>>   create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
>>
>> diff --git a/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>> new file mode 100644
>> index 000000000000..03257ed806fc
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>> @@ -0,0 +1,60 @@
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
>> +  compatible:
>> +    oneOf:
>> +
>> +      - enum:
> Only 1 entry, drop 'oneOf' and the blank line.


Sure.


>> +          - ingenic,x1000-ost
>> +          - ingenic,x2000-ost
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
> additionalProperties: false


Sure.

Thanks and best regards!


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
>> -- 
>> 2.11.0
>>
