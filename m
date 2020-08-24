Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FF9C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA88520838
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598273784;
	bh=3T3/3M6d5tUB1/joAHtEHHUYr19FfCdbNXJdIvPrSjM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SrmiU4wWAEh/s4eKpyJwnTsvngiZv0ugW7texYKRQYFyauBFLXD9mp6IsMvBD89u1
	 Vv5a3RjQB3mYHdxoLh1zhM8wWPfQWP/sdlq/IuC6l3QmAVcUj3suAJ3tyyjHBRKEWa
	 aerYx6Wgirywm5hoJ4IMll7GqN4+ucc7Ke1msMN8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbgHXM4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:56:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgHXMzm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:55:42 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4129F20838;
        Mon, 24 Aug 2020 12:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598273742;
        bh=3T3/3M6d5tUB1/joAHtEHHUYr19FfCdbNXJdIvPrSjM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NljT3Ab/8TrCfW/TLtp33f0y4rU4cLkuzZMzB1LmbPgQSxGSwOj4GSCKU/BGPjzCn
         GJoe4uDvNBB6H80QTdmobfHvszdSiHPuQuSCFVukmLC/8vqwgIHF3hAsgqzf/gk3GU
         23xemH8OJDMB6ZCkntlBRvfLFA9tl70hgR1j2z+8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kAC0i-006DeI-NU; Mon, 24 Aug 2020 13:55:40 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Aug 2020 13:55:40 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, james.morse@arm.com, pbonzini@redhat.com,
        kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH stable-4.4.y backport] KVM: arm/arm64: Don't reschedule in
 unmap_stage2_range()
In-Reply-To: <20200824112854.24651-1-will@kernel.org>
References: <20200824112854.24651-1-will@kernel.org>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <603f4cc58f697a3e1e5896f9bd2478e6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.morse@arm.com, pbonzini@redhat.com, kernel-team@android.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24 12:28, Will Deacon wrote:
> Upstream commits fdfe7cbd5880 ("KVM: Pass MMU notifier range flags to
> kvm_unmap_hva_range()") and b5331379bc62 ("KVM: arm64: Only reschedule
> if MMU_NOTIFIER_RANGE_BLOCKABLE is not set") fix a "sleeping from 
> invalid
> context" BUG caused by unmap_stage2_range() attempting to reschedule 
> when
> called on the OOM path.
> 
> Unfortunately, these patches rely on the MMU notifier callback being
> passed knowledge about whether or not blocking is permitted, which was
> introduced in 4.19. Rather than backport this considerable amount of
> infrastructure just for KVM on arm, instead just remove the conditional
> reschedule.
> 
> Cc: <stable@vger.kernel.org> # v4.4 only
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  arch/arm/kvm/mmu.c | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/arm/kvm/mmu.c b/arch/arm/kvm/mmu.c
> index e0267532bd4e..edd392fdc14b 100644
> --- a/arch/arm/kvm/mmu.c
> +++ b/arch/arm/kvm/mmu.c
> @@ -300,14 +300,6 @@ static void unmap_range(struct kvm *kvm, pgd_t 
> *pgdp,
>  		next = kvm_pgd_addr_end(addr, end);
>  		if (!pgd_none(*pgd))
>  			unmap_puds(kvm, pgd, addr, next);
> -		/*
> -		 * If we are dealing with a large range in
> -		 * stage2 table, release the kvm->mmu_lock
> -		 * to prevent starvation and lockup detector
> -		 * warnings.
> -		 */
> -		if (kvm && (next != end))
> -			cond_resched_lock(&kvm->mmu_lock);
>  	} while (pgd++, addr = next, addr != end);
>  }

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
