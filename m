Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDBBC83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:03:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA98B206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 05:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD1FDw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 01:03:52 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:56748 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726042AbgD1FDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 01:03:52 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01355;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0Twv3vt5_1588050229;
Received: from 30.27.118.60(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Twv3vt5_1588050229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Apr 2020 13:03:49 +0800
Subject: Re: [PATCH] module: Allow to disable modsign in kernel cmdline
To:     Randy Dunlap <rdunlap@infradead.org>, jeyu@kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20200428034310.44035-1-tianjia.zhang@linux.alibaba.com>
 <713892bf-ffe8-8cfd-b2c5-7090626c02fe@infradead.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <546660e1-6128-95a1-fbfe-10a9d3b0f6fb@linux.alibaba.com>
Date:   Tue, 28 Apr 2020 13:03:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <713892bf-ffe8-8cfd-b2c5-7090626c02fe@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/28 11:47, Randy Dunlap wrote:
> On 4/27/20 8:43 PM, Tianjia Zhang wrote:
>> This change allows to disable modsign completely at the beginning,
>> and turn off by set the kernel cmdline `no_modsig_enforce` when
>> CONFIG_MODULE_SIG_FORCE is enabled.
>>
>> Yet another change allows to always show the current status of
>> modsign through `/sys/module/module/parameters/sig_enforce`.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>   kernel/module.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/kernel/module.c b/kernel/module.c
>> index 646f1e2330d2..0e68e1286377 100644
>> --- a/kernel/module.c
>> +++ b/kernel/module.c
>> @@ -269,6 +269,14 @@ static void module_assert_mutex_or_preempt(void)
>>   
>>   static bool sig_enforce = IS_ENABLED(CONFIG_MODULE_SIG_FORCE);
>>   module_param(sig_enforce, bool_enable_only, 0644);
>> +#ifdef CONFIG_MODULE_SIG_FORCE
>> +static int __init set_no_modsig_enforce(char *str)
>> +{
>> +	sig_enforce = false;
>> +	return 1;
>> +}
>> +__setup("no_modsig_enforce", set_no_modsig_enforce);
>> +#endif /* !CONFIG_MODULE_SIG_FORCE */
>>   
>>   /*
>>    * Export sig_enforce kernel cmdline parameter to allow other subsystems rely
>>
> 
> Hi,
> Please document this cmdline option, probably in
> Documentation/admin-guide/kernel-parameters.txt.
> 
> thanks.
> 

Thanks for your information, I will submit a v2 patch.

Thanks and best,
Tianjia
