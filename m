Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2694C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF838206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 06:01:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgD1GBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 02:01:42 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38964 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725792AbgD1GBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 02:01:42 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0Twvsm2a_1588053698;
Received: from 30.27.118.60(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Twvsm2a_1588053698)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Apr 2020 14:01:38 +0800
Subject: Re: [PATCH v2] module: Allow to disable modsign in kernel cmdline
To:     Randy Dunlap <rdunlap@infradead.org>, jeyu@kernel.org,
        corbet@lwn.net, mchehab+samsung@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, gregkh@linuxfoundation.org,
        pawan.kumar.gupta@linux.intel.com, jgross@suse.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20200428050523.47253-1-tianjia.zhang@linux.alibaba.com>
 <aff03dbb-a1a3-c95e-1c24-60279b14970a@infradead.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <aecb37fd-e99e-c6e2-ac80-ccf1ae2b0295@linux.alibaba.com>
Date:   Tue, 28 Apr 2020 14:01:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <aff03dbb-a1a3-c95e-1c24-60279b14970a@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/28 13:52, Randy Dunlap wrote:
> Hi,
> 
> On 4/27/20 10:05 PM, Tianjia Zhang wrote:
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 7bc83f3d9bdf..00ed7566959f 100644
>> --- a/Documentation/admin-guide/kernel-parameters.txt
>> +++ b/Documentation/admin-guide/kernel-parameters.txt
>> @@ -3190,6 +3190,12 @@
>>   	noirqdebug	[X86-32] Disables the code which attempts to detect and
>>   			disable unhandled interrupt sources.
>>   
>> +	no_modsig_enforce
>> +			[KNL] When CONFIG_MODULE_SIG_FORCE is set, this option
>> +			allows to disable modsign completely at the beginning.
>> +			This means that modules without (valid) signatures will
>> +			success to load.
> 
> 			succeed to load.
> 
> 			succeed in loading.
> 
> 			load successfully.
> I prefer this one.....  ^^^^^^^^^^^^^^^^^^^^^
> 
> 			be loaded successfully.
> 
> 
>> +
>>   	no_timer_check	[X86,APIC] Disables the code which tests for
>>   			broken timer IRQ sources.
>>   
> 
> thanks.
> 

v3 patch has been submitted, thank you for your suggestion.

Thanks,
Tianjia
