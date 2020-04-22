Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF9BC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E534C206B9
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 09:16:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="Hy9tq9Cu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgDVJQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 05:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725924AbgDVJQv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 05:16:51 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22102C03C1A6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 02:16:51 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id e20so1413797otk.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 02:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ikIBQXJMa3hdkgv2RFQITgePbsxCCL7yE67akx9AGCE=;
        b=Hy9tq9CudGqndGz8siILzjJdqBvk9DXn29ZdM6oQ3EKer6rWMcs7f+2X/9T8D17vDN
         CU2VT6iXSYyW7snYytxh0dRBNAjzep6WcsXAJR05jX/Kdt5igbT7KU6N+QwQJn3ATxwD
         89WZRJBtjvDEgm2uo4zpdMeXx8xBe2jusJ/T1hDS1fIsUkuIPNdnPs0TmDYa/q+PERP/
         9WrLN8ofcROL5jwc6NQPyHckyLdxhgMeRGXETJ6PGfVBPlQXFNLYFI1idz3EoEGjlS2+
         Mu2YckYHlFBFef/haWXcWoDXH5cdlONxujeGHrUuDNs8kCjGL/TcHXu3D0UjSdba5V1Z
         GMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ikIBQXJMa3hdkgv2RFQITgePbsxCCL7yE67akx9AGCE=;
        b=T/mw6VjFY1ECtoxLV1SNbYuP+y5vCcnnwpU3bV7Q7J7hlFIAKR/0Q5aaoynuLHEb2U
         4NQT4s3CGChCExr1e1zmHMLuDBuBAfJ8EPvXjftKwyV01NLzvj6G7TvJp/R5ZsoezsEc
         IJFoBnjwiuTtzl7/VAQvmPQCtbnXwa+leFdRUggSyYKRx4jicDfB2JO4lwbTKKR6G0W5
         53fcOt0kmbYA+wx5OzPpUP8FTHhxHCr4U9JmHe9it9CD466uU3ySKg/rkMRLtFkUBZnq
         Gx4ujBmilGA3C+UpvUx80STf1OtVtxXFbcI9Im2bgSzRYlzQ8ZR/5G4os4DWRpHobyIy
         B4hQ==
X-Gm-Message-State: AGi0Pub5/CA9Mdi0PF0NOlAnqXPQJQ/vKJL4M2xeuLtWOXKuI71ZxCaj
        mvK2bAHI4aStwLMLpC1zC7XmUUOVrPxwMtqvQ8O2TA==
X-Google-Smtp-Source: APiQypIZshzG7cDC65VyyX1oj3F/Kg/kAsqW8ZTp+MPftCDXIf84zvbwJ/Kdc6Iin7QYRCdGAWBW+kTBIp59YGSZ5dY=
X-Received: by 2002:a05:6830:18eb:: with SMTP id d11mr16932004otf.243.1587547010469;
 Wed, 22 Apr 2020 02:16:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200401163542.83278-1-robert.marko@sartura.hr>
In-Reply-To: <20200401163542.83278-1-robert.marko@sartura.hr>
From:   Robert Marko <robert.marko@sartura.hr>
Date:   Wed, 22 Apr 2020 11:16:39 +0200
Message-ID: <CA+HBbNEV599SRb8k0usZ+9Z18eaiMBEO-=qGbURD2QEHSns+Fg@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] phy: add driver for Qualcomm IPQ40xx USB PHY
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-kernel@vger.kernel.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        robh+dt@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>,
        Luka Perkov <luka.perkov@sartura.hr>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kishon, can you pick this up for 5.8?

Thanks

On Wed, Apr 1, 2020 at 6:36 PM Robert Marko <robert.marko@sartura.hr> wrote:
>
> From: John Crispin <john@phrozen.org>
>
> Add a driver to setup the USB phy on Qualcom Dakota SoCs.
> The driver sets up HS and SS phys.
>
> Signed-off-by: John Crispin <john@phrozen.org>
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> Cc: Luka Perkov <luka.perkov@sartura.hr>
> ---
> Changes from v2 to v3:
> * Remove magic writes as they are not needed
> * Correct commit message
>
>  drivers/phy/qualcomm/Kconfig                |   7 +
>  drivers/phy/qualcomm/Makefile               |   1 +
>  drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c | 152 ++++++++++++++++++++
>  3 files changed, 160 insertions(+)
>  create mode 100644 drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
>
> diff --git a/drivers/phy/qualcomm/Kconfig b/drivers/phy/qualcomm/Kconfig
> index e46824da29f6..964bd5d784d2 100644
> --- a/drivers/phy/qualcomm/Kconfig
> +++ b/drivers/phy/qualcomm/Kconfig
> @@ -18,6 +18,13 @@ config PHY_QCOM_APQ8064_SATA
>         depends on OF
>         select GENERIC_PHY
>
> +config PHY_QCOM_IPQ4019_USB
> +       tristate "Qualcomm IPQ4019 USB PHY module"
> +       depends on OF && ARCH_QCOM
> +       select GENERIC_PHY
> +       help
> +         Support for the USB PHY on QCOM IPQ4019/Dakota chipsets.
> +
>  config PHY_QCOM_IPQ806X_SATA
>         tristate "Qualcomm IPQ806x SATA SerDes/PHY driver"
>         depends on ARCH_QCOM
> diff --git a/drivers/phy/qualcomm/Makefile b/drivers/phy/qualcomm/Makefile
> index 283251d6a5d9..8afe6c4f5178 100644
> --- a/drivers/phy/qualcomm/Makefile
> +++ b/drivers/phy/qualcomm/Makefile
> @@ -1,6 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0
>  obj-$(CONFIG_PHY_ATH79_USB)            += phy-ath79-usb.o
>  obj-$(CONFIG_PHY_QCOM_APQ8064_SATA)    += phy-qcom-apq8064-sata.o
> +obj-$(CONFIG_PHY_QCOM_IPQ4019_USB)     += phy-qcom-ipq4019-usb.o
>  obj-$(CONFIG_PHY_QCOM_IPQ806X_SATA)    += phy-qcom-ipq806x-sata.o
>  obj-$(CONFIG_PHY_QCOM_PCIE2)           += phy-qcom-pcie2.o
>  obj-$(CONFIG_PHY_QCOM_QMP)             += phy-qcom-qmp.o
> diff --git a/drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c b/drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
> new file mode 100644
> index 000000000000..7efebae6b6fd
> --- /dev/null
> +++ b/drivers/phy/qualcomm/phy-qcom-ipq4019-usb.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2018 John Crispin <john@phrozen.org>
> + *
> + * Based on code from
> + * Allwinner Technology Co., Ltd. <www.allwinnertech.com>
> + *
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/io.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_platform.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>
> +
> +struct ipq4019_usb_phy {
> +       struct device           *dev;
> +       struct phy              *phy;
> +       void __iomem            *base;
> +       struct reset_control    *por_rst;
> +       struct reset_control    *srif_rst;
> +};
> +
> +static int ipq4019_ss_phy_power_off(struct phy *_phy)
> +{
> +       struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
> +
> +       reset_control_assert(phy->por_rst);
> +       msleep(10);
> +
> +       return 0;
> +}
> +
> +static int ipq4019_ss_phy_power_on(struct phy *_phy)
> +{
> +       struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
> +
> +       ipq4019_ss_phy_power_off(_phy);
> +
> +       reset_control_deassert(phy->por_rst);
> +
> +       return 0;
> +}
> +
> +static struct phy_ops ipq4019_usb_ss_phy_ops = {
> +       .power_on       = ipq4019_ss_phy_power_on,
> +       .power_off      = ipq4019_ss_phy_power_off,
> +};
> +
> +static int ipq4019_hs_phy_power_off(struct phy *_phy)
> +{
> +       struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
> +
> +       reset_control_assert(phy->por_rst);
> +       msleep(10);
> +
> +       reset_control_assert(phy->srif_rst);
> +       msleep(10);
> +
> +       return 0;
> +}
> +
> +static int ipq4019_hs_phy_power_on(struct phy *_phy)
> +{
> +       struct ipq4019_usb_phy *phy = phy_get_drvdata(_phy);
> +
> +       ipq4019_hs_phy_power_off(_phy);
> +
> +       reset_control_deassert(phy->srif_rst);
> +       msleep(10);
> +
> +       reset_control_deassert(phy->por_rst);
> +
> +       return 0;
> +}
> +
> +static struct phy_ops ipq4019_usb_hs_phy_ops = {
> +       .power_on       = ipq4019_hs_phy_power_on,
> +       .power_off      = ipq4019_hs_phy_power_off,
> +};
> +
> +static const struct of_device_id ipq4019_usb_phy_of_match[] = {
> +       { .compatible = "qcom,usb-hs-ipq4019-phy", .data = &ipq4019_usb_hs_phy_ops},
> +       { .compatible = "qcom,usb-ss-ipq4019-phy", .data = &ipq4019_usb_ss_phy_ops},
> +       { },
> +};
> +MODULE_DEVICE_TABLE(of, ipq4019_usb_phy_of_match);
> +
> +static int ipq4019_usb_phy_probe(struct platform_device *pdev)
> +{
> +       struct device *dev = &pdev->dev;
> +       struct resource *res;
> +       struct phy_provider *phy_provider;
> +       struct ipq4019_usb_phy *phy;
> +       const struct of_device_id *match;
> +
> +       match = of_match_device(ipq4019_usb_phy_of_match, &pdev->dev);
> +       if (!match)
> +               return -ENODEV;
> +
> +       phy = devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +       if (!phy)
> +               return -ENOMEM;
> +
> +       phy->dev = &pdev->dev;
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       phy->base = devm_ioremap_resource(&pdev->dev, res);
> +       if (IS_ERR(phy->base)) {
> +               dev_err(dev, "failed to remap register memory\n");
> +               return PTR_ERR(phy->base);
> +       }
> +
> +       phy->por_rst = devm_reset_control_get(phy->dev, "por_rst");
> +       if (IS_ERR(phy->por_rst)) {
> +               if (PTR_ERR(phy->por_rst) != -EPROBE_DEFER)
> +                       dev_err(dev, "POR reset is missing\n");
> +               return PTR_ERR(phy->por_rst);
> +       }
> +
> +       phy->srif_rst = devm_reset_control_get_optional(phy->dev, "srif_rst");
> +       if (IS_ERR(phy->srif_rst))
> +               return PTR_ERR(phy->srif_rst);
> +
> +       phy->phy = devm_phy_create(dev, NULL, match->data);
> +       if (IS_ERR(phy->phy)) {
> +               dev_err(dev, "failed to create PHY\n");
> +               return PTR_ERR(phy->phy);
> +       }
> +       phy_set_drvdata(phy->phy, phy);
> +
> +       phy_provider = devm_of_phy_provider_register(dev, of_phy_simple_xlate);
> +
> +       return PTR_ERR_OR_ZERO(phy_provider);
> +}
> +
> +static struct platform_driver ipq4019_usb_phy_driver = {
> +       .probe  = ipq4019_usb_phy_probe,
> +       .driver = {
> +               .of_match_table = ipq4019_usb_phy_of_match,
> +               .name  = "ipq4019-usb-phy",
> +       }
> +};
> +module_platform_driver(ipq4019_usb_phy_driver);
> +
> +MODULE_DESCRIPTION("QCOM/IPQ4019 USB phy driver");
> +MODULE_AUTHOR("John Crispin <john@phrozen.org>");
> +MODULE_LICENSE("GPL v2");
> --
> 2.26.0
>
