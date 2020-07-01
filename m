Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F59C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:54:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D7452078A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732786AbgGAQx7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:53:59 -0400
Received: from out28-97.mail.aliyun.com ([115.124.28.97]:55460 "EHLO
        out28-97.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732478AbgGAQx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:53:57 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06444931|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0121749-0.000458275-0.987367;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03302;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.Hvx6e5p_1593622427;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Hvx6e5p_1593622427)
          by smtp.aliyun-inc.com(10.147.41.137);
          Thu, 02 Jul 2020 00:53:48 +0800
Subject: Re: [PATCH v3 1/2] dt-bindings: timer: Add Ingenic X1000 OST
 bindings.
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com
References: <20200630171553.70670-1-zhouyanjie@wanyeetech.com>
 <20200630171553.70670-2-zhouyanjie@wanyeetech.com>
 <LT6RCQ.V5ANBLLSA4OD3@crapouillou.net>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <808ce8df-6e25-8f1b-4db3-718267fe4498@wanyeetech.com>
Date:   Thu, 2 Jul 2020 00:53:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <LT6RCQ.V5ANBLLSA4OD3@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

在 2020/7/1 上午3:15, Paul Cercueil 写道:
> Hi Zhou,
>
> Le mer. 1 juil. 2020 à 1:15, 周琰杰 (Zhou Yanjie) 
> <zhouyanjie@wanyeetech.com> a écrit :
>> Add the OST bindings for the X10000 SoC from Ingenic.
>>
>> Tested-by: 周正 (Zhou Zheng) <sernia.zhou@foxmail.com>
>> Signed-off-by: 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> ---
>>
>> Notes:
>>     v1->v2:
>>     No change.
>>
>>     v2->v3:
>>     Fix wrong parameters in "clocks".
>>
>>  .../devicetree/bindings/timer/ingenic,ost.yaml     | 61 
>> ++++++++++++++++++++++
>>  include/dt-bindings/clock/ingenic,ost.h            | 12 +++++
>
> Please name them ingenic,sysost.yaml and ingenic,sysost.h, to 
> differenciate with the OST that is in the JZ SoCs.
>

Sure.


>>  2 files changed, 73 insertions(+)
>>  create mode 100644 
>> Documentation/devicetree/bindings/timer/ingenic,ost.yaml
>>  create mode 100644 include/dt-bindings/clock/ingenic,ost.h
>>
>> diff --git a/Documentation/devicetree/bindings/timer/ingenic,ost.yaml 
>> b/Documentation/devicetree/bindings/timer/ingenic,ost.yaml
>> new file mode 100644
>> index 000000000000..459dd3d161c2
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/timer/ingenic,ost.yaml
>> @@ -0,0 +1,61 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/timer/ingenic,ost.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Bindings for SYSOST in Ingenic XBurst family SoCs
>> +
>> +maintainers:
>> +  - 周琰杰 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> +
>> +description:
>> +  The SYSOST in an Ingenic SoC provides one 64bit timer for clocksource
>> +  and one or more than one 32bit timers for clockevent.
>
> "and one or more than one" -> "and one or more"
>

OK, I'll change it in the next version.


>> +
>> +properties:
>> +  compatible:
>> +    oneOf:
>> +
>> +      - description: SYSOST in Ingenic XBurst family SoCs
>
> XBurst is the name of the CPU, not a SoC family, so you would just 
> write 'Ingenic SoCs'. But just drop the description alltogether, it 
> does not add anything valuable.
>

Sure.


>> +        enum:
>> +          - ingenic,x1000-ost
>> +          - ingenic,x2000-ost
>
> You have "ingenic,x2000-ost" as a compatible string, but your driver 
> (in patch [2/2]) only handles the first compatible string. Either they 
> are different, in this case the driver should handle both, or they 
> work the same, and in the case the "ingenic,x2000-ost" string should 
> use "ingenic,x1000-ost" as a fallback string.
>

If SMT is not turned on, X2000 can be compatible with X1000, but if SMT 
is turned on, some additional processing is required, and now this 
compatible string is reserved for this.

Thanks and best regards!


> Cheers,
> -Paul
>
>> +
>> +  reg:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    maxItems: 1
>> +
>> +  clock-names:
>> +    const: ost
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +required:
>> +  - "#clock-cells"
>> +  - compatible
>> +  - reg
>> +  - clocks
>> +  - clock-names
>> +  - interrupts
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/clock/x1000-cgu.h>
>> +
>> +    ost: timer@12000000 {
>> +            compatible = "ingenic,x1000-ost";
>> +            reg = <0x12000000 0x3c>;
>> +
>> +            #clock-cells = <1>;
>> +
>> +            clocks = <&cgu X1000_CLK_OST>;
>> +            clock-names = "ost";
>> +
>> +            interrupt-parent = <&cpuintc>;
>> +            interrupts = <3>;
>> +        };
>> +...
>> diff --git a/include/dt-bindings/clock/ingenic,ost.h 
>> b/include/dt-bindings/clock/ingenic,ost.h
>> new file mode 100644
>> index 000000000000..9ac88e90babf
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/ingenic,ost.h
>> @@ -0,0 +1,12 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * This header provides clock numbers for the ingenic,tcu DT binding.
>> + */
>> +
>> +#ifndef __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>> +#define __DT_BINDINGS_CLOCK_INGENIC_OST_H__
>> +
>> +#define OST_CLK_PERCPU_TIMER    0
>> +#define OST_CLK_GLOBAL_TIMER    1
>> +
>> +#endif /* __DT_BINDINGS_CLOCK_INGENIC_OST_H__ */
>> -- 
>> 2.11.0
>>
>
