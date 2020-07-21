Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A879C433E4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:35:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBEF120714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h0SCUlSp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGUKfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:35:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50053 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726990AbgGUKfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:35:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595327707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+QcQANYSd60hPwsM1oi+9jY7lQaINgY8Mg9f0/qdPFw=;
        b=h0SCUlSp0hhx0pYwooGWnz6/rYLP8gGgJ//aGHhgXuzr0cxCoE5Y3cxCimHZoNqe9Uxqnz
        pkHO/IISmUC4PaY+2GS9+15GNjE2lS/sR/X3nyfZoXyp0sqkTofEqyDrpsYLBhG6z2+HzZ
        2LXw9RzcFEAtqOrsL9gYiCLrmRqantA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-Gu5N-3TINUG4mSVx_V5fwQ-1; Tue, 21 Jul 2020 06:35:04 -0400
X-MC-Unique: Gu5N-3TINUG4mSVx_V5fwQ-1
Received: by mail-wr1-f70.google.com with SMTP id w4so12882726wrm.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:35:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+QcQANYSd60hPwsM1oi+9jY7lQaINgY8Mg9f0/qdPFw=;
        b=gQD1W75X0W7neRZEA3D5V/j+Vhr0EU07NW0Te0vj8dAUnxhNnSAE2q+RQ5PkvBR/4F
         XwqPpK53UXlfwfD9CtUYsoHsuAUYQAy7BwGBLosjRLAFGcX6wkqFer5MkRaiHEVSffwd
         f72YfZ54rbY/bDweglGSdJyD3PtK3saV9KTsFeX2IG9gXAd1CGLVUxkoh2dJcDo3hcmK
         gyBdLHreMW7OpPL2RO1wFs9XgRb0Jbm8/QohKzwXzTp4GABa6UZGvbTeueYS8xxm0MKF
         zzWfx5zHRO1qWQTKk3w5Xe83aj2MUHIzvB7VDBrXfqsrQULlAtABRzlUw+OGYiZOyqd2
         7xYg==
X-Gm-Message-State: AOAM531LdGfRWTtfFrjL1iH62Zx6GMN6O6hX0aCUiqVuLQ5hO1oQv0FQ
        gvDIg6mUzhKRWJifw1aGeBtwcF1yPHsbVjiM+8XwntUvUU/AFhF+WzFS21qeU4//4h1t9z0Dwhw
        w9PNJCW7R9bz7uMJWYyKc+0UJ
X-Received: by 2002:adf:ee05:: with SMTP id y5mr27007283wrn.185.1595327703546;
        Tue, 21 Jul 2020 03:35:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwv0DP3FjlddJPF+5lYujXxuycYk0rvKz4/nKB/2vjz0RMXFM7kJkZtlYaitG1SsPgtRKexoA==
X-Received: by 2002:adf:ee05:: with SMTP id y5mr27007267wrn.185.1595327703348;
        Tue, 21 Jul 2020 03:35:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g144sm2604256wme.2.2020.07.21.03.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 03:35:02 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/2] KVM: LAPIC: Prevent setting the tscdeadline timer if the lapic is hw disabled
In-Reply-To: <1595323468-4380-1-git-send-email-wanpengli@tencent.com>
References: <1595323468-4380-1-git-send-email-wanpengli@tencent.com>
Date:   Tue, 21 Jul 2020 12:35:01 +0200
Message-ID: <87o8o9p356.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Prevent setting the tscdeadline timer if the lapic is hw disabled.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 5bf72fc..4ce2ddd 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2195,7 +2195,7 @@ void kvm_set_lapic_tscdeadline_msr(struct kvm_vcpu *vcpu, u64 data)
>  {
>  	struct kvm_lapic *apic = vcpu->arch.apic;
>  
> -	if (!lapic_in_kernel(vcpu) || apic_lvtt_oneshot(apic) ||
> +	if (!kvm_apic_present(vcpu) || apic_lvtt_oneshot(apic) ||
>  			apic_lvtt_period(apic))
>  		return;

Out of pure curiosity, what is the architectural behavior if I disable
LAPIC, write to IA32_TSC_DEADLINE and then re-enable LAPIC before the
timer was supposed to fire?

-- 
Vitaly

