Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B629C35DE1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D0312467D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 13:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R6VU0wEY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbgBYNpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 08:45:47 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32641 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730261AbgBYNpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 08:45:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582638346;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/T/kivFGUXg5sHRSIwBgWjiVnsUmWthpcONYfMKDGQU=;
        b=R6VU0wEYegPORveoMeazRTXnzBhiMutPV6Gui1MyyiaOQQOfYgIz/opxriSbhFs9jY1F1P
        vr5h6u9dEChdCmfKiKoGeTodJxnFzAAIR9dRS+6S5rWjvGjkG6/43dYX594kRJTxAAeLgM
        pRwHh+3fk/78ij8ictEJpXLqibCr51k=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-1uRhk7NyOdOR1H7Yo_aluQ-1; Tue, 25 Feb 2020 08:45:39 -0500
X-MC-Unique: 1uRhk7NyOdOR1H7Yo_aluQ-1
Received: by mail-wm1-f70.google.com with SMTP id u11so1046925wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 05:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=/T/kivFGUXg5sHRSIwBgWjiVnsUmWthpcONYfMKDGQU=;
        b=dXT2HER7G2t6QKc38ecdoSj79JcLn3CYNsylVlJdYP1V+BM6zspf20MmG2bVcSy03S
         J0sDg7Tx8rl9VSPJQTiqfJKR3lhxfqBarDMzJGwIVDGJ56bT/z7J0N8iH2EtMl4OUmjN
         JeBqr83Y1uB4d/o6CWUYYBmApuTvMFPGzomORjfuWka4KGG3CISDBWxjR/VK8MirlrUz
         yDjRQl+UBW/dyU9XW69CrsgR3cwQyI5qUlhbM33eeGcpYdMJA0yl1i06+6petnuJ5DXR
         xq0ouyh7WWiukhf2xmqSkbChaFf//Kj7n9DZl/l6p3VRr9gYbPuhC6OWgarj924EzzBY
         7R8A==
X-Gm-Message-State: APjAAAXxhHHI6jDyGFzr0zE3dfrno/9IXFr8GIQ9Qo//gW5yx+i+uWYc
        dclQBHhT0JYeQF2bW65Vv5Xq682PsDYS0ky1nkOxZzW1TYiWpaXk8FWlMWE/mJKuwd2BRz0oXVD
        NYeEvCekRwY2ScupU6OFKA7oW
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr5249099wmk.138.1582638337568;
        Tue, 25 Feb 2020 05:45:37 -0800 (PST)
X-Google-Smtp-Source: APXvYqwf2ZsKE58ePK4Z2deUeaZOsUEklPqETVClcba53r8rw/fae2dyyFlESYMCG1Qyok6wzsJ9Mg==
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr5249082wmk.138.1582638337293;
        Tue, 25 Feb 2020 05:45:37 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id h205sm4401348wmf.25.2020.02.25.05.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2020 05:45:36 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     rmuncrief@humanavance.com, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: SVM: allocate AVIC data structures based on kvm_amd moduleparameter
In-Reply-To: <1582617278-50338-1-git-send-email-pbonzini@redhat.com>
References: <1582617278-50338-1-git-send-email-pbonzini@redhat.com>
Date:   Tue, 25 Feb 2020 14:45:36 +0100
Message-ID: <874kven5kv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> Even if APICv is disabled at startup, the backing page and ir_list need
> to be initialized in case they are needed later.  The only case in
> which this can be skipped is for userspace irqchip, and that must be
> done because avic_init_backing_page dereferences vcpu->arch.apic
> (which is NULL for userspace irqchip).
>
> Tested-by: rmuncrief@humanavance.com
> Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=206579
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/svm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> index ad3f5b178a03..bd02526300ab 100644
> --- a/arch/x86/kvm/svm.c
> +++ b/arch/x86/kvm/svm.c
> @@ -2194,8 +2194,9 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  static int avic_init_vcpu(struct vcpu_svm *svm)
>  {
>  	int ret;
> +	struct kvm_vcpu *vcpu = &svm->vcpu;
>  
> -	if (!kvm_vcpu_apicv_active(&svm->vcpu))
> +	if (!avic || !irqchip_in_kernel(vcpu->kvm))
>  		return 0;
>  
>  	ret = avic_init_backing_page(&svm->vcpu);

Out of pure curiosity,

when irqchip_in_kernel() is false, can we still get to .update_pi_irte()
(svm_update_pi_irte()) -> get_pi_vcpu_info() -> "vcpu_info->pi_desc_addr
= __sme_set(page_to_phys((*svm)->avic_backing_page));" -> crash! or is
there anything which make this impossible?

The patch is an improvement anyway, so
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

