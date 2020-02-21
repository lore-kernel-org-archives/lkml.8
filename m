Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3601EC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A7D424650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i2/lRd9r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729084AbgBUPFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:05:02 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57297 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728910AbgBUPFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582297500;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yTmEd9xc6G7csgDjNYZkoTzDRVdt6RCq+o8/c5+8RkI=;
        b=i2/lRd9rd987aQMqOfkjJ7e2uExOVzLtVcItZUKHOoxhqKtUhmP0gKK1QRcr+iaVZEznyd
        ziHLbXitp79S+7fGAotG+6repb6P4X26i3wH7ORWlsmvDGcw2XytPLl0BWphJg3IO6l+aC
        oOLk7aGQzkZH52IInEcG5llAqMoGXjM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-tHg_yO-fMpG1mGzmGEvvqg-1; Fri, 21 Feb 2020 10:04:57 -0500
X-MC-Unique: tHg_yO-fMpG1mGzmGEvvqg-1
Received: by mail-wm1-f69.google.com with SMTP id p2so717583wmi.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 07:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yTmEd9xc6G7csgDjNYZkoTzDRVdt6RCq+o8/c5+8RkI=;
        b=uBDJ6PT6c3DWFayNcriAUOUlG/25/S+yVfNCd4X/UPntopX2YxgleciRnbd2ak1koA
         r6fkmejSItRUoW0fE0to9Lwm/Ww7NtIszWjOEuwnjbxae6zqaIbnj96Hg2W4wd1dkOZW
         bCpZ4A0Ordx/YcebVFOD71Itsja1N5ltiTUv/wRuZdEJDpz9bb6NbcYSZDtD7Y/TzXhY
         jrWPhKrfZEoXcRFkVmnaNc2/YVjxqjF81I3cePq3QxB2yqUwU9BhQR5S+O/jI1mWYZ3e
         /xRV16ILWjbGgGZHyAnaR53kaoO1UHEcxMdA6Mkr31gJ3LtDgemmv/AcNTIrdH/sARg+
         YH5g==
X-Gm-Message-State: APjAAAUnsU3BWX5hL7o5PDvN6TI9wkAjlsw1j3LnVSCCQ8mk+0xF4GPw
        ww2RZNzbWWj4YWCs64gkBk1A58Wwrxm0G47Y6hC0Al2OckIUGd1p584jur0pkv5Z9ePSGZ/4Clh
        JM5469RfZyPuDIcMtwY/LwHMk
X-Received: by 2002:a5d:5647:: with SMTP id j7mr49375693wrw.265.1582297495746;
        Fri, 21 Feb 2020 07:04:55 -0800 (PST)
X-Google-Smtp-Source: APXvYqyi44kZL/ZGQMOMG/lXjt2ZRHdP4xnGFQQxWU89Ax6rGaeN+aFAthHOQCoYiqw1R5vHV/3FXA==
X-Received: by 2002:a5d:5647:: with SMTP id j7mr49375673wrw.265.1582297495544;
        Fri, 21 Feb 2020 07:04:55 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a26sm4147958wmm.18.2020.02.21.07.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 07:04:55 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/61] KVM: x86: Use common loop iterator when handling CPUID 0xD.N
In-Reply-To: <20200201185218.24473-19-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-19-sean.j.christopherson@intel.com>
Date:   Fri, 21 Feb 2020 16:04:54 +0100
Message-ID: <87sgj4q8vd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Use __do_cpuid_func()'s common loop iterator, "i", when enumerating the
> sub-leafs for CPUID 0xD now that the CPUID 0xD loop doesn't need to
> manual maintain separate counts for the entries index and CPUID index.
>
> No functional changed intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index 6516fec361c1..bfd8304a8437 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -634,7 +634,6 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		}
>  		break;
>  	case 0xd: {
> -		int idx;
>  		u64 supported = kvm_supported_xcr0();
>  
>  		entry->eax &= supported;
> @@ -658,11 +657,11 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
>  		entry->ecx = 0;
>  		entry->edx = 0;
>  
> -		for (idx = 2; idx < 64; ++idx) {
> -			if (!(supported & BIT_ULL(idx)))
> +		for (i = 2; i < 64; ++i) {
> +			if (!(supported & BIT_ULL(i)))
>  				continue;
>  
> -			entry = do_host_cpuid(array, function, idx);
> +			entry = do_host_cpuid(array, function, i);
>  			if (!entry)
>  				goto out;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

