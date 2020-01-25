Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E165C2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45C4D206D6
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 13:00:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726657AbgAYNA3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 08:00:29 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:13107 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgAYNA3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 08:00:29 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 484bhp51jXz9vCR6;
        Sat, 25 Jan 2020 14:00:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id EVhjlkEv73BO; Sat, 25 Jan 2020 14:00:26 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 484bhp49Cmz9vCR0;
        Sat, 25 Jan 2020 14:00:26 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id B3A05660; Sat, 25 Jan 2020 14:00:52 +0100 (CET)
Received: from 37.173.164.116 ([37.173.164.116]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Sat, 25 Jan 2020 14:00:52 +0100
Date:   Sat, 25 Jan 2020 14:00:52 +0100
Message-ID: <20200125140052.Horde.0-n2_EcIdGahTxfDVj913w1@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/32: Add missing context synchronisation with
 CONFIG_VMAP_STACK
References: <872477f7c7552d3bb7baf0b302398fcd42c5fcfd.1579885334.git.christophe.leroy@c-s.fr>
 <87r1znhgvi.fsf@mpe.ellerman.id.au>
In-Reply-To: <87r1znhgvi.fsf@mpe.ellerman.id.au>
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
>> After reactivation of data translation by modifying MSR[DR], a isync
>> is required to ensure the translation is effective.
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>> Rebased on powerpc/merge-test
>>
>> @mpe: If not too late:
>> - change to head_32.h should be squashed into "powerpc/32: prepare  
>> for CONFIG_VMAP_STACK"
>> - change to head_32.S should be squashed into "powerpc/32s: Enable  
>> CONFIG_VMAP_STACK"
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>  arch/powerpc/kernel/head_32.S | 1 +
>>  arch/powerpc/kernel/head_32.h | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
>> index 73a035b40dbf..a6a5fbbf8504 100644
>> --- a/arch/powerpc/kernel/head_32.h
>> +++ b/arch/powerpc/kernel/head_32.h
>> @@ -43,6 +43,7 @@
>>  	.ifeq	\for_rtas
>>  	li	r11, MSR_KERNEL & ~(MSR_IR | MSR_RI) /* can take DTLB miss */
>>  	mtmsr	r11
>> +	isync
>
> Actually this one leads to:
>
>   /home/michael/linux/arch/powerpc/kernel/head_8xx.S: Assembler messages:
>   /home/michael/linux/arch/powerpc/kernel/head_8xx.S:151: Error:  
> attempt to move .org backwards
>   make[3]: *** [/home/michael/linux/scripts/Makefile.build:348:  
> arch/powerpc/kernel/head_8xx.o] Error 1
>
> For mpc885_ads_defconfig.
>
> That's the alignment exception overflowing into the program check
> handler:
>
> /* Alignment exception */
> 	. = 0x600
> Alignment:
> 	EXCEPTION_PROLOG handle_dar_dsisr=1
> 	save_dar_dsisr_on_stack r4, r5, r11
> 	li	r6, RPN_PATTERN
> 	mtspr	SPRN_DAR, r6	/* Tag DAR, to be used in DTLB Error */
> 	addi	r3,r1,STACK_FRAME_OVERHEAD
> 	EXC_XFER_STD(0x600, alignment_exception)
>
> /* Program check exception */
> 	EXCEPTION(0x700, ProgramCheck, program_check_exception, EXC_XFER_STD)
>
>
> Can't see an obvious/easy way to fix it.

Argh !

I think the easiest is to move the EXC_XFER_STD(0x600,  
alignment_exception) somewhere else and branch to it. There is some  
space at .0xa00

Christophe

PS: I'm afk until monday
