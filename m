Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HK_RANDOM_FROM,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C3BC3B189
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C21218AC
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 13:51:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbgBMNvM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 08:51:12 -0500
Received: from mga01.intel.com ([192.55.52.88]:59554 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730003AbgBMNvM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 08:51:12 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Feb 2020 05:51:12 -0800
X-IronPort-AV: E=Sophos;i="5.70,436,1574150400"; 
   d="scan'208";a="227235705"
Received: from xiaoyaol-mobl.ccr.corp.intel.com (HELO [10.255.30.123]) ([10.255.30.123])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Feb 2020 05:51:10 -0800
Subject: Re: [PATCH 30/61] KVM: x86: Handle MPX CPUID adjustment in VMX code
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200201185218.24473-1-sean.j.christopherson@intel.com>
 <20200201185218.24473-31-sean.j.christopherson@intel.com>
From:   Xiaoyao Li <xiaoyao.li@intel.com>
Message-ID: <4ff69a7e-acdb-40fd-d717-3b2829f20154@intel.com>
Date:   Thu, 13 Feb 2020 21:51:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200201185218.24473-31-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/2/2020 2:51 AM, Sean Christopherson wrote:
> Move the MPX CPUID adjustments into VMX to eliminate an instance of the
> undesirable "unsigned f_* = *_supported ? F(*) : 0" pattern in the
> common CPUID handling code.
> 
> Note, VMX must manually check for kernel support via
> boot_cpu_has(X86_FEATURE_MPX).

Why must?

> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>   arch/x86/kvm/cpuid.c   |  3 +--
>   arch/x86/kvm/vmx/vmx.c | 14 ++++++++++++--
>   2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index cb5870a323cc..09e24d1d731c 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -340,7 +340,6 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>   static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>   {
>   	unsigned f_invpcid = kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
> -	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
>   	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
>   	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>   	unsigned f_la57;
> @@ -349,7 +348,7 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>   	/* cpuid 7.0.ebx */
>   	const u32 kvm_cpuid_7_0_ebx_x86_features =
>   		F(FSGSBASE) | F(BMI1) | F(HLE) | F(AVX2) | F(SMEP) |
> -		F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | f_mpx | F(RDSEED) |
> +		F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | 0 /*MPX*/ | F(RDSEED) |
>   		F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
>   		F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
>   		F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3ff830e2258e..143193fc178e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7106,8 +7106,18 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
>   
>   static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>   {
> -	if (entry->function == 1 && nested)
> -		entry->ecx |= feature_bit(VMX);
> +	switch (entry->function) {
> +	case 0x1:
> +		if (nested)
> +			cpuid_entry_set(entry, X86_FEATURE_VMX);
> +		break;
> +	case 0x7:
> +		if (boot_cpu_has(X86_FEATURE_MPX) && kvm_mpx_supported())
> +			cpuid_entry_set(entry, X86_FEATURE_MPX);
> +		break;
> +	default:
> +		break;
> +	}
>   }
>   
>   static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
> 

