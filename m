Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83410C11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3415B20714
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AT1QpX6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgBXPaW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:30:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38869 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727299AbgBXPaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:30:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582558221;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JJxxV23y9pJ+tpbvjLr3aBKJpCVHhxptFUa2Hc5Byr4=;
        b=AT1QpX6jM6ptCfTpbXqny9orEBrDaXUVRc7Tz61r6VvY4MLx9Gw2byhrvjeRNvr3gg7Iw7
        vkdGeDbR0zuVws5WYTyjQM1Fixx0ABOXtU740F6CayckER+VkWGFmYS5FBF1isjCZQFZCd
        Ez+pZCdeW2F02oWybIPogTXYQqNHxiU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-DdLg1N_4NcqBONLmIG6vHA-1; Mon, 24 Feb 2020 10:30:20 -0500
X-MC-Unique: DdLg1N_4NcqBONLmIG6vHA-1
Received: by mail-wr1-f71.google.com with SMTP id r1so5741796wrc.15
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:30:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=JJxxV23y9pJ+tpbvjLr3aBKJpCVHhxptFUa2Hc5Byr4=;
        b=nwygui9t9PbC9ENpqk6DBBrFKg3irMZ9rsOz/gVBxHjcaJ2xoCskkkEaEjzkG52/go
         Ivef3OOeby1TaSTcTT/Nrj9A4L6LAgnZ26OnPxy+QZy2Ju+B6bZK5oLt06BOxvGdvwm0
         F1ydLsKnbvTs75en5vbtGK8zjaej12HB+XluXZLrMMLt2+sXY699SgTxn0Jr+Yiye8vG
         wNVMzZaS/n9Si4vk+mjA8wtTJ1TJ06KPi0qxJ1dhVugd/9oaKk1iCOpraWjA9wNt5OrY
         B/xjxXVGq9Em6c3qJRo5FJw6PO0NbH1lL8EWp9XmipkXkYAC5P2qN0Tnve99XxTAWSjF
         4cPQ==
X-Gm-Message-State: APjAAAWSHGGxXNeEL7h8HSb25Fmptgjtzog40jodyZ/TOA2bs+yE980n
        Ng3tR4TnbxpAKhNh/wZ6ASrY4tb3V4PqmB85dgZexpdGZ4KOhCqtZpEFNW+qjt4t/tgImgwogWF
        A8WOZSkr8/7OipVisyyB4uH+m
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr23222325wmf.102.1582558218617;
        Mon, 24 Feb 2020 07:30:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXgTuxN3VNwlc48sTT8mfJxtoLJXm/GGABS4BXENrEAzTdbXUUhOHB6SRegFaiOCID0zHO7g==
X-Received: by 2002:a1c:bdc6:: with SMTP id n189mr23222301wmf.102.1582558218400;
        Mon, 24 Feb 2020 07:30:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id d9sm19458030wrx.94.2020.02.24.07.30.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:30:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 35/61] KVM: x86: Handle Intel PT CPUID adjustment in VMX code
In-Reply-To: <20200201185218.24473-36-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-36-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 16:30:17 +0100
Message-ID: <87pne4ngty.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the Processor Trace CPUID adjustment into VMX code to eliminate
> an instance of the undesirable "unsigned f_* = *_supported ? F(*) : 0"
> pattern in the common CPUID handling code, and to pave the way toward
> eventually removing ->pt_supported().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c   | 3 +--
>  arch/x86/kvm/vmx/vmx.c | 3 +++
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fc507270f3f3..f4a3655451dd 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -339,7 +339,6 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  
>  static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  {
> -	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>  	unsigned f_la57;
>  
>  	/* cpuid 7.0.ebx */
> @@ -348,7 +347,7 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  		F(BMI2) | F(ERMS) | 0 /*INVPCID*/ | F(RTM) | 0 /*MPX*/ | F(RDSEED) |
>  		F(ADX) | F(SMAP) | F(AVX512IFMA) | F(AVX512F) | F(AVX512PF) |
>  		F(AVX512ER) | F(AVX512CD) | F(CLFLUSHOPT) | F(CLWB) | F(AVX512DQ) |
> -		F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | f_intel_pt;
> +		F(SHA_NI) | F(AVX512BW) | F(AVX512VL) | 0 /*INTEL_PT*/;
>  
>  	/* cpuid 7.0.ecx*/
>  	const u32 kvm_cpuid_7_0_ecx_x86_features =
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3990ba691d07..fcec3d8a0176 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7111,6 +7111,9 @@ static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  			cpuid_entry_set(entry, X86_FEATURE_MPX);
>  		if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_has_vmx_invpcid())
>  			cpuid_entry_set(entry, X86_FEATURE_INVPCID);
> +		if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
> +		    vmx_pt_mode_is_host_guest())
> +			cpuid_entry_set(entry, X86_FEATURE_INTEL_PT);
>  		if (vmx_umip_emulated())
>  			cpuid_entry_set(entry, X86_FEATURE_UMIP);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

