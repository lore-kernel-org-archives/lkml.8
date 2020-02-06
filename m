Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271E8C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE2A220730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RiDLmLuQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBFKrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:47:08 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:41518 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727784AbgBFKrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580986026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LwUpU4+5TYhyq7gA8U9gCKtyirwnAwi8lnA+NgPfo3s=;
        b=RiDLmLuQTEjbA+/pEgYsrnGTSZP+vDcouERaLFhwxYpYjX7X7AekDcZZBjLySVqsPmDF6H
        q5E9H7dqOO++QfA8ykV6KzL8RPheeeaJx7CLXCVVfoPDSdiYSkU2ePA9bjjiJSmHDVD2bX
        VesbrwTj8sEBkz42maVavIo4hAkuYeg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-SsAdUq1GNN-hhSiqvBWG-Q-1; Thu, 06 Feb 2020 05:47:05 -0500
X-MC-Unique: SsAdUq1GNN-hhSiqvBWG-Q-1
Received: by mail-wr1-f70.google.com with SMTP id u8so3172889wrp.10
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 02:47:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LwUpU4+5TYhyq7gA8U9gCKtyirwnAwi8lnA+NgPfo3s=;
        b=QgwTVHqBNtj8NaS9ySiiPwAqJ8latY94V8SjznMwyMzfF+Udyj04ARALbSwLutmage
         OJZPemm85szcFfE4JwxPxdW0idiZc9UfgJL3Xd5aTRQ5WpzcpYX8G4PnvyGdD6uEzI89
         gHce5zQdXEiFuQRuz4p1c7khw6fDSbdXd+iAS5j85flqWl3eDcbKT+8HHYr++bUgWQuc
         NEZ1anyJRJiYCE2gsdwiCd51voHvSVHPu2IAz2gq2cAPVeIjC2nmdSRbvvic1sRE9fSX
         O3js222Jm8mMYe4oLvg4qvryAjpuwrC/hJss+xd3TkpxiJPItm0HKFDqsjBIzBLGaTXX
         z7yg==
X-Gm-Message-State: APjAAAUmW3Z7pSfkY+y5KqjkzHMaL2JJBcMZG/U58YF0T9APUBHaud6D
        Z0AZ9TQeSo+Zi508PAXy4enI7cckcXAD43BzVT56kfv9/HJCAEYXqjOPCDA+1779W9cjpFTT8kl
        oa0ivCp4ynp2FSzdzTyYs6cpQ
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr3725147wmg.136.1580986024130;
        Thu, 06 Feb 2020 02:47:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqzUXesjapYVLNDGg33W1PSAh8QmTUREwHpI41B5FUgh22WCFZglKZPj1KkMXoFa3bCLqnPBkA==
X-Received: by 2002:a05:600c:2056:: with SMTP id p22mr3725097wmg.136.1580986023542;
        Thu, 06 Feb 2020 02:47:03 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i11sm3631994wrs.10.2020.02.06.02.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 02:47:03 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: apic: reuse smp_wmb() in kvm_make_request()
In-Reply-To: <1580954375-5030-1-git-send-email-linmiaohe@huawei.com>
References: <1580954375-5030-1-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 06 Feb 2020 11:47:02 +0100
Message-ID: <87d0asgfh5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> There is already an smp_mb() barrier in kvm_make_request(). We reuse it
> here.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/lapic.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index eafc631d305c..ea871206a370 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -1080,9 +1080,12 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
>  			result = 1;
>  			/* assumes that there are only KVM_APIC_INIT/SIPI */
>  			apic->pending_events = (1UL << KVM_APIC_INIT);
> -			/* make sure pending_events is visible before sending
> -			 * the request */
> -			smp_wmb();
> +			/*
> +			 * Make sure pending_events is visible before sending
> +			 * the request.
> +			 * There is already an smp_wmb() in kvm_make_request(),
> +			 * we reuse that barrier here.
> +			 */

Let me suggest an alternative wording,

"kvm_make_request() provides smp_wmb() so pending_events changes are
guaranteed to be visible"

But there is nothing wrong with yours, it's just longer than it could be
:-)

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

>  			kvm_make_request(KVM_REQ_EVENT, vcpu);
>  			kvm_vcpu_kick(vcpu);
>  		}

-- 
Vitaly

