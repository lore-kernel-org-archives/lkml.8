Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2805C35647
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7677208C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vyg4b1yl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728081AbgBUNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:39:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46968 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727039AbgBUNj4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:39:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582292396;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVK/xgaNWuLk79HGiCMg7vGaUeaBKpy3vV1cOoNHUbo=;
        b=Vyg4b1ylD6ngFD4zjodg3iRsY1MTdErrh8LxTKVuFouMVuHxIS+X80bHxgEUJbSQR8CSlF
        k3hd71JYMk9CtKQfhaoC9qF3hPlrT/lGYFrP7Z3Rb/CC3kuCHfl5f3xO7rbebjeKqg00Au
        t9QLtip4eIt3HJ4Vk1rTc2dR2L4u68M=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-MtEq419RNs26p7jqXvs5zw-1; Fri, 21 Feb 2020 08:39:54 -0500
X-MC-Unique: MtEq419RNs26p7jqXvs5zw-1
Received: by mail-wm1-f69.google.com with SMTP id p2so619000wmi.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:39:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=HVK/xgaNWuLk79HGiCMg7vGaUeaBKpy3vV1cOoNHUbo=;
        b=IDgcNPsq2nfCL7GbdpjH2fN3Re+tsQ67lT/J35H9le2eVGy8JHo5ElOoeCDI8PCN2m
         boW+Mt4Ddg9/ZhisdRZbik0gUaTkyQo4nTQSDNN3z/VlcDJ+g7uQpYfUo+hVusDqLSdz
         cZKzxSAQMjDvLPGLkdqOSF6W+bhNYb37ke6WGO2NGn4k5nzrJrCT+KEjPKAx8SWIYAIN
         GkC//JI7oFKvkOQ3jv59h0rJOVBd+ads7deG3p8W+e7HuTWeSHda2sqkmtuxd+kc5TkO
         SiyGGXFXDbm96QqI4nNGP1yx/PXRhNQbEH+auqJ36tTjtycoykYeKaSTsxEus2YjSX+W
         7KGw==
X-Gm-Message-State: APjAAAX/0eTOTUajAqRPTeHGrU7aWHpTJmU95FAenNRisBolOfVP8vRz
        Mt3+0Zh+sy2EQHttxS0m95BwJ9gPtFYvScxwOBVnVSAnh/pdGd+e1ySrJuqS1Ih/rG3ckTJmxaj
        Tv9j3D0hVqzlhZAHVMrubBVMx
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr3980078wmm.143.1582292393000;
        Fri, 21 Feb 2020 05:39:53 -0800 (PST)
X-Google-Smtp-Source: APXvYqweFS40c6w6buHNjWyY/RUC5Ssm8VeFlafDjUQ1BIIViezUuUq9RDSemCDXg7Eh/GSmKzbIgg==
X-Received: by 2002:a05:600c:224a:: with SMTP id a10mr3980059wmm.143.1582292392740;
        Fri, 21 Feb 2020 05:39:52 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id q3sm3619639wmj.38.2020.02.21.05.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:39:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] KVM: VMX: Fold vpid_sync_vcpu_{single,global}() into vpid_sync_context()
In-Reply-To: <20200220204356.8837-5-sean.j.christopherson@intel.com>
References: <20200220204356.8837-1-sean.j.christopherson@intel.com> <20200220204356.8837-5-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 14:39:51 +0100
Message-ID: <87zhdcrrdk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Fold vpid_sync_vcpu_global() and vpid_sync_vcpu_single() into their sole
> caller.  KVM should always prefer the single variant, i.e. the only
> reason to use the global variant is if the CPU doesn't support
> invalidating a single VPID, which is the entire purpose of wrapping the
> calls with vpid_sync_context().
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/ops.h | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
> index 612df1bdb26b..eb6adc77a55d 100644
> --- a/arch/x86/kvm/vmx/ops.h
> +++ b/arch/x86/kvm/vmx/ops.h
> @@ -253,29 +253,17 @@ static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
>  	vmx_asm2(invept, "r"(ext), "m"(operand), ext, eptp, gpa);
>  }
>  
> -static inline void vpid_sync_vcpu_single(int vpid)
> +static inline void vpid_sync_context(int vpid)
>  {
>  	if (vpid == 0)
>  		return;
>  
>  	if (cpu_has_vmx_invvpid_single())
>  		__invvpid(VMX_VPID_EXTENT_SINGLE_CONTEXT, vpid, 0);
> -}
> -
> -static inline void vpid_sync_vcpu_global(void)
> -{
> -	if (cpu_has_vmx_invvpid_global())
> +	else
>  		__invvpid(VMX_VPID_EXTENT_ALL_CONTEXT, 0, 0);
>  }
>  
> -static inline void vpid_sync_context(int vpid)
> -{
> -	if (cpu_has_vmx_invvpid_single())
> -		vpid_sync_vcpu_single(vpid);
> -	else
> -		vpid_sync_vcpu_global();
> -}
> -
>  static inline void vpid_sync_vcpu_addr(int vpid, gva_t addr)
>  {
>  	if (vpid == 0)

In the original code it's only vpid_sync_vcpu_single() which has 'vpid
== 0' check, vpid_sync_vcpu_global() doesn't have it. So in the
hypothetical situation when cpu_has_vmx_invvpid_single() is false AND
we've e.g. exhausted our VPID space and allocate_vpid() returned zero,
the new code just won't do anything while the old one would've done
__invvpid(VMX_VPID_EXTENT_ALL_CONTEXT, 0, 0), right?

-- 
Vitaly

