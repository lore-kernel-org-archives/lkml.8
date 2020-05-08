Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9A54C35280
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:30:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBCBC21835
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 01:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgEHBaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 21:30:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3905 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726518AbgEHBaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 21:30:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4002391465909247DBE8;
        Fri,  8 May 2020 09:29:33 +0800 (CST)
Received: from [127.0.0.1] (10.166.215.237) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 09:29:25 +0800
Subject: Re: [PATCH] arm64: stacktrace: Factor out some common code info
 on_stack()
To:     Will Deacon <will@kernel.org>
CC:     <catalin.marinas@arm.com>, <Dave.Martin@arm.com>,
        <mark.rutland@arm.com>, <james.morse@arm.com>,
        <0x7f454c46@gmail.com>, <tglx@linutronix.de>,
        <lorenzo.pieralisi@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <hushiyuan@huawei.com>,
        <hewenliang4@huawei.com>
References: <10b188af-a03b-3acc-8a06-cf31a46f735a@huawei.com>
 <20200507135213.GA32706@willie-the-truck>
From:   Yunfeng Ye <yeyunfeng@huawei.com>
Message-ID: <15e31e59-3429-53f8-bb61-5f60c90fa856@huawei.com>
Date:   Fri, 8 May 2020 09:29:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200507135213.GA32706@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.237]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/5/7 21:52, Will Deacon wrote:
> On Thu, May 07, 2020 at 05:28:19PM +0800, Yunfeng Ye wrote:
>> diff --git a/arch/arm64/include/asm/stacktrace.h b/arch/arm64/include/asm/stacktrace.h
>> index fdb913cc0bcb..b92bef2fb6cd 100644
>> --- a/arch/arm64/include/asm/stacktrace.h
>> +++ b/arch/arm64/include/asm/stacktrace.h
>> @@ -69,27 +69,40 @@ extern void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk,
>>
>>  DECLARE_PER_CPU(unsigned long *, irq_stack_ptr);
>>
>> -static inline bool on_irq_stack(unsigned long sp,
>> +static inline bool on_stack(unsigned long sp, unsigned long low,
>> +				unsigned long high, enum stack_type type,
>>  				struct stack_info *info)
>>  {
>> -	unsigned long low = (unsigned long)raw_cpu_read(irq_stack_ptr);
>> -	unsigned long high = low + IRQ_STACK_SIZE;
>> -
>> -	if (!low)
>> -		return false;
>> -
>>  	if (sp < low || sp >= high)
>>  		return false;
>>
>>  	if (info) {
>>  		info->low = low;
>>  		info->high = high;
>> -		info->type = STACK_TYPE_IRQ;
>> +		info->type = type;
>>  	}
>> -
>>  	return true;
>>  }
>>
>> +static inline bool on_valid_stack(unsigned long sp, unsigned long low,
>> +				unsigned long high, enum stack_type type,
>> +				struct stack_info *info)
>> +{
>> +	if (!low)
>> +		return false;
>> +
>> +	return on_stack(sp, low, high, type, info);
>> +}
> 
> Do we need this as distinct from on_stack()? Afaict, 'low' is never
> going to be NULL for the on_stack() callers, so I suggest just having
> on_stack() check 'low' and getting everybody to call that instead.
> 
> Make sense?
> 
ok, I will modify and send the patch v2, thanks.

> Will
> 
> .
> 

