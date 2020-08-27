Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AEB9C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:39:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C55482177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bbt9yLuE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbgH0OjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgH0Ofc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:35:32 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25257C061264;
        Thu, 27 Aug 2020 07:34:53 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id r13so3268903ljm.0;
        Thu, 27 Aug 2020 07:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ZJJdMtKCLxGo8D2hkbWaTXNBRDz7FggUEnUd/B2P4Wg=;
        b=Bbt9yLuEJri6HRaGza5sTdUvhUxU4JLbGdGfstozdYaR5eMKtLxSJNVYFe5ydQ2e/k
         jlh9VeH1zqV2hEcjLmKeS++LfZRqqMe25rCZOzzxYeQhZViMgmPSCX6wqJjo+OSn8awM
         Nbt8icPtCzhJVde1A+WoSYVmxyBQEmvZWEdEOQJ26Qd22EoS0SgwHQ5AxtRZ4Ygjax9U
         xC7sPuvHo75fWWV8EvFHGmhVrCL00T0wfNfBJe3LUX/Jd+OwFGdO8QWO5Ggjhr6cUv1E
         cKZ3yo1mjhaNY7INuoi3+AUFJM3KqXpT0MR/l1lrDmmAjjFeUqbItSG6EikvG6Wb+KDI
         QszQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ZJJdMtKCLxGo8D2hkbWaTXNBRDz7FggUEnUd/B2P4Wg=;
        b=TD0p3dJyeWDEJ+72Ku3lKL8jWH2yetEY7tsC7Lmulz8QSmqOFwPHsXBgeIc+1ajIWK
         sTDNy2uoLZymxgTQlqOOpPgdF6Hhkqdh4fjWSe8P/ctQtVnQ9aT9h2trRCoUj/OIpGwZ
         o6jmmS/lpicQuWvT1JagTqz1DP1SM3agZRSXyLvOljDG03NJbk9smxX/lj/WgI8/cWDy
         aWH2kKDzEo7C3oQ5oX4K3qeHXVqrYCPkxr0utKgHXK+5BGukLz71GdTLt1Sm2PxLNp7u
         ARVTPooU/YMKnhlT+O9Nl30V3Nan8q3XxlkD/fBX4+IaT9Hby6hrCa1aAp5NlwMdGq9I
         zFUw==
X-Gm-Message-State: AOAM532C68rsieGExop0t4Zl8KNtmKMv7p99Af+UWqF4XEjaUuEg9eeU
        9TAvlaoYUkwEOz9VZ2m4AqoPaCilP7BX6JLlDRU=
X-Google-Smtp-Source: ABdhPJz1s3DLsMxltRWtfx2IxR+OYGag9+HPAkEZjJ+JvWQ3TyWlqD3BmrVX649SC+S58I1Q9iBUvpmZuhJANEMmAro=
X-Received: by 2002:a2e:a497:: with SMTP id h23mr9487516lji.154.1598538891356;
 Thu, 27 Aug 2020 07:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <1598503859-29620-1-git-send-email-u0084500@gmail.com>
 <1598515415.21253.22.camel@mhfsdcap03> <CADiBU3_CpOVTWM7JO78=DGw5J_dYNVUK=eH8ywQiMk2Gtk5Bsw@mail.gmail.com>
 <283c9452-996d-d1ce-90a0-28fbd55c291d@roeck-us.net>
In-Reply-To: <283c9452-996d-d1ce-90a0-28fbd55c291d@roeck-us.net>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Thu, 27 Aug 2020 22:34:39 +0800
Message-ID: <CADiBU39L+zxhMa+Vam8S=j6zSROOebUDGn7dh9v6cbpqqFj3hQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] usb typec: mt6360: Add support for mt6360 Type-C driver
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg KH <gregkh@linuxfoundation.org>, robh+dt@kernel.org,
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
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=889:46=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On 8/27/20 4:32 AM, =E5=95=9F=E5=8E=9F=E9=BB=83 wrote:
> > Chunfeng Yun <chunfeng.yun@mediatek.com> =E6=96=BC 2020=E5=B9=B48=E6=9C=
=8827=E6=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=884:05=E5=AF=AB=E9=81=93=
=EF=BC=9A
> >>
> >> On Thu, 2020-08-27 at 12:50 +0800, cy_huang wrote:
> >>> From: ChiYuan Huang <cy_huang@richtek.com>
> >>>
> >>> Mediatek MT6360 is a multi-functional IC that includes USB Type-C.
> >>> It works with Type-C Port Controller Manager to provide USB PD
> >>> and USB Type-C functionalities.
> >>>
> >>> Add fix to Prevent the race condition from interrupt and tcpci port u=
nregister
> >>> during module remove.
> >>>
> >>> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> >>> ---
> >>>  drivers/usb/typec/tcpm/Kconfig        |   8 ++
> >>>  drivers/usb/typec/tcpm/Makefile       |   1 +
> >>>  drivers/usb/typec/tcpm/tcpci_mt6360.c | 213 ++++++++++++++++++++++++=
++++++++++
> >> Can you avoid using special SoC name in file name?
> >> It's not clear if you later support new SoC in the driver, e.g. mt63xx=
?
> > Okay, I will rename it to mt636x. From our SubPMIC generation,
> > currently, naming will be 6360/62/67, etc..
>
> What if 6361 or 6365 or 6369 will require a different driver ?
> What if 6371 will, in the future, be supported by the same driver ?
> Or, for that matter, 7360 ? 6537 ?
>
> We usually try to avoid "x" in driver names because it can never be
> guaranteed that it will apply to x=3D{0..9}. The current file name is
> just fine; it is customary to name drivers after the first chip they
> support.
>
> Guenter

Thanks. it means the current file name and description is okay....
I'll start to revert the rename work.
>
> >>From our SOC roadmap, one generation can be used for one to two more ye=
ars.
> > I think the name MT636x is enough.
> > For the next one, I can submit the patch to make it compatible with thi=
s driver.
> > Thanks for you comment.
> >>
> >>>  3 files changed, 222 insertions(+)
> >>>  create mode 100644 drivers/usb/typec/tcpm/tcpci_mt6360.c
> >>>
> >>> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/=
Kconfig
> >>> index fa3f393..58a64e1 100644
> >>> --- a/drivers/usb/typec/tcpm/Kconfig
> >>> +++ b/drivers/usb/typec/tcpm/Kconfig
> >>> @@ -27,6 +27,14 @@ config TYPEC_RT1711H
> >>>         Type-C Port Controller Manager to provide USB PD and USB
> >>>         Type-C functionalities.
> >>>
> >>> +config TYPEC_MT6360
> >>> +     tristate "Mediatek MT6360 Type-C driver"
> >>> +     depends on MFD_MT6360
> >>> +     help
> >>> +       Mediatek MT6360 is a multi-functional IC that includes
> >>> +       USB Type-C. It works with Type-C Port Controller Manager
> >>> +       to provide USB PD and USB Type-C functionalities.
> >>> +
> >>>  endif # TYPEC_TCPCI
> >>>
> >>>  config TYPEC_FUSB302
> >>> diff --git a/drivers/usb/typec/tcpm/Makefile b/drivers/usb/typec/tcpm=
/Makefile
> >>> index a5ff6c8..7592ccb 100644
> >>> --- a/drivers/usb/typec/tcpm/Makefile
> >>> +++ b/drivers/usb/typec/tcpm/Makefile
> >>> @@ -5,3 +5,4 @@ obj-$(CONFIG_TYPEC_WCOVE)     +=3D typec_wcove.o
> >>>  typec_wcove-y                        :=3D wcove.o
> >>>  obj-$(CONFIG_TYPEC_TCPCI)    +=3D tcpci.o
> >>>  obj-$(CONFIG_TYPEC_RT1711H)  +=3D tcpci_rt1711h.o
> >>> +obj-$(CONFIG_TYPEC_MT6360)   +=3D tcpci_mt6360.o
> >>> diff --git a/drivers/usb/typec/tcpm/tcpci_mt6360.c b/drivers/usb/type=
c/tcpm/tcpci_mt6360.c
> >>> new file mode 100644
> >>> index 00000000..a381b5d
> >>> --- /dev/null
> >>> +++ b/drivers/usb/typec/tcpm/tcpci_mt6360.c
> >>> @@ -0,0 +1,213 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-only
> >>> +//
> >>> +// Copyright (C) 2020 MediaTek Inc.
> >>> +//
> >>> +// Author: ChiYuan Huang <cy_huang@richtek.com>
> >> Use /* */ except SPDX?
> > Yes, sure.
> >>
> >>> +
> >>> +#include <linux/interrupt.h>
> >>> +#include <linux/kernel.h>
> >>> +#include <linux/module.h>
> >>> +#include <linux/of.h>
> >>> +#include <linux/platform_device.h>
> >>> +#include <linux/regmap.h>
> >>> +#include <linux/usb/tcpm.h>
> >>> +
> >>> +#include "tcpci.h"
> >>> +
> >>> +#define MT6360_REG_VCONNCTRL1        0x8C
> >>> +#define MT6360_REG_MODECTRL2 0x8F
> >>> +#define MT6360_REG_SWRESET   0xA0
> >>> +#define MT6360_REG_DEBCTRL1  0xA1
> >>> +#define MT6360_REG_DRPCTRL1  0xA2
> >>> +#define MT6360_REG_DRPCTRL2  0xA3
> >>> +#define MT6360_REG_I2CTORST  0xBF
> >>> +#define MT6360_REG_RXCTRL2   0xCF
> >>> +#define MT6360_REG_CTDCTRL2  0xEC
> >>> +
> >>> +/* MT6360_REG_VCONNCTRL1 */
> >>> +#define MT6360_VCONNCL_ENABLE        BIT(0)
> >>> +/* MT6360_REG_RXCTRL2 */
> >>> +#define MT6360_OPEN40M_ENABLE        BIT(7)
> >>> +/* MT6360_REG_CTDCTRL2 */
> >>> +#define MT6360_RPONESHOT_ENABLE      BIT(6)
> >>> +
> >>> +struct mt6360_tcpc_info {
> >>> +     struct tcpci_data tdata;
> >>> +     struct tcpci *tcpci;
> >>> +     struct device *dev;
> >>> +     int irq;
> >>> +};
> >>> +
> >>> +static inline int mt6360_tcpc_read16(struct regmap *regmap,
> >>> +                                  unsigned int reg, u16 *val)
> >>> +{
> >>> +     return regmap_raw_read(regmap, reg, val, sizeof(u16));
> >>> +}
> >>> +
> >>> +static inline int mt6360_tcpc_write16(struct regmap *regmap,
> >>> +                                   unsigned int reg, u16 val)
> >>> +{
> >>> +     return regmap_raw_write(regmap, reg, &val, sizeof(u16));
> >>> +}
> >>> +
> >>> +static int mt6360_tcpc_init(struct tcpci *tcpci, struct tcpci_data *=
tdata)
> >>> +{
> >>> +     struct regmap *regmap =3D tdata->regmap;
> >>> +     int ret;
> >>> +
> >>> +     ret =3D regmap_write(regmap, MT6360_REG_SWRESET, 0x01);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* after reset command, wait 1~2ms to wait IC action */
> >>> +     usleep_range(1000, 2000);
> >>> +
> >>> +     /* write all alert to masked */
> >>> +     ret =3D mt6360_tcpc_write16(regmap, TCPC_ALERT_MASK, 0);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* config I2C timeout reset enable , and timeout to 200ms */
> >>> +     ret =3D regmap_write(regmap, MT6360_REG_I2CTORST, 0x8F);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* config CC Detect Debounce : 26.7*val us */
> >>> +     ret =3D regmap_write(regmap, MT6360_REG_DEBCTRL1, 0x10);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* DRP Toggle Cycle : 51.2 + 6.4*val ms */
> >>> +     ret =3D regmap_write(regmap, MT6360_REG_DRPCTRL1, 4);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* DRP Duyt Ctrl : dcSRC: /1024 */
> >>> +     ret =3D mt6360_tcpc_write16(regmap, MT6360_REG_DRPCTRL2, 330);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* Enable VCONN Current Limit function */
> >>> +     ret =3D regmap_update_bits(regmap, MT6360_REG_VCONNCTRL1, MT636=
0_VCONNCL_ENABLE,
> >>> +                              MT6360_VCONNCL_ENABLE);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* Enable cc open 40ms when pmic send vsysuv signal */
> >>> +     ret =3D regmap_update_bits(regmap, MT6360_REG_RXCTRL2, MT6360_O=
PEN40M_ENABLE,
> >>> +                              MT6360_OPEN40M_ENABLE);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* Enable Rpdet oneshot detection */
> >>> +     ret =3D regmap_update_bits(regmap, MT6360_REG_CTDCTRL2, MT6360_=
RPONESHOT_ENABLE,
> >>> +                              MT6360_RPONESHOT_ENABLE);
> >>> +     if (ret)
> >>> +             return ret;
> >>> +
> >>> +     /* Set shipping mode off, AUTOIDLE on */
> >>> +     return regmap_write(regmap, MT6360_REG_MODECTRL2, 0x7A);
> >>> +}
> >>> +
> >>> +static irqreturn_t mt6360_irq(int irq, void *dev_id)
> >>> +{
> >>> +     struct mt6360_tcpc_info *mti =3D dev_id;
> >>> +
> >>> +     return tcpci_irq(mti->tcpci);
> >>> +}
> >>> +
> >>> +static int mt6360_tcpc_probe(struct platform_device *pdev)
> >>> +{
> >>> +     struct mt6360_tcpc_info *mti;
> >>> +     int ret;
> >>> +
> >>> +     mti =3D devm_kzalloc(&pdev->dev, sizeof(*mti), GFP_KERNEL);
> >>> +     if (!mti)
> >>> +             return -ENOMEM;
> >>> +
> >>> +     mti->dev =3D &pdev->dev;
> >>> +
> >>> +     mti->tdata.regmap =3D dev_get_regmap(pdev->dev.parent, NULL);
> >>> +     if (!mti->tdata.regmap) {
> >>> +             dev_err(&pdev->dev, "Failed to get parent regmap\n");
> >>> +             return -ENODEV;
> >>> +     }
> >>> +
> >>> +     mti->irq =3D platform_get_irq_byname(pdev, "PD_IRQB");
> >>> +     if (mti->irq < 0) {
> >>> +             dev_err(&pdev->dev, "Failed to get PD_IRQB irq\n");
> >> No need add error log, platform_get_irq_byname will print it
> > I'll remove it in the next revision. Thanks
> >>
> >>> +             return mti->irq;
> >>> +     }
> >>> +
> >>> +     mti->tdata.init =3D mt6360_tcpc_init;
> >>> +     mti->tcpci =3D tcpci_register_port(&pdev->dev, &mti->tdata);
> >>> +     if (IS_ERR_OR_NULL(mti->tcpci)) {
> >> Use IS_ERR()? it seems not return NULL
> >>> +             dev_err(&pdev->dev, "Failed to register tcpci port\n");
> >>> +             return PTR_ERR(mti->tcpci);
> >> If return NULL, this may return 0?
> > Remove it later. you're right.
> >>
> >>> +     }
> >>> +
> >>> +     ret =3D devm_request_threaded_irq(mti->dev, mti->irq, NULL, mt6=
360_irq, IRQF_ONESHOT,
> >>> +                                     dev_name(&pdev->dev), mti);
> >>> +     if (ret) {
> >>> +             dev_err(mti->dev, "Failed to register irq\n");
> >>> +             tcpci_unregister_port(mti->tcpci);
> >>> +             return ret;
> >>> +     }
> >>> +
> >>> +     device_init_wakeup(&pdev->dev, true);
> >>> +     platform_set_drvdata(pdev, mti);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int mt6360_tcpc_remove(struct platform_device *pdev)
> >>> +{
> >>> +     struct mt6360_tcpc_info *mti =3D platform_get_drvdata(pdev);
> >>> +
> >>> +     disable_irq(mti->irq);
> >> need sync?
> > Yes, sync must be considered to wait interrupt is really finished.
> > And disable_irq already the sync version.
> >>
> >>> +     tcpci_unregister_port(mti->tcpci);
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int __maybe_unused mt6360_tcpc_suspend(struct device *dev)
> >>> +{
> >>> +     struct mt6360_tcpc_info *mti =3D dev_get_drvdata(dev);
> >>> +
> >>> +     if (device_may_wakeup(dev))
> >>> +             enable_irq_wake(mti->irq);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static int __maybe_unused mt6360_tcpc_resume(struct device *dev)
> >>> +{
> >>> +     struct mt6360_tcpc_info *mti =3D dev_get_drvdata(dev);
> >>> +
> >>> +     if (device_may_wakeup(dev))
> >>> +             disable_irq_wake(mti->irq);
> >>> +
> >>> +     return 0;
> >>> +}
> >>> +
> >>> +static SIMPLE_DEV_PM_OPS(mt6360_tcpc_pm_ops, mt6360_tcpc_suspend, mt=
6360_tcpc_resume);
> >>> +
> >>> +static const struct of_device_id __maybe_unused mt6360_tcpc_of_id[] =
=3D {
> >>> +     { .compatible =3D "mediatek,mt6360-tcpc", },
> >>> +     {},
> >>> +};
> >>> +MODULE_DEVICE_TABLE(of, mt6360_tcpc_of_id);
> >>> +
> >>> +static struct platform_driver mt6360_tcpc_driver =3D {
> >>> +     .driver =3D {
> >>> +             .name =3D "mt6360-tcpc",
> >>> +             .pm =3D &mt6360_tcpc_pm_ops,
> >>> +             .of_match_table =3D mt6360_tcpc_of_id,
> >>> +     },
> >>> +     .probe =3D mt6360_tcpc_probe,
> >>> +     .remove =3D mt6360_tcpc_remove,
> >>> +};
> >>> +module_platform_driver(mt6360_tcpc_driver);
> >>> +
> >>> +MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
> >>> +MODULE_DESCRIPTION("MT6360 USB Type-C Port Controller Interface Driv=
er");
> >>> +MODULE_LICENSE("GPL v2");
> >>
>
