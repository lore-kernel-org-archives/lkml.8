Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4295C83007
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3B96206B9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 07:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD1HHS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 03:07:18 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:45412 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726451AbgD1HHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:07:18 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R331e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0TwvxQov_1588057631;
Received: from 30.27.118.60(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TwvxQov_1588057631)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 28 Apr 2020 15:07:12 +0800
Subject: Re: [PATCH v3] module: Allow to disable modsign in kernel cmdline
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jeyu@kernel.org, corbet@lwn.net, rdunlap@infradead.org,
        mchehab+samsung@kernel.org, tglx@linutronix.de,
        akpm@linux-foundation.org, pawan.kumar.gupta@linux.intel.com,
        jgross@suse.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20200428060008.50417-1-tianjia.zhang@linux.alibaba.com>
 <20200428063522.GA990431@kroah.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <8a0c0ef3-4881-1b9c-6e42-ab379542bc16@linux.alibaba.com>
Date:   Tue, 28 Apr 2020 15:07:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428063522.GA990431@kroah.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/4/28 14:35, Greg KH wrote:
> On Tue, Apr 28, 2020 at 02:00:08PM +0800, Tianjia Zhang wrote:
>> This option allows to disable modsign completely at the beginning,
>> and turn off by set the kernel cmdline `no_modsig_enforce` when
>> `CONFIG_MODULE_SIG_FORCE` is enabled.
>>
>> Yet another change allows to always show the current status of
>> modsign through `/sys/module/module/parameters/sig_enforce`.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
>> ---
>>
>> v3 change:
>>    Beautify the document description according to the recommendation.
>>
>> v2 change:
>>    document this new option.
>>
>>   Documentation/admin-guide/kernel-parameters.txt | 6 ++++++
>>   kernel/module.c                                 | 8 ++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
>> index 7bc83f3d9bdf..b30f013fb8c5 100644
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
>> +			be loaded successfully.
>> +
> 
> So now we have module.sig_enforce and this one?  That feels really
> confusing, why can't you just use the existing option?
> 
> And why would you want to allow the bootloader to override a kernel
> build option like this?  That feels risky.
> 
> thanks,
> 
> greg k-h
> 

If CONFIG_MODULE_SIG_FORCE is set, `module.sig_enforce` is always true 
and read-only. There is indeed a risk in doing this, but it will allow 
the system to boot normally in some emergency situations, such as 
certificate expiration.

On the other hand, would it be a good solution to make 
`module.sig_enforce` readable and writable?

Thanks and best,
Tianjia
