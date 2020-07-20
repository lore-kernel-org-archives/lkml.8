Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC2BC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2163020684
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 09:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oIjPLY/k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgGTJbV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 05:31:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgGTJbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 05:31:20 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B63C061794
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:31:20 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id w3so24432204wmi.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 02:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1zb3+2EAQpbVRtFxcmapZb5qs9fbF12day9dwhvNN/c=;
        b=oIjPLY/kS3LJjo7l28j1ki5x5PJYrDcEV7IkNG/WQBdBuHUGYx9UoaFkwRUymrTBWk
         KIjibt3+bWs4StIaH0lADchgNl7/uxldHalN7L4huEMT5mer/UcQD3V/oT0hTlmYSwOB
         Us+yNQ+hAcMJVhcpm9ErKpE/Ld/NKigHakUyifvom+jElrdcECxOh8mDBV6YtPkIzJ5v
         KZiYVr+B+1W/A/twGmfIziXv+Nb94jbFCFFPboG8oi/Lbw7YUx8vCHytO5GQz7UA+7X6
         EqDE8sc25Rfs9oIhYHHkp3I9cmK+OTWxaX3gy4gsx0gpncSsIK3vbEFjyByTrSIWRGBm
         SyTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1zb3+2EAQpbVRtFxcmapZb5qs9fbF12day9dwhvNN/c=;
        b=Dq6RC6dZQVlLg9oecqt+DTS3Lz9Lv39PwSsfDXSVvyRCLi5E0LDipMVCdQlf3IebUT
         31UN845lSrCDjFoa8B+3qc8gwegw48iaVriGnZkkb6ATsgBK8aMhGMeLlT5YTtBsdSxD
         PMQzFygase7cAnTUrczdOM5VrQ9nwZj32/NK6xdehyEwcsSUBakdkB1yaY64i2DSzg9K
         h1x41CxIhZ4YD/bUDcjZSQFjWkXyGP+iJAV0Qge9yaSAU5bc6pVMqZWb0wW4k+YzHjAd
         GxOxQSkG6UKTFawmJuYrzz8I0+w0ebC4sL/W62kbvXT30zuLS79xBh/B/1riLde1MGx7
         nYXQ==
X-Gm-Message-State: AOAM531YemJ/5RkRWkvpWq6m6KA0rSva8Y+v3tFHzfuZjW1BdKJZJOUw
        QPWlsvdpqe1ESy2w3TNSGIu00w==
X-Google-Smtp-Source: ABdhPJxtkLJGEdngOZe7F4EOVeaA/5oefmDx2UgDb68zYzLIckpxOftyqJ4P57Lfu/AT+cTaHqCKBw==
X-Received: by 2002:a05:600c:2317:: with SMTP id 23mr21499232wmo.72.1595237478823;
        Mon, 20 Jul 2020 02:31:18 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id n125sm33058276wme.30.2020.07.20.02.31.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 02:31:18 -0700 (PDT)
Subject: Re: [PATCH v2 18/29] nvmem: Add Realtek DHC eFuse driver
To:     =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?UTF-8?B?U3RhbmxleSBDaGFuZyBb5piM6IKy5b63XQ==?= 
        <stanley_chang@realtek.com>, Edgar Lee <cylee12@realtek.com>
References: <20200623025106.31273-1-afaerber@suse.de>
 <20200623025106.31273-19-afaerber@suse.de>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <c49384c1-2a48-7ae8-67f0-08543c41fc69@linaro.org>
Date:   Mon, 20 Jul 2020 10:31:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200623025106.31273-19-afaerber@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/06/2020 03:50, Andreas Färber wrote:
> Implement enough of a read-only nvmem driver to easily read efuse cells.
> 
> Cc: Cheng-Yu Lee <cylee12@realtek.com>
> Signed-off-by: Andreas Färber <afaerber@suse.de>

If you are expecting this to be applied, then please resend this patch 
splitting the MAINTAINER File changes separately!

--srini
> ---
>   v2: New
>   
>   MAINTAINERS                   |  1 +
>   drivers/nvmem/Kconfig         |  9 ++++
>   drivers/nvmem/Makefile        |  2 +
>   drivers/nvmem/rtk-dhc-efuse.c | 86 +++++++++++++++++++++++++++++++++++
>   4 files changed, 98 insertions(+)
>   create mode 100644 drivers/nvmem/rtk-dhc-efuse.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d0d6ab20451..02117fbf0e57 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2312,6 +2312,7 @@ F:	Documentation/devicetree/bindings/soc/realtek/
>   F:	arch/arm/boot/dts/rtd*
>   F:	arch/arm/mach-realtek/
>   F:	arch/arm64/boot/dts/realtek/
> +F:	drivers/nvmem/rtk-dhc-efuse.c
>   F:	drivers/soc/realtek/
>   
>   ARM/RENESAS ARM64 ARCHITECTURE
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index d7b7f6d688e7..75cf43b16cf9 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -129,6 +129,15 @@ config NVMEM_SPMI_SDAM
>   	  Qualcomm Technologies, Inc. PMICs. It provides the clients
>   	  an interface to read/write to the SDAM module's shared memory.
>   
> +config REALTEK_DHC_EFUSE
> +	tristate "Realtek DHC eFuse Support"
> +	depends on ARCH_REALTEK || COMPILE_TEST
> +	depends on HAS_IOMEM
> +	help
> +	  Say y here to enable read-only access to the Realtek Digital Home
> +	  This driver can also be built as a module. If so, the module
> +	  will be called nvmem-rtk-dhc-efuse.
> +
>   config ROCKCHIP_EFUSE
>   	tristate "Rockchip eFuse Support"
>   	depends on ARCH_ROCKCHIP || COMPILE_TEST
> diff --git a/drivers/nvmem/Makefile b/drivers/nvmem/Makefile
> index a7c377218341..67cefdfa44e6 100644
> --- a/drivers/nvmem/Makefile
> +++ b/drivers/nvmem/Makefile
> @@ -33,6 +33,8 @@ obj-$(CONFIG_ROCKCHIP_EFUSE)	+= nvmem_rockchip_efuse.o
>   nvmem_rockchip_efuse-y		:= rockchip-efuse.o
>   obj-$(CONFIG_ROCKCHIP_OTP)	+= nvmem-rockchip-otp.o
>   nvmem-rockchip-otp-y		:= rockchip-otp.o
> +obj-$(CONFIG_REALTEK_DHC_EFUSE)	+= nvmem-rtk-dhc-efuse.o
> +nvmem-rtk-dhc-efuse-y		:= rtk-dhc-efuse.o
>   obj-$(CONFIG_NVMEM_SUNXI_SID)	+= nvmem_sunxi_sid.o
>   nvmem_stm32_romem-y 		:= stm32-romem.o
>   obj-$(CONFIG_NVMEM_STM32_ROMEM) += nvmem_stm32_romem.o
> diff --git a/drivers/nvmem/rtk-dhc-efuse.c b/drivers/nvmem/rtk-dhc-efuse.c
> new file mode 100644
> index 000000000000..4672db2c2619
> --- /dev/null
> +++ b/drivers/nvmem/rtk-dhc-efuse.c
> @@ -0,0 +1,86 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Realtek Digital Home Center eFuse
> + *
> + * Copyright (c) 2020 Andreas Färber
> + */
> +
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +
> +struct dhc_efuse {
> +	struct device *dev;
> +	void __iomem *base;
> +	struct nvmem_device *nvmem;
> +};
> +
> +static int dhc_efuse_reg_read(void *priv, unsigned int offset, void *val,
> +	size_t bytes)
> +{
> +	struct dhc_efuse *efuse = priv;
> +	u8 *buf = val;
> +
> +	while (bytes--)
> +		*buf++ = readb_relaxed(efuse->base + offset++);
> +
> +	return 0;
> +}
> +
> +static int dhc_efuse_probe(struct platform_device *pdev)
> +{
> +	struct dhc_efuse *efuse;
> +	struct nvmem_config config = {};
> +	struct resource *res;
> +
> +	efuse = devm_kzalloc(&pdev->dev, sizeof(*efuse), GFP_KERNEL);
> +	if (!efuse)
> +		return -ENOMEM;
> +
> +	efuse->base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(efuse->base))
> +		return PTR_ERR(efuse->base);
> +
> +	efuse->dev = &pdev->dev;
> +
> +	config.dev = &pdev->dev;
> +	config.name = "dhc-efuse";
> +	config.owner = THIS_MODULE;
> +	config.type = NVMEM_TYPE_OTP;
> +	config.read_only = true,
> +	config.word_size = 4;
> +	config.stride = 1;
> +	config.size = resource_size(res);
> +	config.reg_read = dhc_efuse_reg_read;
> +	config.priv = efuse;
> +
> +	efuse->nvmem = devm_nvmem_register(&pdev->dev, &config);
> +	if (IS_ERR(efuse->nvmem)) {
> +		dev_err(&pdev->dev, "failed to register nvmem (%ld)\n",
> +			PTR_ERR(efuse->nvmem));
> +		return PTR_ERR(efuse->nvmem);
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct of_device_id dhc_efuse_dt_ids[] = {
> +	 { .compatible = "realtek,rtd1195-efuse" },
> +	 { }
> +};
> +
> +static struct platform_driver dhc_efuse_driver = {
> +	.probe = dhc_efuse_probe,
> +	.driver = {
> +		.name = "rtk-dhc-efuse",
> +		.of_match_table	= dhc_efuse_dt_ids,
> +	},
> +};
> +module_platform_driver(dhc_efuse_driver);
> +
> +MODULE_DESCRIPTION("Realtek DHC eFuse driver");
> +MODULE_LICENSE("GPL");
> 
