Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5053C38BF9
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77B452176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 22:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TI4kigIR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgBXWVz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 17:21:55 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58045 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726687AbgBXWVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 17:21:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582582913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MlgLBPA54fWuuAEYeFoGWhJfgNH9YMvWTW66al92frM=;
        b=TI4kigIRN0rrL2w9tuK8x0JjwZgh4OVns11CTARDvOzghFEMGuItLtLQijrNFlnCHZVnZg
        oUgfxG9QwSNc0bwunRsDOmiv1+NqEOmZYUwvAfw3ymbSPZBdPYzirHFvPtO1PhRwmTBqM7
        /avtTPQJuqQZ9U8kDxJzXq6iI+/6HWQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-407-ZOGpzucaNq28w5mdfVtyKg-1; Mon, 24 Feb 2020 17:21:50 -0500
X-MC-Unique: ZOGpzucaNq28w5mdfVtyKg-1
Received: by mail-wr1-f72.google.com with SMTP id d9so3055788wrv.21
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 14:21:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=MlgLBPA54fWuuAEYeFoGWhJfgNH9YMvWTW66al92frM=;
        b=cg85wTCY6z251BeEMSJT+OM4dTaRA5DDBvLsxQpyPbOp+6l0RIBiExvHl/YdZY6RD/
         mcpu/DDwuDb/G80+ww5LNMnG1Vo2Y3hX8NebvTEmuj1So/L/4v/gjaIh6dvnoSeDyvuP
         UYl6FK3FmDgkoZx8S4cFSB5ZuqUbAHb8jS3ts8Gf/lOY5FsRgDeoRh2jPGH6zSB7qPqP
         ye6y1AZsKRZhu8JrnGa+6pILkFvCwt95SOV7nwxQ2z6acgtmVqaI07UwNyQrLvldC8/z
         qvsuSj3Kb12u1eSEaf+KjzwzvDdegNp7RqTVZU1hlrLXFfLj4SIUXRKdfsxQhXLztMAA
         hjtw==
X-Gm-Message-State: APjAAAWDc4KExoOgVoYIwwXBgYeGoNUIZGyHuERvrpzHFScCFTrDgjL+
        x4U7L3LKCJdEGe7VzWlgnbG/ugbvXS6OGZ0KWNzElzDPPm001zaFlbNJMfLV8bP3q0Cb4v/HW2k
        jm6KuW2tJOptKYrT1u93Kt/Ic
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr12087167wrw.287.1582582909001;
        Mon, 24 Feb 2020 14:21:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqwv1OrYJptTCi459Nv4K1OBAqX8b1+jzsWwgqC+Y0BdxTs1+Ttq2a4ssxOPNtqrc/4OGz6Qyg==
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr12087142wrw.287.1582582908750;
        Mon, 24 Feb 2020 14:21:48 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id p15sm1067820wma.40.2020.02.24.14.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 14:21:48 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 45/61] KVM: x86: Fold CPUID 0x7 masking back into __do_cpuid_func()
In-Reply-To: <20200201185218.24473-46-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-46-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 23:21:47 +0100
Message-ID: <87wo8bmxs4.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the CPUID 0x7 masking back into __do_cpuid_func() now that the
> size of the code has been trimmed down significantly.
>
> Tweak the WARN case, which is impossible to hit unless the CPU is
> completely broken, to break the loop before creating the bogus entry.
>
> Opportunustically reorder the cpuid_entry_set() calls and shorten the
> comment about emulation to further reduce the footprint of CPUID 0x7.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 62 ++++++++++++++++----------------------------
>  1 file changed, 22 insertions(+), 40 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 77a6c1db138d..7362e5238799 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -456,44 +456,6 @@ static int __do_cpuid_func_emulated(struct kvm_cpuid_array *array, u32 func)
>  	return 0;
>  }
>  
> -static inline void do_cpuid_7_mask(struct kvm_cpuid_entry2 *entry)
> -{
> -	switch (entry->index) {
> -	case 0:
> -		entry->eax = min(entry->eax, 1u);
> -		cpuid_entry_mask(entry, CPUID_7_0_EBX);
> -		/* TSC_ADJUST is emulated */
> -		cpuid_entry_set(entry, X86_FEATURE_TSC_ADJUST);
> -		cpuid_entry_mask(entry, CPUID_7_ECX);
> -		cpuid_entry_mask(entry, CPUID_7_EDX);
> -		if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IBRS))
> -			cpuid_entry_set(entry, X86_FEATURE_SPEC_CTRL);
> -		if (boot_cpu_has(X86_FEATURE_STIBP))
> -			cpuid_entry_set(entry, X86_FEATURE_INTEL_STIBP);
> -		if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
> -			cpuid_entry_set(entry, X86_FEATURE_SPEC_CTRL_SSBD);
> -		/*
> -		 * We emulate ARCH_CAPABILITIES in software even
> -		 * if the host doesn't support it.
> -		 */
> -		cpuid_entry_set(entry, X86_FEATURE_ARCH_CAPABILITIES);
> -		break;
> -	case 1:
> -		cpuid_entry_mask(entry, CPUID_7_1_EAX);
> -		entry->ebx = 0;
> -		entry->ecx = 0;
> -		entry->edx = 0;
> -		break;
> -	default:
> -		WARN_ON_ONCE(1);
> -		entry->eax = 0;
> -		entry->ebx = 0;
> -		entry->ecx = 0;
> -		entry->edx = 0;
> -		break;
> -	}
> -}
> -
>  static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  {
>  	struct kvm_cpuid_entry2 *entry;
> @@ -555,14 +517,34 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		break;
>  	/* function 7 has additional index. */
>  	case 7:
> -		do_cpuid_7_mask(entry);
> +		entry->eax = min(entry->eax, 1u);
> +		cpuid_entry_mask(entry, CPUID_7_0_EBX);
> +		cpuid_entry_mask(entry, CPUID_7_ECX);
> +		cpuid_entry_mask(entry, CPUID_7_EDX);
> +
> +		/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
> +		cpuid_entry_set(entry, X86_FEATURE_TSC_ADJUST);
> +		cpuid_entry_set(entry, X86_FEATURE_ARCH_CAPABILITIES);
> +
> +		if (boot_cpu_has(X86_FEATURE_IBPB) && boot_cpu_has(X86_FEATURE_IBRS))
> +			cpuid_entry_set(entry, X86_FEATURE_SPEC_CTRL);
> +		if (boot_cpu_has(X86_FEATURE_STIBP))
> +			cpuid_entry_set(entry, X86_FEATURE_INTEL_STIBP);
> +		if (boot_cpu_has(X86_FEATURE_AMD_SSBD))
> +			cpuid_entry_set(entry, X86_FEATURE_SPEC_CTRL_SSBD);
>  
>  		for (i = 1, max_idx = entry->eax; i <= max_idx; i++) {
> +			if (WARN_ON_ONCE(i > 1))
> +				break;
> +
>  			entry = do_host_cpuid(array, function, i);
>  			if (!entry)
>  				goto out;
>  
> -			do_cpuid_7_mask(entry);
> +			cpuid_entry_mask(entry, CPUID_7_1_EAX);
> +			entry->ebx = 0;
> +			entry->ecx = 0;
> +			entry->edx = 0;
>  		}
>  		break;
>  	case 9:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

