Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05518C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAAEA206D4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgEPIrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:47:13 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4799 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbgEPIrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:47:12 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 7880A39151B447A1EF14;
        Sat, 16 May 2020 16:47:11 +0800 (CST)
Received: from [10.166.215.145] (10.166.215.145) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 16:47:08 +0800
Subject: Re: [PATCH 2/4] arm64: Extract kprobes_save_local_irqflag() and
 kprobes_restore_local_irqflag()
To:     Doug Anderson <dianders@chromium.org>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
 <20200509214159.19680-3-liwei391@huawei.com>
 <CAD=FV=VVz4QnQ6AWAsCMxw6Zne6es0omvJ--Gnag=PXkMPt42g@mail.gmail.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <d5bb9ccf-6047-13d9-45b3-18421629e83f@huawei.com>
Date:   Sat, 16 May 2020 16:47:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=VVz4QnQ6AWAsCMxw6Zne6es0omvJ--Gnag=PXkMPt42g@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On 2020/5/14 8:21, Doug Anderson wrote:
(SNIP)
>> +/*
>> + * Interrupts need to be disabled before single-step mode is set, and not
>> + * reenabled until after single-step mode ends.
>> + * Without disabling interrupt on local CPU, there is a chance of
>> + * interrupt occurrence in the period of exception return and  start of
>> + * out-of-line single-step, that result in wrongly single stepping
>> + * into the interrupt handler.
>> + */
>> +void kernel_prepare_single_step(unsigned long *flags,
>> +                                               struct pt_regs *regs)
>> +{
>> +       *flags = regs->pstate & DAIF_MASK;
>> +       regs->pstate |= PSR_I_BIT;
>> +       /* Unmask PSTATE.D for enabling software step exceptions. */
>> +       regs->pstate &= ~PSR_D_BIT;
>> +}
>> +NOKPROBE_SYMBOL(kernel_prepare_single_step);
> 
> nit: why not just return unsigned long rather than passing by reference?
Because i just extract this function from kprobes_save_local_irqflag(), i think
return unsigned long is fine.

> 
>> +
>> +void kernel_cleanup_single_step(unsigned long flags,
>> +                                               struct pt_regs *regs)
>> +{
>> +       regs->pstate &= ~DAIF_MASK;
>> +       regs->pstate |= flags;
>> +}
>> +NOKPROBE_SYMBOL(kernel_cleanup_single_step);
>> +
>>  /* ptrace API */
>>  void user_enable_single_step(struct task_struct *task)
>>  {
>> diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
>> index d1c95dcf1d78..c655b6b543e3 100644
>> --- a/arch/arm64/kernel/probes/kprobes.c
>> +++ b/arch/arm64/kernel/probes/kprobes.c
>> @@ -168,30 +168,6 @@ static void __kprobes set_current_kprobe(struct kprobe *p)
>>         __this_cpu_write(current_kprobe, p);
>>  }
>>
>> -/*
>> - * Interrupts need to be disabled before single-step mode is set, and not
>> - * reenabled until after single-step mode ends.
>> - * Without disabling interrupt on local CPU, there is a chance of
>> - * interrupt occurrence in the period of exception return and  start of
>> - * out-of-line single-step, that result in wrongly single stepping
>> - * into the interrupt handler.
>> - */
>> -static void __kprobes kprobes_save_local_irqflag(struct kprobe_ctlblk *kcb,
>> -                                               struct pt_regs *regs)
>> -{
>> -       kcb->saved_irqflag = regs->pstate & DAIF_MASK;
>> -       regs->pstate |= PSR_I_BIT;
>> -       /* Unmask PSTATE.D for enabling software step exceptions. */
>> -       regs->pstate &= ~PSR_D_BIT;
>> -}
>> -
>> -static void __kprobes kprobes_restore_local_irqflag(struct kprobe_ctlblk *kcb,
>> -                                               struct pt_regs *regs)
>> -{
>> -       regs->pstate &= ~DAIF_MASK;
>> -       regs->pstate |= kcb->saved_irqflag;
>> -}
>> -
>>  static void __kprobes
>>  set_ss_context(struct kprobe_ctlblk *kcb, unsigned long addr)
>>  {
>> @@ -227,7 +203,7 @@ static void __kprobes setup_singlestep(struct kprobe *p,
>>                 set_ss_context(kcb, slot);      /* mark pending ss */
>>
>>                 /* IRQs and single stepping do not mix well. */
>> -               kprobes_save_local_irqflag(kcb, regs);
>> +               kernel_prepare_single_step(&kcb->saved_irqflag, regs);
> 
> Is there some reason to have two functions?  It seems like every time
> you call kernel_enable_single_step() you'd want to call
> kernel_prepare_single_step().  ...and every time you call
> kernel_disable_single_step() you'd want to call
> kernel_cleanup_single_step().
> 
> Maybe you can just add the flags parameter to
> kernel_enable_single_step() / kernel_disable_single_step() and put the
> code in there?
> 

As kernel_enable_single_step() / kernel_disable_single_step() are also called in
breakpoint_handler() and watchpoint_handler(), i am not sure it's a right thing
to put the daif flag prepare/cleanup into them, especially we don't have a context
to save the flags.

Thanks,
Wei
