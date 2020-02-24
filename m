Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6FDC38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADF4221556
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B6tD71Oa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBXVsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:48:06 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57811 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727421AbgBXVsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582580884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y3mparikf9DdIUeIjvvwXQ1Z1K4Cli1iz2ALnY2BpjQ=;
        b=B6tD71OayeJ+8SGSYHcZ9H3eICc8ljwbIm80SzjfWqWSg6nFhq9qnt0CcG0UsoFjeJLaGI
        2kevA5KT5+C42W3nCnZfcOFPStcd/NjBVTAt6NHTL1vIVwGMaHCzbCLqak3L61dlfdPGkR
        uK+0em3pV4MlPvi5v3+FL05Y5ckyvJc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-gusilmOBPDi1yVW9oGKMmg-1; Mon, 24 Feb 2020 16:48:02 -0500
X-MC-Unique: gusilmOBPDi1yVW9oGKMmg-1
Received: by mail-wr1-f70.google.com with SMTP id p8so6228443wrw.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:48:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=y3mparikf9DdIUeIjvvwXQ1Z1K4Cli1iz2ALnY2BpjQ=;
        b=lDqoJRDb4/rQ2K3ZJzmvK7/R1xY64mSWU52UG3DiU6iuOaO3+n256b08K4SsDUkXS3
         CxD8feJUVoi7P9d9U0uiiRCXkrAkBX13DJLEg03Iu+wWlFuYagUqkbbjheWZ5fxwGFAl
         SokSlSOLPgBtiUpvm8bALI9plmSFzxalJPaP7oBq0O2YIXMuEj99p5V5hONfQtui6ZVH
         vPJ71Po6YPY1/nNwpivFWWbt81Nv7OF/cJiM/JkaggIe7+SJ1ruOuOWjUEJ/IJtPPlCR
         qPeGLwyIW7GLqg8nkQ3iWT+8DAZsAS0270j7TP/zhXywEGeDqx34Jj/WfduLcERWJmbS
         U0Hw==
X-Gm-Message-State: APjAAAUvd25ev9i10suYp6ikYaiEgoGzPsYNsHWmBQAEJnseRl/7OEDZ
        WJUbVPzP7h4KXgqbL2zf8lxtNO63OpZWpFfrMOX2VG7dMJFiQytcymumXzjDICzxguxha+2G868
        UwTJIMJRmZvtOOjQ47YtpkMhz
X-Received: by 2002:a1c:5419:: with SMTP id i25mr1036345wmb.150.1582580880344;
        Mon, 24 Feb 2020 13:48:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqxcGJyPEiNp1nOJTpE1947zCHRS0Mdf/QuU39ULake55oSamxvw9KPNbmzyW5qp2oa0/4ydHA==
X-Received: by 2002:a1c:5419:: with SMTP id i25mr1036324wmb.150.1582580880079;
        Mon, 24 Feb 2020 13:48:00 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id z21sm1026315wml.5.2020.02.24.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:47:59 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 42/61] KVM: x86: Add a helper to check kernel support when setting cpu cap
In-Reply-To: <20200201185218.24473-43-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-43-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 22:47:58 +0100
Message-ID: <875zfvodwx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Add a helper, kvm_cpu_cap_check_and_set(), to query boot_cpu_has() as
> part of setting a KVM cpu capability.  VMX in particular has a number of
> features that are dependent on both a VMCS capability and kernel
> support.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.h   |  6 ++++++
>  arch/x86/kvm/svm.c     |  3 +--
>  arch/x86/kvm/vmx/vmx.c | 18 ++++++++----------
>  3 files changed, 15 insertions(+), 12 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
> index c64283582d96..7b71ae0ca05e 100644
> --- a/arch/x86/kvm/cpuid.h
> +++ b/arch/x86/kvm/cpuid.h
> @@ -274,4 +274,10 @@ static __always_inline void kvm_cpu_cap_set(unsigned x86_feature)
>  	kvm_cpu_caps[x86_leaf] |= __feature_bit(x86_feature);
>  }
>  
> +static __always_inline void kvm_cpu_cap_check_and_set(unsigned x86_feature)
> +{
> +	if (boot_cpu_has(x86_feature))
> +		kvm_cpu_cap_set(x86_feature);
> +}
> +
>  #endif
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 7cb05945162e..defb2c0dbf8a 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1362,8 +1362,7 @@ static __init void svm_set_cpu_caps(void)
>  
>  	/* CPUID 0x8000000A */
>  	/* Support next_rip if host supports it */
> -	if (boot_cpu_has(X86_FEATURE_NRIPS))
> -		kvm_cpu_cap_set(X86_FEATURE_NRIPS);
> +	kvm_cpu_cap_check_and_set(X86_FEATURE_NRIPS);
>  
>  	if (npt_enabled)
>  		kvm_cpu_cap_set(X86_FEATURE_NPT);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index cfd0ef314176..cecf59225136 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7118,18 +7118,16 @@ static __init void vmx_set_cpu_caps(void)
>  		kvm_cpu_cap_set(X86_FEATURE_VMX);
>  
>  	/* CPUID 0x7 */
> -	if (boot_cpu_has(X86_FEATURE_MPX) && kvm_mpx_supported())
> -		kvm_cpu_cap_set(X86_FEATURE_MPX);
> -	if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_has_vmx_invpcid())
> -		kvm_cpu_cap_set(X86_FEATURE_INVPCID);
> -	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
> -	    vmx_pt_mode_is_host_guest())
> -		kvm_cpu_cap_set(X86_FEATURE_INTEL_PT);
> +	if (kvm_mpx_supported())
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_MPX);
> +	if (cpu_has_vmx_invpcid())
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_INVPCID);
> +	if (vmx_pt_mode_is_host_guest())
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_INTEL_PT);
>  
>  	/* PKU is not yet implemented for shadow paging. */
> -	if (enable_ept && boot_cpu_has(X86_FEATURE_PKU) &&
> -	    boot_cpu_has(X86_FEATURE_OSPKE))
> -		kvm_cpu_cap_set(X86_FEATURE_PKU);
> +	if (enable_ept && boot_cpu_has(X86_FEATURE_OSPKE))
> +		kvm_cpu_cap_check_and_set(X86_FEATURE_PKU);
>  
>  	/* CPUID 0xD.1 */
>  	if (!vmx_xsaves_supported())

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

