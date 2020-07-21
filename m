Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0410C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 998502077D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 10:51:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YdJR7nRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729298AbgGUKvs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 06:51:48 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51012 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726089AbgGUKvs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 06:51:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595328707;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P6x8b72+BAW2ZS/XopVU/cZY9GZgo98jcuFZvHSf6+o=;
        b=YdJR7nRowqhlkSwTfFkWMsN3V8JsLXyjjaQKfZi7TrA+uLSo9ClyDNPnx5CVW3w9UDWj1h
        rgjc3Y1BKvSIb2Qr8Y2bek7YwQc0/pvCHOSx2I3vKKlah1hL5SVbDf/iDRkUPrX3O4mtQm
        AkX4AXS/KJXCvFRQIO1CmhViLb9wz/U=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-3kATzk8WP9-LBuNkAQ1I5w-1; Tue, 21 Jul 2020 06:51:45 -0400
X-MC-Unique: 3kATzk8WP9-LBuNkAQ1I5w-1
Received: by mail-wm1-f72.google.com with SMTP id 65so848879wmd.8
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 03:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=P6x8b72+BAW2ZS/XopVU/cZY9GZgo98jcuFZvHSf6+o=;
        b=KSDEqNSHwkAfCmOHj54IsGWq5oZFgy1McmOSgG93jcQ4Si4hwGO3V7Km1YeiN8Y0ps
         2Q3Eo8CqX2D6MSu2K+Alx3Uu5ly14weDQnbLlY1gX6f847YSWtYc09lAwK3hbzamQDOA
         SXYY2jqyk5uZW15qgXPNONLHBrTRUs3FS0k4XCIjFXRg1wt0bCh67f/gOU0ITrJqv/eT
         xn14sUwiWDOj1EsnA0z/DjXnccXyRF7wd7pEBYi9grdb5z66N2K4anjv5ELPFjqsqhp+
         9biqOBBvuU2ee1u6mgs06i1its+I5aVQh67UURSM03kHmu//ZnA+CJAJC5zq/bbiQzlo
         FydQ==
X-Gm-Message-State: AOAM5301B6DxAzA3A5r5O1er8wjZsP7aGuh1j1u1SQSVdi0OS9JAJmXo
        AKV8nCVRCzFpI3zA8pXO/BFXEhQfmxXHGj2jg3c6rgaiQjJ4RGyqtysanMgogSTGxPrvp/Z0BDC
        kny9TaQN49qvRTzGr/TkMRxkU
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr25096957wrm.387.1595328704342;
        Tue, 21 Jul 2020 03:51:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQgZF+XCKusjoWPe1LCm/gSDD1TOc5ZvNM9iscgHiaS1vURkLDx0+jURLsYeYugXZ84y29ZA==
X-Received: by 2002:adf:dcd0:: with SMTP id x16mr25096947wrm.387.1595328704168;
        Tue, 21 Jul 2020 03:51:44 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 65sm43820717wre.6.2020.07.21.03.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 03:51:43 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 2/2] KVM: LAPIC: Set the TDCR settable bits
In-Reply-To: <1595323468-4380-2-git-send-email-wanpengli@tencent.com>
References: <1595323468-4380-1-git-send-email-wanpengli@tencent.com> <1595323468-4380-2-git-send-email-wanpengli@tencent.com>
Date:   Tue, 21 Jul 2020 12:51:42 +0200
Message-ID: <87lfjdp2dd.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Only bits 0, 1, and 3 are settable, others are reserved for APIC_TDCR. 
> Let's record the settable value in the virtual apic page.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index 4ce2ddd..8f7a14d 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -2068,7 +2068,7 @@ int kvm_lapic_reg_write(struct kvm_lapic *apic, u32 reg, u32 val)
>  	case APIC_TDCR: {
>  		uint32_t old_divisor = apic->divide_count;
>  
> -		kvm_lapic_set_reg(apic, APIC_TDCR, val);
> +		kvm_lapic_set_reg(apic, APIC_TDCR, val & 0xb);
>  		update_divide_count(apic);
>  		if (apic->divide_count != old_divisor &&
>  				apic->lapic_timer.period) {

AFAIU bit 2 should be 0 and other upper bits are reserved. Checking on
bare hardware,

# wrmsr 0x83e 0xb
# rdmsr 0x83e
b
# wrmsr 0x83e 0xc
wrmsr: CPU 0 cannot set MSR 0x0000083e to 0x000000000000000c
# rdmsr 0x83e
b

Shouldn't we fail the write in case (val & ~0xb) ?

-- 
Vitaly

