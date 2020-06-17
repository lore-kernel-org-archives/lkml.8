Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB328C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8724920CC7
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592390871;
	bh=6JWW2IP5OHhYePQHs/w7+V8xyYWD4Gc3HpAFhwrnPQQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=0CPbNchqMEfMGl/Gb2IbUkr7be6kVwCDPMZF3NRtFhE/5pRU7ijHHM6on7S9ic4aB
	 g2BJDwkMByQZ3zTF9ktsZwHvLnvvGn5qwiMjg4hIP0CNBdZfZtRD4dJ+vl3SWOe1fI
	 cfP2CAQppCebDfzPgW+LvHBfb0y3zWgLB4ExYuoY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726326AbgFQKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:49508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbgFQKro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:47:44 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF7A208B3;
        Wed, 17 Jun 2020 10:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592390863;
        bh=6JWW2IP5OHhYePQHs/w7+V8xyYWD4Gc3HpAFhwrnPQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GJUFTinrfqpCCrY4NycRdNUZ2Hro8zeipOC3ZMeVPii/BDDvlXnBMP143bd1M6+3w
         jZJdMZR9Zt9pg5mpCY2oNSQW932LM+KXWtSA8g/yE6ibZpH3DnLHhf5Rx/J4TtcA8a
         KLSepr+obpjiYgiYjluC3GM0PJa+Dmzj2i7W5jug=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jlVbZ-003l3h-Ua; Wed, 17 Jun 2020 11:47:42 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Jun 2020 11:47:41 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Steven Price <steven.price@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH] KVM: arm64: kvm_reset_vcpu() return code incorrect with
 SVE
In-Reply-To: <20200617104339.35094-1-steven.price@arm.com>
References: <20200617104339.35094-1-steven.price@arm.com>
User-Agent: Roundcube Webmail/1.4.5
Message-ID: <c9761495762abe174e6546122916fc38@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: steven.price@arm.com, catalin.marinas@arm.com, will@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Dave.Martin@arm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steven,

On 2020-06-17 11:43, Steven Price wrote:
> If SVE is enabled then 'ret' can be assigned the return value of
> kvm_vcpu_enable_sve() which may be 0 causing future "goto out" sites to
> erroneously return 0 on failure rather than -EINVAL as expected.
> 
> Remove the initialisation of 'ret' and make setting the return value
> explicit to avoid this situation in the future.
> 
> Fixes: 9a3cdf26e336 ("KVM: arm64/sve: Allow userspace to enable SVE for 
> vcpus")
> Reported-by: James Morse <james.morse@arm.com>
> Signed-off-by: Steven Price <steven.price@arm.com>
> ---
> The problematic chunk isn't visible in the diff, so reproduced here:
> 
> 	if (!kvm_arm_vcpu_sve_finalized(vcpu)) {
> 		if (test_bit(KVM_ARM_VCPU_SVE, vcpu->arch.features)) {
> 			ret = kvm_vcpu_enable_sve(vcpu);
> 			if (ret)
> 				goto out;
> 		}
> 	} else {
> 		kvm_vcpu_reset_sve(vcpu);
> 	}
> 
>  arch/arm64/kvm/reset.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index d3b209023727..f1057603b756 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -245,7 +245,7 @@ static int kvm_vcpu_enable_ptrauth(struct kvm_vcpu 
> *vcpu)
>   */
>  int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  {
> -	int ret = -EINVAL;
> +	int ret;
>  	bool loaded;
>  	u32 pstate;
> 
> @@ -269,15 +269,19 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> 
>  	if (test_bit(KVM_ARM_VCPU_PTRAUTH_ADDRESS, vcpu->arch.features) ||
>  	    test_bit(KVM_ARM_VCPU_PTRAUTH_GENERIC, vcpu->arch.features)) {
> -		if (kvm_vcpu_enable_ptrauth(vcpu))
> +		if (kvm_vcpu_enable_ptrauth(vcpu)) {
> +			ret = -EINVAL;
>  			goto out;
> +		}
>  	}
> 
>  	switch (vcpu->arch.target) {
>  	default:
>  		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
> -			if (!cpus_have_const_cap(ARM64_HAS_32BIT_EL1))
> +			if (cpus_have_const_cap(ARM64_HAS_32BIT_EL1)) {

Do you really mean this? Seems counter-productive... :-(

> +				ret = -EINVAL;
>  				goto out;
> +			}
>  			pstate = VCPU_RESET_PSTATE_SVC;
>  		} else {
>  			pstate = VCPU_RESET_PSTATE_EL1;

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
