Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E905CC5ACD8
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:44:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B026120714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:44:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks-com.20150623.gappssmtp.com header.i=@gateworks-com.20150623.gappssmtp.com header.b="ne+bVIFR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgCQRoU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:44:20 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33695 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbgCQRoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:44:19 -0400
Received: by mail-ot1-f65.google.com with SMTP id x26so5549278otk.0
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 10:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HFObV0SspXma1gLo5gg6wz6AEKM5WgviBnCNdKtRKgU=;
        b=ne+bVIFRKWbvsEFwYhkf7+KIi+MANbz/V+ZJeByU8P2/DmFk2G4m83PxdKxp14ZcyZ
         zpwcxW3Q/0jmHunemkBhZeEPnLWnDHgffP+YxHm5MkqUx4TxPhzxRkGStLVz3DvPpdNB
         dwmc58QWAwjatkC+hkCLDQC8XLreSV1Hlay2BRDjaFXacT1hvgKONvUPE37D7idzZkRI
         F6m6NaZmFEw/Um4fSpLT/yA30FyLmtbJvMvIcFAsjkflCF0WJsKXcFwO+qfw0n3hzJJd
         3oZs9wrI7l5TRThsC9zKWUtQM37zdpS32x5ieEgBUMAJdGFtZiY7INTl8fohCEaDHjKk
         YtWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HFObV0SspXma1gLo5gg6wz6AEKM5WgviBnCNdKtRKgU=;
        b=C90SVqMoeUM7gXxQQzYAld2qEgSb18yL6VET2ApCCXUWufqVTPm5J6M5iyX+N759P4
         667/TFnC/5fUIFyfV/LcIiIOaukXIKAoBmPlWlKoocRKo6T914ehDB6F7Q3uhrrUP7Uz
         3hpZl3JQfmBxJYzNPyyoAWPbWWr5qRtuHSxrFAtq6xZ9d89QOz+y/DGRWvsAGV+jxIvA
         RAMV0RWmdDWf1hIdBlE6MY1jqUMnPn5An1CZuRfxqDZ/S6GxTHTzKuccZ4BLi6sjY0eT
         yCYgbgfUsNKeTipvy7dM3Gl1amKV/aMcwqaGA1eCWCerfs0v+VTMrnRydVTfmg8IWuo8
         XjIA==
X-Gm-Message-State: ANhLgQ1j179bz3neeMpe3A2E0DoiynEF99H6QOO8MvSNO+i/pDqE9fMb
        2xuN2ai25FpKhKDFU0S88p1zWNq7XTrATslcIBT/Pw==
X-Google-Smtp-Source: ADFU+vvTUir1AUne+7NEC2On9ZdgUJLPHpEJZX9GlK21WrFda8uHLpjtU7BW6sdX6h575+/z1dUqSCMKlnsKqda5gNg=
X-Received: by 2002:a05:6830:1e06:: with SMTP id s6mr385357otr.28.1584467057819;
 Tue, 17 Mar 2020 10:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <1584464453-28200-1-git-send-email-tharvey@gateworks.com>
 <1584464453-28200-4-git-send-email-tharvey@gateworks.com> <8570eb47-d446-9fcb-1033-682114c9ca59@roeck-us.net>
In-Reply-To: <8570eb47-d446-9fcb-1033-682114c9ca59@roeck-us.net>
From:   Tim Harvey <tharvey@gateworks.com>
Date:   Tue, 17 Mar 2020 10:44:06 -0700
Message-ID: <CAJ+vNU0oc17q-Ajgh29hAZRNeTa+CeRfKjz22-33XqHOdYwQyA@mail.gmail.com>
Subject: Re: [PATCH v6 3/3] hwmon: add Gateworks System Controller support
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Lee Jones <lee.jones@linaro.org>, Jean Delvare <jdelvare@suse.com>,
        Linux HWMON List <linux-hwmon@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Robert Jones <rjones@gateworks.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 10:18 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/17/20 10:00 AM, Tim Harvey wrote:
> > The Gateworks System Controller has a hwmon sub-component that exposes
> > up to 16 ADC's, some of which are temperature sensors, others which are
> > voltage inputs. The ADC configuration (register mapping and name) is
> > configured via device-tree and varies board to board.
> >
> > Cc: Guenter Roeck <linux@roeck-us.net>
> > Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> > ---
> > v6:
> > - fix size of info field
> > - improve pwm output control documentation
> > - include unit suffix in divider and offset
> > - change adc subnode name to gsc-adc
> > - change fan base to fan subnode
> > - change adc type to mode
> > - fix voltage offset scaling
> >
> > v5:
> > - fix various checkpatch issues
> > - correct gsc-hwmon.rst in MAINTAINERS
> > - encorporate Gunter's feedback:
> >  - switch to SENSOR_DEVICE_ATTR_{RW,RO}
> >  - use tmp value to avoid excessive pointer deference
> >  - simplify shift operation
> >  - scale voffset once
> >  - simplify is_visible function
> >  - remove empty line at end of file
> >
> > v4:
> > - adjust for uV offset from device-tree
> > - remove unnecessary optional write function
> > - remove register range check
> > - change dev_err prints to use gsc dev
> > - hard-code resolution/scaling for raw adcs
> > - describe units of ADC resolution
> > - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
> > - ensure space before/after operators
> > - remove unnecessary parens
> > - remove more debugging
> > - add default case and comment for type_voltage
> > - remove unnecessary index bounds checks for channel
> > - remove unnecessary clearing of struct fields
> > - added Documentation/hwmon/gsc-hwmon.rst
> >
> > v3:
> > - add voltage_raw input type and supporting fields
> > - add channel validation to is_visible function
> > - remove unnecessary channel validation from read/write functions
> >
> > v2:
> > - change license comment style
> > - remove DEBUG
> > - simplify regmap_bulk_read err check
> > - remove break after returns in switch statement
> > - fix fan setpoint buffer address
> > - remove unnecessary parens
> > - consistently use struct device *dev pointer
> > - change license/comment block
> > - add validation for hwmon child node props
> > - move parsing of of to own function
> > - use strlcpy to ensure null termination
> > - fix static array sizes and removed unnecessary initializers
> > - dynamically allocate channels
> > - fix fan input label
> > - support platform data
> > - fixed whitespace issues
> > ---
> >  Documentation/hwmon/gsc-hwmon.rst       |  53 +++++
> >  Documentation/hwmon/index.rst           |   1 +
> >  MAINTAINERS                             |   3 +
> >  drivers/hwmon/Kconfig                   |   9 +
> >  drivers/hwmon/Makefile                  |   1 +
> >  drivers/hwmon/gsc-hwmon.c               | 372 ++++++++++++++++++++++++++++++++
> >  include/linux/platform_data/gsc_hwmon.h |  44 ++++
> >  7 files changed, 483 insertions(+)
> >  create mode 100644 Documentation/hwmon/gsc-hwmon.rst
> >  create mode 100644 drivers/hwmon/gsc-hwmon.c
> >  create mode 100644 include/linux/platform_data/gsc_hwmon.h
> >
> > diff --git a/Documentation/hwmon/gsc-hwmon.rst b/Documentation/hwmon/gsc-hwmon.rst
> > new file mode 100644
> > index 00000000..ffac392
> > --- /dev/null
> > +++ b/Documentation/hwmon/gsc-hwmon.rst
> > @@ -0,0 +1,53 @@
> > +.. SPDX-License-Identifier: GPL-2.0
> > +
> > +Kernel driver gsc-hwmon
> > +=======================
> > +
> > +Supported chips: Gateworks GSC
> > +Datasheet: http://trac.gateworks.com/wiki/gsc
> > +Author: Tim Harvey <tharvey@gateworks.com>
> > +
> > +Description:
> > +------------
> > +
> > +This driver supports hardware monitoring for the temperature sensor,
> > +various ADC's connected to the GSC, and optional FAN controller available
> > +on some boards.
> > +
> > +
> > +Voltage Monitoring
> > +------------------
> > +
> > +The voltage inputs are scaled either internally or by the driver depending
> > +on the GSC version and firmware. The values returned by the driver do not need
> > +further scaling. The voltage input labels provide the voltage rail name:
> > +
> > +inX_input                  Measured voltage (mV).
> > +inX_label                  Name of voltage rail.
> > +
> > +
> > +Temperature Monitoring
> > +----------------------
> > +
> > +Temperatures are measured with 12-bit or 10-bit resolution and are scaled
> > +either internally or by the driver depending on the GSC version and firmware.
> > +The values returned by the driver reflect millidegree Celcius:
> > +
> > +tempX_input                Measured temperature.
> > +tempX_label                Name of temperature input.
> > +
> > +
> > +PWM Output Control
> > +------------------
> > +
> > +The GSC features 1 PWM output that operates in automatic mode where the
> > +PWM value will be scalled depending on 6 temperature boundaries.
> > +The tempeature boundaries are read-write and in millidegree Celcius and the
> > +read-only PWM values range from 0 (off) to 255 (full speed).
> > +Fan speed will be set to minimum (off) when the temperature sensor reads
> > +less than pwm1_auto_point1_temp and maximum when the temperature sensor
> > +equals or exceeds pwm1_auto_point6_temp.
> > +
> > +pwm1_auto_point[1-6]_pwm       PWM value.
> > +pwm1_auto_point[1-6]_temp      Temperature boundary.
> > +
> > diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> > index 43cc605..a4fab69 100644
> > --- a/Documentation/hwmon/index.rst
> > +++ b/Documentation/hwmon/index.rst
> > @@ -58,6 +58,7 @@ Hardware Monitoring Kernel Drivers
> >     ftsteutates
> >     g760a
> >     g762
> > +   gsc-hwmon
> >     gl518sm
> >     hih6130
> >     ibmaem
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index bb79b60..3f15542 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6846,6 +6846,9 @@ S:      Maintained
> >  F:   Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> >  F:   drivers/mfd/gateworks-gsc.c
> >  F:   include/linux/mfd/gsc.h
> > +F:   Documentation/hwmon/gsc-hwmon.rst
> > +F:   drivers/hwmon/gsc-hwmon.c
> > +F:   include/linux/platform_data/gsc_hwmon.h
> >
> >  GCC PLUGINS
> >  M:   Kees Cook <keescook@chromium.org>
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 23dfe84..99dae13 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -494,6 +494,15 @@ config SENSORS_F75375S
> >         This driver can also be built as a module. If so, the module
> >         will be called f75375s.
> >
> > +config SENSORS_GSC
> > +        tristate "Gateworks System Controller ADC"
> > +        depends on MFD_GATEWORKS_GSC
> > +        help
> > +          Support for the Gateworks System Controller A/D converters.
> > +
> > +       To compile this driver as a module, choose M here:
> > +       the module will be called gsc-hwmon.
> > +
> >  config SENSORS_MC13783_ADC
> >          tristate "Freescale MC13783/MC13892 ADC"
> >          depends on MFD_MC13XXX
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 6db5db9..259cba7 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -71,6 +71,7 @@ obj-$(CONFIG_SENSORS_G760A) += g760a.o
> >  obj-$(CONFIG_SENSORS_G762)   += g762.o
> >  obj-$(CONFIG_SENSORS_GL518SM)        += gl518sm.o
> >  obj-$(CONFIG_SENSORS_GL520SM)        += gl520sm.o
> > +obj-$(CONFIG_SENSORS_GSC)    += gsc-hwmon.o
> >  obj-$(CONFIG_SENSORS_GPIO_FAN)       += gpio-fan.o
> >  obj-$(CONFIG_SENSORS_HIH6130)        += hih6130.o
> >  obj-$(CONFIG_SENSORS_ULTRA45)        += ultra45_env.o
> > diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> > new file mode 100644
> > index 00000000..c498786
> > --- /dev/null
> > +++ b/drivers/hwmon/gsc-hwmon.c
> > @@ -0,0 +1,372 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Driver for Gateworks System Controller Hardware Monitor module
> > + *
> > + * Copyright (C) 2020 Gateworks Corporation
> > + */
> > +#include <linux/hwmon.h>
> > +#include <linux/hwmon-sysfs.h>
> > +#include <linux/mfd/gsc.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regmap.h>
> > +#include <linux/slab.h>
> > +
> > +#include <linux/platform_data/gsc_hwmon.h>
> > +
> > +#define GSC_HWMON_MAX_TEMP_CH        16
> > +#define GSC_HWMON_MAX_IN_CH  16
> > +
> > +#define GSC_HWMON_RESOLUTION 12
> > +#define GSC_HWMON_VREF               2500
> > +
> > +struct gsc_hwmon_data {
> > +     struct gsc_dev *gsc;
> > +     struct device *dev;
>
> What is 'dev' used for ? I don't think it is necessary.
>

Agreed - will remove.

Thanks!

Tim
