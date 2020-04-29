Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C39C4C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C9A82082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q3FxWpoT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726503AbgD2If6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:35:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28603 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726345AbgD2If6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:35:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588149356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qdJ9Tssfd21+vkaPztq8wUNJY05TZTVous+kbqb7BpY=;
        b=Q3FxWpoTSnIld4BjN9jytf5XtCtX+xwBN6uLscw7jbiXZvg4+YBGP5HNg3X5cQDzr/PMbZ
        5spnBwQ9Hl3rashvX6X4vTbVymSB9mOASav+dm011a7QLaDI3aoPYjoH1IFqOCQoCaNoEV
        2lVRMCshmS41YVudIbrUG8qTS7cCVaY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-Hyw3QahcPUe1rCfNcFmAKw-1; Wed, 29 Apr 2020 04:35:54 -0400
X-MC-Unique: Hyw3QahcPUe1rCfNcFmAKw-1
Received: by mail-wm1-f70.google.com with SMTP id o26so725614wmh.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:35:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=qdJ9Tssfd21+vkaPztq8wUNJY05TZTVous+kbqb7BpY=;
        b=XCBodhJb2R+k6CJpBMRDCtwCUA73vJAmuCGUvYTqJcxmoAa6wpODJS2kkm/gVvYndx
         WHUtS566K1RNVFSF3/rzmyoIL0WPYYLonpbSR5HLr4pClmjv/8B7+raQLl5HgS5zRnlf
         lKwQEQ6g0dvoykvPOxLeLzOGgv+w/lPq1Tx3YsgCFzwrLU6tmBEphPdsSFnKitLJCrB9
         8AUzDZDbACxXynrysG7Cfa4dC2vY7qOFctXh8ikjk+PHGpX0ugGJjhE3QGVD2FYtZHWv
         uSRlUuIljDWimK6+uXpdiXroxEC6Mr6pJ53mexrLp4Uemy7RtnYHQcXEwhwyU5nBXpMK
         mLUw==
X-Gm-Message-State: AGi0PuZuVUKn4CWvPDayLoiBl3VfTGOUF4MRHoPBYIKp12j1x7do2CJz
        av4ymWqi0kxMnO3FhW3sbnZBx1OiD6xP89h893guD0EkDIDi/LarL6XSHYlr/SBP/4JkbueSAK0
        eBx74aBeQZBSkrxXodgTSF8vt
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr1912727wmd.95.1588149353524;
        Wed, 29 Apr 2020 01:35:53 -0700 (PDT)
X-Google-Smtp-Source: APiQypIBRr85ezZitL4y/lv7Xl5LCtDwiiwsjxzrPLzALJ4qDzhFmjEVYJ8D+cpir1X8GMvK6w0BZw==
X-Received: by 2002:a1c:7f86:: with SMTP id a128mr1912713wmd.95.1588149353322;
        Wed, 29 Apr 2020 01:35:53 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id a205sm7221889wmh.29.2020.04.29.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 01:35:52 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Xiaoyao Li <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kvm: x86: Cleanup vcpu->arch.guest_xstate_size
In-Reply-To: <20200429154312.1411-1-xiaoyao.li@intel.com>
References: <20200429154312.1411-1-xiaoyao.li@intel.com>
Date:   Wed, 29 Apr 2020 10:35:43 +0200
Message-ID: <87368mit9c.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xiaoyao Li <xiaoyao.li@intel.com> writes:

> vcpu->arch.guest_xstate_size lost its only user since commit df1daba7d1cb
> ("KVM: x86: support XSAVES usage in the host"), so clean it up.
>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 1 -
>  arch/x86/kvm/cpuid.c            | 8 ++------
>  arch/x86/kvm/x86.c              | 2 --
>  3 files changed, 2 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 7cd68d1d0627..34a05ca3c904 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -654,7 +654,6 @@ struct kvm_vcpu_arch {
>  
>  	u64 xcr0;
>  	u64 guest_supported_xcr0;
> -	u32 guest_xstate_size;
>  
>  	struct kvm_pio_request pio;
>  	void *pio_data;
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6828be99b908..f3eb4f171d3d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -84,15 +84,11 @@ int kvm_update_cpuid(struct kvm_vcpu *vcpu)
>  				   kvm_read_cr4_bits(vcpu, X86_CR4_PKE));
>  
>  	best = kvm_find_cpuid_entry(vcpu, 0xD, 0);
> -	if (!best) {
> +	if (!best)
>  		vcpu->arch.guest_supported_xcr0 = 0;
> -		vcpu->arch.guest_xstate_size = XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET;
> -	} else {
> +	else
>  		vcpu->arch.guest_supported_xcr0 =
>  			(best->eax | ((u64)best->edx << 32)) & supported_xcr0;
> -		vcpu->arch.guest_xstate_size = best->ebx =
> -			xstate_required_size(vcpu->arch.xcr0, false);
> -	}
>  
>  	best = kvm_find_cpuid_entry(vcpu, 0xD, 1);
>  	if (best && (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 856b6fc2c2ba..7cd51a3acc43 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9358,8 +9358,6 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
>  	}
>  	fx_init(vcpu);
>  
> -	vcpu->arch.guest_xstate_size = XSAVE_HDR_SIZE + XSAVE_HDR_OFFSET;
> -
>  	vcpu->arch.maxphyaddr = cpuid_query_maxphyaddr(vcpu);
>  
>  	vcpu->arch.pat = MSR_IA32_CR_PAT_DEFAULT;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

