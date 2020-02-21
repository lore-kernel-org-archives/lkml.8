Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6AB8C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:19:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B3A22073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 13:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WVfdunyS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728595AbgBUNTP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 08:19:15 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26272 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728429AbgBUNTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 08:19:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582291154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdrOYqkSU4Wmaj+eD3HBzwtajuhTDrg8MaBJeipWbtU=;
        b=WVfdunyS+iQgQqj/FiEr85d07ajgJPrNb1GAVZ0um/xH1K4RQDZA0lfgI5pbzPg4BtPkuE
        AIzvacV/F+QpQkYkA+o2mJSPVG8TsnTND+07G0cCpXzg/EyxiMjUeTi7DfNbNfB1EdfrB7
        btTZ6E1Akzxuxq2ouBL40J1nznEh+g4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-369-5ZGQXkJgP1CYCHUapl66dA-1; Fri, 21 Feb 2020 08:19:12 -0500
X-MC-Unique: 5ZGQXkJgP1CYCHUapl66dA-1
Received: by mail-wm1-f69.google.com with SMTP id w12so604958wmc.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 05:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=AdrOYqkSU4Wmaj+eD3HBzwtajuhTDrg8MaBJeipWbtU=;
        b=Dx1a/BxxseKrBuNn7QUzOQWYXBBIucUNPVz03DysF9p4yf1pkOKS4EBuZ+VtUrOcLD
         rq54zIEAWk9p7ODdwRmhGk8vtTMvZUHXXaL/GF675gcMkXQQPMg0thkd30sOZ6UX6D8e
         NRdr47+6fIFFECu5s9Ilcc9dCDgjLk0+93nlQj5FJwd6MVjQ79aNpm/So/rIFduTgVWZ
         wuU0rlylMxqWiOepepjaUJfUNRsyrlpJAdMFBTflDe0M5pyYHv7X+qXHIi43soDKSUMq
         7KXvixFj0W2pxq5XWjd/vCR0HVuvmaFtza+ea6GVDCttxWDZTFRSQ22HPOdg7JwQMXgc
         dzzQ==
X-Gm-Message-State: APjAAAVKtdHiglPmkQTPYi5C/Ah9/QH6dyC6J5y8qnvsMPKHzfMkGRtb
        UIAsdlFbXBevPciDU/TFZ/a4gHvwtQzwy4zOlY38N9lrHaJnaj8Bp5Yl0EO6sEETIeQxKz1LIzO
        xlqyfeXlxuo273vnqlaDmAq2u
X-Received: by 2002:adf:b605:: with SMTP id f5mr46530396wre.383.1582291150139;
        Fri, 21 Feb 2020 05:19:10 -0800 (PST)
X-Google-Smtp-Source: APXvYqwZgsSg1tJW0LXXQ30+pBrMKifzSKh5zC/Nh60dphjMDektmaCW99rVjZMhtN7yCmVhzpu/9g==
X-Received: by 2002:adf:b605:: with SMTP id f5mr46530377wre.383.1582291149938;
        Fri, 21 Feb 2020 05:19:09 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s22sm3632247wmh.4.2020.02.21.05.19.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 05:19:09 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] KVM: VMX: Move vpid_sync_vcpu_addr() down a few lines
In-Reply-To: <20200220204356.8837-3-sean.j.christopherson@intel.com>
References: <20200220204356.8837-1-sean.j.christopherson@intel.com> <20200220204356.8837-3-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 14:19:08 +0100
Message-ID: <875zg0t6wj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Move vpid_sync_vcpu_addr() below vpid_sync_context() so that it can be
> refactored in a future patch to call vpid_sync_context() directly when
> the "individual address" INVVPID variant isn't supported.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/ops.h | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/ops.h b/arch/x86/kvm/vmx/ops.h
> index 45eaedee2ac0..a2b0689e65e3 100644
> --- a/arch/x86/kvm/vmx/ops.h
> +++ b/arch/x86/kvm/vmx/ops.h
> @@ -253,19 +253,6 @@ static inline void __invept(unsigned long ext, u64 eptp, gpa_t gpa)
>  	vmx_asm2(invept, "r"(ext), "m"(operand), ext, eptp, gpa);
>  }
>  
> -static inline bool vpid_sync_vcpu_addr(int vpid, gva_t addr)
> -{
> -	if (vpid == 0)
> -		return true;
> -
> -	if (cpu_has_vmx_invvpid_individual_addr()) {
> -		__invvpid(VMX_VPID_EXTENT_INDIVIDUAL_ADDR, vpid, addr);
> -		return true;
> -	}
> -
> -	return false;
> -}
> -
>  static inline void vpid_sync_vcpu_single(int vpid)
>  {
>  	if (vpid == 0)
> @@ -289,6 +276,19 @@ static inline void vpid_sync_context(int vpid)
>  		vpid_sync_vcpu_global();
>  }
>  
> +static inline bool vpid_sync_vcpu_addr(int vpid, gva_t addr)
> +{
> +	if (vpid == 0)
> +		return true;
> +
> +	if (cpu_has_vmx_invvpid_individual_addr()) {
> +		__invvpid(VMX_VPID_EXTENT_INDIVIDUAL_ADDR, vpid, addr);
> +		return true;
> +	}
> +
> +	return false;
> +}
> +
>  static inline void ept_sync_global(void)
>  {
>  	__invept(VMX_EPT_EXTENT_GLOBAL, 0, 0);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

