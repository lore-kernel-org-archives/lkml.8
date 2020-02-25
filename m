Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C0EC35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFE3420CC7
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:27:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DsMgI5Po"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730770AbgBYO1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:27:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37230 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730758AbgBYO1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:27:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582640871;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sxb28+S3GcOqcRUpw4IGeDLDXZNB1HMT0k222wA3ypI=;
        b=DsMgI5PoK0ZVDTPHEEdVEo+5EO6JA2cDGuypVeYifdt2kb5ezwjb/cd/S6mEAGSTue7cA3
        BVrpNUoNmJelfQKF0aNeZ898Nvlj3Jc11tZ/gy0Qvw0zf7kINS1jyRHk2RwVhSCkZF2cj5
        o3YWqtikDHxjZZTr9HWsO5U77TUcDgk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-360-DKSKxEOCPN-ZgwkjBBCP-A-1; Tue, 25 Feb 2020 09:27:50 -0500
X-MC-Unique: DKSKxEOCPN-ZgwkjBBCP-A-1
Received: by mail-wr1-f69.google.com with SMTP id s13so7357162wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sxb28+S3GcOqcRUpw4IGeDLDXZNB1HMT0k222wA3ypI=;
        b=tD0dnScclcjaAlNQ7hlC+VmEK5OqEd5kU2egMUIY/k69IZ4gJ4PpBFAWijcufoHfcA
         4KMtZDt0q+6XXvC+YhhThTBu3VHfe/weH+eSik5dMpZp77FrrpABT34j3sRXBBoSuOCP
         pMljnj9gmmph9IAYEQer7z/hFZJuUcQsn20q1Hm83ih9qBrUEhKQ3FKqATw2upIw4gRx
         ABaFDo7fbsRpFwZA2MEztpkCFrhDctMyWKLKKld1QxbWpYfrrg7vppXxCQ/E1Dr6Q9AP
         ZAwvWHgFI7ZuAImo/T/kvIgfqruZQx52i/kqKrz4w2ZvienGA/punbgYHqz2xdsWg8Pd
         N80Q==
X-Gm-Message-State: APjAAAVFSYfwmMD0ccGGOcEgChsFnSfSVXUOvng95oEADVWALlJwgu2G
        sxK0JWzwbyBAnP9uhj1qRGno8pNJ6fyi1mCJUQ9fh13OUOMU1y4kNNshHVTWu2giwyn5PRHwz5H
        uI/krdBL3VlUIiVTW6KePXeWg
X-Received: by 2002:adf:aa0e:: with SMTP id p14mr20709672wrd.399.1582640868661;
        Tue, 25 Feb 2020 06:27:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqx4D3UREkm8u4df6f6dlOnYyMZR00/oXxbAoHat7kDwXxnRJ5PBRjpkdpz9Q2FKz133cKbaVQ==
X-Received: by 2002:adf:aa0e:: with SMTP id p14mr20709645wrd.399.1582640868423;
        Tue, 25 Feb 2020 06:27:48 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s15sm24390458wrp.4.2020.02.25.06.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:27:47 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 57/61] KVM: x86/mmu: Merge kvm_{enable,disable}_tdp() into a common function
In-Reply-To: <20200201185218.24473-58-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-58-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:27:47 +0100
Message-ID: <87eeuilp24.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Combine kvm_enable_tdp() and kvm_disable_tdp() into a single function,
> kvm_configure_mmu(), in preparation for doing additional configuration
> during hardware setup.  And because having separate helpers is silly.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 +--
>  arch/x86/kvm/mmu/mmu.c          | 13 +++----------
>  arch/x86/kvm/svm.c              |  5 +----
>  arch/x86/kvm/vmx/vmx.c          |  4 +---
>  4 files changed, 6 insertions(+), 19 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a8bae9d88bce..1a13a53bbaeb 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1494,8 +1494,7 @@ void kvm_mmu_invlpg(struct kvm_vcpu *vcpu, gva_t gva);
>  void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid);
>  void kvm_mmu_new_cr3(struct kvm_vcpu *vcpu, gpa_t new_cr3, bool skip_tlb_flush);
>  
> -void kvm_enable_tdp(void);
> -void kvm_disable_tdp(void);
> +void kvm_configure_mmu(bool enable_tdp);
>  
>  static inline gpa_t translate_gpa(struct kvm_vcpu *vcpu, gpa_t gpa, u32 access,
>  				  struct x86_exception *exception)
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 84eeb61d06aa..08c80c7c88d4 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -5541,18 +5541,11 @@ void kvm_mmu_invpcid_gva(struct kvm_vcpu *vcpu, gva_t gva, unsigned long pcid)
>  }
>  EXPORT_SYMBOL_GPL(kvm_mmu_invpcid_gva);
>  
> -void kvm_enable_tdp(void)
> +void kvm_configure_mmu(bool enable_tdp)
>  {
> -	tdp_enabled = true;
> +	tdp_enabled = enable_tdp;
>  }
> -EXPORT_SYMBOL_GPL(kvm_enable_tdp);
> -
> -void kvm_disable_tdp(void)
> -{
> -	tdp_enabled = false;
> -}
> -EXPORT_SYMBOL_GPL(kvm_disable_tdp);
> -
> +EXPORT_SYMBOL_GPL(kvm_configure_mmu);
>  
>  /* The return value indicates if tlb flush on all vcpus is needed. */
>  typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 80962c1eea8f..19dc74ae1efb 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1443,10 +1443,7 @@ static __init int svm_hardware_setup(void)
>  	if (npt_enabled && !npt)
>  		npt_enabled = false;
>  
> -	if (npt_enabled)
> -		kvm_enable_tdp();
> -	else
> -		kvm_disable_tdp();
> +	kvm_configure_mmu(npt_enabled);
>  	pr_info("kvm: Nested Paging %sabled\n", npt_enabled ? "en" : "dis");
>  
>  	if (nrips) {
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index e6284b6aac56..59206c22b5e1 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -5295,7 +5295,6 @@ static void vmx_enable_tdp(void)
>  		VMX_EPT_RWX_MASK, 0ull);
>  
>  	ept_set_mmio_spte_mask();
> -	kvm_enable_tdp();
>  }
>  
>  /*
> @@ -7678,8 +7677,7 @@ static __init int hardware_setup(void)
>  
>  	if (enable_ept)
>  		vmx_enable_tdp();
> -	else
> -		kvm_disable_tdp();
> +	kvm_configure_mmu(enable_ept);
>  
>  	/*
>  	 * Only enable PML when hardware supports PML feature, and both EPT

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

