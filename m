Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64FF5C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:14:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36BC920882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 09:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R5dVhzNL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAUJOW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 04:14:22 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43158 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727220AbgAUJOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 04:14:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579598060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=t567CbMgA9338UWtr+w2ck6M2sm+WFvSEhuhDePLGcE=;
        b=R5dVhzNLZOfmt0xHFXVBSsJ0aRK/PIk0VWK1VPox3p1+oI3qhG4yCrJZMpnO25q5p9Djie
        YwX6I9ajhd3tssOVwn/JGMncuywyhnI47OHX56CqX2lT8kHGyPRPsKWh8RYgR7za7zlK4h
        ZMDVYCwfnvCoTFOtIoJnsNcpeQoZJKE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-210-hBsuaRHiNmqReei7iLM-0A-1; Tue, 21 Jan 2020 04:14:19 -0500
X-MC-Unique: hBsuaRHiNmqReei7iLM-0A-1
Received: by mail-wr1-f69.google.com with SMTP id c17so1031501wrp.10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 01:14:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=t567CbMgA9338UWtr+w2ck6M2sm+WFvSEhuhDePLGcE=;
        b=EnJOGZ6TaOp6WvBEnVLBwDvMAua9lY9Xi8oH8ErjSKwwQOmKerIjpHEj3u22KDjXm8
         oq0nkGTQnRDJ2nezzJGH3jrapj8C7mCqTgvfWhKePBQqxT6EAEQpZPiD41vDhtziKCf4
         /vJyaj6OP7BsqeU0q5pZkEkBREi7ub60m4BkCswhyvaLk4ix0nDC32QIe1Cs9Uj7YZo+
         OZP8+EEfL9CDB8M+F1fU725ijua8GWpzqV0lbpivI9Ldyg1J5KPc2fp7tTe6Q8AimVRR
         BQFTrf/Lm87LPi2+e35px50cdcMqqO+fRq6O0QbFc0y1vw3DLCa6Tx/bSA5F2j/Xq+KW
         /JOQ==
X-Gm-Message-State: APjAAAWBmFxHiwyx15HfXDmxAFCWjKmK5FMeGEexmETwsyz8cRzqzsbJ
        XXWP9gZEjmrnN4Smx2Sq0hssTHg1oShYfJooO8cL2gYT4FhfxddI4ncHdtQiZ/6OjgmdK9v/FSN
        y2Ysaz/PFHuQxL9VUtrY52HCO
X-Received: by 2002:adf:edd0:: with SMTP id v16mr4026375wro.310.1579598058560;
        Tue, 21 Jan 2020 01:14:18 -0800 (PST)
X-Google-Smtp-Source: APXvYqwKY3be808KwDxDQnSOCDMPaR4S7dKImMyC2RkCvhOEp+act0tw14nv6fN+cok8F0tDj6w5qw==
X-Received: by 2002:adf:edd0:: with SMTP id v16mr4026354wro.310.1579598058342;
        Tue, 21 Jan 2020 01:14:18 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id t8sm51641178wrp.69.2020.01.21.01.14.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 01:14:17 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     linmiaohe@huawei.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, wanpengli@tencent.com,
        jmattson@google.com, joro@8bytes.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Subject: Re: [PATCH] KVM: VMX: remove duplicated segment cache clear
In-Reply-To: <20200121151518.27530-1-linmiaohe@huawei.com>
References: <20200121151518.27530-1-linmiaohe@huawei.com>
Date:   Tue, 21 Jan 2020 10:14:16 +0100
Message-ID: <87eevtf9xz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> vmx_set_segment() clears segment cache unconditionally, so we should not
> clear it again by calling vmx_segment_cache_clear().
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index b5a0c2e05825..b32236e6b513 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -2688,8 +2688,6 @@ static void enter_pmode(struct kvm_vcpu *vcpu)
>  
>  	vmx->rmode.vm86_active = 0;
>  
> -	vmx_segment_cache_clear(vmx);
> -
>  	vmx_set_segment(vcpu, &vmx->rmode.segs[VCPU_SREG_TR], VCPU_SREG_TR);
>  
>  	flags = vmcs_readl(GUEST_RFLAGS);

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

