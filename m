Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75063C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 486492075E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgHZPVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:21:20 -0400
Received: from pegase2.c-s.fr ([93.17.235.10]:33107 "EHLO pegase2.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726802AbgHZPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:21:16 -0400
Received: from localhost (mailhub2-ext [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Bc8hM1ndwz9ttg8;
        Wed, 26 Aug 2020 17:21:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [172.26.127.65]) (amavisd-new, port 10024)
        with ESMTP id I4sjrkcRIIM9; Wed, 26 Aug 2020 17:21:07 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Bc8hM118mz9ttg7;
        Wed, 26 Aug 2020 17:21:07 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 68A618B84E;
        Wed, 26 Aug 2020 17:21:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id lumH6pwI8T_t; Wed, 26 Aug 2020 17:21:10 +0200 (CEST)
Received: from [192.168.204.43] (unknown [192.168.204.43])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 83D148B75F;
        Wed, 26 Aug 2020 17:21:09 +0200 (CEST)
Subject: Re: [PATCH v1 4/9] powerpc/vdso: Remove unnecessary ifdefs in
 vdso_pagelist initialization
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <df48ed76cf8a756a7f97ed42a1a39d0a404014bc.1598363608.git.christophe.leroy@csgroup.eu>
 <834f362626e18bc36226f46ed4113c461a3ad032.1598363608.git.christophe.leroy@csgroup.eu>
 <87ft89h2st.fsf@mpe.ellerman.id.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <51cab2a3-044c-f76b-db3a-490ac7533cd2@csgroup.eu>
Date:   Wed, 26 Aug 2020 17:21:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87ft89h2st.fsf@mpe.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 26/08/2020 à 16:58, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
>> diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
>> index daef14a284a3..bbb69832fd46 100644
>> --- a/arch/powerpc/kernel/vdso.c
>> +++ b/arch/powerpc/kernel/vdso.c
>> @@ -718,16 +710,14 @@ static int __init vdso_init(void)
> ...
>>   
>> -
>> -#ifdef CONFIG_VDSO32
>>   	vdso32_kbase = &vdso32_start;
>>   
>>   	/*
>> @@ -735,8 +725,6 @@ static int __init vdso_init(void)
>>   	 */
>>   	vdso32_pages = (&vdso32_end - &vdso32_start) >> PAGE_SHIFT;
>>   	DBG("vdso32_kbase: %p, 0x%x pages\n", vdso32_kbase, vdso32_pages);
>> -#endif
> 
> This didn't build for ppc64le:
> 
>    /opt/cross/gcc-8.20_binutils-2.32/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: arch/powerpc/kernel/vdso.o:(.toc+0x0): undefined reference to `vdso32_end'
>    /opt/cross/gcc-8.20_binutils-2.32/powerpc64-unknown-linux-gnu/bin/powerpc64-unknown-linux-gnu-ld: arch/powerpc/kernel/vdso.o:(.toc+0x8): undefined reference to `vdso32_start'
>    make[1]: *** [/scratch/michael/build/maint/Makefile:1166: vmlinux] Error 1
>    make: *** [Makefile:185: __sub-make] Error 2
> 
> So I just put that ifdef back.
> 

Argh. I guess that's the DBG() that hurts. I'll think about it.

Christophe
