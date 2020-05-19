Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C72FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A11120708
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 11:08:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgESLIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 07:08:36 -0400
Received: from foss.arm.com ([217.140.110.172]:59156 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726466AbgESLIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 07:08:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9841F101E;
        Tue, 19 May 2020 04:08:35 -0700 (PDT)
Received: from [10.37.8.206] (unknown [10.37.8.206])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7B9D13F52E;
        Tue, 19 May 2020 04:08:33 -0700 (PDT)
Subject: Re: [PATCH V4 11/17] arm64/cpufeature: Add remaining feature bits in
 ID_AA64PFR1 register
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, maz@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1589881254-10082-1-git-send-email-anshuman.khandual@arm.com>
 <1589881254-10082-12-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <c3e9a322-6830-c23e-cda6-80632c84442f@arm.com>
Date:   Tue, 19 May 2020 12:13:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1589881254-10082-12-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/19/2020 10:40 AM, Anshuman Khandual wrote:
> Enable the following features bits in ID_AA64PFR1 register as per ARM DDI
> 0487F.a specification.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>   arch/arm64/include/asm/sysreg.h | 4 ++++
>   arch/arm64/kernel/cpufeature.c  | 2 ++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> index 638f6108860f..fa9d02ca4b25 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -670,7 +670,11 @@
>   #define ID_AA64PFR0_EL0_32BIT_64BIT	0x2
>   
>   /* id_aa64pfr1 */
> +#define ID_AA64PFR1_MPAMFRAC_SHIFT	16
> +#define ID_AA64PFR1_RASFRAC_SHIFT	12
> +#define ID_AA64PFR1_MTE_SHIFT		8
>   #define ID_AA64PFR1_SSBS_SHIFT		4
> +#define ID_AA64PFR1_BT_SHIFT		0

nit: You may remove this BT_SHIFT if you don't use it.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>


>   
>   #define ID_AA64PFR1_SSBS_PSTATE_NI	0
>   #define ID_AA64PFR1_SSBS_PSTATE_ONLY	1
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 39fd6cc64796..d1433f996710 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -238,6 +238,8 @@ static const struct arm64_ftr_bits ftr_id_aa64pfr0[] = {
>   };
>   
>   static const struct arm64_ftr_bits ftr_id_aa64pfr1[] = {
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_MPAMFRAC_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_RASFRAC_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64PFR1_SSBS_SHIFT, 4, ID_AA64PFR1_SSBS_PSTATE_NI),
>   	ARM64_FTR_END,
>   };
> 

