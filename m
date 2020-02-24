Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3414C38BFA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6245A2176D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 21:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUGvNGdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727851AbgBXVkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 16:40:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34201 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726980AbgBXVkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:40:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582580405;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HwqZJARxRtRIRsN5GhreVrbXKnfWNifv1uOgK9YLuVA=;
        b=dUGvNGdIGZTdFlH4sSYcZhtx295Ms6hGtUoXVZNucEEQq24K5CU7vlBEu94xcRckWy44LY
        rfVizYT49AWBBcdChbX48gjxbgUZQHcULuGkBjK6Ug6R8DNfmRvFIOXoB2wbitiZFLJ+EB
        Ohx71jV9ATU720k6o7qBCS6Zn4yBIuo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-HBysicJbPPCBnAKW5cNP4Q-1; Mon, 24 Feb 2020 16:40:03 -0500
X-MC-Unique: HBysicJbPPCBnAKW5cNP4Q-1
Received: by mail-wm1-f71.google.com with SMTP id o24so294879wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 13:40:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HwqZJARxRtRIRsN5GhreVrbXKnfWNifv1uOgK9YLuVA=;
        b=Ocne1EW9h5XlfmLg8VUBICmJYnidd4NWIazx475Xcl1HWvBuGBgsXwTOxtbdDmdqFg
         6VS4viFEi+pYbwtVCR7FRjTD3Wwhz4HUdL2036ccne38Zuv7qNtUnj4E0eS3LA74zvzu
         3hfal/QO3MV7W9uLZ8YPZ3pRKEK9Ya+srAlB/JFcF444iOCRGJq4j6Ef+C0/3/a50lIC
         Kmz3R0tqeunbVU2lDUWykteLPLFCUp9M5a64zNMZLfADzTxgtoaPU6asuNDPTH9QoZe8
         kF+4deCgifHuUhea7Y5pgwHAHAAKxiILJRYOUWvMf4qiBdWNca/iWzsrJ0qKz1zAGpoC
         WEgg==
X-Gm-Message-State: APjAAAVcYGY2ZMl3sO86YAOIVwIuY9kHITGQ07E4GmDflsvJv07MW60x
        bp515VDoMcHiIpXYPN4G/jyJ+ZUHzMbnRE7GU1WWQmN//rYByWO9WbmUnWRe5UIcWQ+nD3aPA9U
        KCmpVbYP/VtuhJ1pNomOguBmg
X-Received: by 2002:a1c:98d5:: with SMTP id a204mr999072wme.181.1582580402181;
        Mon, 24 Feb 2020 13:40:02 -0800 (PST)
X-Google-Smtp-Source: APXvYqyJ4hW1d51c+RM1mLhv2OXN8Kb2v1Kn3sIHSnFji11MZqwtCEKB9+CY6WgGaeUcYkeNQcd7HA==
X-Received: by 2002:a1c:98d5:: with SMTP id a204mr999054wme.181.1582580401902;
        Mon, 24 Feb 2020 13:40:01 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 16sm1037653wmi.0.2020.02.24.13.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 13:40:01 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 40/61] KVM: VMX: Convert feature updates from CPUID to KVM cpu caps
In-Reply-To: <20200201185218.24473-41-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-41-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 22:40:00 +0100
Message-ID: <87blpnoea7.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use the recently introduced KVM CPU caps to propagate VMX-only (kernel)
> settings to supported CPUID flags.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 51 ++++++++++++++++++++++++------------------
>  1 file changed, 29 insertions(+), 22 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index 11b9c1e7e520..bae915431c72 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7102,37 +7102,42 @@ static void vmx_cpuid_update(struct kvm_vcpu *vcpu)
>  static void vmx_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
>  	switch (entry->function) {
> -	case 0x1:
> -		if (nested)
> -			cpuid_entry_set(entry, X86_FEATURE_VMX);
> -		break;
>  	case 0x7:
> -		if (boot_cpu_has(X86_FEATURE_MPX) && kvm_mpx_supported())
> -			cpuid_entry_set(entry, X86_FEATURE_MPX);
> -		if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_has_vmx_invpcid())
> -			cpuid_entry_set(entry, X86_FEATURE_INVPCID);
> -		if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
> -		    vmx_pt_mode_is_host_guest())
> -			cpuid_entry_set(entry, X86_FEATURE_INTEL_PT);
>  		if (vmx_umip_emulated())
>  			cpuid_entry_set(entry, X86_FEATURE_UMIP);
> -
> -		/* PKU is not yet implemented for shadow paging. */
> -		if (enable_ept && boot_cpu_has(X86_FEATURE_PKU) &&
> -		    boot_cpu_has(X86_FEATURE_OSPKE))
> -			cpuid_entry_set(entry, X86_FEATURE_PKU);
> -		break;
> -	case 0x80000001:
> -		if (!cpu_has_vmx_rdtscp())
> -			cpuid_entry_clear(entry, X86_FEATURE_RDTSCP);
> -		if (enable_ept && !cpu_has_vmx_ept_1g_page())
> -			cpuid_entry_clear(entry, X86_FEATURE_GBPAGES);
>  		break;
>  	default:
>  		break;
>  	}
>  }
>  

Same comment as for svm: I think someone may not understand what goes
where, i.e. the separation between vmx_set_supported_cpuid() and
vmx_set_cpu_caps().

> +static __init void vmx_set_cpu_caps(void)
> +{
> +	/* CPUID 0x1 */
> +	if (nested)
> +		kvm_cpu_cap_set(X86_FEATURE_VMX);
> +
> +	/* CPUID 0x7 */
> +	if (boot_cpu_has(X86_FEATURE_MPX) && kvm_mpx_supported())
> +		kvm_cpu_cap_set(X86_FEATURE_MPX);
> +	if (boot_cpu_has(X86_FEATURE_INVPCID) && cpu_has_vmx_invpcid())
> +		kvm_cpu_cap_set(X86_FEATURE_INVPCID);
> +	if (boot_cpu_has(X86_FEATURE_INTEL_PT) &&
> +	    vmx_pt_mode_is_host_guest())
> +		kvm_cpu_cap_set(X86_FEATURE_INTEL_PT);
> +
> +	/* PKU is not yet implemented for shadow paging. */
> +	if (enable_ept && boot_cpu_has(X86_FEATURE_PKU) &&
> +	    boot_cpu_has(X86_FEATURE_OSPKE))
> +		kvm_cpu_cap_set(X86_FEATURE_PKU);
> +
> +	/* CPUID 0x80000001 */
> +	if (!cpu_has_vmx_rdtscp())
> +		kvm_cpu_cap_clear(X86_FEATURE_RDTSCP);
> +	if (enable_ept && !cpu_has_vmx_ept_1g_page())
> +		kvm_cpu_cap_clear(X86_FEATURE_GBPAGES);
> +}
> +
>  static void vmx_request_immediate_exit(struct kvm_vcpu *vcpu)
>  {
>  	to_vmx(vcpu)->req_immediate_exit = true;
> @@ -7750,6 +7755,8 @@ static __init int hardware_setup(void)
>  			return r;
>  	}
>  
> +	vmx_set_cpu_caps();
> +
>  	r = alloc_kvm_area();
>  	if (r)
>  		nested_vmx_hardware_unsetup();

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

