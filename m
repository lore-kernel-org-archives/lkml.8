Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F06DC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74E70206B9
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgEEPk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:40:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:42653 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729317AbgEEPk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:40:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49GkSk662Lz9v6ZJ;
        Tue,  5 May 2020 17:40:22 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id lB47a1rBtIIP; Tue,  5 May 2020 17:40:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49GkSk5DfVz9v6ZG;
        Tue,  5 May 2020 17:40:22 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 69F418B7B3;
        Tue,  5 May 2020 17:40:24 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZCQ8FQrSrO81; Tue,  5 May 2020 17:40:24 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E76B98B7A8;
        Tue,  5 May 2020 17:40:22 +0200 (CEST)
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, npiggin@gmail.com,
        segher@kernel.crashing.org
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
 <87sggecv81.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1c6379b2-7e0a-91fe-34f0-51f5adca7929@csgroup.eu>
Date:   Tue, 5 May 2020 17:40:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <87sggecv81.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Le 05/05/2020 à 16:27, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> unsafe_put_user() is designed to take benefit of 'asm goto'.
>>
>> Instead of using the standard __put_user() approach and branch
>> based on the returned error, use 'asm goto' and make the
>> exception code branch directly to the error label. There is
>> no code anymore in the fixup section.
>>
>> This change significantly simplifies functions using
>> unsafe_put_user()
>>
> ...
>>
>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> ---
>>   arch/powerpc/include/asm/uaccess.h | 61 +++++++++++++++++++++++++-----
>>   1 file changed, 52 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
>> index 9cc9c106ae2a..9365b59495a2 100644
>> --- a/arch/powerpc/include/asm/uaccess.h
>> +++ b/arch/powerpc/include/asm/uaccess.h
>> @@ -196,6 +193,52 @@ do {								\
>>   })
>>   
>>   
>> +#define __put_user_asm_goto(x, addr, label, op)			\
>> +	asm volatile goto(					\
>> +		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
>> +		EX_TABLE(1b, %l2)				\
>> +		:						\
>> +		: "r" (x), "m<>" (*addr)				\
> 
> The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.
> 
> Plain "m" works, how much does the "<>" affect code gen in practice?
> 
> A quick diff here shows no difference from removing "<>".

It was recommended by Segher, there has been some discussion about it on 
v1 of this patch, see 
https://patchwork.ozlabs.org/project/linuxppc-dev/patch/4fdc2aba6f5e51887d1cd0fee94be0989eada2cd.1586942312.git.christophe.leroy@c-s.fr/

As far as I understood that's mandatory on recent gcc to get the 
pre-update form of the instruction. With older versions "m" was doing 
the same, but not anymore. Should we ifdef the "m<>" or "m" based on GCC 
version ?

Christophe
