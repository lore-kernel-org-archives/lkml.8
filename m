Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00DDC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71B02082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="THWJtdUL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727085AbgBEOjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:39:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44292 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726308AbgBEOjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:39:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580913553;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SoydEapPcnWnsyykjUkOlfTYQqJiOhpLPIh1rU1g+ZM=;
        b=THWJtdULO7acwRNjSzQVMxx+dCL+MvgXrTZ4YyyzmKosCrnlocFn5Ldi6TzekU/9kY6YOA
        B+Kavzs9FJ48SlseFLMZa2vYwUFFpvb0Q/OBpn4jlhYFh1F9iHS+YwLRcjFkOQ1TPrOHk5
        TUdFL0rgDX/rHgOIiZCn1AWS+phZwR4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-qpQbC9GWNgmmts1pcC1DnA-1; Wed, 05 Feb 2020 09:39:11 -0500
X-MC-Unique: qpQbC9GWNgmmts1pcC1DnA-1
Received: by mail-wm1-f70.google.com with SMTP id y24so913524wmj.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 06:39:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=SoydEapPcnWnsyykjUkOlfTYQqJiOhpLPIh1rU1g+ZM=;
        b=cHT8xi2jBDJNufTG/6L1D1UEjBo2WAgl+hPnV26exbjRInGyzOcN6YRAA38BU9ZwIx
         nhrc/s7i5SqZtYboD/CHwwKbtqee9H5Z+pj8aY92ia7QhKIj04LMFmmaGnebrDlBYxKH
         lD0COAFDljIHIZYmEuTDf7UtsPsZUdZ8hnHZr4XIg5nUig4cm6ReUjjWxu74IGlfKUTW
         tzF43I9mz9nx4UnPWF7q0pc3cwZcOCWLWCS6EIE9x49APlHRXpBcASeYrLGv79u9z8+1
         BjjGkLzmlB+22/VM1pymjVZ1hTKC1O7vW5910yx7TWAD1ziJsTfvxhqSe5wXbG/wMR79
         ro/g==
X-Gm-Message-State: APjAAAWIIWAJv8Eq5DXbWXUz5rSaldEniKdvrNbPwawSwvC00qDsAjcS
        yfGhwIe+n6JLvGAaoB6UloJaWAKT/jPRHHFzGZHGBhe6PKggTX9xBMfpKKftztHHPThNOa+iJKv
        6+v2MR97/PXLqYeMvRwtwb3ir
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6027144wmk.15.1580913550656;
        Wed, 05 Feb 2020 06:39:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZ2+MUSKIq0bFGeGsEl8yDAXhtSQNMDtk5nz9iHlEYoHTTiNkrjIeGzfVkfAlpNl/KZdLkuQ==
X-Received: by 2002:a7b:c759:: with SMTP id w25mr6027129wmk.15.1580913550452;
        Wed, 05 Feb 2020 06:39:10 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id k13sm21684wrx.59.2020.02.05.06.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 06:39:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 05/26] KVM: x86: Move MSR_TSC_AUX existence checks into vendor code
In-Reply-To: <20200129234640.8147-6-sean.j.christopherson@intel.com>
References: <20200129234640.8147-1-sean.j.christopherson@intel.com> <20200129234640.8147-6-sean.j.christopherson@intel.com>
Date:   Wed, 05 Feb 2020 15:39:08 +0100
Message-ID: <87blqdksj7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move the MSR_TSC_AUX existence check into vendor code using the newly
> introduced ->has_virtualized_msr() hook to help pave the way toward the
> removal of ->rdtscp_supported().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm.c     | 7 +++++++
>  arch/x86/kvm/vmx/vmx.c | 7 +++++++
>  arch/x86/kvm/x86.c     | 4 ----
>  3 files changed, 14 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 1f9323fbad81..4c8427f57b71 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -5987,6 +5987,13 @@ static bool svm_cpu_has_accelerated_tpr(void)
>  
>  static bool svm_has_virtualized_msr(u32 index)
>  {
> +	switch (index) {
> +	case MSR_TSC_AUX:
> +		return boot_cpu_has(X86_FEATURE_RDTSCP);
> +	default:
> +		break;
> +	}
> +
>  	return true;
>  }
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 3f2c094434e8..9588914e941e 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6276,6 +6276,13 @@ static void vmx_handle_exit_irqoff(struct kvm_vcpu *vcpu,
>  
>  static bool vmx_has_virtualized_msr(u32 index)
>  {
> +	switch (index) {
> +	case MSR_TSC_AUX:
> +		return cpu_has_vmx_rdtscp();
> +	default:
> +		break;
> +	}
> +
>  	return true;
>  }
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 94f90fe1c0de..a8619c52ea86 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5241,10 +5241,6 @@ static void kvm_init_msr_list(void)
>  			if (!kvm_mpx_supported())
>  				continue;
>  			break;
> -		case MSR_TSC_AUX:
> -			if (!kvm_x86_ops->rdtscp_supported())
> -				continue;
> -			break;
>  		case MSR_IA32_RTIT_CTL:
>  		case MSR_IA32_RTIT_STATUS:
>  			if (!kvm_x86_ops->pt_supported())

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

