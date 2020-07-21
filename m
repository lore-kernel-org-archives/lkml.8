Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B2FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C02192080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgGUDba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:31:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:28852 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726068AbgGUDb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:31:29 -0400
IronPort-SDR: n1cFz5Wg3+bKzFnozRIGuGMbcRGUwgu6CLbk7S4UK2fDVu+5ZMrm6hpNGIGd0yFoEPztwhxyqP
 tostB6LaHhjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9688"; a="147558606"
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="147558606"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2020 20:29:27 -0700
IronPort-SDR: bQ9ZdeB1D38tMA363Q8UQZuFkAnU3ksx0eFX+zAjdzEG+M1kOiji/HGcAVaneb2z50FKVYg5ze
 iljMkO8p7rrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,377,1589266800"; 
   d="scan'208";a="326246718"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.141])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2020 20:29:25 -0700
Date:   Tue, 21 Jul 2020 11:26:17 +0800
From:   Xu Yilun <yilun.xu@intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org, trix@redhat.com,
        matthew.gerlach@linux.intel.com, russell.h.weight@intel.com,
        lgoncalv@redhat.com, hao.wu@intel.com, yilun.xu@intel.com
Subject: Re: [PATCH v2 3/3] mfd: intel-m10-bmc: add Max10 BMC chip support
  for Intel FPGA PAC
Message-ID: <20200721032617.GA17091@yilunxu-OptiPlex-7050>
References: <1594896174-18826-1-git-send-email-yilun.xu@intel.com>
 <1594896174-18826-4-git-send-email-yilun.xu@intel.com>
 <20200717094542.GH3165313@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717094542.GH3165313@dell>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 10:45:42AM +0100, Lee Jones wrote:
> On Thu, 16 Jul 2020, Xu Yilun wrote:
> 
> > This patch implements the basic functions of the BMC chip for some Intel
> > FPGA PCIe Acceleration Cards (PAC). The BMC is implemented using the
> > intel max10 CPLD.
> > 
> > This BMC chip is connected to FPGA by a SPI bus. To provide reliable
> > register access from FPGA, an Avalon Memory-Mapped (Avmm) transaction
> > protocol over the SPI bus is used between host and slave.
> > 
> > This driver implements the basic register access using the
> > regmap-spi-avmm. The mfd cells array is empty now as a placeholder.
> > 
> > Signed-off-by: Xu Yilun <yilun.xu@intel.com>
> > Signed-off-by: Wu Hao <hao.wu@intel.com>
> > Signed-off-by: Matthew Gerlach <matthew.gerlach@linux.intel.com>
> > Signed-off-by: Russ Weight <russell.h.weight@intel.com>
> > Signed-off-by: Tom Rix <trix@redhat.com>
> > ---
> > v2: Split out the regmap-spi-avmm part.
> >     Rename the file intel-m10-bmc-main.c to intel-m10-bmc.c, cause
> >      there is only one source file left for this module now.
> > ---
> >  .../ABI/testing/sysfs-driver-intel-m10-bmc         |  15 ++
> >  drivers/mfd/Kconfig                                |  13 ++
> >  drivers/mfd/Makefile                               |   2 +
> >  drivers/mfd/intel-m10-bmc.c                        | 174 +++++++++++++++++++++
> >  include/linux/mfd/intel-m10-bmc.h                  |  57 +++++++
> >  5 files changed, 261 insertions(+)
> >  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> >  create mode 100644 drivers/mfd/intel-m10-bmc.c
> >  create mode 100644 include/linux/mfd/intel-m10-bmc.h
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > new file mode 100644
> > index 0000000..54cf5bc
> > --- /dev/null
> > +++ b/Documentation/ABI/testing/sysfs-driver-intel-m10-bmc
> > @@ -0,0 +1,15 @@
> > +What:		/sys/bus/spi/devices/.../bmc_version
> 
> Why is this in your MFD patch?
> 
> Again, this looks like it's documenting a SPI device?

The intel-m10-bmc device is a spi device, which contains several sub
devices in it, and I use the mfd APIs for subdev creating.
I see some example drivers in mfd folder which also match a spi/i2c parent
device and creates the sub devices. So I think I may follow the examples
and put the intel-m10-bmc driver in mfd folder.

A little difference is that the driver added 2 sysfs nodes for the
parent device itself. I'm not sure how I should document the sysfs path
correctly. The device is a mfd parent, but I didn't find a sysfs path that
could explicitly indicate its role of mfd parent.

Do you have any suggestion on that?

> 
> > +Date:		June 2020
> > +KernelVersion:	5.9
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read only. Returns the hardware build version of Intel
> > +		MAX10 BMC chip.
> > +		Format: "0x%x".
> > +
> > +What:		/sys/bus/spi/devices/.../bmcfw_version
> > +Date:		June 2020
> > +KernelVersion:	5.9
> > +Contact:	Xu Yilun <yilun.xu@intel.com>
> > +Description:	Read only. Returns the firmware version of Intel MAX10
> > +		BMC chip.
> > +		Format: "0x%x".
> 
> [...]
> 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index d13bb0a..42252c8 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -2130,5 +2130,18 @@ config SGI_MFD_IOC3
> >  	  If you have an SGI Origin, Octane, or a PCI IOC3 card,
> >  	  then say Y. Otherwise say N.
> >  
> > +config MFD_INTEL_M10_BMC
> > +	tristate "Intel MAX10 board management controller"
> 
> "Board Management Controller"

Yes, I'll change it.

> 
> > +	depends on SPI_MASTER
> > +	select REGMAP_SPI_AVMM
> > +	select MFD_CORE
> > +	help
> > +	  Support for the Intel MAX10 board management controller using the
> > +	  SPI interface.
> > +
> > +	  This driver provides common support for accessing the device,
> > +	  additional drivers must be enabled in order to use the functionality
> > +	  of the device.
> > +
> >  endmenu
> >  endif
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index 1c8d6be..149d7d1 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -265,3 +265,5 @@ obj-$(CONFIG_MFD_STMFX) 	+= stmfx.o
> >  obj-$(CONFIG_MFD_KHADAS_MCU) 	+= khadas-mcu.o
> >  
> >  obj-$(CONFIG_SGI_MFD_IOC3)	+= ioc3.o
> > +
> > +obj-$(CONFIG_MFD_INTEL_M10_BMC)   += intel-m10-bmc.o
> > diff --git a/drivers/mfd/intel-m10-bmc.c b/drivers/mfd/intel-m10-bmc.c
> > new file mode 100644
> > index 0000000..0d5e5d6
> > --- /dev/null
> > +++ b/drivers/mfd/intel-m10-bmc.c
> > @@ -0,0 +1,174 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Intel Max10 Board Management Controller chip Driver
> 
> Drop "Driver"

Yes

> 
> > + * Copyright (C) 2018-2020 Intel Corporation. All rights reserved.
> > + *
> > + */
> > +#include <linux/bitfield.h>
> > +#include <linux/mutex.h>
> > +#include <linux/regmap.h>
> > +#include <linux/module.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/init.h>
> > +#include <linux/spi/spi.h>
> > +#include <linux/mfd/intel-m10-bmc.h>
> 
> Alphabetical.

Yes

> 
> > +enum m10bmc_type {
> > +	M10_N3000,
> > +};
> 
> Will there be others?

Yes. 
The M10_N3000 is for "intel pac n3000" FPGA card. There is another M10_D5005
for "intel pac d5005" FPGA card.
We may add d5005 support later on.

> 
> > +static struct mfd_cell m10bmc_pacn3000_subdevs[] = {};
> > +
> > +static struct regmap_config intel_m10bmc_regmap_config = {
> > +	.reg_bits = 32,
> > +	.val_bits = 32,
> > +	.reg_stride = 4,
> > +	.max_register = M10BMC_MEM_END,
> > +};
> > +
> > +static ssize_t bmc_version_show(struct device *dev,
> > +				struct device_attribute *attr, char *buf)
> > +{
> > +	struct intel_m10bmc *m10bmc = dev_get_drvdata(dev);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = m10bmc_sys_read(m10bmc, M10BMC_BUILD_VER, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sprintf(buf, "0x%x\n", val);
> > +}
> > +static DEVICE_ATTR_RO(bmc_version);
> > +
> > +static ssize_t bmcfw_version_show(struct device *dev,
> > +				  struct device_attribute *attr, char *buf)
> > +{
> > +	struct intel_m10bmc *max10 = dev_get_drvdata(dev);
> > +	unsigned int val;
> > +	int ret;
> > +
> > +	ret = m10bmc_sys_read(max10, NIOS2_FW_VERSION, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return sprintf(buf, "0x%x\n", val);
> > +}
> > +static DEVICE_ATTR_RO(bmcfw_version);
> > +
> > +static struct attribute *m10bmc_attrs[] = {
> > +	&dev_attr_bmc_version.attr,
> > +	&dev_attr_bmcfw_version.attr,
> > +	NULL,
> > +};
> > +
> > +static struct attribute_group m10bmc_attr_group = {
> > +	.attrs = m10bmc_attrs,
> > +};
> > +
> > +static const struct attribute_group *m10bmc_dev_groups[] = {
> > +	&m10bmc_attr_group,
> > +	NULL
> > +};
> > +
> > +static int check_m10bmc_version(struct intel_m10bmc *m10bmc)
> > +{
> > +	unsigned int v;
> > +
> > +	if (m10bmc_raw_read(m10bmc, M10BMC_LEGACY_SYS_BASE + M10BMC_BUILD_VER,
> > +			    &v))
> > +		return -ENODEV;
> > +
> > +	if (v != 0xffffffff) {
> 
> So the only supported version number is all 1's?

No, this is to exclude the legacy version of m10bmc.
The legacy version of m10bmc has different system register base. So if
there is valid version value in the legacy version register, it is the
legacy m10bmc and we filter it out.

> 
> > +		dev_err(m10bmc->dev, "bad version M10BMC detected\n");
> > +		return -ENODEV;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static int m10bmc_spi_setup(struct spi_device *spi)
> > +{
> > +	/* try 32 bits bpw first then fall back to 8 bits bpw */
> > +	spi->mode = SPI_MODE_1;
> > +	spi->bits_per_word = 32;
> > +	if (!spi_setup(spi))
> > +		return 0;
> > +
> > +	spi->bits_per_word = 8;
> > +	return spi_setup(spi);
> 
> Looks odd.  Comments needed.

OK, I'll add more comments here.

> 
> > +}
> > +
> > +static int intel_m10_bmc_spi_probe(struct spi_device *spi)
> > +{
> > +	const struct spi_device_id *id = spi_get_device_id(spi);
> > +	struct device *dev = &spi->dev;
> > +	struct mfd_cell *cells;
> > +	struct intel_m10bmc *m10bmc;
> > +	int ret, n_cell;
> > +
> > +	ret = m10bmc_spi_setup(spi);
> > +	if (ret)
> > +		return ret;
> > +
> > +	m10bmc = devm_kzalloc(dev, sizeof(*m10bmc), GFP_KERNEL);
> > +	if (!m10bmc)
> > +		return -ENOMEM;
> > +
> > +	m10bmc->dev = dev;
> > +
> > +	m10bmc->regmap =
> > +		devm_regmap_init_spi_avmm(spi, &intel_m10bmc_regmap_config);
> > +	if (IS_ERR(m10bmc->regmap)) {
> > +		ret = PTR_ERR(m10bmc->regmap);
> > +		dev_err(dev, "Failed to allocate regmap: %d\n", ret);
> > +		return ret;
> > +	}
> > +
> > +	spi_set_drvdata(spi, m10bmc);
> > +
> > +	ret = check_m10bmc_version(m10bmc);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to identify m10bmc hardware\n");
> > +		return ret;
> > +	}
> > +
> > +	switch (id->driver_data) {
> > +	case M10_N3000:
> > +		cells = m10bmc_pacn3000_subdevs;
> > +		n_cell = ARRAY_SIZE(m10bmc_pacn3000_subdevs);
> 
> This is just an empty cell though, right?
> 
> I'm not even sure why this doesn't just crash.

Yes, I didn't add the sub device info now. I tested it will not crash,
but I think I don't have to the subdev info one by one along with the
sub device drivers, right? An empty cell is confusing.

> 
> > +		break;
> > +	default:
> > +		return -ENODEV;
> > +	}
> > +
> > +	ret = devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cells, n_cell,
> > +				   NULL, 0, NULL);
> 
> What sub-devices does this actually register?

We have 3 sub devices now.
"n3000bmc-hwmon" is a set of sensors
"n3000bmc-pkvl" is a set of ethernet phys
"m10bmc-secure" is the secure reprograming engine for FPGA

I'll add the sub devices info in my next version.

> 
> > +	if (ret)
> > +		dev_err(dev, "Failed to register sub-devices: %d\n", ret);
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct spi_device_id m10bmc_spi_id[] = {
> > +	{ "m10-n3000", M10_N3000 },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, m10bmc_spi_id);
> > +
> > +static struct spi_driver intel_m10bmc_spi_driver = {
> > +	.driver = {
> > +		.name = "intel-m10-bmc",
> > +		.dev_groups = m10bmc_dev_groups,
> > +	},
> > +	.probe = intel_m10_bmc_spi_probe,
> > +	.id_table = m10bmc_spi_id,
> > +};
> > +
> > +module_spi_driver(intel_m10bmc_spi_driver);
> > +
> > +MODULE_DESCRIPTION("Intel Max10 BMC Device Driver");
> > +MODULE_AUTHOR("Intel Corporation");
> > +MODULE_LICENSE("GPL v2");
> > +MODULE_ALIAS("spi:intel-m10-bmc");
> > diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
> > new file mode 100644
> > index 0000000..4979756
> > --- /dev/null
> > +++ b/include/linux/mfd/intel-m10-bmc.h
> > @@ -0,0 +1,57 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * Driver Header File for Intel Max10 Board Management Controller chip.
> > + *
> > + * Copyright (C) 2018-2020 Intel Corporation, Inc.
> > + *
> > + */
> > +#ifndef __INTEL_M10_BMC_H
> > +#define __INTEL_M10_BMC_H
> > +
> > +#include <linux/regmap.h>
> > +
> > +#define M10BMC_LEGACY_SYS_BASE	0x300400
> > +#define M10BMC_SYS_BASE		0x300800
> > +#define M10BMC_MEM_END		0x200000fc
> > +
> > +/* Register offset of system registers */
> > +#define NIOS2_FW_VERSION	0x0
> > +#define M10BMC_TEST_REG		0x3c
> > +#define M10BMC_BUILD_VER	0x68
> > +#define M10BMC_VER_MAJOR_MSK	GENMASK(23, 16)
> > +#define M10BMC_VER_PCB_INFO_MSK	GENMASK(31, 24)
> > +
> > +/**
> > + * struct intel_m10bmc - Intel Max10 BMC MFD device private data structure
> > + * @dev: this device
> > + * @regmap: the regmap used to access registers by m10bmc itself
> > + */
> > +struct intel_m10bmc {
> > +	struct device *dev;
> > +	struct regmap *regmap;
> > +};
> > +
> > +/*
> > + * register access helper functions.
> > + *
> > + * m10bmc_raw_read - read m10bmc register per addr
> > + * m10bmc_sys_read - read m10bmc system register per offset
> > + */
> > +static inline int
> > +m10bmc_raw_read(struct intel_m10bmc *m10bmc, unsigned int addr,
> > +		unsigned int *val)
> > +{
> > +	int ret;
> > +
> > +	ret = regmap_read(m10bmc->regmap, addr, val);
> > +	if (ret)
> > +		dev_err(m10bmc->dev, "fail to read raw reg %x: %d\n",
> > +			addr, ret);
> > +
> > +	return ret;
> > +}
> 
> Why are you abstracting Regmap?

I may paste the comments from previous patch:

  This spi-avmm IP is not dedicated to the intel Max10 bmc. It is a soft
  IP provided in Altera (now Intel) IP library. It could be implemented on
  FPGA/CPLDs according to designers need. Actually Max10 is the CPLD chip
  which is programed to have this IP on it.
  I think it may be good to implement the regmap to support any SPI chips
  with this IP.

  Another thing is, the Max10 could integrate some sub devices (soft IPs)
  which are already supported by platform drivers. Using the regmap could
  make the sub devices supported by these drivers in a generic way.

We wapper the regmap operations in an function just to help print some
error info if regmap r/w fails.

Thanks,
Yilun 

> 
> > +#define m10bmc_sys_read(m10bmc, offset, val) \
> > +	m10bmc_raw_read(m10bmc, M10BMC_SYS_BASE + (offset), val)
> > +
> > +#endif /* __INTEL_M10_BMC_H */
> 
> -- 
> Lee Jones [李琼斯]
> Senior Technical Lead - Developer Services
> Linaro.org │ Open source software for Arm SoCs
> Follow Linaro: Facebook | Twitter | Blog
