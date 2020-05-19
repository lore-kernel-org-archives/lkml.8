Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 174F6C433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5E6D204EA
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 14:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eFrGC1B3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729092AbgESOfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 10:35:44 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54188 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728953AbgESOfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 10:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589898941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2xbgBRrGTvYkFK8xcBIJtWfvvMkHZ1itPFaXsI/XXJY=;
        b=eFrGC1B3hisxJ6EH8L65RrtYaoa0exnmgfF8l+gHFFn2YN1K62ghpqRdCP61LetCEN/uDU
        X3ZrnFofqVwP07fjIUdS+Ko1ozZ16xM82jiF2rk+Mf7GY2qYWUrkYh6uHrV9/r+aSSMDVv
        hfV7WMEDL0xAjGMJmKur+wamFN92TYw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-U0qZ2tB2PVSyDgr1tBeqbA-1; Tue, 19 May 2020 10:35:39 -0400
X-MC-Unique: U0qZ2tB2PVSyDgr1tBeqbA-1
Received: by mail-wr1-f70.google.com with SMTP id 90so7345976wrg.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 07:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=2xbgBRrGTvYkFK8xcBIJtWfvvMkHZ1itPFaXsI/XXJY=;
        b=snjObxe8abiqRoXZ43rzUQWwBOGJoKkZg6tQKaLzIplwwjRdH91F08ducWNcgy9ceW
         K8yqjfOsI76uwxtiLkMvYh5WH5VCEEij+npIZp5jGKwUKx05+fSC3g86t2KehR8D0k8q
         euwioHspDy+ZhAltg3xce2AyjdNmfr+T/SIGYVAfiEVHpc/JEY2rPDaRyrRoarDRPq5q
         Yi4AFpI8/DDVYWWpDhHZbJDbgr0NLxvo8HpokDYWfHR427oAbpp5ZviB0UvuB5XaorPk
         /v0RL3MOf/RSG5MjrLD+glgmos0RjPd38JJvn79USMeDiY7+aAeALrQL+jldpquWLOcE
         yNRA==
X-Gm-Message-State: AOAM530fzfv0gDhgw/aQ28ODBDCmKmI3Jomjdq7XYg3jVmgqeFIvyqLB
        GGAwUirm/pbyU65mTv30onEb7FSlRCauytOEgMt/UZfA1/xTlYtP8s8EWxPUyLkWiDbfLvxWdhJ
        yyGspc1YBjzjy7LKsQlTbT7l1
X-Received: by 2002:adf:cd92:: with SMTP id q18mr27014155wrj.237.1589898937570;
        Tue, 19 May 2020 07:35:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymyRcJokL7LorGPwhqLBHvyYKLAde53LE6ciNdHw2GNl0p3NqediA7gtHOFzcm+a1BYs/Guw==
X-Received: by 2002:adf:cd92:: with SMTP id q18mr27014131wrj.237.1589898937269;
        Tue, 19 May 2020 07:35:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id q9sm3989164wmb.34.2020.05.19.07.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 07:35:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: only do L1TF workaround on affected processors
In-Reply-To: <20200519095008.1212-1-pbonzini@redhat.com>
References: <20200519095008.1212-1-pbonzini@redhat.com>
Date:   Tue, 19 May 2020 16:35:35 +0200
Message-ID: <87pnb0t2ko.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> KVM stores the gfn in MMIO SPTEs as a caching optimization.  These are split
> in two parts, as in "[high 11111 low]", to thwart any attempt to use these bits
> in an L1TF attack.  This works as long as there are 5 free bits between
> MAXPHYADDR and bit 50 (inclusive), leaving bit 51 free so that the MMIO
> access triggers a reserved-bit-set page fault.
>
> The bit positions however were computed wrongly for AMD processors that have
> encryption support.  In this case, x86_phys_bits is reduced (for example
> from 48 to 43, to account for the C bit at position 47 and four bits used
> internally to store the SEV ASID and other stuff) while x86_cache_bits in
> would remain set to 48, and _all_ bits between the reduced MAXPHYADDR
> and bit 51 are set.  Then low_phys_bits would also cover some of the
> bits that are set in the shadow_mmio_value, terribly confusing the gfn
> caching mechanism.
>
> To fix this, avoid splitting gfns as long as the processor does not have
> the L1TF bug (which includes all AMD processors).  When there is no
> splitting, low_phys_bits can be set to the reduced MAXPHYADDR removing
> the overlap.  This fixes "npt=0" operation on EPYC processors.
>
> Thanks to Maxim Levitsky for bisecting this bug.
>
> Cc: stable@vger.kernel.org
> Fixes: 52918ed5fcf0 ("KVM: SVM: Override default MMIO mask if memory encryption is enabled")
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/mmu/mmu.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index 8071952e9cf2..86619631ff6a 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -335,6 +335,8 @@ void kvm_mmu_set_mmio_spte_mask(u64 mmio_mask, u64 mmio_value, u64 access_mask)
>  {
>  	BUG_ON((u64)(unsigned)access_mask != access_mask);
>  	BUG_ON((mmio_mask & mmio_value) != mmio_value);
> +	WARN_ON(mmio_value & (shadow_nonpresent_or_rsvd_mask << shadow_nonpresent_or_rsvd_mask_len));
> +	WARN_ON(mmio_value & shadow_nonpresent_or_rsvd_lower_gfn_mask);
>  	shadow_mmio_value = mmio_value | SPTE_MMIO_MASK;
>  	shadow_mmio_mask = mmio_mask | SPTE_SPECIAL_MASK;
>  	shadow_mmio_access_mask = access_mask;
> @@ -583,16 +585,15 @@ static void kvm_mmu_reset_all_pte_masks(void)
>  	 * the most significant bits of legal physical address space.
>  	 */
>  	shadow_nonpresent_or_rsvd_mask = 0;
> -	low_phys_bits = boot_cpu_data.x86_cache_bits;
> -	if (boot_cpu_data.x86_cache_bits <
> -	    52 - shadow_nonpresent_or_rsvd_mask_len) {
> +	low_phys_bits = boot_cpu_data.x86_phys_bits;
> +	if (boot_cpu_has_bug(X86_BUG_L1TF) &&
> +	    !WARN_ON_ONCE(boot_cpu_data.x86_cache_bits >=
> +			  52 - shadow_nonpresent_or_rsvd_mask_len)) {
> +		low_phys_bits = boot_cpu_data.x86_cache_bits
> +			- shadow_nonpresent_or_rsvd_mask_len;
>  		shadow_nonpresent_or_rsvd_mask =
> -			rsvd_bits(boot_cpu_data.x86_cache_bits -
> -				  shadow_nonpresent_or_rsvd_mask_len,
> -				  boot_cpu_data.x86_cache_bits - 1);
> -		low_phys_bits -= shadow_nonpresent_or_rsvd_mask_len;
> -	} else
> -		WARN_ON_ONCE(boot_cpu_has_bug(X86_BUG_L1TF));
> +			rsvd_bits(low_phys_bits, boot_cpu_data.x86_cache_bits - 1);
> +	}
>  
>  	shadow_nonpresent_or_rsvd_lower_gfn_mask =
>  		GENMASK_ULL(low_phys_bits - 1, PAGE_SHIFT);

This indeed seems to fix previously-completely-broken 'npt=0' case,
checked with AMD EPYC 7401P.

Tested-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

