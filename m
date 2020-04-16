Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4AFC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D586214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 15:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="WhAfbrGR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894782AbgDPPoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 11:44:04 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50014 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2395251AbgDPPnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 11:43:41 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4933RF1w3tz9v0Dg;
        Thu, 16 Apr 2020 17:43:37 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=WhAfbrGR; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id c6tOpGTqvzIj; Thu, 16 Apr 2020 17:43:37 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4933RF0VYpz9v0Dd;
        Thu, 16 Apr 2020 17:43:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1587051817; bh=GEVTu3uSW8WWYnixNM8Mp00ac4JacjVJIeeRWD2RosQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WhAfbrGRIpOgUNkc/nY+qzUZ0ndQvAr0fAF0ZDusDpi+zav8oeoX8qrR8+MPL2em7
         aTL4PCY8EU/OafHbjIaZaAcOZM462NhQKHhUbPpCt3Iia/RWNJcKIIFXAgSR8F0do0
         U0deAI4Z5eHMjKp68oJDKoZiZK9zx9sZe8eknlZs=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ECCFD8BB89;
        Thu, 16 Apr 2020 17:43:38 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id OP_QTU9uqPRL; Thu, 16 Apr 2020 17:43:38 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C0DC88BB85;
        Thu, 16 Apr 2020 17:43:37 +0200 (CEST)
Subject: Re: [PATCH v4,4/4] drivers: uio: new driver for fsl_85xx_cache_sram
To:     Wang Wenhu <wenhu.wang@vivo.com>, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, oss@buserror.net,
        linuxppc-dev@lists.ozlabs.org
Cc:     kernel@vivo.com, Michael Ellerman <mpe@ellerman.id.au>
References: <20200416153537.23736-1-wenhu.wang@vivo.com>
 <20200416153537.23736-5-wenhu.wang@vivo.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <8a6656ed-e5b3-4caf-5a15-5c827bf6d7b0@c-s.fr>
Date:   Thu, 16 Apr 2020 17:43:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200416153537.23736-5-wenhu.wang@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le 16/04/2020 à 17:35, Wang Wenhu a écrit :
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

Reviewed-by: Christophe Leroy <christophe.leroy@c-s.fr>

> ---
> Changes since v1:
>   * Addressed comments from Greg K-H
>   * Moved kfree(info->name) into uio_info_free_internal()
> Changes since v2:
>   * Addressed comments from Greg, Scott and Christophe
>   * Use "uiomem->internal_addr" as if condition for sram memory free,
>     and memset the uiomem entry
>   * of_match_table modified to be apart from HW info which belong to
>     the HW level driver fsl_85xx_cache_sram to match
>   * Use roundup_pow_of_two for align calc(really learned a lot from Christophe)
>   * Remove useless clear block of uiomem entries.
>   * Use UIO_INFO_VER micro for info->version, and define it as
>     "devicetree,pseudo", meaning this is pseudo device and probed from
>     device tree configuration
> Changes since v3:
>   * Addressed comments from Christophe(use devm_xxx memory alloc interfaces)
> ---
>   drivers/uio/Kconfig                   |   9 ++
>   drivers/uio/Makefile                  |   1 +
>   drivers/uio/uio_fsl_85xx_cache_sram.c | 148 ++++++++++++++++++++++++++
>   3 files changed, 158 insertions(+)
>   create mode 100644 drivers/uio/uio_fsl_85xx_cache_sram.c
> 
> diff --git a/drivers/uio/Kconfig b/drivers/uio/Kconfig
> index 202ee81cfc2b..9c3b47461b71 100644
> --- a/drivers/uio/Kconfig
> +++ b/drivers/uio/Kconfig
> @@ -105,6 +105,15 @@ config UIO_NETX
>   	  To compile this driver as a module, choose M here; the module
>   	  will be called uio_netx.
>   
> +config UIO_FSL_85XX_CACHE_SRAM
> +	tristate "Freescale 85xx Cache-Sram driver"
> +	depends on FSL_SOC_BOOKE && PPC32
> +	select FSL_85XX_CACHE_SRAM
> +	help
> +	  Generic driver for accessing the Cache-Sram form user level. This
> +	  is extremely helpful for some user-space applications that require
> +	  high performance memory accesses.
> +
>   config UIO_FSL_ELBC_GPCM
>   	tristate "eLBC/GPCM driver"
>   	depends on FSL_LBC
> diff --git a/drivers/uio/Makefile b/drivers/uio/Makefile
> index c285dd2a4539..be2056cffc21 100644
> --- a/drivers/uio/Makefile
> +++ b/drivers/uio/Makefile
> @@ -10,4 +10,5 @@ obj-$(CONFIG_UIO_NETX)	+= uio_netx.o
>   obj-$(CONFIG_UIO_PRUSS)         += uio_pruss.o
>   obj-$(CONFIG_UIO_MF624)         += uio_mf624.o
>   obj-$(CONFIG_UIO_FSL_ELBC_GPCM)	+= uio_fsl_elbc_gpcm.o
> +obj-$(CONFIG_UIO_FSL_85XX_CACHE_SRAM)	+= uio_fsl_85xx_cache_sram.o
>   obj-$(CONFIG_UIO_HV_GENERIC)	+= uio_hv_generic.o
> diff --git a/drivers/uio/uio_fsl_85xx_cache_sram.c b/drivers/uio/uio_fsl_85xx_cache_sram.c
> new file mode 100644
> index 000000000000..cb339d1f9019
> --- /dev/null
> +++ b/drivers/uio/uio_fsl_85xx_cache_sram.c
> @@ -0,0 +1,148 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2020 Vivo Communication Technology Co. Ltd.
> + * Copyright (C) 2020 Wang Wenhu <wenhu.wang@vivo.com>
> + * All rights reserved.
> + */
> +
> +#include <linux/platform_device.h>
> +#include <linux/uio_driver.h>
> +#include <linux/stringify.h>
> +#include <linux/module.h>
> +#include <linux/kernel.h>
> +#include <asm/fsl_85xx_cache_sram.h>
> +
> +#define DRIVER_NAME	"uio_fsl_85xx_cache_sram"
> +#define UIO_INFO_VER	"devicetree,pseudo"
> +#define UIO_NAME	"uio_cache_sram"
> +
> +static void uio_info_free_internal(struct uio_info *info)
> +{
> +	int i;
> +
> +	for (i = 0; i < MAX_UIO_MAPS; i++) {
> +		struct uio_mem *uiomem = &info->mem[i];
> +
> +		if (uiomem->internal_addr) {
> +			mpc85xx_cache_sram_free(uiomem->internal_addr);
> +			memset(uiomem, 0, sizeof(*uiomem));
> +		}
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
> +	int ret;
> +
> +	/* alloc uio_info for one device */
> +	info = devm_kzalloc(&pdev->dev, sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	/* get optional uio name */
> +	if (of_property_read_string(parent, "uio_name", &dt_name))
> +		dt_name = UIO_NAME;
> +
> +	info->name = devm_kstrdup(&pdev->dev, dt_name, GFP_KERNEL);
> +	if (!info->name)
> +		return -ENOMEM;
> +
> +	uiomem = info->mem;
> +	for_each_child_of_node(parent, node) {
> +		void *virt;
> +		phys_addr_t phys;
> +
> +		ret = of_property_read_u32(node, "cache-mem-size", &mem_size);
> +		if (ret) {
> +			ret = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		if (mem_size == 0) {
> +			dev_err(&pdev->dev, "error cache-mem-size should not be 0\n");
> +			ret = -EINVAL;
> +			goto err_out;
> +		}
> +
> +		virt = mpc85xx_cache_sram_alloc(mem_size, &phys,
> +						roundup_pow_of_two(mem_size));
> +		if (!virt) {
> +			/* mpc85xx_cache_sram_alloc to define the real cause */
> +			ret = -ENOMEM;
> +			goto err_out;
> +		}
> +
> +		uiomem->memtype = UIO_MEM_PHYS;
> +		uiomem->addr = phys;
> +		uiomem->size = mem_size;
> +		uiomem->name = kstrdup(node->name, GFP_KERNEL);;
> +		uiomem->internal_addr = virt;
> +		uiomem++;
> +
> +		if (uiomem >= &info->mem[MAX_UIO_MAPS]) {
> +			dev_warn(&pdev->dev, "more than %d uio-maps for device.\n",
> +				 MAX_UIO_MAPS);
> +			break;
> +		}
> +	}
> +
> +	if (uiomem == info->mem) {
> +		dev_err(&pdev->dev, "error no valid uio-map configuration found\n");
> +		return -EINVAL;
> +	}
> +
> +	info->version = UIO_INFO_VER;
> +
> +	/* register uio device */
> +	if (uio_register_device(&pdev->dev, info)) {
> +		dev_err(&pdev->dev, "error uio,cache-sram registration failed\n");
> +		ret = -ENODEV;
> +		goto err_out;
> +	}
> +
> +	platform_set_drvdata(pdev, info);
> +
> +	return 0;
> +err_out:
> +	uio_info_free_internal(info);
> +	return ret;
> +}
> +
> +static int uio_fsl_85xx_cache_sram_remove(struct platform_device *pdev)
> +{
> +	struct uio_info *info = platform_get_drvdata(pdev);
> +
> +	uio_unregister_device(info);
> +
> +	uio_info_free_internal(info);
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id uio_mpc85xx_l2ctlr_of_match[] = {
> +	{	.compatible = "uio,mpc85xx-cache-sram",	},
> +	{},
> +};
> +
> +static struct platform_driver uio_fsl_85xx_cache_sram = {
> +	.probe = uio_fsl_85xx_cache_sram_probe,
> +	.remove = uio_fsl_85xx_cache_sram_remove,
> +	.driver = {
> +		.name = DRIVER_NAME,
> +		.owner = THIS_MODULE,
> +		.of_match_table	= uio_mpc85xx_l2ctlr_of_match,
> +	},
> +};
> +
> +module_platform_driver(uio_fsl_85xx_cache_sram);
> +
> +MODULE_AUTHOR("Wang Wenhu <wenhu.wang@vivo.com>");
> +MODULE_DESCRIPTION("Freescale MPC85xx Cache-Sram UIO Platform Driver");
> +MODULE_ALIAS("platform:" DRIVER_NAME);
> +MODULE_LICENSE("GPL v2");
> 
