Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DEDC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AF462087D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 08:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgIBILe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:11:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:11627 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIBILa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 04:11:30 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BhGqL3C3xz9vCyG;
        Wed,  2 Sep 2020 10:11:26 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id E0RZ90cem4bM; Wed,  2 Sep 2020 10:11:26 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BhGqL2Pdyz9vBnC;
        Wed,  2 Sep 2020 10:11:26 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6958E8B7A3;
        Wed,  2 Sep 2020 10:11:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id LF3wCfD47HqP; Wed,  2 Sep 2020 10:11:27 +0200 (CEST)
Received: from [10.25.210.31] (unknown [10.25.210.31])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2C76D8B784;
        Wed,  2 Sep 2020 10:11:27 +0200 (CEST)
Subject: Re: [PATCH] powerpc: Fix random segfault when freeing hugetlb range
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <f0cb2a5477cd87d1eaadb128042e20aeb2bc2859.1598860677.git.christophe.leroy@csgroup.eu>
 <875z8weua7.fsf@linux.ibm.com>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96409d24-c8bf-7f3a-0a81-0830174d6bcc@csgroup.eu>
Date:   Wed, 2 Sep 2020 10:11:23 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <875z8weua7.fsf@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 02/09/2020 à 05:23, Aneesh Kumar K.V a écrit :
> Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> 
>> The following random segfault is observed from time to time with
>> map_hugetlb selftest:
>>
>> root@localhost:~# ./map_hugetlb 1 19
>> 524288 kB hugepages
>> Mapping 1 Mbytes
>> Segmentation fault
>>
>> [   31.219972] map_hugetlb[365]: segfault (11) at 117 nip 77974f8c lr 779a6834 code 1 in ld-2.23.so[77966000+21000]
>> [   31.220192] map_hugetlb[365]: code: 9421ffc0 480318d1 93410028 90010044 9361002c 93810030 93a10034 93c10038
>> [   31.220307] map_hugetlb[365]: code: 93e1003c 93210024 8123007c 81430038 <80e90004> 814a0004 7f443a14 813a0004
>> [   31.221911] BUG: Bad rss-counter state mm:(ptrval) type:MM_FILEPAGES val:33
>> [   31.229362] BUG: Bad rss-counter state mm:(ptrval) type:MM_ANONPAGES val:5
>>
>> This fault is due to hugetlb_free_pgd_range() freeing page tables
>> that are also used by regular pages.
>>
>> As explain in the comment at the beginning of
>> hugetlb_free_pgd_range(), the verification done in free_pgd_range()
>> on floor and ceiling is not done here, which means
>> hugetlb_free_pte_range() can free outside the expected range.
>>
>> As the verification cannot be done in hugetlb_free_pgd_range(), it
>> must be done in hugetlb_free_pte_range().
>>
> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
>> Fixes: b250c8c08c79 ("powerpc/8xx: Manage 512k huge pages as standard pages.")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
>> ---
>>   arch/powerpc/mm/hugetlbpage.c | 18 ++++++++++++++++--
>>   1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
>> index 26292544630f..e7ae2a2c4545 100644
>> --- a/arch/powerpc/mm/hugetlbpage.c
>> +++ b/arch/powerpc/mm/hugetlbpage.c
>> @@ -330,10 +330,24 @@ static void free_hugepd_range(struct mmu_gather *tlb, hugepd_t *hpdp, int pdshif
>>   				 get_hugepd_cache_index(pdshift - shift));
>>   }
>>   
>> -static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd, unsigned long addr)
>> +static void hugetlb_free_pte_range(struct mmu_gather *tlb, pmd_t *pmd,
>> +				   unsigned long addr, unsigned long end,
>> +				   unsigned long floor, unsigned long ceiling)
>>   {
>> +	unsigned long start = addr;
>>   	pgtable_t token = pmd_pgtable(*pmd);
>>   
>> +	start &= PMD_MASK;
>> +	if (start < floor)
>> +		return;
>> +	if (ceiling) {
>> +		ceiling &= PMD_MASK;
>> +		if (!ceiling)
>> +			return;
>> +	}
>> +	if (end - 1 > ceiling - 1)
>> +		return;
>> +
> 
> We do repeat that for pud/pmd/pte hugetlb_free_range. Can we consolidate
> that with comment explaining we are checking if the pgtable entry is
> mapping outside the range?

I was thinking about refactoring that into a helper and add all the 
necessary comments to explain what it does.

Will do that in a followup series if you are OK. This patch is a bug fix 
and also have to go through stable.

Christophe
