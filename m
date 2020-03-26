Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 627F4C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35CC120774
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 13:41:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MdQkphnA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727736AbgCZNlL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 09:41:11 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:47180 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725994AbgCZNlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 09:41:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585230069;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oGdFXcuSNv1lFds/DpxLS9JrxVpkM15AF9tzkx4/Jpw=;
        b=MdQkphnAdpsON0whYW7yI4brYDkR2PrlQRd905vrNciMubHgKQEOSeIfXVovW+wQLO7ClL
        2PaB1PDH/xzgtDVS3f64TWgi5vucWqDVff470VJip67h4JF8z+JezggvCqtvaTYviNYEO7
        JqK1f1NOH2C3LT2opE8JWOjDVgcJlhg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-XagGmvkIOpqzgyOi8buw4Q-1; Thu, 26 Mar 2020 09:41:07 -0400
X-MC-Unique: XagGmvkIOpqzgyOi8buw4Q-1
Received: by mail-wm1-f70.google.com with SMTP id m4so3945406wme.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 06:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=oGdFXcuSNv1lFds/DpxLS9JrxVpkM15AF9tzkx4/Jpw=;
        b=he91fnAGscMJ/9N9pP5ExJRqp9UEUpvKegeosznOduSHA7J/Z+c/ivVF7VLFiiP9Xw
         Rgt5KFC8XgCapgD2aVFeNT2/Rr/UDVxdGuHLF71KCQrqGAAYiVElIClGZh+IpKtsMmsb
         bjwDyrsZxvGDeJXxKaQRbmQStYkMDkiHiiU+18rYzWrfVhZYowgJxGPrS+gsEtJoSVdX
         4oSFnwn0fSzCIOckmYuQxgvYRaFzuUMmLfzlzTBXqIv5fnWPSKDueESgFSE+kwtd1KEG
         NpEsQOnK5CBhcEuRuhauyeUVNGmAL7Crz58BxPd4ERB7lQQvyEC7YpHWo7fkN+5eI2zs
         oMuQ==
X-Gm-Message-State: ANhLgQ1Lz1Hq/berQRUnzrIaB2yWgsdACqRHNl6GjZvmc9tapPU2oCWz
        yD+KYQ/+7PKajR9dvkgysSK6Le5Sur/hkKFYSwXkN6OrpyahZHy/pDq9GpcWFwSD1eFrNSGy9K1
        DWrtugHQt3etNiKVYL/k54dcZ
X-Received: by 2002:a1c:2404:: with SMTP id k4mr2005wmk.87.1585230063508;
        Thu, 26 Mar 2020 06:41:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtbbJGmBwGro5wmdPWHJOZmcvHECfDoJz68BZJMx279+d/UfjAoFqC4VUFQQs7980HsVdEJAw==
X-Received: by 2002:a1c:2404:: with SMTP id k4mr1979wmk.87.1585230063220;
        Thu, 26 Mar 2020 06:41:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y11sm3755358wrd.65.2020.03.26.06.41.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 06:41:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Junaid Shahid <junaids@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 2/3] KVM: x86: cleanup kvm_inject_emulated_page_fault
In-Reply-To: <20200326093516.24215-3-pbonzini@redhat.com>
References: <20200326093516.24215-1-pbonzini@redhat.com> <20200326093516.24215-3-pbonzini@redhat.com>
Date:   Thu, 26 Mar 2020 14:41:01 +0100
Message-ID: <877dz75j4i.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> To reconstruct the kvm_mmu to be used for page fault injection, we
> can simply use fault->nested_page_fault.  This matches how
> fault->nested_page_fault is assigned in the first place by
> FNAME(walk_addr_generic).
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c         | 6 ------
>  arch/x86/kvm/mmu/paging_tmpl.h | 2 +-
>  arch/x86/kvm/x86.c             | 7 +++----
>  3 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index e26c9a583e75..6250e31ac617 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -4353,12 +4353,6 @@ static unsigned long get_cr3(struct kvm_vcpu *vcpu)
>  	return kvm_read_cr3(vcpu);
>  }
>  
> -static void inject_page_fault(struct kvm_vcpu *vcpu,
> -			      struct x86_exception *fault)
> -{
> -	vcpu->arch.mmu->inject_page_fault(vcpu, fault);
> -}
> -

This is already gone with Sean's "KVM: x86: Consolidate logic for
injecting page faults to L1".

It would probably make sense to have a combined series (or a branch on
kvm.git) to simplify testing efforts.

>  static bool sync_mmio_spte(struct kvm_vcpu *vcpu, u64 *sptep, gfn_t gfn,
>  			   unsigned int access, int *nr_present)
>  {
> diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
> index 1ddbfff64ccc..ae646acf6703 100644
> --- a/arch/x86/kvm/mmu/paging_tmpl.h
> +++ b/arch/x86/kvm/mmu/paging_tmpl.h
> @@ -812,7 +812,7 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, gpa_t addr, u32 error_code,
>  	if (!r) {
>  		pgprintk("%s: guest page fault\n", __func__);
>  		if (!prefault)
> -			inject_page_fault(vcpu, &walker.fault);
> +			kvm_inject_emulated_page_fault(vcpu, &walker.fault);
>  
>  		return RET_PF_RETRY;
>  	}
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 64ed6e6e2b56..522905523bf0 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -614,12 +614,11 @@ EXPORT_SYMBOL_GPL(kvm_inject_page_fault);
>  bool kvm_inject_emulated_page_fault(struct kvm_vcpu *vcpu,
>  				    struct x86_exception *fault)
>  {
> +	struct kvm_mmu *fault_mmu;
>  	WARN_ON_ONCE(fault->vector != PF_VECTOR);
>  
> -	if (mmu_is_nested(vcpu) && !fault->nested_page_fault)
> -		vcpu->arch.nested_mmu.inject_page_fault(vcpu, fault);
> -	else
> -		vcpu->arch.mmu->inject_page_fault(vcpu, fault);
> +	fault_mmu = fault->nested_page_fault ? vcpu->arch.mmu : vcpu->arch.walk_mmu;
> +	fault_mmu->inject_page_fault(vcpu, fault);
>  
>  	return fault->nested_page_fault;
>  }

-- 
Vitaly

