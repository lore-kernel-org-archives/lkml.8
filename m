Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 154B7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF615206B5
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 01:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726517AbgHLBJ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 21:09:58 -0400
Received: from zg8tmty1ljiyny4xntqumjca.icoremail.net ([165.227.154.27]:39133
        "HELO zg8tmty1ljiyny4xntqumjca.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726173AbgHLBJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 21:09:58 -0400
Received: from [192.168.43.246] (unknown [106.19.6.117])
        by c1app4 (Coremail) with SMTP id BAINCgAXOElTQTNfw7QkBA--.26584S2;
        Wed, 12 Aug 2020 09:09:42 +0800 (CST)
Subject: Re: [PATCH] riscv: Setup exception vector for K210 properly
To:     Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>
Cc:     Damien Le Moal <damien.lemoal@wdc.com>,
        Guo Ren <guoren@linux.alibaba.com>,
        Vincent Chen <vincent.chen@sifive.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20200811063659.284088-1-qiuwenbo@phytium.com.cn>
 <CAAhSdy1c=R6aUZ6EOggmJ_Bqm2O0VLKEku=zyFfabExSzOKErA@mail.gmail.com>
 <CAOnJCUJiLVyzMFkn157Zmdrtm66Z=gWmQbXCJiMRY8LCJ3xkaw@mail.gmail.com>
From:   Qiu Wenbo <qiuwenbo@phytium.com.cn>
Message-ID: <a9a36dad-e393-83e2-499e-3454f79813c5@phytium.com.cn>
Date:   Wed, 12 Aug 2020 09:09:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAOnJCUJiLVyzMFkn157Zmdrtm66Z=gWmQbXCJiMRY8LCJ3xkaw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID: BAINCgAXOElTQTNfw7QkBA--.26584S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF18ZF15Zw45uryUXr45Awb_yoWrWF1xp3
        yUCFn0krWFqFyxZ343tw1Fgryavr4DGw13Grs5Ka4rtryqg3sxXr1vq345XFyqqr1Y9r40
        yF409ryS9wn8ArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9lb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
        0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
        A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xII
        jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I
        8E87Iv6xkF7I0E14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
        F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
        4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xK
        xwCYjI0SjxkI62AI1cAE67vIY487MxkIecxEwVAFwVWkMxAIw28IcxkI7VAKI48JMxC20s
        026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
        JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
        v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
        j40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r
        4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUgUKsDUUUU
X-Originating-IP: [106.19.6.117]
X-CM-SenderInfo: 5tlx4vhqerq15k1wx33pof0zgofq/
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

That is a more reasonable approach.

On 8/12/20 2:45 AM, Atish Patra wrote:
> On Tue, Aug 11, 2020 at 1:41 AM Anup Patel <anup@brainfault.org> wrote:
>> On Tue, Aug 11, 2020 at 12:07 PM Qiu Wenbo <qiuwenbo@phytium.com.cn> wrote:
>>> Exception vector is missing on nommu platform and it is a big issue.
>>> This patch is tested in Sipeed MAIX Bit Dev Board.
>>>
>>> Fixes: 79b1feba5455 ("RISC-V: Setup exception vector early")
>>> Signed-off-by: Qiu Wenbo <qiuwenbo@phytium.com.cn>
> Thanks for testing it on the kendryte board.
>
>>> ---
>>>   arch/riscv/kernel/smpboot.c |  1 +
>>>   arch/riscv/kernel/traps.c   | 11 ++++++++++-
>>>   2 files changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
>>> index 356825a57551..23cde0ceb39d 100644
>>> --- a/arch/riscv/kernel/smpboot.c
>>> +++ b/arch/riscv/kernel/smpboot.c
>>> @@ -154,6 +154,7 @@ asmlinkage __visible void smp_callin(void)
>>>          mmgrab(mm);
>>>          current->active_mm = mm;
>>>
>>> +       trap_init();
>>>          notify_cpu_starting(curr_cpuid);
>>>          update_siblings_masks(curr_cpuid);
>>>          set_cpu_online(curr_cpuid, 1);
>>> diff --git a/arch/riscv/kernel/traps.c b/arch/riscv/kernel/traps.c
>>> index ad14f4466d92..a390239818ae 100644
>>> --- a/arch/riscv/kernel/traps.c
>>> +++ b/arch/riscv/kernel/traps.c
>>> @@ -174,7 +174,16 @@ int is_valid_bugaddr(unsigned long pc)
>>>   }
>>>   #endif /* CONFIG_GENERIC_BUG */
>>>
>>> -/* stvec & scratch is already set from head.S */
>>> +/* stvec & scratch is already set from head.S when mmu is enabled */
>>>   void trap_init(void)
>>>   {
>>> +#ifndef CONFIG_MMU
>>> +       /*
>>> +        * Set sup0 scratch register to 0, indicating to exception vector
>>> +        * that we are presently executing in the kernel
>>> +        */
>>> +       csr_write(CSR_SCRATCH, 0);
>>> +       /* Set the exception vector address */
>>> +       csr_write(CSR_TVEC, &handle_exception);
>>> +#endif
>>>   }
>>> --
>>> 2.28.0
>>>
>> This issue seems to be only on the latest master branch of
>> Linux stable tree so this fix need not be a stable fix.
>>
>> For MMU kernel, the CSR_TVEC is setup in relocate() function
>> called from secondary_start_common() function of head.S
>>
>> For NoMMU kernel, we should set CSR_TVEC directly in
>> secondary_start_common() function as "#else" case of the
>> "#ifdef CONFIG_MMU".
>>
> That would enable the trap only for secondary harts. But the exception
> vector on boot hart
> is still uninitialized. How about this change ?
>
> diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
> index d0c5c316e9bb..7822054dbd88 100644
> --- a/arch/riscv/kernel/head.S
> +++ b/arch/riscv/kernel/head.S
> @@ -77,16 +77,6 @@ relocate:
>          csrw CSR_SATP, a0
>   .align 2
>   1:
> -       /* Set trap vector to exception handler */
> -       la a0, handle_exception
> -       csrw CSR_TVEC, a0
> -
> -       /*
> -        * Set sup0 scratch register to 0, indicating to exception vector that
> -        * we are presently executing in kernel.
> -        */
> -       csrw CSR_SCRATCH, zero
> -
>          /* Reload the global pointer */
>   .option push
>   .option norelax
> @@ -144,9 +134,23 @@ secondary_start_common:
>          la a0, swapper_pg_dir
>          call relocate
>   #endif
> +       call setup_trap_vector
>          tail smp_callin
>   #endif /* CONFIG_SMP */
>
> +.align 2
> +setup_trap_vector:
> +       /* Set trap vector to exception handler */
> +       la a0, handle_exception
> +       csrw CSR_TVEC, a0
> +
> +       /*
> +        * Set sup0 scratch register to 0, indicating to exception vector that
> +        * we are presently executing in kernel.
> +        */
> +       csrw CSR_SCRATCH, zero
> +       ret
> +
>   .Lsecondary_park:
>          /* We lack SMP support or have too many harts, so park this hart */
>          wfi
> @@ -240,6 +244,7 @@ clear_bss_done:
>          call relocate
>   #endif /* CONFIG_MMU */
>
> +       call setup_trap_vector
>          /* Restore C environment */
>          la tp, init_task
>          sw zero, TASK_TI_CPU(tp)
>
>
>> Regards,
>> Anup
>>
>> _______________________________________________
>> linux-riscv mailing list
>> linux-riscv@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-riscv
>
>

