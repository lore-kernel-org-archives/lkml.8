Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F49C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 40D9920674
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:49:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgESKtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:49:14 -0400
Received: from foss.arm.com ([217.140.110.172]:58876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbgESKtO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:49:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6BB7101E;
        Tue, 19 May 2020 03:49:10 -0700 (PDT)
Received: from [10.37.8.206] (unknown [10.37.8.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A8B63F68F;
        Tue, 19 May 2020 03:49:09 -0700 (PDT)
Subject: Re: [PATCH V4 08/17] arm64/cpufeature: Add remaining feature bits in
 ID_MMFR4 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-9-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <f0264642-7eb9-b8f2-6802-4099daea5ff7@arm.com>
Date:   Tue, 19 May 2020 11:53:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1589881254-10082-9-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
> Enable all remaining feature bits like EVT, CCIDX, LSM, HPDS, CnP, XNX,
> SpecSEI in ID_MMFR4 register per ARM DDI 0487F.a.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Mark Rutland <mark.rutland@arm.com>
> Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/sysreg.h |  8 ++++++++
>   arch/arm64/kernel/cpufeature.c  | 13 +++++++++++++
>   2 files changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 02b1246e7dbf..0a0cbb3add89 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -794,6 +794,14 @@
>   #define ID_ISAR6_DP_SHIFT		4
>   #define ID_ISAR6_JSCVT_SHIFT		0
>   
> +#define ID_MMFR4_EVT_SHIFT		28
> +#define ID_MMFR4_CCIDX_SHIFT		24
> +#define ID_MMFR4_LSM_SHIFT		20
> +#define ID_MMFR4_HPDS_SHIFT		16
> +#define ID_MMFR4_CNP_SHIFT		12
> +#define ID_MMFR4_XNX_SHIFT		8
> +#define ID_MMFR4_SPECSEI_SHIFT		0
> +
>   #define ID_MMFR5_ETS_SHIFT		0
>   
>   #define ID_PFR0_DIT_SHIFT		24
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index c929aed9fc4b..92186c40b817 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -392,7 +392,20 @@ static const struct arm64_ftr_bits ftr_id_isar5[] = {
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_mmfr4[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_EVT_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_CCIDX_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_LSM_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_HPDS_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_CNP_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_MMFR4_XNX_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, 4, 4, 0),	/* ac2 */

nit: Please could you add the "ID_MMFR4_AC2_SHIFT", while you are at it ?

Suzuki

