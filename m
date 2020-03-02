Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3090CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9494214DB
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 17:48:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="uqUnNLsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgCBRsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 12:48:39 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39978 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727030AbgCBRsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 12:48:39 -0500
Received: by mail-qk1-f194.google.com with SMTP id m2so508404qka.7
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 09:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PYYAUZIfhqMHRqUFPWnk4yBNnqNzxdGQZWA3gawe5Fs=;
        b=uqUnNLsBcYRZk5PfTRC26+YgBG9xXiSEHgtW37cASdYSLiSiItb44zWKQLLcFIt9Am
         WHdsZ7Coi11ky/2X7dvCZI0/qDq7+WZnczFww2v3tCP+lbhH7Ay+lmZOylKa3wT9YBiG
         bsXRVOsGUjkHoDKs7mvZeGobMDnfPxPZW54EresACSxusnpS22FOx67eXttVpztwZYry
         1YCt33vhPNUTKRMNL1edT/AMKPf297ykqGBuzJ7iCG3c0X92diHyJRPtbK3ypi2tQ252
         OC6n96RFe2AubTjxzVUSq1POukt9N5eexgHYdnc30EOTGbDv3nO972lYqApYKRNJdpNY
         91iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PYYAUZIfhqMHRqUFPWnk4yBNnqNzxdGQZWA3gawe5Fs=;
        b=uFqNoODX018EUan8C0cdmQhj8sTVaqbGWSV5Cvno4ZkI81WqZiE+P4g6XS3c2V6+Ho
         hNnu1q/3/wF4ERjpjwUiam1lCG5m2wo97+7SBeXP/BoQZAZMj3VRp3fcpAV72BiQWGPG
         8N27lwo1RL5bzOd8WbKojv4ZidX7H3vOHbdoiNUp+QhEDfVReFga+glyQ0z2BaFLwgcJ
         YxQZiEglobZxP8DX90GcrAD0ZZuoVv74+hIfrPYMkp2GKivw+b8YHlcwnHeZDyLYkXfJ
         DJOwY3a9Evdv8HJTQMs8Ob8tCGBFd7hhuMFCJw97IeAU2cOUec8GUbjnXCcVuPo9dws0
         dGYg==
X-Gm-Message-State: ANhLgQ0Yrn5+vDRpO9tAqRvvFxnU4yZFXLPCAY2L8spc0WXrF3a5MAs9
        JdCjvEQOKSi6UtlI2v7H5cPFW8VDD2kz35Ov2AuHQQ==
X-Google-Smtp-Source: ADFU+vtYF/5skmEZOjiewRzuMJq/yFrIbxvtjbEigaHgDykH1bFvoFp4fxQSUBV8zBtAUKqagcvrxEOuQw0PO5rciMM=
X-Received: by 2002:a37:a493:: with SMTP id n141mr417245qke.330.1583171318024;
 Mon, 02 Mar 2020 09:48:38 -0800 (PST)
MIME-Version: 1.0
References: <cover.1583167849.git.Asmaa@mellanox.com> <ecd006ea6f929895f46eda1be0917e25f60c98d4.1583167849.git.Asmaa@mellanox.com>
In-Reply-To: <ecd006ea6f929895f46eda1be0917e25f60c98d4.1583167849.git.Asmaa@mellanox.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Mon, 2 Mar 2020 18:48:27 +0100
Message-ID: <CAMpxmJWN1gt7XhN6inv38_1u-i1t+fHJefm2MwKDJWqZHSLoTg@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] gpio: add driver for Mellanox BlueField 2 GPIO controller
To:     Asmaa Mnebhi <Asmaa@mellanox.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pon., 2 mar 2020 o 17:55 Asmaa Mnebhi <Asmaa@mellanox.com> napisa=C5=82(a):
>
> This patch adds support for the GPIO controller used by
> Mellanox BlueField 2 SOCs.
>
> Signed-off-by: Asmaa Mnebhi <Asmaa@mellanox.com>
> ---
>  drivers/gpio/Kconfig       |   7 +
>  drivers/gpio/Makefile      |   1 +
>  drivers/gpio/gpio-mlxbf2.c | 342 +++++++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 350 insertions(+)
>  create mode 100644 drivers/gpio/gpio-mlxbf2.c
>
> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> index b8013cf..6234ccc 100644
> --- a/drivers/gpio/Kconfig
> +++ b/drivers/gpio/Kconfig
> @@ -1399,6 +1399,13 @@ config GPIO_MLXBF
>         help
>           Say Y here if you want GPIO support on Mellanox BlueField SoC.
>
> +config GPIO_MLXBF2
> +       tristate "Mellanox BlueField 2 SoC GPIO"
> +       depends on (MELLANOX_PLATFORM && ARM64 && ACPI) || (64BIT && COMP=
ILE_TEST)
> +       select GPIO_GENERIC
> +       help
> +         Say Y here if you want GPIO support on Mellanox BlueField 2 SoC=
.
> +
>  config GPIO_ML_IOH
>         tristate "OKI SEMICONDUCTOR ML7213 IOH GPIO support"
>         depends on X86 || COMPILE_TEST
> diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
> index 0b57126..b2cfc21 100644
> --- a/drivers/gpio/Makefile
> +++ b/drivers/gpio/Makefile
> @@ -93,6 +93,7 @@ obj-$(CONFIG_GPIO_MENZ127)            +=3D gpio-menz127=
.o
>  obj-$(CONFIG_GPIO_MERRIFIELD)          +=3D gpio-merrifield.o
>  obj-$(CONFIG_GPIO_ML_IOH)              +=3D gpio-ml-ioh.o
>  obj-$(CONFIG_GPIO_MLXBF)               +=3D gpio-mlxbf.o
> +obj-$(CONFIG_GPIO_MLXBF2)              +=3D gpio-mlxbf2.o
>  obj-$(CONFIG_GPIO_MM_LANTIQ)           +=3D gpio-mm-lantiq.o
>  obj-$(CONFIG_GPIO_MOCKUP)              +=3D gpio-mockup.o
>  obj-$(CONFIG_GPIO_MOXTET)              +=3D gpio-moxtet.o
> diff --git a/drivers/gpio/gpio-mlxbf2.c b/drivers/gpio/gpio-mlxbf2.c
> new file mode 100644
> index 0000000..151f442
> --- /dev/null
> +++ b/drivers/gpio/gpio-mlxbf2.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/acpi.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/device.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/resource.h>
> +#include <linux/spinlock.h>
> +#include <linux/types.h>
> +#include <linux/version.h>
> +
> +/*
> + * There are 3 YU GPIO blocks:
> + * gpio[0]: HOST_GPIO0->HOST_GPIO31
> + * gpio[1]: HOST_GPIO32->HOST_GPIO63
> + * gpio[2]: HOST_GPIO64->HOST_GPIO69
> + */
> +#define MLXBF2_GPIO_MAX_PINS_PER_BLOCK 32
> +
> +/*
> + * arm_gpio_lock register:
> + * bit[31]     lock status: active if set
> + * bit[15:0]   set lock
> + * The lock is enabled only if 0xd42f is written to this field
> + */
> +#define YU_ARM_GPIO_LOCK_ADDR          0x2801088
> +#define YU_ARM_GPIO_LOCK_SIZE          0x8
> +#define YU_LOCK_ACTIVE_BIT(val)                (val >> 31)
> +#define YU_ARM_GPIO_LOCK_ACQUIRE       0xd42f
> +#define YU_ARM_GPIO_LOCK_RELEASE       0x0
> +
> +/*
> + * gpio[x] block registers and their offset
> + */
> +#define YU_GPIO_DATAIN                 0x04
> +#define YU_GPIO_MODE1                  0x08
> +#define YU_GPIO_MODE0                  0x0c
> +#define YU_GPIO_DATASET                        0x14
> +#define YU_GPIO_DATACLEAR              0x18
> +#define YU_GPIO_MODE1_CLEAR            0x50
> +#define YU_GPIO_MODE0_SET              0x54
> +#define YU_GPIO_MODE0_CLEAR            0x58
> +
> +#ifdef CONFIG_PM
> +struct mlxbf2_gpio_context_save_regs {
> +       u32 gpio_mode0;
> +       u32 gpio_mode1;
> +};
> +#endif
> +
> +/* BlueField-2 gpio block state structure. */
> +struct mlxbf2_gpio_state {
> +       struct gpio_chip gc;
> +
> +       /* YU GPIO blocks address */
> +       void __iomem *gpio_io;
> +
> +#ifdef CONFIG_PM
> +       struct mlxbf2_gpio_context_save_regs *csave_regs;
> +#endif
> +};
> +
> +/* BlueField-2 gpio shared structure. */
> +struct mlxbf2_gpio_param {
> +       void __iomem *io;
> +       struct resource *res;
> +       struct mutex *lock;
> +};
> +
> +static struct resource yu_arm_gpio_lock_res =3D {
> +       .start =3D YU_ARM_GPIO_LOCK_ADDR,
> +       .end   =3D YU_ARM_GPIO_LOCK_ADDR + YU_ARM_GPIO_LOCK_SIZE - 1,
> +       .name  =3D "YU_ARM_GPIO_LOCK",
> +};
> +
> +static DEFINE_MUTEX(yu_arm_gpio_lock_mutex);
> +
> +static struct mlxbf2_gpio_param yu_arm_gpio_lock_param =3D {
> +       .res =3D &yu_arm_gpio_lock_res,
> +       .lock =3D &yu_arm_gpio_lock_mutex,
> +};
> +
> +/* Request memory region and map yu_arm_gpio_lock resource */
> +static int mlxbf2_gpio_get_lock_res(struct platform_device *pdev)
> +{
> +       struct device *dev =3D &pdev->dev;
> +       struct resource *res;
> +       resource_size_t size;
> +       int ret =3D 0;
> +
> +       mutex_lock(yu_arm_gpio_lock_param.lock);
> +
> +       /* Check if the memory map already exists */
> +       if (yu_arm_gpio_lock_param.io)
> +               goto exit;
> +
> +       res =3D yu_arm_gpio_lock_param.res;
> +       size =3D resource_size(res);
> +
> +       if (!devm_request_mem_region(dev, res->start, size, res->name)) {
> +               ret =3D -EFAULT;
> +               goto exit;
> +       }
> +
> +       yu_arm_gpio_lock_param.io =3D devm_ioremap(dev, res->start, size)=
;
> +       if (IS_ERR(yu_arm_gpio_lock_param.io))
> +               ret =3D PTR_ERR(yu_arm_gpio_lock_param.io);
> +
> +exit:
> +       mutex_unlock(yu_arm_gpio_lock_param.lock);
> +
> +       return ret;
> +}
> +
> +/*
> + * Acquire the YU arm_gpio_lock to be able to change the direction
> + * mode. If the lock_active bit is already set, return an error.
> + */
> +static int mlxbf2_gpio_lock_acquire(struct mlxbf2_gpio_state *gs)
> +{
> +       u32 arm_gpio_lock_val;
> +
> +       spin_lock(&gs->gc.bgpio_lock);

The fact that you take this lock here in a separate function and then
release it explicitly in input/output setters is confusing to me. Can
you wrap the unlocking in a function that is appropriately named in a
way that tells the reader that it's the counterpart of this routine?

> +
> +       mutex_lock(yu_arm_gpio_lock_param.lock);
> +
> +       arm_gpio_lock_val =3D readl(yu_arm_gpio_lock_param.io);
> +
> +       /*
> +        * When lock active bit[31] is set, ModeX is write enabled
> +        */
> +       if (YU_LOCK_ACTIVE_BIT(arm_gpio_lock_val)) {
> +               mutex_unlock(yu_arm_gpio_lock_param.lock);
> +               spin_unlock(&gs->gc.bgpio_lock);
> +               return -EINVAL;
> +       }
> +
> +       writel(YU_ARM_GPIO_LOCK_ACQUIRE, yu_arm_gpio_lock_param.io);
> +
> +       mutex_unlock(yu_arm_gpio_lock_param.lock);
> +
> +       return 0;
> +}
> +
> +/*
> + * Release the YU arm_gpio_lock after changing the direction mode.
> + */
> +static void mlxbf2_gpio_lock_release(void)
> +{
> +       mutex_lock(yu_arm_gpio_lock_param.lock);
> +       writel(YU_ARM_GPIO_LOCK_RELEASE, yu_arm_gpio_lock_param.io);
> +       mutex_unlock(yu_arm_gpio_lock_param.lock);
> +}
> +
> +/*
> + * mode0 and mode1 are both locked by the gpio_lock field.
> + *
> + * Together, mode0 and mode1 define the gpio Mode dependeing also
> + * on Reg_DataOut.
> + *
> + * {mode1,mode0}:{Reg_DataOut=3D0,Reg_DataOut=3D1}->{DataOut=3D0,DataOut=
=3D1}
> + *
> + * {0,0}:Reg_DataOut{0,1}->{Z,Z} Input PAD
> + * {0,1}:Reg_DataOut{0,1}->{0,1} Full drive Output PAD
> + * {1,0}:Reg_DataOut{0,1}->{0,Z} 0-set PAD to low, 1-float
> + * {1,1}:Reg_DataOut{0,1}->{Z,1} 0-float, 1-set PAD to high
> + */
> +
> +/*
> + * Set input direction:
> + * {mode1,mode0} =3D {0,0}
> + */
> +static int mlxbf2_gpio_direction_input(struct gpio_chip *chip,
> +                                      unsigned int offset)
> +{
> +       struct mlxbf2_gpio_state *gs =3D gpiochip_get_data(chip);
> +       int ret;
> +
> +       /*
> +        * Although the arm_gpio_lock was set in the probe function, chec=
k again
> +        * if it is still enabled to be able to write to the ModeX regist=
ers.
> +        */
> +       ret =3D mlxbf2_gpio_lock_acquire(gs);
> +       if (ret < 0)
> +               return ret;
> +
> +       writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE0_CLEAR);

Do you really need to use writel()/readl()? Can you use the relaxed variant=
s?

> +       writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE1_CLEAR);
> +
> +       mlxbf2_gpio_lock_release();
> +       spin_unlock(&gs->gc.bgpio_lock);
> +
> +       return ret;
> +}
> +
> +/*
> + * Set output direction:
> + * {mode1,mode0} =3D {0,1}
> + */
> +static int mlxbf2_gpio_direction_output(struct gpio_chip *chip,
> +                                       unsigned int offset,
> +                                       int value)
> +{
> +       struct mlxbf2_gpio_state *gs =3D gpiochip_get_data(chip);
> +       int ret =3D 0;
> +
> +       /*
> +        * Although the arm_gpio_lock was set in the probe function,
> +        * check again it is still enabled to be able to write to the
> +        * ModeX registers.
> +        */
> +       ret =3D mlxbf2_gpio_lock_acquire(gs);
> +       if (ret < 0)
> +               return ret;
> +
> +       writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE1_CLEAR);
> +       writel(BIT(offset), gs->gpio_io + YU_GPIO_MODE0_SET);
> +
> +       mlxbf2_gpio_lock_release();
> +       spin_unlock(&gs->gc.bgpio_lock);
> +
> +       return ret;
> +}
> +
> +/* BlueField-2 GPIO driver initialization routine. */
> +static int
> +mlxbf2_gpio_probe(struct platform_device *pdev)
> +{
> +       struct mlxbf2_gpio_state *gs;

Would you mind renaming it to context? I find the word state to be quite va=
gue.

> +       struct device *dev =3D &pdev->dev;
> +       struct gpio_chip *gc;
> +       struct resource *res;
> +       unsigned int npins;
> +       int ret;
> +
> +       gs =3D devm_kzalloc(dev, sizeof(*gs), GFP_KERNEL);
> +       if (!gs)
> +               return -ENOMEM;
> +
> +       /* YU GPIO block address */
> +       res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENODEV;
> +
> +       gs->gpio_io =3D devm_ioremap(dev, res->start, resource_size(res))=
;
> +       if (!gs->gpio_io)
> +               return -ENOMEM;

Please use devm_platform_ioremap_resource().

> +
> +       ret =3D mlxbf2_gpio_get_lock_res(pdev);
> +       if (ret) {
> +               dev_err(dev, "Failed to get yu_arm_gpio_lock resource\n")=
;
> +               return ret;
> +       }
> +
> +       if (device_property_read_u32(dev, "npins", &npins))
> +               npins =3D MLXBF2_GPIO_MAX_PINS_PER_BLOCK;
> +
> +       gc =3D &gs->gc;
> +
> +       ret =3D bgpio_init(gc, dev, 4,
> +                       gs->gpio_io + YU_GPIO_DATAIN,
> +                       gs->gpio_io + YU_GPIO_DATASET,
> +                       gs->gpio_io + YU_GPIO_DATACLEAR,
> +                       NULL,
> +                       NULL,
> +                       0);
> +
> +       gc->direction_input =3D mlxbf2_gpio_direction_input;
> +       gc->direction_output =3D mlxbf2_gpio_direction_output;
> +       gc->ngpio =3D npins;
> +       gc->owner =3D THIS_MODULE;
> +
> +       platform_set_drvdata(pdev, gs);
> +
> +       ret =3D devm_gpiochip_add_data(dev, &gs->gc, gs);
> +       if (ret) {
> +               dev_err(dev, "Failed adding memory mapped gpiochip\n");
> +               return ret;
> +       }
> +
> +       dev_info(dev, "Registered Mellanox BlueField-2 GPIO");

This is not needed, the core gpiolib already has an appropriate log message=
.

> +
> +       return 0;
> +}
> +
> +#ifdef CONFIG_PM
> +static int mlxbf2_gpio_suspend(struct platform_device *pdev,
> +                               pm_message_t state)
> +{
> +       struct mlxbf2_gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       gs->csave_regs->gpio_mode0 =3D readl(gs->gpio_io +
> +               YU_GPIO_MODE0);
> +       gs->csave_regs->gpio_mode1 =3D readl(gs->gpio_io +
> +               YU_GPIO_MODE1);
> +
> +       return 0;
> +}
> +
> +static int mlxbf2_gpio_resume(struct platform_device *pdev)
> +{
> +       struct mlxbf2_gpio_state *gs =3D platform_get_drvdata(pdev);
> +
> +       writel(gs->csave_regs->gpio_mode0, gs->gpio_io +
> +               YU_GPIO_MODE0);
> +       writel(gs->csave_regs->gpio_mode1, gs->gpio_io +
> +               YU_GPIO_MODE1);
> +
> +       return 0;
> +}
> +#endif
> +
> +static const struct acpi_device_id mlxbf2_gpio_acpi_match[] =3D {
> +       { "MLNXBF22", 0 },
> +       {},
> +};
> +MODULE_DEVICE_TABLE(acpi, mlxbf2_gpio_acpi_match);
> +
> +static struct platform_driver mlxbf2_gpio_driver =3D {
> +       .driver =3D {
> +               .name =3D "mlxbf2_gpio",
> +               .acpi_match_table =3D ACPI_PTR(mlxbf2_gpio_acpi_match),
> +       },
> +       .probe    =3D mlxbf2_gpio_probe,
> +#ifdef CONFIG_PM
> +       .suspend  =3D mlxbf2_gpio_suspend,
> +       .resume   =3D mlxbf2_gpio_resume,
> +#endif
> +};
> +
> +module_platform_driver(mlxbf2_gpio_driver);
> +
> +MODULE_DESCRIPTION("Mellanox BlueField-2 GPIO Driver");
> +MODULE_AUTHOR("Mellanox Technologies");
> +MODULE_LICENSE("GPL v2");
> --
> 2.1.2
>

Bart
