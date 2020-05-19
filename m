Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645BEC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46F28207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgESKlu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:41:50 -0400
Received: from foss.arm.com ([217.140.110.172]:58654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbgESKlu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:41:50 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 650AC101E;
        Tue, 19 May 2020 03:41:49 -0700 (PDT)
Received: from [10.37.8.206] (unknown [10.37.8.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 555D23F305;
        Tue, 19 May 2020 03:41:47 -0700 (PDT)
Subject: Re: [PATCH V4 05/17] arm64/cpufeature: Introduce ID_DFR1 CPU register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, james.morse@arm.com,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-6-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <9d609264-83e4-230e-8d37-46f040b79666@arm.com>
Date:   Tue, 19 May 2020 11:46:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1589881254-10082-6-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
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

> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 600ce237c487..faf644a66e89 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -457,6 +457,11 @@ static const struct arm64_ftr_bits ftr_id_dfr0[] = {
>   	ARM64_FTR_END,
>   };
>   
> +static const struct arm64_ftr_bits ftr_id_dfr1[] = {
> +	S_ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_DFR1_MTPMU_SHIFT, 4, 0),
> +	ARM64_FTR_END,
> +};
> +

> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index cb79b083f97f..50a281703d9d 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -362,6 +362,7 @@ static void __cpuinfo_store_cpu(struct cpuinfo_arm64 *info)
>   	/* Update the 32bit ID registers only if AArch32 is implemented */
>   	if (id_aa64pfr0_32bit_el0(info->reg_id_aa64pfr0)) {
>   		info->reg_id_dfr0 = read_cpuid(ID_DFR0_EL1);
> +		info->reg_id_dfr1 = read_cpuid(ID_DFR1_EL1);
>   		info->reg_id_isar0 = read_cpuid(ID_ISAR0_EL1);
>   		info->reg_id_isar1 = read_cpuid(ID_ISAR1_EL1);
>   		info->reg_id_isar2 = read_cpuid(ID_ISAR2_EL1);
> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index b784b156edb3..0723cfbff7e9 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c
> @@ -1457,7 +1457,7 @@ static const struct sys_reg_desc sys_reg_descs[] = {
>   	ID_SANITISED(MVFR2_EL1),
>   	ID_UNALLOCATED(3,3),
>   	ID_SANITISED(ID_PFR2_EL1),
> -	ID_UNALLOCATED(3,5),
> +	ID_HIDDEN(ID_DFR1_EL1),

It might be a good idea to mention why this is HIDDEN in the description.

With that :

Reviewed-by : Suzuki K Poulose <suzuki.poulose@arm.com>
