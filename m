Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A2BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:34:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB9B62070A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 14:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgAYOej convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 09:34:39 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:60518 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYOei (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 09:34:38 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 484dnR3H6Kz9vCRl;
        Sat, 25 Jan 2020 15:34:35 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 3RI8PEMKEfJE; Sat, 25 Jan 2020 15:34:35 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 484dnR2Dbnz9vCRk;
        Sat, 25 Jan 2020 15:34:35 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id AA7E8763; Sat, 25 Jan 2020 15:35:00 +0100 (CET)
Received: from 37.173.164.116 ([37.173.164.116]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 25 Jan 2020 15:35:00 +0100
Date:   Sat, 25 Jan 2020 15:35:00 +0100
Message-ID: <20200125153500.Horde.JTfP3wDEY-lCopNyg0xvuA4@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/32: Add missing context synchronisation with
 CONFIG_VMAP_STACK
References: <872477f7c7552d3bb7baf0b302398fcd42c5fcfd.1579885334.git.christophe.leroy@c-s.fr>
 <87r1znhgvi.fsf@mpe.ellerman.id.au>
 <20200125140052.Horde.0-n2_EcIdGahTxfDVj913w1@messagerie.si.c-s.fr>
 <87o8urhdi3.fsf@mpe.ellerman.id.au>
In-Reply-To: <87o8urhdi3.fsf@mpe.ellerman.id.au>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> a écrit :

> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Michael Ellerman <mpe@ellerman.id.au> a écrit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> ...
>>>> diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
>>>> index 73a035b40dbf..a6a5fbbf8504 100644
>>>> --- a/arch/powerpc/kernel/head_32.h
>>>> +++ b/arch/powerpc/kernel/head_32.h
>>>> @@ -43,6 +43,7 @@
>>>>  	.ifeq	\for_rtas
>>>>  	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
>>>>  	mtmsr	r11
>>>> +	isync
>>>
>>> Actually this one leads to:
>>>
>>>   /home/michael/linux/arch/powerpc/kernel/head_8xx.S: Assembler messages:
>>>   /home/michael/linux/arch/powerpc/kernel/head_8xx.S:151: Error:
>>> attempt to move .org backwards
>>>   make[3]: *** [/home/michael/linux/scripts/Makefile.build:348:
>>> arch/powerpc/kernel/head_8xx.o] Error 1
>>>
>>> For mpc885_ads_defconfig.
>>>
>>> That's the alignment exception overflowing into the program check
>>> handler:
>>>
>>> /* Alignment exception */
>>> 	. = 0x600
>>> Alignment:
>>> 	EXCEPTION_PROLOG handle_dar_dsisr=1
>>> 	save_dar_dsisr_on_stack r4, r5, r11
>>> 	li	r6, RPN_PATTERN
>>> 	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
>>> 	addi	r3,r1,STACK_FRAME_OVERHEAD
>>> 	EXC_XFER_STD(0x600, alignment_exception)
>>>
>>> /* Program check exception */
>>> 	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
>>>
>>>
>>> Can't see an obvious/easy way to fix it.
>>
>> Argh !
>>
>> I think the easiest is to move the EXC_XFER_STD(0x600,
>> alignment_exception) somewhere else and branch to it. There is some
>> space at .0xa00
>
> That works, or builds at least. I'm not setup to boot test it.
>
> Does this look OK?

Yes it looks ok,

Thanks
Christophe

>
> cheers
>
>
> From 40e7d671aa27cf4411188f978b2cd06b30a9cb6c Mon Sep 17 00:00:00 2001
> From: Michael Ellerman <mpe@ellerman.id.au>
> Date: Sun, 26 Jan 2020 00:20:16 +1100
> Subject: [PATCH] powerpc/8xx: Move tail of alignment exception out of line
>
> When we enable VMAP_STACK there will not be enough room for the
> alignment handler at 0x600 in head_8xx.S. For now move the tail of the
> alignment handler out of line, and branch to it.
>
> Suggested-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kernel/head_8xx.S | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
> index 477933b36bde..9922306ae512 100644
> --- a/arch/powerpc/kernel/head_8xx.S
> +++ b/arch/powerpc/kernel/head_8xx.S
> @@ -145,7 +145,7 @@ _ENTRY(_start);
>  	li	r6, RPN_PATTERN
>  	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
>  	addi	r3,r1,STACK_FRAME_OVERHEAD
> -	EXC_XFER_STD(0x600, alignment_exception)
> +	b	.Lalignment_exception_ool
>
>  /* Program check exception */
>  	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
> @@ -153,6 +153,11 @@ _ENTRY(_start);
>  /* Decrementer */
>  	EXCEPTION(0x900, Decrementer, timer_interrupt, EXC_XFER_LITE)
>
> +	/* With VMAP_STACK there's not enough room for this at 0x600 */
> +	. = 0xa00
> +.Lalignment_exception_ool:
> +	EXC_XFER_STD(0x600, alignment_exception)
> +
>  /* System call */
>  	. = 0xc00
>  SystemCall:
> --
> 2.21.1


