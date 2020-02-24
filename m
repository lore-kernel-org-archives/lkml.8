Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D2CC35671
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC26B2080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 13:49:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GKohwu+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgBXNtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 08:49:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:58399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727160AbgBXNtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 08:49:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582552177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tAQyvgVC9umTI3C0mE/08IO0Mq8UDdBPvvOVcWUX2u0=;
        b=GKohwu+ZwHce2xVgsnBKrRTdlLt77EghCyVdljb+KWvS4/bNq83FOlmbkUyGWDdZIwD+Ye
        A9l5HGpOgoDwAj8xNtT7120KTbWiSvSvYELuJR95MqF0NbeA57V9+HOBKfbur5AQMSWu3s
        B0B3YSoPBxEBs+ai1IFiXbyrH2WR8to=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-YctGikqoPl2t24QX7pcTTg-1; Mon, 24 Feb 2020 08:49:36 -0500
X-MC-Unique: YctGikqoPl2t24QX7pcTTg-1
Received: by mail-wm1-f71.google.com with SMTP id p2so2393541wmi.8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 05:49:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=tAQyvgVC9umTI3C0mE/08IO0Mq8UDdBPvvOVcWUX2u0=;
        b=eVaAqVgMQbaeT1fJQIu4U7Kup+q1mwz5HtJd5hVu8/SJTs24P1H70e5XBJOdN9HI3z
         y9RoatWQ9M7MJjRq5lLludDt8bGUdn1CMbgEL307Cex77t89zQ4K7DKivzyCKF63h+qW
         HxPUgNdqxpTiiKIgXu6kNQQRBeIvdRGMKg46AzU52+GSRiK2DpmnUc4Lbh8zbVi09YIk
         IsNP+N7fXptbIjXqZLhFIycYhXLAI+5XLcwUUf4+2Hf30q8gdMZk3L6drakJi7soTbPz
         5kIfhfuwPYKZb7rGE4bjjVJQPJlI6aZ2Oe6QeOl5JPoJj2U9H6glrmPZZ4sjf1Pv/E6p
         c2FQ==
X-Gm-Message-State: APjAAAVg2RQd3Il/ea8R88Z+1w7iyGqvwlP4t5hVsZSYeDk/mW1+QDon
        k9U3GdfWgLZqXpdlsAgVHh7Z/Q7+3ww5QHZXCwPRDL61CYNjxMKt0XdTCnZHZTWpAxDYFEf4C0g
        aWrOFVx2TCRNiwYyA6cq5QjSw
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr67336211wrq.155.1582552175129;
        Mon, 24 Feb 2020 05:49:35 -0800 (PST)
X-Google-Smtp-Source: APXvYqxdBw9gt33lYnR/XKzr9wDVBrAP8s0iq8iWevpyYhiw+9MMonU5wAHsUexqdA1oN+hOyWiseQ==
X-Received: by 2002:a5d:4a06:: with SMTP id m6mr67336184wrq.155.1582552174866;
        Mon, 24 Feb 2020 05:49:34 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t128sm19156199wmf.28.2020.02.24.05.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 05:49:34 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 28/61] KVM: x86: Refactor cpuid_mask() to auto-retrieve the register
In-Reply-To: <20200201185218.24473-29-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-29-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 14:49:33 +0100
Message-ID: <87d0a4p02a.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use the recently introduced cpuid_entry_get_reg() to automatically get
> the appropriate register when masking a CPUID entry.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 28 +++++++++++++++-------------
>  1 file changed, 15 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 195f4dcc8c6a..cb5870a323cc 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -254,10 +254,12 @@ int kvm_vcpu_ioctl_get_cpuid2(struct kvm_vcpu *vcpu,
>  	return r;
>  }
>  
> -static __always_inline void cpuid_mask(u32 *word, int wordnum)
> +static __always_inline void cpuid_entry_mask(struct kvm_cpuid_entry2 *entry,
> +					     enum cpuid_leafs leaf)
>  {
> -	reverse_cpuid_check(wordnum);
> -	*word &= boot_cpu_data.x86_capability[wordnum];
> +	u32 *reg = cpuid_entry_get_reg(entry, leaf * 32);
> +
> +	*reg &= boot_cpu_data.x86_capability[leaf];
>  }
>  
>  struct kvm_cpuid_array {
> @@ -373,13 +375,13 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  	case 0:
>  		entry->eax = min(entry->eax, 1u);
>  		entry->ebx &= kvm_cpuid_7_0_ebx_x86_features;
> -		cpuid_mask(&entry->ebx, CPUID_7_0_EBX);
> +		cpuid_entry_mask(entry, CPUID_7_0_EBX);
>  		/* TSC_ADJUST is emulated */
>  		cpuid_entry_set(entry, X86_FEATURE_TSC_ADJUST);
>  
>  		entry->ecx &= kvm_cpuid_7_0_ecx_x86_features;
>  		f_la57 = cpuid_entry_get(entry, X86_FEATURE_LA57);
> -		cpuid_mask(&entry->ecx, CPUID_7_ECX);
> +		cpuid_entry_mask(entry, CPUID_7_ECX);
>  		/* Set LA57 based on hardware capability. */
>  		entry->ecx |= f_la57;
>  		entry->ecx |= f_umip;
> @@ -389,7 +391,7 @@ static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
>  			cpuid_entry_clear(entry, X86_FEATURE_PKU);
>  
>  		entry->edx &= kvm_cpuid_7_0_edx_x86_features;
> -		cpuid_mask(&entry->edx, CPUID_7_EDX);
> +		cpuid_entry_mask(entry, CPUID_7_EDX);
>  		if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IBRS))
>  			cpuid_entry_set(entry, X86_FEATURE_SPEC_CTRL);
>  		if (boot_cpu_has(X86_FEATURE_STIBP))
> @@ -507,9 +509,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	case 1:
>  		entry->edx &= kvm_cpuid_1_edx_x86_features;
> -		cpuid_mask(&entry->edx, CPUID_1_EDX);
> +		cpuid_entry_mask(entry, CPUID_1_EDX);
>  		entry->ecx &= kvm_cpuid_1_ecx_x86_features;
> -		cpuid_mask(&entry->ecx, CPUID_1_ECX);
> +		cpuid_entry_mask(entry, CPUID_1_ECX);
>  		/* we support x2apic emulation even if host does not support
>  		 * it since we emulate x2apic in software */
>  		cpuid_entry_set(entry, X86_FEATURE_X2APIC);
> @@ -619,7 +621,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  			goto out;
>  
>  		entry->eax &= kvm_cpuid_D_1_eax_x86_features;
> -		cpuid_mask(&entry->eax, CPUID_D_1_EAX);
> +		cpuid_entry_mask(entry, CPUID_D_1_EAX);
>  		if (entry->eax & (F(XSAVES)|F(XSAVEC)))
>  			entry->ebx = xstate_required_size(supported_xcr0, true);
>  		else
> @@ -699,9 +701,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	case 0x80000001:
>  		entry->edx &= kvm_cpuid_8000_0001_edx_x86_features;
> -		cpuid_mask(&entry->edx, CPUID_8000_0001_EDX);
> +		cpuid_entry_mask(entry, CPUID_8000_0001_EDX);
>  		entry->ecx &= kvm_cpuid_8000_0001_ecx_x86_features;
> -		cpuid_mask(&entry->ecx, CPUID_8000_0001_ECX);
> +		cpuid_entry_mask(entry, CPUID_8000_0001_ECX);
>  		break;
>  	case 0x80000007: /* Advanced power management */
>  		/* invariant TSC is CPUID.80000007H:EDX[8] */
> @@ -720,7 +722,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		entry->eax = g_phys_as | (virt_as << 8);
>  		entry->edx = 0;
>  		entry->ebx &= kvm_cpuid_8000_0008_ebx_x86_features;
> -		cpuid_mask(&entry->ebx, CPUID_8000_0008_EBX);
> +		cpuid_entry_mask(entry, CPUID_8000_0008_EBX);
>  		/*
>  		 * AMD has separate bits for each SPEC_CTRL bit.
>  		 * arch/x86/kernel/cpu/bugs.c is kind enough to
> @@ -763,7 +765,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	case 0xC0000001:
>  		entry->edx &= kvm_cpuid_C000_0001_edx_x86_features;
> -		cpuid_mask(&entry->edx, CPUID_C000_0001_EDX);
> +		cpuid_entry_mask(entry, CPUID_C000_0001_EDX);
>  		break;
>  	case 3: /* Processor serial number */
>  	case 5: /* MONITOR/MWAIT */


Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

