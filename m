Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D17C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB4B20888
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:27:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729520AbgE0I1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:27:41 -0400
Received: from out28-220.mail.aliyun.com ([115.124.28.220]:50240 "EHLO
        out28-220.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgE0I1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:27:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08245211|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0548406-0.00016241-0.944997;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16368;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=11;RT=11;SR=0;TI=SMTPD_---.HeHIDqW_1590568053;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.HeHIDqW_1590568053)
          by smtp.aliyun-inc.com(10.147.44.145);
          Wed, 27 May 2020 16:27:34 +0800
Subject: Re: [PATCH v10 3/6] dt-bindings: clock: Add X1830 bindings.
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200526144044.71413-1-zhouyanjie@wanyeetech.com>
 <20200526144044.71413-5-zhouyanjie@wanyeetech.com>
 <159056716225.88029.7227987261941853085@swboyd.mtv.corp.google.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <19e7793b-c7d1-e91f-c1d9-f3e7f6112360@wanyeetech.com>
Date:   Wed, 27 May 2020 16:27:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <159056716225.88029.7227987261941853085@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

在 2020/5/27 下午4:12, Stephen Boyd 写道:
> Quoting 周琰杰 (Zhou Yanjie) (2020-05-26 07:40:41)
>> Add the clock bindings for the X1830 Soc from Ingenic.
>>
>> Signed-off-by: \u5468\u7430\u6770 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> ---
>>
>> Notes:
>>      v2->v3:
>>      Adjust order from [3/5] in v2 to [4/5] in v3.
>>      
>>      v3->v4:
>>      Adjust order from [4/5] in v3 to [3/4] in v4.
>>      
>>      v4->v5:
>>      Rebase on top of kernel 5.6-rc1.
>>      
>>      v5->v6:
>>      Add missing part of X1830's CGU.
>>      
>>      v6->v7:
>>      No change.
>>      
>>      v7->v8:
>>      Rebase on top of linux-next.
>>      
>>      v8->v9:
>>      No change.
>>      
>>      v9->v10:
>>      Add missing "X1830_CLK_TCU".
>>
>>   .../devicetree/bindings/clock/ingenic,cgu.yaml     |  2 +
>>   include/dt-bindings/clock/x1830-cgu.h              | 55 ++++++++++++++++++++++
>>   2 files changed, 57 insertions(+)
>>   create mode 100644 include/dt-bindings/clock/x1830-cgu.h
>>
>> diff --git a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
> This file is in Rob's DT tree staged for the next release, not in the
> clk tree. Can you split this patch into two, one for the compatible
> update and another for the header file update and send again? Then Rob
> can pick up the yaml file change and I can pick up the header file
> change.


OK, I will do it right away.


Thansk and best regards!


>> index 0281cd1d7e1b..a952d5811823 100644
>> --- a/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
>> +++ b/Documentation/devicetree/bindings/clock/ingenic,cgu.yaml
>> @@ -25,6 +25,7 @@ select:
>>             - ingenic,jz4770-cgu
>>             - ingenic,jz4780-cgu
>>             - ingenic,x1000-cgu
>> +          - ingenic,x1830-cgu
>>     required:
>>       - compatible
>>   
>> @@ -51,6 +52,7 @@ properties:
>>           - ingenic,jz4770-cgu
>>           - ingenic,jz4780-cgu
>>           - ingenic,x1000-cgu
>> +        - ingenic,x1830-cgu
>>         - const: simple-mfd
>>       minItems: 1
>>
