Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C09C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A895B2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 14:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgEAOtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 10:49:39 -0400
Received: from foss.arm.com ([217.140.110.172]:42062 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730034AbgEAOtc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 10:49:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C7BC51FB;
        Fri,  1 May 2020 07:49:31 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D57543F68F;
        Fri,  1 May 2020 07:49:28 -0700 (PDT)
Subject: Re: [PATCH 3/5] arm/arm64: smccc: Drop smccc_version enum and use
 ARM_SMCCC_VERSION_1_x instead
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
References: <20200430114814.14116-1-sudeep.holla@arm.com>
 <20200430114814.14116-4-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <e3878c66-3767-1208-a2e7-4219d9cb7c0c@arm.com>
Date:   Fri, 1 May 2020 15:48:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430114814.14116-4-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 12:48, Sudeep Holla wrote:
> Instead of maintaining 2 sets of enums/macros for tracking SMCCC version,
> let us drop smccc_version enum and use ARM_SMCCC_VERSION_1_x directly
> instead.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   arch/arm64/kernel/paravirt.c | 2 +-
>   drivers/firmware/psci/psci.c | 8 ++++----
>   include/linux/psci.h         | 7 +------
>   3 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> index 1ef702b0be2d..295d66490584 100644
> --- a/arch/arm64/kernel/paravirt.c
> +++ b/arch/arm64/kernel/paravirt.c
> @@ -120,7 +120,7 @@ static bool has_pv_steal_clock(void)
>   	struct arm_smccc_res res;
>   
>   	/* To detect the presence of PV time support we require SMCCC 1.1+ */
> -	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
> +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
>   		return false;
>   
>   	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 2937d44b5df4..6a56d7196697 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -54,12 +54,12 @@ bool psci_tos_resident_on(int cpu)
>   
>   struct psci_operations psci_ops = {
>   	.conduit = SMCCC_CONDUIT_NONE,
> -	.smccc_version = SMCCC_VERSION_1_0,
> +	.smccc_version = ARM_SMCCC_VERSION_1_0,
>   };
>   
>   enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
>   {
> -	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
> +	if (psci_ops.smccc_version < ARM_SMCCC_VERSION_1_1)
>   		return SMCCC_CONDUIT_NONE;
>   
>   	return psci_ops.conduit;
> @@ -411,8 +411,8 @@ static void __init psci_init_smccc(void)
>   	if (feature != PSCI_RET_NOT_SUPPORTED) {
>   		u32 ret;
>   		ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> -		if (ret == ARM_SMCCC_VERSION_1_1) {
> -			psci_ops.smccc_version = SMCCC_VERSION_1_1;
> +		if (ret >= ARM_SMCCC_VERSION_1_1) {
> +			psci_ops.smccc_version = ret;
>   			ver = ret;
>   		}
>   	}
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index a67712b73b6c..29bd0671e5bb 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -21,11 +21,6 @@ bool psci_power_state_is_valid(u32 state);
>   int psci_set_osi_mode(void);
>   bool psci_has_osi_support(void);
>   
> -enum smccc_version {
> -	SMCCC_VERSION_1_0,
> -	SMCCC_VERSION_1_1,
> -};
> -
>   struct psci_operations {
>   	u32 (*get_version)(void);
>   	int (*cpu_suspend)(u32 state, unsigned long entry_point);
> @@ -36,7 +31,7 @@ struct psci_operations {
>   			unsigned long lowest_affinity_level);
>   	int (*migrate_info_type)(void);
>   	enum arm_smccc_conduit conduit;
> -	enum smccc_version smccc_version;
> +	u32 smccc_version;
>   };
>   
>   extern struct psci_operations psci_ops;
> 

