Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C7D4C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:03:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CA112078A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 10:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t41FeBfT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgH1KDI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 06:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729007AbgH1KCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 06:02:47 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 827F6C061236
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:02:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x7so740186wro.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 03:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=oOFwK3QCNRnl9GfVqtueGRjqs7HiYBCUA22vbKnMnmk=;
        b=t41FeBfT7WR37RFZhr6f4h8ajY4ao30Dw74/dxrZDOxVTO3+goRxqnBOwvNCQUeOnA
         xrvMZoEIY2IX/pCWWWRhJqzeVGm3F28gMyL8AdrPoA74KTYtsx+jrsFoQmENAp0Id85M
         RJHHtgkOnEWeonXI7XqG2Jd4C7jZBGdlG+wPdpmncrCjaLdO2HTMWGSLy5v8hVtnGNKB
         CXMwVebGzvoQGZcGsN3bbin4fJdGfK+f1F+ik71Pjhu4tabmUg1Mt93qInVgifwwzQZ0
         UU0YynoA6JGckk1tRgCujXAX4YctE93SpMke01a19Auj0I3BaENwbW+NbOFQzmQb8bbn
         wr6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=oOFwK3QCNRnl9GfVqtueGRjqs7HiYBCUA22vbKnMnmk=;
        b=DA8I0Y8ZB7aYOPAZa5KYlGX65XXlYUKICyN/n81ttTyQYMIEjcv2gN+OGIFPbLIZfD
         ygLZa0eQ2cV/kptqvEJSZ6fwfB5ZJhod8h4uPOe71fvAUCZhAN/EMYP6tY+SDBeidj6w
         XmKaWMOP7ZNrvhXrEwF/J/yoJSGyUxcWUmpmGIpVOEmPU3/71/biHejHW/FILAQuwZuz
         Yeal/iINLel4ygIctTFUvPo8wMIikCpfFdM7DSlbjmhxfuAO096nsP89hIFkUW8G0KKh
         iQHn9fLLA/2zKrR3JBERorxjiYa/oqkL5xtTZ2Bw45QXOi/tFkJWxYxoMyn0C0a1bEku
         PWTA==
X-Gm-Message-State: AOAM531PEFFPnP4DUZIzXFFEZwBcvbtOD0z5r43F5FzAxmqQ1lhve6JF
        Yixfv06JSFY0ejbCEAC8tdCtQA==
X-Google-Smtp-Source: ABdhPJwzShsF022CWEtyJaKVvSVkVwiwhtqXH+8F8OCySg3bgkg/163iYa76VlolPs9UMAE00TtNKA==
X-Received: by 2002:adf:83c5:: with SMTP id 63mr744201wre.321.1598608962973;
        Fri, 28 Aug 2020 03:02:42 -0700 (PDT)
Received: from dell ([91.110.221.141])
        by smtp.gmail.com with ESMTPSA id g70sm1401685wmg.24.2020.08.28.03.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 03:02:42 -0700 (PDT)
Date:   Fri, 28 Aug 2020 11:02:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Xu Yilun <yilun.xu@intel.com>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com
Subject: Re: [PATCH v4 2/2] mfd: intel-m10-bmc: add Max10 BMC chip support
 for Intel FPGA PAC
Message-ID: <20200828100236.GF1826686@dell>
References: <1597822497-25107-1-git-send-email-yilun.xu@intel.com>
 <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1597822497-25107-3-git-send-email-yilun.xu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Aug 2020, Xu Yilun wrote:

> This patch implements the basic functions of the BMC chip for some Intel
> FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> intel max10 CPLD.

Nit: "Intel MAX 10"

> This BMC chip is connected to FPGA by a SPI bus. To provide direct

Nit: "to *the* FPGA"

> register access from FPGA, the "SPI slave to Avalon Master Bridge"

Nit: "from *the* FPGA"

> (spi-avmm) IP is integrated in the chip. It converts encoded streams of
> bytes from the host to the internal register read/write on Avalon bus.

Nit: "on *the* Avalon bus"

> So This driver uses the regmap-spi-avmm for register accessing.
> 
> Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> Signed-off-by: Wu Hao <hao.wu@intel.com>
> Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> Reviewed-by: Tom Rix <trix@redhat.com>
> ---
> v2: Split out the regmap-spi-avmm part.
>     Rename the file intel-m10-bmc-main.c to intel-m10-bmc.c, cause
>      there is only one source file left for this module now.
> v3: add the sub devices in mfd_cell.
>     some minor fixes.
> v4: no change.
> ---
>  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 ++
>  drivers/mfd/Kconfig                                |  13 ++
>  drivers/mfd/Makefile                               |   2 +
>  drivers/mfd/intel-m10-bmc.c                        | 169 +++++++++++++++++++++
>  include/linux/mfd/intel-m10-bmc.h                  |  57 +++++++
>  5 files changed, 256 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
>  create mode 100644 drivers/mfd/intel-m10-bmc.c
>  create mode 100644 include/linux/mfd/intel-m10-bmc.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> new file mode 100644
> index 0000000..979a2d6
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> @@ -0,0 +1,15 @@
> +What:		/sys/bus/spi/devices/.../bmc_version
> +Date:		June 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read only. Returns the hardware build version of Intel
> +		MAX10 BMC chip.
> +		Format: "0x%x".
> +
> +What:		/sys/bus/spi/devices/.../bmcfw_version
> +Date:		June 2020
> +KernelVersion:	5.10
> +Contact:	Xu Yilun <yilun.xu@intel.com>
> +Description:	Read only. Returns the firmware version of Intel MAX10
> +		BMC chip.
> +		Format: "0x%x".
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 33df083..57745f5 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -2118,5 +2118,18 @@ config SGI_MFD_IOC3
>  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
>  	  then say Y. Otherwise say N.
>  
> +config MFD_INTEL_M10_BMC
> +	tristate "Intel MAX10 Board Management Controller"
> +	depends on SPI_MASTER
> +	select REGMAP_SPI_AVMM
> +	select MFD_CORE
> +	help
> +	  Support for the Intel MAX10 board management controller using the
> +	  SPI interface.
> +
> +	  This driver provides common support for accessing the device,
> +	  additional drivers must be enabled in order to use the functionality
> +	  of the device.
> +
>  endmenu
>  endif
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index a60e5f8..dd2cc7b 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -264,3 +264,5 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
>  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
>  
>  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> +
> +obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> new file mode 100644
> index 0000000..0dfd73a
> --- /dev/null
> +++ b/drivers/mfd/intel-m10-bmc.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Max10 Board Management Controller chip

"Intel MAX 10"

> + * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
> + *

Remove this line.

> + */
> +#include <linux/bitfield.h>
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/mfd/core.h>
> +#include <linux/mfd/intel-m10-bmc.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>

Alphabetical.

> +enum m10bmc_type {
> +	M10_N3000,
> +};

Seems over-kill.  Will there be others?

> +static struct mfd_cell m10bmc_pacn3000_subdevs[] = {
> +	{
> +		.name = "n3000bmc-hwmon",
> +	},
> +	{
> +		.name = "n3000bmc-pkvl",
> +	},
> +	{
> +		.name = "m10bmc-secure",
> +	},

Each entry on one line please.

> +

Remove this line.

> +};
> +
> +static struct regmap_config intel_m10bmc_regmap_config = {
> +	.reg_bits = 32,
> +	.val_bits = 32,
> +	.reg_stride = 4,
> +	.max_register = M10BMC_MEM_END,
> +};
> +
> +static ssize_t bmc_version_show(struct device *dev,
> +				struct device_attribute *attr, char *buf)
> +{

Does this line up to the '(' in code?

> +	struct intel_m10bmc *m10bmc = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(m10bmc, M10BMC_BUILD_VER, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", val);

Is this safe?  Have you considered snprintf()?

> +}
> +static DEVICE_ATTR_RO(bmc_version);
> +
> +static ssize_t bmcfw_version_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> +	unsigned int val;
> +	int ret;
> +
> +	ret = m10bmc_sys_read(max10, NIOS2_FW_VERSION, &val);
> +	if (ret)
> +		return ret;
> +
> +	return sprintf(buf, "0x%x\n", val);

As above.

> +}
> +static DEVICE_ATTR_RO(bmcfw_version);
> +
> +static struct attribute *m10bmc_attrs[] = {
> +	&dev_attr_bmc_version.attr,
> +	&dev_attr_bmcfw_version.attr,
> +	NULL,
> +};

Can this be const?

> +static struct attribute_group m10bmc_attr_group = {
> +	.attrs = m10bmc_attrs,
> +};

Can this be const?

> +static const struct attribute_group *m10bmc_dev_groups[] = {
> +	&m10bmc_attr_group,
> +	NULL

Comma (like above).

> +};
> +
> +static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
> +{
> +	unsigned int v;
> +
> +	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> +			    &v))
> +		return -ENODEV;

Please break functions out of if statements.

Does m10bmc_raw_read() return 0 on success?

Seems odd for a read function.

> +	if (v != 0xffffffff) {
> +		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
> +		return -ENODEV;
> +	}

The only acceptable version is -1?

> +	return 0;
> +}
> +
> +static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct device *dev = &spi->dev;
> +	struct mfd_cell *cells;
> +	struct intel_m10bmc *m10bmc;

Prefer the generic 'ddata'.

> +	int ret, n_cell;
> +
> +	m10bmc = devm_kzalloc(dev, sizeof(*m10bmc), GFP_KERNEL);
> +	if (!m10bmc)
> +		return -ENOMEM;
> +
> +	m10bmc->dev = dev;
> +
> +	m10bmc->regmap =
> +		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
> +	if (IS_ERR(m10bmc->regmap)) {
> +		ret = PTR_ERR(m10bmc->regmap);
> +		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
> +		return ret;
> +	}
> +
> +	spi_set_drvdata(spi, m10bmc);
> +
> +	ret = check_m10bmc_version(m10bmc);
> +	if (ret) {
> +		dev_err(dev, "Failed to identify m10bmc hardware\n");
> +		return ret;
> +	}
> +
> +	switch (id->driver_data) {
> +	case M10_N3000:
> +		cells = m10bmc_pacn3000_subdevs;
> +		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> +		break;
> +	default:
> +		return -ENODEV;
> +	}

Will there be other versions?

> +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> +				   NULL, 0, NULL);
> +	if (ret)
> +		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> +
> +	return ret;
> +}
> +
> +static const struct spi_device_id m10bmc_spi_id[] = {
> +	{ "m10-n3000", M10_N3000 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> +
> +static struct spi_driver intel_m10bmc_spi_driver = {
> +	.driver = {
> +		.name = "intel-m10-bmc",
> +		.dev_groups = m10bmc_dev_groups,
> +	},
> +	.probe = intel_m10_bmc_spi_probe,
> +	.id_table = m10bmc_spi_id,
> +};
> +

Remove this line.

> +module_spi_driver(intel_m10bmc_spi_driver);
> +
> +MODULE_DESCRIPTION("Intel Max10 BMC Device Driver");

"Intel MAX 10"

> +MODULE_AUTHOR("Intel Corporation");
> +MODULE_LICENSE("GPL v2");
> +MODULE_ALIAS("spi:intel-m10-bmc");
> diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> new file mode 100644
> index 0000000..4979756
> --- /dev/null
> +++ b/include/linux/mfd/intel-m10-bmc.h
> @@ -0,0 +1,57 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Driver Header File for Intel Max10 Board Management Controller chip.

Please drop the "Driver Header File for" part.

> + * Copyright (C) 2018-2020 Intel Corporation, Inc.
> + *

Remove this line.

> + */
> +#ifndef __INTEL_M10_BMC_H
> +#define __INTEL_M10_BMC_H

"__MFD_INTEL..."

> +#include <linux/regmap.h>
> +
> +#define M10BMC_LEGACY_SYS_BASE	0x300400
> +#define M10BMC_SYS_BASE		0x300800
> +#define M10BMC_MEM_END		0x200000fc
> +
> +/* Register offset of system registers */
> +#define NIOS2_FW_VERSION	0x0
> +#define M10BMC_TEST_REG		0x3c
> +#define M10BMC_BUILD_VER	0x68
> +#define M10BMC_VER_MAJOR_MSK	GENMASK(23, 16)
> +#define M10BMC_VER_PCB_INFO_MSK	GENMASK(31, 24)
> +
> +/**
> + * struct intel_m10bmc - Intel Max10 BMC MFD device private data structure

"Intel MAX 10 BMC parent driver data structure"

> + * @dev: this device
> + * @regmap: the regmap used to access registers by m10bmc itself
> + */
> +struct intel_m10bmc {
> +	struct device *dev;
> +	struct regmap *regmap;
> +};
> +
> +/*
> + * register access helper functions.
> + *
> + * m10bmc_raw_read - read m10bmc register per addr
> + * m10bmc_sys_read - read m10bmc system register per offset
> + */
> +static inline int
> +m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> +		unsigned int *val)
> +{
> +	int ret;
> +
> +	ret = regmap_read(m10bmc->regmap, addr, val);
> +	if (ret)
> +		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
> +			addr, ret);
> +
> +	return ret;
> +}
> +
> +#define m10bmc_sys_read(m10bmc, offset, val) \
> +	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)

No unnecessary abstractions.

Just use the Regmap API directly please.

> +#endif /* __INTEL_M10_BMC_H */

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
