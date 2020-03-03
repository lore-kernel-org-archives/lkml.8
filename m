Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91C3DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 674C820828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDLia4Yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgCCQMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:12:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57844 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728714AbgCCQMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:12:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583251928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ewMDLFJs+pwUVCPxSOpuH/6W8SJZrs4NnUYkU/1nly8=;
        b=GDLia4YlWwiv6C/cwqT16Xt42m/ApxCWxPZHxfZHGDhiNX9AUETbR/Gb0VJmA/v26yPFXd
        d3ZEsAEaWiX6JtI2eWcHUKtvmTpPGLuvQv8wlzZeIEpKHrMnR5X/1q9tVRCQPCCdAjvNiP
        S3Z1MEqDDyrecSVsqwoqVwP6gXXyiIA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-6EWraXSfN4aRgLSRUxbUUw-1; Tue, 03 Mar 2020 11:12:06 -0500
X-MC-Unique: 6EWraXSfN4aRgLSRUxbUUw-1
Received: by mail-wr1-f69.google.com with SMTP id w11so1423130wrp.20
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 08:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ewMDLFJs+pwUVCPxSOpuH/6W8SJZrs4NnUYkU/1nly8=;
        b=dHQXm5mHZDytiyBMsuJR8OTfPE0AxLgjofMrdLhiGW9PbkxI2srQES1vmB4K1f23FA
         IuYxAMrHqe20cGpXpkFh1okRiJeuNfLZJMPOh+vn5O9TKnFVxk2YPZ7gdcpYSy81htrU
         hh3O3rj0YIgARdf1V7zvK7fZ3NNsCArYE/NUuEtqzqFpsQpbt2qXEsCr1jo8ryc3Mvdq
         Y8NPDsjby8zAzuxQNDcvO7PbT8vhcbkX4rsvpEuTlCR7gagFalsgU80yQkDiMHxaNhhP
         OxIuvcVBRUEYXYohdAodyeknUwJYUrSoe1DYYtbUVhrwNEH+ja7VwtPjphiC2BZMUFHv
         k5Lg==
X-Gm-Message-State: ANhLgQ1be16ZBo2f+aH+vN/VzelDM5BA3yPtarU7PE6IOLExMNV5RBbi
        NkRFfHnl3ooeaZ+6NfUHnqaXlRVU8R8HGMLViq3pXW8HnNnlxUE165/HOhRCAeFP0bxidoxF9XS
        waszwel/O8yH10bUEsK/A3aeu
X-Received: by 2002:adf:b601:: with SMTP id f1mr6559895wre.103.1583251925507;
        Tue, 03 Mar 2020 08:12:05 -0800 (PST)
X-Google-Smtp-Source: ADFU+vs+gmDGERMF3k74BHUSenOqjl0DQn34XjlBAm+4vP34zz/YQPtfXpqrGLsflVDYehy+Smec6A==
X-Received: by 2002:adf:b601:: with SMTP id f1mr6559878wre.103.1583251925275;
        Tue, 03 Mar 2020 08:12:05 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id l5sm4806923wml.3.2020.03.03.08.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 08:12:04 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
Subject: Re: [PATCH v2 64/66] KVM: nSVM: Expose SVM features to L1 iff nested is enabled
In-Reply-To: <20200302235709.27467-65-sean.j.christopherson@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com> <20200302235709.27467-65-sean.j.christopherson@intel.com>
Date:   Tue, 03 Mar 2020 17:12:03 +0100
Message-ID: <878skhfmek.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Set SVM feature bits in KVM capabilities if and only if nested=true, KVM
> shouldn't advertise features that realistically can't be used.  Use
> kvm_cpu_cap_has(X86_FEATURE_SVM) to indirectly query "nested" in
> svm_set_supported_cpuid() in anticipation of moving CPUID 0x8000000A
> adjustments into common x86 code.
>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/svm.c | 22 +++++++++++++---------
>  1 file changed, 13 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index f32fc3c03667..8e39dcd3160d 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -1373,21 +1373,21 @@ static __init void svm_set_cpu_caps(void)
>  	if (avic)
>  		kvm_cpu_cap_clear(X86_FEATURE_X2APIC);
>  
> -	/* CPUID 0x80000001 */
> -	if (nested)
> +	/* CPUID 0x80000001 and 0x8000000A (SVM features) */
> +	if (nested) {
>  		kvm_cpu_cap_set(X86_FEATURE_SVM);
>  
> +		if (boot_cpu_has(X86_FEATURE_NRIPS))
> +			kvm_cpu_cap_set(X86_FEATURE_NRIPS);
> +
> +		if (npt_enabled)
> +			kvm_cpu_cap_set(X86_FEATURE_NPT);
> +	}
> +
>  	/* CPUID 0x80000008 */
>  	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
>  	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
>  		kvm_cpu_cap_set(X86_FEATURE_VIRT_SSBD);
> -
> -	/* CPUID 0x8000000A */
> -	/* Support next_rip if host supports it */
> -	kvm_cpu_cap_check_and_set(X86_FEATURE_NRIPS);
> -
> -	if (npt_enabled)
> -		kvm_cpu_cap_set(X86_FEATURE_NPT);
>  }
>  
>  static __init int svm_hardware_setup(void)
> @@ -6051,6 +6051,10 @@ static void svm_set_supported_cpuid(struct kvm_cpuid_entry2 *entry)
>  {
>  	switch (entry->function) {
>  	case 0x8000000A:
> +		if (!kvm_cpu_cap_has(X86_FEATURE_SVM)) {
> +			entry->eax = entry->ebx = entry->ecx = entry->edx = 0;
> +			break;
> +		}
>  		entry->eax = 1; /* SVM revision 1 */
>  		entry->ebx = 8; /* Lets support 8 ASIDs in case we add proper
>  				   ASID emulation to nested SVM */

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

