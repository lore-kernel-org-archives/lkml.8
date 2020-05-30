Return-Path: <SRS0=qKPt=7M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A66FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AC720723
	for <linux-kernel@archiver.kernel.org>; Sat, 30 May 2020 15:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JN2PIv48"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729107AbgE3PcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 May 2020 11:32:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45730 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729026AbgE3PcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 May 2020 11:32:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590852729;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cStna+1NKzghTnXWNaEtnxjSopfCITqDp3GCUO+XaMg=;
        b=JN2PIv48/I3Cgyp+3ZCrDu5/ZvFd7PjgTmxIvmy0yj1DLUcp4yWJ4oEcsUldMZzyxjelxn
        4ffECmqNxeZTTapBmCsSjoAdSePWOI1PRtcAYpqOKykoHAwSNJKlPOTKEG07AyNe6N6yiV
        HUKdDRvDbbwP275Me4pVkFcbvuTf+YA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-nTXnxH0qNGywQLzruW-MPA-1; Sat, 30 May 2020 11:32:07 -0400
X-MC-Unique: nTXnxH0qNGywQLzruW-MPA-1
Received: by mail-ed1-f72.google.com with SMTP id t23so1814173edq.5
        for <linux-kernel@vger.kernel.org>; Sat, 30 May 2020 08:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cStna+1NKzghTnXWNaEtnxjSopfCITqDp3GCUO+XaMg=;
        b=ccc9IilIcS5ot1BmW2qJe6AAEkIa35moUwlgQzueXYoraFNn4ArzktJQkC59ngSjOF
         mFuTlYgjGgn6qWo472EAb9Cm/nC1ETt2r2slwYIJsXfYi5S/uutoYELTpSnm20eLwa4m
         7BJxLNxpSwa3JSpPeg0Gjh1XpFJw7fNloeBIt0xx1gTC5+iutpkG6tnqx/BiBrGx+vMq
         vtQBak0eBFPI0tacKxpIb9Gqam0gu1YZzBrtH4IS92DryNpp6RXzDPUViwQ+MfEBenZy
         assgKenY+jXfvx/YGE7qGyhT6FLfAe+BrY3O7KxlF0AXQXPhRUjKAUhC8RzjbUKwSrH4
         yTzw==
X-Gm-Message-State: AOAM532ypoYd5tHj1D30Oro7q68b5H19EYdynwyIp0c0fwZEhPx2nzuW
        Giw/6H3bTYg+l5dQ+EeNOQfcZ4+7TkiA9lDlsN6cVvWUxuydYscbrfQYMB4XCabzw6D/rzPHLD5
        AUKOr2JBHGG4Y/cCUg9SZg0Ln
X-Received: by 2002:aa7:d952:: with SMTP id l18mr8571127eds.151.1590852725912;
        Sat, 30 May 2020 08:32:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw6MC1P5oCRt+YHh0cSpdhBnMvIhsJALSZN2iDw6qnHcChMj4cgerD9UKR7Ah2l4PQkF6W9wQ==
X-Received: by 2002:aa7:d952:: with SMTP id l18mr8571100eds.151.1590852725538;
        Sat, 30 May 2020 08:32:05 -0700 (PDT)
Received: from x1.localdomain (2001-1c00-0c0c-fe00-d2ea-f29d-118b-24dc.cable.dynamic.v6.ziggo.nl. [2001:1c00:c0c:fe00:d2ea:f29d:118b:24dc])
        by smtp.gmail.com with ESMTPSA id q16sm10110945eju.73.2020.05.30.08.32.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 May 2020 08:32:04 -0700 (PDT)
Subject: Re: [PATCH] platform/x86: Add new intel_atomisp2_led driver
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        acpi4asus-user <acpi4asus-user@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20200509130707.219463-1-hdegoede@redhat.com>
 <CAHp75Ve99asQ8bDMBiKYqpNrgN73K9ppEe+gRoxzOPMLkWrzJA@mail.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <b7ae0f8b-0879-de7c-b85a-f45a98eee25f@redhat.com>
Date:   Sat, 30 May 2020 17:32:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAHp75Ve99asQ8bDMBiKYqpNrgN73K9ppEe+gRoxzOPMLkWrzJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/30/20 4:56 PM, Andy Shevchenko wrote:
> On Sat, May 9, 2020 at 4:07 PM Hans de Goede <hdegoede@redhat.com> wrote:
>>
>> Many Bay Trail and Cherry Trail devices come with a camera attached to
>> Intel's Image Signal Processor. Linux currently does not have a driver for
>> these, so they do not work as a camera.
>>
>> Some of these camera's have a status LED which is controlled through a GPIO
>> in some cases, e.g. on the Asus T100TA and Asus T200TA, there is a firmware
>> issue where the LED gets turned on at boot.
>>
>> This commit adds a Linux LED driver for the camera LED on these devices.
>> This driver will turn the LED off at boot and also allows controlling the
>> LED (so the user can repurpose it) through the sysfs LED interface.
>>
>> Which GPIO is attached to the LED is usually not described in the ACPI
>> tables, so this driver contains per-system info about the GPIO inside the
>> driver. This means that this driver only works on systems the driver knows
>> about.
>>
> 
> Somehow I missed it, sorry.

No problem.

> It doesn't apply to for-next. Also I have a question. Since Mauro
> tries to resurrect AtomISP v2, can we somehow do this in a way it can
> be easily disabled / not conflicting with the real driver?

Mauro is working on resurrecting AtomISP v2 support for Cherry Trail,
the devices which are on the DMI match list of this driver so far
are all Bay Trail based. I think it is safe to say that Bay Trail
AtomISP v2 support still is very far away.

> Or do we need this at all after driver will be in place?

We may still need / want this even if there is an Atom ISP v2
driver. The question is if that driver will then control the
LED itself (using hardcoded per model info embedded in that driver)
or if it will use a LED-trigger + a separate LED driver, if we
go the LED-trigger route, then we want to keep this driver around
as the actual LED driver.

Do you have any more (initial) review remarks, before I do a rebase +
resend ?

Regards,

Hans






> 
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   MAINTAINERS                               |   6 ++
>>   drivers/platform/x86/Kconfig              |  21 ++++
>>   drivers/platform/x86/Makefile             |   1 +
>>   drivers/platform/x86/intel_atomisp2_led.c | 118 ++++++++++++++++++++++
>>   4 files changed, 146 insertions(+)
>>   create mode 100644 drivers/platform/x86/intel_atomisp2_led.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 2926327e4976..d85e009260ec 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -8499,6 +8499,12 @@ L:       platform-driver-x86@vger.kernel.org
>>   S:     Maintained
>>   F:     drivers/platform/x86/intel_atomisp2_pm.c
>>
>> +INTEL ATOMISP2 LED DRIVER
>> +M:     Hans de Goede <hdegoede@redhat.com>
>> +L:     platform-driver-x86@vger.kernel.org
>> +S:     Maintained
>> +F:     drivers/platform/x86/intel_atomisp2_led.c
>> +
>>   INTEL C600 SERIES SAS CONTROLLER DRIVER
>>   M:     Intel SCU Linux support <intel-linux-scu@intel.com>
>>   M:     Artur Paszkiewicz <artur.paszkiewicz@intel.com>
>> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
>> index 0ad7ad8cf8e1..1af4c97447a2 100644
>> --- a/drivers/platform/x86/Kconfig
>> +++ b/drivers/platform/x86/Kconfig
>> @@ -750,6 +750,27 @@ config INTEL_ATOMISP2_PM
>>            To compile this driver as a module, choose M here: the module
>>            will be called intel_atomisp2_pm.
>>
>> +config INTEL_ATOMISP2_LED
>> +       tristate "Intel AtomISP2 camera LED driver"
>> +       depends on GPIOLIB && LEDS_GPIO
>> +       help
>> +         Many Bay Trail and Cherry Trail devices come with a camera attached
>> +         to Intel's Image Signal Processor. Linux currently does not have a
>> +         driver for these, so they do not work as a camera. Some of these
>> +         camera's have a LED which is controlled through a GPIO.
>> +
>> +         Some of these devices have a firmware issue where the LED gets turned
>> +         on at boot. This driver will turn the LED off at boot and also allows
>> +         controlling the LED (repurposing it) through the sysfs LED interface.
>> +
>> +         Which GPIO is attached to the LED is usually not described in the
>> +         ACPI tables, so this driver contains per-system info about the GPIO
>> +         inside the driver, this means that this driver only works on systems
>> +         the driver knows about.
>> +
>> +         To compile this driver as a module, choose M here: the module
>> +         will be called intel_atomisp2_led.
>> +
>>   config INTEL_CHT_INT33FE
>>          tristate "Intel Cherry Trail ACPI INT33FE Driver"
>>          depends on X86 && ACPI && I2C && REGULATOR
>> diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
>> index 53408d965874..969581237abb 100644
>> --- a/drivers/platform/x86/Makefile
>> +++ b/drivers/platform/x86/Makefile
>> @@ -69,6 +69,7 @@ obj-$(CONFIG_THINKPAD_ACPI)   += thinkpad_acpi.o
>>
>>   # Intel
>>   obj-$(CONFIG_INTEL_ATOMISP2_PM)                += intel_atomisp2_pm.o
>> +obj-$(CONFIG_INTEL_ATOMISP2_LED)       += intel_atomisp2_led.o
>>   obj-$(CONFIG_INTEL_CHT_INT33FE)                += intel_cht_int33fe.o
>>   intel_cht_int33fe-objs                 := intel_cht_int33fe_common.o \
>>                                             intel_cht_int33fe_typec.o \
>> diff --git a/drivers/platform/x86/intel_atomisp2_led.c b/drivers/platform/x86/intel_atomisp2_led.c
>> new file mode 100644
>> index 000000000000..fb704956cd9d
>> --- /dev/null
>> +++ b/drivers/platform/x86/intel_atomisp2_led.c
>> @@ -0,0 +1,118 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Driver for controlling LEDs for cameras connected to the Intel atomisp2
>> + * The main purpose of this driver is to turn off LEDs which are on at boot.
>> + *
>> + * Copyright (C) 2020 Hans de Goede <hdegoede@redhat.com>
>> + */
>> +
>> +#include <linux/dmi.h>
>> +#include <linux/gpio/consumer.h>
>> +#include <linux/gpio/machine.h>
>> +#include <linux/leds.h>
>> +#include <linux/module.h>
>> +#include <linux/mod_devicetable.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/workqueue.h>
>> +
>> +/* This must be leds-gpio as the leds-gpio driver binds to the name */
>> +#define DEV_NAME               "leds-gpio"
>> +
>> +static const struct gpio_led atomisp2_leds[] = {
>> +       {
>> +               .name = "atomisp2::camera",
>> +               .default_state  = LEDS_GPIO_DEFSTATE_OFF,
>> +       },
>> +};
>> +
>> +static const struct gpio_led_platform_data atomisp2_leds_pdata = {
>> +       .num_leds       = ARRAY_SIZE(atomisp2_leds),
>> +       .leds           = atomisp2_leds,
>> +};
>> +
>> +static struct gpiod_lookup_table asus_t100ta_lookup = {
>> +       .dev_id = DEV_NAME,
>> +       .table = {
>> +               GPIO_LOOKUP_IDX("INT33FC:02", 8, NULL, 0, GPIO_ACTIVE_HIGH),
>> +               { }
>> +       }
>> +};
>> +
>> +static struct gpiod_lookup_table asus_t100chi_lookup = {
>> +       .dev_id = DEV_NAME,
>> +       .table = {
>> +               GPIO_LOOKUP_IDX("INT33FC:01", 24, NULL, 0, GPIO_ACTIVE_HIGH),
>> +               { }
>> +       }
>> +};
>> +
>> +static const struct dmi_system_id atomisp2_led_systems[] __initconst = {
>> +       {
>> +               .matches = {
>> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100TA"),
>> +               },
>> +               .driver_data = &asus_t100ta_lookup,
>> +       },
>> +       {
>> +               .matches = {
>> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T200TA"),
>> +               },
>> +               .driver_data = &asus_t100ta_lookup,
>> +       },
>> +       {
>> +               .matches = {
>> +                       DMI_EXACT_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
>> +                       DMI_EXACT_MATCH(DMI_PRODUCT_NAME, "T100CHI"),
>> +               },
>> +               .driver_data = &asus_t100chi_lookup,
>> +       },
>> +       {} /* Terminating entry */
>> +};
>> +MODULE_DEVICE_TABLE(dmi, atomisp2_led_systems);
>> +
>> +static struct gpiod_lookup_table *gpio_lookup;
>> +static struct platform_device *pdev;
>> +
>> +static int __init atomisp2_led_init(void)
>> +{
>> +       const struct dmi_system_id *system;
>> +
>> +       system = dmi_first_match(atomisp2_led_systems);
>> +       if (!system)
>> +               return -ENODEV;
>> +
>> +       gpio_lookup = system->driver_data;
>> +       gpiod_add_lookup_table(gpio_lookup);
>> +
>> +       pdev = platform_device_register_resndata(NULL,
>> +                                                DEV_NAME, PLATFORM_DEVID_NONE,
>> +                                                NULL, 0, &atomisp2_leds_pdata,
>> +                                                sizeof(atomisp2_leds_pdata));
>> +       if (IS_ERR(pdev)) {
>> +               gpiod_remove_lookup_table(gpio_lookup);
>> +               return PTR_ERR(pdev);
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +static void __exit atomisp2_led_cleanup(void)
>> +{
>> +       platform_device_unregister(pdev);
>> +       gpiod_remove_lookup_table(gpio_lookup);
>> +}
>> +
>> +module_init(atomisp2_led_init);
>> +module_exit(atomisp2_led_cleanup);
>> +
>> +/*
>> + * The ACPI INIT method from Asus WMI's code on the T100TA and T200TA turns the
>> + * LED on (without the WMI interface allowing further control over the LED).
>> + * Ensure we are loaded after asus-nb-wmi so that we turn the LED off again.
>> + */
>> +MODULE_SOFTDEP("pre: asus_nb_wmi");
>> +MODULE_AUTHOR("Hans de Goede <hdegoede@redhat.com");
>> +MODULE_DESCRIPTION("Intel atomisp2 camera LED driver");
>> +MODULE_LICENSE("GPL");
>> --
>> 2.26.0
>>
> 
> 

