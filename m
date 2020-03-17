Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A220C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9DC820754
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgCQN7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:59:43 -0400
Received: from foss.arm.com ([217.140.110.172]:38618 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726148AbgCQN7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:59:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DAF01FEC;
        Tue, 17 Mar 2020 06:59:41 -0700 (PDT)
Received: from [10.37.12.184] (unknown [10.37.12.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8C0E73F534;
        Tue, 17 Mar 2020 06:59:40 -0700 (PDT)
Subject: Re: [PATCH] KVM: arm64: Use the correct timer for accessing CNT
To:     KarimAllah Ahmed <karahmed@amazon.de>
Cc:     linux-kernel@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu
References: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
From:   James Morse <james.morse@arm.com>
Openpgp: preference=signencrypt
Message-ID: <ac2933bf-452a-f27a-2d8a-8299c3044111@arm.com>
Date:   Tue, 17 Mar 2020 13:59:38 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1584351546-5018-1-git-send-email-karahmed@amazon.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi KarimAllah,

On 3/16/20 9:39 AM, KarimAllah Ahmed wrote:
> Use the physical timer object when reading the physical timer counter
> instead of using the virtual timer object. This is only visible when
> reading it from user-space as kvm_arm_timer_get_reg() is only executed on
> the get register patch from user-space.

Have you seen this go wrong?

I agree this looks like this was a typo introduced by:
84135d3d1 ("KVM: arm/arm64: consolidate arch timer trap handlers")
-----------------%<-----------------
        case KVM_REG_ARM_PTIMER_CNT:
-               return kvm_phys_timer_read();
+               return kvm_arm_timer_read(vcpu,
+                                         vcpu_vtimer(vcpu), TIMER_REG_CNT);
-----------------%<-----------------

This would be a problem when the guest reads the physical counter
directly, (which doesn't get trapped), and the VMM makes this API call
and gets a number in a totally different ball-park.


Can the VMM actually read these registers with this path?

kvm_arm_get_reg() gets to filter out the coproc registers that aren't in
the sys_reg[], it also uses is_timer_reg() to spot the timer/counter
registers, but is_timer_reg() only matches three of them:
|	case KVM_REG_ARM_TIMER_CTL:
|	case KVM_REG_ARM_TIMER_CNT:
|	case KVM_REG_ARM_TIMER_CVAL:

KVM_REG_ARM_PTIMER_CNT is not one of them.

It looks like when the VMM tries to read this, it fails is_timer_reg(),
and matches in the sys_regs[] and is handled by access_arch_timer(),
which uses kvm_arm_timer_read_sysreg() -> kvm_arm_timer_read(),
bypassing this bug.

... this looks like a bug in dead code ...


Thanks!

James

> diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
> index 0d9438e..93bd59b 100644
> --- a/virt/kvm/arm/arch_timer.c
> +++ b/virt/kvm/arm/arch_timer.c
> @@ -788,7 +788,7 @@ u64 kvm_arm_timer_get_reg(struct kvm_vcpu *vcpu, u64 regid)
>  					  vcpu_ptimer(vcpu), TIMER_REG_CTL);
>  	case KVM_REG_ARM_PTIMER_CNT:
>  		return kvm_arm_timer_read(vcpu,
> -					  vcpu_vtimer(vcpu), TIMER_REG_CNT);
> +					  vcpu_ptimer(vcpu), TIMER_REG_CNT);
>  	case KVM_REG_ARM_PTIMER_CVAL:
>  		return kvm_arm_timer_read(vcpu,
>  					  vcpu_ptimer(vcpu), TIMER_REG_CVAL);
> 

