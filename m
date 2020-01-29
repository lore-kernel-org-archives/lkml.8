Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F708C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 403FE2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 15:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i7wuk3zI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgA2PIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 10:08:36 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:52134 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726358AbgA2PIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 10:08:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580310514;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VLaqf7yP7bdIce/kL3zR7k5oqbUaX9ZjKFr0PkLcpeY=;
        b=i7wuk3zIzRTFJP4mMjdbLC2dBI7yxpAqXkz91WTVJjCXV62fTQph4skKohX1nH9MHRQ9Ug
        EH3oG3GQOAuXRi00NxFNj5nG9QrK0XRjoxRdGtG7+gYE7yWuHzNbFGx7HFe8ygE0hWNd5z
        uKmDlSO7xvA1nEe1rdNNOxAIDYgYVgc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-g5kN1YLYO6iOYUpJpxdW_g-1; Wed, 29 Jan 2020 10:08:32 -0500
X-MC-Unique: g5kN1YLYO6iOYUpJpxdW_g-1
Received: by mail-wm1-f70.google.com with SMTP id o24so2751wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 07:08:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=VLaqf7yP7bdIce/kL3zR7k5oqbUaX9ZjKFr0PkLcpeY=;
        b=N3HmoFZ/aWutTaGkQLAhuv6QR4lzFBCbkgRdy5dzOl2on6pzREcuMj61nsbrxp6glD
         PW5ltdjc6ae1taQrz9KGs7fjO/Y7oY2ssptz9It4RY3MdpqgpNEEgoqagqdVUlzqinI0
         X/cEPlqx7iFLqyuuqgmUCGtmZ7X8PdHILThUbxUKrGBKlPmu0pTgGHlIw3UO18c1po/O
         4+vgrrQ0uXef/UdwN9GMQSDY8anviyeuZRIZ1jz330hgSfmjT3ap9JdgBdBafenVQQ8l
         HpPQR8sX2P9scix48N9n1q/jVZHRVPgeMILbjnCo/tuWMTPIrX3i8r4gQ4uPShwy/l26
         I4nA==
X-Gm-Message-State: APjAAAVEY0CJdspsX9IraPKSU2o00KN6hkRJY6zR+M/TAS/KiMO2fwSH
        KHy7Kte8C2iO6oT2eeRxMhSh3tiAvYk8BxDAqFO1xrCS/He4A61LlQ4Ca37FaI16KN0wBDZ2xz5
        wxHxdi0bg+aPBg+BH+/V6uryp
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr12809547wma.177.1580310511023;
        Wed, 29 Jan 2020 07:08:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqxd7v/TEekwH/byRnpgvATju+em8Xhl75IgAQQp0nHiS9nxjrgubYvBWuwl6+TdY5xHEk2Eyw==
X-Received: by 2002:a1c:3b0a:: with SMTP id i10mr12809521wma.177.1580310510755;
        Wed, 29 Jan 2020 07:08:30 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id a184sm2663689wmf.29.2020.01.29.07.08.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jan 2020 07:08:30 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] KVM: x86: Mark CR4.UMIP as reserved based on associated CPUID bit
In-Reply-To: <20200128235344.29581-1-sean.j.christopherson@intel.com>
References: <20200128235344.29581-1-sean.j.christopherson@intel.com>
Date:   Wed, 29 Jan 2020 16:08:29 +0100
Message-ID: <87a7669u6q.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> Re-add code to mark CR4.UMIP as reserved if UMIP is not supported by the
> host.  The UMIP handling was unintentionally dropped during a recent
> refactoring.
>
> Not flagging CR4.UMIP allows the guest to set its CR4.UMIP regardless of
> host support or userspace desires.  On CPUs with UMIP support, including
> emulated UMIP, this allows the guest to enable UMIP against the wishes
> of the userspace VMM.  On CPUs without any form of UMIP, this results in
> a failed VM-Enter due to invalid guest state.
>
> Fixes: 345599f9a2928 ("KVM: x86: Add macro to ensure reserved cr4 bits checks stay in sync")

This one in only in kvm/next so just in case another force-push is
around the corner I'd suggest we squash this change in :-)

> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7e3f1d937224..e70d1215638a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -898,6 +898,8 @@ EXPORT_SYMBOL_GPL(kvm_set_xcr);
>  		__reserved_bits |= X86_CR4_PKE;		\
>  	if (!__cpu_has(__c, X86_FEATURE_LA57))		\
>  		__reserved_bits |= X86_CR4_LA57;	\
> +	if (!__cpu_has(__c, X86_FEATURE_UMIP))		\
> +		__reserved_bits |= X86_CR4_UMIP;	\
>  	__reserved_bits;				\
>  })

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

