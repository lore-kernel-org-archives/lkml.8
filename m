Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8076C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 10:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F832081E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="lJPQAvSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbgBOKRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 05:17:31 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:29587 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbgBOKRa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 05:17:30 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 48KR534g6Dz9v083;
        Sat, 15 Feb 2020 11:17:27 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=lJPQAvSy; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id ZzJgLv4krNH4; Sat, 15 Feb 2020 11:17:27 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 48KR533PkQz9v082;
        Sat, 15 Feb 2020 11:17:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1581761847; bh=nmPPyvS7mugZ03IF9OR5ujLrYqbMOGWsdwsS+aXnSYc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=lJPQAvSy+mJFdKu8sEJPCng689HbtSSsjTwrmksW37mb8w8XHZ3VtZkjQywCjnE4H
         +KTP3kXepPxvIjVdeLjwsIK37dNi0rp3UeAQatRdC8/2vEQOmDg5IT4U7uj8MVjGS4
         ymIAzoXj5iimVp7TJM6TDOcB8933f0kwSdRSo22w=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 92C198B781;
        Sat, 15 Feb 2020 11:17:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id cXg6Z6Js6SoI; Sat, 15 Feb 2020 11:17:28 +0100 (CET)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E2B928B755;
        Sat, 15 Feb 2020 11:17:27 +0100 (CET)
Subject: Re: [PATCH] powerpc/8xx: Fix clearing of bits 20-23 in ITLB miss
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <4f70c2778163affce8508a210f65d140e84524b4.1581272050.git.christophe.leroy@c-s.fr>
 <546ce4737f308a4ba99a53f550de5b44abc06444.camel@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <1d6a53ab-ea72-7452-ea5f-43dd70b223c9@c-s.fr>
Date:   Sat, 15 Feb 2020 11:17:27 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <546ce4737f308a4ba99a53f550de5b44abc06444.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 15/02/2020 à 07:28, Leonardo Bras a écrit :
> On Sun, 2020-02-09 at 18:14 +0000, Christophe Leroy wrote:
>> In ITLB miss handled the line supposed to clear bits 20-23 on the
>> L2 ITLB entry is buggy and does indeed nothing, leading to undefined
>> value which could allow execution when it shouldn't.
>>
>> Properly do the clearing with the relevant instruction.
>>
>> Fixes: 74fabcadfd43 ("powerpc/8xx: don't use r12/SPRN_SPRG_SCRATCH2 in TLB Miss handlers")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/kernel/head_8xx.S | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
>> index 9922306ae512..073a651787df 100644
>> --- a/arch/powerpc/kernel/head_8xx.S
>> +++ b/arch/powerpc/kernel/head_8xx.S
>> @@ -256,7 +256,7 @@ InstructionTLBMiss:
>>   	 * set.  All other Linux PTE bits control the behavior
>>   	 * of the MMU.
>>   	 */
>> -	rlwimi	r10, r10, 0, 0x0f00	/* Clear bits 20-23 */
>> +	rlwinm	r10, r10, 0, ~0x0f00	/* Clear bits 20-23 */
>>   	rlwimi	r10, r10, 4, 0x0400	/* Copy _PAGE_EXEC into bit 21 */
>>   	ori	r10, r10, RPN_PATTERN | 0x200 /* Set 22 and 24-27 */
>>   	mtspr	SPRN_MI_RPN, r10	/* Update TLB entry */
> 
> Looks a valid change.
> rlwimi  r10, r10, 0, 0x0f00 means:
> r10 = ((r10 << 0) & 0x0f00) | (r10 & ~0x0f00) which ends up being
> r10 = r10
> 
> On ISA, rlwinm is recommended for clearing high order bits.
> rlwinm  r10, r10, 0, ~0x0f00 means:
> r10 = (r10 << 0) & ~0x0f00
> 
> Which does exactly what the comments suggests.
> 
> FWIW:
> Reviwed-by: Leonardo Bras <leonardo@linux.ibm.com>
> 

I guess you mean

Reviewed-by: Leonardo Bras <leonardo@linux.ibm.com>
