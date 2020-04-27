Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B065BC83001
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 840CB2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 23:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DQf/hlae"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgD0Xpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:45:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44426 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726333AbgD0Xpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 19:45:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588031142;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nwIFvSz2kGvMTFuz5rDRpT4BSTUSO/yU5bVRJ5mbMLk=;
        b=DQf/hlaevvWPnfQxw8aLfABqe1gu1UaTkhgGuw9Nhyzpp8B6FFTuk7YUvb1PRt0bYtzU/k
        Sc8uNW0wfsvIFBfK1PrTwCEp/GBCoutDDd74oQEtosxZugbMeV1njfZJSZkOsc6KLr99yN
        GfPcq8yQbp0ynH7RieDhkakkTFmc5DI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-3LIp2cJjPdOmC7vAIE7Rag-1; Mon, 27 Apr 2020 19:45:38 -0400
X-MC-Unique: 3LIp2cJjPdOmC7vAIE7Rag-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E28DE107ACF4;
        Mon, 27 Apr 2020 23:45:36 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-127.bne.redhat.com [10.64.54.127])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 164A160638;
        Mon, 27 Apr 2020 23:45:34 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH] arm64/mm: Use phys_to_page() to access pgtable memory
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
References: <20200424044854.15760-1-gshan@redhat.com>
 <20200424092208.GA1167@C02TD0UTHF1T.local>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <a4ad069b-736b-d283-9768-86695eae1d72@redhat.com>
Date:   Tue, 28 Apr 2020 09:45:32 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200424092208.GA1167@C02TD0UTHF1T.local>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 4/24/20 7:22 PM, Mark Rutland wrote:
> On Fri, Apr 24, 2020 at 02:48:54PM +1000, Gavin Shan wrote:
>> The macros {pgd, pud, pmd}_page() retrieves the page struct of the
>> corresponding page frame, which is reserved as page table. There
>> is already a macro (phys_to_page), defined in memory.h, to convert
>> the physical address to the page struct. So it's reasonable to
>> use that in pgtable.h.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
> 
> It might be worth pointing out that phys_to_page() is defined as:
> 
> #define phys_to_page(phys)      (pfn_to_page(__phys_to_pfn(phys)))
> 
> ... so this is obviously equivalent.
> 
> Given that, and given we already explicitly include <asm/memory.h>, this
> looks like a nice cleanup to me.
> 
> With or without the commit message addition:
> 
> Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> 
> Mark.
> 

Thanks for the comments. I will post v2 shortly, which has the improved
commit log and your reviewed-by.

Thanks,
Gavin

>> ---
>>   arch/arm64/include/asm/pgtable.h | 6 +++---
>>   1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 538c85e62f86..8c20e2bd6287 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -508,7 +508,7 @@ static inline void pte_unmap(pte_t *pte) { }
>>   #define pte_set_fixmap_offset(pmd, addr)	pte_set_fixmap(pte_offset_phys(pmd, addr))
>>   #define pte_clear_fixmap()		clear_fixmap(FIX_PTE)
>>   
>> -#define pmd_page(pmd)		pfn_to_page(__phys_to_pfn(__pmd_to_phys(pmd)))
>> +#define pmd_page(pmd)			phys_to_page(__pmd_to_phys(pmd))
>>   
>>   /* use ONLY for statically allocated translation tables */
>>   #define pte_offset_kimg(dir,addr)	((pte_t *)__phys_to_kimg(pte_offset_phys((dir), (addr))))
>> @@ -566,7 +566,7 @@ static inline phys_addr_t pud_page_paddr(pud_t pud)
>>   #define pmd_set_fixmap_offset(pud, addr)	pmd_set_fixmap(pmd_offset_phys(pud, addr))
>>   #define pmd_clear_fixmap()		clear_fixmap(FIX_PMD)
>>   
>> -#define pud_page(pud)		pfn_to_page(__phys_to_pfn(__pud_to_phys(pud)))
>> +#define pud_page(pud)			phys_to_page(__pud_to_phys(pud))
>>   
>>   /* use ONLY for statically allocated translation tables */
>>   #define pmd_offset_kimg(dir,addr)	((pmd_t *)__phys_to_kimg(pmd_offset_phys((dir), (addr))))
>> @@ -624,7 +624,7 @@ static inline phys_addr_t pgd_page_paddr(pgd_t pgd)
>>   #define pud_set_fixmap_offset(pgd, addr)	pud_set_fixmap(pud_offset_phys(pgd, addr))
>>   #define pud_clear_fixmap()		clear_fixmap(FIX_PUD)
>>   
>> -#define pgd_page(pgd)		pfn_to_page(__phys_to_pfn(__pgd_to_phys(pgd)))
>> +#define pgd_page(pgd)			phys_to_page(__pgd_to_phys(pgd))
>>   
>>   /* use ONLY for statically allocated translation tables */
>>   #define pud_offset_kimg(dir,addr)	((pud_t *)__phys_to_kimg(pud_offset_phys((dir), (addr))))
>> -- 
>> 2.23.0
>>
> 

