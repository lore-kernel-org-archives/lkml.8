Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E86C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF8CC2072F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 09:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C1OH9R8N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgC0JAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 05:00:20 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:59691 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726002AbgC0JAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 05:00:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585299619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xXn06OBqafJOcrur/EKuL7fTmScTGWRZwAAJXIbK1TM=;
        b=C1OH9R8Nj5Jajv8Ex2lvtOvhdXxsGkdPCtYBQduuqh2C8d0Uonao7Sxv9zLdXgPJ11YLom
        VCAzlWBUjHSBBLKOWCqc5/SdP904XYfv/P+Fbh9d82QOLCfddZKS7636FFrjSuyJHLRSnB
        tOQpNy6w6Q4Q+doTHGDCz03slv0PaP0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-J0xUhAtaOIuzT8l2-2Ws5w-1; Fri, 27 Mar 2020 05:00:17 -0400
X-MC-Unique: J0xUhAtaOIuzT8l2-2Ws5w-1
Received: by mail-wr1-f70.google.com with SMTP id y1so3110687wrp.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 02:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=xXn06OBqafJOcrur/EKuL7fTmScTGWRZwAAJXIbK1TM=;
        b=hLmXYMjghbzbbVk0mlUk0R4ezDYPuuk8X80Dn6LHFwYaC0ZD14zhzfgEE1zse6E2La
         zO88RY2gNifEakhnWJ9n0++OUV0Hem61c/lcqtHAzIsp+2CYFReTCTBVKaXCiEiKekAf
         cPkrVzKArgamDhelLYyz9c7oOqQrrs2SU/zRnYLsHQ6rTQeKKN/0PUGHuynQLMN70ARc
         KNh8y0lGyfE1HnppoE1cG1qwZ4k2FGfaKuRYaahdfsZLUIjT7AmHg/ZSsbM0zUyPuFHm
         gidPr9k/I5SxC1n6wUs0RxeIJCtFrp7Qv48T/1aCYmtJgyhIlVDcPRsQOAOTvpL58lTq
         TTAQ==
X-Gm-Message-State: ANhLgQ1HoZS8sclGfRDDqGukjT/P98aiH7jqX6HLjtNX18PqV94j/lrK
        tzXczNr8eFQ9siY8vYk0xUeACNKuKzktwPXZXGgRophRmfxv3j7yOPhiBazsCX4h9leFHdAZuZC
        062+lc2BM+YBmFW4k+VT2WySd
X-Received: by 2002:a7b:c005:: with SMTP id c5mr4246489wmb.170.1585299616259;
        Fri, 27 Mar 2020 02:00:16 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vupCgbub67CH9ToceY2ONuYK3r55PSSyGg0pZYTP2Bzke32oW0juDI1XeKQGvWvA4hyB0SRUA==
X-Received: by 2002:a7b:c005:: with SMTP id c5mr4246456wmb.170.1585299616001;
        Fri, 27 Mar 2020 02:00:16 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id 71sm7846558wrc.53.2020.03.27.02.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2020 02:00:15 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Wanpeng Li <kernellwp@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: X86: Filter the broadcast dest for IPI fastpath
In-Reply-To: <1585290240-18643-1-git-send-email-wanpengli@tencent.com>
References: <1585290240-18643-1-git-send-email-wanpengli@tencent.com>
Date:   Fri, 27 Mar 2020 10:00:14 +0100
Message-ID: <87h7ya41gh.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wanpeng Li <kernellwp@gmail.com> writes:

> From: Wanpeng Li <wanpengli@tencent.com>
>
> Except destination shorthand, a destination value 0xffffffff is used to 
> broadcast interrupts, let's also filter this for single target IPI fastpath.
>
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> ---
>  arch/x86/kvm/lapic.c | 3 ---
>  arch/x86/kvm/lapic.h | 3 +++
>  arch/x86/kvm/x86.c   | 3 ++-
>  3 files changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
> index a38f1a8..88929b1 100644
> --- a/arch/x86/kvm/lapic.c
> +++ b/arch/x86/kvm/lapic.c
> @@ -59,9 +59,6 @@
>  #define MAX_APIC_VECTOR			256
>  #define APIC_VECTORS_PER_REG		32
>  
> -#define APIC_BROADCAST			0xFF
> -#define X2APIC_BROADCAST		0xFFFFFFFFul
> -
>  static bool lapic_timer_advance_dynamic __read_mostly;
>  #define LAPIC_TIMER_ADVANCE_ADJUST_MIN	100	/* clock cycles */
>  #define LAPIC_TIMER_ADVANCE_ADJUST_MAX	10000	/* clock cycles */
> diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
> index bc76860..25b77a6 100644
> --- a/arch/x86/kvm/lapic.h
> +++ b/arch/x86/kvm/lapic.h
> @@ -17,6 +17,9 @@
>  #define APIC_BUS_CYCLE_NS       1
>  #define APIC_BUS_FREQUENCY      (1000000000ULL / APIC_BUS_CYCLE_NS)
>  
> +#define APIC_BROADCAST			0xFF
> +#define X2APIC_BROADCAST		0xFFFFFFFFul
> +
>  enum lapic_mode {
>  	LAPIC_MODE_DISABLED = 0,
>  	LAPIC_MODE_INVALID = X2APIC_ENABLE,
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index c4bb7d8..495709f 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1559,7 +1559,8 @@ static int handle_fastpath_set_x2apic_icr_irqoff(struct kvm_vcpu *vcpu, u64 data
>  
>  	if (((data & APIC_SHORT_MASK) == APIC_DEST_NOSHORT) &&
>  		((data & APIC_DEST_MASK) == APIC_DEST_PHYSICAL) &&
> -		((data & APIC_MODE_MASK) == APIC_DM_FIXED)) {
> +		((data & APIC_MODE_MASK) == APIC_DM_FIXED) &&
> +		((u32)(data >> 32) != X2APIC_BROADCAST)) {
>  
>  		data &= ~(1 << 12);
>  		kvm_apic_send_ipi(vcpu->arch.apic, (u32)data, (u32)(data >> 32));

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

