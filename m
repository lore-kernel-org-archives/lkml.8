Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D611DC04EB5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA1A621741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 15:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ll1daz/B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbgBGPzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 10:55:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46980 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726956AbgBGPzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 10:55:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581090903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFBH+I3pZxSE3/nW8uXkPGgglj6CkLzBvtfEOuG6ltU=;
        b=Ll1daz/Bk4WjZr1AUxAshN2UK+Ug1ut7C/qKDahVaCQ18m2IW9AcAEEP7hnA1LK7Th+H2D
        yq9R8facdAbz14NC3MSZqzlmPZuncB0DOfCpxjc5/0e2PdWPm3GMDPYV96vSzrK0mJlhhW
        qC5lKyMLIsDAJUhwfwJc8A+F1NoUnxc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-PcXfCshNM0GnCfHr4RoFBw-1; Fri, 07 Feb 2020 10:55:02 -0500
X-MC-Unique: PcXfCshNM0GnCfHr4RoFBw-1
Received: by mail-wm1-f70.google.com with SMTP id o193so885054wme.8
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 07:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=QFBH+I3pZxSE3/nW8uXkPGgglj6CkLzBvtfEOuG6ltU=;
        b=EhxRsc13U+SP9/eG+gyvkbhgaHFDOVmrm9OkXrQquoJB/K5LmMw3FkrST1Dc56eUcx
         0veAb89ajaBuIKrxCMEo20CQ4h4c4GUsxXUVyjzF2DuyptSsIkHhrdWC1v8JZqOwUgEs
         3MY4xT6pjdwDp7/f+8VZOVIGF1bVRs+XLlUAHT2MRyNEs7XHi9GNhWsinf4DrsvwenyQ
         9fa6dm+4d4MNuoriCR549PLIireYroqYpjxXdM76iCrbVH/iwwiYrUqg5U2FQCbpNacX
         MLpbxdSO6QjyW1jajuTMk/57YcrmIVq/V20zyjF7qhSrdT2tjkqLecLFOQPrCSpNtQJC
         ADnA==
X-Gm-Message-State: APjAAAWszqldzlNFGDf8zltYArcESf7Hdqyjnl6iLlzYCno0mk04JV3j
        Ogz7DONefpQQHxpHAwKP78SI56D//eAlmHYdTZrC4NRTfgtu4hjwbK6s65w5Wnu3590nRjme33L
        Ypx65hOKq+/V6Ul3YANY9QCoZ
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr4823103wme.125.1581090900633;
        Fri, 07 Feb 2020 07:55:00 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGMhefTt0xxkYnoAPTdX7xUJ/aP2VoWNuoM5XnuppuedTlNtTGQxscI7Jhe88U/WITfvKq0A==
X-Received: by 2002:a1c:9c4c:: with SMTP id f73mr4823080wme.125.1581090900418;
        Fri, 07 Feb 2020 07:55:00 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a8sm3949803wmc.20.2020.02.07.07.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 07:54:59 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 08/61] KVM: x86: Warn on zero-size save state for valid CPUID 0xD.N sub-leaf
In-Reply-To: <20200201185218.24473-9-sean.j.christopherson@intel.com>
References: <20200201185218.24473-1-sean.j.christopherson@intel.com> <20200201185218.24473-9-sean.j.christopherson@intel.com>
Date:   Fri, 07 Feb 2020 16:54:59 +0100
Message-ID: <87blqaqtnw.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> WARN if the save state size for a valid XCR0-managed sub-leaf is zero,
> which would indicate a KVM or CPU bug.  Add a comment to explain why KVM
> WARNs so the reader doesn't have to tease out the relevant bits from
> Intel's SDM and KVM's XCR0/XSS code.
>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/cpuid.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
> index fd9b29aa7abc..424dde41cb5d 100644
> --- a/arch/x86/kvm/cpuid.c
> +++ b/arch/x86/kvm/cpuid.c
> @@ -677,10 +677,17 @@ static inline int __do_cpuid_func(struct kvm_cpuid_entry2 *entry, u32 function,
>  				goto out;
>  
>  			do_host_cpuid(&entry[i], function, idx);
> -			if (entry[i].eax == 0)
> -				continue;
> -			if (WARN_ON_ONCE(entry[i].ecx & 1))
> +
> +			/*
> +			 * The @supported check above should have filtered out
> +			 * invalid sub-leafs as well as sub-leafs managed by

Is it 'sub-leafs' or 'sub-leaves' actually? :-)

> +			 * IA32_XSS MSR.  Only XCR0-managed sub-leafs should
> +			 * reach this point, and they should have a non-zero
> +			 * save state size.
> +			 */
> +			if (WARN_ON_ONCE(!entry[i].eax || (entry[i].ecx & 1)))
>  				continue;
> +
>  			entry[i].ecx = 0;
>  			entry[i].edx = 0;
>  			++*nent;

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

