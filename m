Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB674C33CB7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC91C215A4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:33:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729536AbgA0Pdb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:33:31 -0500
Received: from foss.arm.com ([217.140.110.172]:46256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729213AbgA0Pdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:33:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2219E31B;
        Mon, 27 Jan 2020 07:33:30 -0800 (PST)
Received: from [10.1.194.46] (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 249D73F67D;
        Mon, 27 Jan 2020 07:33:28 -0800 (PST)
Subject: Re: [PATCH v2 3/6] arm64/kvm: disable access to AMU registers from
 kvm guests
To:     Ionela Voinescu <ionela.voinescu@arm.com>, catalin.marinas@arm.com,
        will@kernel.org, mark.rutland@arm.com, maz@kernel.org,
        suzuki.poulose@arm.com, sudeep.holla@arm.com,
        dietmar.eggemann@arm.com
Cc:     peterz@infradead.org, mingo@redhat.com, ggherdovich@suse.cz,
        vincent.guittot@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>
References: <20191218182607.21607-1-ionela.voinescu@arm.com>
 <20191218182607.21607-4-ionela.voinescu@arm.com>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <bc3f582c-9aed-8052-d0cb-b39c76c8ce73@arm.com>
Date:   Mon, 27 Jan 2020 15:33:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191218182607.21607-4-ionela.voinescu@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/12/2019 18:26, Ionela Voinescu wrote:
> diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
> index 6e5d839f42b5..dd20fb185d56 100644
> --- a/arch/arm64/include/asm/kvm_arm.h
> +++ b/arch/arm64/include/asm/kvm_arm.h
> @@ -266,10 +266,11 @@
>  #define CPTR_EL2_TFP_SHIFT 10
>  
>  /* Hyp Coprocessor Trap Register */
> -#define CPTR_EL2_TCPAC	(1 << 31)
> -#define CPTR_EL2_TTA	(1 << 20)
> -#define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
>  #define CPTR_EL2_TZ	(1 << 8)
> +#define CPTR_EL2_TFP	(1 << CPTR_EL2_TFP_SHIFT)
> +#define CPTR_EL2_TTA	(1 << 20)
> +#define CPTR_EL2_TAM	(1 << 30)
> +#define CPTR_EL2_TCPAC	(1 << 31)

Nit: why the #define movement? Couldn't that just be added beneath
CPTR_EL2_TCPAC?

>  #define CPTR_EL2_RES1	0x000032ff /* known RES1 bits in CPTR_EL2 */
>  #define CPTR_EL2_DEFAULT	CPTR_EL2_RES1
>  
> diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
> index 72fbbd86eb5e..0bca87a2621f 100644
> --- a/arch/arm64/kvm/hyp/switch.c
> +++ b/arch/arm64/kvm/hyp/switch.c
> @@ -90,6 +90,17 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
>  	val = read_sysreg(cpacr_el1);
>  	val |= CPACR_EL1_TTA;
>  	val &= ~CPACR_EL1_ZEN;
> +
> +	/*
> +	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}. Note that in
> +	 * this case CPACR_EL1 has the same bit layout as CPTR_EL2, and
> +	 * CPACR_EL1 accessing instructions are redefined to access CPTR_EL2.
> +	 * Therefore use CPTR_EL2.TAM bit reference to activate AMU register
> +	 * traps.
> +	 */
> +
> +	val |= CPTR_EL2_TAM;
> +

Hmm so this is a bit confusing for me, I've rewritten that part of the
email too many times (didn't help that I'm far from being a virt guru).
Rectifications are most welcome.


First, AFAICT we *don't* have HCR_EL2.TGE set anymore at this point, it's
cleared just a bit earlier in __activate_traps().


Then, your comment suggests that when we're running this code, CPACR_EL1
accesses are rerouted to CPTR_EL2. Annoyingly this isn't mentioned in
the doc of CPACR_EL1, but D5.6.3 does say

"""
When ARMv8.1-VHE is implemented, and HCR_EL2.E2H is set to 1, when executing
at EL2, some EL1 System register access instructions are redefined to access
the equivalent EL2 register.
"""

And CPACR_EL1 is part of these, so far so good. Now, the thing is
the doc for CPACR_EL1 *doesn't* mention any TAM bit - but CPTR_EL2 does.
I believe what *do* want here is to set CPTR_EL2.TAM (which IIUC we end
up doing via the rerouting).

So, providing I didn't get completely lost on the way, I have to ask:
why do we use CPACR_EL1 here? Couldn't we use CPTR_EL2 directly?


>  	if (update_fp_enabled(vcpu)) {
>  		if (vcpu_has_sve(vcpu))
>  			val |= CPACR_EL1_ZEN;
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index 9f2165937f7d..940ab9b4c98b 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1003,6 +1003,20 @@ static bool access_pmuserenr(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
>  	{ SYS_DESC(SYS_PMEVTYPERn_EL0(n)),					\
>  	  access_pmu_evtyper, reset_unknown, (PMEVTYPER0_EL0 + n), }
>  
> +static bool access_amu(struct kvm_vcpu *vcpu, struct sys_reg_params *p,
> +			     const struct sys_reg_desc *r)
> +{
> +	kvm_inject_undefined(vcpu);
> +
> +	return false;
> +}
> +
> +/* Macro to expand the AMU counter and type registers*/
> +#define AMU_AMEVCNTR0_EL0(n) { SYS_DESC(SYS_AMEVCNTR0_EL0(n)), access_amu }
> +#define AMU_AMEVTYPE0_EL0(n) { SYS_DESC(SYS_AMEVTYPE0_EL0(n)), access_amu }
> +#define AMU_AMEVCNTR1_EL0(n) { SYS_DESC(SYS_AMEVCNTR1_EL0(n)), access_amu }
> +#define AMU_AMEVTYPE1_EL0(n) { SYS_DESC(SYS_AMEVTYPE1_EL0(n)), access_amu }
> +

You could save a *whopping* two lines with something like:

#define AMU_AMEVCNTR_EL0(group, n) { SYS_DESC(SYS_AMEVCNTR##group##_EL0(n)), access_amu }
#define AMU_AMEVTYPE_EL0(group, n) { SYS_DESC(SYS_AMEVTYPE##group##_EL0(n)), access_amu }

Though it doesn't help shortening the big register list below.

>  static bool trap_ptrauth(struct kvm_vcpu *vcpu,
>  			 struct sys_reg_params *p,
>  			 const struct sys_reg_desc *rd)
> @@ -1078,8 +1092,12 @@ static u64 read_id_reg(const struct kvm_vcpu *vcpu,
>  			 (u32)r->CRn, (u32)r->CRm, (u32)r->Op2);
>  	u64 val = raz ? 0 : read_sanitised_ftr_reg(id);
>  
> -	if (id == SYS_ID_AA64PFR0_EL1 && !vcpu_has_sve(vcpu)) {
> -		val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> +	if (id == SYS_ID_AA64PFR0_EL1) {
> +		if (!vcpu_has_sve(vcpu))
> +			val &= ~(0xfUL << ID_AA64PFR0_SVE_SHIFT);
> +		val &= ~(0xfUL << ID_AA64PFR0_AMU_SHIFT);
> +	} else if (id == SYS_ID_PFR0_EL1) {
> +		val &= ~(0xfUL << ID_PFR0_AMU_SHIFT);
>  	} else if (id == SYS_ID_AA64ISAR1_EL1 && !vcpu_has_ptrauth(vcpu)) {
>  		val &= ~((0xfUL << ID_AA64ISAR1_APA_SHIFT) |
>  			 (0xfUL << ID_AA64ISAR1_API_SHIFT) |

Could almost turn the thing into a switch case at this point.
