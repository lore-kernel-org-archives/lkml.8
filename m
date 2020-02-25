Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32B67C35E01
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C0F21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:08:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkSEnI6C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbgBYOIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:08:54 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56456 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730656AbgBYOIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582639731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/lSNkNp1bZNFOwihFsQzXh596wRz5oBaDvQpBBfk2vI=;
        b=gkSEnI6C32B/is3lO7dg+iIcNiJGXOVIdE4lVw32ufPBkdvbfnbN0XYqj52J5BUhJkqMbQ
        3gkdz+Et+dsTXVSxuSrcUjDQW+ZoMl1LyT689EypzBjqxFxCGJYzkrJqCD17sTZ7PQHp4B
        gGXxld9TZIlydvt6COw8SCXac0wrQdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-kuxjlCaXPz2nj95-q9jeVw-1; Tue, 25 Feb 2020 09:08:49 -0500
X-MC-Unique: kuxjlCaXPz2nj95-q9jeVw-1
Received: by mail-wr1-f71.google.com with SMTP id s13so7330037wru.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:08:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/lSNkNp1bZNFOwihFsQzXh596wRz5oBaDvQpBBfk2vI=;
        b=KWmuN2CusGuCOxkC7cbYeu8LNGQMxiAlrOSS8Pfq/92ni2zwwDLLo97sfBk94ZyzJY
         3TngD+h2OUiV9nohFAlPmPstDdKTEwHmYJjxQhNdKUvUhu/Uhzxu/so7dJKf6a6XFBSM
         zVz9laswVudgt/0idXd3T4xfCVfrUeEeoxzTdOr6KMeTvYzAdWVPPMI/I8+bJuy2K0MI
         zrdM3AjiIFYX1tTcMfr1378t052zc4E2BKtYiQvvTTIqk0DLKhV/xpn1/QdrFzogTjZU
         giqRiugOf/II1HfcwQQ26Lre7A20Q/bFInIRydQan/9v4jdzto1bWIL/xv8nWBUD5qyg
         qTBg==
X-Gm-Message-State: APjAAAVD/4sT6pD2EtglYGNYK7hPqDpneh8ABv9iNelPUnk1eF00DmLW
        K6Cy/MkgknnH1ycMuwrCSLwk2RNGKQ/ColHXl4GZVdhhFDKXQPv6u+HKRxJqYM7Y0G0B0BQpdex
        uuWBsT5RMv9wPVPWEsunZvV55
X-Received: by 2002:a5d:4088:: with SMTP id o8mr23584053wrp.144.1582639728079;
        Tue, 25 Feb 2020 06:08:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqyMdmkl8+gCuselr6HXjJJMzQ+xx0En2OokGP5Smh6ixD+ug+Af3wea8+RvP+rkmkQ6jjWqJg==
X-Received: by 2002:a5d:4088:: with SMTP id o8mr23584035wrp.144.1582639727892;
        Tue, 25 Feb 2020 06:08:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a16sm24785070wrx.87.2020.02.25.06.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:08:47 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 52/61] KVM: x86: Use KVM cpu caps to detect MSR_TSC_AUX virt support
In-Reply-To: <20200201185218.24473-53-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-53-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:08:46 +0100
Message-ID: <87sgiylpxt.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Check for MSR_TSC_AUX virtualization via kvm_cpu_cap_has() and drop
> ->rdtscp_supported().
>
> Note, vmx_rdtscp_supported() needs to hang around a tiny bit longer due
> other usage in VMX code.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/svm.c              | 6 ------
>  arch/x86/kvm/vmx/vmx.c          | 3 ---
>  arch/x86/kvm/x86.c              | 2 +-
>  4 files changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 113b138a0347..1dd5ac8a2136 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1143,7 +1143,6 @@ struct kvm_x86_ops {
>  	int (*get_tdp_level)(struct kvm_vcpu *vcpu);
>  	u64 (*get_mt_mask)(struct kvm_vcpu *vcpu, gfn_t gfn, bool is_mmio);
>  	int (*get_lpage_level)(void);
> -	bool (*rdtscp_supported)(void);
>  
>  	void (*set_tdp_cr3)(struct kvm_vcpu *vcpu, unsigned long cr3);
>  
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f4434816dcdf..6dd9c810c0dc 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6074,11 +6074,6 @@ static int svm_get_lpage_level(void)
>  	return PT_PDPE_LEVEL;
>  }
>  
> -static bool svm_rdtscp_supported(void)
> -{
> -	return boot_cpu_has(X86_FEATURE_RDTSCP);
> -}
> -
>  static bool svm_pt_supported(void)
>  {
>  	return false;
> @@ -7443,7 +7438,6 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  
>  	.cpuid_update = svm_cpuid_update,
>  
> -	.rdtscp_supported = svm_rdtscp_supported,
>  	.pt_supported = svm_pt_supported,
>  
>  	.set_supported_cpuid = svm_set_supported_cpuid,
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 2a1df1b714db..c3577f11f538 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7870,9 +7870,6 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  	.get_lpage_level = vmx_get_lpage_level,
>  
>  	.cpuid_update = vmx_cpuid_update,
> -
> -	.rdtscp_supported = vmx_rdtscp_supported,
> -
>  	.set_supported_cpuid = vmx_set_supported_cpuid,
>  
>  	.has_wbinvd_exit = cpu_has_vmx_wbinvd_exit,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index a6d5f22c7ef6..e4353c03269c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5246,7 +5246,7 @@ static void kvm_init_msr_list(void)
>  				continue;
>  			break;
>  		case MSR_TSC_AUX:
> -			if (!kvm_x86_ops->rdtscp_supported())
> +			if (!kvm_cpu_cap_has(X86_FEATURE_RDTSCP))
>  				continue;
>  			break;
>  		case MSR_IA32_RTIT_CTL:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

