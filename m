Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ECB4C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:57:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6569320787
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 09:57:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408492AbgDOJ5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 05:57:52 -0400
Received: from foss.arm.com ([217.140.110.172]:41138 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405824AbgDOJ5r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 05:57:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C3D291063;
        Wed, 15 Apr 2020 02:57:46 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 760B13F68F;
        Wed, 15 Apr 2020 02:57:44 -0700 (PDT)
Subject: Re: [PATCH 1/8] arm64: cpufeature: Relax check for IESB support
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-2-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <ef6f287a-9233-6d5a-b0b8-f5fabe5ac2fc@arm.com>
Date:   Wed, 15 Apr 2020 11:02:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-2-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will

On 04/14/2020 10:31 PM, Will Deacon wrote:
> From: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> 
> We don't care if IESB is supported or not as we always set
> SCTLR_ELx.IESB and, if it works, that's really great.
> 
> Relax the ID_AA64MMFR2.IESB cpufeature check so that we don't warn and
> taint if it's mismatched.
> 
> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
> [will: rewrote commit message]
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>

> ---
>   arch/arm64/kernel/cpufeature.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 9fac745aa7bb..63df28e6a425 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -247,7 +247,7 @@ static const struct arm64_ftr_bits ftr_id_aa64mmfr2[] = {
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_FWB_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_VISIBLE, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_AT_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LVA_SHIFT, 4, 0),
> -	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
> +	ARM64_FTR_BITS(FTR_HIDDEN, FTR_NONSTRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_IESB_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_LSM_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_UAO_SHIFT, 4, 0),
>   	ARM64_FTR_BITS(FTR_HIDDEN, FTR_STRICT, FTR_LOWER_SAFE, ID_AA64MMFR2_CNP_SHIFT, 4, 0),
> 

