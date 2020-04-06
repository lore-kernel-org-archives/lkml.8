Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4D2C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24C0F20672
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 18:22:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="niNBguzV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgDFSWA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 14:22:00 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40040 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbgDFSV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 14:21:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48wzQY5jkMz9twdW;
        Mon,  6 Apr 2020 20:21:57 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=niNBguzV; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id WtuRjlw8CWYP; Mon,  6 Apr 2020 20:21:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48wzQY4SPgz9twdL;
        Mon,  6 Apr 2020 20:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586197317; bh=VXmMovTR7szrUn+dOnA7aSwBzyNCJw4deqwcK+8rHWo=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=niNBguzVn3dxAlaCqfcRFoPs8iHx1jrJCmFEHfpSz+GC4mFtM9v4Y+JX2bDjvfI0L
         gMmRGASJxpVBURurbRxULzyvT3eF1CE3FIbDvBgtRl0D61q8CX8c39g+JG5o0CGU36
         ENdEbaT5NtpAI8TPb94SkTXh0WjtvlpHzRjwEaOw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92F188B784;
        Mon,  6 Apr 2020 20:21:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 7BQ58JlTLiHG; Mon,  6 Apr 2020 20:21:57 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id F20498B775;
        Mon,  6 Apr 2020 20:21:56 +0200 (CEST)
Subject: Re: [RFC PATCH v2 06/13] powerpc/syscall: Make syscall_64.c buildable
 on PPC32
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, msuchanek@suse.de,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <029e1064b1ad738785718221ea468c9cfc282457.1586108649.git.christophe.leroy@c-s.fr>
 <923ab2df9d4a4d0f3a072421e054028c18d614d8.1586108649.git.christophe.leroy@c-s.fr>
 <1586137334.pcovkdryot.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <3b9f9335-3390-6439-81a7-196c883cb35f@c-s.fr>
Date:   Mon, 6 Apr 2020 20:21:52 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1586137334.pcovkdryot.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 06/04/2020 à 03:52, Nicholas Piggin a écrit :
> Christophe Leroy's on April 6, 2020 3:44 am:
>> ifdef out specific PPC64 stuff to allow building
>> syscall_64.c on PPC32.
>>
>> Modify Makefile to always build syscall.o
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/kernel/Makefile  |  5 ++---
>>   arch/powerpc/kernel/syscall.c | 10 ++++++++++
>>   2 files changed, 12 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
>> index 8cc3c831dccd..e4be425b7718 100644
>> --- a/arch/powerpc/kernel/Makefile
>> +++ b/arch/powerpc/kernel/Makefile
>> @@ -45,11 +45,10 @@ obj-y				:= cputable.o syscalls.o \
>>   				   signal.o sysfs.o cacheinfo.o time.o \
>>   				   prom.o traps.o setup-common.o \
>>   				   udbg.o misc.o io.o misc_$(BITS).o \
>> -				   of_platform.o prom_parse.o
>> +				   of_platform.o prom_parse.o syscall.o
>>   obj-y				+= ptrace/
>>   obj-$(CONFIG_PPC64)		+= setup_64.o sys_ppc32.o signal_64.o \
>> -				   paca.o nvram_64.o firmware.o note.o \
>> -				   syscall.o
>> +				   paca.o nvram_64.o firmware.o note.o
>>   obj-$(CONFIG_VDSO32)		+= vdso32/
>>   obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
>>   obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
>> diff --git a/arch/powerpc/kernel/syscall.c b/arch/powerpc/kernel/syscall.c
>> index 72f3d2f0a823..28bd43db8755 100644
>> --- a/arch/powerpc/kernel/syscall.c
>> +++ b/arch/powerpc/kernel/syscall.c
>> @@ -25,8 +25,10 @@ notrace long system_call_exception(long r3, long r4, long r5,
>>   	unsigned long ti_flags;
>>   	syscall_fn f;
>>   
>> +#ifdef CONFIG_PPC64
>>   	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
>>   		BUG_ON(irq_soft_mask_return() != IRQS_ALL_DISABLED);
>> +#endif
>>   
>>   	trace_hardirqs_off(); /* finish reconciling */
>>   
>> @@ -34,7 +36,9 @@ notrace long system_call_exception(long r3, long r4, long r5,
>>   		BUG_ON(!(regs->msr & MSR_RI));
>>   	BUG_ON(!(regs->msr & MSR_PR));
>>   	BUG_ON(!FULL_REGS(regs));
>> +#ifdef CONFIG_PPC64
>>   	BUG_ON(regs->softe != IRQS_ENABLED);
>> +#endif
>>   
>>   	account_cpu_user_entry();
>>   
>> @@ -56,7 +60,9 @@ notrace long system_call_exception(long r3, long r4, long r5,
>>   	 * frame, or if the unwinder was taught the first stack frame always
>>   	 * returns to user with IRQS_ENABLED, this store could be avoided!
>>   	 */
>> +#ifdef CONFIG_PPC64
>>   	regs->softe = IRQS_ENABLED;
>> +#endif
>>   
>>   	local_irq_enable();
>>   
>> @@ -148,7 +154,9 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>>   		ret |= _TIF_RESTOREALL;
>>   	}
>>   
>> +#ifdef CONFIG_PPC64
>>   again:
>> +#endif
>>   	local_irq_disable();
>>   	ti_flags = READ_ONCE(*ti_flagsp);
>>   	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
>> @@ -191,6 +199,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>>   
>>   	/* This pattern matches prep_irq_for_idle */
>>   	__hard_EE_RI_disable();
>> +#ifdef CONFIG_PPC64
>>   	if (unlikely(lazy_irq_pending())) {
>>   		__hard_RI_enable();
>>   		trace_hardirqs_off();
>> @@ -201,6 +210,7 @@ notrace unsigned long syscall_exit_prepare(unsigned long r3,
>>   	}
>>   	local_paca->irq_happened = 0;
>>   	irq_soft_mask_set(IRQS_ENABLED);
>> +#endif
>>   
>>   #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
>>   	local_paca->tm_scratch = regs->msr;
>> -- 
>> 2.25.0
>>
>>
> 
> The #ifdefs disappoint me!

They disappoint me as well. I tried to removed most of them in v3, I 
also took your patch up front the series.

> 
> Here is (unested) something that should help 32-bit avoid several ifdefs
> in the main part of the function. I should have done this as part of the
> merged series, but that's okay I'll submit as a cleanup.
> 
> The rest looks okay for now. Maybe we grow some helpers to manage the
> soft-mask state, though I'm not really sure it would make sense for
> 32-bit code to ever call them. Maybe just confined to this file would be
> okay but for now the ifdefs are okay.

Thanks
Christophe
