Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4236C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 947DF20708
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 05:52:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgHNFwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 01:52:15 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:13652 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNFwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 01:52:15 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BSXdR3zfHz9vD2y;
        Fri, 14 Aug 2020 07:52:11 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id Fa354yKAlT20; Fri, 14 Aug 2020 07:52:11 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BSXdR2fQMz9vD2x;
        Fri, 14 Aug 2020 07:52:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4E8668B775;
        Fri, 14 Aug 2020 07:52:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id P3ttainyg2_X; Fri, 14 Aug 2020 07:52:12 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3E8B8B767;
        Fri, 14 Aug 2020 07:52:11 +0200 (CEST)
Subject: Re: [PATCH 1/5] powerpc: Remove flush_instruction_cache for book3s/32
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <11a330af231af22874c006302a945388846f8112.1597313510.git.christophe.leroy@csgroup.eu>
 <20200813121308.GA16237@infradead.org> <20200813121403.GB16237@infradead.org>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <a0f7d4a2-d2c8-0edc-bc29-47508d4d17e2@csgroup.eu>
Date:   Fri, 14 Aug 2020 07:52:05 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200813121403.GB16237@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 13/08/2020 à 14:14, Christoph Hellwig a écrit :
> On Thu, Aug 13, 2020 at 01:13:08PM +0100, Christoph Hellwig wrote:
>> On Thu, Aug 13, 2020 at 10:12:00AM +0000, Christophe Leroy wrote:
>>> -#ifndef CONFIG_PPC_8xx
>>> +#if !defined(CONFIG_PPC_8xx) && !defined(CONFIG_PPC_BOOK3S_32)
>>>   _GLOBAL(flush_instruction_cache)
>>>   #if defined(CONFIG_4xx)
>>>   	lis	r3, KERNELBASE@h
>>> @@ -290,18 +289,11 @@ _GLOBAL(flush_instruction_cache)
>>>   	mfspr	r3,SPRN_L1CSR1
>>>   	ori	r3,r3,L1CSR1_ICFI|L1CSR1_ICLFR
>>>   	mtspr	SPRN_L1CSR1,r3
>>> -#elif defined(CONFIG_PPC_BOOK3S_601)
>>> -	blr			/* for 601, do nothing */
>>> -#else
>>> -	/* 603/604 processor - use invalidate-all bit in HID0 */
>>> -	mfspr	r3,SPRN_HID0
>>> -	ori	r3,r3,HID0_ICFI
>>> -	mtspr	SPRN_HID0,r3
>>>   #endif /* CONFIG_4xx */
>>>   	isync
>>>   	blr
>>>   EXPORT_SYMBOL(flush_instruction_cache)
>>> -#endif /* CONFIG_PPC_8xx */
>>> +#endif /* CONFIG_PPC_8xx || CONFIG_PPC_BOOK3S_32 */
>>
>> What about untangling this into entirely separate versions instead
>> of the ifdef mess?  Also the export does not seem to be needed at all.
> 
> Ok, I see that you do that later, sorry.
> 

In v2, I drop the untangling patch, because the series completely 
dismantles flush_instruction_cache() so there is no need for an 
ephemeral untanggled version of it.

Christophe
