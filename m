Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001E6C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:05:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBF4720734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQOF4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:05:56 -0400
Received: from foss.arm.com ([217.140.110.172]:58514 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726857AbgFQOF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:05:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9DC9E31B;
        Wed, 17 Jun 2020 07:05:55 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DA5563F73C;
        Wed, 17 Jun 2020 07:05:53 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:05:47 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <Dave.Martin@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH 1/2] arm64: kvm: Save/restore MTE registers
Message-ID: <20200617140546.GE5388@gaia>
References: <20200617123844.29960-1-steven.price@arm.com>
 <20200617123844.29960-2-steven.price@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617123844.29960-2-steven.price@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 01:38:43PM +0100, Steven Price wrote:
> diff --git a/arch/arm64/kvm/hyp/sysreg-sr.c b/arch/arm64/kvm/hyp/sysreg-sr.c
> index 75b1925763f1..6ecee1528566 100644
> --- a/arch/arm64/kvm/hyp/sysreg-sr.c
> +++ b/arch/arm64/kvm/hyp/sysreg-sr.c
> @@ -26,6 +26,12 @@
>  static void __hyp_text __sysreg_save_common_state(struct kvm_cpu_context *ctxt)
>  {
>  	ctxt->sys_regs[MDSCR_EL1]	= read_sysreg(mdscr_el1);
> +	if (system_supports_mte()) {
> +		ctxt->sys_regs[RGSR_EL1] = read_sysreg_s(SYS_RGSR_EL1);
> +		ctxt->sys_regs[GCR_EL1] = read_sysreg_s(SYS_GCR_EL1);
> +		ctxt->sys_regs[TFSRE0_EL1] = read_sysreg_s(SYS_TFSRE0_EL1);
> +		ctxt->sys_regs[TFSR_EL1] = read_sysreg_s(SYS_TFSR_EL1);
> +	}

TFSR_EL1 is not a common register as we have the TFSR_EL2 as well. So
you'd have to access it as read_sysreg_el1(SYS_TFSR) so that, in the VHE
case, it generates TFSR_EL12, otherwise you just save the host register.

Also, since TFSR*_EL1 can be set asynchronously, I think we need to set
the SCTLR_EL2.ITFSB bit so that the register update is synchronised on
entry to EL2. With VHE we get this automatically as part of
SCTLR_EL1_SET but it turns out that we have another SCTLR_ELx_FLAGS
macro for the non-VHE case (why not calling this SCTLR_EL2_* I have no
idea).

>  	/*
>  	 * The host arm64 Linux uses sp_el0 to point to 'current' and it must
> @@ -99,6 +105,12 @@ NOKPROBE_SYMBOL(sysreg_save_guest_state_vhe);
>  static void __hyp_text __sysreg_restore_common_state(struct kvm_cpu_context *ctxt)
>  {
>  	write_sysreg(ctxt->sys_regs[MDSCR_EL1],	  mdscr_el1);
> +	if (system_supports_mte()) {
> +		write_sysreg_s(ctxt->sys_regs[RGSR_EL1], SYS_RGSR_EL1);
> +		write_sysreg_s(ctxt->sys_regs[GCR_EL1], SYS_GCR_EL1);
> +		write_sysreg_s(ctxt->sys_regs[TFSRE0_EL1], SYS_TFSRE0_EL1);
> +		write_sysreg_s(ctxt->sys_regs[TFSR_EL1], SYS_TFSR_EL1);
> +	}

Similarly here, you override the TFSR_EL2 with VHE enabled.

-- 
Catalin
