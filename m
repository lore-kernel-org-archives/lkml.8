Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4531C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8315D2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eXUisQw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404193AbgEYP1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:27:08 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:26595 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404122AbgEYP1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:27:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590420423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D//cvB4ccMcU7KW9UZeTWAleysSnbPmlxts0hTz3QMU=;
        b=eXUisQw9YjXCmbyjVS+/gbkH0znmy3p6sxaBvXi69LqER2FMR1WQGb7Y++/Gp6LvFuDx9X
        OSEIAIBrebmb0uWXnS1DT6+MFG+vxJiVNO3xoizQ4Nk4ISdqE1FRfFNhSJ9TnQjlFXchuj
        XYEILfXJpKPWOdG1m/E62/x/XYmpmwE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-6noa9656NL6nkn6mQ973Fw-1; Mon, 25 May 2020 11:27:01 -0400
X-MC-Unique: 6noa9656NL6nkn6mQ973Fw-1
Received: by mail-ej1-f69.google.com with SMTP id h17so53955ejo.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 08:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=D//cvB4ccMcU7KW9UZeTWAleysSnbPmlxts0hTz3QMU=;
        b=WFp2VtefC2axSFh155OJcokIDqwCTIiY8Ti62MD9RsuiJwZtdyQqqcIZ4h8C7ec48b
         GuRCnPUlr9v5ykiBnCmCc6iTnKuTf1X3QUTYJAz/D87omzktygXsuf0Uda/02IAgYMu8
         eqXjXvJU9FfG/+YJW/QiDoufZN0sq0eaPFrgIlYX3b/2devpYlxO7+MPkRy74PQcT4tH
         PLUTv7EVi11GaMT3h7vBEj1WqfWU6hBO4j7Ru2T2pkKVpriVufMHSPSkGN1VnxUUWi13
         rbODVAdEHwUtQCDug8UPVACML8bevlXl0CRocd1xRZy4rXDIi36FcdNHv5hl9hWzGtbh
         NC/g==
X-Gm-Message-State: AOAM530zFOFry2r+RJstEW5CtpDX1ViyVtWwr2tP6LHhXe3BgwuBIqYH
        FGC3K2cQgr4EimyJ4u4OKNQ5lFFEe8N81rtjT3R2yXMyeIUTKmUaFoa/V+5uWCwpBHoaULQsDoS
        crll+5uoyQxDniE7KZQkCFDD9
X-Received: by 2002:aa7:c3cb:: with SMTP id l11mr15085927edr.364.1590420420658;
        Mon, 25 May 2020 08:27:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxZJ5nnz6Pm1rUfoN4Xt+hW/+DcDkZEDQAlbclmL9sVABHeTOqcq9oYu+WEZFJdsIkhoWrV9g==
X-Received: by 2002:aa7:c3cb:: with SMTP id l11mr15085907edr.364.1590420420401;
        Mon, 25 May 2020 08:27:00 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id cm26sm15655925edb.87.2020.05.25.08.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 08:26:59 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe\, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen\, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [RFC 10/16] KVM: x86: Enabled protected memory extension
In-Reply-To: <20200522125214.31348-11-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com> <20200522125214.31348-11-kirill.shutemov@linux.intel.com>
Date:   Mon, 25 May 2020 17:26:58 +0200
Message-ID: <871rn8827x.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> Wire up hypercalls for the feature and define VM_KVM_PROTECTED.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/Kconfig     | 1 +
>  arch/x86/kvm/cpuid.c | 3 +++
>  arch/x86/kvm/x86.c   | 9 +++++++++
>  include/linux/mm.h   | 4 ++++
>  4 files changed, 17 insertions(+)
>
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 58dd44a1b92f..420e3947f0c6 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -801,6 +801,7 @@ config KVM_GUEST
>  	select ARCH_CPUIDLE_HALTPOLL
>  	select X86_MEM_ENCRYPT_COMMON
>  	select SWIOTLB
> +	select ARCH_USES_HIGH_VMA_FLAGS
>  	default y
>  	---help---
>  	  This option enables various optimizations for running under the KVM
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 901cd1fdecd9..94cc5e45467e 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -714,6 +714,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  			     (1 << KVM_FEATURE_POLL_CONTROL) |
>  			     (1 << KVM_FEATURE_PV_SCHED_YIELD);
>  
> +		if (VM_KVM_PROTECTED)
> +			entry->eax |=(1 << KVM_FEATURE_MEM_PROTECTED);

Nit: missing space.

> +
>  		if (sched_info_on())
>  			entry->eax |= (1 << KVM_FEATURE_STEAL_TIME);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c17e6eb9ad43..acba0ac07f61 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -7598,6 +7598,15 @@ int kvm_emulate_hypercall(struct kvm_vcpu *vcpu)
>  		kvm_sched_yield(vcpu->kvm, a0);
>  		ret = 0;
>  		break;
> +	case KVM_HC_ENABLE_MEM_PROTECTED:
> +		ret = kvm_protect_all_memory(vcpu->kvm);
> +		break;
> +	case KVM_HC_MEM_SHARE:
> +		ret = kvm_protect_memory(vcpu->kvm, a0, a1, false);
> +		break;
> +	case KVM_HC_MEM_UNSHARE:
> +		ret = kvm_protect_memory(vcpu->kvm, a0, a1, true);
> +		break;
>  	default:
>  		ret = -KVM_ENOSYS;
>  		break;
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 4f7195365cc0..6eb771c14968 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -329,7 +329,11 @@ extern unsigned int kobjsize(const void *objp);
>  # define VM_MAPPED_COPY	VM_ARCH_1	/* T if mapped copy of data (nommu mmap) */
>  #endif
>  
> +#if defined(CONFIG_X86_64) && defined(CONFIG_KVM)
> +#define VM_KVM_PROTECTED VM_HIGH_ARCH_4
> +#else
>  #define VM_KVM_PROTECTED 0
> +#endif
>  
>  #ifndef VM_GROWSUP
>  # define VM_GROWSUP	VM_NONE

-- 
Vitaly

