Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADDD5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 786D5206D7
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ex9YMw/U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730929AbgGVRLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:11:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44456 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726462AbgGVRLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:11:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595437893;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jgHkAgpp92rw0Wj8bzn64y2E1QZKk8swHW8VX3GHDZI=;
        b=ex9YMw/UISQ817i1q0OgmcO8qz6+RRBWsnE8qfMhTH9n2GPMXfMF8HJImPsusXvFbQAepS
        8XXzsS8wuqcQ1EAhulehFB4y40ov5+duz4hsqgRiCk5mB8A9QQjOrku0u15AFyQ2fAiqPf
        nMzNyCMKWiaJu6lH4q80/0Qj5WHNk+E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-ZzFVkQPhNGC3klBRVgpv3A-1; Wed, 22 Jul 2020 13:11:31 -0400
X-MC-Unique: ZzFVkQPhNGC3klBRVgpv3A-1
Received: by mail-ed1-f72.google.com with SMTP id u25so1002466edq.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 10:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jgHkAgpp92rw0Wj8bzn64y2E1QZKk8swHW8VX3GHDZI=;
        b=DfPyNLuRdriU10TyPs9mm/Nqn0rCMWexvDTs/cSD/O4t6C03fMRd5KTbwULmOJmw86
         BqkdMWko8jVFoaGKznsfVzCjnl+LbJwSeOK/UVAi1N1wP6TlIjNqiyQlqTx9l2bd4ZRQ
         hHgJwXtTV3WT0UZ2F/EHHodxDqtSfegpEPaia2antyCioxAUNHvbExrYQ9EyBiTtfobo
         EaqcDGE+DL0qdhuMSBs4tmL/VlT0LbwkCBgOv2b79xWwADDU4xwG4GaILRNBDkXSkcRK
         qtJBmYpBm9nSs3k5e1KHYhI+oVaalLWmxKHJ8jo4SkW3XX0o2Xf3eYeaGdE2sstKkTIL
         JSqw==
X-Gm-Message-State: AOAM531pz+uoqwOtnrvD4/62jUxkBt++JB3BA1ls0uVEoRzWArqPKwpF
        O3HKXeB2hdNQWSnEEyWtibqcqFuJckHktQKeQPjxcWSs0RkjpwsjIfNBbzryoGJyX2QEgEaFs+H
        D8flBIITWADKH6PGgAyY8CebF
X-Received: by 2002:a17:906:365a:: with SMTP id r26mr584690ejb.52.1595437889695;
        Wed, 22 Jul 2020 10:11:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxIDQvaBXZjm8+nbGJrQMnFZKRGvGcs/2efdjyAdlvhOm2XaFuaDCx8DZIlSecIFUl/fN/0gw==
X-Received: by 2002:a17:906:365a:: with SMTP id r26mr584662ejb.52.1595437889370;
        Wed, 22 Jul 2020 10:11:29 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p4sm150601eji.123.2020.07.22.10.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 10:11:28 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/9] KVM: x86: Pull the PGD's level from the MMU instead of recalculating it
In-Reply-To: <20200716034122.5998-6-sean.j.christopherson@intel.com>
References: <20200716034122.5998-1-sean.j.christopherson@intel.com> <20200716034122.5998-6-sean.j.christopherson@intel.com>
Date:   Wed, 22 Jul 2020 19:11:26 +0200
Message-ID: <871rl3pj9d.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use the shadow_root_level from the current MMU as the root level for the
> PGD, i.e. for VMX's EPTP.  This eliminates the weird dependency between
> VMX and the MMU where both must independently calculate the same root
> level for things to work correctly.  Temporarily keep VMX's calculation
> of the level and use it to WARN if the incoming level diverges.
>
> Opportunistically refactor kvm_mmu_load_pgd() to avoid indentation hell,
> and rename a 'cr3' param in the load_mmu_pgd prototype that managed to
> survive the cr3 purge.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  3 ++-
>  arch/x86/kvm/mmu.h              | 10 +++++++---
>  arch/x86/kvm/svm/svm.c          |  3 ++-
>  arch/x86/kvm/vmx/nested.c       |  2 +-
>  arch/x86/kvm/vmx/vmx.c          | 18 ++++++++++++------
>  arch/x86/kvm/vmx/vmx.h          |  3 ++-
>  6 files changed, 26 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1bab87a444d78..ce60f4c38843f 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1136,7 +1136,8 @@ struct kvm_x86_ops {
>  	int (*get_tdp_level)(struct kvm_vcpu *vcpu);
>  	u64 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
>  
> -	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, unsigned long cr3);
> +	void (*load_mmu_pgd)(struct kvm_vcpu *vcpu, unsigned long pgd,
> +			     int pgd_level);
>  
>  	bool (*has_wbinvd_exit)(void);
>  
> diff --git a/arch/x86/kvm/mmu.h b/arch/x86/kvm/mmu.h
> index 9f6554613babc..5efc6081ca138 100644
> --- a/arch/x86/kvm/mmu.h
> +++ b/arch/x86/kvm/mmu.h
> @@ -90,9 +90,13 @@ static inline unsigned long kvm_get_active_pcid(struct kvm_vcpu *vcpu)
>  
>  static inline void kvm_mmu_load_pgd(struct kvm_vcpu *vcpu)
>  {
> -	if (VALID_PAGE(vcpu->arch.mmu->root_hpa))
> -		kvm_x86_ops.load_mmu_pgd(vcpu, vcpu->arch.mmu->root_hpa |
> -					       kvm_get_active_pcid(vcpu));
> +	u64 root_hpa = vcpu->arch.mmu->root_hpa;
> +
> +	if (!VALID_PAGE(root_hpa))
> +		return;
> +
> +	kvm_x86_ops.load_mmu_pgd(vcpu, root_hpa | kvm_get_active_pcid(vcpu),
> +				 vcpu->arch.mmu->shadow_root_level);
>  }
>  
>  int kvm_tdp_page_fault(struct kvm_vcpu *vcpu, gpa_t gpa, u32 error_code,
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index 783330d0e7b88..c70d7dd333061 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3541,7 +3541,8 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
>  	return exit_fastpath;
>  }
>  
> -static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long root)
> +static void svm_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long root,
> +			     int root_level)
>  {
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  	unsigned long cr3;
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 4d561edf6f9ca..50b56622e16a6 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -2162,7 +2162,7 @@ static void prepare_vmcs02_constant_state(struct vcpu_vmx *vmx)
>  	 * consistency checks.
>  	 */
>  	if (enable_ept && nested_early_check)
> -		vmcs_write64(EPT_POINTER, construct_eptp(&vmx->vcpu, 0));
> +		vmcs_write64(EPT_POINTER, construct_eptp(&vmx->vcpu, 0, 4));

Nit: could we use MMU's PT64_ROOT_4LEVEL instead of '4' here?

>  
>  	/* All VMFUNCs are currently emulated through L0 vmexits.  */
>  	if (cpu_has_vmx_vmfunc())
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 791baa73e5786..244053cff0a3a 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2933,14 +2933,16 @@ static void vmx_flush_tlb_all(struct kvm_vcpu *vcpu)
>  
>  static void vmx_flush_tlb_current(struct kvm_vcpu *vcpu)
>  {
> -	u64 root_hpa = vcpu->arch.mmu->root_hpa;
> +	struct kvm_mmu *mmu = vcpu->arch.mmu;
> +	u64 root_hpa = mmu->root_hpa;
>  
>  	/* No flush required if the current context is invalid. */
>  	if (!VALID_PAGE(root_hpa))
>  		return;
>  
>  	if (enable_ept)
> -		ept_sync_context(construct_eptp(vcpu, root_hpa));
> +		ept_sync_context(construct_eptp(vcpu, root_hpa,
> +						mmu->shadow_root_level));
>  	else if (!is_guest_mode(vcpu))
>  		vpid_sync_context(to_vmx(vcpu)->vpid);
>  	else
> @@ -3078,11 +3080,12 @@ static int get_ept_level(struct kvm_vcpu *vcpu)
>  	return vmx_get_tdp_level(vcpu);
>  }
>  
> -u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa)
> +u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa,
> +		   int root_level)
>  {
>  	u64 eptp = VMX_EPTP_MT_WB;
>  
> -	eptp |= (get_ept_level(vcpu) == 5) ? VMX_EPTP_PWL_5 : VMX_EPTP_PWL_4;
> +	eptp |= (root_level == 5) ? VMX_EPTP_PWL_5 : VMX_EPTP_PWL_4;
>  
>  	if (enable_ept_ad_bits &&
>  	    (!is_guest_mode(vcpu) || nested_ept_ad_enabled(vcpu)))
> @@ -3092,7 +3095,8 @@ u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa)
>  	return eptp;
>  }
>  
> -static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd)
> +static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd,
> +			     int pgd_level)
>  {
>  	struct kvm *kvm = vcpu->kvm;
>  	bool update_guest_cr3 = true;
> @@ -3100,7 +3104,9 @@ static void vmx_load_mmu_pgd(struct kvm_vcpu *vcpu, unsigned long pgd)
>  	u64 eptp;
>  
>  	if (enable_ept) {
> -		eptp = construct_eptp(vcpu, pgd);
> +		WARN_ON(pgd_level != get_ept_level(vcpu));
> +
> +		eptp = construct_eptp(vcpu, pgd, pgd_level);
>  		vmcs_write64(EPT_POINTER, eptp);
>  
>  		if (kvm_x86_ops.tlb_remote_flush) {
> diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
> index 3c55433ac1b21..26175a4759fa5 100644
> --- a/arch/x86/kvm/vmx/vmx.h
> +++ b/arch/x86/kvm/vmx/vmx.h
> @@ -341,7 +341,8 @@ void set_cr4_guest_host_mask(struct vcpu_vmx *vmx);
>  void ept_save_pdptrs(struct kvm_vcpu *vcpu);
>  void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
>  void vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
> -u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa);
> +u64 construct_eptp(struct kvm_vcpu *vcpu, unsigned long root_hpa,
> +		   int root_level);
>  void update_exception_bitmap(struct kvm_vcpu *vcpu);
>  void vmx_update_msr_bitmap(struct kvm_vcpu *vcpu);
>  bool vmx_nmi_blocked(struct kvm_vcpu *vcpu);

-- 
Vitaly

