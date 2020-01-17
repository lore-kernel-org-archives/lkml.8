Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C175C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0D62073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:31:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3s6dsiG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgAQLbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:31:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50762 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgAQLbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:31:48 -0500
Received: by mail-wm1-f68.google.com with SMTP id a5so7110072wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 03:31:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=cfy07DwWiHWEaUzIl/EIgqIgAwSUXdJZnQft4rG8lt8=;
        b=U3s6dsiGmyrLYmzuvR2cAzPzdTJJQBUae6nGZS9XFV0kHwnekqy6p4vB7IAokRccdD
         kN+kQ4wUCsUkKGkeFPbG2heQzmU/leSxk096t3NqwUR7YjOVTn3vJsa622SydqUpnbfV
         qsuWrFBVAEeYT16CdY7niAtIdVfRSiW0ZryyM9SlBB2izMxb967S3Z/yTrpepLW/5ROq
         lpsIN6z4SdTriKqeEAoMHTFmYt0qQ9PXar4DB91ZTGUjppWOeiYRivXDuin1QSTdj8Gh
         TeVZX8lDOLHpMk1nCcrCTY0oOdZWEMTF3gfaipqS6Cka4Fkl3RKL8biwwUi6c4W4UNzX
         oCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=cfy07DwWiHWEaUzIl/EIgqIgAwSUXdJZnQft4rG8lt8=;
        b=ixMWVnxRRdO7Ihmw4E0dst4tQOmDFWszNEF7yz/kIP3yaLXf6kOVMj4u5RsO0Fi3nr
         NHKCpe8SraCMt0J+eZqwUTdM5yWWH9OKGQGhx2HTHzbnc10mFmmB/RzPn6GgqS64Awuw
         AxNHgf7m608CZrlm/isqTjJppVoa3OeX72V2MtHAuD/gVV9nxattd+WT9PmKkiYVnNzY
         vMMwLZlhJluMEM/gncXAGyO5OypJvYv3lZ0NgsfxYAapfoZZO1f0tfR1USBCQe/Mt7Ou
         v1xu95D0tiUd6VnPr6vPg0YevQdmesxPdPSNonXpZulJ4B8bJZgRvs55sSZgKvfZP0YM
         wx/g==
X-Gm-Message-State: APjAAAX8yZPSr9yihpSLhf3mN87Ssf3F9z08V2wYFWIFi1nER1wrrgeG
        OugRqhD2pNBQrpgrsjTCVyVJWQ==
X-Google-Smtp-Source: APXvYqyCUirSIHZ+eGc8fQUhI/3GugYvYrQN9l5WbZBVrR91BvzbIBg9ii7Sct3Trdb+X6wcsSJQ4A==
X-Received: by 2002:a05:600c:d6:: with SMTP id u22mr4156889wmm.77.1579260705047;
        Fri, 17 Jan 2020 03:31:45 -0800 (PST)
Received: from dell ([2.27.35.221])
        by smtp.gmail.com with ESMTPSA id e6sm35160827wru.44.2020.01.17.03.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:31:44 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:32:02 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
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
Message-ID: <20200117113202.GH15507@dell>
References: <20200113135623.56286-1-mika.westerberg@linux.intel.com>
 <20200113135623.56286-36-mika.westerberg@linux.intel.com>
 <20200116132108.GH325@dell>
 <20200116143730.GE2838@lahna.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200116143730.GE2838@lahna.fi.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020, Mika Westerberg wrote:
> On Thu, Jan 16, 2020 at 01:21:08PM +0000, Lee Jones wrote:
> > On Mon, 13 Jan 2020, Mika Westerberg wrote:
> > 
> > > This driver only creates a bunch of platform devices sharing resources
> > > belonging to the PMC device. This is pretty much what MFD subsystem is
> > > for so move the driver there, renaming it to intel_pmc_bxt.c which
> > > should be more clear what it is.
> > > 
> > > MFD subsystem provides nice helper APIs for subdevice creation so
> > > convert the driver to use those. Unfortunately the ACPI device includes
> > > separate resources for most of the subdevices so we cannot simply call
> > > mfd_add_devices() to create all of them but instead we need to call it
> > > separately for each device.
> > > 
> > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > ---
> > >  drivers/mfd/Kconfig                           |  16 +-
> > >  drivers/mfd/Makefile                          |   1 +
> > >  drivers/mfd/intel_pmc_bxt.c                   | 543 +++++++++++++++
> > >  drivers/platform/x86/Kconfig                  |  16 +-
> > >  drivers/platform/x86/Makefile                 |   1 -
> > >  drivers/platform/x86/intel_pmc_ipc.c          | 650 ------------------
> > >  .../platform/x86/intel_telemetry_debugfs.c    |   2 +-
> > >  drivers/usb/typec/tcpm/Kconfig                |   2 +-
> > >  .../linux/mfd/intel_pmc_bxt.h                 |  11 +-
> > >  9 files changed, 573 insertions(+), 669 deletions(-)
> > >  create mode 100644 drivers/mfd/intel_pmc_bxt.c
> > >  delete mode 100644 drivers/platform/x86/intel_pmc_ipc.c
> > >  rename arch/x86/include/asm/intel_pmc_ipc.h => include/linux/mfd/intel_pmc_bxt.h (83%)

[...]

> > > +#include <linux/acpi.h>
> > > +#include <linux/delay.h>
> > > +#include <linux/errno.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/io-64-nonatomic-lo-hi.h>
> > > +#include <linux/mfd/core.h>
> > > +#include <linux/mfd/intel_pmc_bxt.h>
> > > +#include <linux/module.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include <asm/intel_scu_ipc.h>
> > > +
> > > +#include <linux/platform_data/itco_wdt.h>
> > 
> > Why are these 2 header files separated form the rest?
> 
> This was like that in the original driver. I did not want to touch
> non-functional parts too much during the conversion.

Although not a deal breaker in this instance, we need to think of this
as a new driver since the expectations between Platform and MFD may
well be different.

> > > +/* Residency with clock rate at 19.2MHz to usecs */
> > > +#define S0IX_RESIDENCY_IN_USECS(d, s)		\
> > > +({						\
> > > +	u64 result = 10ull * ((d) + (s));	\
> > > +	do_div(result, 192);			\
> > > +	result;					\
> > 
> > OOI, what does this line do?
> 
> result becomes value of the whole expression, see:
> 
>   https://gcc.gnu.org/onlinedocs/gcc-9.2.0/gcc/Statement-Exprs.html#Statement-Exprs

Thank you.

[...]

> > > +static struct intel_pmc_dev {
> > > +	struct device *dev;
> > > +
> > > +	/* iTCO */
> > 
> > Not sure these are required, the variables are clear enough.
> 
> OK
> 
> > > +	struct resource tco_res[2];
> > > +
> > > +	/* gcr */
> > > +	void __iomem *gcr_mem_base;
> > > +	spinlock_t gcr_lock;
> > > +
> > > +	/* punit */
> > > +	struct resource punit_res[6];
> > > +	unsigned int punit_res_count;
> > > +
> > > +	/* Telemetry */
> > > +	struct resource *telem_base;
> > > +} pmcdev;
> > 
> > Why not create this dynamically?
> 
> This is also from the original driver probably due to reasons that there
> can be only a single PMC in a system.
> 
> I don't think anything prevents this to be created dynamically though.

Great.  That would help bring the driver into line with other drivers
currently residing in MFD.

[...]

> > Looks like Regmap could save you the trouble here.
> 
> Agreed.

Great.

[...]

> > > +static int update_no_reboot_bit(void *priv, bool set)
> > > +{
> > > +	u32 value = set ? PMC_CFG_NO_REBOOT_EN : PMC_CFG_NO_REBOOT_DIS;
> > > +
> > > +	return intel_pmc_gcr_update(PMC_GCR_PMC_CFG_REG,
> > > +				    PMC_CFG_NO_REBOOT_MASK, value);
> > > +}
> > 
> > Only used by the Watchdog?  Maybe move in there?
> 
> Yes, this is only used by watchdog. 
> 
> We pass this function as part of itco_wdt_platform_data so that it does
> not need to know the details about how to access the PMC.

Maybe Regmap will solve this too.

[...]

> > > +static DEVICE_ATTR(simplecmd, 0200, NULL, intel_pmc_simple_cmd_store);
> > 
> > I assume you've drafted some documentation for this?
> 
> I don't think there is documentation about this yet. This is from the
> original driver. I can add it though.
> 
> > If not, you need to.
> 
> Yup.

SYSFS entries require documenting in Documentation.

[...]

> > Is that a good idea?  No security implications for doing so?
> 
> No don't think it is a good idea to be honest. I would like to get rid
> of both of these but the problem is that these are part of userspace ABI
> (that was exposed by to original driver) so changing it may break
> something.

Hmm... that is an issue.  However, since it's not changing any
existing behaviour, I won't make it an issue for *this* set of
changes.  Please justify it in the commit log though please.

[...]

> > > +	ret = pmc_create_telemetry_device();
> > > +	if (ret)
> > > +		dev_warn(pmcdev.dev, "Failed to add telemetry platform device\n");
> > > +
> > > +	return ret;
> > > +}
> > 
> > Once you have split out the 'struct mfd_cells' from the functions
> > above, you can move the devm_mfd_add_devices() calls into probe() and
> > do away with all of these functions which will greatly simplify the
> > driver as a whole.
> 
> OK, but there is one catch. Some of these addresses need to be filled
> dynamically when we parse the device resources which means that we need
> to take copy of that static structure to avoid modifying it. For example
> if the driver is unbound and then bind back from sysfs the old values
> are still there).

Not sure I understand.  If the driver is unbound then rebound, the
device resources will be re-parsed, no?

[...]

> > > +		return -ENXIO;
> > 
> > Is "No such device or address" the correct response for this?
> 
> That was in the original code. Maybe -ENOMEM is better in this case?

No, that's not correct either, since we haven't run out of memory.

-EINVAL and -ENODEV are common.

> > > +	tco_res[0].flags = IORESOURCE_IO;
> > > +	tco_res[0].start = res->start + TCO_BASE_OFFSET;
> > > +	tco_res[0].end = tco_res[0].start + TCO_REGS_SIZE - 1;
> > > +	tco_res[1].flags = IORESOURCE_IO;
> > > +	tco_res[1].start = res->start + SMI_EN_OFFSET;
> > > +	tco_res[1].end = tco_res[1].start + SMI_EN_SIZE - 1;
> > > +
> > > +	dev_dbg(&pdev->dev, "IO: %pR\n", res);
> > 
> > Do all of these dev_dgb() prints really still serve a purpose?
> 
> No, just for seeing what the resources are. I can remove them.

Thanks.

[...]

> > > +	pmcdev.gcr_mem_base = addr + PLAT_RESOURCE_GCR_OFFSET;
> > > +	dev_dbg(&pdev->dev, "IPC: %pR\n", res);
> > > +
> > > +	res = platform_get_resource(pdev, IORESOURCE_MEM,
> > > +				    PLAT_RESOURCE_TELEM_SSRAM_INDEX);
> > > +	if (!res) {
> > > +		dev_err(&pdev->dev, "Failed to get telemetry SSRAM resource\n");
> > 
> > Is this actually an error?  If so, it should return an error code.
> 
> I don't think this is an error. I can lower this to dev_dbg().

Maybe consider dev_warn() and change the working to make it not seem
like a failure.

> > > +	} else {
> > > +		dev_dbg(&pdev->dev, "Telemetry SSRAM: %pR\n", res);
> > > +		pmcdev.telem_base = res;
> > > +	}
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * intel_pmc_s0ix_counter_read() - Read S0ix residency.
> > 
> > What is residency?
> 
> Here it means amount of time the system has been in S0ix (low power mode
> in intel CPUs).

Could you clarify that in the comments please?

[...]

> > > +	scu = intel_scu_ipc_probe(&pdev->dev, &pdata);
> > 
> > This is a parent or child device?
> 
> The SCU IPC is a library so here it is just the device that has the SCU
> IPC registers the library can use.

"probing" a library doesn't sound right.

Looking at the code, I think this should be a device.

[...]

> > > +/* Some modules are dependent on this, so init earlier */
> > > +fs_initcall(intel_pmc_init);
> > 
> > Prefer if you didn't have to rely on this.
> > 
> > Can you use -EPROBE_DEFER instead?
> 
> I think the only modules outside of the ones this creates are the ones
> using SCU IPC separately but they are already converted to handle the
> situation where the IPC is not available.
> 
> So I think we can change this to be module_platform_driver(). I'll try
> it and see if that works.

That would be ideal, thanks.

> > > diff --git a/arch/x86/include/asm/intel_pmc_ipc.h b/include/linux/mfd/intel_pmc_bxt.h
> > > similarity index 83%
> > > rename from arch/x86/include/asm/intel_pmc_ipc.h
> > > rename to include/linux/mfd/intel_pmc_bxt.h
> > > index 22848df5faaf..f03a80df0728 100644
> > > --- a/arch/x86/include/asm/intel_pmc_ipc.h
> > > +++ b/include/linux/mfd/intel_pmc_bxt.h
> > 
> > Need to review this too.
> 
> Right, sorry about that. I suppose I need to pass '--no-renames' to git
> format-patch so it generates full diffs?

You're a smart chap, I'm sure you'll figure it out. ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
