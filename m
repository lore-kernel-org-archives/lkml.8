Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EF87C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52C2A20C56
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 02:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgE1COk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 22:14:40 -0400
Received: from out28-193.mail.aliyun.com ([115.124.28.193]:51956 "EHLO
        out28-193.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgE1COk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 22:14:40 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1300187|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0398664-0.00233981-0.957794;FP=0|0|0|0|0|-1|-1|-1;HT=e01a16370;MF=zhouyanjie@wanyeetech.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.Hed4cZm_1590632076;
Received: from 192.168.10.205(mailfrom:zhouyanjie@wanyeetech.com fp:SMTPD_---.Hed4cZm_1590632076)
          by smtp.aliyun-inc.com(10.147.41.121);
          Thu, 28 May 2020 10:14:37 +0800
Subject: Re: [PATCH v12 5/7] clk: Ingenic: Add CGU driver for X1830.
To:     Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org,
        dongsheng.qiu@ingenic.com, aric.pzqi@ingenic.com,
        rick.tyliu@ingenic.com, yanfei.li@ingenic.com,
        sernia.zhou@foxmail.com, zhenwenjin@gmail.com, paul@crapouillou.net
References: <20200527175635.5558-1-zhouyanjie@wanyeetech.com>
 <20200527175635.5558-6-zhouyanjie@wanyeetech.com>
 <159062842562.69627.2356351510003565560@swboyd.mtv.corp.google.com>
From:   Zhou Yanjie <zhouyanjie@wanyeetech.com>
Message-ID: <22e6a7a2-36fd-96ea-9084-8fac50b8c6b6@wanyeetech.com>
Date:   Thu, 28 May 2020 10:14:36 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <159062842562.69627.2356351510003565560@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

在 2020/5/28 上午9:13, Stephen Boyd 写道:
> Quoting Zhou Yanjie (2020-05-27 10:56:33)
>> diff --git a/drivers/clk/ingenic/x1830-cgu.c b/drivers/clk/ingenic/x1830-cgu.c
>> new file mode 100644
>> index 000000000000..29a637f4a2cc
>> --- /dev/null
>> +++ b/drivers/clk/ingenic/x1830-cgu.c
>> @@ -0,0 +1,443 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * X1830 SoC CGU driver
>> + * Copyright (c) 2019 \u5468\u7430\u6770 (Zhou Yanjie) <zhouyanjie@wanyeetech.com>
>> + */
>> +
>> +#include <linux/clk-provider.h>
>> +#include <linux/delay.h>
> Add linux/io.h here.


Sure.


>> +#include <linux/of.h>
>> +
>> +#include <dt-bindings/clock/x1830-cgu.h>
>> +
>> +#include "cgu.h"
> [...]
>> +               return;
>> +       }
>> +
>> +       ingenic_cgu_register_syscore_ops(cgu);
>> +}
>> +CLK_OF_DECLARE_DRIVER(x1830_cgu, "ingenic,x1830-cgu", x1830_cgu_init);
> Same question about why this is DECLARE_DRIVER.


CGU has some children devices, this is useful for probing children 
devices in the case where the device node is compatible with 
"simple-mfd" (see commit 03d570e1a4dc for a reference).

Thanks and best regards!


