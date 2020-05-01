Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF93BC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:07:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CF5EA2137B
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbgEAPHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:07:44 -0400
Received: from foss.arm.com ([217.140.110.172]:42302 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728981AbgEAPHn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:07:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96A2230E;
        Fri,  1 May 2020 08:07:42 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C66303F68F;
        Fri,  1 May 2020 08:07:40 -0700 (PDT)
Subject: Re: [PATCH 5/5] arm/arm64: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Harb Abdulhamid (harb@amperecomputing.com)" 
        <harb@amperecomputing.com>
References: <20200430114814.14116-1-sudeep.holla@arm.com>
 <20200430114814.14116-6-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <241f0a4b-e5bb-f3d9-40ff-b2f088129a0c@arm.com>
Date:   Fri, 1 May 2020 16:07:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200430114814.14116-6-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/2020 12:48, Sudeep Holla wrote:
> SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
> SiP defined SoC identification value. Add support for the same.
> 
> Also using the SoC bus infrastructure, let us expose the platform
> specific SoC atrributes under sysfs. We also provide custom sysfs for
> the vendor ID as JEP-106 bank and identification code.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   drivers/firmware/psci/Makefile |   2 +-
>   drivers/firmware/psci/soc_id.c | 148 +++++++++++++++++++++++++++++++++
>   include/linux/arm-smccc.h      |   5 ++
>   3 files changed, 154 insertions(+), 1 deletion(-)
>   create mode 100644 drivers/firmware/psci/soc_id.c
> 
> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> index 1956b882470f..c0b0c9ca57e4 100644
> --- a/drivers/firmware/psci/Makefile
> +++ b/drivers/firmware/psci/Makefile
> @@ -1,4 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
> -obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> +obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o soc_id.o
>   obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> diff --git a/drivers/firmware/psci/soc_id.c b/drivers/firmware/psci/soc_id.c
> new file mode 100644
> index 000000000000..820f69dad7f5
> --- /dev/null
> +++ b/drivers/firmware/psci/soc_id.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 Arm Limited
> + */
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/bitfield.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <linux/slab.h>
> +#include <linux/sys_soc.h>
> +
> +#define SOCID_JEP106_BANK_IDX_MASK	GENMASK(30, 24)
> +#define SOCID_JEP106_ID_CODE_MASK	GENMASK(23, 16)
> +#define SOCID_IMP_DEF_SOC_ID_MASK	GENMASK(15, 0)
> +#define JEP106_BANK_IDX(x)	(u8)(FIELD_GET(SOCID_JEP106_BANK_IDX_MASK, (x)))
> +#define JEP106_ID_CODE(x)	(u8)(FIELD_GET(SOCID_JEP106_ID_CODE_MASK, (x)))
> +#define IMP_DEF_SOC_ID(x)	(u16)(FIELD_GET(SOCID_IMP_DEF_SOC_ID_MASK, (x)))
> +
> +static int soc_id_version;
> +static struct soc_device *soc_dev;
> +static struct soc_device_attribute *soc_dev_attr;
> +
> +static int smccc_map_error_codes(unsigned long a0)
> +{
> +	if (a0 == SMCCC_RET_INVALID_PARAMETER)
> +		return -EINVAL;
> +	if (a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return -EOPNOTSUPP;
> +	return 0;

It seems odd to special case just those errors. While they are the only 
errors we expect, any result with the high bit set is an error (arguably 
a bug in the firmware) so should really cause an error return.

> +}
> +
> +static int smccc_soc_id_support_check(void)
> +{
> +	struct arm_smccc_res res;
> +
> +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
> +		pr_err("%s: invalid SMCCC conduit\n", __func__);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> +			     ARM_SMCCC_ARCH_SOC_ID, &res);
> +
> +	return smccc_map_error_codes(res.a0);
> +}
> +
> +static ssize_t
> +jep106_cont_bank_code_show(struct device *dev, struct device_attribute *attr,
> +			   char *buf)
> +{
> +	return sprintf(buf, "%02x\n", JEP106_BANK_IDX(soc_id_version) + 1);
> +}
> +
> +static DEVICE_ATTR_RO(jep106_cont_bank_code);
> +
> +static ssize_t
> +jep106_identification_code_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%02x\n", JEP106_ID_CODE(soc_id_version) & 0x7F);

It seems odd to have the mask defined to include a bit that is then 
always masked off. From the spec I presume this is a parity bit, but it 
would be good to have a comment explaining this.

> +}
> +
> +static DEVICE_ATTR_RO(jep106_identification_code);
> +
> +static struct attribute *jep106_id_attrs[] = {
> +	&dev_attr_jep106_cont_bank_code.attr,
> +	&dev_attr_jep106_identification_code.attr,
> +	NULL
> +};
> +
> +ATTRIBUTE_GROUPS(jep106_id);
> +
> +static int __init smccc_soc_init(void)
> +{
> +	struct device *dev;
> +	int ret, soc_id_rev;
> +	struct arm_smccc_res res;
> +	static char soc_id_str[8], soc_id_rev_str[12];
> +
> +	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
> +		return 0;

NIT: Do we actually need to check the version here - or would probing 
ARM_SMCCC_ARCH_FEATURES_FUNC_ID as is done below sufficient? I'm not 
aware of this relying on any new semantics that v1.2 added.

> +
> +	ret = smccc_soc_id_support_check();
> +	if (ret)
> +		return ret;

This seems odd - if the version is <v1.2 then we return 0. But if it's 
 >=1.2 but doesn't support SOC_ID then it's an error return?

> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
> +
> +	ret = smccc_map_error_codes(res.a0);
> +	if (ret)
> +		return ret;
> +
> +	soc_id_version = res.a0;
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
> +
> +	ret = smccc_map_error_codes(res.a0);
> +	if (ret)
> +		return ret;
> +
> +	soc_id_rev = res.a0;
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	sprintf(soc_id_str, "0x%04x", IMP_DEF_SOC_ID(soc_id_version));
> +	sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
> +
> +	soc_dev_attr->soc_id = soc_id_str;
> +	soc_dev_attr->revision = soc_id_rev_str;
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		ret = PTR_ERR(soc_dev);
> +		goto free_soc;
> +	}
> +
> +	dev = soc_device_to_device(soc_dev);
> +
> +	ret = devm_device_add_groups(dev, jep106_id_groups);
> +	if (ret) {
> +		dev_err(dev, "sysfs create failed: %d\n", ret);
> +		goto unregister_soc;
> +	}
> +
> +	pr_info("SMCCC SoC ID: %s Revision %s\n", soc_dev_attr->soc_id,
> +		soc_dev_attr->revision);
> +
> +	return 0;
> +
> +unregister_soc:
> +	soc_device_unregister(soc_dev);
> +free_soc:
> +	kfree(soc_dev_attr);
> +	return ret;
> +}
> +module_init(smccc_soc_init);
> +
> +static void __exit smccc_soc_exit(void)
> +{
> +	if (soc_dev)
> +		soc_device_unregister(soc_dev);
> +	kfree(soc_dev_attr);
> +}
> +module_exit(smccc_soc_exit);
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index d6b0f4acc707..04414fc2000f 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -68,6 +68,11 @@
>   			   ARM_SMCCC_SMC_32,				\
>   			   0, 1)
>   
> +#define ARM_SMCCC_ARCH_SOC_ID						\
> +	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
> +			   ARM_SMCCC_SMC_32,				\
> +			   0, 2)
> +
>   #define ARM_SMCCC_ARCH_WORKAROUND_1					\
>   	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,				\
>   			   ARM_SMCCC_SMC_32,				\
> 

