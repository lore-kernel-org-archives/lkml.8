Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372BAC433E7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:47:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12B28206C1
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 16:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgGVQrq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 12:47:46 -0400
Received: from out28-74.mail.aliyun.com ([115.124.28.74]:60643 "EHLO
        out28-74.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbgGVQrp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:47:45 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1401843|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0100466-0.000167862-0.989786;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.I6-TcvX_1595436459;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.I6-TcvX_1595436459)
          by smtp.aliyun-inc.com(10.147.40.7);
          Thu, 23 Jul 2020 00:47:40 +0800
Subject: Re: [PATCH v10 0/2] Add support for the OST in Ingenic X1000.
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        tglx@linutronix.de, dongsheng.qiu@ingenic.com,
        aric.pzqi@ingenic.com, rick.tyliu@ingenic.com,
        yanfei.li@ingenic.com, sernia.zhou@foxmail.com,
        zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200720173134.22826-1-zhouyanjie@wanyeetech.com>
 <6aca88ad-1e20-97da-effe-fa5a4cec789c@linaro.org>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <0ace68b6-9d75-8b8f-c108-89863cb6d03d@wanyeetech.com>
Date:   Thu, 23 Jul 2020 00:47:39 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <6aca88ad-1e20-97da-effe-fa5a4cec789c@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Daniel,

在 2020/7/21 下午8:53, Daniel Lezcano 写道:
> On 20/07/2020 19:31, 周琰杰 (Zhou Yanjie) wrote:
>> v9->v10:
>> Fix errors which case "make dt_binding_check" failed.
>>
>> 周琰杰 (Zhou Yanjie) (2):
>>    dt-bindings: timer: Add Ingenic X1000 OST bindings.
>>    clocksource: Ingenic: Add support for the Ingenic X1000 OST.
>>
>>   .../devicetree/bindings/timer/ingenic,sysost.yaml  |  63 +++
>>   drivers/clocksource/Kconfig                        |  12 +-
>>   drivers/clocksource/Makefile                       |   1 +
>>   drivers/clocksource/ingenic-sysost.c               | 539 +++++++++++++++++++++
>>   include/dt-bindings/clock/ingenic,sysost.h         |  12 +
>>   5 files changed, 626 insertions(+), 1 deletion(-)
>>   create mode 100644 Documentation/devicetree/bindings/timer/ingenic,sysost.yaml
>>   create mode 100644 drivers/clocksource/ingenic-sysost.c
>>   create mode 100644 include/dt-bindings/clock/ingenic,sysost.h
> Applied, thanks


I'm very sorry, I found some typos in this series, do I need to send a 
v11 to fix these typos?

Thanks and best regards!


>
>    -- Daniel
>
