Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7698DC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4471C217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X6pGbPFA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbgBEMAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:00:20 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:49827 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgBEMAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:00:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580904018;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Z9OdtqIYUBqoL66r9+oESb2jG/fvhjGyIkGlsqD7Tqs=;
        b=X6pGbPFA6D4WvFECHidJJnQ/GLuPG3fwztAkRMGqvI9/MkLYCmcZbtOwgmyqQSTrTNSjOT
        OUEhF3euSXyjzXoFsapGuRey3Cj2r1DJGUSXLXr3pWsoZ3SZD61ek68lZ65M8jWh5XXRAw
        SS346G5UjU9M/5ZPccVkyK7zmQRgCu8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-101-OuJYWiTJN5Ce_2QUHArEmQ-1; Wed, 05 Feb 2020 07:00:14 -0500
X-MC-Unique: OuJYWiTJN5Ce_2QUHArEmQ-1
Received: by mail-wr1-f72.google.com with SMTP id c6so1061912wrm.18
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 04:00:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Z9OdtqIYUBqoL66r9+oESb2jG/fvhjGyIkGlsqD7Tqs=;
        b=nXRRbhhYpz3QQWefMm3Z4Lm3V9s7zCFboxYTljtMi21atbxnWEdQABOM6ykPaEa1Jq
         ClixC8icUeioQwyAm+wb8YGGFkk+2i/7j6yQgTtCRVX11a0aTQ9cNJkPmYn4bqBgegvw
         wGXUWu96z+pu3Di0+DbTxJVoIfraiIXx0/I0v5nbIZwrXAlhohDo+aJUAZ9eB0FCrROE
         0JDg1ObShUbefodwsruBGYMg4+DpNXQ+Ig1HQr6KI7r4qSpRbDEuTOOsUg5ZPfkfEHxj
         xC8RPM+F/djRCEdua0i9Yft1FB2XOlLXcNzsSPaJOqV6dN/CstiAnZsaPA72ifGhbw5y
         CltQ==
X-Gm-Message-State: APjAAAW3Nla3GorFU7mszAHZPj0iiQ/atgHl9Q11sJJrK/tDOGFAh0Mx
        aVP+EIcu48Q903mQ8g6TtPMIcOqKY9a6evfON6kusgdaVh8iAnkjXeKSgqDCs461AtsT7VNJ4iG
        chKiGvzOVOPWBYDWp1jwgc314
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr22168464wrs.97.1580904013136;
        Wed, 05 Feb 2020 04:00:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqwSvQyMeJTISB9Ag6NMPuNBbKfC47aIaLnVUfMV7jVwsDN2cT06Yn/Y71CxLRow8+0A6XsFrQ==
X-Received: by 2002:a5d:4c89:: with SMTP id z9mr22168431wrs.97.1580904012809;
        Wed, 05 Feb 2020 04:00:12 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q14sm34679205wrj.81.2020.02.05.04.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 04:00:12 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ben Gardon <bgardon@google.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 1/3] kvm: mmu: Replace unsigned with unsigned int for PTE access
In-Reply-To: <20200203230911.39755-1-bgardon@google.com>
References: <20200203230911.39755-1-bgardon@google.com>
Date:   Wed, 05 Feb 2020 13:00:11 +0100
Message-ID: <87v9olkzw4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Gardon <bgardon@google.com> writes:

> There are several functions which pass an access permission mask for
> SPTEs as an unsigned. This works, but checkpatch complains about it.
> Switch the occurrences of unsigned to unsigned int to satisfy checkpatch.
>
> No functional change expected.
>
> Tested by running kvm-unit-tests on an Intel Haswell machine. This
> commit introduced no new failures.
>
> This commit can be viewed in Gerrit at:
> 	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2358
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Oliver Upton <oupton@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 84eeb61d06aa3..a9c593dec49bf 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -452,7 +452,7 @@ static u64 get_mmio_spte_generation(u64 spte)
>  }
>  
>  static void mark_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, u64 gfn,
> -			   unsigned access)
> +			   unsigned int access)
>  {
>  	u64 gen = kvm_vcpu_memslots(vcpu)->generation & MMIO_SPTE_GEN_MASK;
>  	u64 mask = generation_mmio_spte_mask(gen);
> @@ -484,7 +484,7 @@ static unsigned get_mmio_spte_access(u64 spte)
>  }
>  
>  static bool set_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
> -			  kvm_pfn_t pfn, unsigned access)
> +			  kvm_pfn_t pfn, unsigned int access)
>  {
>  	if (unlikely(is_noslot_pfn(pfn))) {
>  		mark_mmio_spte(vcpu, sptep, gfn, access);
> @@ -2475,7 +2475,7 @@ static struct kvm_mmu_page *kvm_mmu_get_page(struct kvm_vcpu *vcpu,
>  					     gva_t gaddr,
>  					     unsigned level,
>  					     int direct,
> -					     unsigned access)
> +					     unsigned int access)
>  {
>  	union kvm_mmu_page_role role;
>  	unsigned quadrant;
> @@ -2990,7 +2990,7 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
>  #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
>  
>  static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> -		    unsigned pte_access, int level,
> +		    unsigned int pte_access, int level,
>  		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
>  		    bool can_unsync, bool host_writable)
>  {
> @@ -3081,9 +3081,10 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  	return ret;
>  }
>  
> -static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep, unsigned pte_access,
> -			int write_fault, int level, gfn_t gfn, kvm_pfn_t pfn,
> -		       	bool speculative, bool host_writable)
> +static int mmu_set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> +			unsigned int pte_access, int write_fault, int level,
> +			gfn_t gfn, kvm_pfn_t pfn, bool speculative,
> +			bool host_writable)
>  {
>  	int was_rmapped = 0;
>  	int rmap_count;
> @@ -3165,7 +3166,7 @@ static int direct_pte_prefetch_many(struct kvm_vcpu *vcpu,
>  {
>  	struct page *pages[PTE_PREFETCH_NUM];
>  	struct kvm_memory_slot *slot;
> -	unsigned access = sp->role.access;
> +	unsigned int access = sp->role.access;
>  	int i, ret;
>  	gfn_t gfn;
>  
> @@ -3400,7 +3401,8 @@ static int kvm_handle_bad_page(struct kvm_vcpu *vcpu, gfn_t gfn, kvm_pfn_t pfn)
>  }
>  
>  static bool handle_abnormal_pfn(struct kvm_vcpu *vcpu, gva_t gva, gfn_t gfn,
> -				kvm_pfn_t pfn, unsigned access, int *ret_val)
> +				kvm_pfn_t pfn, unsigned int access,
> +				int *ret_val)
>  {
>  	/* The pfn is invalid, report the error! */
>  	if (unlikely(is_error_pfn(pfn))) {
> @@ -4005,7 +4007,7 @@ static int handle_mmio_page_fault(struct kvm_vcpu *vcpu, u64 addr, bool direct)
>  
>  	if (is_mmio_spte(spte)) {
>  		gfn_t gfn = get_mmio_spte_gfn(spte);
> -		unsigned access = get_mmio_spte_access(spte);
> +		unsigned int access = get_mmio_spte_access(spte);
>  
>  		if (!check_mmio_spte(vcpu, spte))
>  			return RET_PF_INVALID;
> @@ -4349,7 +4351,7 @@ static void inject_page_fault(struct kvm_vcpu *vcpu,
>  }
>  
>  static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
> -			   unsigned access, int *nr_present)
> +			   unsigned int access, int *nr_present)
>  {
>  	if (unlikely(is_mmio_spte(*sptep))) {
>  		if (gfn != get_mmio_spte_gfn(*sptep)) {

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

