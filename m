Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD93BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DE202075B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 14:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbgEDOK1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 10:10:27 -0400
Received: from foss.arm.com ([217.140.110.172]:45706 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728910AbgEDOK1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 10:10:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 166601FB;
        Mon,  4 May 2020 07:10:26 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D515E3F305;
        Mon,  4 May 2020 07:10:24 -0700 (PDT)
Subject: Re: [PATCH v2 5/5] arm/arm64: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, harb@amperecomputing.com
References: <20200504092905.10580-1-sudeep.holla@arm.com>
 <20200504092905.10580-6-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <18382286-2aa8-54f3-e7f3-25992e908102@arm.com>
Date:   Mon, 4 May 2020 15:10:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504092905.10580-6-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/05/2020 10:29, Sudeep Holla wrote:
> SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
> SiP defined SoC identification value. Add support for the same.
> 
> Also using the SoC bus infrastructure, let us expose the platform
> specific SoC atrributes under sysfs. We also provide custom sysfs for
> the vendor ID as JEP-106 bank and identification code.
> 
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>

Some minor things below, but with those fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>   drivers/firmware/psci/Kconfig  |   9 ++
>   drivers/firmware/psci/Makefile |   1 +
>   drivers/firmware/psci/soc_id.c | 165 +++++++++++++++++++++++++++++++++
>   include/linux/arm-smccc.h      |   5 +
>   4 files changed, 180 insertions(+)
>   create mode 100644 drivers/firmware/psci/soc_id.c
> 
> diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
> index 97944168b5e6..831399338289 100644
> --- a/drivers/firmware/psci/Kconfig
> +++ b/drivers/firmware/psci/Kconfig
> @@ -12,3 +12,12 @@ config ARM_PSCI_CHECKER
>   	  The torture tests may interfere with the PSCI checker by turning CPUs
>   	  on and off through hotplug, so for now torture tests and PSCI checker
>   	  are mutually exclusive.
> +
> +config ARM_SMCCC_SOC_ID
> +	bool "SoC bus device for the ARM SMCCC SOC_ID"
> +	depends on ARM_PSCI_FW
> +	default y if ARM_PSCI_FW

Since it depends on ARM_PSCI_FW this "if" part is not needed.

> +	select SOC_BUS
> +	help
> +	  Include support for the SoC bus on the ARM SMCCC firmware based
> +	  platforms providing some sysfs information about the SoC variant.
> diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> index 1956b882470f..55596698d1ad 100644
> --- a/drivers/firmware/psci/Makefile
> +++ b/drivers/firmware/psci/Makefile
> @@ -2,3 +2,4 @@
>   #
>   obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
>   obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> +obj-$(CONFIG_ARM_SMCCC_SOC_ID)	+= soc_id.o
> diff --git a/drivers/firmware/psci/soc_id.c b/drivers/firmware/psci/soc_id.c
> new file mode 100644
> index 000000000000..b45f2d78e12e
> --- /dev/null
> +++ b/drivers/firmware/psci/soc_id.c
> @@ -0,0 +1,165 @@
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
> +#define SMCCC_SOC_ID_JEP106_BANK_IDX_MASK	GENMASK(30, 24)
> +/*
> + * As per the spec bits[23:16] are JEP-106 identification code with parity bit
> + * for the SiP. We can drop the parity bit.
> + */
> +#define SMCCC_SOC_ID_JEP106_ID_CODE_MASK	GENMASK(22, 16)
> +#define SMCCC_SOC_ID_IMP_DEF_SOC_ID_MASK	GENMASK(15, 0)
> +
> +/* The bank index is equal to the for continuation code bank number - 1 */
> +#define JEP106_BANK_CONT_CODE(x)	\
> +	(u8)(FIELD_GET(SMCCC_SOC_ID_JEP106_BANK_IDX_MASK, (x)) + 1)
> +#define JEP106_ID_CODE(x)	\
> +	(u8)(FIELD_GET(SMCCC_SOC_ID_JEP106_ID_CODE_MASK, (x)))
> +#define IMP_DEF_SOC_ID(x)	\
> +	(u16)(FIELD_GET(SMCCC_SOC_ID_IMP_DEF_SOC_ID_MASK, (x)))
> +
> +static int soc_id_version;
> +static struct soc_device *soc_dev;
> +static struct soc_device_attribute *soc_dev_attr;
> +
> +static int smccc_map_error_codes(unsigned long a0)
> +{
> +	if (a0 >= SMCCC_RET_SUCCESS)
> +		return 0;
> +	else if (a0 == SMCCC_RET_INVALID_PARAMETER)
> +		return -EINVAL;
> +	else if (a0 == SMCCC_RET_NOT_SUPPORTED)
> +		return -EOPNOTSUPP;
> +	return -EINVAL;
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
> +	return sprintf(buf, "%02x\n", JEP106_BANK_CONT_CODE(soc_id_version));
> +}
> +
> +static DEVICE_ATTR_RO(jep106_cont_bank_code);
> +
> +static ssize_t
> +jep106_identification_code_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%02x\n", JEP106_ID_CODE(soc_id_version));
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
> +
> +	ret = smccc_soc_id_support_check();
> +	if (ret) {
> +		pr_info("SMCCC SOC_ID not implemented, skipping ....\n");
> +		return 0;
> +	}
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
> +
> +	ret = smccc_map_error_codes(res.a0);
> +	if (ret) {
> +		pr_info("SMCCC SOC_ID: failed to version, Err = %d\n", ret);
                                                 ^ get/fetch
> +		return ret;
> +	}
> +
> +	soc_id_version = res.a0;
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
> +
> +	ret = smccc_map_error_codes(res.a0);
> +	if (ret) {
> +		pr_info("SMCCC SOC_ID: failed to revision, Err = %d\n", ret);
                                                 ^ get/fetch
> +		return ret;
> +	}
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

All these pr_info()s have (almost) the same initial string, it might be 
worth defining pr_fmt() and dropping it from the individual calls.

Steve

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

