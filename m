Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 564FDC433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:32:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 417BD208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 09:32:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGNJcw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 05:32:52 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:59548 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725952AbgGNJcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:32:51 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=guoren@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U2i6OKl_1594719159;
Received: from IT-C02Z45M7LVCF.local(mailfrom:guoren@linux.alibaba.com fp:SMTPD_---0U2i6OKl_1594719159)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 14 Jul 2020 17:32:39 +0800
Subject: Re: [PATCH] arm64: Make TSK_STACK_CANARY more accurate defined
To:     Will Deacon <will@kernel.org>, guoren@kernel.org
Cc:     catalin.marinas@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org
References: <1594613013-13059-1-git-send-email-guoren@kernel.org>
 <20200714083715.GE4516@willie-the-truck>
From:   Guo Ren <guoren@linux.alibaba.com>
Message-ID: <d69bbfdb-64a2-aa14-a422-770af9bc68f3@linux.alibaba.com>
Date:   Tue, 14 Jul 2020 17:32:39 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714083715.GE4516@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/7/14 下午4:37, Will Deacon wrote:
> On Mon, Jul 13, 2020 at 04:03:33AM +0000, guoren@kernel.org wrote:
>> From: Guo Ren <guoren@linux.alibaba.com>
>>
>> TSK_STACK_CANARY only used in arm64/Makefile with
>> CONFIG_STACKPROTECTOR_PER_TASK wrap. So use the same policy in
>> asm-offset.c.
>>
>> Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
>> Co-developed-by: Kees Cook <keescook@chromium.org>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> ---
>>   arch/arm64/kernel/asm-offsets.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/kernel/asm-offsets.c b/arch/arm64/kernel/asm-offsets.c
>> index 0577e21..37d5d3d 100644
>> --- a/arch/arm64/kernel/asm-offsets.c
>> +++ b/arch/arm64/kernel/asm-offsets.c
>> @@ -39,7 +39,7 @@ int main(void)
>>     DEFINE(TSK_TI_SCS_SP,		offsetof(struct task_struct, thread_info.scs_sp));
>>   #endif
>>     DEFINE(TSK_STACK,		offsetof(struct task_struct, stack));
>> -#ifdef CONFIG_STACKPROTECTOR
>> +#ifdef CONFIG_STACKPROTECTOR_PER_TASK
>>     DEFINE(TSK_STACK_CANARY,	offsetof(struct task_struct, stack_canary));
>>   #endif
> I don't think this really makese much sense. The 'stack_canary' field in
> 'struct task_struct' is defined as:
>
> #ifdef CONFIG_STACKPROTECTOR
>          /* Canary value for the -fstack-protector GCC feature: */
>          unsigned long                   stack_canary;
> #endif
>
> so I think it makes sense to follow that in asm-offsets.c
>
> Does the current code actually cause a problem?
No, I just want to know how arm64 reply, ref:
https://lore.kernel.org/linux-riscv/1594397998-10221-1-git-send-email-guoren@kernel.org/T/#t

Best Regards
  Guo Ren

