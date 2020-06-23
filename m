Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E33DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1211320724
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KHBfyhBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbgFWJce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731921AbgFWJcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:32:33 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C74AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:32:32 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so19780514wrc.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 02:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eejVzaxAAyht+9QkvwHXTBq5Ku51Lr5rfWRqulZX9B4=;
        b=KHBfyhBHITTcnmU8+oRI2dAStF+rvJs2Qwk9Rw+gFbpNJqiEaYUsEGjOb2T4CzJgE0
         XsKnLoZmYw3tJGs83mK1XSfG1COkBJnnyNElGqoHSCIMBv5/3tUUSfFk3toRnvIt1I68
         yi1XIHiykMTnd3u9eGNoZNklW+nTD6UsItTYcUYpEgLN1B6172bR1KWLVUGvxISOQJpp
         yskSUncxKWFVfKzz0xW+KMVKXLriCTaBggr62HErhZXzYllOKWsRATESTBx2wajWHR72
         AtWibwKlnC5JLiT9pzTFy4IEV9JCbVmtGfCbxP2jiJC9TmellLs0uIZ8PGYA+AM/upYZ
         WgAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eejVzaxAAyht+9QkvwHXTBq5Ku51Lr5rfWRqulZX9B4=;
        b=fzuvEG14UUEiKgEvblCh1RYb+FBpwcFlhshX/J1s/wwngMvA/nGqETZym8/AIICz0H
         j6IrX5ZFmFlh828PqtZddm5LmGpsIAUQZ3Ymx939+LSPh0YrW7uaSEWqjdg0wOI/18Ov
         eG+dPM2/TPCYilupcktA7UMyIL8vuDHT7kwCpqq3JUGNnADN2yx6Z0ztHRXFgrwRYysh
         jGP6U9h6ar7emzF8F6bZEPAnTxhuNl/Ct+EFc4feJLZuyfOyxKsTUDC7EVWmSiJG+bBc
         9GHL46sekIlx/Jt3VfIIiarrZ7yFpKG9VcoA3dSVmfZAKGBM8KnAEZvjEkj7NFdPxJ6l
         Ag5A==
X-Gm-Message-State: AOAM530qZBrINP6x/khuIAUsqUyCFDgjP3KwdRiSO4M4kFYL4nDPCACF
        ebhcPDIb6nRfrJVTJWxnz3vPqw==
X-Google-Smtp-Source: ABdhPJxAny/BHJIXm5/7o+fRpzayetIpJLo9v5nsF0ymmWZ5Az4/r/ciLsmkqWlf29Pk5WxLFeE4Rw==
X-Received: by 2002:a5d:56d0:: with SMTP id m16mr23333687wrw.194.1592904751256;
        Tue, 23 Jun 2020 02:32:31 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id c201sm3094727wmd.4.2020.06.23.02.32.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2020 02:32:30 -0700 (PDT)
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
Message-ID: <4c137c33-bd46-2da0-01d0-5f52747be48a@linaro.org>
Date:   Tue, 23 Jun 2020 10:32:29 +0100
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
> ---

This patch itself looks okay to me, I will apply this once DT patches 
are Reviewed/applied by DT maintainers!

--srini
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
