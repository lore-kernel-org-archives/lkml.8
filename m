Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6E93C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC22080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKH6x3Ll"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH0PU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728708AbgH0LdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:33:00 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9982C0611E9;
        Thu, 27 Aug 2020 04:32:48 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x77so1710734lfa.0;
        Thu, 27 Aug 2020 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ltk8RYW7fB/3rKjHI7QhwhhF7KMKnrNNDYrdBd/Av3w=;
        b=hKH6x3LlzVd16ndArlrlEWJPoVHjmylHKxvmOYnAad10oq+3CNtX4UJ33TZ7lxHCQX
         BfSnmaUyHV5igQIFjawpE6obOOwO0houGYv0WG8RFVKTFAzZafpxB9p+RSkpJWPfwmI7
         i0pDuPk+ZG9rIrn/Vlzu7AqWd75wpuk+oc6Mbzxrerlkr/4FQj+979TzObIXS5udvz5y
         o+H6II70NS27EjYCcG6l+bfk4rppGL85L8W/ojYk3E6IAp/Nb89jLmolquaYtfaWDjR+
         Wf23/jHO13mo8lzpun6fwQh0AyNdy56vSfkk6va+vnvnwAJwLPGuBionrZiFCrO0Wtyo
         EThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ltk8RYW7fB/3rKjHI7QhwhhF7KMKnrNNDYrdBd/Av3w=;
        b=Bkb7aSL1mIU5ApK33b/FrPn+z3LVtcFos0/O7jqfobGjE1FN2hIO3ZcvaPxkLHAiaO
         GpqP0Th2DtQDIvK64ar0ILa5CscaWVMTYYrbydSLMJE1KyVfdz/ds6aHpILqGygV4/Nf
         nSbt2yHZzl2spty8q6Bk05KIy38N+wVyf5Ol7vaf3gUJUu/owXhKX/iuk3yiDDNY1FkW
         N+wEA4ZvU6GWEV8WqyF33SHDv7QbGgYvCPSahVbD4JH6w/sSxVXk/OFX0Q4PyDyG1irZ
         rgFgjtWKSv7S1z4wCRby5ifRILChM3FdspCpzDmIq1GRQAip5sgYuMlN4p9VAt9h547J
         T5zQ==
X-Gm-Message-State: AOAM532swCMoUB3R+bwawaSDxVvH/GZNfGMABqjTTBvhdgUxZ1qE0OFx
        C0KIjGy4eR0+CCBBqQLKVhjx+d6cO+TFFp/RoBI=
X-Google-Smtp-Source: ABdhPJyEKh3MhHU7CTZeNdi7xgzQ7+BbUlj8TEH5gU/fzdIE0svGOU8bG8y8/ogaMpKWFPrb01dYSxrYl32LjH+wWqs=
X-Received: by 2002:ac2:4ec4:: with SMTP id p4mr9974945lfr.176.1598527966961;
 Thu, 27 Aug 2020 04:32:46 -0700 (PDT)
MIME-Version: 1.0
References: <1598503859-29620-1-git-send-email-u0084500@gmail.com> <1598515415.21253.22.camel@mhfsdcap03>
In-Reply-To: <1598515415.21253.22.camel@mhfsdcap03>
From:   =?UTF-8?B?5ZWf5Y6f6buD?= <u0084500@gmail.com>
Date:   Thu, 27 Aug 2020 19:32:35 +0800
Message-ID: <CADiBU3_CpOVTWM7JO78=DGw5J_dYNVUK=eH8ywQiMk2Gtk5Bsw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb typec: mt6360: Add support for mt6360 Type-C driver
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
7=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:05=E5=AF=AB=E9=81=93=EF=
=BC=9A
>
> On Thu, 2020-08-27 at 12:50 +0800, cy_huang wrote:
> > From: ChiYuan Huang <cy_huang@richtek.com>
> >
> > Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> > It works with Type-C Port Controller Manager to provide USB PD
> > and USB Type-C functionalities.
> >
> > Add fix to Prevent the race condition from interrupt and tcpci port unr=
egister
> > during module remove.
> >
> > Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> > ---
> >  drivers/usb/typec/tcpm/Kconfig        |   8 ++
> >  drivers/usb/typec/tcpm/Makefile       |   1 +
> >  drivers/usb/typec/tcpm/tcpci_mt6360.c | 213 ++++++++++++++++++++++++++=
++++++++
> Can you avoid using special SoC name in file name?
> It's not clear if you later support new SoC in the driver, e.g. mt63xx?
Okay, I will rename it to mt636x. From our SubPMIC generation,
currently, naming will be 6360/62/67, etc..
From our SOC roadmap, one generation can be used for one to two more years.
I think the name MT636x is enough.
For the next one, I can submit the patch to make it compatible with this dr=
iver.
Thanks for you comment.
>
> >  3 files changed, 222 insertions(+)
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
> > index 00000000..a381b5d
> > --- /dev/null
> > +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> > @@ -0,0 +1,213 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +//
> > +// Copyright (C) 2020 MediaTek Inc.
> > +//
> > +// Author: ChiYuan Huang <cy_huang@richtek.com>
> Use /* */ except SPDX?
Yes, sure.
>
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
> No need add error log, platform_get_irq_byname will print it
I'll remove it in the next revision. Thanks
>
> > +             return mti->irq;
> > +     }
> > +
> > +     mti->tdata.init =3D mt6360_tcpc_init;
> > +     mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata);
> > +     if (IS_ERR_OR_NULL(mti->tcpci)) {
> Use IS_ERR()? it seems not return NULL
> > +             dev_err(&pdev->dev, "Failed to register tcpci port\n");
> > +             return PTR_ERR(mti->tcpci);
> If return NULL, this may return 0?
Remove it later. you're right.
>
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
> need sync?
Yes, sync must be considered to wait interrupt is really finished.
And disable_irq already the sync version.
>
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
