Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E949CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F8A208B8
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 13:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFQNf4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 09:35:56 -0400
Received: from foss.arm.com ([217.140.110.172]:58028 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgFQNfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 09:35:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9093D31B;
        Wed, 17 Jun 2020 06:35:54 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB6353F73C;
        Wed, 17 Jun 2020 06:35:52 -0700 (PDT)
Subject: Re: [PATCH v2] firmware: smccc: Add ARCH_SOC_ID support
To:     Sudeep Holla <sudeep.holla@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Harb Abdulhamid (harb@amperecomputing.com)" 
        <harb@amperecomputing.com>,
        Francois Ozog <francois.ozog@linaro.org>,
        Jose Marinho <Jose.Marinho@arm.com>,
        Etienne Carriere <etienne.carriere@st.com>
References: <20200617100559.55209-1-sudeep.holla@arm.com>
From:   Steven Price <steven.price@arm.com>
Message-ID: <ccbbae8d-8ca8-4688-4cec-58ae9962d766@arm.com>
Date:   Wed, 17 Jun 2020 14:34:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200617100559.55209-1-sudeep.holla@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/06/2020 11:05, Sudeep Holla wrote:
> SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
> SiP defined SoC identification value. Add support for the same.
> 
> Also using the SoC bus infrastructure, let us expose the platform
> specific SoC atrributes under sysfs.
> 
> There are various ways in which it can be represented in shortened form
> for efficiency and ease of parsing for userspace. The chosen form is
> described in the ABI document.
> 
> Cc: Steven Price <steven.price@arm.com>
> Cc: Etienne Carriere <etienne.carriere@st.com>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>   Documentation/ABI/testing/sysfs-devices-soc |  30 ++++++
>   drivers/firmware/smccc/Kconfig              |   9 ++
>   drivers/firmware/smccc/Makefile             |   1 +
>   drivers/firmware/smccc/soc_id.c             | 114 ++++++++++++++++++++
>   include/linux/arm-smccc.h                   |   5 +
>   5 files changed, 159 insertions(+)
>   create mode 100644 drivers/firmware/smccc/soc_id.c
> 
> Changes from v1[1] -> v2:
> 	- Dropped new jep106_id added to SoC infrastructure
> 	- Dropped all the tags(acks/reviews) as there is change in the format
> 	- Updated the format for SoC id to ensure there will be no
> 	  conflict in the namespace
> 
> [1] https://lore.kernel.org/lkml/20200522124951.35776-1-sudeep.holla@arm.com/
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-soc b/Documentation/ABI/testing/sysfs-devices-soc
> index ba3a3fac0ee1..50707f316ea9 100644
> --- a/Documentation/ABI/testing/sysfs-devices-soc
> +++ b/Documentation/ABI/testing/sysfs-devices-soc
> @@ -26,6 +26,30 @@ contact:	Lee Jones <lee.jones@linaro.org>
>   		Read-only attribute common to all SoCs. Contains SoC family name
>   		(e.g. DB8500).
>   
> +		On many of ARM based silicon with SMCCC v1.2+ compliant firmware
> +		this will contain the JEDEC JEP106 manufacturer’s identification
> +		code. The format is "jep106:XXYY" where XX is identity code and
> +		YY is continuation code.
> +
> +		This manufacturer’s identification code is defined by one
> +		or more eight (8) bit fields, each consisting of seven (7)
> +		data bits plus one (1) odd parity bit. It is a single field,
> +		limiting the possible number of vendors to 126. To expand
> +		the maximum number of identification codes, a continuation
> +		scheme has been defined.
> +
> +		The specified mechanism is that an identity code of 0x7F
> +		represents the "continuation code" and implies the presence
> +		of an additional identity code field, and this mechanism
> +		may be extended to multiple continuation codes followed
> +		by the manufacturer's identity code.
> +
> +		For example, ARM has identity code 0x7F 0x7F 0x7F 0x7F 0x3B,
> +		which is code 0x3B on the fifth 'page'. This can be shortened

NIT: s/can be/is/ - since the format always uses the short form.

> +		as JEP106 identity code of 0x3B and a continuation code of
> +		0x4 to represent the four continuation codes preceding the
> +		identity code.
> +
>   What:		/sys/devices/socX/serial_number
>   Date:		January 2019
>   contact:	Bjorn Andersson <bjorn.andersson@linaro.org>
> @@ -40,6 +64,12 @@ contact:	Lee Jones <lee.jones@linaro.org>
>   		Read-only attribute supported by most SoCs. In the case of
>   		ST-Ericsson's chips this contains the SoC serial number.
>   
> +		On many of ARM based silicon with SMCCC v1.2+ compliant firmware
> +		this will contain the SOC ID appended to the family attribute
> +		to ensure there is no clash in this namespace across various
> +		vendors. The format is "jep106:XXYY:ZZZZ" where XX is identity
> +		code, YY is continuation code and ZZZZ is the SOC ID.
> +
>   What:		/sys/devices/socX/revision
>   Date:		January 2012
>   contact:	Lee Jones <lee.jones@linaro.org>
> diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
> index 27b675d76235..15e7466179a6 100644
> --- a/drivers/firmware/smccc/Kconfig
> +++ b/drivers/firmware/smccc/Kconfig
> @@ -14,3 +14,12 @@ config HAVE_ARM_SMCCC_DISCOVERY
>   	 to add SMCCC discovery mechanism though the PSCI firmware
>   	 implementation of PSCI_FEATURES(SMCCC_VERSION) which returns
>   	 success on firmware compliant to SMCCC v1.1 and above.
> +
> +config ARM_SMCCC_SOC_ID
> +	bool "SoC bus device for the ARM SMCCC SOC_ID"
> +	depends on HAVE_ARM_SMCCC_DISCOVERY
> +	default y
> +	select SOC_BUS
> +	help
> +	  Include support for the SoC bus on the ARM SMCCC firmware based
> +	  platforms providing some sysfs information about the SoC variant.
> diff --git a/drivers/firmware/smccc/Makefile b/drivers/firmware/smccc/Makefile
> index 6f369fe3f0b9..72ab84042832 100644
> --- a/drivers/firmware/smccc/Makefile
> +++ b/drivers/firmware/smccc/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0
>   #
>   obj-$(CONFIG_HAVE_ARM_SMCCC_DISCOVERY)	+= smccc.o
> +obj-$(CONFIG_ARM_SMCCC_SOC_ID)	+= soc_id.o
> diff --git a/drivers/firmware/smccc/soc_id.c b/drivers/firmware/smccc/soc_id.c
> new file mode 100644
> index 000000000000..cf6888fd84aa
> --- /dev/null
> +++ b/drivers/firmware/smccc/soc_id.c
> @@ -0,0 +1,114 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright 2020 Arm Limited
> + */
> +
> +#define pr_fmt(fmt) "SMCCC: SOC_ID: " fmt
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
> + * As per the SMC Calling Convention specification v1.2 (ARM DEN 0028C)
> + * Section 7.4 SMCCC_ARCH_SOC_ID bits[23:16] are JEP-106 identification
> + * code with parity bit for the SiP. We can drop the parity bit.
> + */
> +#define SMCCC_SOC_ID_JEP106_ID_CODE_MASK	GENMASK(22, 16)
> +#define SMCCC_SOC_ID_IMP_DEF_SOC_ID_MASK	GENMASK(15, 0)
> +
> +#define JEP106_BANK_CONT_CODE(x)	\
> +	(u8)(FIELD_GET(SMCCC_SOC_ID_JEP106_BANK_IDX_MASK, (x)))
> +#define JEP106_ID_CODE(x)	\
> +	(u8)(FIELD_GET(SMCCC_SOC_ID_JEP106_ID_CODE_MASK, (x)))
> +#define IMP_DEF_SOC_ID(x)	\
> +	(u16)(FIELD_GET(SMCCC_SOC_ID_IMP_DEF_SOC_ID_MASK, (x)))
> +
> +static struct soc_device *soc_dev;
> +static struct soc_device_attribute *soc_dev_attr;
> +
> +static int __init smccc_soc_init(void)
> +{
> +	struct arm_smccc_res res;
> +	int soc_id_rev, soc_id_version;
> +	static char soc_id_str[16], soc_id_rev_str[12];
> +	static char soc_id_jep106_id_str[12];
> +
> +	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
> +		return 0;
> +
> +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
> +		pr_err("%s: invalid SMCCC conduit\n", __func__);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> +			     ARM_SMCCC_ARCH_SOC_ID, &res);
> +
> +	if (res.a0 == SMCCC_RET_NOT_SUPPORTED) {
> +		pr_info("ARCH_SOC_ID not implemented, skipping ....\n");
> +		return 0;
> +	}
> +
> +	if ((int)res.a0 < 0) {
> +		pr_info("ARCH_FEATURES(ARCH_SOC_ID) returned error: %lx\n",
> +			res.a0);
> +		return -EINVAL;
> +	}
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 0, &res);
> +	if ((int)res.a0 < 0) {
> +		pr_err("ARCH_SOC_ID(0) returned error: %lx\n", res.a0);
> +		return -EINVAL;
> +	}
> +
> +	soc_id_version = res.a0;
> +
> +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_SOC_ID, 1, &res);
> +	if ((int)res.a0 < 0) {
> +		pr_err("ARCH_SOC_ID(1) returned error: %lx\n", res.a0);
> +		return -EINVAL;
> +	}
> +
> +	soc_id_rev = res.a0;
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	sprintf(soc_id_rev_str, "0x%08x", soc_id_rev);
> +	sprintf(soc_id_jep106_id_str, "jep106:%02x%02x",
> +		JEP106_BANK_CONT_CODE(soc_id_version),
> +		JEP106_ID_CODE(soc_id_version));
> +	sprintf(soc_id_str, "%s:%04x", soc_id_jep106_id_str,
> +		IMP_DEF_SOC_ID(soc_id_version));

My maths might be wrong, but I think this is one byte too long:

soc_id_jep106_id_str can be 11 characters (without the NUL), then we 
have a ':' byte followed by 4 hex digits and a trailing NUL: 11 + 1 + 4 
+ 1 = 17, but the char array is 16 bytes long.

With that fixed feel free to add my "Reviewed-by".

Steve

> +
> +	soc_dev_attr->soc_id = soc_id_str;
> +	soc_dev_attr->revision = soc_id_rev_str;
> +	soc_dev_attr->family = soc_id_jep106_id_str;
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		kfree(soc_dev_attr);
> +		return PTR_ERR(soc_dev);
> +	}
> +
> +	pr_info("ID = %s Revision = %s\n", soc_dev_attr->soc_id,
> +		soc_dev_attr->revision);
> +
> +	return 0;
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
> index 56d6a5c6e353..8254e11ea857 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -71,6 +71,11 @@
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

