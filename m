Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15FAFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB8EE206A5
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:15:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgENMPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:15:51 -0400
Received: from mga18.intel.com ([134.134.136.126]:28100 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbgENMPm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:15:42 -0400
IronPort-SDR: 2lbPDla9ifZ/FfB5W/zJfn3irWO6KVlDurIm1ipBoSEpjheB9AWWm5PU9OksCP6Ww6rHgyWPpm
 5NgseuHrJaIg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2020 05:15:40 -0700
IronPort-SDR: cObg6rwopXcw+E2AkorNYKXZ/LrbjIlvh77TuBFrRDmFkjBvq1r4K0cgW1yD/uwWDYe1578jcs
 QdmEz4SYVzqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,391,1583222400"; 
   d="scan'208";a="372252100"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 14 May 2020 05:15:36 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 14 May 2020 15:15:36 +0300
Date:   Thu, 14 May 2020 15:15:36 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Richard Hughes <hughsient@gmail.com>
Cc:     ptyser@xes-inc.com, Lee Jones <lee.jones@linaro.org>,
        tudor.ambarus@microchip.com,
        Kate Stewart <kstewart@linuxfoundation.org>,
        allison@lohutok.net, tglx@linutronix.de, jethro@fortanix.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mfd: Export LPC attributes for the system SPI chip
Message-ID: <20200514121536.GS2571@lahna.fi.intel.com>
References: <125a8c31e106dc68e6d3e3395cecc766db7fb897.camel@gmail.com>
 <20200513070847.GM2571@lahna.fi.intel.com>
 <CAD2FfiHsUjLC1K=HvF74LbRaKoc_zz6bOmGLQrQbW4CywWCP9A@mail.gmail.com>
 <20200513091100.GY2571@lahna.fi.intel.com>
 <CAD2FfiGNErUhz=7DH6Z37X573hSkJkzbOEXbb++X+Ey5WLc9=Q@mail.gmail.com>
 <20200513162513.GI2571@lahna.fi.intel.com>
 <c4602e6768377179ff3204ea0c2d5944e6d35844.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4602e6768377179ff3204ea0c2d5944e6d35844.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 07:27:50PM +0100, Richard Hughes wrote:
> On Wed, 2020-05-13 at 19:25 +0300, Mika Westerberg wrote:
> > This may be problematic if there is driver bound to the device and
> > accessing the hardware simultaneusly. Although this is just read side
> > and I don't think these registers have any side effects when you read
> > them, so should not be an issue.
> 
> Right, agreed.
> 
> > > So Cannon Lake, Cannon Point and Ice Lake would go into
> > > drivers/mtd/spi-nor/controllers/intel-spi-pci.c and the systems
> > > like
> > > Sunrise Point using an ISA bridge would use drivers/mfd/lpc_ich.c?
> > 
> > Yes, something like that.
> 
> Okay, lets get lpc_ich.c sorted, then I'll look at implementing the
> same securityfs interface for intel-spi-pci.c

Yup, sounds reasonable.

> > I would like to keep it (the label) there but I think we can label
> > SPI_INTEL_SPI with that instead and then make the -pci.c to work
> > standalone if CONFIG_SPI_INTEL_SPI is not enabled.
> 
> Okay, good idea. I'll have a look at this next week after we get the
> ISB bridges agreed on.
> 
> New patch here, if you want me to split it up a bit please just ask how
> you would like it split. I fear Evolution is mangling the patch so I
> might have to indeed start using git-send-email. :(

Right, I'm using git send-email and it works reasonably well.

I think Lee is the one who takes this so what he prefers. I suggest
using git send-email.

> Thanks,
> 
> Richard.
> 
> >From 0b395efde8da7d5099c87945def473ff164d1c4c Mon Sep 17 00:00:00 2001
> From: Richard Hughes <richard@hughsie.com>
> Date: Mon, 11 May 2020 14:19:27 +0100
> Subject: [PATCH] mfd: Export LPC attributes for the system SPI chip
> 
> Export standard SPI-specific config values from various LPC
> controllers.
> This allows userspace components such as fwupd to verify the most basic
> SPI
> protections are set correctly. For instance, checking BIOSWE is
> disabled
> and BLE is enabled.
> 
> Exporting these values from the kernel allows us to report the security
> level of the platform without rebooting and running an EFI binary like
> chipsec.
> 
> Signed-off-by: Richard Hughes <richard@hughsie.com>
> ---
>  Documentation/ABI/testing/sysfs-security-spi |  23 +++
>  drivers/mfd/lpc_ich.c                        | 169 ++++++++++++++++++-
>  include/linux/platform_data/intel-spi.h      |   1 +
>  3 files changed, 187 insertions(+), 6 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-security-spi
> 
> diff --git a/Documentation/ABI/testing/sysfs-security-spi
> b/Documentation/ABI/testing/sysfs-security-spi
> new file mode 100644
> index 000000000000..6805b74d7036
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-security-spi
> @@ -0,0 +1,23 @@
> +What:		/sys/kernel/security/firmware/bioswe

Should this still be "firmware_protections" or similar. Plain "firmware"
sounds again too generic. Maybe its just me..

> +Date:		May 2020
> +KernelVersion:	5.7.0
> +Contact:	richard@hughsie.com
> +Description:	If the system firmware set BIOS Write Enable.
> +		0: writes disabled, 1: writes enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/kernel/security/firmware/ble
> +Date:		May 2020
> +KernelVersion:	5.7.0
> +Contact:	richard@hughsie.com
> +Description:	If the system firmware set Bios Lock Enable.
> +		0: SMM lock disabled, 1: SMM lock enabled.
> +Users:		https://github.com/fwupd/fwupd
> +
> +What:		/sys/kernel/security/firmware/smm_bwp
> +Date:		May 2020
> +KernelVersion:	5.7.0
> +Contact:	richard@hughsie.com
> +Description:	If the system firmware set SMM Bios Write Protect.
> +		0: writes disabled unless in SMM, 1: writes enabled.
> +Users:		https://github.com/fwupd/fwupd
> diff --git a/drivers/mfd/lpc_ich.c b/drivers/mfd/lpc_ich.c
> index 3bbb29a7e7a5..fab017efdb9d 100644
> --- a/drivers/mfd/lpc_ich.c
> +++ b/drivers/mfd/lpc_ich.c
> @@ -33,6 +33,7 @@
>   *	document number 322169-001, 322170-003: 5 Series, 3400 Series
> (PCH)
>   *	document number 320066-003, 320257-008: EP80597 (IICH)
>   *	document number 324645-001, 324646-001: Cougar Point (CPT)
> + *	document number 332690-006, 332691-003: C230 (CPT)
>   */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> @@ -40,6 +41,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/errno.h>
> +#include <linux/security.h>
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <linux/mfd/core.h>
> @@ -68,6 +70,8 @@
>  #define SPIBASE_LPT_SZ		512
>  #define BCR			0xdc
>  #define BCR_WPD			BIT(0)
> +#define BCR_BLE			BIT(1)
> +#define BCR_SMM_BWP		BIT(5)
>  
>  #define SPIBASE_APL_SZ		4096
>  
> @@ -93,6 +97,11 @@ struct lpc_ich_priv {
>  	int abase_save;		/* Cached ACPI base value */
>  	int actrl_pbase_save;		/* Cached ACPI control or PMC
> base value */
>  	int gctrl_save;		/* Cached GPIO control value */
> +
> +	struct dentry *firmware_dir;	/* SecurityFS entries */
> +	struct dentry *firmware_bioswe;
> +	struct dentry *firmware_ble;
> +	struct dentry *firmware_smm_bwp;
>  };
>  
>  static struct resource wdt_ich_res[] = {
> @@ -221,6 +230,9 @@ enum lpc_chipsets {
>  	LPC_APL,	/* Apollo Lake SoC */
>  	LPC_GLK,	/* Gemini Lake SoC */
>  	LPC_COUGARMOUNTAIN,/* Cougar Mountain SoC*/
> +	LPC_SPT,	/* Sunrise Point */
> +	LPC_KBL,	/* Kaby Lake */
> +	LPC_TGL,	/* Tiger Lake */

These all have the SPI-NOR controller as separate PCI device (as ICL and
others).

I suggest you to add this feature to the existing entries instead of
adding these PCI IDs if you can't test them.

There are bunch of existing devices listed there that set .spi_type.

>  };
>  
>  static struct lpc_ich_info lpc_chipset_info[] = {
> @@ -557,6 +569,18 @@ static struct lpc_ich_info lpc_chipset_info[] = {
>  		.name = "Cougar Mountain SoC",
>  		.iTCO_version = 3,
>  	},
> +	[LPC_SPT] = {
> +		.name = "Sunrise Point",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_KBL] = {
> +		.name = "Kaby Lake-H",
> +		.spi_type = INTEL_SPI_LPC,
> +	},
> +	[LPC_TGL] = {
> +		.name = "Tiger Lake",
> +		.spi_type = INTEL_SPI_LPC,

So all of these have LCP/eSPI controller but the SPI-NOR controller is
not accessible through it - it is a separate PCI device.

> +	},
>  };
>  
>  /*
> @@ -792,6 +816,32 @@ static const struct pci_device_id lpc_ich_ids[] =
> {
>  	{ PCI_VDEVICE(INTEL, 0x9cc6), LPC_WPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9cc7), LPC_WPT_LP},
>  	{ PCI_VDEVICE(INTEL, 0x9cc9), LPC_WPT_LP},
> +	{ PCI_VDEVICE(INTEL, 0x9ce6), LPC_WPT_LP},
> +	{ PCI_VDEVICE(INTEL, 0x9d2a), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0x9d4e), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa0a4), LPC_TGL},
> +	{ PCI_VDEVICE(INTEL, 0xa140), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa141), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa142), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa143), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa144), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa145), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa146), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa147), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa148), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa149), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14a), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14b), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14c), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14d), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14e), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa14f), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa150), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa151), LPC_SPT},
> +	{ PCI_VDEVICE(INTEL, 0xa152), LPC_KBL},
> +	{ PCI_VDEVICE(INTEL, 0xa153), LPC_KBL},
> +	{ PCI_VDEVICE(INTEL, 0xa154), LPC_KBL},
> +	{ PCI_VDEVICE(INTEL, 0xa155), LPC_SPT},
>  	{ PCI_VDEVICE(INTEL, 0xa1c1), LPC_LEWISBURG},
>  	{ PCI_VDEVICE(INTEL, 0xa1c2), LPC_LEWISBURG},
>  	{ PCI_VDEVICE(INTEL, 0xa1c3), LPC_LEWISBURG},
> @@ -1083,6 +1133,103 @@ static int lpc_ich_init_wdt(struct pci_dev
> *dev)
>  	return ret;
>  }
>  
> +#if IS_ENABLED(CONFIG_SECURITY)
> +static ssize_t bioswe_read(struct file *filp, char __user *buf,
> +			   size_t count, loff_t *ppos)
> +{
> +	struct pci_dev *dev = filp->f_inode->i_private;
> +	char tmp[3];
> +	u32 bcr;
> +
> +	pci_read_config_dword(dev, BCR, &bcr);
> +	sprintf(tmp, "%d\n", bcr & BCR_WPD ? 1 : 0);
> +	return simple_read_from_buffer(buf, count, ppos, tmp,
> sizeof(tmp));

Like you said, Evolution seems to mangle these.

> +}
> +
> +static const struct file_operations spi_bioswe_ops = {
> +	.read  = bioswe_read,
> +};
> +
> +static ssize_t ble_read(struct file *filp, char __user *buf,
> +			size_t count, loff_t *ppos)
> +{
> +	struct pci_dev *dev = filp->f_inode->i_private;
> +	char tmp[3];
> +	u32 bcr;
> +
> +	pci_read_config_dword(dev, BCR, &bcr);
> +	sprintf(tmp, "%d\n", bcr & BCR_BLE ? 1 : 0);
> +	return simple_read_from_buffer(buf, count, ppos, tmp,
> sizeof(tmp));
> +}
> +
> +static const struct file_operations spi_ble_ops = {
> +	.read  = ble_read,
> +};
> +
> +static ssize_t smm_bwp_read(struct file *filp, char __user *buf,
> +			    size_t count, loff_t *ppos)
> +{
> +	struct pci_dev *dev = filp->f_inode->i_private;
> +	char tmp[3];
> +	u32 bcr;
> +
> +	pci_read_config_dword(dev, BCR, &bcr);
> +	sprintf(tmp, "%d\n", bcr & BCR_SMM_BWP ? 1 : 0);
> +	return simple_read_from_buffer(buf, count, ppos, tmp,
> sizeof(tmp));
> +}
> +
> +static const struct file_operations spi_smm_bwp_ops = {
> +	.read  = smm_bwp_read,
> +};
> +
> +static int lpc_ich_init_securityfs(struct pci_dev *dev)
> +{
> +	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> +
> +	priv->firmware_dir = securityfs_create_dir("firmware", NULL);
> +	if (IS_ERR(priv->firmware_dir))
> +		return -1;
> +
> +	priv->firmware_bioswe =
> +	    securityfs_create_file("bioswe",
> +				   0600, priv->firmware_dir, dev,
> +				   &spi_bioswe_ops);
> +	if (IS_ERR(priv->firmware_bioswe))
> +		goto out;
> +	priv->firmware_ble =
> +	    securityfs_create_file("ble",
> +				   0600, priv->firmware_dir, dev,
> +				   &spi_ble_ops);
> +	if (IS_ERR(priv->firmware_ble))
> +		goto out;
> +	priv->firmware_smm_bwp =
> +	    securityfs_create_file("smm_bwp",
> +				   0600, priv->firmware_dir, dev,
> +				   &spi_smm_bwp_ops);
> +	if (IS_ERR(priv->firmware_smm_bwp))
> +		goto out;
> +	return 0;
> +out:
> +	securityfs_remove(priv->firmware_ble);
> +	securityfs_remove(priv->firmware_bioswe);
> +	securityfs_remove(priv->firmware_dir);
> +	return -1;
> +}
> +
> +static void lpc_ich_uninit_securityfs(struct pci_dev *dev)
> +{
> +	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> +
> +	securityfs_remove(priv->firmware_smm_bwp);
> +	securityfs_remove(priv->firmware_ble);
> +	securityfs_remove(priv->firmware_bioswe);
> +	securityfs_remove(priv->firmware_dir);
> +}
> +#else
> +static inline int lpc_ich_init_securityfs(struct pci_dev *dev) {
> return 0; }
> +static inline void lpc_ich_uninit_securityfs(struct pci_dev *dev) {
> return 0; }
> +#endif
> +
>  static int lpc_ich_init_spi(struct pci_dev *dev)
>  {
>  	struct lpc_ich_priv *priv = pci_get_drvdata(dev);
> @@ -1111,10 +1258,14 @@ static int lpc_ich_init_spi(struct pci_dev
> *dev)
>  			spi_base = round_down(rcba, SPIBASE_LPT_SZ);
>  			res->start = spi_base + SPIBASE_LPT;
>  			res->end = res->start + SPIBASE_LPT_SZ - 1;
> -
> -			pci_read_config_dword(dev, BCR, &bcr);
> -			info->writeable = !!(bcr & BCR_WPD);
>  		}
> +		pci_read_config_dword(dev, BCR, &bcr);
> +		info->writeable = !!(bcr & BCR_WPD);
> +		break;
> +
> +	case INTEL_SPI_LPC:

So instead of this, you can add the security attributes to the existing
entries where we are sure there is SPI-NOR controller behind LPC. Here
it is not the case and further..

> +		pci_read_config_dword(dev, BCR, &bcr);
> +		info->writeable = !!(bcr & BCR_WPD);
>  		break;
>  
>  	case INTEL_SPI_BXT: {
> @@ -1146,8 +1297,10 @@ static int lpc_ich_init_spi(struct pci_dev *dev)
>  		return -EINVAL;
>  	}
>  
> -	if (!res->start)
> -		return -ENODEV;
> +	if (info->type != INTEL_SPI_LPC) {

.. we can avoid checks like this ;-)

> +		if (!res->start)
> +			return -ENODEV;
> +	}
>  
>  	lpc_ich_spi_cell.platform_data = info;
>  	lpc_ich_spi_cell.pdata_size = sizeof(*info);
> @@ -1201,8 +1354,11 @@ static int lpc_ich_probe(struct pci_dev *dev,
>  
>  	if (lpc_chipset_info[priv->chipset].spi_type) {
>  		ret = lpc_ich_init_spi(dev);
> -		if (!ret)
> +		if (!ret) {
> +			if (lpc_ich_init_securityfs(dev))
> +				return -EINVAL;
>  			cell_added = true;
> +		}
>  	}
>  
>  	/*
> @@ -1221,6 +1377,7 @@ static int lpc_ich_probe(struct pci_dev *dev,
>  static void lpc_ich_remove(struct pci_dev *dev)
>  {
>  	mfd_remove_devices(&dev->dev);
> +	lpc_ich_uninit_securityfs(dev);
>  	lpc_ich_restore_config_space(dev);
>  }
>  
> diff --git a/include/linux/platform_data/intel-spi.h
> b/include/linux/platform_data/intel-spi.h
> index 7f53a5c6f35e..ed5b527cf1c6 100644
> --- a/include/linux/platform_data/intel-spi.h
> +++ b/include/linux/platform_data/intel-spi.h
> @@ -14,6 +14,7 @@ enum intel_spi_type {
>  	INTEL_SPI_LPT,
>  	INTEL_SPI_BXT,
>  	INTEL_SPI_CNL,
> +	INTEL_SPI_LPC,

So I would not add this type here at all. Just add the security nodes to
the existing entries for now. Rest need to be part of the
intel-spi-pci.c, I think.

Otherwise this looks good, nice work :)

>  };
>  
>  /**
> -- 
> 2.26.2
> 
> 
> 
