Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76124C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46FAC207F9
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 17:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eIE7/olj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgGKReR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 13:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728507AbgGKReQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 13:34:16 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BC6C08C5DD;
        Sat, 11 Jul 2020 10:34:16 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id q15so4623886vso.9;
        Sat, 11 Jul 2020 10:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v+tsx9OTSRtTzUZDxhFw8FgKD2WUd6vGP5luqo/9VOo=;
        b=eIE7/oljb9GYXRzw17yoLA0lIKiyMKxU/afZz4gU4UhsIZrqd2VAs43tysRXd06NCh
         4z9M2N5QQP/laQUD1rLcWGl7yXUyzfHqv+45H5/C8Jbm/fciRoBxhyysNQ68u/f0Gf8Z
         rQsThojX7kxLOkMiBfypAuNAO240kpeFlCvjaPTmD2d2ZqL25b5rJe40Aq5WSJ1inhSt
         QbC7r+zIUhxujvBhJrRlBw3kjW5VVUE+4paLaTkyNdulegU0oQZWy51TYSQ/XJHI3UE4
         VT8470QQKagvS+Cw1UZvgJWiKlGRcqPQj2mkBGCrrDZESpi3ffZk/MAZO7tKjv5pUPyx
         3mvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v+tsx9OTSRtTzUZDxhFw8FgKD2WUd6vGP5luqo/9VOo=;
        b=FsMgJnd6ALlaQsq5RSNcIr3QrXPOoSNH64FgacEOlOUo3Cwa8fUDYVBRUzpzWQ3ID1
         2qxSaUS0KmVkIeIEMBnkJDSSAIxIPWOHfORw4ijBpV7WllWo7JbSLSY8pjj20sFKcTRQ
         ZrnT1gAhgBabnOQ/7NE4qtsymydr+b3bsNg43ucl+eqvLgl5ekbFB7dBtDIWUbN+SNEf
         ZIvzvgx4nIz82J4zVPVE9gk7c2IYYWdLbx5WuR9XOLped/zDszkH/v2HHL3zY5ibS6wq
         hQOkGOm67xgnB7NWHLPBDI8nao8pghHzv+U6VgqOB8pFJtdaGDfK6t5YkpImNPBo9LB6
         xIlg==
X-Gm-Message-State: AOAM533G9erXUqEDaoGiGQ1u4istkWxMTDlG41jCyl/yVAgp2G1NQ4QX
        C91d8qbmY+rc+V/2wjMKzCkYe9RkOTLfkB2RJdo=
X-Google-Smtp-Source: ABdhPJxUsbIO/AesL8d3NLFr2ULYgQ7u5AXBI2Aj7CM3DHPlni7KrXv5NCBbiOqDnsR8hFjzGp6L6oJ1rQj3dEsnLm0=
X-Received: by 2002:a67:22c7:: with SMTP id i190mr54970289vsi.179.1594488854633;
 Sat, 11 Jul 2020 10:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200703173144epcas5p1daa9f5c594e7f299638cc75b7425b7c8@epcas5p1.samsung.com>
 <20200703171135.77389-1-alim.akhtar@samsung.com> <20200703171135.77389-2-alim.akhtar@samsung.com>
In-Reply-To: <20200703171135.77389-2-alim.akhtar@samsung.com>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Sat, 11 Jul 2020 23:03:38 +0530
Message-ID: <CAGOxZ536L3juqoNP5RzQOscpvJ8jE7awxVgcL+=U0kQYYjcxEg@mail.gmail.com>
Subject: Re: [PATCH v12 2/2] phy: samsung-ufs: add UFS PHY driver for samsung SoC
To:     Alim Akhtar <alim.akhtar@samsung.com>
Cc:     vkoul@kernel.org, "robh+dt" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org, kishon <kishon@ti.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod
Gentle Reminder !!

On Fri, Jul 3, 2020 at 11:02 PM Alim Akhtar <alim.akhtar@samsung.com> wrote=
:
>
> This patch introduces Samsung UFS PHY driver. This driver
> supports to deal with phy calibration and power control
> according to UFS host driver's behavior.
>
> [Robot: -Wmissing-prototypes and -Wsometimes-uninitialized]
> Reported-by: kernel test robot <lkp@intel.com>
> Reviewed-by: Kiwoong Kim <kwmad.kim@samsung.com>
> Signed-off-by: Seungwon Jeon <essuuj@gmail.com>
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> Cc: Kishon Vijay Abraham I <kishon@ti.com>
> Cc: Vinod Koul <vkoul@kernel.org>
> Tested-by: Pawe=C5=82 Chmiel <pawel.mikolaj.chmiel@gmail.com>
> ---
>  - Changes V11 -> V12
>  * Fixed kernel test robot warnings
>
>  - Changes V10 -> V11
>  * Addressed review comments from Vinod
>
>  drivers/phy/samsung/Kconfig           |   9 +
>  drivers/phy/samsung/Makefile          |   1 +
>  drivers/phy/samsung/phy-exynos7-ufs.h |  86 ++++++
>  drivers/phy/samsung/phy-samsung-ufs.c | 359 ++++++++++++++++++++++++++
>  drivers/phy/samsung/phy-samsung-ufs.h | 139 ++++++++++
>  5 files changed, 594 insertions(+)
>  create mode 100644 drivers/phy/samsung/phy-exynos7-ufs.h
>  create mode 100644 drivers/phy/samsung/phy-samsung-ufs.c
>  create mode 100644 drivers/phy/samsung/phy-samsung-ufs.h
>
> diff --git a/drivers/phy/samsung/Kconfig b/drivers/phy/samsung/Kconfig
> index 19f2e3119343..e20d2fcc9fe7 100644
> --- a/drivers/phy/samsung/Kconfig
> +++ b/drivers/phy/samsung/Kconfig
> @@ -29,6 +29,15 @@ config PHY_EXYNOS_PCIE
>           Enable PCIe PHY support for Exynos SoC series.
>           This driver provides PHY interface for Exynos PCIe controller.
>
> +config PHY_SAMSUNG_UFS
> +       tristate "SAMSUNG SoC series UFS PHY driver"
> +       depends on OF && (ARCH_EXYNOS || COMPILE_TEST)
> +       select GENERIC_PHY
> +       help
> +         Enable this to support the Samsung UFS PHY driver for
> +         Samsung SoCs. This driver provides the interface for UFS
> +         host controller to do PHY related programming.
> +
>  config PHY_SAMSUNG_USB2
>         tristate "Samsung USB 2.0 PHY driver"
>         depends on HAS_IOMEM
> diff --git a/drivers/phy/samsung/Makefile b/drivers/phy/samsung/Makefile
> index db9b1aa0de6e..3959100fe8a2 100644
> --- a/drivers/phy/samsung/Makefile
> +++ b/drivers/phy/samsung/Makefile
> @@ -2,6 +2,7 @@
>  obj-$(CONFIG_PHY_EXYNOS_DP_VIDEO)      +=3D phy-exynos-dp-video.o
>  obj-$(CONFIG_PHY_EXYNOS_MIPI_VIDEO)    +=3D phy-exynos-mipi-video.o
>  obj-$(CONFIG_PHY_EXYNOS_PCIE)          +=3D phy-exynos-pcie.o
> +obj-$(CONFIG_PHY_SAMSUNG_UFS)          +=3D phy-samsung-ufs.o
>  obj-$(CONFIG_PHY_SAMSUNG_USB2)         +=3D phy-exynos-usb2.o
>  phy-exynos-usb2-y                      +=3D phy-samsung-usb2.o
>  phy-exynos-usb2-$(CONFIG_PHY_EXYNOS4210_USB2)  +=3D phy-exynos4210-usb2.=
o
> diff --git a/drivers/phy/samsung/phy-exynos7-ufs.h b/drivers/phy/samsung/=
phy-exynos7-ufs.h
> new file mode 100644
> index 000000000000..c4aab792d30e
> --- /dev/null
> +++ b/drivers/phy/samsung/phy-exynos7-ufs.h
> @@ -0,0 +1,86 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UFS PHY driver data for Samsung EXYNOS7 SoC
> + *
> + * Copyright (C) 2020 Samsung Electronics Co., Ltd.
> + */
> +#ifndef _PHY_EXYNOS7_UFS_H_
> +#define _PHY_EXYNOS7_UFS_H_
> +
> +#include "phy-samsung-ufs.h"
> +
> +#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL        0x720
> +#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK   0x1
> +#define EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN     BIT(0)
> +
> +/* Calibration for phy initialization */
> +static const struct samsung_ufs_phy_cfg exynos7_pre_init_cfg[] =3D {
> +       PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_ANY),
> +       PHY_COMN_REG_CFG(0x010, 0x82, PWR_MODE_ANY),
> +       PHY_COMN_REG_CFG(0x011, 0x1e, PWR_MODE_ANY),
> +       PHY_COMN_REG_CFG(0x017, 0x84, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x035, 0x58, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x036, 0x32, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x037, 0x40, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x03b, 0x83, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x042, 0x88, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x043, 0xa6, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x048, 0x74, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x04c, 0x5b, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x04d, 0x83, PWR_MODE_ANY),
> +       PHY_TRSV_REG_CFG(0x05c, 0x14, PWR_MODE_ANY),
> +       END_UFS_PHY_CFG
> +};
> +
> +static const struct samsung_ufs_phy_cfg exynos7_post_init_cfg[] =3D {
> +       END_UFS_PHY_CFG
> +};
> +
> +/* Calibration for HS mode series A/B */
> +static const struct samsung_ufs_phy_cfg exynos7_pre_pwr_hs_cfg[] =3D {
> +       PHY_COMN_REG_CFG(0x00f, 0xfa, PWR_MODE_HS_ANY),
> +       PHY_COMN_REG_CFG(0x010, 0x82, PWR_MODE_HS_ANY),
> +       PHY_COMN_REG_CFG(0x011, 0x1e, PWR_MODE_HS_ANY),
> +       /* Setting order: 1st(0x16, 2nd(0x15) */
> +       PHY_COMN_REG_CFG(0x016, 0xff, PWR_MODE_HS_ANY),
> +       PHY_COMN_REG_CFG(0x015, 0x80, PWR_MODE_HS_ANY),
> +       PHY_COMN_REG_CFG(0x017, 0x94, PWR_MODE_HS_ANY),
> +       PHY_TRSV_REG_CFG(0x036, 0x32, PWR_MODE_HS_ANY),
> +       PHY_TRSV_REG_CFG(0x037, 0x43, PWR_MODE_HS_ANY),
> +       PHY_TRSV_REG_CFG(0x038, 0x3f, PWR_MODE_HS_ANY),
> +       PHY_TRSV_REG_CFG(0x042, 0x88, PWR_MODE_HS_G2_SER_A),
> +       PHY_TRSV_REG_CFG(0x042, 0xbb, PWR_MODE_HS_G2_SER_B),
> +       PHY_TRSV_REG_CFG(0x043, 0xa6, PWR_MODE_HS_ANY),
> +       PHY_TRSV_REG_CFG(0x048, 0x74, PWR_MODE_HS_ANY),
> +       PHY_TRSV_REG_CFG(0x034, 0x35, PWR_MODE_HS_G2_SER_A),
> +       PHY_TRSV_REG_CFG(0x034, 0x36, PWR_MODE_HS_G2_SER_B),
> +       PHY_TRSV_REG_CFG(0x035, 0x5b, PWR_MODE_HS_G2_SER_A),
> +       PHY_TRSV_REG_CFG(0x035, 0x5c, PWR_MODE_HS_G2_SER_B),
> +       END_UFS_PHY_CFG
> +};
> +
> +/* Calibration for HS mode series A/B atfer PMC */
> +static const struct samsung_ufs_phy_cfg exynos7_post_pwr_hs_cfg[] =3D {
> +       PHY_COMN_REG_CFG(0x015, 0x00, PWR_MODE_HS_ANY),
> +       PHY_TRSV_REG_CFG(0x04d, 0x83, PWR_MODE_HS_ANY),
> +       END_UFS_PHY_CFG
> +};
> +
> +static const struct samsung_ufs_phy_cfg *exynos7_ufs_phy_cfgs[CFG_TAG_MA=
X] =3D {
> +       [CFG_PRE_INIT]          =3D exynos7_pre_init_cfg,
> +       [CFG_POST_INIT]         =3D exynos7_post_init_cfg,
> +       [CFG_PRE_PWR_HS]        =3D exynos7_pre_pwr_hs_cfg,
> +       [CFG_POST_PWR_HS]       =3D exynos7_post_pwr_hs_cfg,
> +};
> +
> +static struct samsung_ufs_phy_drvdata exynos7_ufs_phy =3D {
> +       .cfg =3D exynos7_ufs_phy_cfgs,
> +       .isol =3D {
> +               .offset =3D EXYNOS7_EMBEDDED_COMBO_PHY_CTRL,
> +               .mask =3D EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_MASK,
> +               .en =3D EXYNOS7_EMBEDDED_COMBO_PHY_CTRL_EN,
> +       },
> +       .has_symbol_clk =3D 1,
> +};
> +
> +#endif /* _PHY_EXYNOS7_UFS_H_ */
> diff --git a/drivers/phy/samsung/phy-samsung-ufs.c b/drivers/phy/samsung/=
phy-samsung-ufs.c
> new file mode 100644
> index 000000000000..3077f3901737
> --- /dev/null
> +++ b/drivers/phy/samsung/phy-samsung-ufs.c
> @@ -0,0 +1,359 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * UFS PHY driver for Samsung SoC
> + *
> + * Copyright (C) 2020 Samsung Electronics Co., Ltd.
> + * Author: Seungwon Jeon <essuuj@gmail.com>
> + * Author: Alim Akhtar <alim.akhtar@samsung.com>
> + *
> + */
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/of.h>
> +#include <linux/io.h>
> +#include <linux/iopoll.h>
> +#include <linux/mfd/syscon.h>
> +#include <linux/module.h>
> +#include <linux/phy/phy.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "phy-samsung-ufs.h"
> +
> +#define for_each_phy_lane(phy, i) \
> +       for (i =3D 0; i < (phy)->lane_cnt; i++)
> +#define for_each_phy_cfg(cfg) \
> +       for (; (cfg)->id; (cfg)++)
> +
> +#define PHY_DEF_LANE_CNT       1
> +
> +static void samsung_ufs_phy_config(struct samsung_ufs_phy *phy,
> +                                  const struct samsung_ufs_phy_cfg *cfg,
> +                                  u8 lane)
> +{
> +       enum {LANE_0, LANE_1}; /* lane index */
> +
> +       switch (lane) {
> +       case LANE_0:
> +               writel(cfg->val, (phy)->reg_pma + cfg->off_0);
> +               break;
> +       case LANE_1:
> +               if (cfg->id =3D=3D PHY_TRSV_BLK)
> +                       writel(cfg->val, (phy)->reg_pma + cfg->off_1);
> +               break;
> +       }
> +}
> +
> +static int samsung_ufs_phy_wait_for_lock_acq(struct phy *phy)
> +{
> +       struct samsung_ufs_phy *ufs_phy =3D get_samsung_ufs_phy(phy);
> +       const unsigned int timeout_us =3D 100000;
> +       const unsigned int sleep_us =3D 10;
> +       u32 val;
> +       int err;
> +
> +       err =3D readl_poll_timeout(
> +                       ufs_phy->reg_pma + PHY_APB_ADDR(PHY_PLL_LOCK_STAT=
US),
> +                       val, (val & PHY_PLL_LOCK_BIT), sleep_us, timeout_=
us);
> +       if (err) {
> +               dev_err(ufs_phy->dev,
> +                       "failed to get phy pll lock acquisition %d\n", er=
r);
> +               goto out;
> +       }
> +
> +       err =3D readl_poll_timeout(
> +                       ufs_phy->reg_pma + PHY_APB_ADDR(PHY_CDR_LOCK_STAT=
US),
> +                       val, (val & PHY_CDR_LOCK_BIT), sleep_us, timeout_=
us);
> +       if (err)
> +               dev_err(ufs_phy->dev,
> +                       "failed to get phy cdr lock acquisition %d\n", er=
r);
> +out:
> +       return err;
> +}
> +
> +static int samsung_ufs_phy_calibrate(struct phy *phy)
> +{
> +       struct samsung_ufs_phy *ufs_phy =3D get_samsung_ufs_phy(phy);
> +       struct samsung_ufs_phy_cfg **cfgs =3D ufs_phy->cfg;
> +       const struct samsung_ufs_phy_cfg *cfg;
> +       int err =3D 0;
> +       int i;
> +
> +       if (unlikely(ufs_phy->ufs_phy_state < CFG_PRE_INIT ||
> +                    ufs_phy->ufs_phy_state >=3D CFG_TAG_MAX)) {
> +               dev_err(ufs_phy->dev, "invalid phy config index %d\n", uf=
s_phy->ufs_phy_state);
> +               return -EINVAL;
> +       }
> +
> +       cfg =3D cfgs[ufs_phy->ufs_phy_state];
> +       if (!cfg)
> +               goto out;
> +
> +       for_each_phy_cfg(cfg) {
> +               for_each_phy_lane(ufs_phy, i) {
> +                       samsung_ufs_phy_config(ufs_phy, cfg, i);
> +               }
> +       }
> +
> +       if (ufs_phy->ufs_phy_state =3D=3D CFG_POST_PWR_HS)
> +               err =3D samsung_ufs_phy_wait_for_lock_acq(phy);
> +
> +       /**
> +        * In Samsung ufshci, PHY need to be calibrated at different
> +        * stages / state mainly before Linkstartup, after Linkstartup,
> +        * before power mode change and after power mode change.
> +        * Below state machine to make sure to calibrate PHY in each
> +        * state. Here after configuring PHY in a given state, will
> +        * change the state to next state so that next state phy
> +        * calibration value can be programed
> +        */
> +       switch (ufs_phy->ufs_phy_state) {
> +       case CFG_PRE_INIT:
> +               ufs_phy->ufs_phy_state =3D CFG_POST_INIT;
> +               break;
> +       case CFG_POST_INIT:
> +               ufs_phy->ufs_phy_state =3D CFG_PRE_PWR_HS;
> +               break;
> +       case CFG_PRE_PWR_HS:
> +               ufs_phy->ufs_phy_state =3D CFG_POST_PWR_HS;
> +               break;
> +       case CFG_POST_PWR_HS:
> +               /* Change back to INIT state */
> +               ufs_phy->ufs_phy_state =3D CFG_PRE_INIT;
> +               break;
> +       default:
> +               dev_err(ufs_phy->dev, "wrong state for phy calibration\n"=
);
> +       }
> +
> +out:
> +       return err;
> +}
> +
> +static int samsung_ufs_phy_symbol_clk_init(struct samsung_ufs_phy *phy)
> +{
> +       int ret =3D 0;
> +
> +       phy->tx0_symbol_clk =3D devm_clk_get(phy->dev, "tx0_symbol_clk");
> +       if (IS_ERR(phy->tx0_symbol_clk)) {
> +               dev_err(phy->dev, "failed to get tx0_symbol_clk clock\n")=
;
> +               goto out;
> +       }
> +
> +       phy->rx0_symbol_clk =3D devm_clk_get(phy->dev, "rx0_symbol_clk");
> +       if (IS_ERR(phy->rx0_symbol_clk)) {
> +               dev_err(phy->dev, "failed to get rx0_symbol_clk clock\n")=
;
> +               goto out;
> +       }
> +
> +       phy->rx1_symbol_clk =3D devm_clk_get(phy->dev, "rx1_symbol_clk");
> +       if (IS_ERR(phy->rx0_symbol_clk)) {
> +               dev_err(phy->dev, "failed to get rx1_symbol_clk clock\n")=
;
> +               goto out;
> +       }
> +
> +       ret =3D clk_prepare_enable(phy->tx0_symbol_clk);
> +       if (ret) {
> +               dev_err(phy->dev, "%s: tx0_symbol_clk enable failed %d\n"=
, __func__, ret);
> +               goto out;
> +       }
> +
> +       ret =3D clk_prepare_enable(phy->rx0_symbol_clk);
> +       if (ret) {
> +               dev_err(phy->dev, "%s: rx0_symbol_clk enable failed %d\n"=
, __func__, ret);
> +               clk_disable_unprepare(phy->tx0_symbol_clk);
> +               goto out;
> +       }
> +
> +       ret =3D clk_prepare_enable(phy->rx1_symbol_clk);
> +       if (ret) {
> +               dev_err(phy->dev, "%s: rx1_symbol_clk enable failed %d\n"=
, __func__, ret);
> +               clk_disable_unprepare(phy->tx0_symbol_clk);
> +               clk_disable_unprepare(phy->rx0_symbol_clk);
> +       }
> +out:
> +       return ret;
> +}
> +
> +static int samsung_ufs_phy_clks_init(struct samsung_ufs_phy *phy)
> +{
> +       int ret;
> +
> +       phy->ref_clk =3D devm_clk_get(phy->dev, "ref_clk");
> +       if (IS_ERR(phy->ref_clk))
> +               dev_err(phy->dev, "failed to get ref_clk clock\n");
> +
> +       ret =3D clk_prepare_enable(phy->ref_clk);
> +       if (ret) {
> +               dev_err(phy->dev, "%s: ref_clk enable failed %d\n", __fun=
c__, ret);
> +               return ret;
> +       }
> +
> +       dev_info(phy->dev, "UFS MPHY ref_clk_rate =3D %ld\n", clk_get_rat=
e(phy->ref_clk));
> +
> +       return 0;
> +}
> +
> +static int samsung_ufs_phy_init(struct phy *phy)
> +{
> +       struct samsung_ufs_phy *_phy =3D get_samsung_ufs_phy(phy);
> +       int ret;
> +
> +       _phy->lane_cnt =3D phy->attrs.bus_width;
> +       _phy->ufs_phy_state =3D CFG_PRE_INIT;
> +
> +       if (_phy->drvdata->has_symbol_clk) {
> +               ret =3D samsung_ufs_phy_symbol_clk_init(_phy);
> +               if (ret)
> +                       dev_err(_phy->dev, "failed to set ufs phy symbol =
clocks\n");
> +       }
> +
> +       ret =3D samsung_ufs_phy_clks_init(_phy);
> +       if (ret)
> +               dev_err(_phy->dev, "failed to set ufs phy  clocks\n");
> +
> +       samsung_ufs_phy_calibrate(phy);
> +
> +       return 0;
> +}
> +
> +static int samsung_ufs_phy_power_on(struct phy *phy)
> +{
> +       struct samsung_ufs_phy *_phy =3D get_samsung_ufs_phy(phy);
> +
> +       samsung_ufs_phy_ctrl_isol(_phy, false);
> +       return 0;
> +}
> +
> +static int samsung_ufs_phy_power_off(struct phy *phy)
> +{
> +       struct samsung_ufs_phy *_phy =3D get_samsung_ufs_phy(phy);
> +
> +       samsung_ufs_phy_ctrl_isol(_phy, true);
> +       return 0;
> +}
> +
> +static int samsung_ufs_phy_set_mode(struct phy *generic_phy,
> +                                   enum phy_mode mode, int submode)
> +{
> +       struct samsung_ufs_phy *_phy =3D get_samsung_ufs_phy(generic_phy)=
;
> +
> +       _phy->mode =3D PHY_MODE_INVALID;
> +
> +       if (mode > 0)
> +               _phy->mode =3D mode;
> +
> +       return 0;
> +}
> +
> +static int samsung_ufs_phy_exit(struct phy *phy)
> +{
> +       struct samsung_ufs_phy *_phy =3D get_samsung_ufs_phy(phy);
> +
> +       clk_disable_unprepare(_phy->ref_clk);
> +
> +       if (_phy->drvdata->has_symbol_clk) {
> +               clk_disable_unprepare(_phy->tx0_symbol_clk);
> +               clk_disable_unprepare(_phy->rx0_symbol_clk);
> +               clk_disable_unprepare(_phy->rx1_symbol_clk);
> +       }
> +
> +       return 0;
> +}
> +
> +static struct phy_ops samsung_ufs_phy_ops =3D {
> +       .init           =3D samsung_ufs_phy_init,
> +       .exit           =3D samsung_ufs_phy_exit,
> +       .power_on       =3D samsung_ufs_phy_power_on,
> +       .power_off      =3D samsung_ufs_phy_power_off,
> +       .calibrate      =3D samsung_ufs_phy_calibrate,
> +       .set_mode       =3D samsung_ufs_phy_set_mode,
> +       .owner          =3D THIS_MODULE,
> +};
> +
> +static const struct of_device_id samsung_ufs_phy_match[];
> +
> +static int samsung_ufs_phy_probe(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       const struct of_device_id *match;
> +       struct samsung_ufs_phy *phy;
> +       struct phy *gen_phy;
> +       struct phy_provider *phy_provider;
> +       const struct samsung_ufs_phy_drvdata *drvdata;
> +       int err =3D 0;
> +
> +       match =3D of_match_node(samsung_ufs_phy_match, dev->of_node);
> +       if (!match) {
> +               err =3D -EINVAL;
> +               dev_err(dev, "failed to get match_node\n");
> +               goto out;
> +       }
> +
> +       phy =3D devm_kzalloc(dev, sizeof(*phy), GFP_KERNEL);
> +       if (!phy) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       phy->reg_pma =3D devm_platform_ioremap_resource_byname(pdev, "phy=
-pma");
> +       if (IS_ERR(phy->reg_pma)) {
> +               err =3D PTR_ERR(phy->reg_pma);
> +               goto out;
> +       }
> +
> +       phy->reg_pmu =3D syscon_regmap_lookup_by_phandle(
> +                               dev->of_node, "samsung,pmu-syscon");
> +       if (IS_ERR(phy->reg_pmu)) {
> +               err =3D PTR_ERR(phy->reg_pmu);
> +               dev_err(dev, "failed syscon remap for pmu\n");
> +               goto out;
> +       }
> +
> +       gen_phy =3D devm_phy_create(dev, NULL, &samsung_ufs_phy_ops);
> +       if (IS_ERR(gen_phy)) {
> +               err =3D PTR_ERR(gen_phy);
> +               dev_err(dev, "failed to create PHY for ufs-phy\n");
> +               goto out;
> +       }
> +
> +       drvdata =3D match->data;
> +       phy->dev =3D dev;
> +       phy->drvdata =3D drvdata;
> +       phy->cfg =3D (struct samsung_ufs_phy_cfg **)drvdata->cfg;
> +       phy->isol =3D &drvdata->isol;
> +       phy->lane_cnt =3D PHY_DEF_LANE_CNT;
> +
> +       phy_set_drvdata(gen_phy, phy);
> +
> +       phy_provider =3D devm_of_phy_provider_register(dev, of_phy_simple=
_xlate);
> +       if (IS_ERR(phy_provider)) {
> +               err =3D PTR_ERR(phy_provider);
> +               dev_err(dev, "failed to register phy-provider\n");
> +               goto out;
> +       }
> +out:
> +       return err;
> +}
> +
> +static const struct of_device_id samsung_ufs_phy_match[] =3D {
> +       {
> +               .compatible =3D "samsung,exynos7-ufs-phy",
> +               .data =3D &exynos7_ufs_phy,
> +       },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(of, samsung_ufs_phy_match);
> +
> +static struct platform_driver samsung_ufs_phy_driver =3D {
> +       .probe  =3D samsung_ufs_phy_probe,
> +       .driver =3D {
> +               .name =3D "samsung-ufs-phy",
> +               .of_match_table =3D samsung_ufs_phy_match,
> +       },
> +};
> +module_platform_driver(samsung_ufs_phy_driver);
> +MODULE_DESCRIPTION("Samsung SoC UFS PHY Driver");
> +MODULE_AUTHOR("Seungwon Jeon <essuuj@gmail.com>");
> +MODULE_AUTHOR("Alim Akhtar <alim.akhtar@samsung.com>");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/phy/samsung/phy-samsung-ufs.h b/drivers/phy/samsung/=
phy-samsung-ufs.h
> new file mode 100644
> index 000000000000..5de78710524c
> --- /dev/null
> +++ b/drivers/phy/samsung/phy-samsung-ufs.h
> @@ -0,0 +1,139 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * UFS PHY driver for Samsung EXYNOS SoC
> + *
> + * Copyright (C) 2020 Samsung Electronics Co., Ltd.
> + * Author: Seungwon Jeon <essuuj@gmail.com>
> + * Author: Alim Akhtar <alim.akhtar@samsung.com>
> + *
> + */
> +#ifndef _PHY_SAMSUNG_UFS_
> +#define _PHY_SAMSUNG_UFS_
> +
> +#define PHY_COMN_BLK   1
> +#define PHY_TRSV_BLK   2
> +#define END_UFS_PHY_CFG { 0 }
> +#define PHY_TRSV_CH_OFFSET     0x30
> +#define PHY_APB_ADDR(off)      ((off) << 2)
> +
> +#define PHY_COMN_REG_CFG(o, v, d) {    \
> +       .off_0 =3D PHY_APB_ADDR((o)),     \
> +       .off_1 =3D 0,             \
> +       .val =3D (v),             \
> +       .desc =3D (d),            \
> +       .id =3D PHY_COMN_BLK,     \
> +}
> +
> +#define PHY_TRSV_REG_CFG(o, v, d) {    \
> +       .off_0 =3D PHY_APB_ADDR((o)),     \
> +       .off_1 =3D PHY_APB_ADDR((o) + PHY_TRSV_CH_OFFSET),        \
> +       .val =3D (v),             \
> +       .desc =3D (d),            \
> +       .id =3D PHY_TRSV_BLK,     \
> +}
> +
> +/* UFS PHY registers */
> +#define PHY_PLL_LOCK_STATUS    0x1e
> +#define PHY_CDR_LOCK_STATUS    0x5e
> +
> +#define PHY_PLL_LOCK_BIT       BIT(5)
> +#define PHY_CDR_LOCK_BIT       BIT(4)
> +
> +/* description for PHY calibration */
> +enum {
> +       /* applicable to any */
> +       PWR_DESC_ANY    =3D 0,
> +       /* mode */
> +       PWR_DESC_PWM    =3D 1,
> +       PWR_DESC_HS     =3D 2,
> +       /* series */
> +       PWR_DESC_SER_A  =3D 1,
> +       PWR_DESC_SER_B  =3D 2,
> +       /* gear */
> +       PWR_DESC_G1     =3D 1,
> +       PWR_DESC_G2     =3D 2,
> +       PWR_DESC_G3     =3D 3,
> +       /* field mask */
> +       MD_MASK         =3D 0x3,
> +       SR_MASK         =3D 0x3,
> +       GR_MASK         =3D 0x7,
> +};
> +
> +#define PWR_MODE_HS_G1_ANY     PWR_MODE_HS(PWR_DESC_G1, PWR_DESC_ANY)
> +#define PWR_MODE_HS_G1_SER_A   PWR_MODE_HS(PWR_DESC_G1, PWR_DESC_SER_A)
> +#define PWR_MODE_HS_G1_SER_B   PWR_MODE_HS(PWR_DESC_G1, PWR_DESC_SER_B)
> +#define PWR_MODE_HS_G2_ANY     PWR_MODE_HS(PWR_DESC_G2, PWR_DESC_ANY)
> +#define PWR_MODE_HS_G2_SER_A   PWR_MODE_HS(PWR_DESC_G2, PWR_DESC_SER_A)
> +#define PWR_MODE_HS_G2_SER_B   PWR_MODE_HS(PWR_DESC_G2, PWR_DESC_SER_B)
> +#define PWR_MODE_HS_G3_ANY     PWR_MODE_HS(PWR_DESC_G3, PWR_DESC_ANY)
> +#define PWR_MODE_HS_G3_SER_A   PWR_MODE_HS(PWR_DESC_G3, PWR_DESC_SER_A)
> +#define PWR_MODE_HS_G3_SER_B   PWR_MODE_HS(PWR_DESC_G3, PWR_DESC_SER_B)
> +#define PWR_MODE(g, s, m)      ((((g) & GR_MASK) << 4) |\
> +                                (((s) & SR_MASK) << 2) | ((m) & MD_MASK)=
)
> +#define PWR_MODE_PWM_ANY       PWR_MODE(PWR_DESC_ANY,\
> +                                        PWR_DESC_ANY, PWR_DESC_PWM)
> +#define PWR_MODE_HS(g, s)      ((((g) & GR_MASK) << 4) |\
> +                                (((s) & SR_MASK) << 2) | PWR_DESC_HS)
> +#define PWR_MODE_HS_ANY                PWR_MODE(PWR_DESC_ANY,\
> +                                        PWR_DESC_ANY, PWR_DESC_HS)
> +#define PWR_MODE_ANY           PWR_MODE(PWR_DESC_ANY,\
> +                                        PWR_DESC_ANY, PWR_DESC_ANY)
> +/* PHY calibration point/state */
> +enum {
> +       CFG_PRE_INIT,
> +       CFG_POST_INIT,
> +       CFG_PRE_PWR_HS,
> +       CFG_POST_PWR_HS,
> +       CFG_TAG_MAX,
> +};
> +
> +struct samsung_ufs_phy_cfg {
> +       u32 off_0;
> +       u32 off_1;
> +       u32 val;
> +       u8 desc;
> +       u8 id;
> +};
> +
> +struct samsung_ufs_phy_drvdata {
> +       const struct samsung_ufs_phy_cfg **cfg;
> +       struct pmu_isol {
> +               u32 offset;
> +               u32 mask;
> +               u32 en;
> +       } isol;
> +       bool has_symbol_clk;
> +};
> +
> +struct samsung_ufs_phy {
> +       struct device *dev;
> +       void __iomem *reg_pma;
> +       struct regmap *reg_pmu;
> +       struct clk *ref_clk;
> +       struct clk *ref_clk_parent;
> +       struct clk *tx0_symbol_clk;
> +       struct clk *rx0_symbol_clk;
> +       struct clk *rx1_symbol_clk;
> +       const struct samsung_ufs_phy_drvdata *drvdata;
> +       struct samsung_ufs_phy_cfg **cfg;
> +       const struct pmu_isol *isol;
> +       u8 lane_cnt;
> +       int ufs_phy_state;
> +       enum phy_mode mode;
> +};
> +
> +static inline struct samsung_ufs_phy *get_samsung_ufs_phy(struct phy *ph=
y)
> +{
> +       return (struct samsung_ufs_phy *)phy_get_drvdata(phy);
> +}
> +
> +static inline void samsung_ufs_phy_ctrl_isol(
> +               struct samsung_ufs_phy *phy, u32 isol)
> +{
> +       regmap_update_bits(phy->reg_pmu, phy->isol->offset,
> +                          phy->isol->mask, isol ? 0 : phy->isol->en);
> +}
> +
> +#include "phy-exynos7-ufs.h"
> +
> +#endif /* _PHY_SAMSUNG_UFS_ */
> --
> 2.17.1
>


--=20
Regards,
Alim
