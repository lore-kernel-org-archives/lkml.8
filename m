Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4791C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:50:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA06720639
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbgHRGuL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:50:11 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52104 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbgHRGuJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:50:09 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 33B4020B6310118DD2DE;
        Tue, 18 Aug 2020 14:50:06 +0800 (CST)
Received: from [127.0.0.1] (10.108.235.113) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 14:49:56 +0800
Subject: Re: [PATCH 1/2] kexec: Add quick kexec support for kernel
To:     Pavel Machek <pavel@ucw.cz>
CC:     <kexec@lists.infradead.org>, <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <guohanjun@huawei.com>, <zhuling8@huawei.com>,
        <luanjianhai@huawei.com>, <luchunhua@huawei.com>
References: <20200814055239.47348-1-sangyan@huawei.com>
 <20200817134224.GA8381@bug>
From:   Sang Yan <sangyan@huawei.com>
Message-ID: <97b12762-cee1-67fd-2c6f-b0bfe1cf14fc@huawei.com>
Date:   Tue, 18 Aug 2020 14:49:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200817134224.GA8381@bug>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.108.235.113]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/17/2020 9:42 PM, Pavel Machek wrote:
> Hi!
> 
>> +config QUICK_KEXEC
>> +	bool "Support for quick kexec"
>> +	depends on KEXEC_CORE
>> +	help
>> +	  Say y here to enable this feature.
> 
> ?
> 
>> +	  It use reserved memory to accelerate kexec, just like crash
> 
> uses
> 
>> +	  kexec, load new kernel and initrd to reserved memory, and
>> +	  boot new kernel on that memory. It will save the time of
>> +	  relocating kernel.
> 
> loads a new.... boots new... 
> 
>>  	IORES_DESC_DEVICE_PRIVATE_MEMORY	= 6,
>>  	IORES_DESC_RESERVED			= 7,
>>  	IORES_DESC_SOFT_RESERVED		= 8,
>> +#ifdef CONFIG_QUICK_KEXEC
>> +	IORES_DESC_QUICK_KEXEC			= 9,
>> +#endif
>>  };
> 
> Remove ifdef.
> 
>>  /*
>> diff --git a/include/linux/kexec.h b/include/linux/kexec.h
>> index 9e93bef52968..976bf9631070 100644
>> --- a/include/linux/kexec.h
>> +++ b/include/linux/kexec.h
>> @@ -269,9 +269,12 @@ struct kimage {
>>  	unsigned long control_page;
>>  
>>  	/* Flags to indicate special processing */
>> -	unsigned int type : 1;
>> +	unsigned int type : 2;
>>  #define KEXEC_TYPE_DEFAULT 0
>>  #define KEXEC_TYPE_CRASH   1
>> +#ifdef CONFIG_QUICK_KEXEC
>> +#define KEXEC_TYPE_QUICK   2
>> +#endif
>>  	unsigned int preserve_context : 1;
> 
> Here, too.
> 
>> +++ b/include/uapi/linux/kexec.h
>> @@ -12,6 +12,9 @@
>>  /* kexec flags for different usage scenarios */
>>  #define KEXEC_ON_CRASH		0x00000001
>>  #define KEXEC_PRESERVE_CONTEXT	0x00000002
>> +#ifdef CONFIG_QUICK_KEXEC
>> +#define KEXEC_QUICK		0x00000004
>> +#endif
>>  #define KEXEC_ARCH_MASK		0xffff0000
> 
> And here.
> 
> 									Pavel
> 
> .
> 

Thanks a lot for your review.

Sang Yan.

