Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68F2C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD2B620720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:48:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P18eL/rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727144AbgBGPsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:48:33 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58080 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727011AbgBGPsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:48:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581090511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xwuFs+d8bJwJhhJOajzZNm6jYesIdXdjH4QKPI8LzcM=;
        b=P18eL/rgRuHhNRUcsCwKyryelGj3fitFphsX5JO9r31d6eppzM7cl1SWyZHuxTyO0GTc4z
        GIxW6bidRnglkYlCFG7qsDrjdOvxI+NsXonwTfsGTJPjbmHohX2eZcqdKCmket1Yl/ODgH
        nc3GSf3jmt1cseVeaK82sPFzSmY7ey0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-2UMLorFfMCW620sk2jAu_w-1; Fri, 07 Feb 2020 10:48:25 -0500
X-MC-Unique: 2UMLorFfMCW620sk2jAu_w-1
Received: by mail-wm1-f71.google.com with SMTP id n17so884737wmk.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:48:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xwuFs+d8bJwJhhJOajzZNm6jYesIdXdjH4QKPI8LzcM=;
        b=N82hTib9a2H0BluumnWGyCaY1EWNuLo6Tjpkg2vt3msfX+veLtA95q2t4IqyoZBjYb
         w/A1N1PdhENCVbHFiCrHlj4TbLafsfg5EzZgZ/OgLOaJTCtBE8pFlquRembGPg+N2lmw
         eF8hzge+kgE6D61PEIgGRdoDE9iyQGcTK9c7y1kZP3WXl97SMt6EZ6bBjprHnCgbbqWV
         KtajnBKYyVKjQWuNdlKqJYz+L8Y1W7dtuOL8hbxb217eCRb5/8puF5e/TIwuUQQowwDg
         Q7VQlL7+1ixtawVfMrK8AMVxqGJ+9uper6XaWDYO5Aa5zBdOL38VCmp+rMYzAtJzgbCL
         7aKg==
X-Gm-Message-State: APjAAAURHmI8Uv6q4vAWyqIS1bs15NqehBa3KeKOfh3pKr6jaaT3ckJQ
        2JwLk7DkscvN+lJ3kb1AHmwbkOdMNH0HrFXEleJRLCCzoQquwDFkoYrThl8h7AQjGNcwBt/30Jo
        2j7Tc15OjKpIGhliLgD8Y/vFD
X-Received: by 2002:adf:cd04:: with SMTP id w4mr5631190wrm.219.1581090504065;
        Fri, 07 Feb 2020 07:48:24 -0800 (PST)
X-Google-Smtp-Source: APXvYqz41NVY/PedM9n7Ys7gSqcfGjqvwYpzjm3X6C/T7/jBpkYp83BGA/BjCIhF9v9j1utS1ZenLA==
X-Received: by 2002:adf:cd04:: with SMTP id w4mr5631171wrm.219.1581090503877;
        Fri, 07 Feb 2020 07:48:23 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a22sm3922661wmd.20.2020.02.07.07.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:48:23 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 07/61] KVM: x86: Check for CPUID 0xD.N support before validating array size
In-Reply-To: <20200201185218.24473-8-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-8-sean.j.christopherson@intel.com>
Date:   Fri, 07 Feb 2020 16:48:22 +0100
Message-ID: <87eev6qtyx.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Now that sub-leaf 1 is handled separately, verify the next sub-leaf is
> needed before rejecting KVM_GET_SUPPORTED_CPUID due to an insufficiently
> sized userspace array.
>
> Note, although this is technically a bug, it's not visible to userspace
> as KVM_GET_SUPPORTED_CPUID is guaranteed to fail on KVM_CPUID_SIGNATURE,
> which is hardcoded to be added after leaf 0xD.  The real motivation for
> the change is to tightly couple the nent/maxnent and do_host_cpuid()
> sequences in preparation for future cleanup.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fc8540596386..fd9b29aa7abc 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -670,13 +670,14 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  		entry[1].edx = 0;
>  
>  		for (idx = 2, i = 2; idx < 64; ++idx) {
> -			u64 mask = ((u64)1 << idx);
> +			if (!(supported & BIT_ULL(idx)))
> +				continue;
>  
>  			if (*nent >= maxnent)
>  				goto out;
>  
>  			do_host_cpuid(&entry[i], function, idx);
> -			if (entry[i].eax == 0 || !(supported & mask))
> +			if (entry[i].eax == 0)
>  				continue;
>  			if (WARN_ON_ONCE(entry[i].ecx & 1))
>  				continue;

The remaining WARN_ON_ONCE() is technically the same 'bug not visible to
userspace' :-)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

