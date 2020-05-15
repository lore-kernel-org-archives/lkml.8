Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 544E1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29701207C4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 11:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgEOLjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 07:39:48 -0400
Received: from foss.arm.com ([217.140.110.172]:54454 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbgEOLjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 07:39:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 15873D6E;
        Fri, 15 May 2020 04:39:47 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.24.119])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EFB3B3F305;
        Fri, 15 May 2020 04:39:44 -0700 (PDT)
Date:   Fri, 15 May 2020 12:39:42 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: Re: [PATCH v3 4/7] firmware: smccc: Drop smccc_version enum and use
 ARM_SMCCC_VERSION_1_x instead
Message-ID: <20200515113942.GD67718@C02TD0UTHF1T.local>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
 <20200506164411.3284-5-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506164411.3284-5-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 06, 2020 at 05:44:08PM +0100, Sudeep Holla wrote:
> Instead of maintaining 2 sets of enums/macros for tracking SMCCC version,
> let us drop smccc_version enum and use ARM_SMCCC_VERSION_1_x directly
> instead.
> 
> This is in preparation to drop smccc_version here and move it separately
> under drivers/firmware/smccc.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Acked-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
>  arch/arm64/kernel/paravirt.c | 2 +-
>  drivers/firmware/psci/psci.c | 8 ++++----
>  include/linux/psci.h         | 7 +------
>  3 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/arm64/kernel/paravirt.c b/arch/arm64/kernel/paravirt.c
> index 1ef702b0be2d..295d66490584 100644
> --- a/arch/arm64/kernel/paravirt.c
> +++ b/arch/arm64/kernel/paravirt.c
> @@ -120,7 +120,7 @@ static bool has_pv_steal_clock(void)
>  	struct arm_smccc_res res;
>  
>  	/* To detect the presence of PV time support we require SMCCC 1.1+ */
> -	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
> +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
>  		return false;
>  
>  	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 2937d44b5df4..6a56d7196697 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -54,12 +54,12 @@ bool psci_tos_resident_on(int cpu)
>  
>  struct psci_operations psci_ops = {
>  	.conduit = SMCCC_CONDUIT_NONE,
> -	.smccc_version = SMCCC_VERSION_1_0,
> +	.smccc_version = ARM_SMCCC_VERSION_1_0,
>  };
>  
>  enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
>  {
> -	if (psci_ops.smccc_version < SMCCC_VERSION_1_1)
> +	if (psci_ops.smccc_version < ARM_SMCCC_VERSION_1_1)
>  		return SMCCC_CONDUIT_NONE;
>  
>  	return psci_ops.conduit;
> @@ -411,8 +411,8 @@ static void __init psci_init_smccc(void)
>  	if (feature != PSCI_RET_NOT_SUPPORTED) {
>  		u32 ret;
>  		ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> -		if (ret == ARM_SMCCC_VERSION_1_1) {
> -			psci_ops.smccc_version = SMCCC_VERSION_1_1;
> +		if (ret >= ARM_SMCCC_VERSION_1_1) {
> +			psci_ops.smccc_version = ret;
>  			ver = ret;
>  		}
>  	}
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index a67712b73b6c..29bd0671e5bb 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -21,11 +21,6 @@ bool psci_power_state_is_valid(u32 state);
>  int psci_set_osi_mode(void);
>  bool psci_has_osi_support(void);
>  
> -enum smccc_version {
> -	SMCCC_VERSION_1_0,
> -	SMCCC_VERSION_1_1,
> -};
> -
>  struct psci_operations {
>  	u32 (*get_version)(void);
>  	int (*cpu_suspend)(u32 state, unsigned long entry_point);
> @@ -36,7 +31,7 @@ struct psci_operations {
>  			unsigned long lowest_affinity_level);
>  	int (*migrate_info_type)(void);
>  	enum arm_smccc_conduit conduit;
> -	enum smccc_version smccc_version;
> +	u32 smccc_version;
>  };
>  
>  extern struct psci_operations psci_ops;
> -- 
> 2.17.1
> 
