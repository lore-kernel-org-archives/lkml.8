Return-Path: <SRS0=AKQz=7N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3048C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 15:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B8B20801
	for <linux-kernel@archiver.kernel.org>; Sun, 31 May 2020 15:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="foHofBbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgEaPMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 May 2020 11:12:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:60380 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727781AbgEaPMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 May 2020 11:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1590937939; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kymWIUWItlhHLWKPhKukKuKsgfUgf420g1O8R+PnZoQ=;
        b=foHofBbV4GnKB5b+ecDB5jldLR80OSvOFXdbFImRxCrZHr5NhXu4OK8o/d08EHG+AiJ7YR
        AULi5EEQUl6sUt6vP0gGR1RlSI6WmWeFzu9H/PLd509/4RbZZba7Syl0PoEz14iKtZP80c
        G22y3JdVvCNq1HYZTduKSa8SRZrh0pg=
Date:   Sun, 31 May 2020 17:12:09 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH] usb: common: usb-conn-gpio: Register optional charger
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <9KB7BQ.BH9P6TT11PEH2@crapouillou.net>
In-Reply-To: <20200413122543.73846-1-paul@crapouillou.net>
References: <20200413122543.73846-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any feedback on this patch?

Cheers,
-Paul


Le lun. 13 avril 2020 =E0 14:25, Paul Cercueil <paul@crapouillou.net> a=20
=E9crit :
> Register a power supply charger, if the Kconfig option
> USB_CONN_GPIO_CHARGER is set, whose online state depends on whether
> the USB role is set to device or not.
>=20
> This is useful when the USB role is the only way to know if the device
> is charging from USB. The API is the standard power supply charger=20
> API,
> you get a /sys/class/power_supply/xxx/online node which tells you the
> state of the charger.
>=20
> The sole purpose of this is to give userspace applications a way to
> know whether or not the charger is plugged.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>=20
> Notes:
>     v2: - improve commit message... explain why we want a charger
>         - compile charger code only if CONFIG_USB_CONN_GPIO_CHARGER
>     	  is set
>=20
>  drivers/usb/common/Kconfig         | 11 +++++++
>  drivers/usb/common/usb-conn-gpio.c | 47=20
> ++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>=20
> diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
> index d611477aae41..5405ae96c68f 100644
> --- a/drivers/usb/common/Kconfig
> +++ b/drivers/usb/common/Kconfig
> @@ -49,3 +49,14 @@ config USB_CONN_GPIO
>=20
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called usb-conn-gpio.ko
> +
> +if USB_CONN_GPIO
> +
> +config USB_CONN_GPIO_CHARGER
> +	bool "USB charger support"
> +	select POWER_SUPPLY
> +	help
> +	  Register a charger with the power supply subsystem. This will=20
> allow
> +	  userspace to know whether or not the device is charging from USB.
> +
> +endif
> diff --git a/drivers/usb/common/usb-conn-gpio.c=20
> b/drivers/usb/common/usb-conn-gpio.c
> index ed204cbb63ea..129d48db280b 100644
> --- a/drivers/usb/common/usb-conn-gpio.c
> +++ b/drivers/usb/common/usb-conn-gpio.c
> @@ -17,6 +17,7 @@
>  #include <linux/of.h>
>  #include <linux/pinctrl/consumer.h>
>  #include <linux/platform_device.h>
> +#include <linux/power_supply.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/usb/role.h>
>=20
> @@ -38,6 +39,9 @@ struct usb_conn_info {
>  	struct gpio_desc *vbus_gpiod;
>  	int id_irq;
>  	int vbus_irq;
> +
> +	struct power_supply_desc desc;
> +	struct power_supply *charger;
>  };
>=20
>  /**
> @@ -98,6 +102,8 @@ static void usb_conn_detect_cable(struct=20
> work_struct *work)
>  		ret =3D regulator_enable(info->vbus);
>  		if (ret)
>  			dev_err(info->dev, "enable vbus regulator failed\n");
> +	} else if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
> +		power_supply_changed(info->charger);
>  	}
>=20
>  	info->last_role =3D role;
> @@ -121,10 +127,35 @@ static irqreturn_t usb_conn_isr(int irq, void=20
> *dev_id)
>  	return IRQ_HANDLED;
>  }
>=20
> +static enum power_supply_property usb_charger_properties[] =3D {
> +	POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static int usb_charger_get_property(struct power_supply *psy,
> +				    enum power_supply_property psp,
> +				    union power_supply_propval *val)
> +{
> +	struct usb_conn_info *info =3D power_supply_get_drvdata(psy);
> +
> +	switch (psp) {
> +	case POWER_SUPPLY_PROP_ONLINE:
> +		val->intval =3D info->last_role =3D=3D USB_ROLE_DEVICE;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>  static int usb_conn_probe(struct platform_device *pdev)
>  {
>  	struct device *dev =3D &pdev->dev;
> +	struct power_supply_desc *desc;
>  	struct usb_conn_info *info;
> +	struct power_supply_config cfg =3D {
> +		.of_node =3D dev->of_node,
> +	};
>  	int ret =3D 0;
>=20
>  	info =3D devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> @@ -203,6 +234,22 @@ static int usb_conn_probe(struct platform_device=20
> *pdev)
>  		}
>  	}
>=20
> +	if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
> +		desc =3D &info->desc;
> +		desc->name =3D "usb-charger";
> +		desc->properties =3D usb_charger_properties;
> +		desc->num_properties =3D ARRAY_SIZE(usb_charger_properties);
> +		desc->get_property =3D usb_charger_get_property;
> +		desc->type =3D POWER_SUPPLY_TYPE_USB;
> +		cfg.drv_data =3D info;
> +
> +		info->charger =3D devm_power_supply_register(dev, desc, &cfg);
> +		if (IS_ERR(info->charger)) {
> +			dev_err(dev, "Unable to register charger\n");
> +			return PTR_ERR(info->charger);
> +		}
> +	}
> +
>  	platform_set_drvdata(pdev, info);
>=20
>  	/* Perform initial detection */
> --
> 2.25.1
>=20


