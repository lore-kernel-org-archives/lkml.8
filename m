Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DE8C4BA0E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:34:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A847820801
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 10:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727913AbgBZKeC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 05:34:02 -0500
Received: from mga12.intel.com ([192.55.52.136]:61922 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgBZKeB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 05:34:01 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 02:34:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,487,1574150400"; 
   d="scan'208";a="350358780"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2020 02:33:56 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Feb 2020 12:33:55 +0200
Date:   Wed, 26 Feb 2020 12:33:55 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Zha Qipeng <qipeng.zha@intel.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 18/19] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200226103355.GO2667@lahna.fi.intel.com>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
 <20200217131446.32818-19-mika.westerberg@linux.intel.com>
 <20200226084749.GA3494@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200226084749.GA3494@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 08:47:49AM +0000, Lee Jones wrote:
> On Mon, 17 Feb 2020, Mika Westerberg wrote:
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
> > The new MFD driver continues to expose two sysfs attributes that allow
> > userspace to send IPC commands to the PMC/SCU to avoid breaking any
> > existing applications that may use these. Generally this is bad idea so
> > document this in the ABI documentation.
> > 
> > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > ---
> >  .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
> >  arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
> >  arch/x86/include/asm/intel_telemetry.h        |   1 +
> >  drivers/mfd/Kconfig                           |  16 +-
> >  drivers/mfd/Makefile                          |   1 +
> >  drivers/mfd/intel_pmc_bxt.c                   | 489 +++++++++++++
> >  drivers/platform/x86/Kconfig                  |  16 +-
> >  drivers/platform/x86/Makefile                 |   1 -
> >  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
> >  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
> >  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
> >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> >  include/linux/mfd/intel_pmc_bxt.h             |  21 +
> >  13 files changed, 565 insertions(+), 710 deletions(-)
> >  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
> >  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
> >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> >  create mode 100644 include/linux/mfd/intel_pmc_bxt.h
> 
> [...]
> 
> > diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> > index 20b294ef2873..d41a965d819b 100644
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
> > +	  This driver provides support for the PMC (Power Management
> > +	  Controller) on Intel Broxton and Apollo Lake. The PMC is a
> > +	  multi-function device that exposes IPC, General Control
> > +	  Register and P-unit access. In addition this creates devices
> > +	  for iTCO watchdog and telemetry that are part of the PMC.
> > +
> >  config MFD_IPAQ_MICRO
> >  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
> >  	depends on SA1100_H3100 || SA1100_H3600
> > diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> > index b83f172545e1..444264d42a20 100644
> > --- a/drivers/mfd/Makefile
> > +++ b/drivers/mfd/Makefile
> > @@ -212,6 +212,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
> >  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
> >  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
> >  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
> > +obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
> >  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
> >  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
> >  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> > diff --git a/drivers/mfd/intel_pmc_bxt.c b/drivers/mfd/intel_pmc_bxt.c
> > new file mode 100644
> > index 000000000000..7f743ae205de
> > --- /dev/null
> > +++ b/drivers/mfd/intel_pmc_bxt.c
> > @@ -0,0 +1,489 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for the Intel Broxton PMC
> > + *
> > + * (C) Copyright 2014 - 2020 Intel Corporation
> > + *
> > + * This driver is based on Intel SCU IPC driver (intel_scu_ipc.c) by
> > + * Sreedhara DS <sreedhara.ds@intel.com>
> > + *
> > + * The PMC running on the ARC processor communicates with another entity
> > + * running in the IA core through an IPC mechanism which in turn sends
> > + * messages between the IA and the PMC.
> 
> Please expand non-universal/non-obvious abbreviations in comments.

Okay.

> > + */
> > +
> > +#include <linux/acpi.h>
> > +#include <linux/delay.h>
> > +#include <linux/errno.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io-64-nonatomic-lo-hi.h>
> > +#include <linux/mfd/core.h>
> > +#include <linux/mfd/intel_pmc_bxt.h>
> > +#include <linux/module.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/platform_data/itco_wdt.h>
> > +
> > +#include <asm/intel_scu_ipc.h>
> > +
> > +/* Residency with clock rate at 19.2MHz to usecs */
> > +#define S0IX_RESIDENCY_IN_USECS(d, s)		\
> > +({						\
> > +	u64 result = 10ull * ((d) + (s));	\
> > +	do_div(result, 192);			\
> > +	result;					\
> > +})
> > +
> > +/* Resources exported from IFWI */
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
> > + * BIOS does not create an ACPI device for each PMC function, but
> > + * exports multiple resources from one ACPI device (IPC) for multiple
> > + * functions. This driver is responsible for creating a child device and
> > + * to export resources for those functions.
> > + */
> > +#define TCO_DEVICE_NAME			"iTCO_wdt"
> 
> This is nearly always horrible.
> 
> Please just use the string in it's place.
> 
> > +#define SMI_EN_OFFSET			0x40
> > +#define SMI_EN_SIZE			4
> > +#define TCO_BASE_OFFSET			0x60
> > +#define TCO_REGS_SIZE			16
> 
> > +#define PUNIT_DEVICE_NAME		"intel_punit_ipc"
> > +#define TELEMETRY_DEVICE_NAME		"intel_telemetry"
> 
> As above.

Yup.

> > +#define TELEM_SSRAM_SIZE		240
> > +#define TELEM_PMC_SSRAM_OFFSET		0x1B00
> > +#define TELEM_PUNIT_SSRAM_OFFSET	0x1A00
> > +
> > +/* Commands */
> > +#define PMC_NORTHPEAK_CTRL		0xED
> > +
> > +/* PMC_CFG_REG bit masks */
> > +#define PMC_CFG_NO_REBOOT_EN		BIT(4)
> > +
> > +/* Index to cells array in below struct */
> > +enum {
> > +	PMC_TCO,
> > +	PMC_PUNIT,
> > +	PMC_TELEM,
> > +};
> > +
> > +struct intel_pmc_dev {
> > +	struct device *dev;
> > +	struct intel_scu_ipc_dev *scu;
> > +
> > +	struct mfd_cell cells[PMC_TELEM + 1];
> 
> Nicer to add a "PMC_DEVICE_MAX" enum and use that.
> 
> Why do these even need to be in here?

They need to be here because we need to fill them in dynamically based
on the resources we get from the ACPI device.

> I would normally suggest creating a cell per device.

You mean 

struct intel_pmc_dev {
	...
	struct mfd_cell tco_cell;
	struct mfd_cell punit_cell;
	...

right? Sure no problem.

> > +	void __iomem *gcr_mem_base;
> > +	spinlock_t gcr_lock;
> > +
> > +	struct resource *telem_base;
> > +};
> > +
> > +static inline bool is_gcr_valid(u32 offset)
> > +{
> > +	return offset < PLAT_RESOURCE_GCR_SIZE - 8;
> > +}
> > +
> > +/**
> > + * intel_pmc_gcr_read64() - Read a 64-bit PMC GCR register
> > + * @pmc: PMC device pointer
> > + * @offset: offset of GCR register from GCR address base
> > + * @data: data pointer for storing the register output
> > + *
> > + * Reads the 64-bit PMC GCR register at given offset.
> > + *
> > + * Return: Negative value on error or 0 on success.
> > + */
> > +int intel_pmc_gcr_read64(struct intel_pmc_dev *pmc, u32 offset, u64 *data)
> > +{
> > +	if (!is_gcr_valid(offset))
> > +		return -EINVAL;
> > +
> > +	spin_lock(&pmc->gcr_lock);
> > +	*data = readq(pmc->gcr_mem_base + offset);
> > +	spin_unlock(&pmc->gcr_lock);
> > +
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_pmc_gcr_read64);
> > +
> > +/**
> > + * intel_pmc_gcr_update() - Update PMC GCR register bits
> > + * @pmc: PMC device pointer
> > + * @offset: offset of GCR register from GCR address base
> > + * @mask: bit mask for update operation
> > + * @val: update value
> > + *
> > + * Updates the bits of given GCR register as specified by
> > + * @mask and @val.
> > + *
> > + * Return: Negative value on error or 0 on success.
> > + */
> > +static int intel_pmc_gcr_update(struct intel_pmc_dev *pmc, u32 offset, u32 mask,
> > +				u32 val)
> > +{
> > +	u32 new_val;
> > +
> > +	if (!is_gcr_valid(offset))
> > +		return -EINVAL;
> > +
> > +	spin_lock(&pmc->gcr_lock);
> > +	new_val = readl(pmc->gcr_mem_base + offset);
> > +
> > +	new_val = (new_val & ~mask) | (val & mask);
> > +	writel(new_val, pmc->gcr_mem_base + offset);
> > +
> > +	new_val = readl(pmc->gcr_mem_base + offset);
> > +	spin_unlock(&pmc->gcr_lock);
> > +
> > +	/* Check whether the bit update is successful */
> > +	return (new_val & mask) != (val & mask) ? -EIO : 0;
> > +}
> > +
> > +/**
> > + * intel_pmc_s0ix_counter_read() - Read S0ix residency.
> > + * @pmc: PMC device pointer
> > + * @data: Out param that contains current S0ix residency count.
> > + *
> > + * Writes to @data how many usecs the system has been in low-power S0ix
> > + * state.
> > + *
> > + * Return: An error code or 0 on success.
> > + */
> > +int intel_pmc_s0ix_counter_read(struct intel_pmc_dev *pmc, u64 *data)
> > +{
> > +	u64 deep, shlw;
> > +
> > +	spin_lock(&pmc->gcr_lock);
> > +	deep = readq(pmc->gcr_mem_base + PMC_GCR_TELEM_DEEP_S0IX_REG);
> > +	shlw = readq(pmc->gcr_mem_base + PMC_GCR_TELEM_SHLW_S0IX_REG);
> > +	spin_unlock(&pmc->gcr_lock);
> > +
> > +	*data = S0IX_RESIDENCY_IN_USECS(deep, shlw);
> > +	return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(intel_pmc_s0ix_counter_read);
> > +
> > +static ssize_t simplecmd_store(struct device *dev, struct device_attribute *attr,
> 
> Header with explanation please.

kernel-doc, right? I'll do that.

> > +			       const char *buf, size_t count)
> > +{
> > +	struct intel_pmc_dev *pmc = dev_get_drvdata(dev);
> > +	struct intel_scu_ipc_dev *scu = pmc->scu;
> > +	int subcmd;
> > +	int cmd;
> > +	int ret;
> > +
> > +	ret = sscanf(buf, "%d %d", &cmd, &subcmd);
> > +	if (ret != 2) {
> > +		dev_err(dev, "Invalid values, expected: cmd subcmd\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	ret = intel_scu_ipc_dev_simple_command(scu, cmd, subcmd);
> > +	return ret ?: count;
> 
> Prefer the usual "if (ret) return ret;" over ternary.

Sure.

> > +}
> > +static DEVICE_ATTR_WO(simplecmd);
> > +
> > +static ssize_t northpeak_store(struct device *dev, struct device_attribute *attr,
> > +			       const char *buf, size_t count)
> 
> Header with explanation please.

Yup.

> > +{
> > +	struct intel_pmc_dev *pmc = dev_get_drvdata(dev);
> > +	struct intel_scu_ipc_dev *scu = pmc->scu;
> > +	unsigned long val;
> > +	int subcmd;
> > +	int ret;
> > +
> > +	ret = kstrtoul(buf, 0, &val);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (val)
> > +		subcmd = 1;
> > +	else
> > +		subcmd = 0;
> 
> Comment please.

OK.

> 
> > +	ret = intel_scu_ipc_dev_simple_command(scu, PMC_NORTHPEAK_CTRL, subcmd);
> > +	return ret ?: count;
> 
> As above.

OK.

> > +}
> > +static DEVICE_ATTR_WO(northpeak);
> > +
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
> > +/* Templates used to construct MFD cells */
> > +
> > +static const struct mfd_cell punit = {
> > +	.name = PUNIT_DEVICE_NAME,
> 
> Use proper string please.

Sure.

> > +};
> > +
> > +static int update_no_reboot_bit(void *priv, bool set)
> > +{
> > +	struct intel_pmc_dev *pmc = priv;
> > +	u32 bits = PMC_CFG_NO_REBOOT_EN;
> > +	u32 value = set ? bits : 0;
> > +
> > +	return intel_pmc_gcr_update(pmc, PMC_GCR_PMC_CFG_REG, bits, value);
> > +}
> > +
> > +static const struct itco_wdt_platform_data tco_pdata = {
> > +	.name = "Apollo Lake SoC",
> > +	.version = 5,
> > +	.update_no_reboot_bit = update_no_reboot_bit,
> > +};
> > +
> > +static const struct mfd_cell tco = {
> > +	.name = TCO_DEVICE_NAME,
> 
> Use proper string please.
> 
> > +	.ignore_resource_conflicts = true,
> 
> Why not add tco_pdata here?

Because we need to pass it the private PMC pointer that is filled later
on. It is being used by the iTCO_wdt .update_no_reboot_bit() callback as
its private data.

> > +};
> > +
> > +static const struct resource telem_res[] = {
> > +	DEFINE_RES_MEM(TELEM_PUNIT_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > +	DEFINE_RES_MEM(TELEM_PMC_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > +};
> > +
> > +static const struct mfd_cell telem = {
> > +	.name = TELEMETRY_DEVICE_NAME,
> 
> Use proper string please.

Okay.

> > +	.resources = telem_res,
> > +	.num_resources = ARRAY_SIZE(telem_res),
> > +};
> > +
> > +static int intel_pmc_get_tco_resources(struct platform_device *pdev,
> > +				       struct intel_pmc_dev *pmc)
> > +{
> > +	struct itco_wdt_platform_data *pdata;
> > +	struct resource *res, *tco_res;
> > +
> > +	if (acpi_has_watchdog())
> > +		return 0;
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_IO,
> > +				    PLAT_RESOURCE_ACPI_IO_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get IO resource\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	tco_res = devm_kcalloc(&pdev->dev, 2, sizeof(*tco_res), GFP_KERNEL);
> > +	if (!tco_res)
> > +		return -ENOMEM;
> > +
> > +	tco_res[0].flags = IORESOURCE_IO;
> > +	tco_res[0].start = res->start + TCO_BASE_OFFSET;
> > +	tco_res[0].end = tco_res[0].start + TCO_REGS_SIZE - 1;
> > +	tco_res[1].flags = IORESOURCE_IO;
> > +	tco_res[1].start = res->start + SMI_EN_OFFSET;
> > +	tco_res[1].end = tco_res[1].start + SMI_EN_SIZE - 1;
> > +
> > +	pmc->cells[PMC_TCO].resources = tco_res;
> > +	pmc->cells[PMC_TCO].num_resources = 2;
> > +
> > +	pdata = devm_kmemdup(&pdev->dev, &tco_pdata, sizeof(*pdata), GFP_KERNEL);
> > +	if (!pdata)
> > +		return -ENOMEM;
> > +
> > +	pdata->no_reboot_priv = pmc;
> 
> This looks hacky.  What are you doing here?

So the pmc instance is created per device as you requested. This one
passes it to the iTCO_wdt .update_no_reboot_bit() callback which we
implemented in this driver (sane name update_no_reboot_bit()).

The iTCO_wdt platform data can be found in this header if you want to
take a look: include/linux/platform_data/itco_wdt.h.

> > +	pmc->cells[PMC_TCO].platform_data = pdata;
> > +	pmc->cells[PMC_TCO].pdata_size = sizeof(*pdata);
> > +
> > +	return 0;
> > +}
> > +
> > +static int intel_pmc_get_resources(struct platform_device *pdev,
> > +				   struct intel_pmc_dev *pmc,
> > +				   struct intel_scu_ipc_pdata *pdata)
> > +{
> > +	struct resource *res, *punit_res;
> > +	struct resource gcr_res;
> > +	size_t npunit_res = 0;
> > +	int ret;
> > +
> > +	pdata->irq = platform_get_irq_optional(pdev, 0);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_IPC_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get IPC resource\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* IPC registers */
> > +	pdata->mem.flags = res->flags;
> > +	pdata->mem.start = res->start;
> > +	pdata->mem.end = res->start + PLAT_RESOURCE_IPC_SIZE - 1;
> 
> Passing register addresses through pdata also looks like a hack.
> 
> Why not pass via resources?

It is not actual "platform data" but just a structure that we pass for
the IPC registration function that then creates the underlying device
for the SCU IPC using these. Since it is plain device (not struct
platform device) it does not have the concept of "resources" such as
platform devices have.

> > +	/* GCR registers */
> > +	gcr_res.flags = res->flags;
> > +	gcr_res.start = res->start + PLAT_RESOURCE_GCR_OFFSET;
> > +	gcr_res.end = gcr_res.start + PLAT_RESOURCE_GCR_SIZE - 1;
> > +
> > +	pmc->gcr_mem_base = devm_ioremap_resource(&pdev->dev, &gcr_res);
> > +	if (IS_ERR(pmc->gcr_mem_base))
> > +		return PTR_ERR(pmc->gcr_mem_base);
> > +
> > +	pmc->cells[PMC_TCO] = tco;
> > +	pmc->cells[PMC_PUNIT] = punit;
> > +	pmc->cells[PMC_TELEM] = telem;
> > +
> > +	/* iTCO watchdog only if there is no WDAT ACPI table */
> 
> This sentence doesn't make sense.
> 
> "Only register ... " ?

Heh, good point. I'll fix.

> > +	ret = intel_pmc_get_tco_resources(pdev, pmc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	punit_res = devm_kcalloc(&pdev->dev, 6, sizeof(*punit_res), GFP_KERNEL);
> > +	if (!punit_res)
> > +		return -ENOMEM;
> > +
> > +	/* This is index 0 to cover BIOS data register */
> 
> We don't need to know what the indexes are.
> 
> Just leave it at "BIOS data register".

Okay.

> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_BIOS_DATA_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get resource of P-unit BIOS data\n");
> > +		return -EINVAL;
> > +	}
> > +	punit_res[npunit_res++] = *res;
> > +
> > +	/* This is index 1 to cover BIOS interface register */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_BIOS_IFACE_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get resource of P-unit BIOS interface\n");
> > +		return -EINVAL;
> > +	}
> > +	punit_res[npunit_res++] = *res;
> > +
> > +	/* This is index 2 to cover ISP data register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_ISP_DATA_INDEX);
> > +	if (res)
> > +		punit_res[npunit_res++] = *res;
> > +
> > +	/* This is index 3 to cover ISP interface register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_ISP_IFACE_INDEX);
> > +	if (res)
> > +		punit_res[npunit_res++] = *res;
> > +
> > +	/* This is index 4 to cover GTD data register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_GTD_DATA_INDEX);
> > +	if (res)
> > +		punit_res[npunit_res++] = *res;
> > +
> > +	/* This is index 5 to cover GTD interface register, optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_GTD_IFACE_INDEX);
> > +	if (res)
> > +		punit_res[npunit_res++] = *res;
> > +
> > +	pmc->cells[PMC_PUNIT].resources = punit_res;
> > +	pmc->cells[PMC_PUNIT].num_resources = npunit_res;
> > +
> > +	/* Telemetry SSRAM is optional */
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
> > +	if (res)
> > +		pmc->telem_base = res;
> > +
> > +	return 0;
> > +}
> > +
> > +static int intel_pmc_create_devices(struct intel_pmc_dev *pmc)
> > +{
> > +	int ret;
> > +
> > +	if (pmc->cells[PMC_TCO].num_resources) {
> 
> Why not use the same (only?) condition that could make this false:
> 
>   if (acpi_has_watchdog())

Right, good point. I'll use that instead.

> > +		ret = devm_mfd_add_devices(pmc->dev, PLATFORM_DEVID_AUTO,
> > +					   &pmc->cells[PMC_TCO], 1, NULL, 0, NULL);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	ret = devm_mfd_add_devices(pmc->dev, PLATFORM_DEVID_AUTO,
> > +				   &pmc->cells[PMC_PUNIT], 1, NULL, 0, NULL);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (pmc->telem_base) {
> > +		ret = devm_mfd_add_devices(pmc->dev, PLATFORM_DEVID_AUTO,
> > +					   &pmc->cells[PMC_TELEM], 1,
> > +					   pmc->telem_base, 0, NULL);
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct acpi_device_id intel_pmc_acpi_ids[] = {
> > +	{ "INT34D2" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(acpi, intel_pmc_acpi_ids);
> > +
> > +static int intel_pmc_probe(struct platform_device *pdev)
> > +{
> > +	struct intel_scu_ipc_pdata pdata = {};
> > +	struct intel_pmc_dev *pmc;
> > +	int ret;
> > +
> > +	pmc = devm_kzalloc(&pdev->dev, sizeof(*pmc), GFP_KERNEL);
> > +	if (!pmc)
> > +		return -ENOMEM;
> > +
> > +	pmc->dev = &pdev->dev;
> > +	spin_lock_init(&pmc->gcr_lock);
> > +
> > +	ret = intel_pmc_get_resources(pdev, pmc, &pdata);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Failed to request resources\n");
> > +		return ret;
> > +	}
> > +
> > +	pmc->scu = devm_intel_scu_ipc_register(&pdev->dev, &pdata);
> > +	if (IS_ERR(pmc->scu))
> > +		return PTR_ERR(pmc->scu);
> > +
> > +	platform_set_drvdata(pdev, pmc);
> > +
> > +	ret = intel_pmc_create_devices(pmc);
> > +	if (ret)
> > +		dev_err(&pdev->dev, "Failed to create PMC devices\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static struct platform_driver intel_pmc_driver = {
> > +	.probe = intel_pmc_probe,
> > +	.driver = {
> > +		.name = "intel_pmc_bxt",
> > +		.acpi_match_table = intel_pmc_acpi_ids,
> > +		.dev_groups = intel_pmc_groups,
> > +	},
> > +};
> > +
> 
> Remove this line.

Okay.

> > +module_platform_driver(intel_pmc_driver);
> > +
> > +MODULE_AUTHOR("Mika Westerberg <mika.westerberg@linux.intel.com>");
> > +MODULE_AUTHOR("Zha Qipeng <qipeng.zha@intel.com>");
> > +MODULE_DESCRIPTION("Intel Broxton PMC driver");
> > +MODULE_LICENSE("GPL v2");
> 
> [...]
> 
> > diff --git a/include/linux/mfd/intel_pmc_bxt.h b/include/linux/mfd/intel_pmc_bxt.h
> > new file mode 100644
> > index 000000000000..a5fb41910d78
> > --- /dev/null
> > +++ b/include/linux/mfd/intel_pmc_bxt.h
> > @@ -0,0 +1,21 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef MFD_INTEL_PMC_BXT_H
> > +#define MFD_INTEL_PMC_BXT_H
> > +
> > +#include <linux/types.h>
> > +
> > +/* GCR reg offsets from GCR base */
> > +#define PMC_GCR_PMC_CFG_REG		0x08
> > +#define PMC_GCR_TELEM_DEEP_S0IX_REG	0x78
> > +#define PMC_GCR_TELEM_SHLW_S0IX_REG	0x80
> > +
> > +/*
> > + * Pointer to the PMC device can be obtained by calling
> > + * dev_get_drvdata() to the parent MFD device.
> > + */
> > +struct intel_pmc_dev;
> 
> Don't you have a shared header file you can put the definition in
> instead?

Unfortunately no. This one is the shared header.

> > +int intel_pmc_s0ix_counter_read(struct intel_pmc_dev *pmc, u64 *data);
> > +int intel_pmc_gcr_read64(struct intel_pmc_dev *pmc, u32 offset, u64 *data);
> > +
> > +#endif /* MFD_INTEL_PMC_BXT_H */
> 
> -- 
> Lee Jones [李琼斯]
> Linaro Services Technical Lead
> Linaro.org │ Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
