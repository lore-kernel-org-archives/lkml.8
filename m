Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EC00C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:52:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A83E2073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:52:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgAPMwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:52:21 -0500
Received: from foss.arm.com ([217.140.110.172]:49018 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgAPMwV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:52:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 632251396;
        Thu, 16 Jan 2020 04:52:20 -0800 (PST)
Received: from [10.37.9.112] (unknown [10.37.9.112])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 020443F6C4;
        Thu, 16 Jan 2020 04:52:18 -0800 (PST)
Subject: Re: [PATCH v2] arm64: cpufeature: Export matrix and other features to
 userspace
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>, julien@xen.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20191216113337.13882-1-steven.price@arm.com>
 <20200115094916.GC21692@willie-the-truck>
 <20200115095810.GD21692@willie-the-truck>
From:   Steven Price <steven.price@arm.com>
Message-ID: <87d09890-146c-a9ce-a8d9-13baaa30068d@arm.com>
Date:   Thu, 16 Jan 2020 12:52:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200115095810.GD21692@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/01/2020 09:58, Will Deacon wrote:
> On Wed, Jan 15, 2020 at 09:49:17AM +0000, Will Deacon wrote:
>> In other words, I'll drop the SPECRES parts from this patch. Sound ok?

Yes, sounds like a good idea based on what Mark linked to. The diff 
below looks right to me.

Thanks,

Steve

> 
> Diff below.
> 
> Will
> 
> --->8
> 
> diff --git a/Documentation/arm64/cpu-feature-registers.rst b/Documentation/arm64/cpu-feature-registers.rst
> index 5382981533f8..27877d25dd9b 100644
> --- a/Documentation/arm64/cpu-feature-registers.rst
> +++ b/Documentation/arm64/cpu-feature-registers.rst
> @@ -206,8 +206,6 @@ infrastructure:
>        +------------------------------+---------+---------+
>        | BF16                         | [47-44] |    y    |
>        +------------------------------+---------+---------+
> -     | SPECRES                      | [43-40] |    y    |
> -     +------------------------------+---------+---------+
>        | SB                           | [39-36] |    y    |
>        +------------------------------+---------+---------+
>        | FRINTTS                      | [35-32] |    y    |
> diff --git a/Documentation/arm64/elf_hwcaps.rst b/Documentation/arm64/elf_hwcaps.rst
> index 183ba86ad46e..4fafc57d8e73 100644
> --- a/Documentation/arm64/elf_hwcaps.rst
> +++ b/Documentation/arm64/elf_hwcaps.rst
> @@ -232,10 +232,6 @@ HWCAP2_DGH
>   
>       Functionality implied by ID_AA64ISAR1_EL1.DGH == 0b0001.
>   
> -HWCAP2_SPECRES
> -
> -    Functionality implied by ID_AA64ISAR1_EL1.SPECRES == 0b0001.
> -
>   4. Unused AT_HWCAP bits
>   -----------------------
>   
> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> index ac7180b2c20b..fcb390ea29ea 100644
> --- a/arch/arm64/include/asm/hwcap.h
> +++ b/arch/arm64/include/asm/hwcap.h
> @@ -93,7 +93,6 @@
>   #define KERNEL_HWCAP_I8MM		__khwcap2_feature(I8MM)
>   #define KERNEL_HWCAP_DGH		__khwcap2_feature(DGH)
>   #define KERNEL_HWCAP_BF16		__khwcap2_feature(BF16)
> -#define KERNEL_HWCAP_SPECRES		__khwcap2_feature(SPECRES)
>   
>   /*
>    * This yields a mask that user programs can use to figure out what
> diff --git a/arch/arm64/include/uapi/asm/hwcap.h b/arch/arm64/include/uapi/asm/hwcap.h
> index 8f3f1b66f7b2..e6dad5924703 100644
> --- a/arch/arm64/include/uapi/asm/hwcap.h
> +++ b/arch/arm64/include/uapi/asm/hwcap.h
> @@ -72,6 +72,5 @@
>   #define HWCAP2_I8MM		(1 << 13)
>   #define HWCAP2_BF16		(1 << 14)
>   #define HWCAP2_DGH		(1 << 15)
> -#define HWCAP2_SPECRES		(1 << 16)
>   
>   #endif /* _UAPI__ASM_HWCAP_H */
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9164ee5351a4..c88f8fb80e2e 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -138,7 +138,7 @@ static const struct arm64_ftr_bits ftr_id_aa64isar1[] = {
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_I8MM_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_DGH_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_BF16_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SPECRES_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SPECRES_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_SB_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64ISAR1_FRINTTS_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE_IF_IS_ENABLED(CONFIG_ARM64_PTR_AUTH),
> @@ -1678,7 +1678,6 @@ static const struct arm64_cpu_capabilities arm64_elf_hwcaps[] = {
>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_LRCPC_SHIFT, FTR_UNSIGNED, 2, CAP_HWCAP, KERNEL_HWCAP_ILRCPC),
>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_FRINTTS_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_FRINT),
>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SB_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SB),
> -	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_SPECRES_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_SPECRES),
>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_BF16_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_BF16),
>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_DGH_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_DGH),
>   	HWCAP_CAP(SYS_ID_AA64ISAR1_EL1, ID_AA64ISAR1_I8MM_SHIFT, FTR_UNSIGNED, 1, CAP_HWCAP, KERNEL_HWCAP_I8MM),
> diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
> index c689e26889c7..9013b224591a 100644
> --- a/arch/arm64/kernel/cpuinfo.c
> +++ b/arch/arm64/kernel/cpuinfo.c
> @@ -91,7 +91,6 @@ static const char *const hwcap_str[] = {
>   	"i8mm",
>   	"bf16",
>   	"dgh",
> -	"specres",
>   	NULL
>   };
>   
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 

