Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F898C11D32
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E17620828
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MjPCk1YE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXPPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:15:03 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:54961 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727474AbgBXPPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:15:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582557301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jg+g+BXJiV7d1uJkYnBUd3r7wI4Gy8xbFcG43fhnWLQ=;
        b=MjPCk1YENRpelnTFujXrQQP/Nxamn1m9M0G4fjI7nRPS/bC4ws3hhKAi+dY/ZMCYanLbli
        F8iLUh4ZeUY7ADqSjww1ofXfN96qVxC1WD+qnaQAJMCkxceDuGTzkGo2mfwqK+2MfmKs1z
        EDKtLsv8X2by2YFrxgTBDLn0fcsJ5+k=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-9fdQZKC1MvSxX3kTxNEq0w-1; Mon, 24 Feb 2020 10:14:59 -0500
X-MC-Unique: 9fdQZKC1MvSxX3kTxNEq0w-1
Received: by mail-wr1-f72.google.com with SMTP id s13so5712538wru.7
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:14:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=jg+g+BXJiV7d1uJkYnBUd3r7wI4Gy8xbFcG43fhnWLQ=;
        b=NIpyGE+W2wMbD1fWAZgFoOPhOSwHAw77tc7yJwX4EKKc5fahWv02ayC6QZP2EdJMd2
         1UY1HozETKDnI1myqQ3aVpgaz3T1MAFiRl9qJEW0BwHpSW62KDwq7kV+2oA+5jiDGFSy
         SZAumpbO9ha4xzw9NfOt6i+fEefQr1WTe6acr2juY77z23eOPwv0CwWvqXLxYrJjvWDq
         pTzn/0Y5pYTF8+Kxx4uU0Ql1zkoHsKUKmvd5ySx4VXxIKbSQJL60RiyRdxrb0t3ir5Bu
         aMjjzexWppoM+6KmpuvHVz7gW2X14t3WCArV93mkLbh1ZWsTSbsisBV1BuAWLAjuc8Tm
         7PHA==
X-Gm-Message-State: APjAAAXgRbqUwo/qYgI5yrihLMhMKvfbsV1TE291TttssAAOfrqdoz3S
        eYWr9K9WMAq+NLqjCNcU9HPFfPDkrzXosPbjoSe/W+DtSKAltdxbOL0QG6M/8OhMruSKrM5/Fgl
        dZxmBR4LK+PXSQxen3fx31Xrx
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr22903088wmj.150.1582557298489;
        Mon, 24 Feb 2020 07:14:58 -0800 (PST)
X-Google-Smtp-Source: APXvYqx32jEI8eqwdcHOq9gcGNlIOblbxYGYoKXK2wgkEIbGrTKfs/u12V+bccJRiGIWo+p7euzzaQ==
X-Received: by 2002:a7b:cd8e:: with SMTP id y14mr22903065wmj.150.1582557298259;
        Mon, 24 Feb 2020 07:14:58 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id y8sm18017619wma.10.2020.02.24.07.14.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:14:57 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 30/61] KVM: x86: Handle MPX CPUID adjustment in VMX code
In-Reply-To: <20200201185218.24473-31-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-31-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 16:14:56 +0100
Message-ID: <874kvgow3z.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the MPX CPUID adjustments into VMX to eliminate an instance of the
> undesirable "unsigned f_* = *_supported ? F(*) : 0" pattern in the
> common CPUID handling code.
>
> Note, VMX must manually check for kernel support via
> boot_cpu_has(X86_FEATURE_MPX).
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c   |  3 +--
>  arch/x86/kvm/vmx/vmx.c | 14 ++++++++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index cb5870a323cc..09e24d1d731c 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -340,7 +340,6 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  {
>  	unsigned f_invpcid = kvm_x86_ops->invpcid_supported() ? F(INVPCID) : 0;
> -	unsigned f_mpx = kvm_mpx_supported() ? F(MPX) : 0;
>  	unsigned f_umip = kvm_x86_ops->umip_emulated() ? F(UMIP) : 0;
>  	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>  	unsigned f_la57;
> @@ -349,7 +348,7 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  	/* cpuid 7.0.ebx */
>  	const u32 kvm_cpuid_7_0_ebx_x86_features =
>  		F(FSGSBASE) | F(BMI1) | F(HLE) | F(AVX2) | F(SMEP) |
> -		F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | f_mpx | F(RDSEED) |
> +		F(BMI2) | F(ERMS) | f_invpcid | F(RTM) | 0 /*MPX*/ | F(RDSEED) |
>  		F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
>  		F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
>  		F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3ff830e2258e..143193fc178e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7106,8 +7106,18 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
>  
>  static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
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
>  }
>  
>  static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)

The word 'must' in the description seems to work like a trigger for
reviewers, their brains automatically turn into 'and what if not?' mode
:-)

So do I understand correctly that kvm_mpx_supported() (which checks for
XFEATURE_MASK_BNDREGS/XFEATURE_MASK_BNDCSR) may actually return true
while 'boot_cpu_has(X86_FEATURE_MPX)' is false? Is this done on purpose,
i.e. why don't we filter these out from vmcs_config early, similar to
SVM?

The patch itself looks good, so
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

