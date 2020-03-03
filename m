Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3A50C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC10320828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sy96jZlV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbgCCQOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:14:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40209 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730168AbgCCQOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:14:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583252058;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ke7JyOZ+XUVw15fBOEBYEhZUVs/KiL71BjHy19fu+e0=;
        b=Sy96jZlVpMK/dalzbRcBMCs6t4ZgTgQaB4F0tmp3O8C0S6XFKzVrw0OLN5Hy+9ArvCgel8
        ivtYdoS+8qTGa0XC4h3rY6xjL8mNK4LIo4JpkA5GzHV4FmrSLWaoR2L6XtcyvwzWxpSiuH
        wNWygPSPeV+LCx8DLLEeOe55QxZNAUM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-qo_Jh0-OOpiCW1bWYoP3fA-1; Tue, 03 Mar 2020 11:14:16 -0500
X-MC-Unique: qo_Jh0-OOpiCW1bWYoP3fA-1
Received: by mail-wm1-f69.google.com with SMTP id p186so181141wmp.0
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:14:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ke7JyOZ+XUVw15fBOEBYEhZUVs/KiL71BjHy19fu+e0=;
        b=hVhOk2mlYKexQT5+gmwZe8YqGmoyQtSUocX7Xizpyu9hHRLO0zb/+87zAXwEstF967
         5x5/G7mu+JUwz39b3xyEXlnUpSdwmGhxexNTTt2cC7TlDRDckKey7mMgiAAq6uAK+NeG
         AcOMCwrWYAaR1DaFOD4jGiKoT8g9zft/8Shd+g87lTzV0EQkv5kgsWDpXcNAuIJOAKQi
         oZ3HAXTbRSLOG5kfnE7Vq2tJWsLsqEEV3KW/7nE4lzIc9A/iCyqXYkI8f4tvhXwWrdxD
         Nex3jcob2exPw40toeTRSQnHVgK/whr+2wR/jowMdTfdvU9iLgEoAltf85vrjYl+RGK/
         e5Zw==
X-Gm-Message-State: ANhLgQ1PKbmV6nqwVks4wAVmmR5hJ8kFv5DXwuohNAi6fijHUc+oxxhk
        3eowc+uFjO7km4Mgqq6A1vORPq3UexNtjn48SDPaLJQpqMkCG3U07lAP0pbss/mnJRnPoinJeDw
        JGcBiDjFmTZOErC12FzEdgGk7
X-Received: by 2002:a5d:4385:: with SMTP id i5mr6533999wrq.73.1583252054839;
        Tue, 03 Mar 2020 08:14:14 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvzxW70xc/VJEcuSFwL+qOMYmCt0A4uPOJ819FvR079RmuIjM3QhoM81oK2YqUq/BXSW9GBqg==
X-Received: by 2002:a5d:4385:: with SMTP id i5mr6533975wrq.73.1583252054588;
        Tue, 03 Mar 2020 08:14:14 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q16sm18640242wrj.73.2020.03.03.08.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:14:12 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 65/66] KVM: nSVM: Advertise and enable NRIPS for L1 iff nrips is enabled
In-Reply-To: <20200302235709.27467-66-sean.j.christopherson@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com> <20200302235709.27467-66-sean.j.christopherson@intel.com>
Date:   Tue, 03 Mar 2020 17:14:12 +0100
Message-ID: <875zflfmaz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Set NRIPS in KVM capabilities if and only if nrips=true, which naturally
> incorporates the boot_cpu_has() check, and set nrips_enabled only if the
> KVM capability is enabled.
>
> Note, previously KVM would set nrips_enabled based purely on userspace
> input, but at worst that would cause KVM to propagate garbage into L1,
> i.e. userspace would simply be hosing its VM.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 8e39dcd3160d..32d9c13ec6b9 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1377,7 +1377,7 @@ static __init void svm_set_cpu_caps(void)
>  	if (nested) {
>  		kvm_cpu_cap_set(X86_FEATURE_SVM);
>  
> -		if (boot_cpu_has(X86_FEATURE_NRIPS))
> +		if (nrips)
>  			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
>  
>  		if (npt_enabled)
> @@ -6031,7 +6031,8 @@ static void svm_cpuid_update(struct kvm_vcpu *vcpu)
>  				    boot_cpu_has(X86_FEATURE_XSAVES);
>  
>  	/* Update nrips enabled cache */
> -	svm->nrips_enabled = !!guest_cpuid_has(&svm->vcpu, X86_FEATURE_NRIPS);
> +	svm->nrips_enabled = kvm_cpu_cap_has(X86_FEATURE_NRIPS) &&
> +			     guest_cpuid_has(&svm->vcpu, X86_FEATURE_NRIPS);
>  
>  	if (!kvm_vcpu_apicv_active(vcpu))
>  		return;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

