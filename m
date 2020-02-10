Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E968C35250
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AADC20838
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 06:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBg3xsNw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgBJGCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 01:02:07 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43294 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726103AbgBJGCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 01:02:07 -0500
Received: by mail-qt1-f194.google.com with SMTP id d18so4292284qtj.10
        for <linux-kernel@vger.kernel.org>; Sun, 09 Feb 2020 22:02:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kretm2EkBgfkiMc+qwq53BRz8J4do/DUgrjcSaKPNn0=;
        b=XBg3xsNwYew/qJ6JuBUJLreVGTqJ8Yw5GQH1wV/qAHLMLGiKuNC7da6RO2ioSNKUet
         RTdd/pbzue60cWEAIFK8MQheXEmW76YwPmNt5O+gt7+B4fMPiHe8rOI+D8n+pf/JiOor
         nIldstvBB6W8cv7Sz439ra1vlmjOj18BnwsLUyVVuRtvKNsYl49cTh7oXcbcSu2qCxj0
         XSmjlxK0v233jozmRmV8ScaMzLQwvRAm5jf/p4yZIBLXCauenYHAs/jEKcZDkAtkdKYb
         lFifbe8ENeDuEnZ8/rs9CxNOsL1LoAwP4FG2D3MT/DY2d/MUJgPQX1QY2RNYDJOMYbic
         MumQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kretm2EkBgfkiMc+qwq53BRz8J4do/DUgrjcSaKPNn0=;
        b=AxCY7Et4UsmeuoZ/FPN9C/kL4tH9Qderzvm7xIFPwjFA0Im9eQPdqkLzx1+PhJ2uff
         S612iX8tgrsTtir46d+LRulR1LbP5r4xbxjW+geOwAYLsqWljhOAOFFHMhCLRvmnuqsd
         i5hlY04NMKpCONF4sVmlzgvMscBNOquel88cMMBIq1AUWTiW5xYWRqS6c4QPDPNI2dft
         xa0ixIH/YuAWbtl9x4F2FLf4o4z+KJRkAMJQ5AfP5k+TjHGBh933ySf0rGrpSYVVBGPs
         1vPzqbQAV6iqd57w3GUy9oMby6Ychum24UmyLoR3aT12qFTmNpNNvSezJAdIzsDlpfHF
         37jw==
X-Gm-Message-State: APjAAAVeqdqamhdfwn4eUm8owixlfAi2IOBgHD/c1y12qKZUdehlaHDv
        6c00rHwIvJNzHyk5QCP44T9OqSiH9L3cxH8im3I=
X-Google-Smtp-Source: APXvYqzX5ChDAsOu5+GhQDeB/jHSNo8BzdFdCSSvxgEMquLIFagSm9+A7iKhS4+n2LiUSqOfb6XfYMSutkFuy0xcXWU=
X-Received: by 2002:ac8:8d6:: with SMTP id y22mr8276493qth.85.1581314524459;
 Sun, 09 Feb 2020 22:02:04 -0800 (PST)
MIME-Version: 1.0
References: <cffcf7479885c23fe86a2635895363955d00e7de.1579514485.git.baolin.wang7@gmail.com>
In-Reply-To: <cffcf7479885c23fe86a2635895363955d00e7de.1579514485.git.baolin.wang7@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Mon, 10 Feb 2020 14:01:52 +0800
Message-ID: <CADBw62rYSkRvZEFR5g2ahvEMUmiCt5nkn=ERqEor33ps0edeFg@mail.gmail.com>
Subject: Re: [PATCH] mfd: sc27xx: Add USB charger type detection support
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On Mon, Jan 20, 2020 at 6:06 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
>
> The Spreadtrum SC27XX series PMICs supply the USB charger type detection
> function, and related registers are located on the PMIC global registers
> region, thus we implement and export this function in the MFD driver for
> users to get the USB charger type.

Do you have any comments for this patch? Thanks.

> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> ---
>  drivers/mfd/sprd-sc27xx-spi.c   |   52 +++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/sc27xx-pmic.h |    7 ++++++
>  2 files changed, 59 insertions(+)
>  create mode 100644 include/linux/mfd/sc27xx-pmic.h
>
> diff --git a/drivers/mfd/sprd-sc27xx-spi.c b/drivers/mfd/sprd-sc27xx-spi.c
> index c0529a1..ebdf2f1 100644
> --- a/drivers/mfd/sprd-sc27xx-spi.c
> +++ b/drivers/mfd/sprd-sc27xx-spi.c
> @@ -10,6 +10,7 @@
>  #include <linux/of_device.h>
>  #include <linux/regmap.h>
>  #include <linux/spi/spi.h>
> +#include <uapi/linux/usb/charger.h>
>
>  #define SPRD_PMIC_INT_MASK_STATUS      0x0
>  #define SPRD_PMIC_INT_RAW_STATUS       0x4
> @@ -17,6 +18,16 @@
>
>  #define SPRD_SC2731_IRQ_BASE           0x140
>  #define SPRD_SC2731_IRQ_NUMS           16
> +#define SPRD_SC2731_CHG_DET            0xedc
> +
> +/* PMIC charger detection definition */
> +#define SPRD_PMIC_CHG_DET_DELAY_US     200000
> +#define SPRD_PMIC_CHG_DET_TIMEOUT      2000000
> +#define SPRD_PMIC_CHG_DET_DONE         BIT(11)
> +#define SPRD_PMIC_SDP_TYPE             BIT(7)
> +#define SPRD_PMIC_DCP_TYPE             BIT(6)
> +#define SPRD_PMIC_CDP_TYPE             BIT(5)
> +#define SPRD_PMIC_CHG_TYPE_MASK                GENMASK(7, 5)
>
>  struct sprd_pmic {
>         struct regmap *regmap;
> @@ -24,12 +35,14 @@ struct sprd_pmic {
>         struct regmap_irq *irqs;
>         struct regmap_irq_chip irq_chip;
>         struct regmap_irq_chip_data *irq_data;
> +       const struct sprd_pmic_data *pdata;
>         int irq;
>  };
>
>  struct sprd_pmic_data {
>         u32 irq_base;
>         u32 num_irqs;
> +       u32 charger_det;
>  };
>
>  /*
> @@ -40,8 +53,46 @@ struct sprd_pmic_data {
>  static const struct sprd_pmic_data sc2731_data = {
>         .irq_base = SPRD_SC2731_IRQ_BASE,
>         .num_irqs = SPRD_SC2731_IRQ_NUMS,
> +       .charger_det = SPRD_SC2731_CHG_DET,
>  };
>
> +enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev)
> +{
> +       struct spi_device *spi = to_spi_device(dev);
> +       struct sprd_pmic *ddata = spi_get_drvdata(spi);
> +       const struct sprd_pmic_data *pdata = ddata->pdata;
> +       enum usb_charger_type type;
> +       u32 val;
> +       int ret;
> +
> +       ret = regmap_read_poll_timeout(ddata->regmap, pdata->charger_det, val,
> +                                      (val & SPRD_PMIC_CHG_DET_DONE),
> +                                      SPRD_PMIC_CHG_DET_DELAY_US,
> +                                      SPRD_PMIC_CHG_DET_TIMEOUT);
> +       if (ret) {
> +               dev_err(&spi->dev, "failed to detect charger type\n");
> +               return UNKNOWN_TYPE;
> +       }
> +
> +       switch (val & SPRD_PMIC_CHG_TYPE_MASK) {
> +       case SPRD_PMIC_CDP_TYPE:
> +               type = CDP_TYPE;
> +               break;
> +       case SPRD_PMIC_DCP_TYPE:
> +               type = DCP_TYPE;
> +               break;
> +       case SPRD_PMIC_SDP_TYPE:
> +               type = SDP_TYPE;
> +               break;
> +       default:
> +               type = UNKNOWN_TYPE;
> +               break;
> +       }
> +
> +       return type;
> +}
> +EXPORT_SYMBOL_GPL(sprd_pmic_detect_charger_type);
> +
>  static const struct mfd_cell sprd_pmic_devs[] = {
>         {
>                 .name = "sc27xx-wdt",
> @@ -181,6 +232,7 @@ static int sprd_pmic_probe(struct spi_device *spi)
>         spi_set_drvdata(spi, ddata);
>         ddata->dev = &spi->dev;
>         ddata->irq = spi->irq;
> +       ddata->pdata = pdata;
>
>         ddata->irq_chip.name = dev_name(&spi->dev);
>         ddata->irq_chip.status_base =
> diff --git a/include/linux/mfd/sc27xx-pmic.h b/include/linux/mfd/sc27xx-pmic.h
> new file mode 100644
> index 0000000..57e45c0
> --- /dev/null
> +++ b/include/linux/mfd/sc27xx-pmic.h
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __LINUX_MFD_SC27XX_PMIC_H
> +#define __LINUX_MFD_SC27XX_PMIC_H
> +
> +extern enum usb_charger_type sprd_pmic_detect_charger_type(struct device *dev);
> +
> +#endif /* __LINUX_MFD_SC27XX_PMIC_H */
> --
> 1.7.9.5
>
