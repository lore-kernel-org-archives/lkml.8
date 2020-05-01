Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 943D5C4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:10:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CCE1208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 08:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588320607;
	bh=uLiq5a6dLXMXcUMycTUCiQ72GItaDCJTBvLnDyCMgaU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QUhQS08uu/gfDSRDZAlf5pgfTUeuCSmW9NkFQG8oSZ3/mQUtohSe2uVUE8ORPSrXV
	 A5cYVSsarqXolCKEi1qyva+fmkgSY4qSoG6NU6/D1uDLX3MjNhEdKNhTmXOEENa4O9
	 /94W5srcle91tIWtrc5dLrqRvMiN7c+RKHcStBZI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbgEAIKG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 04:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgEAIKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 04:10:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95066208C3;
        Fri,  1 May 2020 08:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588320605;
        bh=uLiq5a6dLXMXcUMycTUCiQ72GItaDCJTBvLnDyCMgaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q09Nip3gCCH28XrCXedTsqKkbmfolu2ECXp0fSwUUkdl0Jn0SeTsnGufVmeQo+rMD
         FQugMCAdc082I/GKgzN9JC2JEcqznsoRybTBsIRgfCg5BmBPhAixZffS8kJ7E34DGT
         4zRWoPgrzBUR9RZJjja9gnPBo5ZrKO6brkRP1Jb4=
Date:   Fri, 1 May 2020 10:10:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Paul J Murphy <paul.j.murphy@intel.com>
Subject: Re: [PATCH 1/1] soc: keembay: Add Keem Bay IMR driver
Message-ID: <20200501081002.GA1055721@kroah.com>
References: <cover.1587485099.git.daniele.alessandrelli@intel.com>
 <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13ca92165fab2827b6d439661e75f5b91ef083c2.1587485099.git.daniele.alessandrelli@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 21, 2020 at 05:36:18PM +0100, Daniele Alessandrelli wrote:
> From: Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> 
> Keem Bay bootloader sets up a temporary Isolated Memory Region (IMR) to
> protect itself during pre-Linux boot.
> 
> This temporary IMR remains active even when control is passed to the
> Linux Kernel. It is Kernel responsibility to remove such an IMR during
> initialization.
> 
> This driver adds such functionality.
> 
> The driver is loaded during `early_init`, which should ensure that the
> IMR is removed before devices that may try to access the IMR are
> initialized.
> 
> Signed-off-by: Daniele Alessandrelli <daniele.alessandrelli@intel.com>

First off, there is a "proper" way to send patches to the kernel
community that Intel has that I do not think you are following.  Please
work with the Intel "Linux group" to do that first, as odds are they
would have caught all of these issues beforehand (hint, which is why
that process is in place...)

> ---
>  MAINTAINERS                       |  5 ++++
>  drivers/soc/Kconfig               |  1 +
>  drivers/soc/Makefile              |  1 +
>  drivers/soc/keembay/Kconfig       | 22 +++++++++++++++++
>  drivers/soc/keembay/Makefile      |  5 ++++
>  drivers/soc/keembay/keembay-imr.c | 40 +++++++++++++++++++++++++++++++
>  6 files changed, 74 insertions(+)
>  create mode 100644 drivers/soc/keembay/Kconfig
>  create mode 100644 drivers/soc/keembay/Makefile
>  create mode 100644 drivers/soc/keembay/keembay-imr.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b816a453b10e..59f1923a0f25 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9194,6 +9194,11 @@ S:	Maintained
>  W:	http://lse.sourceforge.net/kdump/
>  F:	Documentation/admin-guide/kdump/
>  
> +KEEMBAY IMR
> +M:	Daniele Alessandrelli <daniele.alessandrelli@intel.com>
> +S:	Maintained
> +F:	drivers/soc/keembay/keembay-imr.c
> +
>  KEENE FM RADIO TRANSMITTER DRIVER
>  M:	Hans Verkuil <hverkuil@xs4all.nl>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
> index 425ab6f7e375..eeeba3ef7338 100644
> --- a/drivers/soc/Kconfig
> +++ b/drivers/soc/Kconfig
> @@ -9,6 +9,7 @@ source "drivers/soc/bcm/Kconfig"
>  source "drivers/soc/fsl/Kconfig"
>  source "drivers/soc/imx/Kconfig"
>  source "drivers/soc/ixp4xx/Kconfig"
> +source "drivers/soc/keembay/Kconfig"

For a single 40 line driver, do not make a new directory.  If you end up
with lots in the future, then just move the files.  Don't over-engineer
we have no idea what will actually happen in the future.

>  source "drivers/soc/mediatek/Kconfig"
>  source "drivers/soc/qcom/Kconfig"
>  source "drivers/soc/renesas/Kconfig"
> diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
> index 36452bed86ef..65c981207283 100644
> --- a/drivers/soc/Makefile
> +++ b/drivers/soc/Makefile
> @@ -13,6 +13,7 @@ obj-y				+= fsl/
>  obj-$(CONFIG_ARCH_GEMINI)	+= gemini/
>  obj-y				+= imx/
>  obj-$(CONFIG_ARCH_IXP4XX)	+= ixp4xx/
> +obj-y				+= keembay/
>  obj-$(CONFIG_SOC_XWAY)		+= lantiq/
>  obj-y				+= mediatek/
>  obj-y				+= amlogic/
> diff --git a/drivers/soc/keembay/Kconfig b/drivers/soc/keembay/Kconfig
> new file mode 100644
> index 000000000000..2161bce131b3
> --- /dev/null
> +++ b/drivers/soc/keembay/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Keem Bay SoC drivers.
> +#
> +
> +menu "Keem Bay SoC drivers"
> +
> +config KEEMBAY_IMR
> +	bool "Clean-up Keem Bay bootloader IMR at boot"
> +	depends on ARM64
> +	help
> +	  This option makes the Kernel clean up the Isolated Memory Region
> +	  (IMR) set up by Keem Bay bootloader (U-boot) to protect itself during
> +	  early boot.
> +
> +	  The IMR number to be cleaned up is taken from the device tree
> +	  (property 'u-boot-imr' of the 'chosen' node).
> +
> +	  If you are compiling the Kernel for a Keem Bay SoC select Y,
> +	  otherwise select N.

No module support?

What about kernels that support more than one ARM device in the same
kernel, you just broke that :(

> +
> +endmenu
> diff --git a/drivers/soc/keembay/Makefile b/drivers/soc/keembay/Makefile
> new file mode 100644
> index 000000000000..dacfdb9f5fc1
> --- /dev/null
> +++ b/drivers/soc/keembay/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for Keem Bay SoC drivers.
> +#
> +obj-$(CONFIG_KEEMBAY_IMR) += keembay-imr.o
> diff --git a/drivers/soc/keembay/keembay-imr.c b/drivers/soc/keembay/keembay-imr.c
> new file mode 100644
> index 000000000000..eabbdd6e69a7
> --- /dev/null
> +++ b/drivers/soc/keembay/keembay-imr.c
> @@ -0,0 +1,40 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (C) 2019-2020 Intel Corporation
> + */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/arm-smccc.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/printk.h>
> +#include <linux/types.h>
> +
> +/* Keem Bay SiP SVC for clearing an IMR. */
> +#define KMB_SIP_SVC_IMR_CLEAR	0x8200ff13
> +
> +static int __init clear_imr(u64 imr)
> +{
> +	struct arm_smccc_res res = { 0 };
> +
> +	arm_smccc_smc(KMB_SIP_SVC_IMR_CLEAR, imr, 0, 0, 0, 0, 0, 0, &res);
> +
> +	return res.a0;
> +}
> +
> +static int __init kmb_imr_init(void)
> +{
> +	u32 imr;
> +	int rc;
> +
> +	rc = of_property_read_u32(of_chosen, "u-boot-imr", &imr);

Is there a device tree documetnation for this attribute?  You have to
have that approved before you can get your code merged.

> +	if (rc) {
> +		pr_warn("Skipping IMR clean-up: No U-Boot IMR defined in device tree\n");
> +		return 0;
> +	}
> +	pr_info("Disabling Keem Bay U-boot IMR: %u\n", imr);

Drivers are quiet if all is good, don't be noisy for no reason.

> +
> +	return clear_imr(imr);

Did that really need to be a separate function?

> +}
> +early_initcall(kmb_imr_init);

Like I said above, you just broke multi-system kernels by always trying
to do this.  Trigger off of a hardware device that only your platform
has in order to properly load and run.  As-is, you don't want to do
this.

Anyway, Intel owes me more liquor for this review as the resources you
had to get review of this were obviously not taken advantage of.

greg k-h
