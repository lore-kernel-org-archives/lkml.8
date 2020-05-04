Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EC5C47257
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988E8206D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 16:52:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RDCQxcvG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729820AbgEDQwP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 12:52:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57364 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729803AbgEDQwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 12:52:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588611132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xq7evAiBk3xPfOvO/sipXO7h1v7W7BuTHXTgg2tavgk=;
        b=RDCQxcvGffRt837920W0lFHhcbqfH/ZE4mgqNidXUH0l9uErNAJTeHhGgEv+/wrO7LlnhX
        WE425IZw+ImnU0iKRJZc8Tl3elx93Un8YAHR5YfFnh0kYixjlteU7Lfp1K+Zxkvv+thxbf
        N6erAgxj+kARgZ6qJhhelQqWsUp68bk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-3EYKf4BSP42pspY-AfGwcA-1; Mon, 04 May 2020 12:52:10 -0400
X-MC-Unique: 3EYKf4BSP42pspY-AfGwcA-1
Received: by mail-wr1-f72.google.com with SMTP id e5so11058810wrs.23
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 09:52:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Xq7evAiBk3xPfOvO/sipXO7h1v7W7BuTHXTgg2tavgk=;
        b=KxOsUItALHqCIo6Jtk/Xg+ZzIGUT/JoUUCKhH7FLj0EO/hE05LFu8BHovVxnuCD0Yq
         OMlZDeKwQoGLTSSQiuTvWlLYFS2c8NU61tFTw9shpu6Q7bsMBMrrgKqqolAzFTNBa5Gr
         5N/vhdgfQ9dypXgWYe6pgcop4QTxZsZl3BWpB4tSMjaIb5to79/aSybzF6nMaUr6j1V5
         VZ2B7X7Leiqt8iijZbCyJqS7XWQNG6gHLt7T74WEpXxVTop0f20DnNr1Ry9NShTYvDBK
         GovEYHkBkc8o6xcnbMOmMAsfKOfZJdS2FCZF9badqJO1L0wnEafq0NxU3KyC9DfNmQvy
         zXZg==
X-Gm-Message-State: AGi0PuZXWuf+Cy2xVUk1S+dndZ64wrQLjgqc8NU+YJb/RKYTMS+urXd9
        zGSP7AVjlogCbuuJg/NVCB14nWQVfXjXg/nhQZcJU5PUHUlgLViDs2CGvFz17spFPK/CAZb5y8G
        k/go7LTMKdAsLxvNnQF+Uv0NV
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr228530wrq.358.1588611129360;
        Mon, 04 May 2020 09:52:09 -0700 (PDT)
X-Google-Smtp-Source: APiQypIt+QaQvO/hh4kBVZb4PUDBG8Re1ce556PxEi7eJG0bF6Z9f4Ryq95dX5XnnVb3uAFaXN/YOg==
X-Received: by 2002:a5d:4b04:: with SMTP id v4mr228509wrq.358.1588611129088;
        Mon, 04 May 2020 09:52:09 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id p6sm18767323wrt.3.2020.05.04.09.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 May 2020 09:52:08 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86/mmu: Add a helper to consolidate root sp
 allocation
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200428023714.31923-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d33d1d4f-106b-06a7-68e8-a4707ecc9e67@redhat.com>
Date:   Mon, 4 May 2020 18:52:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200428023714.31923-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/20 04:37, Sean Christopherson wrote:
> Add a helper, mmu_alloc_root(), to consolidate the allocation of a root
> shadow page, which has the same basic mechanics for all flavors of TDP
> and shadow paging.
> 
> Note, __pa(sp->spt) doesn't need to be protected by mmu_lock, sp->spt
> points at a kernel page.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 88 +++++++++++++++++++-----------------------
>  1 file changed, 39 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e618472c572b..80205aea296e 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3685,37 +3685,43 @@ static int mmu_check_root(struct kvm_vcpu *vcpu, gfn_t root_gfn)
>  	return ret;
>  }
>  
> +static hpa_t mmu_alloc_root(struct kvm_vcpu *vcpu, gfn_t gfn, gva_t gva,
> +			    u8 level, bool direct)
> +{
> +	struct kvm_mmu_page *sp;
> +
> +	spin_lock(&vcpu->kvm->mmu_lock);
> +
> +	if (make_mmu_pages_available(vcpu)) {
> +		spin_unlock(&vcpu->kvm->mmu_lock);
> +		return INVALID_PAGE;
> +	}
> +	sp = kvm_mmu_get_page(vcpu, gfn, gva, level, direct, ACC_ALL);
> +	++sp->root_count;
> +
> +	spin_unlock(&vcpu->kvm->mmu_lock);
> +	return __pa(sp->spt);
> +}
> +
>  static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_mmu_page *sp;
> +	u8 shadow_root_level = vcpu->arch.mmu->shadow_root_level;
> +	hpa_t root;
>  	unsigned i;
>  
> -	if (vcpu->arch.mmu->shadow_root_level >= PT64_ROOT_4LEVEL) {
> -		spin_lock(&vcpu->kvm->mmu_lock);
> -		if(make_mmu_pages_available(vcpu) < 0) {
> -			spin_unlock(&vcpu->kvm->mmu_lock);
> +	if (shadow_root_level >= PT64_ROOT_4LEVEL) {
> +		root = mmu_alloc_root(vcpu, 0, 0, shadow_root_level, true);
> +		if (!VALID_PAGE(root))
>  			return -ENOSPC;
> -		}
> -		sp = kvm_mmu_get_page(vcpu, 0, 0,
> -				vcpu->arch.mmu->shadow_root_level, 1, ACC_ALL);
> -		++sp->root_count;
> -		spin_unlock(&vcpu->kvm->mmu_lock);
> -		vcpu->arch.mmu->root_hpa = __pa(sp->spt);
> -	} else if (vcpu->arch.mmu->shadow_root_level == PT32E_ROOT_LEVEL) {
> +		vcpu->arch.mmu->root_hpa = root;
> +	} else if (shadow_root_level == PT32E_ROOT_LEVEL) {
>  		for (i = 0; i < 4; ++i) {
> -			hpa_t root = vcpu->arch.mmu->pae_root[i];
> +			MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
>  
> -			MMU_WARN_ON(VALID_PAGE(root));
> -			spin_lock(&vcpu->kvm->mmu_lock);
> -			if (make_mmu_pages_available(vcpu) < 0) {
> -				spin_unlock(&vcpu->kvm->mmu_lock);
> +			root = mmu_alloc_root(vcpu, i << (30 - PAGE_SHIFT),
> +					      i << 30, PT32_ROOT_LEVEL, true);
> +			if (!VALID_PAGE(root))
>  				return -ENOSPC;
> -			}
> -			sp = kvm_mmu_get_page(vcpu, i << (30 - PAGE_SHIFT),
> -					i << 30, PT32_ROOT_LEVEL, 1, ACC_ALL);
> -			root = __pa(sp->spt);
> -			++sp->root_count;
> -			spin_unlock(&vcpu->kvm->mmu_lock);
>  			vcpu->arch.mmu->pae_root[i] = root | PT_PRESENT_MASK;
>  		}
>  		vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
> @@ -3730,9 +3736,9 @@ static int mmu_alloc_direct_roots(struct kvm_vcpu *vcpu)
>  
>  static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  {
> -	struct kvm_mmu_page *sp;
>  	u64 pdptr, pm_mask;
>  	gfn_t root_gfn, root_pgd;
> +	hpa_t root;
>  	int i;
>  
>  	root_pgd = vcpu->arch.mmu->get_guest_pgd(vcpu);
> @@ -3746,20 +3752,12 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  	 * write-protect the guests page table root.
>  	 */
>  	if (vcpu->arch.mmu->root_level >= PT64_ROOT_4LEVEL) {
> -		hpa_t root = vcpu->arch.mmu->root_hpa;
> +		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->root_hpa));
>  
> -		MMU_WARN_ON(VALID_PAGE(root));
> -
> -		spin_lock(&vcpu->kvm->mmu_lock);
> -		if (make_mmu_pages_available(vcpu) < 0) {
> -			spin_unlock(&vcpu->kvm->mmu_lock);
> +		root = mmu_alloc_root(vcpu, root_gfn, 0,
> +				      vcpu->arch.mmu->shadow_root_level, false);
> +		if (!VALID_PAGE(root))
>  			return -ENOSPC;
> -		}
> -		sp = kvm_mmu_get_page(vcpu, root_gfn, 0,
> -				vcpu->arch.mmu->shadow_root_level, 0, ACC_ALL);
> -		root = __pa(sp->spt);
> -		++sp->root_count;
> -		spin_unlock(&vcpu->kvm->mmu_lock);
>  		vcpu->arch.mmu->root_hpa = root;
>  		goto set_root_pgd;
>  	}
> @@ -3774,9 +3772,7 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  		pm_mask |= PT_ACCESSED_MASK | PT_WRITABLE_MASK | PT_USER_MASK;
>  
>  	for (i = 0; i < 4; ++i) {
> -		hpa_t root = vcpu->arch.mmu->pae_root[i];
> -
> -		MMU_WARN_ON(VALID_PAGE(root));
> +		MMU_WARN_ON(VALID_PAGE(vcpu->arch.mmu->pae_root[i]));
>  		if (vcpu->arch.mmu->root_level == PT32E_ROOT_LEVEL) {
>  			pdptr = vcpu->arch.mmu->get_pdptr(vcpu, i);
>  			if (!(pdptr & PT_PRESENT_MASK)) {
> @@ -3787,17 +3783,11 @@ static int mmu_alloc_shadow_roots(struct kvm_vcpu *vcpu)
>  			if (mmu_check_root(vcpu, root_gfn))
>  				return 1;
>  		}
> -		spin_lock(&vcpu->kvm->mmu_lock);
> -		if (make_mmu_pages_available(vcpu) < 0) {
> -			spin_unlock(&vcpu->kvm->mmu_lock);
> -			return -ENOSPC;
> -		}
> -		sp = kvm_mmu_get_page(vcpu, root_gfn, i << 30, PT32_ROOT_LEVEL,
> -				      0, ACC_ALL);
> -		root = __pa(sp->spt);
> -		++sp->root_count;
> -		spin_unlock(&vcpu->kvm->mmu_lock);
>  
> +		root = mmu_alloc_root(vcpu, root_gfn, i << 30,
> +				      PT32_ROOT_LEVEL, false);
> +		if (!VALID_PAGE(root))
> +			return -ENOSPC;
>  		vcpu->arch.mmu->pae_root[i] = root | pm_mask;
>  	}
>  	vcpu->arch.mmu->root_hpa = __pa(vcpu->arch.mmu->pae_root);
> 

Queued, thanks.

Paolo

