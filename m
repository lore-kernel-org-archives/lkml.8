Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE02CC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 21:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E71A206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 21:30:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbgECVap (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 17:30:45 -0400
Received: from foss.arm.com ([217.140.110.172]:33352 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729034AbgECVao (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 17:30:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B82A31FB;
        Sun,  3 May 2020 14:30:43 -0700 (PDT)
Received: from [10.37.12.17] (unknown [10.37.12.17])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C33E73F68F;
        Sun,  3 May 2020 14:30:41 -0700 (PDT)
Subject: Re: [PATCH V3 05/16] arm64/cpufeature: Introduce ID_DFR1 CPU register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1588426445-24344-1-git-send-email-anshuman.khandual@arm.com>
 <1588426445-24344-6-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <baaccab1-4f54-bc86-4244-2dc981b2dc90@arm.com>
Date:   Sun, 3 May 2020 22:35:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1588426445-24344-6-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02/2020 02:33 PM, Anshuman Khandual wrote:
> This adds basic building blocks required for ID_DFR1 CPU register which
> provides top level information about the debug system in AArch32 state.
> This is added per ARM DDI 0487F.a specification.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/cpu.h    |  1 +
>   arch/arm64/include/asm/sysreg.h |  3 +++
>   arch/arm64/kernel/cpufeature.c  | 10 ++++++++++
>   arch/arm64/kernel/cpuinfo.c     |  1 +
>   arch/arm64/kvm/sys_regs.c       |  2 +-
>   5 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/include/asm/cpu.h b/arch/arm64/include/asm/cpu.h
> index 464e828a994d..d9a78bdec409 100644
> --- a/arch/arm64/include/asm/cpu.h
> +++ b/arch/arm64/include/asm/cpu.h
> @@ -33,6 +33,7 @@ struct cpuinfo_arm64 {
>   	u64		reg_id_aa64zfr0;
>   
>   	u32		reg_id_dfr0;
> +	u32		reg_id_dfr1;
>   	u32		reg_id_isar0;
>   	u32		reg_id_isar1;
>   	u32		reg_id_isar2;
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index c977449e02db..2e1e922e1409 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -154,6 +154,7 @@
>   #define SYS_MVFR1_EL1			sys_reg(3, 0, 0, 3, 1)
>   #define SYS_MVFR2_EL1			sys_reg(3, 0, 0, 3, 2)
>   #define SYS_ID_PFR2_EL1			sys_reg(3, 0, 0, 3, 4)
> +#define SYS_ID_DFR1_EL1			sys_reg(3, 0, 0, 3, 5)
>   
>   #define SYS_ID_AA64PFR0_EL1		sys_reg(3, 0, 0, 4, 0)
>   #define SYS_ID_AA64PFR1_EL1		sys_reg(3, 0, 0, 4, 1)
> @@ -763,6 +764,8 @@
>   #define ID_ISAR4_WITHSHIFTS_SHIFT	4
>   #define ID_ISAR4_UNPRIV_SHIFT		0
>   
> +#define ID_DFR1_MTPMU_SHIFT		0
> +
>   #define ID_ISAR0_DIVIDE_SHIFT		24
>   #define ID_ISAR0_DEBUG_SHIFT		20
>   #define ID_ISAR0_COPROC_SHIFT		16
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index a8247bf92959..2ce952d9668d 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -451,6 +451,11 @@ static const struct arm64_ftr_bits ftr_id_dfr0[] = {
>   	ARM64_FTR_END,
>   };
>   
> +static const struct arm64_ftr_bits ftr_id_dfr1[] = {
> +	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR1_MTPMU_SHIFT, 4, 0),


> -	ID_UNALLOCATED(3,5),
> +	ID_SANITISED(ID_DFR1_EL1),
>   	ID_UNALLOCATED(3,6),
>   	ID_UNALLOCATED(3,7),
>   

IIUC, we should not expose the MTPMU to the KVM guests. Either we could 
drop this entire patch, or we should emulate the MTPMU to 0 in KVM.

Suzuki
