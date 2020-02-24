Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E37C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 310E620714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AD56ZL4H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727804AbgBXPYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:24:46 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54877 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727426AbgBXPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:24:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582557883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fuRRBlx4j4UkYx2EF/pAjANHxGGEpwASqI8e8VAeAfQ=;
        b=AD56ZL4HS2gZRVjhHPmdTeGWcn7Ma36dHWvK67ISbmLcGwGIsMLZLpiW+FVxo1R6+Zb3LN
        SXR8gN87mfT0eO4xEpnsw/JZcxF509tHAYZWLT3hfllrwKgt51tyxKyKUjrLbLVchvhUWx
        N5XH0LA0OIGJ3wCyPMPU2CgeUmrVCyM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-zHmZn8dvOPif-k1p-p-fEA-1; Mon, 24 Feb 2020 10:24:42 -0500
X-MC-Unique: zHmZn8dvOPif-k1p-p-fEA-1
Received: by mail-wr1-f69.google.com with SMTP id u8so5750436wrp.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:24:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=fuRRBlx4j4UkYx2EF/pAjANHxGGEpwASqI8e8VAeAfQ=;
        b=kBP0e9GdO9DnA59ge9nHbXFz9ByWLdg68/FV8kSpXXIMMHAYAFWy+NRkUbJOCX7Y3q
         RbfUEkjZMzaCCBCGVlTul/2PZ2/TyJRYetnNkA41Oukw/GH0hcdTNEGQCQSxSy7/9vfA
         pNfKVEJaDf9kWEWJQvgYAcz+GQ+TrbeVWzgP+F1as40qqFZg3JwOIw4zQAtbpwdniBJl
         qvMxJZADs8Krjjke74H1MYLFH1GK/FTt71P8kMskSHTOi52xo2e+stHH3mjC0XwC/L1T
         WqVvQE8NBww+dQ8yxpZSVtpriVN7zGl224ujzjc1xbESPxOruwPNuWX/eQMnIBtGoLJH
         ksyA==
X-Gm-Message-State: APjAAAWnTYzjy+QU4+OXhd9Li1Zl9lKpcIrqmCKim3W7M6PiHv4kPXsi
        GJAciGokzIWZnsVXpC3ZqR1VolziZiV2Jk/m1KqaGHcHxJMINOKvCFRUQUCkY/UVQvBdDcmhDhs
        rI7T6YCZerwqAbtKvA1xrvt6m
X-Received: by 2002:a5d:4481:: with SMTP id j1mr66652402wrq.348.1582557880691;
        Mon, 24 Feb 2020 07:24:40 -0800 (PST)
X-Google-Smtp-Source: APXvYqwaUXwEAZFnWFzGMUopuUjBNkaw48BMz5DDIfkPWCeW0aZgisdRAPUGaWC+O14ygb50gtDXTg==
X-Received: by 2002:a5d:4481:: with SMTP id j1mr66652386wrq.348.1582557880470;
        Mon, 24 Feb 2020 07:24:40 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id b7sm10956019wrs.97.2020.02.24.07.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:24:39 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 33/61] KVM: x86: Handle PKU CPUID adjustment in VMX code
In-Reply-To: <20200201185218.24473-34-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-34-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 16:24:39 +0100
Message-ID: <87v9nwnh3c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the setting of the PKU CPUID bit into VMX to eliminate an instance
> of the undesirable "unsigned f_* = *_supported ? F(*) : 0" pattern in
> the common CPUID handling code.  Drop ->pku_supported(), CPUID
> adjustment was the only user.
>
> Note, some AMD CPUs now support PKU, but SVM doesn't yet support
> exposing it to a guest.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/cpuid.c            | 5 -----
>  arch/x86/kvm/svm.c              | 6 ------
>  arch/x86/kvm/vmx/capabilities.h | 5 -----
>  arch/x86/kvm/vmx/vmx.c          | 6 +++++-
>  5 files changed, 5 insertions(+), 18 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 9baff70ad419..ba828569cda5 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1166,7 +1166,6 @@ struct kvm_x86_ops {
>  	bool (*xsaves_supported)(void);
>  	bool (*umip_emulated)(void);
>  	bool (*pt_supported)(void);
> -	bool (*pku_supported)(void);
>  
>  	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
>  	void (*request_immediate_exit)(struct kvm_vcpu *vcpu);
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 202a6c0f1db8..a1f46b3ca16e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -341,7 +341,6 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  {
>  	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>  	unsigned f_la57;
> -	unsigned f_pku = kvm_x86_ops->pku_supported() ? F(PKU) : 0;
>  
>  	/* cpuid 7.0.ebx */
>  	const u32 kvm_cpuid_7_0_ebx_x86_features =
> @@ -381,10 +380,6 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  		cpuid_entry_mask(entry, CPUID_7_ECX);
>  		/* Set LA57 based on hardware capability. */
>  		entry->ecx |= f_la57;
> -		entry->ecx |= f_pku;
> -		/* PKU is not yet implemented for shadow paging. */
> -		if (!tdp_enabled || !boot_cpu_has(X86_FEATURE_OSPKE))
> -			cpuid_entry_clear(entry, X86_FEATURE_PKU);
>  
>  		entry->edx &= kvm_cpuid_7_0_edx_x86_features;
>  		cpuid_entry_mask(entry, CPUID_7_EDX);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index c0f8c09f3b04..630520f8adfa 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6094,11 +6094,6 @@ static bool svm_has_wbinvd_exit(void)
>  	return true;
>  }
>  
> -static bool svm_pku_supported(void)
> -{
> -	return false;
> -}
> -
>  #define PRE_EX(exit)  { .exit_code = (exit), \
>  			.stage = X86_ICPT_PRE_EXCEPT, }
>  #define POST_EX(exit) { .exit_code = (exit), \
> @@ -7457,7 +7452,6 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  	.xsaves_supported = svm_xsaves_supported,
>  	.umip_emulated = svm_umip_emulated,
>  	.pt_supported = svm_pt_supported,
> -	.pku_supported = svm_pku_supported,
>  
>  	.set_supported_cpuid = svm_set_supported_cpuid,
>  
> diff --git a/arch/x86/kvm/vmx/capabilities.h b/arch/x86/kvm/vmx/capabilities.h
> index 0a0b1494a934..7cae355e3490 100644
> --- a/arch/x86/kvm/vmx/capabilities.h
> +++ b/arch/x86/kvm/vmx/capabilities.h
> @@ -145,11 +145,6 @@ static inline bool vmx_umip_emulated(void)
>  		SECONDARY_EXEC_DESC;
>  }
>  
> -static inline bool vmx_pku_supported(void)
> -{
> -	return boot_cpu_has(X86_FEATURE_PKU);
> -}
> -
>  static inline bool cpu_has_vmx_rdtscp(void)
>  {
>  	return vmcs_config.cpu_based_2nd_exec_ctrl &
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 9d2e36a5ecb9..a9728cc0c343 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7113,6 +7113,11 @@ static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  			cpuid_entry_set(entry, X86_FEATURE_INVPCID);
>  		if (vmx_umip_emulated())
>  			cpuid_entry_set(entry, X86_FEATURE_UMIP);
> +
> +		/* PKU is not yet implemented for shadow paging. */
> +		if (enable_ept && boot_cpu_has(X86_FEATURE_PKU) &&
> +		    boot_cpu_has(X86_FEATURE_OSPKE))
> +			cpuid_entry_set(entry, X86_FEATURE_PKU);
>  		break;
>  	default:
>  		break;
> @@ -7868,7 +7873,6 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  	.xsaves_supported = vmx_xsaves_supported,
>  	.umip_emulated = vmx_umip_emulated,
>  	.pt_supported = vmx_pt_supported,
> -	.pku_supported = vmx_pku_supported,
>  
>  	.request_immediate_exit = vmx_request_immediate_exit,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

