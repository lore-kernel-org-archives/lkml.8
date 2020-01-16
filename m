Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC48C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0535F207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 14:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgAPOhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 09:37:39 -0500
Received: from mga07.intel.com ([134.134.136.100]:28750 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgAPOhi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 09:37:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 06:37:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="scan'208";a="258746041"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 16 Jan 2020 06:37:31 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 16 Jan 2020 16:37:30 +0200
Date:   Thu, 16 Jan 2020 16:37:30 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 35/36] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200116143730.GE2838@lahna.fi.intel.com>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-36-mika.westerberg@linux.intel.com>
 <20200116132108.GH325@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116132108.GH325@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 01:21:08PM +0000, Lee Jones wrote:
> On Mon, 13 Jan 2020, Mika Westerberg wrote:
> 
> > This driver only creates a bunch of platform devices sharing resources
> > belonging to the PMC device. This is pretty much what MFD subsystem is
> > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > should be more clear what it is.
> > 
> > MFD subsystem provides nice helper APIs for subdevice creation so
> > convert the driver to use those. Unfortunately the ACPI device includes
> > separate resources for most of the subdevices so we cannot simply call
> > mfd_add_devices() to create all of them but instead we need to call it
> > separately for each device.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  drivers/mfd/Kconfig                           |  16 +-
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel_pmc_bxt.c                   | 543 +++++++++++++++
> >  drivers/platform/x86/Kconfig                  |  16 +-
> >  drivers/platform/x86/Makefile                 |   1 -
> >  drivers/platform/x86/intel_pmc_ipc.c          | 650 ------------------
> >  .../platform/x86/intel_telemetry_debugfs.c    |   2 +-
> >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> >  .../linux/mfd/intel_pmc_bxt.h                 |  11 +-
> >  9 files changed, 573 insertions(+), 669 deletions(-)
> >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> >  rename arch/x86/include/asm/intel_pmc_ipc.h => include/linux/mfd/intel_pmc_bxt.h (83%)
> > 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 59515142438e..b3b83932aaec 100644
> > --- a/drivers/mfd/Kconfig
> > +++ b/drivers/mfd/Kconfig
> > @@ -551,7 +551,7 @@ config INTEL_SOC_PMIC
> >  
> >  config INTEL_SOC_PMIC_BXTWC
> >  	tristate "Support for Intel Broxton Whiskey Cove PMIC"
> > -	depends on INTEL_PMC_IPC
> > +	depends on MFD_INTEL_PMC_BXT
> >  	select MFD_CORE
> >  	select REGMAP_IRQ
> >  	help
> > @@ -632,6 +632,20 @@ config MFD_INTEL_MSIC
> >  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
> >  	  devices used in Intel Medfield platforms.
> >  
> > +config MFD_INTEL_PMC_BXT
> > +	tristate "Intel PMC Driver for Broxton"
> > +	depends on X86
> > +	depends on X86_PLATFORM_DEVICES
> > +	depends on ACPI
> > +	select INTEL_SCU_IPC
> > +	select MFD_CORE
> > +	help
> > +	  This driver provides support for PMC (Power Management
> 
> "the PMC"

OK.

> 
> > +	  Controller) on Intel Broxton and Apollo Lake. PMC is a
> 
> "the PMC"
> 
> > +	  multi-function device that exposes IPC, General Control
> > +	  Register and P-unit access. In addition this creates devices
> > +	  for iTCO watchdog and telemetry that are part of the PMC.
> >
> >  config MFD_IPAQ_MICRO
> >  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
> >  	depends on SA1100_H3100 || SA1100_H3600
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index aed99f08739f..34563a6a047b 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -211,6 +211,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
> >  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
> >  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
> >  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
> > +obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
> >  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
> >  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
> >  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> > diff --git a/drivers/mfd/intel_pmc_bxt.c b/drivers/mfd/intel_pmc_bxt.c
> > new file mode 100644
> > index 000000000000..6cc87df4f573
> > --- /dev/null
> > +++ b/drivers/mfd/intel_pmc_bxt.c
> > @@ -0,0 +1,543 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for the Intel Broxton PMC
> > + *
> > + * (C) Copyright 2014-2015, 2020 Intel Corporation
> > + *
> > + * This driver is based on Intel SCU IPC driver(intel_scu_ipc.c) by
> > + *     Sreedhara DS <sreedhara.ds@intel.com>
> > + *
> > + * PMC running in ARC processor communicates with other entity running in IA
> > + * core through IPC mechanism which in turn messaging between IA core ad PMC.
> > + */
> 
> "The PMC" .. "on the ARC" ... "another entity" ... "the IA"
> "an IPC" ... "sends messages" ... "the IA and the PMC."

OK

> > +#include <linux/acpi.h>
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/intel_pmc_bxt.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +
> > +#include <asm/intel_scu_ipc.h>
> > +
> > +#include <linux/platform_data/itco_wdt.h>
> 
> Why are these 2 header files separated form the rest?

This was like that in the original driver. I did not want to touch
non-functional parts too much during the conversion.

> > +/* Residency with clock rate at 19.2MHz to usecs */
> > +#define S0IX_RESIDENCY_IN_USECS(d, s)		\
> > +({						\
> > +	u64 result = 10ull * ((d) + (s));	\
> > +	do_div(result, 192);			\
> > +	result;					\
> 
> OOI, what does this line do?

result becomes value of the whole expression, see:

  https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/Statement-Exprs.html#Statement-Exprs

> > +})
> > +
> > +/* exported resources from IFWI */
> 
> Proper grammar please.
> 
> "Exported"

OK

> > +#define PLAT_RESOURCE_IPC_INDEX		0
> > +#define PLAT_RESOURCE_IPC_SIZE		0x1000
> > +#define PLAT_RESOURCE_GCR_OFFSET	0x1000
> > +#define PLAT_RESOURCE_GCR_SIZE		0x1000
> > +#define PLAT_RESOURCE_BIOS_DATA_INDEX	1
> > +#define PLAT_RESOURCE_BIOS_IFACE_INDEX	2
> > +#define PLAT_RESOURCE_TELEM_SSRAM_INDEX	3
> > +#define PLAT_RESOURCE_ISP_DATA_INDEX	4
> > +#define PLAT_RESOURCE_ISP_IFACE_INDEX	5
> > +#define PLAT_RESOURCE_GTD_DATA_INDEX	6
> > +#define PLAT_RESOURCE_GTD_IFACE_INDEX	7
> > +#define PLAT_RESOURCE_ACPI_IO_INDEX	0
> > +
> > +/*
> > + * BIOS does not create an ACPI device for each PMC function,
> > + * but exports multiple resources from one ACPI device(IPC) for
> > + * multiple functions. This driver is responsible to create a
> 
> "for creating"
> 
> > + * platform device and to export resources for those functions.
> 
> Prefer "child device" or "sub-device".

OK

> > + */
> > +#define TCO_DEVICE_NAME			"iTCO_wdt"
> > +#define SMI_EN_OFFSET			0x40
> > +#define SMI_EN_SIZE			4
> > +#define TCO_BASE_OFFSET			0x60
> > +#define TCO_REGS_SIZE			16
> > +#define PUNIT_DEVICE_NAME		"intel_punit_ipc"
> > +#define TELEMETRY_DEVICE_NAME		"intel_telemetry"
> > +#define TELEM_SSRAM_SIZE		240
> > +#define TELEM_PMC_SSRAM_OFFSET		0x1B00
> > +#define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
> > +
> > +/* PMC register bit definitions */
> > +
> > +/* PMC_CFG_REG bit masks */
> > +#define PMC_CFG_NO_REBOOT_MASK		BIT_MASK(4)
> > +#define PMC_CFG_NO_REBOOT_EN		(1 << 4)
> > +#define PMC_CFG_NO_REBOOT_DIS		(0 << 4)
> > +
> > +static struct intel_pmc_dev {
> > +	struct device *dev;
> > +
> > +	/* iTCO */
> 
> Not sure these are required, the variables are clear enough.

OK

> > +	struct resource tco_res[2];
> > +
> > +	/* gcr */
> > +	void __iomem *gcr_mem_base;
> > +	spinlock_t gcr_lock;
> > +
> > +	/* punit */
> > +	struct resource punit_res[6];
> > +	unsigned int punit_res_count;
> > +
> > +	/* Telemetry */
> > +	struct resource *telem_base;
> > +} pmcdev;
> 
> Why not create this dynamically?

This is also from the original driver probably due to reasons that there
can be only a single PMC in a system.

I don't think anything prevents this to be created dynamically though.

> > +static inline u64 gcr_data_readq(u32 offset)
> > +{
> > +	return readq(pmcdev.gcr_mem_base + offset);
> > +}
> 
> Abstraction for the sake of abstraction is generally frowned upon.
> 
> > +static inline int is_gcr_valid(u32 offset)
> > +{
> > +	if (!pmcdev.gcr_mem_base)
> > +		return -EACCES;
> 
> Is this actually possible?

Now that I look at it again, it actually cannot happen so I can remove
these checks.

> 
> > +	if (offset > PLAT_RESOURCE_GCR_SIZE)
> > +		return -EINVAL;
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * intel_pmc_gcr_read64() - Read a 64-bit PMC GCR register
> > + * @offset:	offset of GCR register from GCR address base
> > + * @data:	data pointer for storing the register output
> > + *
> > + * Reads the 64-bit PMC GCR register at given offset.
> > + *
> > + * Return:	negative value on error or 0 on success.
> > + */
> > +int intel_pmc_gcr_read64(u32 offset, u64 *data)
> > +{
> > +	int ret;
> > +
> > +	spin_lock(&pmcdev.gcr_lock);
> > +
> > +	ret = is_gcr_valid(offset);
> > +	if (ret < 0) {
> > +		spin_unlock(&pmcdev.gcr_lock);
> > +		return ret;
> > +	}
> > +
> > +	*data = readq(pmcdev.gcr_mem_base + offset);
> > +
> > +	spin_unlock(&pmcdev.gcr_lock);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_pmc_gcr_read64);
> 
> What calls this?

Currently only caller is:

drivers/platform/x86/intel_telemetry_debugfs.c

> It's probably nicer to provide the caller with a memory address.

You mean MMIO address directly to the GCR registers instead of provide
this accessor?

> Maybe using Regmap?

I'll check if that can be used here.

> > +/**
> > + * intel_pmc_gcr_update() - Update PMC GCR register bits
> > + * @offset:	offset of GCR register from GCR address base
> > + * @mask:	bit mask for update operation
> > + * @val:	update value
> > + *
> > + * Updates the bits of given GCR register as specified by
> > + * @mask and @val.
> > + *
> > + * Return:	negative value on error or 0 on success.
> > + */
> > +static int intel_pmc_gcr_update(u32 offset, u32 mask, u32 val)
> > +{
> > +	u32 new_val;
> > +	int ret = 0;
> > +
> > +	spin_lock(&pmcdev.gcr_lock);
> > +
> > +	ret = is_gcr_valid(offset);
> > +	if (ret < 0)
> > +		goto gcr_unlock;
> > +
> > +	new_val = readl(pmcdev.gcr_mem_base + offset);
> > +
> > +	new_val &= ~mask;
> > +	new_val |= val & mask;
> > +
> > +	writel(new_val, pmcdev.gcr_mem_base + offset);
> > +
> > +	new_val = readl(pmcdev.gcr_mem_base + offset);
> > +
> > +	/* check whether the bit update is successful */
> > +	if ((new_val & mask) != (val & mask)) {
> > +		ret = -EIO;
> > +		goto gcr_unlock;
> > +	}
> > +
> > +gcr_unlock:
> > +	spin_unlock(&pmcdev.gcr_lock);
> > +	return ret;
> > +}
> 
> Looks like Regmap could save you the trouble here.

Agreed.

> > +static int update_no_reboot_bit(void *priv, bool set)
> > +{
> > +	u32 value = set ? PMC_CFG_NO_REBOOT_EN : PMC_CFG_NO_REBOOT_DIS;
> > +
> > +	return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
> > +				    PMC_CFG_NO_REBOOT_MASK, value);
> > +}
> 
> Only used by the Watchdog?  Maybe move in there?

Yes, this is only used by watchdog. 

We pass this function as part of itco_wdt_platform_data so that it does
not need to know the details about how to access the PMC.

> > +static ssize_t intel_pmc_simple_cmd_store(struct device *dev,
> > +					  struct device_attribute *attr,
> > +					  const char *buf, size_t count)
> > +{
> > +	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
> > +	int subcmd;
> > +	int cmd;
> > +	int ret;
> > +
> > +	ret = sscanf(buf, "%d %d", &cmd, &subcmd);
> > +	if (ret != 2) {
> > +		dev_err(dev, "Error args\n");
> 
> Maybe give the user a clue as to the format?

OK

> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = intel_scu_ipc_dev_simple_command(scu, cmd, subcmd);
> > +	if (ret) {
> > +		dev_err(dev, "command %d error with %d\n", cmd, ret);
> 
> s/error/failed/
> 
> Use English grammar please.
> 
> > +		return ret;
> > +	}
> > +	return (ssize_t)count;
> 
> No need to cast:
> 
> $ git grep -W "static ssize_t" | grep return.*count | grep ssize_t | wc -l
> 11
> $ git grep -W "static ssize_t" | grep return.*count | grep -v ssize_t | wc -l
> 3256
> 
> > +}
> > +static DEVICE_ATTR(simplecmd, 0200, NULL, intel_pmc_simple_cmd_store);
> 
> I assume you've drafted some documentation for this?

I don't think there is documentation about this yet. This is from the
original driver. I can add it though.

> If not, you need to.

Yup.

> > +static ssize_t intel_pmc_northpeak_store(struct device *dev,
> > +					 struct device_attribute *attr,
> > +					 const char *buf, size_t count)
> > +{
> > +	struct intel_scu_ipc_dev *scu = dev_get_drvdata(dev);
> > +	unsigned long val;
> > +	int subcmd;
> > +	int ret;
> > +
> > +	if (kstrtoul(buf, 0, &val))
> > +		return -EINVAL;
> > +
> > +	if (val)
> > +		subcmd = 1;
> > +	else
> > +		subcmd = 0;
> 
> '\n'
> 
> > +	ret = intel_scu_ipc_dev_simple_command(scu, PMC_IPC_NORTHPEAK_CTRL, subcmd);
> > +	if (ret) {
> > +		dev_err(dev, "command north %d error with %d\n", subcmd, ret);
> 
> Use English grammar please.
> 
> > +		return ret;
> > +	}
> > +	return (ssize_t)count;
> > +}
> > +static DEVICE_ATTR(northpeak, 0200, NULL, intel_pmc_northpeak_store);
> 
> So a user can write any command to the PMC from userspace?

Yup.

> Is that a good idea?  No security implications for doing so?

No don't think it is a good idea to be honest. I would like to get rid
of both of these but the problem is that these are part of userspace ABI
(that was exposed by to original driver) so changing it may break
something.

> ...
> 
> I assume you've drafted some documentation for this?
> 
> If not, you need to.

OK

> > +static struct attribute *intel_pmc_attrs[] = {
> > +	&dev_attr_northpeak.attr,
> > +	&dev_attr_simplecmd.attr,
> > +	NULL
> > +};
> > +
> > +static const struct attribute_group intel_pmc_group = {
> > +	.attrs = intel_pmc_attrs,
> > +};
> > +
> > +static const struct attribute_group *intel_pmc_groups[] = {
> > +	&intel_pmc_group,
> > +	NULL
> > +};
> > +
> > +static int pmc_create_punit_device(void)
> > +{
> > +	struct mfd_cell punit = {
> > +		.name = PUNIT_DEVICE_NAME,
> > +		.resources = pmcdev.punit_res,
> > +		.num_resources = pmcdev.punit_res_count,
> > +	};
> 
> It's more common/preferred to create static structs.
> 
> Lots of examples in drivers/mfd.

OK

> > +	if (!pmcdev.punit_res_count)
> > +		return 0;
> > +
> > +	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &punit, 1,
> > +				    NULL, 0, NULL);
> > +}
> > +
> > +static int pmc_create_tco_device(void)
> > +{
> > +	struct itco_wdt_platform_data tco_info = {
> > +		.name = "Apollo Lake SoC",
> > +		.version = 5,
> > +		.no_reboot_priv = &pmcdev,
> > +		.update_no_reboot_bit = update_no_reboot_bit,
> > +	};
> > +	struct mfd_cell tco = {
> > +		.name = TCO_DEVICE_NAME,
> > +		.ignore_resource_conflicts = true,
> > +		.platform_data = &tco_info,
> > +		.pdata_size = sizeof(tco_info),
> > +		.resources = pmcdev.tco_res,
> > +		.num_resources = ARRAY_SIZE(pmcdev.tco_res),
> > +	};
> > +
> > +	if (!pmcdev.tco_res[0].start)
> > +		return 0;
> 
> How would this be possible?

It is not anymore (it used to be in at some point in the series). I'll
remove this check.

> > +	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &tco, 1,
> > +				    NULL, 0, NULL);
> > +}
> > +
> > +static int pmc_create_telemetry_device(void)
> > +{
> > +	struct resource telem_res[] = {
> > +		DEFINE_RES_MEM(TELEM_PUNIT_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > +		DEFINE_RES_MEM(TELEM_PMC_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > +	};
> > +	struct mfd_cell telem  = {
> > +		.name = TELEMETRY_DEVICE_NAME,
> > +		.resources = telem_res,
> > +		.num_resources = ARRAY_SIZE(telem_res),
> > +	};
> > +
> > +	if (!pmcdev.telem_base)
> > +		return 0;
> > +
> > +	return devm_mfd_add_devices(pmcdev.dev, PLATFORM_DEVID_AUTO, &telem, 1,
> > +				    pmcdev.telem_base, 0, NULL);
> > +}
> > +
> > +static int pmc_create_devices(void)
> > +{
> > +	int ret;
> > +
> > +	/* If we have ACPI based watchdog use that instead */
> > +	if (!acpi_has_watchdog()) {
> > +		ret = pmc_create_tco_device();
> > +		if (ret) {
> > +			dev_err(pmcdev.dev, "Failed to add tco platform device\n");
> > +			return ret;
> > +		}
> > +	}
> > +
> > +	ret = pmc_create_punit_device();
> > +	if (ret) {
> > +		dev_err(pmcdev.dev, "Failed to add punit platform device\n");
> > +		return ret;
> > +	}
> > +
> > +	ret = pmc_create_telemetry_device();
> > +	if (ret)
> > +		dev_warn(pmcdev.dev, "Failed to add telemetry platform device\n");
> > +
> > +	return ret;
> > +}
> 
> Once you have split out the 'struct mfd_cells' from the functions
> above, you can move the devm_mfd_add_devices() calls into probe() and
> do away with all of these functions which will greatly simplify the
> driver as a whole.

OK, but there is one catch. Some of these addresses need to be filled
dynamically when we parse the device resources which means that we need
to take copy of that static structure to avoid modifying it. For example
if the driver is unbound and then bind back from sysfs the old values
are still there).

> > +static int pmc_plat_get_res(struct platform_device *pdev,
> > +			    struct intel_scu_ipc_pdata *pdata)
> > +{
> > +	struct resource *res, *punit_res = pmcdev.punit_res;
> > +	struct resource *tco_res = pmcdev.tco_res;
> > +	void __iomem *addr;
> > +	int size;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_IO,
> > +				    PLAT_RESOURCE_ACPI_IO_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get IO resource\n");
> 
> What is the IO resource here used for?

For watchdog.

> 
> > +		return -ENXIO;
> 
> Is "No such device or address" the correct response for this?

That was in the original code. Maybe -ENOMEM is better in this case?

> > +
> 
> Superfluous '\n'.
> 
> > +	}
> 
> '\n'
> 
> > +	tco_res[0].flags = IORESOURCE_IO;
> > +	tco_res[0].start = res->start + TCO_BASE_OFFSET;
> > +	tco_res[0].end = tco_res[0].start + TCO_REGS_SIZE - 1;
> > +	tco_res[1].flags = IORESOURCE_IO;
> > +	tco_res[1].start = res->start + SMI_EN_OFFSET;
> > +	tco_res[1].end = tco_res[1].start + SMI_EN_SIZE - 1;
> > +
> > +	dev_dbg(&pdev->dev, "IO: %pR\n", res);
> 
> Do all of these dev_dgb() prints really still serve a purpose?

No, just for seeing what the resources are. I can remove them.

> > +	pmcdev.punit_res_count = 0;
> > +
> > +	/* This is index 0 to cover BIOS data register */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_BIOS_DATA_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get res of P-unit BIOS data\n");
> > +		return -ENXIO;
> > +	}
> > +	punit_res[pmcdev.punit_res_count++] = *res;
> > +	dev_dbg(&pdev->dev, "P-unit BIOS data: %pR\n", res);
> > +
> > +	/* This is index 1 to cover BIOS interface register */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_BIOS_IFACE_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get res of P-unit BIOS iface\n");
> > +		return -ENXIO;
> > +	}
> > +	punit_res[pmcdev.punit_res_count++] = *res;
> > +	dev_dbg(&pdev->dev, "P-unit BIOS interface: %pR\n", res);
> > +
> > +	/* This is index 2 to cover ISP data register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_ISP_DATA_INDEX);
> > +	if (res) {
> > +		punit_res[pmcdev.punit_res_count++] = *res;
> > +		dev_dbg(&pdev->dev, "P-unit ISP data: %pR\n", res);
> > +	}
> > +
> > +	/* This is index 3 to cover ISP interface register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_ISP_IFACE_INDEX);
> > +	if (res) {
> > +		punit_res[pmcdev.punit_res_count++] = *res;
> > +		dev_dbg(&pdev->dev, "P-unit ISP interface: %pR\n", res);
> > +	}
> > +
> > +	/* This is index 4 to cover GTD data register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_GTD_DATA_INDEX);
> > +	if (res) {
> > +		punit_res[pmcdev.punit_res_count++] = *res;
> > +		dev_dbg(&pdev->dev, "P-unit GTD data: %pR\n", res);
> > +	}
> > +
> > +	/* This is index 5 to cover GTD interface register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_GTD_IFACE_INDEX);
> > +	if (res) {
> > +		punit_res[pmcdev.punit_res_count++] = *res;
> > +		dev_dbg(&pdev->dev, "P-unit GTD interface: %pR\n", res);
> > +	}
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_IPC_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get IPC resource\n");
> > +		return -ENXIO;
> > +	}
> 
> '\n'
> 
> > +	size = PLAT_RESOURCE_IPC_SIZE + PLAT_RESOURCE_GCR_SIZE;
> 
> 'size' seems like a superfluous variable.
> 
> > +	res->end = res->start + size - 1;
> > +
> > +	addr = devm_ioremap_resource(&pdev->dev, res);
> > +	if (IS_ERR(addr))
> > +		return PTR_ERR(addr);
> > +
> > +	pdata->ipc_regs = addr;
> 
> Wouldn't this fit better in intel_scu_ipc_probe()?

OK.

> > +	pmcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
> > +	dev_dbg(&pdev->dev, "IPC: %pR\n", res);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get telemetry SSRAM resource\n");
> 
> Is this actually an error?  If so, it should return an error code.

I don't think this is an error. I can lower this to dev_dbg().

> 
> > +	} else {
> > +		dev_dbg(&pdev->dev, "Telemetry SSRAM: %pR\n", res);
> > +		pmcdev.telem_base = res;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/**
> > + * intel_pmc_s0ix_counter_read() - Read S0ix residency.
> 
> What is residency?

Here it means amount of time the system has been in S0ix (low power mode
in intel CPUs).

> > + * @data: Out param that contains current S0ix residency count.
> > + *
> > + * Return: an error code or 0 on success.
> > + */
> > +int intel_pmc_s0ix_counter_read(u64 *data)
> > +{
> > +	u64 deep, shlw;
> > +
> > +	if (!pmcdev.gcr_mem_base)
> > +		return -EACCES;
> 
> Again, is this possible?

No. I'll remove this check.

> 
> > +	deep = gcr_data_readq(PMC_GCR_TELEM_DEEP_S0IX_REG);
> 
> Can this fail?

No. It maps to readq() that does not return an error.

> 
> > +	shlw = gcr_data_readq(PMC_GCR_TELEM_SHLW_S0IX_REG);
> 
> Cant this fail?

Ditto.

> 
> > +	*data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_pmc_s0ix_counter_read);
> 
> What calls this?

Same telemetry driver:

drivers/platform/x86/intel_telemetry_debugfs.c

> 
> > +static const struct acpi_device_id intel_pmc_acpi_ids[] = {
> > +	{ "INT34D2", 0},
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, intel_pmc_acpi_ids);
> > +
> > +static int intel_pmc_probe(struct platform_device *pdev)
> > +{
> > +	struct intel_scu_ipc_pdata pdata;
> 
> Can we request this dynamically please?

OK

> > +	struct intel_scu_ipc_dev *scu;
> > +	int ret;
> > +
> > +	memset(&pdata, 0, sizeof(pdata));
> > +	pdata.irq = platform_get_irq(pdev, 0);
> > +	if (pdata.irq < 0)
> > +		return -EINVAL;
> > +
> > +	pmcdev.dev = &pdev->dev;
> 
> Same for pmcdev.

OK

> > +	spin_lock_init(&pmcdev.gcr_lock);
> > +
> > +	ret = pmc_plat_get_res(pdev, &pdata);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to request resource\n");
> 
> "resources"
> 
> > +		return ret;
> > +	}
> > +
> > +	scu = intel_scu_ipc_probe(&pdev->dev, &pdata);
> 
> This is a parent or child device?

The SCU IPC is a library so here it is just the device that has the SCU
IPC registers the library can use.

> > +	if (IS_ERR(scu))
> > +		return PTR_ERR(scu);
> > +
> > +	platform_set_drvdata(pdev, scu);
> > +
> > +	ret = pmc_create_devices();
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to create pmc devices\n");
> > +		goto err_ipc;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_ipc:
> > +	intel_scu_ipc_remove(scu);
> > +
> > +	return ret;
> > +}
> > +
> > +static int intel_pmc_remove(struct platform_device *pdev)
> > +{
> > +	intel_scu_ipc_remove(platform_get_drvdata(pdev));
> > +	pmcdev.dev = NULL;
> > +	return 0;
> > +}
> > +
> > +static struct platform_driver intel_pmc_driver = {
> > +	.remove = intel_pmc_remove,
> > +	.probe = intel_pmc_probe,
> > +	.driver = {
> > +		.name = "intel_pmc_bxt",
> > +		.acpi_match_table = ACPI_PTR(intel_pmc_acpi_ids),
> > +		.dev_groups = intel_pmc_groups,
> > +	},
> > +};
> > +
> > +static int __init intel_pmc_init(void)
> > +{
> > +	return platform_driver_register(&intel_pmc_driver);
> > +}
> > +
> > +static void __exit intel_pmc_exit(void)
> > +{
> > +	platform_driver_unregister(&intel_pmc_driver);
> > +}
> > +
> > +MODULE_AUTHOR("Zha Qipeng <qipeng.zha@intel.com>");
> > +MODULE_DESCRIPTION("Intel Broxton PMC driver");
> > +MODULE_LICENSE("GPL v2");
> > +
> > +/* Some modules are dependent on this, so init earlier */
> > +fs_initcall(intel_pmc_init);
> 
> Prefer if you didn't have to rely on this.
> 
> Can you use -EPROBE_DEFER instead?

I think the only modules outside of the ones this creates are the ones
using SCU IPC separately but they are already converted to handle the
situation where the IPC is not available.

So I think we can change this to be module_platform_driver(). I'll try
it and see if that works.

> 
> > +module_exit(intel_pmc_exit);
> 
> [...]
> 
> > diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/include/linux/mfd/intel_pmc_bxt.h
> > similarity index 83%
> > rename from arch/x86/include/asm/intel_pmc_ipc.h
> > rename to include/linux/mfd/intel_pmc_bxt.h
> > index 22848df5faaf..f03a80df0728 100644
> > --- a/arch/x86/include/asm/intel_pmc_ipc.h
> > +++ b/include/linux/mfd/intel_pmc_bxt.h
> 
> Need to review this too.

Right, sorry about that. I suppose I need to pass '--no-renames' to git
format-patch so it generates full diffs?
