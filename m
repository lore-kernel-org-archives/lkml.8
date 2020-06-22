Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B52CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CEE20644
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:05:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HK1pnyvk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbgFVRFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:05:02 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48030 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729605AbgFVRE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592845497;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zw8XrOHkVRgeeR7QiiSEcbjjjltG1ehdscLw0b/C9c0=;
        b=HK1pnyvkqHnxsLGrfsqJVCnJUQGfR2HNg+QQNbW7LlAZDNwUPJriS4zqdks9x7klIWMnGc
        5iig13zlfIOSl28b4c5YR78WBwAA1QTyDg1ItpuiM6QZsGXZgWv7dpa3cHdt1+gRcXTTCU
        wPCeMmVmlLFFh0tIf0YSjDhyLCDfkUo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-B5dA4YPjNDGeLM7vej3xlg-1; Mon, 22 Jun 2020 13:04:56 -0400
X-MC-Unique: B5dA4YPjNDGeLM7vej3xlg-1
Received: by mail-wr1-f70.google.com with SMTP id a6so4859502wrq.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:04:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zw8XrOHkVRgeeR7QiiSEcbjjjltG1ehdscLw0b/C9c0=;
        b=Ka2O+yAilnWipqif7Sk2dse1PF4xEZrAqknepK5cSHCZZ+NAxgAWP7KBi9MCd3+/0x
         HAVKr06gqSjdRgJxspxCdz1Kx9B1EK+N8u1m/2JOvZfN4FI5MkTXpImQpFytM2KvW+71
         ZRH5gfCdsB/zBHT9WYIfMEWAFEfvv+U8Rg28SitwRkriLDiNnWqD6UhAA5ZBOr0vaWXa
         nHUiGKn8Fly1WZFE/wDj5UaqmoovXh3SZSE9ciXQY1tkueEJsNqtG6bl8nKP0mA+uA34
         OzS52w2McCKw4jjGOpey7qQlHEuRa7zlvz21olPp6XGoLadGukPH6CdrvG9T4cubk+dc
         bZig==
X-Gm-Message-State: AOAM531V0qLj06RmPon6gzDAidjHKgA0wOqqfbRP/kycuv2LLisHMvCn
        Wqydqb6I31N1UivtnIvc9G3Ud0Tj1mYtZA565my8R2HhSEhhDFo80ZbADtTFXYfKTSMBvBUTin9
        OT5oO7QoU3OyyjhqPanShT/ze
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr20552792wru.252.1592845494817;
        Mon, 22 Jun 2020 10:04:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzJshRM/Q+cYn+pOyoQNIMqnZX6SUkflro/KbDFFzDy9a/O4IODCxlScxMd2GSbKua7MHQkLQ==
X-Received: by 2002:a5d:4d4d:: with SMTP id a13mr20552775wru.252.1592845494559;
        Mon, 22 Jun 2020 10:04:54 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id p16sm20655190wru.27.2020.06.22.10.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 10:04:53 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Avoid mixing gpa_t with gfn_t in
 walk_addr_generic()
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
References: <20200622151435.752560-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fe5b461e-795f-332f-48fe-58fc39fd1ae0@redhat.com>
Date:   Mon, 22 Jun 2020 19:04:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200622151435.752560-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/06/20 17:14, Vitaly Kuznetsov wrote:
> translate_gpa() returns a GPA, assigning it to 'real_gfn' seems obviously
> wrong. There is no real issue because both 'gpa_t' and 'gfn_t' are u64 and
> we don't use the value in 'real_gfn' as a GFN, we do
> 
>  real_gfn = gpa_to_gfn(real_gfn);
> 
> instead. 'If you see a "buffalo" sign on an elephant's cage, do not trust
> your eyes', but let's fix it for good.
> 
> No functional change intended.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  arch/x86/kvm/mmu/paging_tmpl.h | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index a6d484ea110b..58234bfaca07 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -360,7 +360,6 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  	++walker->level;
>  
>  	do {
> -		gfn_t real_gfn;
>  		unsigned long host_addr;
>  
>  		pt_access = pte_access;
> @@ -375,7 +374,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  		walker->table_gfn[walker->level - 1] = table_gfn;
>  		walker->pte_gpa[walker->level - 1] = pte_gpa;
>  
> -		real_gfn = mmu->translate_gpa(vcpu, gfn_to_gpa(table_gfn),
> +		real_gpa = mmu->translate_gpa(vcpu, gfn_to_gpa(table_gfn),
>  					      nested_access,
>  					      &walker->fault);
>  
> @@ -389,12 +388,10 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
>  		 * information to fix the exit_qualification or exit_info_1
>  		 * fields.
>  		 */
> -		if (unlikely(real_gfn == UNMAPPED_GVA))
> +		if (unlikely(real_gpa == UNMAPPED_GVA))
>  			return 0;
>  
> -		real_gfn = gpa_to_gfn(real_gfn);
> -
> -		host_addr = kvm_vcpu_gfn_to_hva_prot(vcpu, real_gfn,
> +		host_addr = kvm_vcpu_gfn_to_hva_prot(vcpu, gpa_to_gfn(real_gpa),
>  					    &walker->pte_writable[walker->level - 1]);
>  		if (unlikely(kvm_is_error_hva(host_addr)))
>  			goto error;
> 

Queued, thanks.

Paolo

