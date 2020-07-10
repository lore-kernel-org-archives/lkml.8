Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6FEC433EA
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1C50207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 16:53:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XAF+95OK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728717AbgGJQxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 12:53:47 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50348 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728642AbgGJQxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 12:53:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594400024;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mTbg3U6lOAL1frqXN6ZgumAR5RgCm4pmbTt3ifAZ6gA=;
        b=XAF+95OKFYaQJ60gh4u3qd6ZzlY/SEh6Q+zOpOK9f1YxbGJAo6KxXtaKAUCezfXaA0+rmP
        ieKGnLehHr1RSnYiN3cb9TELEHBO0dtBG1MqXDnZWbk00QeYzeL38mTN7Cb14UTdSx7Te/
        S0vGWUoXf3qbhrAbAsyZAY1mZmOyJU0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-253-YBAPrLh5OyaElknhrzVdIQ-1; Fri, 10 Jul 2020 12:53:40 -0400
X-MC-Unique: YBAPrLh5OyaElknhrzVdIQ-1
Received: by mail-wr1-f69.google.com with SMTP id b8so6576774wro.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 09:53:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTbg3U6lOAL1frqXN6ZgumAR5RgCm4pmbTt3ifAZ6gA=;
        b=TnBfJMnczi45hTr5Aqy8q5lhO9Bg3aPZhavtqFHbMLudZ6owbrPeT7U7fB17iDPLX2
         0TP4S5gCuIr+2kdUGTkgJEHpbGf8XsZcMenuOfSqGsz+fBNWvQGfNQNKFEbttxkyE8Vn
         MvG74Qfc6Bu1Yh7TN5DvaulKWWpF5AePIz2898tGr8RriFnISaPC5zrSS9F4uZwnNfZq
         6OX4Pxf0rbjvQuR8Hef+15BNEWQrS7HCVUsuXC9nH5Y8D/Vr6MGb2bhETrspHSAU3aj0
         M72SLlN4zOyvrzbetHbwgxrcOfGco56vAfyna7bA6jDW/DR1nlNrF1+KUxeaWOYU4Fwa
         5t2w==
X-Gm-Message-State: AOAM532lTNCzQdiLYL+9Jq6QADmn9m43gffidk33bF4pTK++1LYasrzd
        M+cBC4HNFi2XgozFVjr74B8KhFLCT4/LiL+wJOV8aSPRLxryc/114sQp3h3GIVj2QgHyC/+qxLD
        tCrMs66TW/DAIcKJanKRuO/8l
X-Received: by 2002:a7b:c775:: with SMTP id x21mr6168370wmk.34.1594400019664;
        Fri, 10 Jul 2020 09:53:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyr41yxVE/py/FXZd3TzKsnMsxa9t0Mud+LeC+plAYWiHrPHKpZInuTdfVRgC6MzJmcoOlkdw==
X-Received: by 2002:a7b:c775:: with SMTP id x21mr6168360wmk.34.1594400019427;
        Fri, 10 Jul 2020 09:53:39 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id u17sm10389648wrp.70.2020.07.10.09.53.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 09:53:38 -0700 (PDT)
Subject: Re: [PATCH v3] KVM: x86: move MSR_IA32_PERF_CAPABILITIES emulation to
 common x86 code
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Like Xu <like.xu@linux.intel.com>, linux-kernel@vger.kernel.org
References: <20200710152559.1645827-1-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3c58c709-eb63-2abb-8191-064164271f9f@redhat.com>
Date:   Fri, 10 Jul 2020 18:53:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200710152559.1645827-1-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/20 17:25, Vitaly Kuznetsov wrote:
> state_test/smm_test selftests are failing on AMD with:
> "Unexpected result from KVM_GET_MSRS, r: 51 (failed MSR was 0x345)"
> 
> MSR_IA32_PERF_CAPABILITIES is an emulated MSR on Intel but it is not
> known to AMD code, we can move the emulation to common x86 code. For
> AMD, we basically just allow the host to read and write zero to the MSR.
> 
> Fixes: 27461da31089 ("KVM: x86/pmu: Support full width counting")
> Suggested-by: Jim Mattson <jmattson@google.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
> - This is a succesor of "[PATCH v2] KVM: SVM: emulate MSR_IA32_PERF_CAPABILITIES".
> ---
>  arch/x86/kvm/svm/svm.c       |  2 ++
>  arch/x86/kvm/vmx/pmu_intel.c | 17 -----------------
>  arch/x86/kvm/x86.c           | 20 ++++++++++++++++++++
>  3 files changed, 22 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> index c0da4dd78ac5..1b68cc6cd756 100644
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -2358,6 +2358,8 @@ static int svm_get_msr_feature(struct kvm_msr_entry *msr)
>  		if (boot_cpu_has(X86_FEATURE_LFENCE_RDTSC))
>  			msr->data |= MSR_F10H_DECFG_LFENCE_SERIALIZE;
>  		break;
> +	case MSR_IA32_PERF_CAPABILITIES:
> +		return 0;
>  	default:
>  		return 1;
>  	}
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index bdcce65c7a1d..a886a47daebd 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -180,9 +180,6 @@ static bool intel_is_valid_msr(struct kvm_vcpu *vcpu, u32 msr)
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  		ret = pmu->version > 1;
>  		break;
> -	case MSR_IA32_PERF_CAPABILITIES:
> -		ret = 1;
> -		break;
>  	default:
>  		ret = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0) ||
>  			get_gp_pmc(pmu, msr, MSR_P6_EVNTSEL0) ||
> @@ -224,12 +221,6 @@ static int intel_pmu_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  	case MSR_CORE_PERF_GLOBAL_OVF_CTRL:
>  		msr_info->data = pmu->global_ovf_ctrl;
>  		return 0;
> -	case MSR_IA32_PERF_CAPABILITIES:
> -		if (!msr_info->host_initiated &&
> -		    !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
> -			return 1;
> -		msr_info->data = vcpu->arch.perf_capabilities;
> -		return 0;
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>  		    (pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
> @@ -289,14 +280,6 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 0;
>  		}
>  		break;
> -	case MSR_IA32_PERF_CAPABILITIES:
> -		if (!msr_info->host_initiated)
> -			return 1;
> -		if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM) ?
> -			(data & ~vmx_get_perf_capabilities()) : data)
> -			return 1;
> -		vcpu->arch.perf_capabilities = data;
> -		return 0;
>  	default:
>  		if ((pmc = get_gp_pmc(pmu, msr, MSR_IA32_PERFCTR0)) ||
>  		    (pmc = get_gp_pmc(pmu, msr, MSR_IA32_PMC0))) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 3b92db412335..a08bd66cd662 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2817,6 +2817,20 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 1;
>  		vcpu->arch.arch_capabilities = data;
>  		break;
> +	case MSR_IA32_PERF_CAPABILITIES: {
> +		struct kvm_msr_entry msr_ent = {.index = msr, .data = 0};
> +
> +		if (!msr_info->host_initiated)
> +			return 1;
> +		if (guest_cpuid_has(vcpu, X86_FEATURE_PDCM) && kvm_get_msr_feature(&msr_ent))
> +			return 1;
> +		if (data & ~msr_ent.data)
> +			return 1;
> +
> +		vcpu->arch.perf_capabilities = data;
> +
> +		return 0;
> +		}
>  	case MSR_EFER:
>  		return set_efer(vcpu, msr_info);
>  	case MSR_K7_HWCR:
> @@ -3167,6 +3181,12 @@ int kvm_get_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  			return 1;
>  		msr_info->data = vcpu->arch.arch_capabilities;
>  		break;
> +	case MSR_IA32_PERF_CAPABILITIES:
> +		if (!msr_info->host_initiated &&
> +		    !guest_cpuid_has(vcpu, X86_FEATURE_PDCM))
> +			return 1;
> +		msr_info->data = vcpu->arch.perf_capabilities;
> +		break;
>  	case MSR_IA32_POWER_CTL:
>  		msr_info->data = vcpu->arch.msr_ia32_power_ctl;
>  		break;
> 

Queued, thanks.

Paolo

