Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A80F0C4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:20:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DBC620786
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:20:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZWeOY2ZK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgCXLUh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:20:37 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:35716 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727186AbgCXLUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585048836;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rXT0D7cY7bPYe0yb02QZeAQZaimZpE2z4zLSjjcJk1w=;
        b=ZWeOY2ZKsdtBEDLWkdDthbJcTbuDgf+wtWLBwKknuv/5cnaVxEeW2NepMjuwztnF+1lpuG
        /C+v5GOYo963kSSsUFYCWBf0W5/FOMGCVe8x5jvy3fi/jc7du5lcWG00D8hhxQpV//ZQFH
        FN+VraUXgAlwHYD5lZmp4TGwxBUirT0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-312-yN4Gcl_fN-SXAk6CIlf9vQ-1; Tue, 24 Mar 2020 07:20:34 -0400
X-MC-Unique: yN4Gcl_fN-SXAk6CIlf9vQ-1
Received: by mail-wm1-f69.google.com with SMTP id f185so1133935wmf.8
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 04:20:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rXT0D7cY7bPYe0yb02QZeAQZaimZpE2z4zLSjjcJk1w=;
        b=I1ydkNYDEgrwDkZglJw8J3l/CR0RZFZBALVOBGbX/2IiE0pVL+rnWod/KwBhQlSh0m
         81gPn6YBanqiuBBX8++M/zDgqE+r9OTmyAHJCilIxlKTfKr0Q56qk++Ffu3UgnpWYLmS
         4P1tEkrez6cyBiPfPs1MuRW6S6vI8CSgzOSzVmDCszIIdhkxkI7rjZ6xwwl0uCwCXTq+
         QUMHzQUn/D80ZS451yg7RDe+rXCgFBiGMG0Ze9UDYEXhev25F5fWPvNGTC7t0S2uHgHh
         ZMifTrwEVjy5ab27JYc0qq6QMhyi4lnbKcylwcI/yLCX0cOfbcpiY0YGul0L/1y5sXFN
         Yj9g==
X-Gm-Message-State: ANhLgQ2Ax5Z+rFzqP7ZmE+tZqZqQRW3dkU54HPNYAgNMvrvMhAy29ix/
        O1lzV+Nk8NAauyRD1N/AkgahcslYwMjPpX/ywMF2xonZMd//km4/kMacQC2qljK3QOCdeOl1OqN
        WLrTGQ2wyIWdDmoblOhN9tTYv
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr35434225wrh.311.1585048833268;
        Tue, 24 Mar 2020 04:20:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvfgvyMCNqRfS0Utl+oeBTEBfq98PbTEUj8aI5mL7xEtyh9/y9Q/2QJMVUHhBUl52/Oz1qc8Q==
X-Received: by 2002:adf:d0c1:: with SMTP id z1mr35434187wrh.311.1585048833009;
        Tue, 24 Mar 2020 04:20:33 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:7848:99b4:482a:e888? ([2001:b07:6468:f312:7848:99b4:482a:e888])
        by smtp.gmail.com with ESMTPSA id u5sm21556158wrp.81.2020.03.24.04.20.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 04:20:32 -0700 (PDT)
Subject: Re: [PATCH v3 34/37] KVM: nVMX: Don't flush TLB on nested VMX
 transition
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ben Gardon <bgardon@google.com>,
        Junaid Shahid <junaids@google.com>,
        Liran Alon <liran.alon@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        John Haxby <john.haxby@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Tom Lendacky <thomas.lendacky@amd.com>
References: <20200320212833.3507-1-sean.j.christopherson@intel.com>
 <20200320212833.3507-35-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4e2b2b82-278e-72d9-4db3-5047b678049c@redhat.com>
Date:   Tue, 24 Mar 2020 12:20:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200320212833.3507-35-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/03/20 22:28, Sean Christopherson wrote:
> Unconditionally skip the TLB flush triggered when reusing a root for a
> nested transition as nested_vmx_transition_tlb_flush() ensures the TLB
> is flushed when needed, regardless of whether the MMU can reuse a cached
> root (or the last root).
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>

So much for my WARN_ON. :)

Paolo

> ---
>  arch/x86/kvm/mmu/mmu.c    | 2 +-
>  arch/x86/kvm/vmx/nested.c | 6 ++++--
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 84e1e748c2b3..7b0fb7f2c24d 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5038,7 +5038,7 @@ void kvm_init_shadow_ept_mmu(struct kvm_vcpu *vcpu, bool execonly,
>  		kvm_calc_shadow_ept_root_page_role(vcpu, accessed_dirty,
>  						   execonly, level);
>  
> -	__kvm_mmu_new_cr3(vcpu, new_eptp, new_role.base, false, true);
> +	__kvm_mmu_new_cr3(vcpu, new_eptp, new_role.base, true, true);
>  
>  	if (new_role.as_u64 == context->mmu_role.as_u64)
>  		return;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index db3ce8f297c2..92aab4166498 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -1161,10 +1161,12 @@ static int nested_vmx_load_cr3(struct kvm_vcpu *vcpu, unsigned long cr3, bool ne
>  	}
>  
>  	/*
> -	 * See nested_vmx_transition_mmu_sync for details on skipping the MMU sync.
> +	 * Unconditionally skip the TLB flush on fast CR3 switch, all TLB
> +	 * flushes are handled by nested_vmx_transition_tlb_flush().  See
> +	 * nested_vmx_transition_mmu_sync for details on skipping the MMU sync.
>  	 */
>  	if (!nested_ept)
> -		kvm_mmu_new_cr3(vcpu, cr3, false,
> +		kvm_mmu_new_cr3(vcpu, cr3, true,
>  				!nested_vmx_transition_mmu_sync(vcpu));
>  
>  	vcpu->arch.cr3 = cr3;
> 

