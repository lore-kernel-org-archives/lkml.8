Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68A67C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EA0A20757
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728962AbgEDOLR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:11:17 -0400
Received: from foss.arm.com ([217.140.110.172]:45736 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726404AbgEDOLQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:11:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FFB71FB;
        Mon,  4 May 2020 07:11:16 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0D9813F305;
        Mon,  4 May 2020 07:11:14 -0700 (PDT)
Subject: Re: [PATCH v2 4/5] firmware: psci: Add function to fetch SMCCC
 version
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
References: <20200504092905.10580-1-sudeep.holla@arm.com>
 <20200504092905.10580-5-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <3554928d-2b7c-a3d3-f16e-20e25e761710@arm.com>
Date:   Mon, 4 May 2020 15:11:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504092905.10580-5-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2020 10:29, Sudeep Holla wrote:
> For backward compatibility reasons, PSCI maintains SMCCC version as
> SMCCC didn't provide ARM_SMCCC_VERSION_FUNC_ID until v1.1
> 
> Let us provide accessors to fetch the SMCCC version in PSCI so that
> other SMCCC v1.1+ features can use it.

Since it seems there is a good reason for this patch... ;)

Reviewed-by: Steven Price <steven.price@arm.com>

Steve

> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/firmware/psci/psci.c | 5 +++++
>   include/linux/arm-smccc.h    | 9 +++++++++
>   2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> index 6a56d7196697..04426e16fee6 100644
> --- a/drivers/firmware/psci/psci.c
> +++ b/drivers/firmware/psci/psci.c
> @@ -65,6 +65,11 @@ enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void)
>   	return psci_ops.conduit;
>   }
>   
> +u32 arm_smccc_get_version(void)
> +{
> +	return psci_ops.smccc_version;
> +}
> +
>   typedef unsigned long (psci_fn)(unsigned long, unsigned long,
>   				unsigned long, unsigned long);
>   static psci_fn *invoke_psci_fn;
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index 9d9a2e42e919..d6b0f4acc707 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -98,6 +98,15 @@ enum arm_smccc_conduit {
>    */
>   enum arm_smccc_conduit arm_smccc_1_1_get_conduit(void);
>   
> +/**
> + * arm_smccc_get_version()
> + *
> + * Returns the version to be used for SMCCCv1.1 or later.
> + *
> + * When SMCCCv1.1 or above is not present, assumes and returns SMCCCv1.0.
> + */
> +u32 arm_smccc_get_version(void);
> +
>   /**
>    * struct arm_smccc_res - Result from SMC/HVC call
>    * @a0-a3 result values from registers 0 to 3
> 

