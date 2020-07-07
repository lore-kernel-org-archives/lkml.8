Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D56F4C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE6EC206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 09:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGJxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 05:53:46 -0400
Received: from foss.arm.com ([217.140.110.172]:35600 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgGGJxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 05:53:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56DFDC0A;
        Tue,  7 Jul 2020 02:53:45 -0700 (PDT)
Received: from [10.37.12.102] (unknown [10.37.12.102])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CE1963F718;
        Tue,  7 Jul 2020 02:53:43 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/cpufeature: Validate feature bits spacing in
 arm64_ftr_regs[]
To:     anshuman.khandual@arm.com, linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, broonie@kernel.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org
References: <1593581140-4339-1-git-send-email-anshuman.khandual@arm.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <7cfdef28-9710-d08f-58b0-1f414cd741ba@arm.com>
Date:   Tue, 7 Jul 2020 10:58:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1593581140-4339-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 07/01/2020 06:25 AM, Anshuman Khandual wrote:
> arm64_feature_bits for a register in arm64_ftr_regs[] are in a descending
> order as per their shift values. Validate that these features bits are
> defined correctly and do not overlap with each other. This check protects
> against any inadvertent erroneous changes to the register definitions.

The patch looks fine to me. I have a few minor nits on the coding
style, feel free to ignore.


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
> Applies on 5.8-rc3.
> 
> Changes in V2:
> 
> - Replaced WARN_ON() with WARN() dropping the conditional block per Suzuki
> 
> Changes in V1: (https://patchwork.kernel.org/patch/11606285/)
> 
>   arch/arm64/kernel/cpufeature.c | 45 +++++++++++++++++++++++++++++++---
>   1 file changed, 42 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9f63053a63a9..7bd7e6f936a5 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -697,11 +697,50 @@ static s64 arm64_ftr_safe_value(const struct arm64_ftr_bits *ftrp, s64 new,
>   
>   static void __init sort_ftr_regs(void)
>   {
> -	int i;
> +	

> +	unsigned int i;


> +
> +	for (i = 0; i < ARRAY_SIZE(arm64_ftr_regs); i++) {
	 const struct arm64_ftr_reg *ftr_reg = arm64_ftr_regs[i].reg;
  	 const struct arm64_ftr_bits *ftr_bits = ftr_reg->ftr_bits;
	 unsigned int j = 0;

> +		/*
> +		 * Features here must be sorted in descending order with respect
> +		 * to their shift values and should not overlap with each other.
> +		 */
> +		ftr_reg = arm64_ftr_regs[i].reg;
> +		for (ftr_bits = ftr_reg->ftr_bits,
> +				ftr_bits->width != 0; ftr_bits++, j++) {
			unsigned int shift = ftr_bits->shift;
			unsigned int width = ftr_bits->width;
			unsigned int prev_shift;

> +			WARN((ftr_bits->shift  + ftr_bits->width) > 64,
> +				"%s has invalid feature at shift %d\n",
> +				ftr_reg->name, ftr_bits->shift);

			WARN(shit + width > 64, ....);


Either way,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
