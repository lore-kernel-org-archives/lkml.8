Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8496C55191
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE7ED2071C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:20:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E4Si9Zs5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgDWSUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730042AbgDWSUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:20:06 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEFFC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:05 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id h6so3365999qvz.8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=bf0nGSVGkC+aztgKP2PSvhhFaNUMbOeW1ZqugBFPCTM=;
        b=E4Si9Zs50J0Wnw08bSJi9uMTQi3oU5V4Qc2VYNf1UFjvEtqvWkt1I/EUqdzy+wp3xa
         XtDLUqh/tZkDI9JZyEqqJ/w0KMqOedX8Z1PNVJSSL4KuzM3FCTfeGpkffMRQz/aIIX5K
         bSS+eIN4i32o9vXAEckGF5aEqBuNpsb6RHPjqV61nlButdaCwSlo/VW1UtOvvaPPWibN
         r1QrJDbShe+9YQje+FIqg7rUsdxgsMWDyRTUpaHYduW37kcTxwzQA8d0jNDmfykQw9iC
         VTxAvxRPldYF1Glb6o8+GP9iG0UrcvWPdT2X8Irp9f6rSna51vDCc/+9C3sqwVeKe5W3
         2TAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=bf0nGSVGkC+aztgKP2PSvhhFaNUMbOeW1ZqugBFPCTM=;
        b=bEhKOTjv9OCaHT3rrpOqBxjcfM2e1zbCoLT5sXBIFkNsp02I5SXHfMvtiNA5byLuJS
         9Ie8G9ldDOelaI59Lq2W64aXkrtq5hN26+Oo7n6joLcrbu/eyIhVwNEMbTLW2Mguj+jd
         NAblMb/yHLkVD5yz04bQFllNcPCt7HqklxsEbyhfo/XpcYfFR/7AY3EnsrgeX0GSxQl2
         f3piklW0F1JeKVcLdKnMutE0eh8QDnjOQxbcpvZwZrF1yiyXSM99+tTlLL5pSq97/Y5o
         xu6H4JVb7oJHUuLGQ49sI+K+X+Ut+xmcz4hNdKsryf58Qj4MkvnYhWvMm/hb/eOiHR/f
         oeqQ==
X-Gm-Message-State: AGi0PuaVvOaRo25xpXINNqDv8TSk/qPMcn324qDzQCfecgn7qWwZoAa7
        DX64Zw+ziB8/148fBh812/tODRzILtOJf1qC57M=
X-Google-Smtp-Source: APiQypIVFaULtGdf4UGHlruSImJ/HsnciUDMb1Iuy1wvq3Ul8ltZWWR7DLuFJ5P+pMtYRjqV8O52hE1uJkqWOhfRLdU=
X-Received: by 2002:a0c:c505:: with SMTP id x5mr5555355qvi.121.1587666005017;
 Thu, 23 Apr 2020 11:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <1584689540-5227-1-git-send-email-weiyi.lu@mediatek.com> <1584689540-5227-5-git-send-email-weiyi.lu@mediatek.com>
In-Reply-To: <1584689540-5227-5-git-send-email-weiyi.lu@mediatek.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Thu, 23 Apr 2020 20:19:53 +0200
Message-ID: <CAFqH_50HUcy1u69nXhp1bTY-MObp5-J=HorUwyc4Wpt6jFVjTw@mail.gmail.com>
Subject: Re: [PATCH v13 04/11] soc: mediatek: Remove infracfg misc driver support
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        James Liao <jamesjj.liao@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fan Chen <fan.chen@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Weiyi Lu,

Thank you for the patch

Missatge de Weiyi Lu <weiyi.lu@mediatek.com> del dia dv., 20 de mar=C3=A7
2020 a les 8:33:
>
> The functions provided by infracfg misc driver have no other user except
> the scpsys driver so move those into scpsys driver directly.
> And then, remove infracfg misc drvier which is no longer being used.
> BTW, in next patch, we're going to extend the bus protection functions
> with more customized arguments.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>
> ---
>  drivers/soc/mediatek/Kconfig          | 10 -----
>  drivers/soc/mediatek/Makefile         |  1 -
>  drivers/soc/mediatek/mtk-infracfg.c   | 79 -----------------------------=
------
>  drivers/soc/mediatek/mtk-scpsys.c     | 44 +++++++++++++++----
>  drivers/soc/mediatek/scpsys.h         | 28 +++++++++++++
>  include/linux/soc/mediatek/infracfg.h | 39 -----------------
>  6 files changed, 63 insertions(+), 138 deletions(-)
>  delete mode 100644 drivers/soc/mediatek/mtk-infracfg.c
>  create mode 100644 drivers/soc/mediatek/scpsys.h
>  delete mode 100644 include/linux/soc/mediatek/infracfg.h
>
> diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
> index 2114b56..f837b3c 100644
> --- a/drivers/soc/mediatek/Kconfig
> +++ b/drivers/soc/mediatek/Kconfig
> @@ -10,21 +10,12 @@ config MTK_CMDQ
>         depends on ARCH_MEDIATEK || COMPILE_TEST
>         select MAILBOX
>         select MTK_CMDQ_MBOX
> -       select MTK_INFRACFG
>         help
>           Say yes here to add support for the MediaTek Command Queue (CMD=
Q)
>           driver. The CMDQ is used to help read/write registers with crit=
ical
>           time limitation, such as updating display configuration during =
the
>           vblank.
>
> -config MTK_INFRACFG
> -       bool "MediaTek INFRACFG Support"
> -       select REGMAP
> -       help
> -         Say yes here to add support for the MediaTek INFRACFG controlle=
r. The
> -         INFRACFG controller contains various infrastructure registers n=
ot
> -         directly associated to any device.
> -
>  config MTK_PMIC_WRAP
>         tristate "MediaTek PMIC Wrapper Support"
>         depends on RESET_CONTROLLER
> @@ -38,7 +29,6 @@ config MTK_SCPSYS
>         bool "MediaTek SCPSYS Support"
>         default ARCH_MEDIATEK
>         select REGMAP
> -       select MTK_INFRACFG
>         select PM_GENERIC_DOMAINS if PM
>         help
>           Say yes here to add support for the MediaTek SCPSYS power domai=
n
> diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefil=
e
> index b017330..2b2c2537 100644
> --- a/drivers/soc/mediatek/Makefile
> +++ b/drivers/soc/mediatek/Makefile
> @@ -1,5 +1,4 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  obj-$(CONFIG_MTK_CMDQ) +=3D mtk-cmdq-helper.o
> -obj-$(CONFIG_MTK_INFRACFG) +=3D mtk-infracfg.o
>  obj-$(CONFIG_MTK_PMIC_WRAP) +=3D mtk-pmic-wrap.o
>  obj-$(CONFIG_MTK_SCPSYS) +=3D mtk-scpsys.o
> diff --git a/drivers/soc/mediatek/mtk-infracfg.c b/drivers/soc/mediatek/m=
tk-infracfg.c
> deleted file mode 100644
> index 341c7ac..0000000
> --- a/drivers/soc/mediatek/mtk-infracfg.c
> +++ /dev/null
> @@ -1,79 +0,0 @@
> -// SPDX-License-Identifier: GPL-2.0-only
> -/*
> - * Copyright (c) 2015 Pengutronix, Sascha Hauer <kernel@pengutronix.de>
> - */
> -
> -#include <linux/export.h>
> -#include <linux/jiffies.h>
> -#include <linux/regmap.h>
> -#include <linux/soc/mediatek/infracfg.h>
> -#include <asm/processor.h>
> -
> -#define MTK_POLL_DELAY_US   10
> -#define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
> -
> -#define INFRA_TOPAXI_PROTECTEN         0x0220
> -#define INFRA_TOPAXI_PROTECTSTA1       0x0228
> -#define INFRA_TOPAXI_PROTECTEN_SET     0x0260
> -#define INFRA_TOPAXI_PROTECTEN_CLR     0x0264
> -
> -/**
> - * mtk_infracfg_set_bus_protection - enable bus protection
> - * @regmap: The infracfg regmap
> - * @mask: The mask containing the protection bits to be enabled.
> - * @reg_update: The boolean flag determines to set the protection bits
> - *              by regmap_update_bits with enable register(PROTECTEN) or
> - *              by regmap_write with set register(PROTECTEN_SET).
> - *
> - * This function enables the bus protection bits for disabled power
> - * domains so that the system does not hang when some unit accesses the
> - * bus while in power down.
> - */
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update)
> -{
> -       u32 val;
> -       int ret;
> -
> -       if (reg_update)
> -               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask=
,
> -                               mask);
> -       else
> -               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> -
> -       ret =3D regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTST=
A1,
> -                                      val, (val & mask) =3D=3D mask,
> -                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOU=
T);
> -
> -       return ret;
> -}
> -
> -/**
> - * mtk_infracfg_clear_bus_protection - disable bus protection
> - * @regmap: The infracfg regmap
> - * @mask: The mask containing the protection bits to be disabled.
> - * @reg_update: The boolean flag determines to clear the protection bits
> - *              by regmap_update_bits with enable register(PROTECTEN) or
> - *              by regmap_write with clear register(PROTECTEN_CLR).
> - *
> - * This function disables the bus protection bits previously enabled wit=
h
> - * mtk_infracfg_set_bus_protection.
> - */
> -
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update)
> -{
> -       int ret;
> -       u32 val;
> -
> -       if (reg_update)
> -               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask=
, 0);
> -       else
> -               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> -
> -       ret =3D regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTST=
A1,
> -                                      val, !(val & mask),
> -                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOU=
T);
> -
> -       return ret;
> -}
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk=
-scpsys.c
> index db35a28..e50a568 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -10,8 +10,9 @@
>  #include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/pm_domain.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> -#include <linux/soc/mediatek/infracfg.h>
> +#include "scpsys.h"

Are the defines in this include going to be used somewhere else?
Otherwise, you can add the defines in this file directly.


>
>  #include <dt-bindings/power/mt2701-power.h>
>  #include <dt-bindings/power/mt2712-power.h>
> @@ -251,25 +252,50 @@ static int scpsys_sram_disable(struct scp_domain *s=
cpd, void __iomem *ctl_addr)
>  static int scpsys_bus_protect_enable(struct scp_domain *scpd)
>  {
>         struct scp *scp =3D scpd->scp;
> +       struct regmap *infracfg =3D scp->infracfg;
> +       u32 mask =3D scpd->data->bus_prot_mask;
> +       bool reg_update =3D scp->bus_prot_reg_update;
> +       u32 val;
> +       int ret;
>
> -       if (!scpd->data->bus_prot_mask)
> +       if (!mask)
>                 return 0;
>
> -       return mtk_infracfg_set_bus_protection(scp->infracfg,
> -                       scpd->data->bus_prot_mask,
> -                       scp->bus_prot_reg_update);
> +       if (reg_update)
> +               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask=
,
> +                               mask);
> +       else
> +               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_SET, mask);
> +
> +       ret =3D regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTST=
A1,
> +                                      val, (val & mask) =3D=3D mask,
> +                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOU=
T);
> +
> +       return ret;
>  }
>
>  static int scpsys_bus_protect_disable(struct scp_domain *scpd)
>  {
>         struct scp *scp =3D scpd->scp;
> +       struct regmap *infracfg =3D scp->infracfg;
> +       u32 mask =3D scpd->data->bus_prot_mask;
> +       bool reg_update =3D scp->bus_prot_reg_update;
> +       u32 val;
> +       int ret;
>
> -       if (!scpd->data->bus_prot_mask)
> +       if (!mask)
>                 return 0;
>
> -       return mtk_infracfg_clear_bus_protection(scp->infracfg,
> -                       scpd->data->bus_prot_mask,
> -                       scp->bus_prot_reg_update);
> +       if (reg_update)
> +               regmap_update_bits(infracfg, INFRA_TOPAXI_PROTECTEN, mask=
, 0);
> +       else
> +               regmap_write(infracfg, INFRA_TOPAXI_PROTECTEN_CLR, mask);
> +
> +       ret =3D regmap_read_poll_timeout(infracfg, INFRA_TOPAXI_PROTECTST=
A1,
> +                                      val, !(val & mask),
> +                                      MTK_POLL_DELAY_US, MTK_POLL_TIMEOU=
T);
> +
> +       return ret;
>  }
>
>  static int scpsys_power_on(struct generic_pm_domain *genpd)
> diff --git a/drivers/soc/mediatek/scpsys.h b/drivers/soc/mediatek/scpsys.=
h
> new file mode 100644
> index 0000000..ad2559b
> --- /dev/null
> +++ b/drivers/soc/mediatek/scpsys.h
> @@ -0,0 +1,28 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __SOC_MEDIATEK_SCPSYS_H
> +#define __SOC_MEDIATEK_SCPSYS_H
> +
> +#define INFRA_TOPAXI_PROTECTEN         0x0220
> +#define INFRA_TOPAXI_PROTECTSTA1       0x0228
> +#define INFRA_TOPAXI_PROTECTEN_SET     0x0260
> +#define INFRA_TOPAXI_PROTECTEN_CLR     0x0264
> +
> +#define MT2701_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> +#define MT2701_TOP_AXI_PROT_EN_CONN_M          BIT(2)
> +#define MT2701_TOP_AXI_PROT_EN_CONN_S          BIT(8)
> +
> +#define MT7622_TOP_AXI_PROT_EN_ETHSYS          (BIT(3) | BIT(17))
> +#define MT7622_TOP_AXI_PROT_EN_HIF0            (BIT(24) | BIT(25))
> +#define MT7622_TOP_AXI_PROT_EN_HIF1            (BIT(26) | BIT(27) | \
> +                                                BIT(28))
> +#define MT7622_TOP_AXI_PROT_EN_WB              (BIT(2) | BIT(6) | \
> +                                                BIT(7) | BIT(8))
> +
> +#define MT8173_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> +#define MT8173_TOP_AXI_PROT_EN_MM_M1           BIT(2)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_S           BIT(14)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_M0          BIT(21)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_M1          BIT(22)
> +#define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT   BIT(23)
> +
> +#endif /* __SOC_MEDIATEK_SCPSYS_H */
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/me=
diatek/infracfg.h
> deleted file mode 100644
> index fd25f01..0000000
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ /dev/null
> @@ -1,39 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef __SOC_MEDIATEK_INFRACFG_H
> -#define __SOC_MEDIATEK_INFRACFG_H
> -
> -#define MT8173_TOP_AXI_PROT_EN_MCI_M2          BIT(0)
> -#define MT8173_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> -#define MT8173_TOP_AXI_PROT_EN_MM_M1           BIT(2)
> -#define MT8173_TOP_AXI_PROT_EN_MMAPB_S         BIT(6)
> -#define MT8173_TOP_AXI_PROT_EN_L2C_M2          BIT(9)
> -#define MT8173_TOP_AXI_PROT_EN_L2SS_SMI                BIT(11)
> -#define MT8173_TOP_AXI_PROT_EN_L2SS_ADD                BIT(12)
> -#define MT8173_TOP_AXI_PROT_EN_CCI_M2          BIT(13)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_S           BIT(14)
> -#define MT8173_TOP_AXI_PROT_EN_PERI_M0         BIT(15)
> -#define MT8173_TOP_AXI_PROT_EN_PERI_M1         BIT(16)
> -#define MT8173_TOP_AXI_PROT_EN_DEBUGSYS                BIT(17)
> -#define MT8173_TOP_AXI_PROT_EN_CQ_DMA          BIT(18)
> -#define MT8173_TOP_AXI_PROT_EN_GCPU            BIT(19)
> -#define MT8173_TOP_AXI_PROT_EN_IOMMU           BIT(20)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_M0          BIT(21)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_M1          BIT(22)
> -#define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT   BIT(23)
> -
> -#define MT2701_TOP_AXI_PROT_EN_MM_M0           BIT(1)
> -#define MT2701_TOP_AXI_PROT_EN_CONN_M          BIT(2)
> -#define MT2701_TOP_AXI_PROT_EN_CONN_S          BIT(8)
> -
> -#define MT7622_TOP_AXI_PROT_EN_ETHSYS          (BIT(3) | BIT(17))
> -#define MT7622_TOP_AXI_PROT_EN_HIF0            (BIT(24) | BIT(25))
> -#define MT7622_TOP_AXI_PROT_EN_HIF1            (BIT(26) | BIT(27) | \
> -                                                BIT(28))
> -#define MT7622_TOP_AXI_PROT_EN_WB              (BIT(2) | BIT(6) | \
> -                                                BIT(7) | BIT(8))
> -
> -int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update);
> -int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask,
> -               bool reg_update);
> -#endif /* __SOC_MEDIATEK_INFRACFG_H */
> --
> 1.8.1.1.dirty
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
