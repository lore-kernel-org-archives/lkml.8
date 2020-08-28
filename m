Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68223C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25BEC20639
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 14:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5nAhCf9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgH1Odx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 10:33:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbgH1Odv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 10:33:51 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81B4BC061264;
        Fri, 28 Aug 2020 07:33:50 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r13so1573407ljm.0;
        Fri, 28 Aug 2020 07:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OCikJRMTs4xsn1R4s14WoPrXml08NXG0b5Xs1oTpCvk=;
        b=A5nAhCf90mZbfJdZlIVtVQ+y7WWm+/NtA61wl7Hodw73kgbF6TWjkKQWH6n+CSZIZb
         oM+wEFw4w7Dnr/CckRoQug6x4UQD573x6/6U2MlefE9nGjgx0ItXFjnE3s8RhIMYiDe3
         Ovf8wWfOWD32buNTOyb2D3varTj3CEiD+xXb7LtsRFvceLvLRaQGRP/KRgfYneZNOZUW
         x5Y+m0a5RTOPVJy+fLz5rYytMWYwEKpVDRJdxgzHPy/n+4D0HC1NQ0ZcNcj7oR6SH5Tj
         JcTvqWdsa1jPWc54Wm7g+HzO36HyrXT8bwEUIFjgbDCqulRkfNB4DC1Um6TshhxornlB
         l3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OCikJRMTs4xsn1R4s14WoPrXml08NXG0b5Xs1oTpCvk=;
        b=N/WdxXR55NbDXMy+ZKqs+StN60qMmyo4p+1wQX2+KXn9pBd8luEfN8R3khDB9+cPsI
         u783MAhDX+VXXRzUT2awajya2BGV5THLT83KVcSIRnEU6WoUSqLD9kDq7bnnMqkiDqt8
         hmg34OTEa9aI4XlEQjKXMWwlOicSNREc6qGGHRwWSy/QgzKZcqYmSSFlJAn4JZrwVZEy
         TUokBp//maN2arlDKNBD282mj6D7yjuhNILZWlRpBuqHNehv6Slz75FAp9IBrad4vXtW
         BQ6ykPtAfUIcy3n4x9uKQoinWFcjJceqg329mvrJvuTFqbJ+lNoxTAH/SjJC40F+hra6
         1c3g==
X-Gm-Message-State: AOAM530YO1/khuhsVBWV7GKuX4nQt5XlM3Nejt4UG4QFrSexcb5vhvvG
        c5m2qRc5dmygGEBCw/c7I2gBcFWI2facOWmSDxs=
X-Google-Smtp-Source: ABdhPJw7pZiInBPe8b6WeWZyBNvaEr5FADjE8R7f+kAvMeFfkb2nMOcQ5nwsCVU1i/Kt9Q7ALooMDUFUYCEIoY6icTQ=
X-Received: by 2002:a2e:9b08:: with SMTP id u8mr967908lji.208.1598625228693;
 Fri, 28 Aug 2020 07:33:48 -0700 (PDT)
MIME-Version: 1.0
References: <1598527137-6915-1-git-send-email-u0084500@gmail.com> <1598616616.7054.3.camel@mhfsdcap03>
In-Reply-To: <1598616616.7054.3.camel@mhfsdcap03>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Fri, 28 Aug 2020 22:33:36 +0800
Message-ID: <CADiBU3_-Jvk8ORu1MxrccJkdK0_1WdH4Yd8AR-cGyDMEA3Htpw@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] usb typec: mt6360: Add support for mt6360 Type-C driver
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
        matthias.bgg@gmail.com, Guenter Roeck <linux@roeck-us.net>,
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

Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=882=
8=E6=97=A5 =E9=80=B1=E4=BA=94 =E4=B8=8B=E5=8D=888:11=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, 2020-08-27 at 19:18 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> > It works with Type-C Port Controller Manager to provide USB PD
> > and USB Type-C functionalities.
> >
> > v1 to v2
> > 1. Add fix to Prevent the race condition from interrupt and tcpci port
> > unregister during module remove.
> >
> > v2 to v3
> > 1. Change comment style for the head of source code.
> > 2. No need to print error for platform_get_irq_byname.
> > 3. Fix tcpci_register_port check from IS_ERR_OR_NULL to IS_ERR.
> > 4. Rename driver/Kconfig/Makefile form mt6360 to mt636x.
> > 5. Rename DT binding documents from mt6360 to mt636x.
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
> > index 00000000..f1bd9e0
> > --- /dev/null
> > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > @@ -0,0 +1,212 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 MediaTek Inc.
> > + *
> > + * Author: ChiYuan Huang <cy_huang@richtek.com>
> > + */
> > +
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/usb/tcpm.h>
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
> Wonder why access some register by 2bytes, and others 4bytes?
> can we access them all by 4bytes?

Actually, the access bus is still I2C.
Each register is still one byte only.
Register address like as TCPC_ALERT_MASK are continuous two byte used
as IRQ MASK.
That's why it's used wirte16 function to access.

Actually, you also can divided into two bytes write into one byte
access by two times.
For I2C bus efficiency, it seems bad.
>
>
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
> Use lowercase letters for irq name?

PD_IRQB is defined in MT6360 pinout. The datasheet is also labeled as PD_IR=
QB.
My thinking is to keep the pinout name like as the datasheet defined.
B means bar to be identified the pin is active low.
>
> > +     if (mti->irq < 0)
> > +             return mti->irq;
> > +
> > +     mti->tdata.init =3D mt6360_tcpc_init;
> > +     mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata);
> > +     if (IS_ERR(mti->tcpci)) {
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
> > +     disable_irq(mti->irq);
> > +     tcpci_unregister_port(mti->tcpci);
> > +     return 0;
> > +}
> > +
> > +static int __maybe_unused mt6360_tcpc_suspend(struct device *dev)
> > +{
> > +     struct mt6360_tcpc_info *mti =3D dev_get_drvdata(dev);
> > +
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
>
