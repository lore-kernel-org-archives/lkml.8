Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDF1C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE7F42176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bf95SKPL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728079AbgBXVdn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:33:43 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:41546 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgBXVdn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:33:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582580020;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c8+XmMTcQu9NRSgMktjQy1xQLejdPrZ1ttEMyUDWp7M=;
        b=bf95SKPLTUleHCRsO6cY9yIz8Uzdmlj1D4UeFrVCNeLWCrnZzwXGWqVgXyzbl7S+WLvoo9
        OPIWOwI/Tbr3QSnquARhKKKFCZu1/c5YliVJCUmgnaOYURwrgkf/Dg1jt1QPMXWOMS0LPj
        3PNomdqvzhmW01vkuzbBfSCf99zHEGA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-104-3yyvE0AxOyeOMTQ4xOdCYA-1; Mon, 24 Feb 2020 16:33:38 -0500
X-MC-Unique: 3yyvE0AxOyeOMTQ4xOdCYA-1
Received: by mail-wr1-f70.google.com with SMTP id t6so6235348wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:33:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=c8+XmMTcQu9NRSgMktjQy1xQLejdPrZ1ttEMyUDWp7M=;
        b=DeNxxPa4Tak2rFv/R8ULQmdHwamhfPqYydyrGq7g+wABBI9G+L03XwxmKnwchp1iGY
         cmCA/7h1D7L4JXW/ju6HNYesW3F7ArCs4fNBJvv+XUpe/g14CqOsOnYB5ULl5xvW/t8u
         dDOd8J8Yx4stbQsqnvJg526M1y06exWrcdC06f7EPNNVK7RXbsubI3iLWCM3O4peQs3q
         hhxQW0XBJQkTnoqIF47LIzy1+FUMfeF1NP3mxAf9xuFDA97cJ1AYcZzqeWvAjPbLYNrc
         neX3rz8m6u7bELDHHmz76QZVZrLjSmCAQ9bt3BxKdTliLKisfex1PGogIEXWokq4aSyj
         2B0g==
X-Gm-Message-State: APjAAAV8Ev7i7MOgkInJKdFv/MAtHaBhjnd6BO/879LPIiSYooHuT3+D
        OSIgfIAdZejFUcnZqHgKA3MzC6CxqeMM7ald5c5FU7JiBV2aYRZ437djWbbTBoVfqjennblhsG8
        R3RptODsfGs7cxxo48MBrGo3A
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr963813wmr.72.1582580016825;
        Mon, 24 Feb 2020 13:33:36 -0800 (PST)
X-Google-Smtp-Source: APXvYqwhJwlnq6aBlscqWEwyDJc0FvxuLMx0zkO0HNxZHKJdkV1VLwBYu8uFo3PsO3iYz3LrtvhQ6Q==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr963789wmr.72.1582580016516;
        Mon, 24 Feb 2020 13:33:36 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y8sm1002966wma.10.2020.02.24.13.33.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:33:35 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 39/61] KVM: SVM: Convert feature updates from CPUID to KVM cpu caps
In-Reply-To: <20200201185218.24473-40-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-40-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 22:33:34 +0100
Message-ID: <87eeujoekx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use the recently introduced KVM CPU caps to propagate SVM-only (kernel)
> settings to supported CPUID flags.
>
> Note, setting a flag based on a *different* feature is effectively
> emulation, and so must be done at runtime via ->set_supported_cpuid().
>
> Opportunistically add a technically unnecessary break and fix an
> indentation issue in svm_set_supported_cpuid().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm.c | 40 +++++++++++++++++++++++-----------------
>  1 file changed, 23 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 630520f8adfa..f98a192459f7 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1350,6 +1350,25 @@ static __init void svm_adjust_mmio_mask(void)
>  	kvm_mmu_set_mmio_spte_mask(mask, mask, PT_WRITABLE_MASK | PT_USER_MASK);
>  }
>  

Can we probably add the comment about what can be done here and what
needs to go to svm_set_supported_cpuid()? (The one about 'emulation'
from your commit message would do).

> +static __init void svm_set_cpu_caps(void)
> +{
> +	/* CPUID 0x1 */
> +	if (avic)
> +		kvm_cpu_cap_clear(X86_FEATURE_X2APIC);
> +
> +	/* CPUID 0x80000001 */
> +	if (nested)
> +		kvm_cpu_cap_set(X86_FEATURE_SVM);
> +
> +	/* CPUID 0x8000000A */
> +	/* Support next_rip if host supports it */
> +	if (boot_cpu_has(X86_FEATURE_NRIPS))
> +		kvm_cpu_cap_set(X86_FEATURE_NRIPS);

Unrelated to your patch but the way we handle 'nrips' is a bit weird: we
can disable it with 'nrips' module parameter but L1 hypervisor will get
it unconditionally.

Also, what about all the rest of 0x8000000A.EDX features? Nested SVM
would appreciate some love... 

> +
> +	if (npt_enabled)
> +		kvm_cpu_cap_set(X86_FEATURE_NPT);
> +}
> +
>  static __init int svm_hardware_setup(void)
>  {
>  	int cpu;
> @@ -1462,6 +1481,8 @@ static __init int svm_hardware_setup(void)
>  			pr_info("Virtual GIF supported\n");
>  	}
>  
> +	svm_set_cpu_caps();
> +
>  	return 0;
>  
>  err:
> @@ -6033,17 +6054,9 @@ static void svm_cpuid_update(struct kvm_vcpu *vcpu)
>  static void svm_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
>  	switch (entry->function) {
> -	case 0x1:
> -		if (avic)
> -			cpuid_entry_clear(entry, X86_FEATURE_X2APIC);
> -		break;
> -	case 0x80000001:
> -		if (nested)
> -			cpuid_entry_set(entry, X86_FEATURE_SVM);
> -		break;
>  	case 0x80000008:
>  		if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
> -		     boot_cpu_has(X86_FEATURE_AMD_SSBD))
> +		    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  			cpuid_entry_set(entry, X86_FEATURE_VIRT_SSBD);
>  		break;
>  	case 0x8000000A:
> @@ -6053,14 +6066,7 @@ static void svm_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  		entry->ecx = 0; /* Reserved */
>  		entry->edx = 0; /* Per default do not support any
>  				   additional features */
> -
> -		/* Support next_rip if host supports it */
> -		if (boot_cpu_has(X86_FEATURE_NRIPS))
> -			cpuid_entry_set(entry, X86_FEATURE_NRIPS);
> -
> -		/* Support NPT for the guest if enabled */
> -		if (npt_enabled)
> -			cpuid_entry_set(entry, X86_FEATURE_NPT);
> +		break;
>  	}
>  }

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

