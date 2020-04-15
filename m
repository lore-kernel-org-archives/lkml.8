Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A865C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67188206D5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 12:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586955023;
	bh=YudaV565w6btpCVfkDa53B7k9IwUOjEJzRGtCM4oZpg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s1tDZaLJfmYLDSRoKfWpWDRK+6glrR7kpJT0BGV4L9bVsaXgBdTkhnJWekXTOX6S5
	 WBvhDfUrrv1D9HzrrrcUopvH2qx7bqNkY8MixzoZwQUvkG3OkuxfryIoabZajEy/OE
	 O/LuG0lbvYnSwPGFTvHvSnU1IMR1YB22FlBZfw6Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S370410AbgDOMuW (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 08:50:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58904 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S370362AbgDOMtd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 08:49:33 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74B43206D5;
        Wed, 15 Apr 2020 12:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586954971;
        bh=YudaV565w6btpCVfkDa53B7k9IwUOjEJzRGtCM4oZpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MvhzHoXnZd6QsEJ4Yfy+sgm47S1WPqDVf1yFwRKpePmQvWl9nCqRzzu8sP0obG5Ai
         ltjkVY5rOF4O4jAREviY8DLKNSCmqh0MTbT5+vhOgcJqI3VVapO0j0VbBDrLQR9qk4
         rw4ybt0VHtSEBrlVHXCViFBAeSMRpMweThfY9JRo=
Date:   Wed, 15 Apr 2020 14:49:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wang Wenhu <wenhu.wang@vivo.com>
Cc:     linux-kernel@vger.kernel.org, oss@buserror.net,
        christophe.leroy@c-s.fr, linuxppc-dev@lists.ozlabs.org,
        kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 5/5] drivers: uio: new driver for fsl_85xx_cache_sram
Message-ID: <20200415124929.GA3265842@kroah.com>
References: <20200415123346.116212-1-wenhu.wang@vivo.com>
 <20200415123346.116212-6-wenhu.wang@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415123346.116212-6-wenhu.wang@vivo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 05:33:46AM -0700, Wang Wenhu wrote:
> A driver for freescale 85xx platforms to access the Cache-Sram form
> user level. This is extremely helpful for some user-space applications
> that require high performance memory accesses.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> Cc: Scott Wood <oss@buserror.net>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
> ---
>  drivers/uio/Kconfig                   |   8 ++
>  drivers/uio/Makefile                  |   1 +
>  drivers/uio/uio_fsl_85xx_cache_sram.c | 195 ++++++++++++++++++++++++++
>  3 files changed, 204 insertions(+)
>  create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81cfc2b..afd38ec13de0 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -105,6 +105,14 @@ config UIO_NETX
>  	  To compile this driver as a module, choose M here; the module
>  	  will be called uio_netx.
>  
> +config UIO_FSL_85XX_CACHE_SRAM
> +	tristate "Freescale 85xx Cache-Sram driver"
> +	depends on FSL_85XX_CACHE_SRAM
> +	help
> +	  Generic driver for accessing the Cache-Sram form user level. This
> +	  is extremely helpful for some user-space applications that require
> +	  high performance memory accesses.
> +
>  config UIO_FSL_ELBC_GPCM
>  	tristate "eLBC/GPCM driver"
>  	depends on FSL_LBC
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2a4539..be2056cffc21 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -10,4 +10,5 @@ obj-$(CONFIG_UIO_NETX)	+= uio_netx.o
>  obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>  obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>  obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
> +obj-$(CONFIG_UIO_FSL_85XX_CACHE_SRAM)	+= uio_fsl_85xx_cache_sram.o
>  obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> diff --git a/drivers/uio/uio_fsl_85xx_cache_sram.c b/drivers/uio/uio_fsl_85xx_cache_sram.c
> new file mode 100644
> index 000000000000..e11202dd5b93
> --- /dev/null
> +++ b/drivers/uio/uio_fsl_85xx_cache_sram.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify it
> + * under the terms of the GNU General Public License version 2 as published
> + * by the Free Software Foundation.

Nit, you don't need this sentance anymore now that you have the SPDX
line above

> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/uio_driver.h>
> +#include <linux/stringify.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <asm/fsl_85xx_cache_sram.h>
> +
> +#define DRIVER_VERSION	"0.1.0"

Don't do DRIVER_VERSIONs, they never work once the code is in the kernel
tree.

> +#define DRIVER_NAME	"uio_fsl_85xx_cache_sram"

KBUILD_MODNAME?

> +#define UIO_NAME	"uio_cache_sram"
> +
> +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> +	{	.compatible = "uio,fsl,p2020-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p2010-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1020-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1011-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1013-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1022-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8548-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8544-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8572-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,mpc8536-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1021-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1012-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1025-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1016-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1024-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1015-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,p1010-l2-cache-controller",	},
> +	{	.compatible = "uio,fsl,bsc9131-l2-cache-controller",	},
> +	{},
> +};
> +
> +static void uio_info_free_internal(struct uio_info *info)
> +{
> +	struct uio_mem *uiomem = &info->mem[0];
> +
> +	while (uiomem < &info->mem[MAX_UIO_MAPS]) {
> +		if (uiomem->size) {
> +			mpc85xx_cache_sram_free(uiomem->internal_addr);
> +			kfree(uiomem->name);
> +		}
> +		uiomem++;
> +	}
> +}
> +
> +static int uio_fsl_85xx_cache_sram_probe(struct platform_device *pdev)
> +{
> +	struct device_node *parent = pdev->dev.of_node;
> +	struct device_node *node = NULL;
> +	struct uio_info *info;
> +	struct uio_mem *uiomem;
> +	const char *dt_name;
> +	u32 mem_size;
> +	u32 align;
> +	void *virt;
> +	phys_addr_t phys;
> +	int ret = -ENODEV;
> +
> +	/* alloc uio_info for one device */
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info) {
> +		dev_err(&pdev->dev, "kzalloc uio_info failed\n");

kzalloc already says this.

> +		ret = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	/* get optional uio name */
> +	if (of_property_read_string(parent, "uio_name", &dt_name))
> +		dt_name = UIO_NAME;
> +
> +	info->name = kstrdup(dt_name, GFP_KERNEL);
> +	if (!info->name) {
> +		dev_err(&pdev->dev, "error kstrdup uio_name\n");

kstrdup should have given you an error string already, right?

> +		ret = -ENOMEM;
> +		goto err_info_free;
> +	}
> +
> +	uiomem = &info->mem[0];
> +	for_each_child_of_node(parent, node) {
> +		if (!node) {
> +			dev_err(&pdev->dev, "device's OF-node is NULL\n");

How can this happen?

> +			continue;

Why not error out?

> +		}
> +
> +		ret = of_property_read_u32(node, "cache-mem-size", &mem_size);
> +		if (ret) {
> +			dev_err(&pdev->dev, "missing cache-mem-size value\n");

You don't exit?

> +			continue;
> +		}
> +
> +		if (mem_size == 0) {
> +			dev_err(&pdev->dev, "cache-mem-size should not be 0\n");

Again, you don't exit?

> +			continue;
> +		}
> +
> +		align = 2;
> +		while (align < mem_size)
> +			align *= 2;
> +		virt = mpc85xx_cache_sram_alloc(mem_size, &phys, align);
> +		if (!virt) {
> +			dev_err(&pdev->dev, "allocate 0x%x cache-mem failed\n", mem_size);

You don't exit?

> +			continue;
> +		}
> +
> +		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->addr = phys;
> +		uiomem->size = mem_size;
> +		uiomem->name = kstrdup(node->name, GFP_KERNEL);;
> +		uiomem->internal_addr = virt;
> +		++uiomem;
> +
> +		if (uiomem >= &info->mem[MAX_UIO_MAPS]) {
> +			dev_warn(&pdev->dev, "device has more than "
> +				 __stringify(MAX_UIO_MAPS)
> +				 " I/O memory resources.\n");

What can someone do with that?

thanks,

greg k-h
