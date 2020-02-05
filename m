Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AC6C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B48D22082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 13:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SvQRJcQx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgBENwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 08:52:41 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:35714 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726308AbgBENwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 08:52:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580910759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5Sj7x8CxfrfyHDRynAhfcdpyI/AgR8ICRTetDOHq/Y=;
        b=SvQRJcQxMKJ+jsF63X0SbV6GphAT3UCcUzNxt7GZAzBDitDBxZ4qobaNyHLtKHXUtSlCeS
        vB79/XnSG+Vujf4a+7riAnfUNN8P4UqouX+vacOulaSGiEETTgvsYotT3um4cN49io8POy
        lRaGNeQH+F4JWOD6suoNBMy5C6slspU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-vpsCb2uyPaq6xnAEjYNzfg-1; Wed, 05 Feb 2020 08:52:36 -0500
X-MC-Unique: vpsCb2uyPaq6xnAEjYNzfg-1
Received: by mail-wr1-f72.google.com with SMTP id f10so1212998wro.14
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 05:52:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=f5Sj7x8CxfrfyHDRynAhfcdpyI/AgR8ICRTetDOHq/Y=;
        b=cOrb2Bnnv7fR+v4u0RiVaQc49YbdCQSs+CfBBdNKR21UnRyup3ZtohFWq79F7bXZxs
         5quXVk8bRxd76Nok/8o4YjIyCAR58z6OVhjkj4KHpDOgFgLpXE+Z7VFt+/Xr403FNMGW
         kMCUfT6jd8SJVtcBdfUJbwzYCUxLCVlP8WHBBE9qseiq0VITw4KUC+29kkLhU6JQ4LRQ
         d42oMhl9AvL3GePMstUtwXLrd+8pVjuEnYSAfZyLGmGZ8oq1u0P6KbqTct8MZpXLdc7j
         QQbOw3Am+NCK+N/GHfZ82JzaeS9Kb9LPgYXIXDyPJpH21tr7xl4lscuy6+V/8BfYbB9o
         X93A==
X-Gm-Message-State: APjAAAWRFzpNU7lo4fmq9CtE1gc4etM9F1KQgRHy45wk+1NE5Si7xhQJ
        IwBWN6rmqxoVVKX8S2OEDr2nu9pJjNhtA9GTllnXzvBFUWJweF+JzamYiGfC5YuJDcnbPjpTGQm
        BASuhuSLEWCYxuEgs5ZTZWb3+
X-Received: by 2002:a1c:5419:: with SMTP id i25mr5991849wmb.150.1580910754601;
        Wed, 05 Feb 2020 05:52:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqy9C7S2xWyX6maFcY4AIf2bKYC/DyzgQynh2K/exOYnOeWiI1Vof7HIHkVr0VnE9kYTD22Z1A==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr5991818wmb.150.1580910754300;
        Wed, 05 Feb 2020 05:52:34 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r5sm34859540wrt.43.2020.02.05.05.52.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 05:52:33 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        Ben Gardon <bgardon@google.com>
Subject: Re: [PATCH 3/3] kvm: mmu: Separate pte generation from set_spte
In-Reply-To: <20200203230911.39755-3-bgardon@google.com>
References: <20200203230911.39755-1-bgardon@google.com> <20200203230911.39755-3-bgardon@google.com>
Date:   Wed, 05 Feb 2020 14:52:32 +0100
Message-ID: <87pnetkuov.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Gardon <bgardon@google.com> writes:

> Separate the functions for generating leaf page table entries from the
> function that inserts them into the paging structure. This refactoring
> will facilitate changes to the MMU sychronization model to use atomic
> compare / exchanges (which are not guaranteed to succeed) instead of a
> monolithic MMU lock.
>
> No functional change expected.
>
> Tested by running kvm-unit-tests on an Intel Haswell machine. This
> commit introduced no new failures.
>
> This commit can be viewed in Gerrit at:
> 	https://linux-review.googlesource.com/c/virt/kvm/kvm/+/2360
>
> Signed-off-by: Ben Gardon <bgardon@google.com>
> Reviewed-by: Peter Shier <pshier@google.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 52 +++++++++++++++++++++++++++---------------
>  1 file changed, 34 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index b81010d0edae1..9239ad5265dc6 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -3000,20 +3000,14 @@ static bool kvm_is_mmio_pfn(kvm_pfn_t pfn)
>  #define SET_SPTE_WRITE_PROTECTED_PT	BIT(0)
>  #define SET_SPTE_NEED_REMOTE_TLB_FLUSH	BIT(1)
>  
> -static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> -		    unsigned int pte_access, int level,
> -		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
> -		    bool can_unsync, bool host_writable)
> +static u64 make_spte(struct kvm_vcpu *vcpu, unsigned int pte_access, int level,
> +		     gfn_t gfn, kvm_pfn_t pfn, u64 old_spte, bool speculative,
> +		     bool can_unsync, bool host_writable, bool ad_disabled,
> +		     int *ret)

With such a long parameter list we may think about passing a pointer to
a structure instead (common for make_spte()/set_spte())

>  {
>  	u64 spte = 0;
> -	int ret = 0;
> -	struct kvm_mmu_page *sp;
> -
> -	if (set_mmio_spte(vcpu, sptep, gfn, pfn, pte_access))
> -		return 0;
>  
> -	sp = page_header(__pa(sptep));
> -	if (sp_ad_disabled(sp))
> +	if (ad_disabled)
>  		spte |= SPTE_AD_DISABLED_MASK;
>  	else if (kvm_vcpu_ad_need_write_protect(vcpu))
>  		spte |= SPTE_AD_WRPROT_ONLY_MASK;
> @@ -3066,27 +3060,49 @@ static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
>  		 * is responsibility of mmu_get_page / kvm_sync_page.
>  		 * Same reasoning can be applied to dirty page accounting.
>  		 */
> -		if (!can_unsync && is_writable_pte(*sptep))
> -			goto set_pte;
> +		if (!can_unsync && is_writable_pte(old_spte))
> +			return spte;
>  
>  		if (mmu_need_write_protect(vcpu, gfn, can_unsync)) {
>  			pgprintk("%s: found shadow page for %llx, marking ro\n",
>  				 __func__, gfn);
> -			ret |= SET_SPTE_WRITE_PROTECTED_PT;
> +			*ret |= SET_SPTE_WRITE_PROTECTED_PT;
>  			pte_access &= ~ACC_WRITE_MASK;
>  			spte &= ~(PT_WRITABLE_MASK | SPTE_MMU_WRITEABLE);
>  		}
>  	}
>  
> -	if (pte_access & ACC_WRITE_MASK) {
> -		kvm_vcpu_mark_page_dirty(vcpu, gfn);
> +	if (pte_access & ACC_WRITE_MASK)
>  		spte |= spte_shadow_dirty_mask(spte);
> -	}
>  
>  	if (speculative)
>  		spte = mark_spte_for_access_track(spte);
>  
> -set_pte:
> +	return spte;
> +}
> +
> +static int set_spte(struct kvm_vcpu *vcpu, u64 *sptep,
> +		    unsigned int pte_access, int level,
> +		    gfn_t gfn, kvm_pfn_t pfn, bool speculative,
> +		    bool can_unsync, bool host_writable)
> +{
> +	u64 spte = 0;
> +	struct kvm_mmu_page *sp;
> +	int ret = 0;
> +
> +	if (set_mmio_spte(vcpu, sptep, gfn, pfn, pte_access))
> +		return 0;
> +
> +	sp = page_header(__pa(sptep));
> +
> +	spte = make_spte(vcpu, pte_access, level, gfn, pfn, *sptep, speculative,
> +			 can_unsync, host_writable, sp_ad_disabled(sp), &ret);

I'm probably missing something, but in make_spte() I see just one place
which writes to '*ret' so at the end, this is either
SET_SPTE_WRITE_PROTECTED_PT or 0 (which we got only because we
initialize it to 0 in set_spte()). Unless this is preparation to some
other change, I don't see much value in the complication.

Can we actually reverse the logic, pass 'spte' by reference and return
'ret'?

> +	if (!spte)
> +		return 0;
> +
> +	if (spte & PT_WRITABLE_MASK)
> +		kvm_vcpu_mark_page_dirty(vcpu, gfn);
> +
>  	if (mmu_spte_update(sptep, spte))
>  		ret |= SET_SPTE_NEED_REMOTE_TLB_FLUSH;
>  	return ret;

-- 
Vitaly

