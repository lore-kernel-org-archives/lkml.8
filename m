Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F39C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF35E20730
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 10:41:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hiJ5AS4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728454AbgBFKl3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 05:41:29 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:33373 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727915AbgBFKl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 05:41:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580985687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z3MLvs9QeO5YfLds0ekW7KKa80cPvToO4kODbI4MibM=;
        b=hiJ5AS4X6LzWncGGEWMrbYOmjM9W0e9gPXAhqAxxk+mJ7xTyLsSZSpfeq4J3w/aZtU4FSN
        S6II8qrceFMF8eN8tPKjJhkmUMRksDVycCW52zLa3tkR96j8bSacSEVOiYVYIaB8slwfLN
        v6oSsCe7wDWZaymZ8x7TLm7YrBF3His=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-yI3V82t2PnKYSe4K0wTHZg-1; Thu, 06 Feb 2020 05:41:20 -0500
X-MC-Unique: yI3V82t2PnKYSe4K0wTHZg-1
Received: by mail-wm1-f69.google.com with SMTP id o24so2599283wmh.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 02:41:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=z3MLvs9QeO5YfLds0ekW7KKa80cPvToO4kODbI4MibM=;
        b=NQPFjXMrZSqvWGPkdm3Xpuk+52TxJVsxNbsdGmv379WeDP8wF9fgZxBRkXUI3hzDKB
         Djxr0X+aUnf9ZRtFDwi+GOJftZetry8Mmvhf5+hDahxwcdkfUFEkr/uMpP96ev0msYB1
         /TvjfrweK1rhXzbUTjOSdTzxWzT33RIbHGVPC7XKXZMbmju00xdShS1EXADWC9wNRyj1
         5KpOEaQmTgP6OAzhqW95GrWiLt0GKDcMjps49kWhzU/87eMCDSGA5+RivaMHFUnzov8o
         /2niFZ+2SOlcS+w76P8CrbqhS/m+9B2hvEgzzoHxuCsfCGrXkH5Ov3MVGU6785jqqzmG
         UMtw==
X-Gm-Message-State: APjAAAVgHTMyQBZdQtzGtPPPtYsKIbLHvANgDnWfLP/r91+wyn+fTmlL
        Qlhx67grfQDj7eW1uZUVGyKvONnaeV9ADydqseXwlvCbyXjbRdiCVJbL25hkj2MDz8+0XrYjkIp
        KR3tz/BsCn3QD8hknAJBE74KW
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr3810508wme.161.1580985677423;
        Thu, 06 Feb 2020 02:41:17 -0800 (PST)
X-Google-Smtp-Source: APXvYqyDh4uumYKMzVvavc7ne4C/+Y4wIseWOIgttAS3dqIsiaZbXeKK3iMa37NwzhkJfhRCKINK7Q==
X-Received: by 2002:a1c:9e89:: with SMTP id h131mr3810455wme.161.1580985677003;
        Thu, 06 Feb 2020 02:41:17 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id e17sm3732182wrn.62.2020.02.06.02.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 02:41:16 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        pbonzini@redhat.com, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: x86: remove duplicated KVM_REQ_EVENT request
In-Reply-To: <1580953544-4778-1-git-send-email-linmiaohe@huawei.com>
References: <1580953544-4778-1-git-send-email-linmiaohe@huawei.com>
Date:   Thu, 06 Feb 2020 11:41:15 +0100
Message-ID: <87ftfogfqs.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linmiaohe <linmiaohe@huawei.com> writes:

> From: Miaohe Lin <linmiaohe@huawei.com>
>
> The KVM_REQ_EVENT request is already made in kvm_set_rflags(). We should
> not make it again.
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/x86.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index fbabb2f06273..212282c6fb76 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -8942,7 +8942,6 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
>  
>  	kvm_rip_write(vcpu, ctxt->eip);
>  	kvm_set_rflags(vcpu, ctxt->eflags);
> -	kvm_make_request(KVM_REQ_EVENT, vcpu);

I would've actually done it the other way around and removed
kvm_make_request() from kvm_set_rflags() as it is not an obvious
behavior (e.g. why kvm_rip_write() doens't do that and kvm_set_rflags()
does ?) adding kvm_make_request() to all call sites.

In case this looks like too big of a change with no particular gain I'd
suggest you at least leave a comment above kvm_set_rflags(), something
like

"kvm_make_request() also requests KVM_REQ_EVENT"

>  	return 1;
>  }
>  EXPORT_SYMBOL_GPL(kvm_task_switch);

-- 
Vitaly

