Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE87C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3216B2076C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 04:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="l5aO7L9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbgDXEhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 00:37:06 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:51342 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgDXEhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 00:37:06 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03O4augt010574;
        Thu, 23 Apr 2020 23:36:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587703016;
        bh=EK3IDClTNIlhXWnCss9gllYbcBcjybSvE7CD8sr903Q=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=l5aO7L9y2DgfHyDQx3RlZecWh3BEMM+/rC2Z4MNJAGJfHD1geX/5Pioyzfsqw27+7
         JOw4Xx50d93Vps5g7KbG31bfSBhiRug6t4XJS14YV+5qeAHqQE/m4J/s33yMdCCtvK
         C1oJvvovCUZRy50pbSpXGkFfVKf3vyWbiUSovIpE=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03O4auCu036675;
        Thu, 23 Apr 2020 23:36:56 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 23
 Apr 2020 23:36:55 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 23 Apr 2020 23:36:55 -0500
Received: from [10.24.69.20] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03O4apjk058324;
        Thu, 23 Apr 2020 23:36:52 -0500
Subject: Re: [PATCH 2/5] soc: ti: add k3 platforms chipid module driver
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200423180545.13707-1-grygorii.strashko@ti.com>
 <20200423180545.13707-3-grygorii.strashko@ti.com>
From:   Lokesh Vutla <lokeshvutla@ti.com>
Message-ID: <c4ad246f-0167-1a6c-aa15-a63a9264c78a@ti.com>
Date:   Fri, 24 Apr 2020 10:06:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20200423180545.13707-3-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/04/20 11:35 PM, Grygorii Strashko wrote:
> The Texas Instruments K3 Multicore SoC platforms have chipid module which
> is represented by CTRLMMR_xxx_JTAGID register and contains information
> about SoC id and revision.
>  Bits:
>   31-28 VARIANT Device variant
>   27-12 PARTNO  Part number
>   11-1  MFG     Indicates TI as manufacturer (0x17)
>   1             Always 1
> 
> This patch adds corresponding driver to identify the TI K3 SoC family and
> revision, and registers this information with the SoC bus. It is available
> under /sys/devices/soc0/ for user space, and can be checked, where needed,
> in Kernel using soc_device_match().
> 
> Identification is done by:
> - checking MFG to be TI ID
>  - retrieving Device variant (revision)
>  - retrieving Part number and convert it to the family
>  - retrieving machine from DT "/model"
> 
> Example J721E:
>   # cat /sys/devices/soc0/{machine,family,revision}
>   Texas Instruments K3 J721E SoC
>   J721E
>   SR1.0
> 
> Example AM65x:
>   # cat /sys/devices/soc0/{machine,family,revision}
>   Texas Instruments AM654 Base Board
>   AM65X
>   SR1.0
> 
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

Very minor comments, other than that:

Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>


> ---
>  drivers/soc/ti/Kconfig      |  10 +++
>  drivers/soc/ti/Makefile     |   1 +
>  drivers/soc/ti/k3-socinfo.c | 135 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 146 insertions(+)
>  create mode 100644 drivers/soc/ti/k3-socinfo.c
> 
> diff --git a/drivers/soc/ti/Kconfig b/drivers/soc/ti/Kconfig
> index 4486e055794c..e192fb788836 100644
> --- a/drivers/soc/ti/Kconfig
> +++ b/drivers/soc/ti/Kconfig
> @@ -91,6 +91,16 @@ config TI_K3_RINGACC
>  	  and a consumer. There is one RINGACC module per NAVSS on TI AM65x SoCs
>  	  If unsure, say N.
>  
> +config TI_K3_SOCINFO
> +	bool
> +	depends on ARCH_K3 || COMPILE_TEST
> +	select SOC_BUS
> +	select MFD_SYSCON
> +	help
> +	  Include support for the SoC bus socinfo for the TI K3 Multicore SoC
> +	  platforms to provide information about the SoC family and
> +	  variant to user space.
> +
>  endif # SOC_TI
>  
>  config TI_SCI_INTA_MSI_DOMAIN
> diff --git a/drivers/soc/ti/Makefile b/drivers/soc/ti/Makefile
> index bec827937a5f..1110e5c98685 100644
> --- a/drivers/soc/ti/Makefile
> +++ b/drivers/soc/ti/Makefile
> @@ -11,3 +11,4 @@ obj-$(CONFIG_WKUP_M3_IPC)		+= wkup_m3_ipc.o
>  obj-$(CONFIG_TI_SCI_PM_DOMAINS)		+= ti_sci_pm_domains.o
>  obj-$(CONFIG_TI_SCI_INTA_MSI_DOMAIN)	+= ti_sci_inta_msi.o
>  obj-$(CONFIG_TI_K3_RINGACC)		+= k3-ringacc.o
> +obj-$(CONFIG_TI_K3_SOCINFO)		+= k3-socinfo.o
> diff --git a/drivers/soc/ti/k3-socinfo.c b/drivers/soc/ti/k3-socinfo.c
> new file mode 100644
> index 000000000000..a0c97b3bd063
> --- /dev/null
> +++ b/drivers/soc/ti/k3-socinfo.c
> @@ -0,0 +1,135 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * TI K3 SoC info driver
> + *
> + * Copyright (C) 2020 Texas Instruments Incorporated - http://www.ti.com
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/mfd/syscon.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +#include <linux/string.h>
> +#include <linux/sys_soc.h>
> +
> +#define CTRLMMR_WKUP_JTAGID_REG		0
> +/*
> + * Bits:
> + *  31-28 VARIANT	Device variant
> + *  27-12 PARTNO	Part number
> + *  11-1  MFG		Indicates TI as manufacturer (0x17)
> + *  1			Always 1
> + */
> +#define CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT	(28)
> +#define CTRLMMR_WKUP_JTAGID_VARIANT_MASK	GENMASK(31, 28)
> +
> +#define CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT	(12)
> +#define CTRLMMR_WKUP_JTAGID_PARTNO_MASK		GENMASK(27, 12)
> +
> +#define CTRLMMR_WKUP_JTAGID_MFG_SHIFT		(1)
> +#define CTRLMMR_WKUP_JTAGID_MFG_MASK		GENMASK(11, 1)
> +
> +#define CTRLMMR_WKUP_JTAGID_MFG_TI		0x17
> +
> +static const struct k3_soc_id {
> +	unsigned int id;
> +	const char *family_name;
> +} k3_soc_ids[] = {
> +	{ 0xBB5A, "AM65X" },
> +	{ 0xBB64, "J721E" },
> +};
> +
> +static int __init partno_to_names(unsigned int partno,
> +				  struct soc_device_attribute *soc_dev_attr)
> +{
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(k3_soc_ids); i++)
> +		if (partno == k3_soc_ids[i].id) {
> +			soc_dev_attr->family = k3_soc_ids[i].family_name;
> +			return 0;
> +		}
> +
> +	return -EINVAL;
> +}
> +
> +static int __init k3_chipinfo_init(void)
> +{
> +	struct soc_device_attribute *soc_dev_attr;
> +	struct soc_device *soc_dev;
> +	struct device_node *node;
> +	struct regmap *regmap;
> +	u32 jtag_id;
> +	u32 partno_id;
> +	u32 variant;

I think you missed the reverse order here.

> +	u32 mfg;
> +	int ret;
> +
> +	node = of_find_compatible_node(NULL, NULL, "ti,am654-chipid");
> +	if (!node)
> +		return -ENODEV;
> +
> +	regmap = device_node_to_regmap(node);
> +	of_node_put(node);
> +
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	ret = regmap_read(regmap, CTRLMMR_WKUP_JTAGID_REG, &jtag_id);
> +	if (ret < 0)
> +		return ret;
> +
> +	mfg = (jtag_id & CTRLMMR_WKUP_JTAGID_MFG_MASK) >>
> +	       CTRLMMR_WKUP_JTAGID_MFG_SHIFT;
> +
> +	if (mfg != CTRLMMR_WKUP_JTAGID_MFG_TI) {
> +		pr_err("Invalid MFG SoC\n");
> +		return -ENODEV;
> +	}
> +
> +	variant = (jtag_id & CTRLMMR_WKUP_JTAGID_VARIANT_MASK) >>
> +		  CTRLMMR_WKUP_JTAGID_VARIANT_SHIFT;
> +	variant++;
> +
> +	partno_id = (jtag_id & CTRLMMR_WKUP_JTAGID_PARTNO_MASK) >>
> +		 CTRLMMR_WKUP_JTAGID_PARTNO_SHIFT;
> +
> +	soc_dev_attr = kzalloc(sizeof(*soc_dev_attr), GFP_KERNEL);
> +	if (!soc_dev_attr)
> +		return -ENOMEM;
> +
> +	soc_dev_attr->revision = kasprintf(GFP_KERNEL, "SR%x.0", variant);
> +
> +	ret = partno_to_names(partno_id, soc_dev_attr);
> +	if (ret) {
> +		pr_err("Unknown SoC JTAGID[0x%08X]\n", jtag_id);
> +		ret = -ENODEV;
> +		goto err;
> +	}
> +
> +	node = of_find_node_by_path("/");
> +	of_property_read_string(node, "model", &soc_dev_attr->machine);
> +	of_node_put(node);
> +
> +	soc_dev = soc_device_register(soc_dev_attr);
> +	if (IS_ERR(soc_dev)) {
> +		ret = PTR_ERR(soc_dev);
> +		goto err;
> +	}
> +
> +	pr_debug("Family:%s rev:%s JTAGID[0x%08x] Detected\n",
> +		 soc_dev_attr->family,
> +		 soc_dev_attr->revision, jtag_id);

May be pr_info. It is good to print SoC name and revision in the log.

Thanks and regards,
Lokesh
