Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1526C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C72BF20706
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 12:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598273795;
	bh=7bMktPkaqQaWzue11MGOLW/pQ9euAy2VMSZRTdulEtI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=fasqphVtZqsYbYpB0S94UaVvhdspAe453g0syO/5o2N7WAB7jeY88G6JLkT1w7CZ5
	 6e4n6M0x279BAc5/364eB/JOZ4JCBtMGZ3SwNb4/Ip7peT596ha4ntL4h4TdlF4fRW
	 dCL8zBgF3DM7mVHHsH5v6uypWCctrQI0p92q22qg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgHXM4d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 08:56:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:53392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727909AbgHXM4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 08:56:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E2A420706;
        Mon, 24 Aug 2020 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598273780;
        bh=7bMktPkaqQaWzue11MGOLW/pQ9euAy2VMSZRTdulEtI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CIWyPAAhqglvx0WFJPdJTvfL1Seen+CxwPpV6kDQk+GHl+ElQHh+OzxWndgs9UpmW
         /mu8IW3vpyN0+LxCkzq5ua/1cE8kzSC5vGPkAp93F6/v6FyHwz1poGJBMSNzpwtOYX
         t6ROws8KiM4+60/9YuHgwEG9MNXBvXAHcPUJrm9Y=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kAC1K-006DgR-Qe; Mon, 24 Aug 2020 13:56:18 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 24 Aug 2020 13:56:18 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Will Deacon <will@kernel.org>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        suzuki.poulose@arm.com, james.morse@arm.com, pbonzini@redhat.com,
        kernel-team@android.com, stable@vger.kernel.org
Subject: Re: [PATCH stable-4.14.y backport] KVM: arm/arm64: Don't reschedule
 in unmap_stage2_range()
In-Reply-To: <20200824112954.24756-1-will@kernel.org>
References: <20200824112954.24756-1-will@kernel.org>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <2d18375b13eeae3ae12dda5393154857@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: will@kernel.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, suzuki.poulose@arm.com, james.morse@arm.com, pbonzini@redhat.com, kernel-team@android.com, stable@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24 12:29, Will Deacon wrote:
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
> Cc: <stable@vger.kernel.org> # v4.14 only
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>  virt/kvm/arm/mmu.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/virt/kvm/arm/mmu.c b/virt/kvm/arm/mmu.c
> index 3814cdad643a..7fe673248e98 100644
> --- a/virt/kvm/arm/mmu.c
> +++ b/virt/kvm/arm/mmu.c
> @@ -307,12 +307,6 @@ static void unmap_stage2_range(struct kvm *kvm,
> phys_addr_t start, u64 size)
>  		next = stage2_pgd_addr_end(addr, end);
>  		if (!stage2_pgd_none(*pgd))
>  			unmap_stage2_puds(kvm, pgd, addr, next);
> -		/*
> -		 * If the range is too large, release the kvm->mmu_lock
> -		 * to prevent starvation and lockup detector warnings.
> -		 */
> -		if (next != end)
> -			cond_resched_lock(&kvm->mmu_lock);
>  	} while (pgd++, addr = next, addr != end);
>  }

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
