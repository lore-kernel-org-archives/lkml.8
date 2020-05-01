Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309C7C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17EB024956
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 15:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgEAP5n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 11:57:43 -0400
Received: from foss.arm.com ([217.140.110.172]:43150 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729008AbgEAP5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 11:57:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16D2D30E;
        Fri,  1 May 2020 08:57:42 -0700 (PDT)
Received: from bogus (unknown [10.37.12.80])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B90543F68F;
        Fri,  1 May 2020 08:57:39 -0700 (PDT)
Date:   Fri, 1 May 2020 16:57:29 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Harb Abdulhamid (harb@amperecomputing.com)" 
        <harb@amperecomputing.com>
Subject: Re: [PATCH 5/5] arm/arm64: smccc: Add ARCH_SOC_ID support
Message-ID: <20200501155717.GA24840@bogus>
References: <20200430114814.14116-1-sudeep.holla@arm.com>
 <20200430114814.14116-6-sudeep.holla@arm.com>
 <241f0a4b-e5bb-f3d9-40ff-b2f088129a0c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <241f0a4b-e5bb-f3d9-40ff-b2f088129a0c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,

Thanks for taking a reviewing these patches.

On Fri, May 01, 2020 at 04:07:39PM +0100, Steven Price wrote:
> On 30/04/2020 12:48, Sudeep Holla wrote:
> > SMCCC v1.2 adds a new optional function SMCCC_ARCH_SOC_ID to obtain a
> > SiP defined SoC identification value. Add support for the same.
> >
> > Also using the SoC bus infrastructure, let us expose the platform
> > specific SoC atrributes under sysfs. We also provide custom sysfs for
> > the vendor ID as JEP-106 bank and identification code.
> >
> > Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> > ---
> >   drivers/firmware/psci/Makefile |   2 +-
> >   drivers/firmware/psci/soc_id.c | 148 +++++++++++++++++++++++++++++++++
> >   include/linux/arm-smccc.h      |   5 ++
> >   3 files changed, 154 insertions(+), 1 deletion(-)
> >   create mode 100644 drivers/firmware/psci/soc_id.c
> >
> > diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
> > index 1956b882470f..c0b0c9ca57e4 100644
> > --- a/drivers/firmware/psci/Makefile
> > +++ b/drivers/firmware/psci/Makefile
> > @@ -1,4 +1,4 @@
> >   # SPDX-License-Identifier: GPL-2.0
> >   #
> > -obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
> > +obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o soc_id.o
> >   obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
> > diff --git a/drivers/firmware/psci/soc_id.c b/drivers/firmware/psci/soc_id.c
> > new file mode 100644
> > index 000000000000..820f69dad7f5
> > --- /dev/null
> > +++ b/drivers/firmware/psci/soc_id.c
> > @@ -0,0 +1,148 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright 2020 Arm Limited
> > + */
> > +
> > +#include <linux/arm-smccc.h>
> > +#include <linux/bitfield.h>
> > +#include <linux/device.h>
> > +#include <linux/module.h>
> > +#include <linux/kernel.h>
> > +#include <linux/slab.h>
> > +#include <linux/sys_soc.h>
> > +
> > +#define SOCID_JEP106_BANK_IDX_MASK	GENMASK(30, 24)
> > +#define SOCID_JEP106_ID_CODE_MASK	GENMASK(23, 16)
> > +#define SOCID_IMP_DEF_SOC_ID_MASK	GENMASK(15, 0)
> > +#define JEP106_BANK_IDX(x)	(u8)(FIELD_GET(SOCID_JEP106_BANK_IDX_MASK, (x)))
> > +#define JEP106_ID_CODE(x)	(u8)(FIELD_GET(SOCID_JEP106_ID_CODE_MASK, (x)))
> > +#define IMP_DEF_SOC_ID(x)	(u16)(FIELD_GET(SOCID_IMP_DEF_SOC_ID_MASK, (x)))
> > +
> > +static int soc_id_version;
> > +static struct soc_device *soc_dev;
> > +static struct soc_device_attribute *soc_dev_attr;
> > +
> > +static int smccc_map_error_codes(unsigned long a0)
> > +{
> > +	if (a0 == SMCCC_RET_INVALID_PARAMETER)
> > +		return -EINVAL;
> > +	if (a0 == SMCCC_RET_NOT_SUPPORTED)
> > +		return -EOPNOTSUPP;
> > +	return 0;
>
> It seems odd to special case just those errors. While they are the only
> errors we expect, any result with the high bit set is an error (arguably a
> bug in the firmware) so should really cause an error return.
>

I agree and happy to change it. I too thought about the same for a while and
they left it for review time to finalise 😄 

> > +}
> > +
> > +static int smccc_soc_id_support_check(void)
> > +{
> > +	struct arm_smccc_res res;
> > +
> > +	if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE) {
> > +		pr_err("%s: invalid SMCCC conduit\n", __func__);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	arm_smccc_1_1_invoke(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> > +			     ARM_SMCCC_ARCH_SOC_ID, &res);
> > +
> > +	return smccc_map_error_codes(res.a0);
> > +}
> > +
> > +static ssize_t
> > +jep106_cont_bank_code_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	return sprintf(buf, "%02x\n", JEP106_BANK_IDX(soc_id_version) + 1);
> > +}
> > +
> > +static DEVICE_ATTR_RO(jep106_cont_bank_code);
> > +
> > +static ssize_t
> > +jep106_identification_code_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	return sprintf(buf, "%02x\n", JEP106_ID_CODE(soc_id_version) & 0x7F);
>
> It seems odd to have the mask defined to include a bit that is then always
> masked off. From the spec I presume this is a parity bit, but it would be
> good to have a comment explaining this.
>

Sure, actually I can to make it part of the macro itself and add a note
there.

> > +}
> > +
> > +static DEVICE_ATTR_RO(jep106_identification_code);
> > +
> > +static struct attribute *jep106_id_attrs[] = {
> > +	&dev_attr_jep106_cont_bank_code.attr,
> > +	&dev_attr_jep106_identification_code.attr,
> > +	NULL
> > +};
> > +
> > +ATTRIBUTE_GROUPS(jep106_id);
> > +
> > +static int __init smccc_soc_init(void)
> > +{
> > +	struct device *dev;
> > +	int ret, soc_id_rev;
> > +	struct arm_smccc_res res;
> > +	static char soc_id_str[8], soc_id_rev_str[12];
> > +
> > +	if (arm_smccc_get_version() < ARM_SMCCC_VERSION_1_2)
> > +		return 0;
>
> NIT: Do we actually need to check the version here - or would probing
> ARM_SMCCC_ARCH_FEATURES_FUNC_ID as is done below sufficient? I'm not aware
> of this relying on any new semantics that v1.2 added.
>

It should be sufficient, but I am trying to avoid raising error if it is
not SMCCC v1.2+, hence the return 0.

> > +
> > +	ret = smccc_soc_id_support_check();
> > +	if (ret)
> > +		return ret;
>
> This seems odd - if the version is <v1.2 then we return 0. But if it's >=1.2
> but doesn't support SOC_ID then it's an error return?
>

You are right, I see that now. I can flag a note/info and return 0.

--
Regards,
Sudeep
