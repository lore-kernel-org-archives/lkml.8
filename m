Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACEFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57FA82065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgENOYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 10:24:48 -0400
Received: from foss.arm.com ([217.140.110.172]:37476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbgENOYs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 10:24:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CE441FB;
        Thu, 14 May 2020 07:24:47 -0700 (PDT)
Received: from bogus (unknown [10.37.8.154])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 636883F71E;
        Thu, 14 May 2020 07:24:45 -0700 (PDT)
Date:   Thu, 14 May 2020 15:24:42 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Etienne Carriere <etienne.carriere@linaro.org>
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        lorenzo.pieralisi@arm.com, maz@kernel.org, steven.price@arm.com,
        alexios.zavras@intel.com, tglx@linutronix.de, will@kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/2] firmware: psci: support SMCCC v1.2 for SMCCC conduit
Message-ID: <20200514142442.GB23401@bogus>
References: <20200514082109.27573-1-etienne.carriere@linaro.org>
 <20200514082109.27573-2-etienne.carriere@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514082109.27573-2-etienne.carriere@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:21:09AM +0200, Etienne Carriere wrote:
> Update PSCI driver to support SMCCC v1.2 reported by secure firmware
> and indirectly make SMCCC conduit properly set when so. TF-A release
> v2.3 implements and reports SMCCC v1.2 since commit [1].
> 
> Link: [1] https://git.trustedfirmware.org/TF-A/trusted-firmware-a.git/commit/?id=e34cc0cedca6e229847c232fe58d37fad2610ce9
> Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
> ---
>  drivers/firmware/psci/psci.c | 14 ++++++++++----
>  include/linux/psci.h         |  1 +
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 2937d44b5df4..80cf73bea4b0 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -409,11 +409,17 @@ static void __init psci_init_smccc(void)
>  	feature = psci_features(ARM_SMCCC_VERSION_FUNC_ID);
>  
>  	if (feature != PSCI_RET_NOT_SUPPORTED) {
> -		u32 ret;
> -		ret = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> -		if (ret == ARM_SMCCC_VERSION_1_1) {
> +		ver = invoke_psci_fn(ARM_SMCCC_VERSION_FUNC_ID, 0, 0, 0);
> +
> +		switch (ver) {
> +		case ARM_SMCCC_VERSION_1_1:
>  			psci_ops.smccc_version = SMCCC_VERSION_1_1;
> -			ver = ret;
> +			break;
> +		case ARM_SMCCC_VERSION_1_2:
> +			psci_ops.smccc_version = SMCCC_VERSION_1_2;
> +			break;
> +		default:
> +			break;
>  		}
>  	}
>  
> diff --git a/include/linux/psci.h b/include/linux/psci.h
> index a67712b73b6c..c7d99b7f34ed 100644
> --- a/include/linux/psci.h
> +++ b/include/linux/psci.h
> @@ -24,6 +24,7 @@ bool psci_has_osi_support(void);
>  enum smccc_version {
>  	SMCCC_VERSION_1_0,
>  	SMCCC_VERSION_1_1,
> +	SMCCC_VERSION_1_2,

I took approach to kill this completely [1] instead of having to keep
expanding it for ever.

-- 
Regards,
Sudeep

[1] https://lore.kernel.org/linux-arm-kernel/20200506164411.3284-5-sudeep.holla@arm.com/
