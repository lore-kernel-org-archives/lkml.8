Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58F7C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:03:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83CCC206E7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 15:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="VzBQm+/N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730169AbgG0PDO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 11:03:14 -0400
Received: from crapouillou.net ([89.234.176.41]:42346 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728933AbgG0PDN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 11:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595862189; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c2+KBusTYw4XXP6S5EXIOXQHYMpCEGdEMNRzuD1vNCo=;
        b=VzBQm+/NpES995TN1e5nncacB0wbVwpubqKxwkqYJu6gNxtybmi3p1cw//Dq18rcHZcRmj
        oxHyNnruVq2kOyqsSjut6H9uTe8EjegtRosiiKs+yTR9/sCO7/i/Kt5X22DEBIYcVHsnqy
        wCYgHjqMKG49UGZS0ZF1y7t3sZzBCVE=
Date:   Mon, 27 Jul 2020 17:02:59 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional
 charger
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>, od@zcrc.me,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <Z4V4EQ.I8UQ5TF3SBJ61@crapouillou.net>
In-Reply-To: <1595828558.23885.90.camel@mhfsdcap03>
References: <20200621224807.882184-1-paul@crapouillou.net>
        <CAHp75VcfhDncqP_hSVvRNc_vY0fOYaoxm-tiCm2G92Xrisb9hA@mail.gmail.com>
        <FPN2EQ.RC89XKRQDKRN3@crapouillou.net>
        <1595828558.23885.90.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le lun. 27 juil. 2020 =E0 13:42, Chunfeng Yun=20
<chunfeng.yun@mediatek.com> a =E9crit :
> On Sun, 2020-07-26 at 12:27 +0200, Paul Cercueil wrote:
>>=20
>>  Le dim. 26 juil. 2020 =E0 13:14, Andy Shevchenko
>>  <andy.shevchenko@gmail.com> a =E9crit :
>>  > On Mon, Jun 22, 2020 at 1:51 AM Paul Cercueil=20
>> <paul@crapouillou.net>
>>  > wrote:
>>  >>
>>  >>  Register a power supply charger, if the Kconfig option
>>  >>  USB_CONN_GPIO_CHARGER is set, whose online state depends on=20
>> whether
>>  >>  the USB role is set to device or not.
>>  >>
>>  >>  This is useful when the USB role is the only way to know if the
>>  >> device
>>  >>  is charging from USB. The API is the standard power supply=20
>> charger
>>  >> API,
>>  >>  you get a /sys/class/power_supply/xxx/online node which tells=20
>> you
>>  >> the
>>  >>  state of the charger.
>>  >>
>>  >>  The sole purpose of this is to give userspace applications a=20
>> way to
>>  >>  know whether or not the charger is plugged.
>>  >
>>  > I'm not sure I understand the purpose of this (third?) way to=20
>> detect
>>  > USB charger and notify user space about.
>>  > Why is extcon not good enough?
>>=20
>>  We can't have extcon and USB role detection at the same time.
>>=20
>>  -Paul
>>=20
>>  >>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  >>  ---
>>  >>   drivers/usb/common/Kconfig         | 11 +++++++
>>  >>   drivers/usb/common/usb-conn-gpio.c | 47
>>  >> ++++++++++++++++++++++++++++++
>>  >>   2 files changed, 58 insertions(+)
>>  >>
>>  >>  diff --git a/drivers/usb/common/Kconfig=20
>> b/drivers/usb/common/Kconfig
>>  >>  index d611477aae41..5405ae96c68f 100644
>>  >>  --- a/drivers/usb/common/Kconfig
>>  >>  +++ b/drivers/usb/common/Kconfig
>>  >>  @@ -49,3 +49,14 @@ config USB_CONN_GPIO
>>  >>
>>  >>            To compile the driver as a module, choose M here: the
>>  >> module will
>>  >>            be called usb-conn-gpio.ko
>>  >>  +
>>  >>  +if USB_CONN_GPIO
>>  >>  +
>>  >>  +config USB_CONN_GPIO_CHARGER
>>  >>  +       bool "USB charger support"
>>  >>  +       select POWER_SUPPLY
>>  >>  +       help
>>  >>  +         Register a charger with the power supply subsystem.=20
>> This
>>  >> will allow
>>  >>  +         userspace to know whether or not the device is=20
>> charging
>>  >> from USB.
>>  >>  +
>>  >>  +endif
>>  >>  diff --git a/drivers/usb/common/usb-conn-gpio.c
>>  >> b/drivers/usb/common/usb-conn-gpio.c
>>  >>  index ed204cbb63ea..129d48db280b 100644
>>  >>  --- a/drivers/usb/common/usb-conn-gpio.c
>>  >>  +++ b/drivers/usb/common/usb-conn-gpio.c
>>  >>  @@ -17,6 +17,7 @@
>>  >>   #include <linux/of.h>
>>  >>   #include <linux/pinctrl/consumer.h>
>>  >>   #include <linux/platform_device.h>
>>  >>  +#include <linux/power_supply.h>
>>  >>   #include <linux/regulator/consumer.h>
>>  >>   #include <linux/usb/role.h>
>>  >>
>>  >>  @@ -38,6 +39,9 @@ struct usb_conn_info {
>>  >>          struct gpio_desc *vbus_gpiod;
>>  >>          int id_irq;
>>  >>          int vbus_irq;
>>  >>  +
>>  >>  +       struct power_supply_desc desc;
>>  >>  +       struct power_supply *charger;
>>  >>   };
>>  >>
>>  >>   /**
>>  >>  @@ -98,6 +102,8 @@ static void usb_conn_detect_cable(struct
>>  >> work_struct *work)
>>  >>                  ret =3D regulator_enable(info->vbus);
>>  >>                  if (ret)
>>  >>                          dev_err(info->dev, "enable vbus=20
>> regulator
>>  >> failed\n");
>>  >>  +       } else if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
>>  >>  +               power_supply_changed(info->charger);
>>  >>          }
>>  >>
>>  >>          info->last_role =3D role;
>>  >>  @@ -121,10 +127,35 @@ static irqreturn_t usb_conn_isr(int irq,=20
>> void
>>  >> *dev_id)
>>  >>          return IRQ_HANDLED;
>>  >>   }
>>  >>
>>  >>  +static enum power_supply_property usb_charger_properties[] =3D {
>>  >>  +       POWER_SUPPLY_PROP_ONLINE,
>>  >>  +};
>>  >>  +
>>  >>  +static int usb_charger_get_property(struct power_supply *psy,
>>  >>  +                                   enum power_supply_property=20
>> psp,
>>  >>  +                                   union power_supply_propval=20
>> *val)
>>  >>  +{
>>  >>  +       struct usb_conn_info *info =3D=20
>> power_supply_get_drvdata(psy);
>>  >>  +
>>  >>  +       switch (psp) {
>>  >>  +       case POWER_SUPPLY_PROP_ONLINE:
>>  >>  +               val->intval =3D info->last_role =3D=3D=20
>> USB_ROLE_DEVICE;
> What will happen if you not change info->last_role here?
> I prefer it's only changed by usb_conn_isr(), if it's changed by other
> drivers, for example, through power_supply_get_property(), may skip=20
> role
> switch.

If you read carefully, info->last_role is not modified here :)

-Paul

>=20
>>  >>  +               break;
>>  >>  +       default:
>>  >>  +               return -EINVAL;
>>  >>  +       }
>>  >>  +
>>  >>  +       return 0;
>>  >>  +}
>>  >>  +
>>  >>   static int usb_conn_probe(struct platform_device *pdev)
>>  >>   {
>>  >>          struct device *dev =3D &pdev->dev;
>>  >>  +       struct power_supply_desc *desc;
>>  >>          struct usb_conn_info *info;
>>  >>  +       struct power_supply_config cfg =3D {
>>  >>  +               .of_node =3D dev->of_node,
>>  >>  +       };
>>  >>          int ret =3D 0;
>>  >>
>>  >>          info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>>  >>  @@ -203,6 +234,22 @@ static int usb_conn_probe(struct
>>  >> platform_device *pdev)
>>  >>                  }
>>  >>          }
>>  >>
>>  >>  +       if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
>>  >>  +               desc =3D &info->desc;
>>  >>  +               desc->name =3D "usb-charger";
>>  >>  +               desc->properties =3D usb_charger_properties;
>>  >>  +               desc->num_properties =3D
>>  >> ARRAY_SIZE(usb_charger_properties);
>>  >>  +               desc->get_property =3D usb_charger_get_property;
>>  >>  +               desc->type =3D POWER_SUPPLY_TYPE_USB;
>>  >>  +               cfg.drv_data =3D info;
>>  >>  +
>>  >>  +               info->charger =3D devm_power_supply_register(dev,
>>  >> desc, &cfg);
>>  >>  +               if (IS_ERR(info->charger)) {
>>  >>  +                       dev_err(dev, "Unable to register
>>  >> charger\n");
>>  >>  +                       return PTR_ERR(info->charger);
>>  >>  +               }
>>  >>  +       }
>>  >>  +
>>  >>          platform_set_drvdata(pdev, info);
>>  >>
>>  >>          /* Perform initial detection */
>>  >>  --
>>  >>  2.27.0
>>  >>
>>  >
>>  >
>>  > --
>>  > With Best Regards,
>>  > Andy Shevchenko
>>=20
>>=20
>=20


