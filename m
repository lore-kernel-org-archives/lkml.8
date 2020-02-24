Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CBCC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 874102072D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 15:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H+4WphPj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgBXPjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 10:39:13 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:21088 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727736AbgBXPjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 10:39:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582558752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ddo4zTy9kohv7vcxaNjRWh45qs6RB8g9+hhdp7Haxl4=;
        b=H+4WphPjcCMnx+NQmv5Fv15WngycdSL6jow4e0VqzKbHSthsY/qFMFmoVIonF0SkBd5Gvc
        J+L7G2Uq8TTDRyF6c7BnNIHfbcPyLqtoxp1TyBsvvMht8aZqXLSGGoHo+VvC6PcsnC3c0J
        so1+Ni+B5kvhWBTTd/Mwr4Ih8qXXLn0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-NMVPgppZO7ynxEJtP_w_Xg-1; Mon, 24 Feb 2020 10:39:10 -0500
X-MC-Unique: NMVPgppZO7ynxEJtP_w_Xg-1
Received: by mail-wr1-f72.google.com with SMTP id n23so5758633wra.20
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 07:39:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ddo4zTy9kohv7vcxaNjRWh45qs6RB8g9+hhdp7Haxl4=;
        b=Q29yh7Y13VX3XvWWjjQZN4RGSp07oKy6Hf7Y3NOLPd89nqE8TXKnMg9HSAmpif/Ayf
         NvhkrZxv7tc1Vlt69b3kd63sbE+k5KHOg98b0WJbacAgYk8P9Ly7yWoQ/Gz3yRKrxgNy
         TEmBAW/ERPx0ZauwN3dGebrjLTNNoq2YGH3mVc/ndc6+/QQiyjsTfLDo2Ut5l2EfEaH1
         1GXcng72q/lBP3NTCELbDW+5GpbdggM1wH5A3TX+dkEyI4BIMb1gIMr6VPP3QHWXSska
         RoGYc3JC8FFmc8aimhnFmn1woqloev6EycXBORoJQjWI+FnWlLjZwyKeO+t6mwT5cjGq
         oNww==
X-Gm-Message-State: APjAAAVNWEogd50qkE/ScuIQ8mMXU/ZpGtnCJIksj0+4VJJBkanN+6g7
        uZ2zRKAFjgMFboQZxA/pNZaEepzNdfL3mkQ10mnA18XJzHQerrg1Z2qtJOBwQd5ser0YBcrXozj
        2xF3GFBM/odVD17hQ4YaobP4M
X-Received: by 2002:adf:f586:: with SMTP id f6mr64690531wro.46.1582558748992;
        Mon, 24 Feb 2020 07:39:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/n0QwrYWVp/915whGBoyMjNRD9DraOLZjnMyIscER1XCgM5QXhvW6xCBl8B80g0y5p7Ffcg==
X-Received: by 2002:adf:f586:: with SMTP id f6mr64690519wro.46.1582558748783;
        Mon, 24 Feb 2020 07:39:08 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id m125sm19195001wmf.8.2020.02.24.07.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 07:39:08 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 37/61] KVM: x86: Refactor handling of XSAVES CPUID adjustment
In-Reply-To: <20200201185218.24473-38-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-38-sean.j.christopherson@intel.com>
Date:   Mon, 24 Feb 2020 16:39:07 +0100
Message-ID: <87k14cngf8.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Invert the handling of XSAVES, i.e. set it based on boot_cpu_has() by
> default, in preparation for adding KVM cpu caps, which will generate the
> mask at load time before ->xsaves_supported() is ready.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index c74253202af8..20a7af320291 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -422,7 +422,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  	unsigned f_gbpages = 0;
>  	unsigned f_lm = 0;
>  #endif
> -	unsigned f_xsaves = kvm_x86_ops->xsaves_supported() ? F(XSAVES) : 0;
>  	unsigned f_intel_pt = kvm_x86_ops->pt_supported() ? F(INTEL_PT) : 0;
>  
>  	/* cpuid 1.edx */
> @@ -479,7 +478,7 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  
>  	/* cpuid 0xD.1.eax */
>  	const u32 kvm_cpuid_D_1_eax_x86_features =
> -		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | f_xsaves;
> +		F(XSAVEOPT) | F(XSAVEC) | F(XGETBV1) | F(XSAVES);
>  
>  	/* all calls to cpuid_count() should be made on the same cpu */
>  	get_cpu();
> @@ -610,6 +609,10 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  
>  		entry->eax &= kvm_cpuid_D_1_eax_x86_features;
>  		cpuid_entry_mask(entry, CPUID_D_1_EAX);
> +
> +		if (!kvm_x86_ops->xsaves_supported())
> +			cpuid_entry_clear(entry, X86_FEATURE_XSAVES);
> +
>  		if (entry->eax & (F(XSAVES)|F(XSAVEC)))
>  			entry->ebx = xstate_required_size(supported_xcr0, true);
>  		else

I was going to ask if this can be moved to set_supported_cpuid() for
both VMX and SVM but then I realized this is just a temporary change.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

