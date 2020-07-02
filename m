Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD44C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E3572070C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgGBLSC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:18:02 -0400
Received: from foss.arm.com ([217.140.110.172]:40318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726475AbgGBLSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:18:01 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F1BAA1FB;
        Thu,  2 Jul 2020 04:18:00 -0700 (PDT)
Received: from [10.37.12.95] (unknown [10.37.12.95])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADF2C3F71E;
        Thu,  2 Jul 2020 04:17:58 -0700 (PDT)
Subject: Re: [PATCH V5 1/4] arm64/cpufeature: Add remaining feature bits in
 ID_AA64MMFR0 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org
References: <1590548619-3441-1-git-send-email-anshuman.khandual@arm.com>
 <1590548619-3441-2-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <3fde5a19-ffe9-f798-8e4a-fc356e271f19@arm.com>
Date:   Thu, 2 Jul 2020 12:22:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1590548619-3441-2-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/27/2020 04:03 AM, Anshuman Khandual wrote:
> Enable EVC, FGT, EXS features bits in ID_AA64MMFR0 register as per ARM DDI
> 0487F.a specification.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/sysreg.h | 3 +++
>   arch/arm64/kernel/cpufeature.c  | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index fa9d02ca4b25..cf983d03aa4c 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -703,6 +703,9 @@
>   #define ID_AA64ZFR0_SVEVER_SVE2		0x1
>   
>   /* id_aa64mmfr0 */
> +#define ID_AA64MMFR0_ECV_SHIFT		60
> +#define ID_AA64MMFR0_FGT_SHIFT		56
> +#define ID_AA64MMFR0_EXS_SHIFT		44
>   #define ID_AA64MMFR0_TGRAN4_SHIFT	28
>   #define ID_AA64MMFR0_TGRAN64_SHIFT	24
>   #define ID_AA64MMFR0_TGRAN16_SHIFT	20
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index ada9f6f9b0f6..feaa6dcd6f7b 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -267,6 +267,9 @@ static const struct arm64_ftr_bits ftr_id_aa64zfr0[] = {
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_aa64mmfr0[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_ECV_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_FGT_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR0_EXS_SHIFT, 4, 0),

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
