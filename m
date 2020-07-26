Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D28F9C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9CB9206E3
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="yJzkDFXN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgGZK11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:27:27 -0400
Received: from crapouillou.net ([89.234.176.41]:44822 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgGZK11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:27:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1595759245; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fbU+TeK0+GgvvOesLiJ7PCOZj8nQcAuLTnnFTcND9Qo=;
        b=yJzkDFXNIOz//Z48en5ph0zLCiLXWQQ0lwjtPF0dB28wPZmxGb5HGTf1ozlqsnVRlijhKw
        /JBhmCGDpSQSHK2AZvnDYx/Mg5UYl+PIJFc7X5j6iNmzLv9AX4elSDIyZhPjHsB6NxL9TU
        1WDwhTUW6K6hyqI1APOxHwrCM6XnNeQ=
Date:   Sun, 26 Jul 2020 12:27:15 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional
 charger
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <FPN2EQ.RC89XKRQDKRN3@crapouillou.net>
In-Reply-To: <CAHp75VcfhDncqP_hSVvRNc_vY0fOYaoxm-tiCm2G92Xrisb9hA@mail.gmail.com>
References: <20200621224807.882184-1-paul@crapouillou.net>
        <CAHp75VcfhDncqP_hSVvRNc_vY0fOYaoxm-tiCm2G92Xrisb9hA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Le dim. 26 juil. 2020 =E0 13:14, Andy Shevchenko=20
<andy.shevchenko@gmail.com> a =E9crit :
> On Mon, Jun 22, 2020 at 1:51 AM Paul Cercueil <paul@crapouillou.net>=20
> wrote:
>>=20
>>  Register a power supply charger, if the Kconfig option
>>  USB_CONN_GPIO_CHARGER is set, whose online state depends on whether
>>  the USB role is set to device or not.
>>=20
>>  This is useful when the USB role is the only way to know if the=20
>> device
>>  is charging from USB. The API is the standard power supply charger=20
>> API,
>>  you get a /sys/class/power_supply/xxx/online node which tells you=20
>> the
>>  state of the charger.
>>=20
>>  The sole purpose of this is to give userspace applications a way to
>>  know whether or not the charger is plugged.
>=20
> I'm not sure I understand the purpose of this (third?) way to detect
> USB charger and notify user space about.
> Why is extcon not good enough?

We can't have extcon and USB role detection at the same time.

-Paul

>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/usb/common/Kconfig         | 11 +++++++
>>   drivers/usb/common/usb-conn-gpio.c | 47=20
>> ++++++++++++++++++++++++++++++
>>   2 files changed, 58 insertions(+)
>>=20
>>  diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
>>  index d611477aae41..5405ae96c68f 100644
>>  --- a/drivers/usb/common/Kconfig
>>  +++ b/drivers/usb/common/Kconfig
>>  @@ -49,3 +49,14 @@ config USB_CONN_GPIO
>>=20
>>            To compile the driver as a module, choose M here: the=20
>> module will
>>            be called usb-conn-gpio.ko
>>  +
>>  +if USB_CONN_GPIO
>>  +
>>  +config USB_CONN_GPIO_CHARGER
>>  +       bool "USB charger support"
>>  +       select POWER_SUPPLY
>>  +       help
>>  +         Register a charger with the power supply subsystem. This=20
>> will allow
>>  +         userspace to know whether or not the device is charging=20
>> from USB.
>>  +
>>  +endif
>>  diff --git a/drivers/usb/common/usb-conn-gpio.c=20
>> b/drivers/usb/common/usb-conn-gpio.c
>>  index ed204cbb63ea..129d48db280b 100644
>>  --- a/drivers/usb/common/usb-conn-gpio.c
>>  +++ b/drivers/usb/common/usb-conn-gpio.c
>>  @@ -17,6 +17,7 @@
>>   #include <linux/of.h>
>>   #include <linux/pinctrl/consumer.h>
>>   #include <linux/platform_device.h>
>>  +#include <linux/power_supply.h>
>>   #include <linux/regulator/consumer.h>
>>   #include <linux/usb/role.h>
>>=20
>>  @@ -38,6 +39,9 @@ struct usb_conn_info {
>>          struct gpio_desc *vbus_gpiod;
>>          int id_irq;
>>          int vbus_irq;
>>  +
>>  +       struct power_supply_desc desc;
>>  +       struct power_supply *charger;
>>   };
>>=20
>>   /**
>>  @@ -98,6 +102,8 @@ static void usb_conn_detect_cable(struct=20
>> work_struct *work)
>>                  ret =3D regulator_enable(info->vbus);
>>                  if (ret)
>>                          dev_err(info->dev, "enable vbus regulator=20
>> failed\n");
>>  +       } else if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
>>  +               power_supply_changed(info->charger);
>>          }
>>=20
>>          info->last_role =3D role;
>>  @@ -121,10 +127,35 @@ static irqreturn_t usb_conn_isr(int irq, void=20
>> *dev_id)
>>          return IRQ_HANDLED;
>>   }
>>=20
>>  +static enum power_supply_property usb_charger_properties[] =3D {
>>  +       POWER_SUPPLY_PROP_ONLINE,
>>  +};
>>  +
>>  +static int usb_charger_get_property(struct power_supply *psy,
>>  +                                   enum power_supply_property psp,
>>  +                                   union power_supply_propval *val)
>>  +{
>>  +       struct usb_conn_info *info =3D power_supply_get_drvdata(psy);
>>  +
>>  +       switch (psp) {
>>  +       case POWER_SUPPLY_PROP_ONLINE:
>>  +               val->intval =3D info->last_role =3D=3D USB_ROLE_DEVICE;
>>  +               break;
>>  +       default:
>>  +               return -EINVAL;
>>  +       }
>>  +
>>  +       return 0;
>>  +}
>>  +
>>   static int usb_conn_probe(struct platform_device *pdev)
>>   {
>>          struct device *dev =3D &pdev->dev;
>>  +       struct power_supply_desc *desc;
>>          struct usb_conn_info *info;
>>  +       struct power_supply_config cfg =3D {
>>  +               .of_node =3D dev->of_node,
>>  +       };
>>          int ret =3D 0;
>>=20
>>          info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
>>  @@ -203,6 +234,22 @@ static int usb_conn_probe(struct=20
>> platform_device *pdev)
>>                  }
>>          }
>>=20
>>  +       if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
>>  +               desc =3D &info->desc;
>>  +               desc->name =3D "usb-charger";
>>  +               desc->properties =3D usb_charger_properties;
>>  +               desc->num_properties =3D=20
>> ARRAY_SIZE(usb_charger_properties);
>>  +               desc->get_property =3D usb_charger_get_property;
>>  +               desc->type =3D POWER_SUPPLY_TYPE_USB;
>>  +               cfg.drv_data =3D info;
>>  +
>>  +               info->charger =3D devm_power_supply_register(dev,=20
>> desc, &cfg);
>>  +               if (IS_ERR(info->charger)) {
>>  +                       dev_err(dev, "Unable to register=20
>> charger\n");
>>  +                       return PTR_ERR(info->charger);
>>  +               }
>>  +       }
>>  +
>>          platform_set_drvdata(pdev, info);
>>=20
>>          /* Perform initial detection */
>>  --
>>  2.27.0
>>=20
>=20
>=20
> --
> With Best Regards,
> Andy Shevchenko


