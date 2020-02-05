Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1171CC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA03C217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K2bYxWX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727524AbgBEObI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:31:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54244 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727003AbgBEObF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:31:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580913064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sHYKodjFVDSIcn10UudO1fMfOFwyzIATDeSzz3cLTkw=;
        b=K2bYxWX8sRExA/uEEPcghqiEyfV3SmAPabWSJVYdsMN54OVcs3boctCme3tz9TtQUMppyT
        097rLFjALH7j8jIKGdD0ic/5mHFLPftYbxO0w6F0yAIFXUpKQMxtK5HNANilOvWLMSisDr
        Zkt5+AFo4yPrD1btmEFYlOhe7Gyfav8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-p43FbHAvMGi2Vq0aUU46AA-1; Wed, 05 Feb 2020 09:31:02 -0500
X-MC-Unique: p43FbHAvMGi2Vq0aUU46AA-1
Received: by mail-wr1-f70.google.com with SMTP id s13so1266807wru.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:31:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=sHYKodjFVDSIcn10UudO1fMfOFwyzIATDeSzz3cLTkw=;
        b=fxBVfR+GHmLy6aO9tL6eCE5aJ++j6Ms3GPkoQ7RPUPtB7oqaaVxTeCjdNwJSMHlvfU
         WgaQzAyTQ33WWhh5fErRjqyjN1+ejraJqTVOacJPEO+6RTlc+JuF/CEABGG/H6hCb2Fd
         clnfpau7UKeYbqwiYK5NXydd5qSndVx38JN+SoQ00jAjVQU9Wt+ciWGeIB+XNdWubi6f
         c1hvd/N2/j1dyEv17b7KUC0/eBHCeaEjdh0bhnLOAlohreLWYffoLWv4QBgmOXghpEas
         dkYoB7qEn/xfH1b/7qFlvZ23O3YEWKHyT4Vua1W1heIM+5c4cOXSiqu1smYM1OjaV+WU
         nZ6w==
X-Gm-Message-State: APjAAAUGgnzZ0hWscQ9S7DkqBPpfiXxSCgXioAqX+3BXnbhx2dP54bgq
        rHo0EHZ5i+FYFhSCmokPJkPckng+GKYVyVwpmI5OU/l3hLF6bg4Dy5L+hnHj0O7HIqreKIWKR6I
        BOFK1fUbDMxjwljbeoyeRWrmr
X-Received: by 2002:a5d:484d:: with SMTP id n13mr28173380wrs.420.1580913061408;
        Wed, 05 Feb 2020 06:31:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzFK6EvOMGq9u7DSi56KhONwlHzFQfhDMzkLRJNTfs/7t/pQJPyaDPRAy10xdDkndgy5KPNtw==
X-Received: by 2002:a5d:484d:: with SMTP id n13mr28173360wrs.420.1580913061224;
        Wed, 05 Feb 2020 06:31:01 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id w7sm8284222wmi.9.2020.02.05.06.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 06:30:59 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 02/26] KVM: x86: Take an unsigned 32-bit int for has_emulated_msr()'s index
In-Reply-To: <20200129234640.8147-3-sean.j.christopherson@intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-3-sean.j.christopherson@intel.com>
Date:   Wed, 05 Feb 2020 15:30:59 +0100
Message-ID: <87k151ksws.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Take a u32 for the index in has_emulated_msr() to match hardware, which
> treats MSR indices as unsigned 32-bit values.  Functionally, taking a
> signed int doesn't cause problems with the current code base, but could
> theoretically cause problems with 32-bit KVM, e.g. if the index were
> checked via a less-than statement, which would evaluate incorrectly for
> MSR indices with bit 31 set.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 +-
>  arch/x86/kvm/svm.c              | 2 +-
>  arch/x86/kvm/vmx/vmx.c          | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 77d206a93658..5c2ad3fa0980 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1050,7 +1050,7 @@ struct kvm_x86_ops {
>  	int (*hardware_setup)(void);               /* __init */
>  	void (*hardware_unsetup)(void);            /* __exit */
>  	bool (*cpu_has_accelerated_tpr)(void);
> -	bool (*has_emulated_msr)(int index);
> +	bool (*has_emulated_msr)(u32 index);
>  	void (*cpuid_update)(struct kvm_vcpu *vcpu);
>  
>  	struct kvm *(*vm_alloc)(void);
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index bf0556588ad0..a7b944a3a0e2 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5985,7 +5985,7 @@ static bool svm_cpu_has_accelerated_tpr(void)
>  	return false;
>  }
>  
> -static bool svm_has_emulated_msr(int index)
> +static bool svm_has_emulated_msr(u32 index)
>  {
>  	switch (index) {
>  	case MSR_IA32_MCG_EXT_CTL:
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 1419c53aed16..f5bb1ad2e9fa 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6274,7 +6274,7 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
>  		*exit_fastpath = handle_fastpath_set_msr_irqoff(vcpu);
>  }
>  
> -static bool vmx_has_emulated_msr(int index)
> +static bool vmx_has_emulated_msr(u32 index)
>  {
>  	switch (index) {
>  	case MSR_IA32_SMBASE:

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

