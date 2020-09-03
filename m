Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ED3C433E7
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A18792071B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 10:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgICKFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 06:05:19 -0400
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:44618 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726025AbgICKFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 06:05:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=zoucao@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U7nxhOa_1599127516;
Received: from ali-6c96cfe06eab.local(mailfrom:zoucao@linux.alibaba.com fp:SMTPD_---0U7nxhOa_1599127516)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 18:05:17 +0800
Subject: Re: [PATCH] irqchip/gic-v3: change gic_data into gic_v3_data
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net
References: <1599124088-80231-1-git-send-email-zoucao@linux.alibaba.com>
 <c6eacce9e0990239ee12bfc5826fe2c6@kernel.org>
From:   zc <zoucao@linux.alibaba.com>
Message-ID: <69118106-e6d8-71dc-7004-80fd96b32e54@linux.alibaba.com>
Date:   Thu, 3 Sep 2020 18:05:16 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <c6eacce9e0990239ee12bfc5826fe2c6@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


   thank for you reply.


    of course it won't,   i just think it is better to splite the global 
data between irq-gic and irq-gic-v3.

I wrote some hook module for gic,  kallsyms_lookup_name can't support 
for mutlipte symbol,

i need to call kallsyms scan to get the addr.


   If you think it isn't necessary, well for me.


Regards,

zou cao

在 2020/9/3 下午5:55, Marc Zyngier 写道:
> On 2020-09-03 10:08, Zou Cao wrote:
>> There are multiple gic_data symbol between irq_gic.c and irq_gic_v3.c,
>> we can see the same symbol name:
>>
>>     cat /proc/kallsyms | grep gic_data
>> ------>
>>     ffff80001138f1d0 d gic_data
>>     ffff80001138f940 d gic_data
>>
>> Normally CONFIG_ARM_GIC and CONFIG_ARM_GIC_V3 are all enabled, move
>> the gic_data symbol into different name, it will be friend for
>> kallsyms_lookup_name to get addr easily.
>>
>> Signed-off-by: Zou Cao <zoucao@linux.alibaba.com>
>
> I'm sorry, but this kind of change is not acceptable.
>
> It is pure churn, for zero benefit. As an example, give the following
> script a go:
>
> awk '{ print $3 }' /proc/kallsyms | sort | uniq -c| awk '$1 > 1 
> {print}'| sort -n
>
> Are you going to repaint all these symbols?
>
>         M.
