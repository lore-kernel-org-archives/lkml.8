Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A58C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:37:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4AF206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 18:37:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4xSEIve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730903AbgCKShm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 14:37:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:45710 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730786AbgCKShl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 14:37:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583951860;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X0ZmaY++spyK7vmk+FHr1dD6tAiRChu3go1fBexokgw=;
        b=F4xSEIveKNBMUpbDVH8Sds0Ag3iIH+TreOUEdimbdx2opbBxzXObycSyd3zQY6SPxCdBcc
        lgHXzWlppaCNiGWYqMQKe13YFTXvYwK+CpuZlqoKYmfikOgsY8QgTFkquQXhQ61nKrMmgR
        jscxC2ilnIoK/ewjVpj4kly8D0onUXg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-MNJjid9jPuiYXHctxOT2oA-1; Wed, 11 Mar 2020 14:37:39 -0400
X-MC-Unique: MNJjid9jPuiYXHctxOT2oA-1
Received: by mail-wm1-f69.google.com with SMTP id s20so389895wmj.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 11:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X0ZmaY++spyK7vmk+FHr1dD6tAiRChu3go1fBexokgw=;
        b=MDmtmFUbj5K7+bjgKq1LIumNdakt7jEEC+kzG8nOV6zKRfq/i9t7xrDM2lCo9LdUK+
         Udq0DSOxl+7AlZeJz+HGQTxL2cXSjj3DwL1l9L/dvBPu/xN8sHRFmfKp4UOMsZOeG55u
         NcVt6yuLuiQTiGAH6w5mm1TnLZrO+KLGco7xlbFylyVY425A8f+hm60xZmuvP8oZVYbj
         Nv8DiVzmVV2v1SeNqecZLfMoFTCKkE9lNXmkRAgRdkOOIQrj/t6ZWNweWu7AFJAMRUX/
         58OU2IeuOy8EeTS9SBCsFe+8jLc+wDk0/0I8alV4k3DxChmNTkkeJXaOqX4rbOwmw2w3
         S8Yg==
X-Gm-Message-State: ANhLgQ2CLrNL/TfXxRzY2eT/+ZTYk/4f1UhDxie2t0mct4g7oVD81gXt
        T8PhQd/3/GXMP61B88RZlyNzSHy33+uaSWSxDr/vtMm1EQqT3mJAPTCCF/uNfsFNL34udzmxk6d
        a4jPU7qch5rC9fue19TecSeuv
X-Received: by 2002:a5d:488c:: with SMTP id g12mr5957968wrq.67.1583951857917;
        Wed, 11 Mar 2020 11:37:37 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsflks/o8X6/ZRDJnODjPvnwGeTVxJEJNFcC5ElmMG03JirD4k6HnufLeAkGDsp8WdXHXVZQw==
X-Received: by 2002:a5d:488c:: with SMTP id g12mr5957948wrq.67.1583951857638;
        Wed, 11 Mar 2020 11:37:37 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:4887:2313:c0bc:e3a8? ([2001:b07:6468:f312:4887:2313:c0bc:e3a8])
        by smtp.gmail.com with ESMTPSA id f17sm63743791wrj.28.2020.03.11.11.37.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Mar 2020 11:37:37 -0700 (PDT)
Subject: Re: [PATCH v2 00/66] KVM: x86: Introduce KVM cpu caps
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <cd8eae75-b85b-59a9-24ea-c8bde7bd7cee@redhat.com>
 <20200309201134.GA10653@linux.intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d4cf3b8c-6dcd-e3be-e0cd-96100ed7be25@redhat.com>
Date:   Wed, 11 Mar 2020 19:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309201134.GA10653@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/20 21:11, Sean Christopherson wrote:
> 
> For supported_xss, would it make sense to handle it purely in common x86
> code, e.g. stub in something similar to supported_xcr0?  KVM_SUPPORTED_XSS
> would be 0 for now.  I assume whatever XSAVES features are supported will
> be "supported" by both VMX and SVM, in the sense that VMX/SVM won't need
> to mask off features that can exist on their respective hardware but can't
> be exposed to the guest.

I preferred to keep it safe because I'm not sure if in the future there
will be an XSAVES feature that absolutely needs to be swapped atomically
via VMCB fields.  Since SVM does not have an MSR load/save area, it's
not impossible that such a feature would have to be supported only on  VMX.

Paolo

> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 4dca3579e740..c6e9910d1149 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1371,8 +1371,6 @@ static __init void svm_set_cpu_caps(void)
>  {
>         kvm_set_cpu_caps();
>  
> -       supported_xss = 0;
> -
>         /* CPUID 0x80000001 and 0x8000000A (SVM features) */
>         if (nested) {
>                 kvm_cpu_cap_set(X86_FEATURE_SVM);
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 8001070b209c..e91a84bb251c 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7126,7 +7126,6 @@ static __init void vmx_set_cpu_caps(void)
>                 kvm_cpu_cap_set(X86_FEATURE_UMIP);
>  
>         /* CPUID 0xD.1 */
> -       supported_xss = 0;
>         if (!vmx_xsaves_supported())
>                 kvm_cpu_cap_clear(X86_FEATURE_XSAVES);
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 96e897d38a63..29cfe80db4b4 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9628,6 +9628,8 @@ int kvm_arch_hardware_setup(void)
>  
>         if (!kvm_cpu_cap_has(X86_FEATURE_XSAVES))
>                 supported_xss = 0;
> +       else
> +               supported_xss = host_xss & KVM_SUPPORTED_XSS;
>  
>         cr4_reserved_bits = kvm_host_cr4_reserved_bits(&boot_cpu_data);
> 

