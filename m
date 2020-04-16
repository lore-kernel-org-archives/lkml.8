Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D6B0C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:42:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5FE217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 12:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="c8TasGQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2635960AbgDPMme (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 08:42:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:45031 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2635940AbgDPMmD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 08:42:03 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 492zPh13xMz9tyrG;
        Thu, 16 Apr 2020 14:42:00 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=c8TasGQY; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id aVjCzTv4DTiP; Thu, 16 Apr 2020 14:42:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 492zPh01qQz9tylm;
        Thu, 16 Apr 2020 14:42:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587040920; bh=2ljz1nBL0vCUAzYsmnWMgAQ1qstKSVseeRiTlYNCisw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=c8TasGQY5NCkEsCb/sMMNlOMPh5/phE1iiPq1mCNdcnugijQ+I3aJvCt6VHWD9FvA
         kwM+raumBoqTBRoapNS1cNvXLqt/zyb63lIWK7MOYT0e2kc7WBbjY2Ntc8XlrjEOsZ
         Nj5J4t1ahc5l8MRIVgmEBDiiv/TrlsK+J7Os54gw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 874B68BBCF;
        Thu, 16 Apr 2020 14:42:01 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id A-kyLt3tW5FA; Thu, 16 Apr 2020 14:42:01 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9BBC78BB88;
        Thu, 16 Apr 2020 14:42:00 +0200 (CEST)
Subject: Re: [PATCH v2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <c9abd91e9bb0b3dd6e3470015e92b98bc2483780.1586942304.git.christophe.leroy@c-s.fr>
 <20200415223747.GX26902@gate.crashing.org>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <f797e5ac-a29a-0eb0-89c8-ff0a9f537ccf@c-s.fr>
Date:   Thu, 16 Apr 2020 14:41:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200415223747.GX26902@gate.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/04/2020 à 00:37, Segher Boessenkool a écrit :
> Hi!
> 
> On Wed, Apr 15, 2020 at 09:25:59AM +0000, Christophe Leroy wrote:
>> +#define __put_user_goto(x, ptr, label) \
>> +	__put_user_nocheck_goto((__typeof__(*(ptr)))(x), (ptr), sizeof(*(ptr)), label)
> 
> This line gets too long, can you break it up somehow?

This line has 86 chars.

powerpc arch tolerates lines with up to 90 chars, see 
arch/powerpc/tools/checkpatch.sh

> 
>> +#define __put_user_asm_goto(x, addr, label, op)			\
>> +	asm volatile goto(					\
>> +		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
>> +		EX_TABLE(1b, %l2)				\
>> +		:						\
>> +		: "r" (x), "m" (*addr)				\
>> +		:						\
>> +		: label)
> 
> Same "%Un" problem as in the other patch.  You could use "m<>" here,
> but maybe just dropping "%Un" is better.

Ok.

I kept it to be consistent with the other patch.

> 
>> +#ifdef __powerpc64__
>> +#define __put_user_asm2_goto(x, ptr, label)			\
>> +	__put_user_asm_goto(x, ptr, label, "std")
>> +#else /* __powerpc64__ */
>> +#define __put_user_asm2_goto(x, addr, label)			\
>> +	asm volatile goto(					\
>> +		"1:	stw%U1%X1 %0, %1\n"			\
>> +		"2:	stw%U1%X1 %L0, %L1\n"			\
>> +		EX_TABLE(1b, %l2)				\
>> +		EX_TABLE(2b, %l2)				\
>> +		:						\
>> +		: "r" (x), "m" (*addr)				\
>> +		:						\
>> +		: label)
>> +#endif /* __powerpc64__ */
> 
> Here, you should drop it for sure.

Done.

Christophe
