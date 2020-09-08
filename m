Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A714C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB56221741
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 08:56:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgIHI4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 04:56:38 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:52306 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbgIHI4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 04:56:38 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BlzXf0t6Nz9v06V;
        Tue,  8 Sep 2020 10:56:34 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id F3nHJ8RTcc_q; Tue,  8 Sep 2020 10:56:34 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BlzXf060rz9v06Q;
        Tue,  8 Sep 2020 10:56:34 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1AD2F8B7A1;
        Tue,  8 Sep 2020 10:56:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id ZCgTkuGxxvKw; Tue,  8 Sep 2020 10:56:35 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 93F4D8B768;
        Tue,  8 Sep 2020 10:56:34 +0200 (CEST)
Subject: Re: [PATCH v1 1/5] powerpc/mm: sanity_check_fault() should work for
 all, not only BOOK3S
To:     Nicholas Piggin <npiggin@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <7baae4086cbb9ffb08c933b065ff7d29dbc03dd6.1596734104.git.christophe.leroy@csgroup.eu>
 <1599554359.m174sr2fhg.astroid@bobo.none>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <b5a84cb6-2f54-6c4d-6326-2cc21074490b@csgroup.eu>
Date:   Tue, 8 Sep 2020 10:56:29 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <1599554359.m174sr2fhg.astroid@bobo.none>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 08/09/2020 à 10:43, Nicholas Piggin a écrit :
> Excerpts from Christophe Leroy's message of August 7, 2020 3:15 am:
>> The verification and message introduced by commit 374f3f5979f9
>> ("powerpc/mm/hash: Handle user access of kernel address gracefully")
>> applies to all platforms, it should not be limited to BOOK3S.
>>
>> Make the BOOK3S version of sanity_check_fault() the one for all,
>> and bail out earlier if not BOOK3S.
>>
>> Fixes: 374f3f5979f9 ("powerpc/mm/hash: Handle user access of kernel address gracefully")
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/fault.c | 8 +++-----
>>   1 file changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index 925a7231abb3..2efa34d7e644 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -303,7 +303,6 @@ static inline void cmo_account_page_fault(void)
>>   static inline void cmo_account_page_fault(void) { }
>>   #endif /* CONFIG_PPC_SMLPAR */
>>   
>> -#ifdef CONFIG_PPC_BOOK3S
>>   static void sanity_check_fault(bool is_write, bool is_user,
>>   			       unsigned long error_code, unsigned long address)
>>   {
>> @@ -320,6 +319,9 @@ static void sanity_check_fault(bool is_write, bool is_user,
>>   		return;
>>   	}
>>   
>> +	if (!IS_ENABLED(CONFIG_PPC_BOOK3S))
>> +		return;
> 
> Seems okay. Why is address == -1 special though? I guess it's because
> it may not be an exploit kernel reference but a buggy pointer underflow?
> In that case -1 doesn't seem like it would catch very much. Would it be
> better to test for high bit set for example ((long)address < 0) ?

See 
https://github.com/linuxppc/linux/commit/0f9aee0cb9da7db7d96f63cfa2dc5e4f1bffeb87#diff-f9658f412252f3bb3093e0a95b37f3ac

-1 is what mmap() returns on error, if the app uses that as a pointer 
that's a programming error not an exploit.

Euh .. If you test (long)address < 0, then the entire kernel falls into 
that range as usually it goes from 0xc0000000 to 0xffffffff

But we could skip the top page entirely, anyway it is never mapped.

> 
> Anyway for your patch
> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Thanks
Christophe

