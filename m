Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8247BC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ACFD2080C
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 12:22:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgCXMWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 08:22:23 -0400
Received: from mga07.intel.com ([134.134.136.100]:5249 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727241AbgCXMWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 08:22:23 -0400
IronPort-SDR: yb4NWUgA3aIqL166v6n0xKi/4ojBI6r11AxUcVtAzmuWJvw7l1owO529EFmjdivOoLnhXZAw0I
 WJstt/391bSw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2020 05:22:21 -0700
IronPort-SDR: mqTxCfSFaBhHjZxM72j/gkpQ5rcdY36qil8NK7yodAUufj5QhuL+zr+cXzg3oviRmkziYAoB8s
 9V/HG0qhd8tg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,300,1580803200"; 
   d="scan'208";a="357409870"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 24 Mar 2020 05:22:17 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 24 Mar 2020 14:22:16 +0200
Date:   Tue, 24 Mar 2020 14:22:16 +0200
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
Subject: Re: [PATCH v8 18/19] platform/x86: intel_pmc_ipc: Convert to MFD
Message-ID: <20200324122216.GG2564@lahna.fi.intel.com>
References: <20200303133649.39819-1-mika.westerberg@linux.intel.com>
 <20200303133649.39819-19-mika.westerberg@linux.intel.com>
 <20200324115219.GB437932@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200324115219.GB437932@dell>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 24, 2020 at 11:52:19AM +0000, Lee Jones wrote:
> On Tue, 03 Mar 2020, Mika Westerberg wrote:
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
> >  drivers/mfd/intel_pmc_bxt.c                   | 504 ++++++++++++++
> >  drivers/platform/x86/Kconfig                  |  16 +-
> >  drivers/platform/x86/Makefile                 |   1 -
> >  drivers/platform/x86/intel_pmc_ipc.c          | 645 ------------------
> >  .../platform/x86/intel_telemetry_debugfs.c    |  12 +-
> >  drivers/platform/x86/intel_telemetry_pltdrv.c |   2 +
> >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> >  include/linux/mfd/intel_pmc_bxt.h             |  43 ++
> >  13 files changed, 602 insertions(+), 710 deletions(-)
> >  create mode 100644 Documentation/ABI/obsolete/sysfs-driver-intel_pmc_bxt
> >  delete mode 100644 arch/x86/include/asm/intel_pmc_ipc.h
> >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> >  create mode 100644 include/linux/mfd/intel_pmc_bxt.h
> 
> [...]
> 
> > +/*
> > + * We use the below templates to construct MFD cells. The struct
> > + * intel_pmc_dev instance holds the real MFD cells where we first copy
> > + * these and then fill the dynamic parts based on the extracted resources.
> > + */
> > +
> > +static const struct mfd_cell punit = {
> > +	.name = "intel_punit_ipc",
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
> > +	.name = "iTCO_wdt",
> > +	.ignore_resource_conflicts = true,
> > +};
> > +
> > +static const struct resource telem_res[] = {
> > +	DEFINE_RES_MEM(TELEM_PUNIT_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > +	DEFINE_RES_MEM(TELEM_PMC_SSRAM_OFFSET, TELEM_SSRAM_SIZE),
> > +};
> > +
> > +static const struct mfd_cell telem = {
> > +	.name = "intel_telemetry",
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
> 
> Why do you need to take a copy?
> 
> This can be referenced directly in 'mfd_cell tco', no?

No because I'm filling the priv pointer dynamically. I've tried to
explain the same thing in the previous iterations already.

> > +	pdata->no_reboot_priv = pmc;
> 
> You're putting device data inside platform data?
> 
> This doesn't sit right with me at all.
>
> You already saved it using platform_set_drvdata(), why do you need it
> twice?  Why can't you export update_no_reboot_bit() and make it take
> 'struct intel_pmc_dev' or better yet 'pdev' as an argument?

This is a property of the iTCO_wdt driver, not part of this patch
series. I'm just using the interface it provides.

iTCO_wdt interface can of course be made better but I don't think it
should be part of this series.

> > +	pmc->cells[PMC_TCO].platform_data = pdata;
> > +	pmc->cells[PMC_TCO].pdata_size = sizeof(*pdata);
> > +
> > +	return 0;
> > +}
> > +
> > +static int intel_pmc_get_resources(struct platform_device *pdev,
> > +				   struct intel_pmc_dev *pmc,
> > +				   struct intel_scu_ipc_data *scu_data)
> > +{
> > +	struct resource *res, *punit_res;
> > +	struct resource gcr_res;
> > +	size_t npunit_res = 0;
> > +	int ret;
> > +
> > +	scu_data->irq = platform_get_irq_optional(pdev, 0);
> > +
> > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > +				    PLAT_RESOURCE_IPC_INDEX);
> > +	if (!res) {
> > +		dev_err(&pdev->dev, "Failed to get IPC resource\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	/* IPC registers */
> > +	scu_data->mem.flags = res->flags;
> > +	scu_data->mem.start = res->start;
> > +	scu_data->mem.end = res->start + PLAT_RESOURCE_IPC_SIZE - 1;
> > +
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
> 
> Why are you still saving these to device data?
> 
> What's stopping you operating on the structures directly?

OK, I've explained this in the previous iterations but here goes. The
problem is that the resources need to be filled dynamically as they are
whatever there is in the ACPI table.

Now, Consider that we have two PMC devices. It is possible that the
driver is bind to both in paraller which means that both are racing to
fill and use these structures leading to a corruption.

Another issue is that even if we have single device, the driver fills in
the structures and then we unbind it. These structures now are left with
that data which does not feel right.

Therefore I've put all we know in advance as const version of these
structures and then we use those as template to build custom ones based
on resources extracted from ACPI to individual instances.
