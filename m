Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBE7C7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:40:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7696320732
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 06:40:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="iYhWWX8E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgBQGkO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 01:40:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:45100 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725855AbgBQGkN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 01:40:13 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48LZ9M03Mtz9tyKy;
        Mon, 17 Feb 2020 07:40:07 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=iYhWWX8E; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id M2lXqJqpekqG; Mon, 17 Feb 2020 07:40:06 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48LZ9L632Xz9tyKw;
        Mon, 17 Feb 2020 07:40:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581921606; bh=RIChch1m0QYFDIHCh/Ft7iNcP75vzp/5ozhdlv2//6o=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=iYhWWX8EJBYGe6LckfXQdWNjahq1nPguw3X0/BbI4Epn1QxtXFvxtfyMFoYKdcWpt
         FfB6j63LvHWwIANYeBWrIUsI1OujjBZWBb+21FZanZgdDxVTwG7i6znepTb7FEecrS
         gFreQaaXtYVl3hWbI9pN3TJ+E1Js/RW3dgnYIQzE=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 594738B79C;
        Mon, 17 Feb 2020 07:40:06 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id hIToJ0uh2nON; Mon, 17 Feb 2020 07:40:06 +0100 (CET)
Received: from [172.25.230.102] (unknown [172.25.230.102])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2F15A8B755;
        Mon, 17 Feb 2020 07:40:06 +0100 (CET)
Subject: Re: [PATCH] powerpc/chrp: Fix enter_rtas() with CONFIG_VMAP_STACK
To:     Michael Neuling <mikey@neuling.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <159ecb0ab021c07fd2f383d4a083a43d16d67b92.1581669187.git.christophe.leroy@c-s.fr>
 <04cdd26307a1eaebeacc039b207db92e0b6820bb.camel@neuling.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <40126489-adf8-1b65-8974-25bca584bc9b@c-s.fr>
Date:   Mon, 17 Feb 2020 07:40:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <04cdd26307a1eaebeacc039b207db92e0b6820bb.camel@neuling.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/02/2020 à 23:40, Michael Neuling a écrit :
> On Fri, 2020-02-14 at 08:33 +0000, Christophe Leroy wrote:
>> With CONFIG_VMAP_STACK, data MMU has to be enabled
>> to read data on the stack.
> 
> Can you describe what goes wrong without this? Some oops message? rtas blows up?
> Get corrupt data?

Larry reported a machine check. Or in fact, he reported a Oops in 
kprobe_handler(), that Oops being a bug in kprobe_handle() triggered by 
this machine check.

By converting a VM address to a phys-like address as if is was linear 
mem, you get in the dark. Either there is some physical memory at that 
address and you corrupt it. Or there is none and you get a machine check.

> 
> Also can you say what you're actually doing (ie turning on MSR[DR])

Euh ... I'm saying that data MMU has to be enabled, so I'm enabling it.

> 
> 
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/kernel/entry_32.S | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
>> index 0713daa651d9..bc056d906b51 100644
>> --- a/arch/powerpc/kernel/entry_32.S
>> +++ b/arch/powerpc/kernel/entry_32.S
>> @@ -1354,12 +1354,17 @@ _GLOBAL(enter_rtas)
>>   	mtspr	SPRN_SRR0,r8
>>   	mtspr	SPRN_SRR1,r9
>>   	RFI
>> -1:	tophys(r9,r1)
>> +1:	tophys_novmstack r9, r1
>> +#ifdef CONFIG_VMAP_STACK
>> +	li	r0, MSR_KERNEL & ~MSR_IR	/* can take DTLB miss */
> 
> You're potentially turning on more than MSR DR here. This should be clear in the
> commit message.

Am I ?

At the time of the RFI just above, SRR1 contains the value of r9 which 
has been set 2 lines before to MSR_KERNEL & ~(MSR_IR|MSR_DR).

What should be clear in the commit message ?

> 
>> +	mtmsr	r0
>> +	isync
>> +#endif
>>   	lwz	r8,INT_FRAME_SIZE+4(r9)	/* get return address */
>>   	lwz	r9,8(r9)	/* original msr value */
>>   	addi	r1,r1,INT_FRAME_SIZE
>>   	li	r0,0
>> -	tophys(r7, r2)
>> +	tophys_novmstack r7, r2
>>   	stw	r0, THREAD + RTAS_SP(r7)
>>   	mtspr	SPRN_SRR0,r8
>>   	mtspr	SPRN_SRR1,r9

Christophe
