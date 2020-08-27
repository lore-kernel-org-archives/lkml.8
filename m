Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B85C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0598A20791
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 00:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCSyDD8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbgH0A7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 20:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgH0A7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 20:59:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5311BC061786;
        Wed, 26 Aug 2020 17:59:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id f26so4475787ljc.8;
        Wed, 26 Aug 2020 17:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=YgOXZpwH0ewXs82/jjLYcaOpq5EI/CmvwmT22mI/C+I=;
        b=CCSyDD8O7rzYso7ZxMulzYe48S5Am/phI+EblCtlKt+rLexTw4fds0VFjNnKnM0e3j
         Dl4C3egtwiHrZAiCIVqfNfJiq2lQIgy6mKMhDZ7tH5lNHVz975QeBczqyf67zJTJ1AEd
         NsyTVyQquWKdsibgKTptCHrI+A3xZlCdjnqgwR+vKxdv4oapWTkuxtVw0XV/wEsCBTNf
         DWQYTlaFfyEfYH7+VDA9/OWhxoJuUgDHAatz2ERh4GM+2G8kUK5oAIgBbzdssv5LhQnQ
         6GhqukSepVgzIEiDMSi7484mWmdx53v9NJMvvwvSeE4s3isAt1w0V/wmikBjcs6DmHfK
         HJ4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=YgOXZpwH0ewXs82/jjLYcaOpq5EI/CmvwmT22mI/C+I=;
        b=KIyGDnBZo3HaQUPbTiwhbRLLUwQvilcPzsX8sROz6XTJWKaNzIzrXNCInBTeIFwjJh
         gRSBrWdmFVy+HwmTHvdIluDWM0WoM9PS2GasXWUUjhwy3ndzbxx69lhCXLlmU9jGxks3
         3ji+s3RerwVnHyxL4KtJuDHtKYgdW4kvYyVgoEPomQQkA4PfHI7iRTo783fLeVqjle8h
         /O39utYx8KYV+8hTe8rf2mntrgHOqiNMm0hWc4IcObO/IFKyN34h4vdn0jiQZs0fQcL6
         Z4NtG/FXfFrMV88H7JrUTMt2k01cvCUerJsvDHcWDgSDNEEfcbT5tHlMzmy4zG3nLw+i
         yZTw==
X-Gm-Message-State: AOAM530YwBAt2Eus8g5SHuRPNhx1hjMU5g6VGYysWAmCkiE7SnF9+KNk
        a4IouJ7kPVAzIvCiIFH6MzXFlGRhFgz9Z8KWeiGlKNaZ+Gg=
X-Google-Smtp-Source: ABdhPJwH0lHwaLAzuFrgZmCUe1ZFD2AyR6rf6tblOaXajPSE84HmKfejrTd84DR4UlFsowLyiTELrWCu0CPcnfYSIgQ=
X-Received: by 2002:a2e:160d:: with SMTP id w13mr8936438ljd.470.1598489974771;
 Wed, 26 Aug 2020 17:59:34 -0700 (PDT)
MIME-Version: 1.0
References: <1598440602-8648-1-git-send-email-u0084500@gmail.com> <a7d1a5d9-97e9-bcf6-23f4-2c4be356913f@roeck-us.net>
In-Reply-To: <a7d1a5d9-97e9-bcf6-23f4-2c4be356913f@roeck-us.net>
From:   =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Date:   Thu, 27 Aug 2020 08:59:23 +0800
Message-ID: <CADiBU3_x5-P8A0erchFpWucX4_R8M01-CdOJv38FjrPGSn+55A@mail.gmail.com>
Subject: Re: [PATCH 1/2] usb typec: mt6360: Add support for mt6360 Type-C driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        cy_huang <cy_huang@richtek.com>, gene_chen@richtek.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Guenter Roeck <linux@roeck-us.net> =E6=96=BC 2020=E5=B9=B48=E6=9C=8827=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=884:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 8/26/20 4:16 AM, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> > It works with Type-C Port Controller Manager to provide USB PD
> > and USB Type-C functionalities.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/usb/typec/tcpm/Kconfig        |   8 ++
> >  drivers/usb/typec/tcpm/Makefile       |   1 +
> >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 212 ++++++++++++++++++++++++++=
++++++++
> >  3 files changed, 221 insertions(+)
> >  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
> >
> > diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kc=
onfig
> > index fa3f393..58a64e1 100644
> > --- a/drivers/usb/typec/tcpm/Kconfig
> > +++ b/drivers/usb/typec/tcpm/Kconfig
> > @@ -27,6 +27,14 @@ config TYPEC_RT1711H
> >         Type-C Port Controller Manager to provide USB PD and USB
> >         Type-C functionalities.
> >
> > +config TYPEC_MT6360
> > +     tristate "Mediatek MT6360 Type-C driver"
> > +     depends on MFD_MT6360
> > +     help
> > +       Mediatek MT6360 is a multi-functional IC that includes
> > +       USB Type-C. It works with Type-C Port Controller Manager
> > +       to provide USB PD and USB Type-C functionalities.
> > +
> >  endif # TYPEC_TCPCI
> >
> >  config TYPEC_FUSB302
> > diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm/M=
akefile
> > index a5ff6c8..7592ccb 100644
> > --- a/drivers/usb/typec/tcpm/Makefile
> > +++ b/drivers/usb/typec/tcpm/Makefile
> > @@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_WCOVE)     +=3D typec_wcove.o
> >  typec_wcove-y                        :=3D wcove.o
> >  obj-$(CONFIG_TYPEC_TCPCI)    +=3D tcpci.o
> >  obj-$(CONFIG_TYPEC_RT1711H)  +=3D tcpci_rt1711h.o
> > +obj-$(CONFIG_TYPEC_MT6360)   +=3D tcpci_mt6360.o
> > diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/typec/=
tcpm/tcpci_mt6360.c
> > new file mode 100644
> > index 00000000..6a28193
> > --- /dev/null
> > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > @@ -0,0 +1,212 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Copyright (C) 2020 MediaTek Inc.
> > +//
> > +// Author: ChiYuan Huang <cy_huang@richtek.com>
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/usb/tcpm.h>
>
> Is that needed ?
Ah, sorry, for some testing, I forget to remove it.
>
> > +
> > +#include "tcpci.h"
> > +
> > +#define MT6360_REG_VCONNCTRL1        0x8C
> > +#define MT6360_REG_MODECTRL2 0x8F
> > +#define MT6360_REG_SWRESET   0xA0
> > +#define MT6360_REG_DEBCTRL1  0xA1
> > +#define MT6360_REG_DRPCTRL1  0xA2
> > +#define MT6360_REG_DRPCTRL2  0xA3
> > +#define MT6360_REG_I2CTORST  0xBF
> > +#define MT6360_REG_RXCTRL2   0xCF
> > +#define MT6360_REG_CTDCTRL2  0xEC
> > +
> > +/* MT6360_REG_VCONNCTRL1 */
> > +#define MT6360_VCONNCL_ENABLE        BIT(0)
> > +/* MT6360_REG_RXCTRL2 */
> > +#define MT6360_OPEN40M_ENABLE        BIT(7)
> > +/* MT6360_REG_CTDCTRL2 */
> > +#define MT6360_RPONESHOT_ENABLE      BIT(6)
> > +
> > +struct mt6360_tcpc_info {
> > +     struct tcpci_data tdata;
> > +     struct tcpci *tcpci;
> > +     struct device *dev;
> > +     int irq;
> > +};
> > +
> > +static inline int mt6360_tcpc_read16(struct regmap *regmap,
> > +                                  unsigned int reg, u16 *val)
> > +{
> > +     return regmap_raw_read(regmap, reg, val, sizeof(u16));
> > +}
> > +
> > +static inline int mt6360_tcpc_write16(struct regmap *regmap,
> > +                                   unsigned int reg, u16 val)
> > +{
> > +     return regmap_raw_write(regmap, reg, &val, sizeof(u16));
> > +}
> > +
> > +static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *td=
ata)
> > +{
> > +     struct regmap *regmap =3D tdata->regmap;
> > +     int ret;
> > +
> > +     ret =3D regmap_write(regmap, MT6360_REG_SWRESET, 0x01);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* after reset command, wait 1~2ms to wait IC action */
> > +     usleep_range(1000, 2000);
> > +
> > +     /* write all alert to masked */
> > +     ret =3D mt6360_tcpc_write16(regmap, TCPC_ALERT_MASK, 0);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* config I2C timeout reset enable , and timeout to 200ms */
> > +     ret =3D regmap_write(regmap, MT6360_REG_I2CTORST, 0x8F);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* config CC Detect Debounce : 26.7*val us */
> > +     ret =3D regmap_write(regmap, MT6360_REG_DEBCTRL1, 0x10);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* DRP Toggle Cycle : 51.2 + 6.4*val ms */
> > +     ret =3D regmap_write(regmap, MT6360_REG_DRPCTRL1, 4);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* DRP Duyt Ctrl : dcSRC: /1024 */
> > +     ret =3D mt6360_tcpc_write16(regmap, MT6360_REG_DRPCTRL2, 330);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enable VCONN Current Limit function */
> > +     ret =3D regmap_update_bits(regmap, MT6360_REG_VCONNCTRL1, MT6360_=
VCONNCL_ENABLE,
> > +                              MT6360_VCONNCL_ENABLE);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enable cc open 40ms when pmic send vsysuv signal */
> > +     ret =3D regmap_update_bits(regmap, MT6360_REG_RXCTRL2, MT6360_OPE=
N40M_ENABLE,
> > +                              MT6360_OPEN40M_ENABLE);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Enable Rpdet oneshot detection */
> > +     ret =3D regmap_update_bits(regmap, MT6360_REG_CTDCTRL2, MT6360_RP=
ONESHOT_ENABLE,
> > +                              MT6360_RPONESHOT_ENABLE);
> > +     if (ret)
> > +             return ret;
> > +
> > +     /* Set shipping mode off, AUTOIDLE on */
> > +     return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
> > +}
> > +
> > +static irqreturn_t mt6360_irq(int irq, void *dev_id)
> > +{
> > +     struct mt6360_tcpc_info *mti =3D dev_id;
> > +
> > +     return tcpci_irq(mti->tcpci);
> > +}
> > +
> > +static int mt6360_tcpc_probe(struct platform_device *pdev)
> > +{
> > +     struct mt6360_tcpc_info *mti;
> > +     int ret;
> > +
> > +     mti =3D devm_kzalloc(&pdev->dev, sizeof(*mti), GFP_KERNEL);
> > +     if (!mti)
> > +             return -ENOMEM;
> > +
> > +     mti->dev =3D &pdev->dev;
> > +
> > +     mti->tdata.regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> > +     if (!mti->tdata.regmap) {
> > +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
> > +             return -ENODEV;
> > +     }
> > +
> > +     mti->irq =3D platform_get_irq_byname(pdev, "PD_IRQB");
> > +     if (mti->irq < 0) {
> > +             dev_err(&pdev->dev, "Failed to get PD_IRQB irq\n");
> > +             return mti->irq;
> > +     }
> > +
> > +     mti->tdata.init =3D mt6360_tcpc_init;
> > +     mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata);
> > +     if (IS_ERR_OR_NULL(mti->tcpci)) {
> > +             dev_err(&pdev->dev, "Failed to register tcpci port\n");
> > +             return PTR_ERR(mti->tcpci);
> > +     }
> > +
> > +     ret =3D devm_request_threaded_irq(mti->dev, mti->irq, NULL, mt636=
0_irq, IRQF_ONESHOT,
> > +                                     dev_name(&pdev->dev), mti);
> > +     if (ret) {
> > +             dev_err(mti->dev, "Failed to register irq\n");
> > +             tcpci_unregister_port(mti->tcpci);
> > +             return ret;
> > +     }
> > +
> > +     device_init_wakeup(&pdev->dev, true);
> > +     platform_set_drvdata(pdev, mti);
> > +
> > +     return 0;
> > +}
> > +
> > +static int mt6360_tcpc_remove(struct platform_device *pdev)
> > +{
> > +     struct mt6360_tcpc_info *mti =3D platform_get_drvdata(pdev);
> > +
> > +     tcpci_unregister_port(mti->tcpci);
>
> That leaves interrupts enabled, which might be racy
> because interrupts are still enabled here.
M..., yes, it will cause the race condition during module remove.
I'll add disable_irq before tcpci unregister to prevent it.
>
> Guenter
>
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused mt6360_tcpc_suspend(struct device *dev)
> > +{
> > +     struct mt6360_tcpc_info *mti =3D dev_get_drvdata(dev);> +
> > +     if (device_may_wakeup(dev))
> > +             enable_irq_wake(mti->irq);
> > +
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused mt6360_tcpc_resume(struct device *dev)
> > +{
> > +     struct mt6360_tcpc_info *mti =3D dev_get_drvdata(dev);
> > +
> > +     if (device_may_wakeup(dev))
> > +             disable_irq_wake(mti->irq);
> > +
> > +     return 0;
> > +}
> > +
> > +static SIMPLE_DEV_PM_OPS(mt6360_tcpc_pm_ops, mt6360_tcpc_suspend, mt63=
60_tcpc_resume);
> > +
> > +static const struct of_device_id __maybe_unused mt6360_tcpc_of_id[] =
=3D {
> > +     { .compatible =3D "mediatek,mt6360-tcpc", },
> > +     {},
> > +};
> > +MODULE_DEVICE_TABLE(of, mt6360_tcpc_of_id);
> > +
> > +static struct platform_driver mt6360_tcpc_driver =3D {
> > +     .driver =3D {
> > +             .name =3D "mt6360-tcpc",
> > +             .pm =3D &mt6360_tcpc_pm_ops,
> > +             .of_match_table =3D mt6360_tcpc_of_id,
> > +     },
> > +     .probe =3D mt6360_tcpc_probe,
> > +     .remove =3D mt6360_tcpc_remove,
> > +};
> > +module_platform_driver(mt6360_tcpc_driver);
> > +
> > +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> > +MODULE_DESCRIPTION("MT6360 USB Type-C Port Controller Interface Driver=
");
> > +MODULE_LICENSE("GPL v2");
> >
>
