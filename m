Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E37E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C715E206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390755AbgF2VRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:17:15 -0400
Received: from foss.arm.com ([217.140.110.172]:36810 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729478AbgF2Sy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E64061042;
        Mon, 29 Jun 2020 03:37:58 -0700 (PDT)
Received: from [10.37.12.90] (unknown [10.37.12.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DCCC3F71E;
        Mon, 29 Jun 2020 03:37:57 -0700 (PDT)
Subject: Re: [PATCH] arm64/cpufeature: Validate feature bits spacing in
 arm64_ftr_regs[]
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1592274331-19006-1-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ec04ed20-1ad8-6130-ebd9-0157e5753ef6@arm.com>
Date:   Mon, 29 Jun 2020 11:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1592274331-19006-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/16/2020 03:25 AM, Anshuman Khandual wrote:
> arm64_feature_bits for a register in arm64_ftr_regs[] are in a descending
> order as per their shift values. Validate that these features bits are
> defined correctly and do not overlap with each other. This check protects
> against any inadvertent erroneous changes to the register definitions.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: Mark Brown <broonie@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Applies on 5.8-rc1.
> 
>   arch/arm64/kernel/cpufeature.c | 45 +++++++++++++++++++++++++++++++---
>   1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4ae41670c2e6..2270eda9a7fb 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -697,11 +697,50 @@ static s64 arm64_ftr_safe_value(const struct arm64_ftr_bits *ftrp, s64 new,
>   
>   static void __init sort_ftr_regs(void)
>   {
> -	int i;
> +	const struct arm64_ftr_reg *ftr_reg;
> +	const struct arm64_ftr_bits *ftr_bits;
> +	unsigned int i, j, width, shift, prev_shift;
> +
> +	for (i = 0; i < ARRAY_SIZE(arm64_ftr_regs); i++) {
> +		/*
> +		 * Features here must be sorted in descending order with respect
> +		 * to their shift values and should not overlap with each other.
> +		 */
> +		ftr_reg = arm64_ftr_regs[i].reg;
> +		for (ftr_bits = ftr_reg->ftr_bits, j = 0;
> +				ftr_bits->width != 0; ftr_bits++, j++) {
> +			if (WARN_ON(ftr_bits->shift  + ftr_bits->width > 64))
> +				pr_err("%s has invalid feature at shift %d\n",
> +					ftr_reg->name, ftr_bits->shift);

nit:

			WARN((ftr_bits->shift + ftr_bits->width) > 64,
				"%s......);?

> +
> +			/*
> +			 * Skip the first feature. There is nothing to
> +			 * compare against for now.
> +			 */
> +			if (j == 0)
> +				continue;
> +
> +			prev_shift = ftr_reg->ftr_bits[j - 1].shift;
> +			width = ftr_reg->ftr_bits[j].width;
> +			shift = ftr_reg->ftr_bits[j].shift;
> +			if (WARN_ON(prev_shift < shift + width))
> +				pr_err("%s has feature overlap at shift %d\n",
> +					ftr_reg->name, ftr_bits->shift);

same as above ?

> +		}
>   
> -	/* Check that the array is sorted so that we can do the binary search */
> -	for (i = 1; i < ARRAY_SIZE(arm64_ftr_regs); i++)
> +		/*
> +		 * Skip the first register. There is nothing to
> +		 * compare against for now.
> +		 */
> +		if (i == 0)
> +			continue;

You are starting at 1 already, so you may skip this check.

> +		/*
> +		 * Registers here must be sorted in ascending order with respect
> +		 * to sys_id for subsequent binary search in get_arm64_ftr_reg()
> +		 * to work correctly.
> +		 */
>   		BUG_ON(arm64_ftr_regs[i].sys_id < arm64_ftr_regs[i - 1].sys_id);
> +	}
>   }
>   
>   /*

Otherwise looks good to me.

Suzuki
