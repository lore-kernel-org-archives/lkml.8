Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E699C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75E9720BED
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:34:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RwOBCAFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730648AbgCaQeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:34:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53584 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730099AbgCaQeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:34:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585672440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X9yGbZJZcTDAf4kkcRp2Ft+jto/DPsExKthWpzXZsf8=;
        b=RwOBCAFbhKqxsbPZjcGTGBcaUkmmFGPEao79UIa+3pQXv7vyfSdcqtRtsJnvvnLgBUnTk6
        g1Ill9yhQAnfkM8TKymnCVAQ+DjJQV+fpFM9Fym02oX/QyDNWTfYzXzkY/39o/aC0Je+HQ
        wwnHNnvgFjudxGSylIP4BPFUvF1Y7Jg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-153-n5KfhEquPPqg0NuA_xyMnA-1; Tue, 31 Mar 2020 12:33:59 -0400
X-MC-Unique: n5KfhEquPPqg0NuA_xyMnA-1
Received: by mail-wr1-f70.google.com with SMTP id w12so13185474wrl.23
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 09:33:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X9yGbZJZcTDAf4kkcRp2Ft+jto/DPsExKthWpzXZsf8=;
        b=YgcAx03gOqPUd5MZKirGNUa8fKxRi0Fvqi1iOW5a99wBzgVyEJPjBEInv9rpQ9bEyL
         Ik0oHrNaRuKZq0vCPCDVpKJ8UadR+ThjSvSyErncvz+fKlUSfovfRFKEhYDiuypEnOGA
         ZYMr4uxb9hUDtao2gHuuKNOyRKe+hakDcDq+aci0oxTDWB/R9hJtHy1tbdOTATx9aCxt
         7amIqx3jFUDbBeDrgoKsi1StL4LEgUB2jAk9Ez/G2oaEF4re70hVb8njFRIdYTxBtbA0
         5lzMg4COAQ3K4sYoHsTCrqLG5NbIaBiYgzwtJQMBOQwOBY3pg7LVHQFsqYZqHp0hiEyJ
         JOqw==
X-Gm-Message-State: ANhLgQ1zOXlMU1SmnrIn2iuG2Mr17k4tNJFxAqWGSHFFeNCE/pNgGLQd
        9vpCWBEFcRMpOvTobHpMzSChbHLb7tKKVX8hYm9Pc83Tz3vgFXBO8Ve//EiSHHWAy8tpImeos4C
        ltWTJILt/8KEPEa5pOOOqcI95
X-Received: by 2002:a1c:6885:: with SMTP id d127mr4308141wmc.33.1585672438091;
        Tue, 31 Mar 2020 09:33:58 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsvpNN4gBPIgc2ZIYkWbDIAgbPhijWN0Kg8An9gAyuDMWqJ79G2a6EDVOBAiaOi++KlIXWV0w==
X-Received: by 2002:a1c:6885:: with SMTP id d127mr4308060wmc.33.1585672436921;
        Tue, 31 Mar 2020 09:33:56 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:b55d:5ed2:8a41:41ea? ([2001:b07:6468:f312:b55d:5ed2:8a41:41ea])
        by smtp.gmail.com with ESMTPSA id b6sm28552659wrp.59.2020.03.31.09.33.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 09:33:56 -0700 (PDT)
Subject: Re: [PATCH] KVM: MIPS: fix compilation
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-mips@vger.kernel.org, peterx@redhat.com
References: <20200331154749.5457-1-pbonzini@redhat.com>
 <20200331160703.GF30942@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b2d15996-1e8b-02a5-7abd-3eb380442092@redhat.com>
Date:   Tue, 31 Mar 2020 18:33:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331160703.GF30942@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/20 18:07, Mike Rapoport wrote:
> On Tue, Mar 31, 2020 at 11:47:49AM -0400, Paolo Bonzini wrote:
>> Commit 31168f033e37 is correct that pud_index() & __pud_offset() are the same
>> when pud_index() is actually provided, however it does not take into account
>> the __PAGETABLE_PUD_FOLDED case.  Provide kvm_pud_index so that MIPS KVM
>> compiles.
>>
>> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> ---
>>  arch/mips/kvm/mmu.c | 18 ++++++++++++------
>>  1 file changed, 12 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
>> index 7dad7a293eae..ccf98c22fd2c 100644
>> --- a/arch/mips/kvm/mmu.c
>> +++ b/arch/mips/kvm/mmu.c
>> @@ -25,6 +25,12 @@
>>  #define KVM_MMU_CACHE_MIN_PAGES 2
>>  #endif
>>  
>> +#if defined(__PAGETABLE_PUD_FOLDED)
>> +#define kvm_pud_index(gva) 0
>> +#else
>> +#define kvm_pud_index(gva) pud_index(gva)
>> +#endif
>> +
> 
> I'd prefer simply making pud_index() always defined. When pud level is
> folded asm-generic/pgtable-nopud.h will define PTRS_PER_PUD to 1 and
> pud_index() will evaluate to 0 anyway.

I won't queue this patch for now, let's wait for the MIPS people to say
what they prefer.  Thanks!

Paolo

> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index f92716cfa4f4..ee5dc0c145b9 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -172,6 +172,8 @@
>  
>  extern pte_t invalid_pte_table[PTRS_PER_PTE];
>  
> +#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> +
>  #ifndef __PAGETABLE_PUD_FOLDED
>  /*
>   * For 4-level pagetables we defines these ourselves, for 3-level the
> @@ -210,8 +212,6 @@ static inline void p4d_clear(p4d_t *p4dp)
>  	p4d_val(*p4dp) = (unsigned long)invalid_pud_table;
>  }
>  
> -#define pud_index(address)	(((address) >> PUD_SHIFT) & (PTRS_PER_PUD - 1))
> -
>  static inline unsigned long p4d_page_vaddr(p4d_t p4d)
>  {
>  	return p4d_val(p4d);
> 
>>  static int mmu_topup_memory_cache(struct kvm_mmu_memory_cache *cache,
>>  				  int min, int max)
>>  {
>> @@ -234,8 +240,8 @@ static bool kvm_mips_flush_gpa_pud(pud_t *pud, unsigned long start_gpa,
>>  {
>>  	pmd_t *pmd;
>>  	unsigned long end = ~0ul;
>> -	int i_min = pud_index(start_gpa);
>> -	int i_max = pud_index(end_gpa);
>> +	int i_min = kvm_pud_index(start_gpa);
>> +	int i_max = kvm_pud_index(end_gpa);
>>  	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PUD - 1);
>>  	int i;
>>  
>> @@ -361,8 +367,8 @@ static int kvm_mips_##name##_pud(pud_t *pud, unsigned long start,	\
>>  	int ret = 0;							\
>>  	pmd_t *pmd;							\
>>  	unsigned long cur_end = ~0ul;					\
>> -	int i_min = pud_index(start);				\
>> -	int i_max = pud_index(end);					\
>> +	int i_min = kvm_pud_index(start);				\
>> +	int i_max = kvm_pud_index(end);					\
>>  	int i;								\
>>  									\
>>  	for (i = i_min; i <= i_max; ++i, start = 0) {			\
>> @@ -896,8 +902,8 @@ static bool kvm_mips_flush_gva_pud(pud_t *pud, unsigned long start_gva,
>>  {
>>  	pmd_t *pmd;
>>  	unsigned long end = ~0ul;
>> -	int i_min = pud_index(start_gva);
>> -	int i_max = pud_index(end_gva);
>> +	int i_min = kvm_pud_index(start_gva);
>> +	int i_max = kvm_pud_index(end_gva);
>>  	bool safe_to_remove = (i_min == 0 && i_max == PTRS_PER_PUD - 1);
>>  	int i;
>>  
>> -- 
>> 2.18.2
>>
> 

