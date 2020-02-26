Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6825EC4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EC720838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgBZMXA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:23:00 -0500
Received: from mga01.intel.com ([192.55.52.88]:8655 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727175AbgBZMXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:23:00 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Feb 2020 04:22:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,488,1574150400"; 
   d="scan'208";a="350378972"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 26 Feb 2020 04:22:53 -0800
Received: by lahna (sSMTP sendmail emulation); Wed, 26 Feb 2020 14:22:53 +0200
Date:   Wed, 26 Feb 2020 14:22:53 +0200
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
Message-ID: <20200226122253.GP2667@lahna.fi.intel.com>
References: <20200217131446.32818-1-mika.westerberg@linux.intel.com>
 <20200217131446.32818-19-mika.westerberg@linux.intel.com>
 <20200226084749.GA3494@dell>
 <20200226103355.GO2667@lahna.fi.intel.com>
 <20200226112324.GL3494@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226112324.GL3494@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 11:23:24AM +0000, Lee Jones wrote:
> On Wed, 26 Feb 2020, Mika Westerberg wrote:
> 
> > On Wed, Feb 26, 2020 at 08:47:49AM +0000, Lee Jones wrote:
> > > On Mon, 17 Feb 2020, Mika Westerberg wrote:
> > > 
> > > > This driver only creates a bunch of platform devices sharing resources
> > > > belonging to the PMC device. This is pretty much what MFD subsystem is
> > > > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > > > should be more clear what it is.
> > > > 
> > > > MFD subsystem provides nice helper APIs for subdevice creation so
> > > > convert the driver to use those. Unfortunately the ACPI device includes
> > > > separate resources for most of the subdevices so we cannot simply call
> > > > mfd_add_devices() to create all of them but instead we need to call it
> > > > separately for each device.
> > > > 
> > > > The new MFD driver continues to expose two sysfs attributes that allow
> > > > userspace to send IPC commands to the PMC/SCU to avoid breaking any
> > > > existing applications that may use these. Generally this is bad idea so
> > > > document this in the ABI documentation.
> > > > 
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > > ---
> > > >  .../ABI/obsolete/sysfs-driver-intel_pmc_bxt   |  22 +
> > > >  arch/x86/include/asm/intel_pmc_ipc.h          |  47 --
> > > >  arch/x86/include/asm/intel_telemetry.h        |   1 +
> > > >  drivers/mfd/Kconfig                           |  16 +-
> > > >  drivers/mfd/Makefile                          |   1 +
> > > >  drivers/mfd/intel_pmc_bxt.c                   | 489 +++++++++++++
> > > >  drivers/platform/x86/Kconfig                  |  16 +-
> > > >  drivers/platform/x86/Makefile                 |   1 -
> > > >  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
> > > >  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
> > > >  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
> > > >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> > > >  include/linux/mfd/intel_pmc_bxt.h             |  21 +
> > > >  13 files changed, 565 insertions(+), 710 deletions(-)
> > > >  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
> > > >  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
> > > >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> > > >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> > > >  create mode 100644 include/linux/mfd/intel_pmc_bxt.h
> > > 
> > > [...]
> 
> [...]
> 
> > > > +struct intel_pmc_dev {
> > > > +	struct device *dev;
> > > > +	struct intel_scu_ipc_dev *scu;
> > > > +
> > > > +	struct mfd_cell cells[PMC_TELEM + 1];
> > > 
> > > Nicer to add a "PMC_DEVICE_MAX" enum and use that.
> > > 
> > > Why do these even need to be in here?
> > 
> > They need to be here because we need to fill them in dynamically based
> > on the resources we get from the ACPI device.
> 
> Why can't you do that with statically defined structs?
> 
> HINT: You can.

Well if I did that then there are two issues I see. First is that if
there will be another PMC device in the future, we could not cope with
that because the first device that is probed will fill those cells with
its information.

Second is that if we ignore the possibility of multiple devices then we
still end up filling the module wide cells with the resources which does
not seem right to me because we have a intel_pmc_dev instance
separately.

So we can't really use the "standard" MFD way here where we have static
const cells (module wide) that we pass to the MFD core with base address
because the resources in the ACPI device (that the driver binds to) are
not organized like that. The resources are pretty much arbitrary.

> > > I would normally suggest creating a cell per device.
> > 
> > You mean 
> > 
> > struct intel_pmc_dev {
> > 	...
> > 	struct mfd_cell tco_cell;
> > 	struct mfd_cell punit_cell;
> > 	...
> > 
> > right? Sure no problem.
> 
> No.  We don't usually put them in device data at all.
> 
> I mean:
> 
> static struct mfd_cell tco_cell[] = {
>         {      }
> };
> 
> static struct mfd_cell tco_cell[] = {
>         {      }
> };

OK, then my above comment hopefully explains why I can't do that.

> [...]
> 
> > > > +static const struct mfd_cell tco = {
> > > > +	.name = TCO_DEVICE_NAME,
> > > 
> > > Use proper string please.
> > > 
> > > > +	.ignore_resource_conflicts = true,
> > > 
> > > Why not add tco_pdata here?
> > 
> > Because we need to pass it the private PMC pointer that is filled later
> > on. It is being used by the iTCO_wdt .update_no_reboot_bit() callback as
> > its private data.
> 
> Just drop the const.

But again we have the same issue here. So what we have is:

  - module wide resources (the cell templates)
  - per PMC instance resources created when the driver is probed against
    the ACPI device.

I don't think it is good idea to put the latter to the former because of
the reasons I exlain above.

If this would have something like single MMIO register that is split for
the child-devices this would work fine but in this case it unfortunately
does not. Well unless I'm missing something ;-)

> > > > +};
> > > > +
> > > > +static const struct resource telem_res[] = {
> > > > +	DEFINE_RES_MEM(TELEM_PUNIT_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > > > +	DEFINE_RES_MEM(TELEM_PMC_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > > > +};
> > > > +
> > > > +static const struct mfd_cell telem = {
> > > > +	.name = TELEMETRY_DEVICE_NAME,
> > > 
> > > Use proper string please.
> > 
> > Okay.
> > 
> > > > +	.resources = telem_res,
> > > > +	.num_resources = ARRAY_SIZE(telem_res),
> > > > +};
> > > > +
> > > > +static int intel_pmc_get_tco_resources(struct platform_device *pdev,
> > > > +				       struct intel_pmc_dev *pmc)
> > > > +{
> > > > +	struct itco_wdt_platform_data *pdata;
> > > > +	struct resource *res, *tco_res;
> > > > +
> > > > +	if (acpi_has_watchdog())
> > > > +		return 0;
> > > > +
> > > > +	res = platform_get_resource(pdev, IORESOURCE_IO,
> > > > +				    PLAT_RESOURCE_ACPI_IO_INDEX);
> > > > +	if (!res) {
> > > > +		dev_err(&pdev->dev, "Failed to get IO resource\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	tco_res = devm_kcalloc(&pdev->dev, 2, sizeof(*tco_res), GFP_KERNEL);
> > > > +	if (!tco_res)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	tco_res[0].flags = IORESOURCE_IO;
> > > > +	tco_res[0].start = res->start + TCO_BASE_OFFSET;
> > > > +	tco_res[0].end = tco_res[0].start + TCO_REGS_SIZE - 1;
> > > > +	tco_res[1].flags = IORESOURCE_IO;
> > > > +	tco_res[1].start = res->start + SMI_EN_OFFSET;
> > > > +	tco_res[1].end = tco_res[1].start + SMI_EN_SIZE - 1;
> > > > +
> > > > +	pmc->cells[PMC_TCO].resources = tco_res;
> > > > +	pmc->cells[PMC_TCO].num_resources = 2;
> > > > +
> > > > +	pdata = devm_kmemdup(&pdev->dev, &tco_pdata, sizeof(*pdata), GFP_KERNEL);
> > > > +	if (!pdata)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	pdata->no_reboot_priv = pmc;
> > > 
> > > This looks hacky.  What are you doing here?
> > 
> > So the pmc instance is created per device as you requested. This one
> > passes it to the iTCO_wdt .update_no_reboot_bit() callback which we
> > implemented in this driver (sane name update_no_reboot_bit()).
> > 
> > The iTCO_wdt platform data can be found in this header if you want to
> > take a look: include/linux/platform_data/itco_wdt.h.
> 
> We usually pass these kinds of pointers via device data, rather than
> platform data.

I know but this is already existing iTCO_wdt interface that I'm using.
Not created by this patch series.

> > > > +	pmc->cells[PMC_TCO].platform_data = pdata;
> > > > +	pmc->cells[PMC_TCO].pdata_size = sizeof(*pdata);
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +static int intel_pmc_get_resources(struct platform_device *pdev,
> > > > +				   struct intel_pmc_dev *pmc,
> > > > +				   struct intel_scu_ipc_pdata *pdata)
> > > > +{
> > > > +	struct resource *res, *punit_res;
> > > > +	struct resource gcr_res;
> > > > +	size_t npunit_res = 0;
> > > > +	int ret;
> > > > +
> > > > +	pdata->irq = platform_get_irq_optional(pdev, 0);
> > > > +
> > > > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > > > +				    PLAT_RESOURCE_IPC_INDEX);
> > > > +	if (!res) {
> > > > +		dev_err(&pdev->dev, "Failed to get IPC resource\n");
> > > > +		return -EINVAL;
> > > > +	}
> > > > +
> > > > +	/* IPC registers */
> > > > +	pdata->mem.flags = res->flags;
> > > > +	pdata->mem.start = res->start;
> > > > +	pdata->mem.end = res->start + PLAT_RESOURCE_IPC_SIZE - 1;
> > > 
> > > Passing register addresses through pdata also looks like a hack.
> > > 
> > > Why not pass via resources?
> > 
> > It is not actual "platform data" but just a structure that we pass for
> > the IPC registration function that then creates the underlying device
> > for the SCU IPC using these. Since it is plain device (not struct
> > platform device) it does not have the concept of "resources" such as
> > platform devices have.
> 
> Calling something platform data that isn't platform data is confusing.
> 
> Why aren't you using the standard device driver model to register this
> device?

Well I think I am. It is now registered the same way as you would
register say, an input device (you don't really have drivers binding for
anything you register with input_register_device()). It even registers a
new class of devices as discussed previously.

> [...]
> 
> > > > diff --git a/include/linux/mfd/intel_pmc_bxt.h b/include/linux/mfd/intel_pmc_bxt.h
> > > > new file mode 100644
> > > > index 000000000000..a5fb41910d78
> > > > --- /dev/null
> > > > +++ b/include/linux/mfd/intel_pmc_bxt.h
> > > > @@ -0,0 +1,21 @@
> > > > +/* SPDX-License-Identifier: GPL-2.0 */
> > > > +#ifndef MFD_INTEL_PMC_BXT_H
> > > > +#define MFD_INTEL_PMC_BXT_H
> > > > +
> > > > +#include <linux/types.h>
> > > > +
> > > > +/* GCR reg offsets from GCR base */
> > > > +#define PMC_GCR_PMC_CFG_REG		0x08
> > > > +#define PMC_GCR_TELEM_DEEP_S0IX_REG	0x78
> > > > +#define PMC_GCR_TELEM_SHLW_S0IX_REG	0x80
> > > > +
> > > > +/*
> > > > + * Pointer to the PMC device can be obtained by calling
> > > > + * dev_get_drvdata() to the parent MFD device.
> > > > + */
> > > > +struct intel_pmc_dev;
> > > 
> > > Don't you have a shared header file you can put the definition in
> > > instead?
> > 
> > Unfortunately no. This one is the shared header.
> 
> Please consider moving the definition into here then.

Okay.
