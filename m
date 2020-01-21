Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA4D9C2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CBE5206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 17:23:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="gFTk7nIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729191AbgAURXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 12:23:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:43999 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728186AbgAURXC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 12:23:02 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 482FjS293hz9v1S7;
        Tue, 21 Jan 2020 18:22:52 +0100 (CET)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=gFTk7nIS; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 1oAV2srf0Lba; Tue, 21 Jan 2020 18:22:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 482FjS108jz9v1S6;
        Tue, 21 Jan 2020 18:22:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1579627372; bh=sMXDwBt01Cd62ThXPHiPled8Rp8cKUezeik7kezRUaM=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=gFTk7nISCQ6YwsCKDldBxyRo17VC7Hwqw3vyPk4sgmpHuazFD4jPGwVeCNwEOB0d5
         Yx9uk840B7OHaR+LWAKROZLvdNjI5p+YMY1m72edZxhkBhjzjXAoF5WGg6tYJ0bGZD
         4LDwC4Pm55Z4zK4eLh3yHS28M9G8E7TWNFdKao+I=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CE1B28B7E6;
        Tue, 21 Jan 2020 18:22:53 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lslBuyCx9qG5; Tue, 21 Jan 2020 18:22:53 +0100 (CET)
Received: from po14934vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB55A8B776;
        Tue, 21 Jan 2020 18:22:52 +0100 (CET)
Subject: GCC bug ? Re: [PATCH v2 10/10] powerpc/32s: Implement Kernel
 Userspace Access Protection
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, ruscur@russell.cc,
        Segher Boessenkool <segher@kernel.crashing.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1552292207.git.christophe.leroy@c-s.fr>
 <a2847248a92cb1641b1740fa121c5a30593ae662.1552292207.git.christophe.leroy@c-s.fr>
 <87ftqfu7j1.fsf@concordia.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <a008a182-f1db-073c-7d38-27bfd1fd8676@c-s.fr>
Date:   Tue, 21 Jan 2020 17:22:32 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <87ftqfu7j1.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/18/2019 06:55 AM, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> diff --git a/arch/powerpc/include/asm/book3s/32/kup.h b/arch/powerpc/include/asm/book3s/32/kup.h
>> index 5f97c742ca71..b3560b2de435 100644
>> --- a/arch/powerpc/include/asm/book3s/32/kup.h
>> +++ b/arch/powerpc/include/asm/book3s/32/kup.h
>> @@ -37,6 +37,113 @@
> ...
>> +
>> +static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
>> +{
>> +	u32 addr = (__force u32)to;
>> +	u32 end = min(addr + size, TASK_SIZE);
>> +
>> +	if (!addr || addr >= TASK_SIZE || !size)
>> +		return;
>> +
>> +	current->thread.kuap = (addr & 0xf0000000) | ((((end - 1) >> 28) + 1) & 0xf);
>> +	kuap_update_sr(mfsrin(addr) & ~SR_KS, addr, end);	/* Clear Ks */
>> +}
> 
> When rebasing on my v6 I changed the above to:
> 
> static inline void allow_user_access(void __user *to, const void __user *from, u32 size)
> {
> 	u32 addr, end;
> 
> 	if (__builtin_constant_p(to) && to == NULL)
> 		return;

Look like the above doesn't work: gcc bug ?

#define NULL (void*)0

static inline int f1(void *to)
{
	if (__builtin_constant_p(to) && to == NULL)
		return 3;
	return 5;
}

int g1(void)
{
	return f1(NULL);
}

static inline int f2(int x)
{
	if (__builtin_constant_p(x) && x == 0)
		return 7;
	return 9;
}

int g2(void)
{
	return f2(0);
}



toto.o:     file format elf32-powerpc


Disassembly of section .text:

00000000 <g1>:
    0:	38 60 00 05 	li      r3,5
    4:	4e 80 00 20 	blr

00000008 <g2>:
    8:	38 60 00 07 	li      r3,7
    c:	4e 80 00 20 	blr



It works for the int const, but not for the pointer const:

g1() should return 3, not 5. GCC bug ?

Christophe
