Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE0B4C33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B08F92080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 12:55:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SIokP/4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727948AbgBCMzq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 07:55:46 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60390 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727363AbgBCMzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 07:55:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580734545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PKYTrZ2l9XDKCKxWTKQUHgKqQscinAEepYElS6s2GdY=;
        b=SIokP/4k8YXaNP8VfOxcFfjIMETcnAGsfTLJHR7TeG1WdbDc42mDD/xk7g6sNJkBaH4DR/
        1bSoryeOklpH/TRqBBLUcCca9akNtZAQaPOh5PVZSX2wsG2TflarnYaEKg0inciOmQGn90
        n2mUy6ob38ikgkKDqNPbN8qwYbVaWNI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-6oJMEh-NPLyBdjksCiTeFw-1; Mon, 03 Feb 2020 07:55:43 -0500
X-MC-Unique: 6oJMEh-NPLyBdjksCiTeFw-1
Received: by mail-wm1-f70.google.com with SMTP id l11so4890076wmi.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 04:55:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PKYTrZ2l9XDKCKxWTKQUHgKqQscinAEepYElS6s2GdY=;
        b=U0F1uQy8yjoZx4OLQMFx5bgSuyxEaGqI5PB3q8mPrPjSLUaq6T2A0ZExWZBfCBvgq5
         mnF/lVcjoNArthaw4L90gpgBMJ+KWNQ46AnaKGWx2mH36DnBQ7PBxs9CkhwFeRcgkAiW
         LdFOHE9EwPUHiA6B270/ZestBogxVO9I7OF0lHniqtPsPtsfyXYrWTXl9d+pDYZ8UPCm
         Z3YnBqNQkQoFkRSEOAr1AIgVzSK8We92+J3eeE8hoWkXD/QWQzvdnLg+/rpZQNnsog0w
         +7M1XACsQjPvn3ib/QTyxnCr0DzGrz/G/3TxDE3Mv4Nt/N5vJaFmNVZEngtEBhtu/pIo
         oXvQ==
X-Gm-Message-State: APjAAAXovKSg8k+YnTRB0PdZ65OkeaBc+8nE0INYGOcAiE+Zj6zqRJSM
        sMxbkX0Av9zbljxMx45oVDr5y8SoLCJVAotbTylggOl+dLWL6uJHSYabtvK4B9NdaB9cqR/jvXP
        r87JzHnk3jfiNMtIo3nYJW0xA
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr15561241wrr.208.1580734541934;
        Mon, 03 Feb 2020 04:55:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqzuXwumKXy69ZvsnWkYM1n/3TsEHbX5cfQn3xjEJOebm44QI5GW+cGW67maRdHtBrct5bZLYg==
X-Received: by 2002:adf:fd8d:: with SMTP id d13mr15561190wrr.208.1580734541492;
        Mon, 03 Feb 2020 04:55:41 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id r5sm25434161wrt.43.2020.02.03.04.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 04:55:40 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 01/61] KVM: x86: Return -E2BIG when KVM_GET_SUPPORTED_CPUID hits max entries
In-Reply-To: <20200201185218.24473-2-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-2-sean.j.christopherson@intel.com>
Date:   Mon, 03 Feb 2020 13:55:40 +0100
Message-ID: <87mu9zomnn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Fix a long-standing bug that causes KVM to return 0 instead of -E2BIG
> when userspace's array is insufficiently sized.
>
> Note, while the Fixes: tag is accurate with respect to the immediate
> bug, it's likely that similar bugs in KVM_GET_SUPPORTED_CPUID existed
> prior to the refactoring, e.g. Qemu contains a workaround for the broken
> KVM_GET_SUPPORTED_CPUID behavior that predates the buggy commit by over
> two years.  The Qemu workaround is also likely the main reason the bug
> has gone unreported for so long.
>
> Qemu hack:
>   commit 76ae317f7c16aec6b469604b1764094870a75470
>   Author: Mark McLoughlin <markmc@redhat.com>
>   Date:   Tue May 19 18:55:21 2009 +0100
>
>     kvm: work around supported cpuid ioctl() brokenness
>
>     KVM_GET_SUPPORTED_CPUID has been known to fail to return -E2BIG
>     when it runs out of entries. Detect this by always trying again
>     with a bigger table if the ioctl() fills the table.
>
> Fixes: 831bf664e9c1f ("KVM: Refactor and simplify kvm_dev_ioctl_get_supported_cpuid")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index b1c469446b07..47ce04762c20 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -908,9 +908,14 @@ int kvm_dev_ioctl_get_cpuid(struct kvm_cpuid2 *cpuid,
>  			goto out_free;
>  
>  		limit = cpuid_entries[nent - 1].eax;
> -		for (func = ent->func + 1; func <= limit && nent < cpuid->nent && r == 0; ++func)
> +		for (func = ent->func + 1; func <= limit && r == 0; ++func) {
> +			if (nent >= cpuid->nent) {
> +				r = -E2BIG;
> +				goto out_free;
> +			}
>  			r = do_cpuid_func(&cpuid_entries[nent], func,
>  				          &nent, cpuid->nent, type);
> +		}
>  
>  		if (r)
>  			goto out_free;

Is fixing a bug a valid reason for breaking buggy userspace? :-)
Personally, I think so. In particular, here the change is both the
return value and the fact that we don't do copy_to_user() anymore so I
think it's possible to meet a userspace which is going to get broken by
the change.

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

