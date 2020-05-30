Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D845DC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 14:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93F9F20722
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 14:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SlruLFuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729116AbgE3O4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 10:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728927AbgE3O4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 10:56:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1936FC03E969;
        Sat, 30 May 2020 07:56:20 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id bg4so2426788plb.3;
        Sat, 30 May 2020 07:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mLi7t+Haaug9DHO6Wy0k89wrvEdd9nJ/1JBPF70+Lt0=;
        b=SlruLFuBIWRa3wV4vXEMBtMPt6L9RlvbgVm9eu65dCp+0P+XDmp8E3z0JJ00wNWSQ/
         UrcgVn86Ki6OvNsMigq537DB//ifup87wMTJDhpL7LXlhGCxBcieQq1cJdgiYh1LDVKW
         N9cBh7DQR5yIxRg3Zxmf2/XLYLd6wXHjsQbIJcCwYw2jX0ZabyheIxVSwhHflQE6xjvP
         OQHlJerX39f3xsmWvex9Xhxk5nc4HQoR2d9bi8NgpwW/BpuGsRUOq9PrBr7YIx8Qz3XP
         lMm2gzXHi01kjh7Iml2xOs5uZxdj6UT6MGWg1nWKu06P+ImKPAQIKj6oNhgKcpjGTP3v
         zZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mLi7t+Haaug9DHO6Wy0k89wrvEdd9nJ/1JBPF70+Lt0=;
        b=h49QKFhDH055cj8qLw+ArKJ2spZXsdgIs0ikt0QuGsWI5TELrhyJM2AdFqILpCinfN
         bhDnRYzzSGbQx//7UwPiw5DDUE3wTQ7wHFW7wnFFNbwDLK1RjFsZkXP4ncrTNsGFAFmx
         4gIyCOV057I7UV1IYq1UepHh2eSgaebp2R64PkXzl5Q8PVMq7DmUsmXYaLTMrUQmAFKR
         571HXTxMN8vLnKajsUCGbQIOsLl8agn7kC4bY4cJbHFoi9h/xua+FRsWo+Eq7zpa/AIi
         0G0/pN+viMq7MsWxYZ2C4dIdwa72P7vQ38Sk6bp8FblHEWNi7RjKvwL4cuTZydlXD7IX
         jHnw==
X-Gm-Message-State: AOAM531jBIGqaY4A+0Ioj+s57qqHQVgCvDziOq+9zH3IUkU6Gbz/0FS9
        0e7k0MxG8nc8veCybGlmeealVTXq9qF9zPiU/Tg=
X-Google-Smtp-Source: ABdhPJxQ4yk7C87XVHHvfk4bnrqm7MDxBWdpNj7aIgrNbOUj+WthgYS6wb9OhvOP+FjYxwQZcfb/qymxZuhLPYDsiz4=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr6928267pje.129.1590850579389;
 Sat, 30 May 2020 07:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200509130707.219463-1-hdegoede@redhat.com>
In-Reply-To: <20200509130707.219463-1-hdegoede@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 30 May 2020 17:56:07 +0300
Message-ID: <CAHp75Ve99asQ8bDMBiKYqpNrgN73K9ppEe+gRoxzOPMLkWrzJA@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: Add new intel_atomisp2_led driver
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 9, 2020 at 4:07 PM Hans de Goede <hdegoede@redhat.com> wrote:
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

Somehow I missed it, sorry.

It doesn't apply to for-next. Also I have a question. Since Mauro
tries to resurrect AtomISP v2, can we somehow do this in a way it can
be easily disabled / not conflicting with the real driver?
Or do we need this at all after driver will be in place?

> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  MAINTAINERS                               |   6 ++
>  drivers/platform/x86/Kconfig              |  21 ++++
>  drivers/platform/x86/Makefile             |   1 +
>  drivers/platform/x86/intel_atomisp2_led.c | 118 ++++++++++++++++++++++
>  4 files changed, 146 insertions(+)
>  create mode 100644 drivers/platform/x86/intel_atomisp2_led.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2926327e4976..d85e009260ec 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8499,6 +8499,12 @@ L:       platform-driver-x86@vger.kernel.org
>  S:     Maintained
>  F:     drivers/platform/x86/intel_atomisp2_pm.c
>
> +INTEL ATOMISP2 LED DRIVER
> +M:     Hans de Goede <hdegoede@redhat.com>
> +L:     platform-driver-x86@vger.kernel.org
> +S:     Maintained
> +F:     drivers/platform/x86/intel_atomisp2_led.c
> +
>  INTEL C600 SERIES SAS CONTROLLER DRIVER
>  M:     Intel SCU Linux support <intel-linux-scu@intel.com>
>  M:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 0ad7ad8cf8e1..1af4c97447a2 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -750,6 +750,27 @@ config INTEL_ATOMISP2_PM
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
> index 53408d965874..969581237abb 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_ACPI)   += thinkpad_acpi.o
>
>  # Intel
>  obj-$(CONFIG_INTEL_ATOMISP2_PM)                += intel_atomisp2_pm.o
> +obj-$(CONFIG_INTEL_ATOMISP2_LED)       += intel_atomisp2_led.o
>  obj-$(CONFIG_INTEL_CHT_INT33FE)                += intel_cht_int33fe.o
>  intel_cht_int33fe-objs                 := intel_cht_int33fe_common.o \
>                                            intel_cht_int33fe_typec.o \
> diff --git a/drivers/platform/x86/intel_atomisp2_led.c b/drivers/platform/x86/intel_atomisp2_led.c
> new file mode 100644
> index 000000000000..fb704956cd9d
> --- /dev/null
> +++ b/drivers/platform/x86/intel_atomisp2_led.c
> @@ -0,0 +1,118 @@
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
> +       if (IS_ERR(pdev)) {
> +               gpiod_remove_lookup_table(gpio_lookup);
> +               return PTR_ERR(pdev);
> +       }
> +
> +       return 0;
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
> 2.26.0
>


-- 
With Best Regards,
Andy Shevchenko
