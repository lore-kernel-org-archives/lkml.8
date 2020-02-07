Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D310C04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14FCE20720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g92+jjcL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbgBGPiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:38:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38615 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727123AbgBGPiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:38:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581089889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yeuGyx1LYp/9evwWS6l3a4ujN4qYmz2YKlJpVfSsUqE=;
        b=g92+jjcLWyEeDAvv3156YRy3F3e4ET738p+CJcnkq7oMw2doqM3SWLzrvZVqTcge5sNsCa
        gTGVLGPIAX6EDqyHagc9DG9QDS62DRhLVNnwFyWIEgxJ7TNcC3cnIHn67wg+yI9pGoLu0/
        iFvkvmBRu4uZheEAR3hTUDroTIiF8z0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-GZFagP8GO3audfWekoFhug-1; Fri, 07 Feb 2020 10:38:08 -0500
X-MC-Unique: GZFagP8GO3audfWekoFhug-1
Received: by mail-wm1-f69.google.com with SMTP id q125so896243wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:38:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=yeuGyx1LYp/9evwWS6l3a4ujN4qYmz2YKlJpVfSsUqE=;
        b=r+FsqDWSEHIG0x7Xnysg+66tFd5zc7vrlA+2orX/8aurucdJs9SP3+yEEnGEeWcMkw
         Rh8J1LlajC2FuscBUZ2c+pnw1SgW67nLx3GhCZTyRfUpxtAPY1+YY0y2Sn2Z+500ySoa
         vRQWRWPkb7TeATAiphhP0alx7ZnTdwJVdoKk15GTOZ1e7OGIR/jP9FHXS4BVhiggPGf/
         L76B9zd35TO/L5mHuIC30dbeaHFjKk3Myvx+WhIok5Vawt5YjYPNH7Jx7rwz5omY3c1/
         cZ6rrSnKPaDjzIV+ktimMdI/mcIShoSqXiGe2PAJBlBHbF0P5BNraKzyVUdGH1bvsouk
         yJxQ==
X-Gm-Message-State: APjAAAV8o6S4Nz7vnA/RBb8M/a9xbjgKsV12Oj5cCI6R/xHrsICf/K2b
        AsKwnnwMURV7dhzyQk54AXUVx5uTxZBrBzdi43VlAsOvPx8YYJpAX/U8d0Rl1FMGqHrXjJ6nUwM
        gMCoym6c1p5/gx8QMjtntuEWA
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr5062941wml.110.1581089884200;
        Fri, 07 Feb 2020 07:38:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZ7AtqIkIwnjLWqR7E9sRTStC/xqmTP4CD5tgC2/SP8tFzBECx2Eupzy1OBKXCZC0jlLXNEQ==
X-Received: by 2002:a05:600c:214f:: with SMTP id v15mr5062923wml.110.1581089883895;
        Fri, 07 Feb 2020 07:38:03 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id v8sm3845601wrw.2.2020.02.07.07.38.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:38:03 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 06/61] KVM: x86: Move CPUID 0xD.1 handling out of the index>0 loop
In-Reply-To: <20200201185218.24473-7-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-7-sean.j.christopherson@intel.com>
Date:   Fri, 07 Feb 2020 16:38:02 +0100
Message-ID: <87h802qug5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Mov the sub-leaf 1 handling for CPUID 0xD out of the index>0 loop so
> that the loop only handles index>2.  Sub-leafs 2+ have identical
> semantics, whereas sub-leaf 1 is effectively a feature sub-leaf.
>
> Moving sub-leaf 1 out of the loop does duplicate a bit of code, but
> the nent/maxnent code will be consolidated in a future patch, and
> duplicating the clear of ECX/EDX is arguably a good thing as the reasons
> for clearing said registers are completely different.
>
> No functional change intended.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 37 ++++++++++++++++++++++---------------
>  1 file changed, 22 insertions(+), 15 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index e5cf1e0cf84a..fc8540596386 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -653,26 +653,33 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  		if (!supported)
>  			break;
>  
> -		for (idx = 1, i = 1; idx < 64; ++idx) {
> +		if (*nent >= maxnent)
> +			goto out;
> +
> +		do_host_cpuid(&entry[1], function, 1);
> +		++*nent;
> +
> +		entry[1].eax &= kvm_cpuid_D_1_eax_x86_features;
> +		cpuid_mask(&entry[1].eax, CPUID_D_1_EAX);
> +		if (entry[1].eax & (F(XSAVES)|F(XSAVEC)))
> +			entry[1].ebx = xstate_required_size(supported, true);
> +		else
> +			entry[1].ebx = 0;
> +		/* Saving XSS controlled state via XSAVES isn't supported. */
> +		entry[1].ecx = 0;
> +		entry[1].edx = 0;
> +
> +		for (idx = 2, i = 2; idx < 64; ++idx) {
>  			u64 mask = ((u64)1 << idx);
> +
>  			if (*nent >= maxnent)
>  				goto out;
>  
>  			do_host_cpuid(&entry[i], function, idx);
> -			if (idx == 1) {
> -				entry[i].eax &= kvm_cpuid_D_1_eax_x86_features;
> -				cpuid_mask(&entry[i].eax, CPUID_D_1_EAX);
> -				entry[i].ebx = 0;
> -				if (entry[i].eax & (F(XSAVES)|F(XSAVEC)))
> -					entry[i].ebx =
> -						xstate_required_size(supported,
> -								     true);
> -			} else {
> -				if (entry[i].eax == 0 || !(supported & mask))
> -					continue;
> -				if (WARN_ON_ONCE(entry[i].ecx & 1))
> -					continue;
> -			}
> +			if (entry[i].eax == 0 || !(supported & mask))
> +				continue;
> +			if (WARN_ON_ONCE(entry[i].ecx & 1))
> +				continue;
>  			entry[i].ecx = 0;
>  			entry[i].edx = 0;
>  			++*nent;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

