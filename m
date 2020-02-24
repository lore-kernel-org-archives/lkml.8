Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DBAC11D30
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6364C20838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:19:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E2bia/Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBXPT4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:19:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:27901 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727730AbgBXPTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:19:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582557594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5S2YkOJ+YGT8KtcQp0VwIkOlKilyj5rI/cUT2U2NV8=;
        b=E2bia/Jaf71Rsv5KQxpUUJ0ZhCJQos1sR5kNodkKyyCnJddKpEa/mIpYSjn+j8B5jt/Dnw
        i5rT6gZ5LEHWI6PgdinXRC/77KenHeRfmkEv07SYPR1HXRFBgv5KdMCAqAgNV9pvxFec54
        B0a0Mjs32fnmwqzcUphAVeviF05F8zc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-wpvrj15AMtasVxhDK1Eeuw-1; Mon, 24 Feb 2020 10:19:52 -0500
X-MC-Unique: wpvrj15AMtasVxhDK1Eeuw-1
Received: by mail-wr1-f69.google.com with SMTP id 90so5743385wrq.6
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:19:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=L5S2YkOJ+YGT8KtcQp0VwIkOlKilyj5rI/cUT2U2NV8=;
        b=VODxi4C4EKRzlQ57M5y1xJb3hcNWHQEKUU5S+P15K+lGRFYAAGxLHc2iR3QFUm89dn
         FcBdjB/Psyycv6T2nW5JUQ0ThwIS4nvfYrzhUHuowEmXCNFwGTWeJxWHLs5HBxRyb2Ob
         k/cVIr1Jxh10cClki0HZNU/6mU6Uc+Q0MizDh3wqI4rIB9C3ZukmbFOwfRuwGTn+jXJv
         3BDUN/i/vLVrJ7Tb/a5zkIWpgijfGK/3Cmwyg5xzKOpuaJYVezi0uu1lw4Gu1q5SzMek
         4FfTJs5WanOQTUq+aUusVYXVCGPApj8ERX+NfqxG40HydKtYVDIHmnCE8g7QBctZlYbQ
         1TgQ==
X-Gm-Message-State: APjAAAWDTDR+FulV2y0thcmcpiCG/A8ToMOi4AMuQqTG9RBV2NS+wqsk
        yqKWSNRr5ehKvLqYDc4m0/O5+4gKKC+a4E6/tfjQ8ncTujtjiV2aWe/z0k5fPmZ3Q2XaRLY2J8R
        zpopYhbWHpsddLlFBMV8PqbbP
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr22757897wmc.39.1582557591020;
        Mon, 24 Feb 2020 07:19:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqyZ0xq73pUXOC2yZODFFxqdsdkZNnMc/g/QtJ2RejQB4yqvqtClPsF80RhNK+Pnn4IaECxe5Q==
X-Received: by 2002:a1c:f21a:: with SMTP id s26mr22757869wmc.39.1582557590783;
        Mon, 24 Feb 2020 07:19:50 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s22sm17868322wmh.4.2020.02.24.07.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:19:50 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 31/61] KVM: x86: Handle INVPCID CPUID adjustment in VMX code
In-Reply-To: <20200201185218.24473-32-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-32-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 16:19:49 +0100
Message-ID: <871rqkovvu.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the INVPCID CPUID adjustments into VMX to eliminate an instance of
> the undesirable "unsigned f_* = *_supported ? F(*) : 0" pattern in the
> common CPUID handling code.  Drop ->invpcid_supported(), CPUID
> adjustment was the only user.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  1 -
>  arch/x86/kvm/cpuid.c            |  3 +--
>  arch/x86/kvm/svm.c              |  6 ------
>  arch/x86/kvm/vmx/vmx.c          | 10 +++-------
>  4 files changed, 4 insertions(+), 16 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index a61928d5435b..9baff70ad419 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1144,7 +1144,6 @@ struct kvm_x86_ops {
>  	u64 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
>  	int (*get_lpage_level)(void);
>  	bool (*rdtscp_supported)(void);
> -	bool (*invpcid_supported)(void);
>  
>  	void (*set_tdp_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
>  
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 09e24d1d731c..a5f150204d73 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -339,7 +339,6 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  
>  static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  {
> -	unsigned f_invpcid = kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
>  	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
>  	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>  	unsigned f_la57;
> @@ -348,7 +347,7 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  	/* cpuid 7.0.ebx */
>  	const u32 kvm_cpuid_7_0_ebx_x86_features =
>  		F(FSGSBASE) | F(BMI1) | F(HLE) | F(AVX2) | F(SMEP) |
> -		F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | 0 /*MPX*/ | F(RDSEED) |
> +		F(BMI2) | F(ERMS) | 0 /*INVPCID*/ | F(RTM) | 0 /*MPX*/ | F(RDSEED) |
>  		F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
>  		F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
>  		F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 7bb5d81f0f11..c0f8c09f3b04 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6074,11 +6074,6 @@ static bool svm_rdtscp_supported(void)
>  	return boot_cpu_has(X86_FEATURE_RDTSCP);
>  }
>  
> -static bool svm_invpcid_supported(void)
> -{
> -	return false;
> -}
> -
>  static bool svm_xsaves_supported(void)
>  {
>  	return boot_cpu_has(X86_FEATURE_XSAVES);
> @@ -7459,7 +7454,6 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  	.cpuid_update = svm_cpuid_update,
>  
>  	.rdtscp_supported = svm_rdtscp_supported,
> -	.invpcid_supported = svm_invpcid_supported,
>  	.xsaves_supported = svm_xsaves_supported,
>  	.umip_emulated = svm_umip_emulated,
>  	.pt_supported = svm_pt_supported,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 143193fc178e..49ee4c600934 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -1656,11 +1656,6 @@ static bool vmx_rdtscp_supported(void)
>  	return cpu_has_vmx_rdtscp();
>  }
>  
> -static bool vmx_invpcid_supported(void)
> -{
> -	return cpu_has_vmx_invpcid();
> -}
> -
>  /*
>   * Swap MSR entry in host/guest MSR entry array.
>   */
> @@ -4071,7 +4066,7 @@ static void vmx_compute_secondary_exec_control(struct vcpu_vmx *vmx)
>  		}
>  	}
>  
> -	if (vmx_invpcid_supported()) {
> +	if (cpu_has_vmx_invpcid()) {
>  		/* Exposing INVPCID only when PCID is exposed */
>  		bool invpcid_enabled =
>  			guest_cpuid_has(vcpu, X86_FEATURE_INVPCID) &&
> @@ -7114,6 +7109,8 @@ static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  	case 0x7:
>  		if (boot_cpu_has(X86_FEATURE_MPX) && kvm_mpx_supported())
>  			cpuid_entry_set(entry, X86_FEATURE_MPX);
> +		if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_has_vmx_invpcid())
> +			cpuid_entry_set(entry, X86_FEATURE_INVPCID);
>  		break;
>  	default:
>  		break;
> @@ -7854,7 +7851,6 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  	.cpuid_update = vmx_cpuid_update,
>  
>  	.rdtscp_supported = vmx_rdtscp_supported,
> -	.invpcid_supported = vmx_invpcid_supported,
>  
>  	.set_supported_cpuid = vmx_set_supported_cpuid,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

