Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11051C352BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA25E221EA
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 10:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pT1ZPbKI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbgDQKcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 06:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727907AbgDQKcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 06:32:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A30C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:32:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id k1so2476911wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 03:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=107gFRkToKH3NZvEzE8D2zQk2B7UQGVYWH3FpM3ffbQ=;
        b=pT1ZPbKIzeOuCLAGwau2qh6AMP05LfNf9H23Mf2O3gsd15pclob8765UcLXtYetbPJ
         tW62+lUJpJcjEBR3UgD04tLEWlMRZvnXZlmDT1BoBH9QoVIvD60GNORkBEolOXl/BjPh
         9XThsJSY/xjjkqyJJAXGLyI/HB4J15kFHjLYD+1K+EP+gqAiv4YoIUcEnqtidGOIiueV
         zTvOBPY9OnOfoBmHGwSx14yxh6y0kuhijDBkFTZKthvd/L9lj6EZ3vxC9Q/dHE+uvk/x
         CSmkXE5EGApOLTFfzUsar1xydm0g5G1kDzCVMa5P7hfVzmecFNz/om0CJECT4us9mTiI
         X8zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=107gFRkToKH3NZvEzE8D2zQk2B7UQGVYWH3FpM3ffbQ=;
        b=tsyyCDiyK494BsYHFW+l61Me9X5eoaf/pd2JJYcyeBxcEJ6rA+1bOC4LTgg251S3qS
         xF2kd9JaQ6M8L9Qq6RtVatsxS1aZrQDmqcfkG9QMAR/2pxJ10UU++ESpGnzao5BuLGa0
         K+1gH24axEuh9OO6eI1kKtn26dULceyWR9OtfBzXylog3gupuS88CVMuekwa9Z03iLFc
         h4MczvSLGqgoZ3rjPyuRGG4Q1nhUDrgWaJyKETAGqO/KKCWMhCvYGdfcuY1pKdGADHCD
         JB20+HTTQDA0jtHuSeBrJb+e9oEBYqQKFajiPWAlqLunQnbyPn+nklFV9xsO9pOdPdpZ
         8qOA==
X-Gm-Message-State: AGi0PuZiHb7pqjoBR6QG5jk2G68l64CM8iRT7526ngF7Q/3xZ+3m3w/H
        oJXTa/4jxuUeCPeeAbuR3wQTHx/ILhE=
X-Google-Smtp-Source: APiQypIfmSfeb691l/CD81jIS3LbFcVmiFUm6gA93sVAsJxA5uo5BTobaVoE1BIDagtfVzSXji3Jtw==
X-Received: by 2002:adf:dd84:: with SMTP id x4mr3479893wrl.210.1587119553482;
        Fri, 17 Apr 2020 03:32:33 -0700 (PDT)
Received: from dell ([95.149.164.124])
        by smtp.gmail.com with ESMTPSA id t20sm6692113wmi.2.2020.04.17.03.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 03:32:32 -0700 (PDT)
Date:   Fri, 17 Apr 2020 11:33:34 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Gene Chen <gene.chen.richtek@gmail.com>
Cc:     matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: Re: [PATCH resend v8] mfd: mt6360: add pmic mt6360 driver
Message-ID: <20200417103334.GD3737@dell>
References: <1586273804-7722-1-git-send-email-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1586273804-7722-1-git-send-email-gene.chen.richtek@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 07 Apr 2020, Gene Chen wrote:

> Add mfd driver for mt6360 pmic chip include
> Battery Charger/USB_PD/Flash LED/RGB LED/LDO/Buck
> 
> Signed-off-by: Gene Chen <gene_chen@richtek.com>
> ---
>  drivers/mfd/Kconfig        |  12 ++
>  drivers/mfd/Makefile       |   1 +
>  drivers/mfd/mt6360-core.c  | 425 +++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/mt6360.h | 240 +++++++++++++++++++++++++
>  4 files changed, 678 insertions(+)
>  create mode 100644 drivers/mfd/mt6360-core.c
>  create mode 100644 include/linux/mfd/mt6360.h
> 
> changelogs between v1 & v2
> - include missing header file
> 
> changelogs between v2 & v3
> - add changelogs
> 
> changelogs between v3 & v4
> - fix Kconfig description
> - replace mt6360_pmu_info with mt6360_pmu_data
> - replace probe with probe_new
> - remove unnecessary irq_chip variable
> - remove annotation
> - replace MT6360_MFD_CELL with OF_MFD_CELL
> 
> changelogs between v4 & v5
> - remove unnecessary parse dt function
> - use devm_i2c_new_dummy_device
> - add base-commit message
> 
> changelogs between v5 & v6
> - review return value
> - remove i2c id_table
> - use GPL license v2
> 
> changelogs between v6 & v7
> - add author description
> - replace MT6360_REGMAP_IRQ_REG by REGMAP_IRQ_REG_LINE
> - remove mt6360-private.h
> 
> changelogs between v7 & v8
> - fix kbuild auto reboot by include interrupt header
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 2b20329..0f8c341 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -857,6 +857,18 @@ config MFD_MAX8998
>  	  additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> +config MFD_MT6360
> +	tristate "Mediatek MT6360 SubPMIC"
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	depends on I2C
> +	help
> +	  Say Y here to enable MT6360 PMU/PMIC/LDO functional support.
> +	  PMU part includes Charger, Flashlight, RGB LED
> +	  PMIC part includes 2-channel BUCKs and 2-channel LDOs
> +	  LDO part includes 4-channel LDOs
> +
>  config MFD_MT6397
>  	tristate "MediaTek MT6397 PMIC Support"
>  	select MFD_CORE
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index b83f172..8c35816 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -238,6 +238,7 @@ obj-$(CONFIG_INTEL_SOC_PMIC)	+= intel-soc-pmic.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_BXTWC)	+= intel_soc_pmic_bxtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTWC)	+= intel_soc_pmic_chtwc.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_CHTDC_TI)	+= intel_soc_pmic_chtdc_ti.o
> +obj-$(CONFIG_MFD_MT6360)	+= mt6360-core.o
>  mt6397-objs	:= mt6397-core.o mt6397-irq.o
>  obj-$(CONFIG_MFD_MT6397)	+= mt6397.o
>  obj-$(CONFIG_INTEL_SOC_PMIC_MRFLD)	+= intel_soc_pmic_mrfld.o
> diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
> new file mode 100644
> index 0000000..d1168f8
> --- /dev/null
> +++ b/drivers/mfd/mt6360-core.c
> @@ -0,0 +1,425 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.

This is out of date.

> + * Author: Gene Chen <gene_chen@richtek.com>
> + */

[...]

> +MODULE_LICENSE("GPL v2");
> diff --git a/include/linux/mfd/mt6360.h b/include/linux/mfd/mt6360.h
> new file mode 100644
> index 0000000..c03e6d1
> --- /dev/null
> +++ b/include/linux/mfd/mt6360.h
> @@ -0,0 +1,240 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 MediaTek Inc.

Also out of date.

> + */

Once fixed, please resubmit with my:

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
