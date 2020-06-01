Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CFE0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51E7B206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 08:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wd1epwVr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgFAIu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 04:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbgFAIuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 04:50:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 970DCC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 01:50:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r9so9907273wmh.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 01:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zhq0r1aqKRJx8DKO6VJME8TRiyFzcm/sFaXzVbsq4o8=;
        b=wd1epwVrD0XUF3VXMvb1tS/X+E/1RiYakwh4uStJ149K6ffBVV3jp3+KqsWIuSwXa3
         o8K8nMTtxMw1AzNU8J0tBqGH67uGa8jDTMFVKWYRzBC1wleW5exMLz/YsTL7wsLbZa4R
         w3T4i7jsrF7AguQG2WqKIG4NKNQRc2uPJj4HLLOoNlxrQG+J6u465E21WbS3FOLcyGze
         mTrtOyic1J772KkBab94cgkfIJ0PslOlmMwd9zAXtb9RRrb2/uSdGjN8Bu0PgMkiBg9y
         7oX90KnKklgJ64UbuDx/SHUbBla1D/5+6KokTNJaJrb0APUoVS/dSkzwq0A/hJwXqVHf
         IABA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zhq0r1aqKRJx8DKO6VJME8TRiyFzcm/sFaXzVbsq4o8=;
        b=JePDjv4uMrfmhfOhHRVMFwiJ/n2/RXiD+kWf0O9jofqFiJlCPcgLlrJSP0m3b0j+59
         h9Gy6JPmSxmjCECl3gm+fDg7wdGwfcSkri2QOFQx3W7RoCndSvUKetrB0U2FGKjT2+Bm
         ETOiaa68GyblMLusOt4PNU8aIBWR/q8HpcczarEYdNTKZlKxKQYJGD92Fmvm+KaIRnOr
         yQbHSa/z70G+uRb0c+04USV0MPuomUV5SNu+tukceQ1gLDRQJCE9LmfjuZyowcwQ2r4h
         QV3hRelC9t3efPrm89gf2g0tmJkULteBn2rrrpUFQs/j2DcKp7hcjYaAcxo6R3c+Hy9g
         nGsA==
X-Gm-Message-State: AOAM532k/IyaA4JdVc6M8dX2zUtANM6MV04ftvD7Klm37ayOforwxJEN
        Am9fgKFYJ+VV18Weo7uC8re9bsvdUI4=
X-Google-Smtp-Source: ABdhPJz45bZSRMJ3FZVlPLxUzk3KqPmNmZmHqXUb9pMGKSIUkoS06Uu4pZRfhEEvFW5A/8gGiVu3gA==
X-Received: by 2002:a7b:c046:: with SMTP id u6mr19695187wmc.57.1591001454321;
        Mon, 01 Jun 2020 01:50:54 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id s5sm10681134wme.37.2020.06.01.01.50.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 01:50:53 -0700 (PDT)
Subject: Re: [PATCH v2 2/2] nvmem: add ONIE NVMEM cells support
To:     Vadym Kochan <vadym.kochan@plvision.eu>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Taras Chornyi <taras.chornyi@plvision.eu>
References: <20200529230451.21337-1-vadym.kochan@plvision.eu>
 <20200529230451.21337-3-vadym.kochan@plvision.eu>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <8a8653c5-b112-4042-cbdf-8498e38d14ee@linaro.org>
Date:   Mon, 1 Jun 2020 09:50:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200529230451.21337-3-vadym.kochan@plvision.eu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2020 00:04, Vadym Kochan wrote:
> ONIE is a small operating system, pre-installed on bare metal network
> switches, that provides an environment for automated provisioning.
> 
> This system requires that NVMEM (EEPROM) device holds various system
> information (mac address, platform name, etc) in a special TLV layout.
> 
> The driver registers ONIE TLV attributes as NVMEM cells which can be
> accessed by other platform driver. Also it allows to use
> of_get_mac_address() to retrieve mac address for the netdev.
> 
> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> ---
>   drivers/nvmem/Kconfig      |   9 +
>   drivers/nvmem/Makefile     |   3 +
>   drivers/nvmem/onie-cells.c | 332 +++++++++++++++++++++++++++++++++++++

Is there a reason why Device tree bindings are missing for this driver?



>   3 files changed, 344 insertions(+)
>   create mode 100644 drivers/nvmem/onie-cells.c
> 
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d7b7f6d688e7..dd9298487992 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -273,4 +273,13 @@ config SPRD_EFUSE
>   	  This driver can also be built as a module. If so, the module
>   	  will be called nvmem-sprd-efuse.
>   
> +config NVMEM_ONIE_CELLS
> +	tristate "ONIE TLV cells support"
> +	help
> +	  This is a driver to provide cells from ONIE TLV structure stored
> +	  on NVME device.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-onie-cells.
> +
>   endif
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index a7c377218341..2199784a489f 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -55,3 +55,6 @@ obj-$(CONFIG_NVMEM_ZYNQMP)	+= nvmem_zynqmp_nvmem.o
>   nvmem_zynqmp_nvmem-y		:= zynqmp_nvmem.o
>   obj-$(CONFIG_SPRD_EFUSE)	+= nvmem_sprd_efuse.o
>   nvmem_sprd_efuse-y		:= sprd-efuse.o
> +
> +obj-$(CONFIG_NVMEM_ONIE_CELLS)	+= nvmem-onie-cells.o
> +nvmem-onie-cells-y		:= onie-cells.o
> diff --git a/drivers/nvmem/onie-cells.c b/drivers/nvmem/onie-cells.c
> new file mode 100644
> index 000000000000..1e8b4b8d1c0d
> --- /dev/null
> +++ b/drivers/nvmem/onie-cells.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * ONIE NVMEM cells provider
> + *
> + * Author: Vadym Kochan <vadym.kochan@plvision.eu>
> + */
> +
> +#define ONIE_NVMEM_DRVNAME	"onie-nvmem-cells"
> +
> +#define pr_fmt(fmt) ONIE_NVMEM_DRVNAME ": " fmt
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/nvmem-provider.h>
> +
> +#define ONIE_NVMEM_TLV_MAX_LEN	2048
> +
> +#define ONIE_NVMEM_HDR_ID	"TlvInfo"
> +

...

> +
> +static int onie_nvmem_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *np = dev->of_node;
> +	struct nvmem_cell_info *cells;
> +	struct onie_nvmem_attr *attr;
> +	struct nvmem_device *nvmem;
> +	struct onie_nvmem *onie;
> +	unsigned int ncells = 0;
> +	int err;
> +
> +	nvmem = of_nvmem_device_get(np, NULL);
> +	if (IS_ERR(nvmem))
> +		return PTR_ERR(nvmem);
> +
TBH, this looks completely incorrect way to do this and misuse of nvmem 
consumer interface.

Ideally nvmem provider driver should populate "cells" in struct 
nvmem_config after decoding them and then register nvmem provider.

That should just work!


--srini


> +	onie = kmalloc(sizeof(*onie), GFP_KERNEL);
> +	if (!onie) {
> +		err = -ENOMEM;
> +		goto err_nvmem_alloc;
> +	}
> +
> +	INIT_LIST_HEAD(&onie->attrs);
> +	onie->attr_count = 0;
> +	onie->nvmem = nvmem;
> +
> +	err = onie_nvmem_decode(onie);
> +	if (err)
> +		goto err_nvmem_decode;
> +
> +	if (!onie->attr_count) {
> +		pr_err("%s: has no ONIE attributes\n", nvmem_dev_name(nvmem));
> +		err = -EINVAL;
> +		goto err_no_attrs;
> +	}
> +
> +	cells = kmalloc_array(onie->attr_count, sizeof(*cells), GFP_KERNEL);
> +	if (!cells) {
> +		err = -ENOMEM;
> +		goto err_cells_alloc;
> +	}
> +
> +	onie->cell_lookup = kmalloc_array(onie->attr_count,
> +					  sizeof(struct nvmem_cell_lookup),
> +					  GFP_KERNEL);
> +	if (!onie->cell_lookup) {
> +		err = -ENOMEM;
> +		goto err_lookup_alloc;
> +	}
> +
> +	list_for_each_entry(attr, &onie->attrs, head) {
> +		struct nvmem_cell_lookup *lookup;
> +		struct nvmem_cell_info *cell;
> +
> +		cell = &cells[ncells];
> +
> +		lookup = &onie->cell_lookup[ncells];
> +		lookup->con_id = NULL;
> +
> +		cell->offset = attr->offset;
> +		cell->name = attr->name;
> +		cell->bytes = attr->len;
> +		cell->bit_offset = 0;
> +		cell->nbits = 0;
> +
> +		lookup->nvmem_name = nvmem_dev_name(onie->nvmem);
> +		lookup->dev_id = dev_name(dev);
> +		lookup->cell_name = cell->name;
> +		lookup->con_id = cell->name;
> +
> +		ncells++;
> +	}
> +
> +	onie->cell_tbl.nvmem_name = nvmem_dev_name(onie->nvmem);
> +	onie->cell_tbl.ncells = ncells;
> +	onie->cell_tbl.cells = cells;
> +
> +	nvmem_add_cell_table(&onie->cell_tbl);
> +	nvmem_add_cell_lookups(onie->cell_lookup, ncells);
> +
> +	dev_set_drvdata(dev, onie);
> +
> +	onie_nvmem_attrs_free(onie);
> +
> +	nvmem_device_put(nvmem);
> +
> +	return 0;
> +
> +err_lookup_alloc:
> +	kfree(onie->cell_tbl.cells);
> +err_cells_alloc:
> +	onie_nvmem_attrs_free(onie);
> +err_no_attrs:
> +err_nvmem_decode:
> +	kfree(onie);
> +err_nvmem_alloc:
> +	nvmem_device_put(nvmem);
> +
> +	return err;
> +}
> +
