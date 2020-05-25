Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA39C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:59:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE15208A7
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej0e13nJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404108AbgEYO7D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:59:03 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42706 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2403996AbgEYO7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:59:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590418741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/PbRQvB88ht24b8raCs2Rp+OemoV1xc4Dn7xmItPEjo=;
        b=Ej0e13nJTXOEmSKCQVitLTSaxaOWYlU6f2xGRXps/mz6leK1roz7oZ6YdZlRYSlW4O7z/r
        sIC55pqwBqTW2JiQHKq0cCUqE5l0PdteaVjHQ0jKvmy45W9h3sa9fpGS9XKZUEfFklIQ1w
        Q37f7N7lP+n3YquKJyZOBj7xgUCxovU=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-1-w1L8mdADN4mAprqihsApOw-1; Mon, 25 May 2020 10:58:56 -0400
X-MC-Unique: w1L8mdADN4mAprqihsApOw-1
Received: by mail-ej1-f69.google.com with SMTP id h17so37365ejo.21
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 07:58:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/PbRQvB88ht24b8raCs2Rp+OemoV1xc4Dn7xmItPEjo=;
        b=jhd2mZipjUsln4s8z7UKZiYbrdU7nIxNPmCLOT+patq8aeg12/XixSKmKGpeD7/fWM
         vBZKF1XI1jgp/Qlg6Y1oo8dkVa6hNwaSRe8tkz0qVVAbzSpqmxyO4w9v7VoKRc1RisfS
         JhVxRKyaNFNrbfQKRf13sTKuw27F26sFOMiDXUdfGrNAl+VVFOns7mnNXQYNuiNt+WlC
         x+qcFRXnUVz1GP01sx3nStZBb0N6TxtxIdhN22xPhYdOuyVQNyQkScNooyO2BhjHCtC0
         qUjsEzTPbbKPKA0BqXOygxqpfQ50DEH5FbrWnZkFcEkuMHbjZ+fs9TJV0PCl/S4BZk2f
         NfcA==
X-Gm-Message-State: AOAM5337yfWVTvYtnVwlFwTNRGaYVSbDk22iwskl2KioZ4ccuR0/7yzl
        riG/6C0/nm1MPPxaaDmRqhyqdZx+TbDjsktd5xhjFIj2c0mEFNqgrx1iUGVKCsQn6XsDWqR8kxB
        m18oQvPSBeLACZXnFdd38rSe/
X-Received: by 2002:a50:ae02:: with SMTP id c2mr15032187edd.373.1590418733891;
        Mon, 25 May 2020 07:58:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbhAfQv27YSR8SHsKDaU9868pdSCI+CFNDsQqunB+c4lrCFbVP38Mx6dHQ77pU4fv1zDsTqA==
X-Received: by 2002:a50:ae02:: with SMTP id c2mr15032176edd.373.1590418733681;
        Mon, 25 May 2020 07:58:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id c15sm10946676edm.78.2020.05.25.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 07:58:53 -0700 (PDT)
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
Subject: Re: [RFC 02/16] x86/kvm: Introduce KVM memory protection feature
In-Reply-To: <20200522125214.31348-3-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com> <20200522125214.31348-3-kirill.shutemov@linux.intel.com>
Date:   Mon, 25 May 2020 16:58:51 +0200
Message-ID: <87d06s83is.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Kirill A. Shutemov" <kirill@shutemov.name> writes:

> Provide basic helpers, KVM_FEATURE and a hypercall.
>
> Host side doesn't provide the feature yet, so it is a dead code for now.
>
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/include/asm/kvm_para.h      |  5 +++++
>  arch/x86/include/uapi/asm/kvm_para.h |  3 ++-
>  arch/x86/kernel/kvm.c                | 16 ++++++++++++++++
>  include/uapi/linux/kvm_para.h        |  3 ++-
>  4 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 9b4df6eaa11a..3ce84fc07144 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -10,11 +10,16 @@ extern void kvmclock_init(void);
>  
>  #ifdef CONFIG_KVM_GUEST
>  bool kvm_check_and_clear_guest_paused(void);
> +bool kvm_mem_protected(void);
>  #else
>  static inline bool kvm_check_and_clear_guest_paused(void)
>  {
>  	return false;
>  }
> +static inline bool kvm_mem_protected(void)
> +{
> +	return false;
> +}
>  #endif /* CONFIG_KVM_GUEST */
>  
>  #define KVM_HYPERCALL \
> diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
> index 2a8e0b6b9805..c3b499acc98f 100644
> --- a/arch/x86/include/uapi/asm/kvm_para.h
> +++ b/arch/x86/include/uapi/asm/kvm_para.h
> @@ -28,9 +28,10 @@
>  #define KVM_FEATURE_PV_UNHALT		7
>  #define KVM_FEATURE_PV_TLB_FLUSH	9
>  #define KVM_FEATURE_ASYNC_PF_VMEXIT	10
> -#define KVM_FEATURE_PV_SEND_IPI	11
> +#define KVM_FEATURE_PV_SEND_IPI		11

Nit: spurrious change

>  #define KVM_FEATURE_POLL_CONTROL	12
>  #define KVM_FEATURE_PV_SCHED_YIELD	13
> +#define KVM_FEATURE_MEM_PROTECTED	14
>  
>  #define KVM_HINTS_REALTIME      0
>  
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 6efe0410fb72..bda761ca0d26 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -35,6 +35,13 @@
>  #include <asm/tlb.h>
>  #include <asm/cpuidle_haltpoll.h>
>  
> +static bool mem_protected;
> +
> +bool kvm_mem_protected(void)
> +{
> +	return mem_protected;
> +}
> +

Honestly, I don't see a need for kvm_mem_protected(), just rename the
bool if you need kvm_ prefix :-)

>  static int kvmapf = 1;
>  
>  static int __init parse_no_kvmapf(char *arg)
> @@ -727,6 +734,15 @@ static void __init kvm_init_platform(void)
>  {
>  	kvmclock_init();
>  	x86_platform.apic_post_init = kvm_apic_init;
> +
> +	if (kvm_para_has_feature(KVM_FEATURE_MEM_PROTECTED)) {
> +		if (kvm_hypercall0(KVM_HC_ENABLE_MEM_PROTECTED)) {
> +			pr_err("Failed to enable KVM memory protection\n");
> +			return;
> +		}
> +
> +		mem_protected = true;
> +	}
>  }

Personally, I'd prefer to do this via setting a bit in a KVM-specific
MSR instead. The benefit is that the guest doesn't need to remember if
it enabled the feature or not, it can always read the config msr. May
come handy for e.g. kexec/kdump.

>  
>  const __initconst struct hypervisor_x86 x86_hyper_kvm = {
> diff --git a/include/uapi/linux/kvm_para.h b/include/uapi/linux/kvm_para.h
> index 8b86609849b9..1a216f32e572 100644
> --- a/include/uapi/linux/kvm_para.h
> +++ b/include/uapi/linux/kvm_para.h
> @@ -27,8 +27,9 @@
>  #define KVM_HC_MIPS_EXIT_VM		7
>  #define KVM_HC_MIPS_CONSOLE_OUTPUT	8
>  #define KVM_HC_CLOCK_PAIRING		9
> -#define KVM_HC_SEND_IPI		10
> +#define KVM_HC_SEND_IPI			10

Same spurrious change detected.

>  #define KVM_HC_SCHED_YIELD		11
> +#define KVM_HC_ENABLE_MEM_PROTECTED	12
>  
>  /*
>   * hypercalls use architecture specific

-- 
Vitaly

