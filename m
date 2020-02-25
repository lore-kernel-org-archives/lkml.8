Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C473C35E03
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6AF1220732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:16:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCgLh2BA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730590AbgBYOQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:16:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57741 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729386AbgBYOQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:16:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582640210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IzQn+onzvBlxqocwz0NsyUCMnotTZ6aJbCpbo5ir5HI=;
        b=GCgLh2BAWGfo6OxlVDKeDDHwMc/mEm9SXTsHeVM5zt1ZZNpCvjT8Lt5k1jx8CSD8NSPZ2V
        uvCT17FG7nbvZXwb65G2nVrUhaS5XYu+ZMcMRUWbme1Uej4PqEnB778j9YuE7GX+0JMbfS
        dQQKpJyP8ZyjzZVdPUWxlISYpHKW7A4=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-h0XOl_F_NoKzNYSprrmykQ-1; Tue, 25 Feb 2020 09:16:49 -0500
X-MC-Unique: h0XOl_F_NoKzNYSprrmykQ-1
Received: by mail-wr1-f72.google.com with SMTP id m15so7326432wrs.22
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 06:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=IzQn+onzvBlxqocwz0NsyUCMnotTZ6aJbCpbo5ir5HI=;
        b=HFjajVhW1+iuoUCYi+/Cr6c0QmTZNsElu8drIfQOnwcvV9+Ul8FpNkuDFdTKRKPUYQ
         9aY/1phegilcqPcO5q+SdMJywbkIU+QFD8YQlMSQuaUcfI5XZBQXQ4f/nmbXkAxswNnc
         mll2zhhus88JV30I7OKMkVPCSn70L12Foll3c7lWBNmTZoCglqf7nqczObvm9Zvj1hZ+
         cEQohtqCpcAk5iXC4jWSC5u/ZBZgDNv2V6Qlts++NjamC5sDc1/IsT9b4G03nx9dHq9q
         7Smntr1FHJ9IlDzStrrWimDuaJWSw3jB9lIGu/CCQU977fdIcNhqq9mKmVP1UEsToYLM
         HCRA==
X-Gm-Message-State: APjAAAU3yu6UjwWZiJ5RQrNpSECFmCvAxOe+qLg4LxVBvO2035xPwYr2
        ueRGK30QToGYx6H/qf3aqrowE5+iQ4011gVQAJsiuVT0YX6x5HLnTkH+z0pl0zOH4kUzwr1PS83
        CUkKu6eSc1uaCj+DIB8m71yE9
X-Received: by 2002:a5d:5044:: with SMTP id h4mr69727247wrt.4.1582640207935;
        Tue, 25 Feb 2020 06:16:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqxJp/qijxC/XruuNkhMbwA0G62eKvQ1UZq7MZO3LcjaKoXbLRecbRmkRft5llJb3hZkv2UPzw==
X-Received: by 2002:a5d:5044:: with SMTP id h4mr69727222wrt.4.1582640207667;
        Tue, 25 Feb 2020 06:16:47 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id z4sm24516180wrt.47.2020.02.25.06.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 06:16:47 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 55/61] KVM: VMX: Directly query Intel PT mode when refreshing PMUs
In-Reply-To: <20200201185218.24473-56-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-56-sean.j.christopherson@intel.com>
Date:   Tue, 25 Feb 2020 15:16:46 +0100
Message-ID: <87k14alpkh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use vmx_pt_mode_is_host_guest() in intel_pmu_refresh() instead of
> bouncing through kvm_x86_ops->pt_supported, and remove ->pt_supported()
> as the PMU code was the last remaining user.
>
> Opportunistically clean up the wording of a comment that referenced
> kvm_x86_ops->pt_supported().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/include/asm/kvm_host.h | 2 --
>  arch/x86/kvm/svm.c              | 7 -------
>  arch/x86/kvm/vmx/pmu_intel.c    | 2 +-
>  arch/x86/kvm/vmx/vmx.c          | 6 ------
>  arch/x86/kvm/x86.c              | 7 +++----
>  5 files changed, 4 insertions(+), 20 deletions(-)
>
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 1dd5ac8a2136..a8bae9d88bce 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1162,8 +1162,6 @@ struct kvm_x86_ops {
>  	void (*handle_exit_irqoff)(struct kvm_vcpu *vcpu,
>  		enum exit_fastpath_completion *exit_fastpath);
>  
> -	bool (*pt_supported)(void);
> -
>  	int (*check_nested_events)(struct kvm_vcpu *vcpu, bool external_intr);
>  	void (*request_immediate_exit)(struct kvm_vcpu *vcpu);
>  
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index 6dd9c810c0dc..a27f83f7521c 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -6074,11 +6074,6 @@ static int svm_get_lpage_level(void)
>  	return PT_PDPE_LEVEL;
>  }
>  
> -static bool svm_pt_supported(void)
> -{
> -	return false;
> -}
> -
>  static bool svm_has_wbinvd_exit(void)
>  {
>  	return true;
> @@ -7438,8 +7433,6 @@ static struct kvm_x86_ops svm_x86_ops __ro_after_init = {
>  
>  	.cpuid_update = svm_cpuid_update,
>  
> -	.pt_supported = svm_pt_supported,
> -
>  	.set_supported_cpuid = svm_set_supported_cpuid,
>  
>  	.has_wbinvd_exit = svm_has_wbinvd_exit,
> diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> index 34a3a17bb6d7..d8f5cb312b9d 100644
> --- a/arch/x86/kvm/vmx/pmu_intel.c
> +++ b/arch/x86/kvm/vmx/pmu_intel.c
> @@ -330,7 +330,7 @@ static void intel_pmu_refresh(struct kvm_vcpu *vcpu)
>  	pmu->global_ovf_ctrl_mask = pmu->global_ctrl_mask
>  			& ~(MSR_CORE_PERF_GLOBAL_OVF_CTRL_OVF_BUF |
>  			    MSR_CORE_PERF_GLOBAL_OVF_CTRL_COND_CHGD);
> -	if (kvm_x86_ops->pt_supported())
> +	if (vmx_pt_mode_is_host_guest())
>  		pmu->global_ovf_ctrl_mask &=
>  				~MSR_CORE_PERF_GLOBAL_OVF_CTRL_TRACE_TOPA_PMI;
>  
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 98d54cfa0cbe..e6284b6aac56 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -6283,11 +6283,6 @@ static bool vmx_has_emulated_msr(int index)
>  	}
>  }
>  
> -static bool vmx_pt_supported(void)
> -{
> -	return vmx_pt_mode_is_host_guest();
> -}
> -
>  static void vmx_recover_nmi_blocking(struct vcpu_vmx *vmx)
>  {
>  	u32 exit_intr_info;
> @@ -7876,7 +7871,6 @@ static struct kvm_x86_ops vmx_x86_ops __ro_after_init = {
>  
>  	.check_intercept = vmx_check_intercept,
>  	.handle_exit_irqoff = vmx_handle_exit_irqoff,
> -	.pt_supported = vmx_pt_supported,
>  
>  	.request_immediate_exit = vmx_request_immediate_exit,
>  
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9d38dcdbb613..144143a57d0b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -2805,10 +2805,9 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
>  		    !guest_cpuid_has(vcpu, X86_FEATURE_XSAVES))
>  			return 1;
>  		/*
> -		 * We do support PT if kvm_x86_ops->pt_supported(), but we do
> -		 * not support IA32_XSS[bit 8]. Guests will have to use
> -		 * RDMSR/WRMSR rather than XSAVES/XRSTORS to save/restore PT
> -		 * MSRs.
> +		 * KVM supports exposing PT to the guest, but does not support
> +		 * IA32_XSS[bit 8]. Guests have to use RDMSR/WRMSR rather than
> +		 * XSAVES/XRSTORS to save/restore PT MSRs.

So the responsibility shifts from vague 'we' to KVM. There should be
a juridical term for that :-)

>  		 */
>  		if (data != 0)
>  			return 1;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

