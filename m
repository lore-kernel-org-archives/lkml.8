Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7232C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E5E206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 10:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgHNKaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 06:30:24 -0400
Received: from mail.loongson.cn ([114.242.206.163]:44742 "EHLO loongson.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726893AbgHNKaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 06:30:20 -0400
Received: from [10.130.0.97] (unknown [113.200.148.30])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9Dx_9yxZzZfHeUIAA--.176S3;
        Fri, 14 Aug 2020 18:30:10 +0800 (CST)
Subject: Re: [PATCH v2] seqlock: Fix build errors
To:     Peter Zijlstra <peterz@infradead.org>
References: <1597378358-2546-1-git-send-email-suxingxing@loongson.cn>
 <20200814083552.GE3982@worktop.programming.kicks-ass.net>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org
From:   Xingxing Su <suxingxing@loongson.cn>
Message-ID: <b9a75f44-53a6-2546-2871-ccec0a52c13a@loongson.cn>
Date:   Fri, 14 Aug 2020 18:30:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux mips64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20200814083552.GE3982@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9Dx_9yxZzZfHeUIAA--.176S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tFy3tr1UAr1Duw4xGr4DJwb_yoW8ur13pa
        ykCF1kKr4rWrWUZFnIkaySy3W0q3y5GFy2qFy2g34UZFy7tF1kXrs2vrn0yF18Zrs2ka10
        gF9xWay5WrWUZFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwV
        C2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
        0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Cr0_Gr
        1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487
        MxkIecxEwVAFwVW8twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s
        026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_
        JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20x
        vEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280
        aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43
        ZEXa7IU5hqXtUUUUU==
X-CM-SenderInfo: pvx0x0xj0l0wo6or00hjvr0hdfq/1tbiAQAIC13QvMMVVgABsy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/14/2020 04:35 PM, Peter Zijlstra wrote:

> On Fri, Aug 14, 2020 at 12:12:38PM +0800, Xingxing Su wrote:
>> Fix the following build errors:
>>
>> In file included from ./include/linux/time.h:6:0,
>>                   from ./include/linux/compat.h:10,
>>                   from arch/mips/kernel/asm-offsets.c:12:
>> ./include/linux/seqlock.h: In function ‘write_seqcount_begin_nested’:
>> ./include/linux/seqlock.h:286:2: error: implicit declaration of function
>>   ‘raw_smp_processor_id’ [-Werror=implicit-function-declaration]
>>    lockdep_assert_preemption_disabled();
>>    ^
>> ./arch/mips/include/asm/smp.h: At top level:
>> ./arch/mips/include/asm/smp.h:28:19: error: static declaration of
>>   ‘raw_smp_processor_id’ follows non-static declaration
>>   static inline int raw_smp_processor_id(void)
>>                   ^
>> cc1: some warnings being treated as errors
>> scripts/Makefile.build:117: recipe for target 'arch/mips/kernel/asm-offsets.s' failed
>> make[1]: *** [arch/mips/kernel/asm-offsets.s] Error 1
>> arch/mips/Makefile:396: recipe for target 'archprepare' failed
>> make: *** [archprepare] Error 2
>>
> What kernel are you building?
>
> Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")
>
> should have solved that I think.
>
>> Signed-off-by: Xingxing Su <suxingxing@loongson.cn>
>> ---
>>   v2:  update the commit message
>>
>>   include/linux/seqlock.h | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
>> index 54bc204..4763c13 100644
>> --- a/include/linux/seqlock.h
>> +++ b/include/linux/seqlock.h
>> @@ -17,6 +17,7 @@
>>   #include <linux/lockdep.h>
>>   #include <linux/compiler.h>
>>   #include <linux/kcsan-checks.h>
>> +#include <linux/smp.h>
>>   #include <asm/processor.h>
> Wrong place, it's lockdep_assert_preemption_disabled() that requires
> asm/percpu.h, and thus lockdep.h should include linux/smp. before
> asm/percpu.h

Thanks for your reply, I will check it.

