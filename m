Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F1C9C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6441206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 10:14:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JA6o9rlx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGZKOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 06:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgGZKOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 06:14:33 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4BDC0619D2;
        Sun, 26 Jul 2020 03:14:33 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id t15so7734112pjq.5;
        Sun, 26 Jul 2020 03:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pI6694xzz906TEXIdBTv5zox9FPpS/Oms0a6Hf/o6mo=;
        b=JA6o9rlxpINvQj24gHCxdjwBIY3c0ui9sbTITufthuErW87KW3fWgO7mFTCaojF0Nc
         Y89wquUqWFR/AXd6BL5fPiejZIFLxY+4qhOLY3z5Gbv90r9GmtQzKH9xwYAgUHm3o+vd
         dHgmvC1a7zc/aEiPtfgLQaRXPBLWV5t+DxHbR0yf5DeQX83xJNAFTkhMGmg28DyIkD/L
         DcCDqc/pM9T3RzbKEEnpzvNf0cqdzWUictvQ+h5j0JZjDwYWZ2+A/V+L97C+y0shhslN
         6AxLRqTMpgzFljD+RAArxVJzuLhgcFgXJ6koURcFP6GGb3avhbD/meWIbPzxwn7DSl4H
         +8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pI6694xzz906TEXIdBTv5zox9FPpS/Oms0a6Hf/o6mo=;
        b=p6opf12DTagYkBlp6uUd9tyOgSjcleJd3c7hmO93CXJ1hZb3ebkXfeHS49Zn/BX+89
         hlfcJMBqJY8lfWYSMeYkvktJFeTeL/WMCqIjBQyNRXP6tD3bJc4Fwghqpav6bBtKJhjf
         To67+eBbsST+Vy2lqe/M1y9cNi+7bEJLd9IRGByAvP6vvdfWp/DkYxw0k57ovnVR3cgL
         Qak1/N0h2Oy9s92pxGhIOm+9zGc/wagegg8HIY2Q5E8dqH28YVDBYiEiiugC1LY8rrs2
         0oSyxReVgdUPI7Br1SVEqlaAwU9A14/16nJMgVwkP+KXssXoTYe+mN5RJa0z0BviOdUb
         iXkw==
X-Gm-Message-State: AOAM532ACWg0Q3RzRNZ3ckwa+qiDhQkNWWTi2jw3NllZPZVhgCE8BPdY
        HqYPPdF2cZrwornT3qK0lbzwYUjS8F5niGoueBQ0dT8hTKA=
X-Google-Smtp-Source: ABdhPJxf8yDvJ10Va7KUKlmBDOMyr7v0SbUaYgGuRwOt2PBevmTHlFdee97KfyNlicevYbg+dyOLHAcMhyPZ5TY0glQ=
X-Received: by 2002:a17:90a:498b:: with SMTP id d11mr14255156pjh.129.1595758472397;
 Sun, 26 Jul 2020 03:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200621224807.882184-1-paul@crapouillou.net>
In-Reply-To: <20200621224807.882184-1-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 26 Jul 2020 13:14:15 +0300
Message-ID: <CAHp75VcfhDncqP_hSVvRNc_vY0fOYaoxm-tiCm2G92Xrisb9hA@mail.gmail.com>
Subject: Re: [RESEND PATCH] usb: common: usb-conn-gpio: Register optional charger
To:     Paul Cercueil <paul@crapouillou.net>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>, od@zcrc.me,
        USB <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 1:51 AM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Register a power supply charger, if the Kconfig option
> USB_CONN_GPIO_CHARGER is set, whose online state depends on whether
> the USB role is set to device or not.
>
> This is useful when the USB role is the only way to know if the device
> is charging from USB. The API is the standard power supply charger API,
> you get a /sys/class/power_supply/xxx/online node which tells you the
> state of the charger.
>
> The sole purpose of this is to give userspace applications a way to
> know whether or not the charger is plugged.

I'm not sure I understand the purpose of this (third?) way to detect
USB charger and notify user space about.
Why is extcon not good enough?

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/usb/common/Kconfig         | 11 +++++++
>  drivers/usb/common/usb-conn-gpio.c | 47 ++++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>
> diff --git a/drivers/usb/common/Kconfig b/drivers/usb/common/Kconfig
> index d611477aae41..5405ae96c68f 100644
> --- a/drivers/usb/common/Kconfig
> +++ b/drivers/usb/common/Kconfig
> @@ -49,3 +49,14 @@ config USB_CONN_GPIO
>
>           To compile the driver as a module, choose M here: the module will
>           be called usb-conn-gpio.ko
> +
> +if USB_CONN_GPIO
> +
> +config USB_CONN_GPIO_CHARGER
> +       bool "USB charger support"
> +       select POWER_SUPPLY
> +       help
> +         Register a charger with the power supply subsystem. This will allow
> +         userspace to know whether or not the device is charging from USB.
> +
> +endif
> diff --git a/drivers/usb/common/usb-conn-gpio.c b/drivers/usb/common/usb-conn-gpio.c
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
>
> @@ -38,6 +39,9 @@ struct usb_conn_info {
>         struct gpio_desc *vbus_gpiod;
>         int id_irq;
>         int vbus_irq;
> +
> +       struct power_supply_desc desc;
> +       struct power_supply *charger;
>  };
>
>  /**
> @@ -98,6 +102,8 @@ static void usb_conn_detect_cable(struct work_struct *work)
>                 ret = regulator_enable(info->vbus);
>                 if (ret)
>                         dev_err(info->dev, "enable vbus regulator failed\n");
> +       } else if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
> +               power_supply_changed(info->charger);
>         }
>
>         info->last_role = role;
> @@ -121,10 +127,35 @@ static irqreturn_t usb_conn_isr(int irq, void *dev_id)
>         return IRQ_HANDLED;
>  }
>
> +static enum power_supply_property usb_charger_properties[] = {
> +       POWER_SUPPLY_PROP_ONLINE,
> +};
> +
> +static int usb_charger_get_property(struct power_supply *psy,
> +                                   enum power_supply_property psp,
> +                                   union power_supply_propval *val)
> +{
> +       struct usb_conn_info *info = power_supply_get_drvdata(psy);
> +
> +       switch (psp) {
> +       case POWER_SUPPLY_PROP_ONLINE:
> +               val->intval = info->last_role == USB_ROLE_DEVICE;
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return 0;
> +}
> +
>  static int usb_conn_probe(struct platform_device *pdev)
>  {
>         struct device *dev = &pdev->dev;
> +       struct power_supply_desc *desc;
>         struct usb_conn_info *info;
> +       struct power_supply_config cfg = {
> +               .of_node = dev->of_node,
> +       };
>         int ret = 0;
>
>         info = devm_kzalloc(dev, sizeof(*info), GFP_KERNEL);
> @@ -203,6 +234,22 @@ static int usb_conn_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       if (IS_ENABLED(CONFIG_USB_CONN_GPIO_CHARGER)) {
> +               desc = &info->desc;
> +               desc->name = "usb-charger";
> +               desc->properties = usb_charger_properties;
> +               desc->num_properties = ARRAY_SIZE(usb_charger_properties);
> +               desc->get_property = usb_charger_get_property;
> +               desc->type = POWER_SUPPLY_TYPE_USB;
> +               cfg.drv_data = info;
> +
> +               info->charger = devm_power_supply_register(dev, desc, &cfg);
> +               if (IS_ERR(info->charger)) {
> +                       dev_err(dev, "Unable to register charger\n");
> +                       return PTR_ERR(info->charger);
> +               }
> +       }
> +
>         platform_set_drvdata(pdev, info);
>
>         /* Perform initial detection */
> --
> 2.27.0
>


-- 
With Best Regards,
Andy Shevchenko
