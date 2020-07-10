Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C600C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:35:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0622078B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 20:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOrCRCzM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbgGJUfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 16:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgGJUfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 16:35:36 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD292C08C5DC;
        Fri, 10 Jul 2020 13:35:36 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a14so3038545pfi.2;
        Fri, 10 Jul 2020 13:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FIc7/IKtxgtR1oJSZ3yRUTyE3zKKVoISQASChXTkBlo=;
        b=FOrCRCzMX4h7OjhSGuW4LDBEjUwwLTmqd4LfzXzrTtu8LMWLDXHS9P+SgrCTxvG5PK
         /ELzclpKa771eU/LueYekjKhK2CrDlKaG3/sfC43jSa76dJcKPBVkPBLpiToFC9004on
         akPapBIMIyA+BjKs1yNQ4frwkVU+TxJNNd1AI4WXVnKIXtYBMWqkD9gaVQU7808iuqgN
         e5DIzjIcj2lIRfgIIqwVurZN70RYyrj385hzbEMx2oE/u5ZKZwa7J/AkhCk0uCQbib4w
         mo987tOO/coJ/moXJhOyVteeci8rLqcKZurbhD7lIwGTHgiN+sCnE3JEmWe1nmXrVjBT
         q+YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FIc7/IKtxgtR1oJSZ3yRUTyE3zKKVoISQASChXTkBlo=;
        b=gwPh/FlPCxnzbsU+QGWkX2p8WIFm7Clq5u1tk+jgGWn5QGQvPyUtFCSWbuBWOPzFzv
         gVYNOfEIr2Dod9v8nS5uNmMF5o/zsVqPh17jkpGrg1cGLaIjAzXGMZW39eqV8LUUxHqx
         PDUbbclTO9S9HN93yOUlfAHueXyn0iwE6ZH7kjgLEyYasOHoaxxIkgF5Yn+3OlF/YqFR
         hbxJ1z/NzSiBZtszAAP3Ro/cnSu3URXIO+qwRVMmX4Vm2pCD0lAe0KweeTEFxJtemf0+
         HY1fatY+zB+KBqI16aCbyftHqrbdGGWO1xI4BE+yOo/U1E+be6GrdIfiHGwke3XHQCej
         yRrg==
X-Gm-Message-State: AOAM533pkG93HDExCrXxvbhhM/EfrS+3GUWr4k/J602s5bBxbX5X2SdK
        P/NHYZ8ED5XlzUyEzyMJux6XOMTeonzF1S+uSL9W0kvy
X-Google-Smtp-Source: ABdhPJwx795zT5GkcJ8oKNP5vaosuAVKGUur20sCV5zbbPtT5wRG7QZ6uB2bia39IVe41iTzGnhkoZyAIspZrq7AYV0=
X-Received: by 2002:a63:ce41:: with SMTP id r1mr37210194pgi.203.1594413335893;
 Fri, 10 Jul 2020 13:35:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200620123705.72625-1-hdegoede@redhat.com>
In-Reply-To: <20200620123705.72625-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 23:35:19 +0300
Message-ID: <CAHp75Vf5dm0iErjK4sCA54kKJhLeNe4oAG3PrCJiJHFyrJZ_iQ@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: Add new intel_atomisp2_led driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 3:37 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Many Bay Trail and Cherry Trail devices come with a camera attached to
> Intel's Image Signal Processor. Linux currently does not have a driver for
> these, so they do not work as a camera.
>
> Some of these camera's have a status LED which is controlled through a GPIO
> in some cases, e.g. on the Asus T100TA and Asus T200TA, there is a firmware
> issue where the LED gets turned on at boot.
>
> This commit adds a Linux LED driver for the camera LED on these devices.
> This driver will turn the LED off at boot and also allows controlling the
> LED (so the user can repurpose it) through the sysfs LED interface.
>
> Which GPIO is attached to the LED is usually not described in the ACPI
> tables, so this driver contains per-system info about the GPIO inside the
> driver. This means that this driver only works on systems the driver knows
> about.
>

Pushed to my review and testing queue, thanks!

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
> Changes in v2:
> - Rebase on top of v5.8-rc1
> - Use PTR_ERR_OR_ZERO
> ---
>  MAINTAINERS                               |   6 ++
>  drivers/platform/x86/Kconfig              |  21 ++++
>  drivers/platform/x86/Makefile             |   1 +
>  drivers/platform/x86/intel_atomisp2_led.c | 116 ++++++++++++++++++++++
>  4 files changed, 144 insertions(+)
>  create mode 100644 drivers/platform/x86/intel_atomisp2_led.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 301330e02bca..5535761f2b54 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8600,6 +8600,12 @@ L:       platform-driver-x86@vger.kernel.org
>  S:     Maintained
>  F:     drivers/platform/x86/intel_atomisp2_pm.c
>
> +INTEL ATOMISP2 LED DRIVER
> +M:     Hans de Goede <hdegoede@redhat.com>
> +L:     platform-driver-x86@vger.kernel.org
> +S:     Maintained
> +F:     drivers/platform/x86/intel_atomisp2_led.c
> +
>  INTEL BROXTON PMC DRIVER
>  M:     Mika Westerberg <mika.westerberg@linux.intel.com>
>  M:     Zha Qipeng <qipeng.zha@intel.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0581a54cf562..318e083f38b3 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -761,6 +761,27 @@ config INTEL_ATOMISP2_PM
>           To compile this driver as a module, choose M here: the module
>           will be called intel_atomisp2_pm.
>
> +config INTEL_ATOMISP2_LED
> +       tristate "Intel AtomISP2 camera LED driver"
> +       depends on GPIOLIB && LEDS_GPIO
> +       help
> +         Many Bay Trail and Cherry Trail devices come with a camera attached
> +         to Intel's Image Signal Processor. Linux currently does not have a
> +         driver for these, so they do not work as a camera. Some of these
> +         camera's have a LED which is controlled through a GPIO.
> +
> +         Some of these devices have a firmware issue where the LED gets turned
> +         on at boot. This driver will turn the LED off at boot and also allows
> +         controlling the LED (repurposing it) through the sysfs LED interface.
> +
> +         Which GPIO is attached to the LED is usually not described in the
> +         ACPI tables, so this driver contains per-system info about the GPIO
> +         inside the driver, this means that this driver only works on systems
> +         the driver knows about.
> +
> +         To compile this driver as a module, choose M here: the module
> +         will be called intel_atomisp2_led.
> +
>  config INTEL_CHT_INT33FE
>         tristate "Intel Cherry Trail ACPI INT33FE Driver"
>         depends on X86 && ACPI && I2C && REGULATOR
> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
> index 2b85852a1a87..7a78cc0bb249 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -70,6 +70,7 @@ obj-$(CONFIG_THINKPAD_ACPI)   += thinkpad_acpi.o
>
>  # Intel
>  obj-$(CONFIG_INTEL_ATOMISP2_PM)                += intel_atomisp2_pm.o
> +obj-$(CONFIG_INTEL_ATOMISP2_LED)       += intel_atomisp2_led.o
>  obj-$(CONFIG_INTEL_CHT_INT33FE)                += intel_cht_int33fe.o
>  intel_cht_int33fe-objs                 := intel_cht_int33fe_common.o \
>                                            intel_cht_int33fe_typec.o \
> diff --git a/drivers/platform/x86/intel_atomisp2_led.c b/drivers/platform/x86/intel_atomisp2_led.c
> new file mode 100644
> index 000000000000..5935dfca166f
> --- /dev/null
> +++ b/drivers/platform/x86/intel_atomisp2_led.c
> @@ -0,0 +1,116 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Driver for controlling LEDs for cameras connected to the Intel atomisp2
> + * The main purpose of this driver is to turn off LEDs which are on at boot.
> + *
> + * Copyright (C) 2020 Hans de Goede <hdegoede@redhat.com>
> + */
> +
> +#include <linux/dmi.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/leds.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +#include <linux/workqueue.h>
> +
> +/* This must be leds-gpio as the leds-gpio driver binds to the name */
> +#define DEV_NAME               "leds-gpio"
> +
> +static const struct gpio_led atomisp2_leds[] = {
> +       {
> +               .name = "atomisp2::camera",
> +               .default_state  = LEDS_GPIO_DEFSTATE_OFF,
> +       },
> +};
> +
> +static const struct gpio_led_platform_data atomisp2_leds_pdata = {
> +       .num_leds       = ARRAY_SIZE(atomisp2_leds),
> +       .leds           = atomisp2_leds,
> +};
> +
> +static struct gpiod_lookup_table asus_t100ta_lookup = {
> +       .dev_id = DEV_NAME,
> +       .table = {
> +               GPIO_LOOKUP_IDX("INT33FC:02", 8, NULL, 0, GPIO_ACTIVE_HIGH),
> +               { }
> +       }
> +};
> +
> +static struct gpiod_lookup_table asus_t100chi_lookup = {
> +       .dev_id = DEV_NAME,
> +       .table = {
> +               GPIO_LOOKUP_IDX("INT33FC:01", 24, NULL, 0, GPIO_ACTIVE_HIGH),
> +               { }
> +       }
> +};
> +
> +static const struct dmi_system_id atomisp2_led_systems[] __initconst = {
> +       {
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
> +               },
> +               .driver_data = &asus_t100ta_lookup,
> +       },
> +       {
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T200TA"),
> +               },
> +               .driver_data = &asus_t100ta_lookup,
> +       },
> +       {
> +               .matches = {
> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100CHI"),
> +               },
> +               .driver_data = &asus_t100chi_lookup,
> +       },
> +       {} /* Terminating entry */
> +};
> +MODULE_DEVICE_TABLE(dmi, atomisp2_led_systems);
> +
> +static struct gpiod_lookup_table *gpio_lookup;
> +static struct platform_device *pdev;
> +
> +static int __init atomisp2_led_init(void)
> +{
> +       const struct dmi_system_id *system;
> +
> +       system = dmi_first_match(atomisp2_led_systems);
> +       if (!system)
> +               return -ENODEV;
> +
> +       gpio_lookup = system->driver_data;
> +       gpiod_add_lookup_table(gpio_lookup);
> +
> +       pdev = platform_device_register_resndata(NULL,
> +                                                DEV_NAME, PLATFORM_DEVID_NONE,
> +                                                NULL, 0, &atomisp2_leds_pdata,
> +                                                sizeof(atomisp2_leds_pdata));
> +       if (IS_ERR(pdev))
> +               gpiod_remove_lookup_table(gpio_lookup);
> +
> +       return PTR_ERR_OR_ZERO(pdev);
> +}
> +
> +static void __exit atomisp2_led_cleanup(void)
> +{
> +       platform_device_unregister(pdev);
> +       gpiod_remove_lookup_table(gpio_lookup);
> +}
> +
> +module_init(atomisp2_led_init);
> +module_exit(atomisp2_led_cleanup);
> +
> +/*
> + * The ACPI INIT method from Asus WMI's code on the T100TA and T200TA turns the
> + * LED on (without the WMI interface allowing further control over the LED).
> + * Ensure we are loaded after asus-nb-wmi so that we turn the LED off again.
> + */
> +MODULE_SOFTDEP("pre: asus_nb_wmi");
> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
> +MODULE_DESCRIPTION("Intel atomisp2 camera LED driver");
> +MODULE_LICENSE("GPL");
> --
> 2.26.2
>


-- 
With Best Regards,
Andy Shevchenko
