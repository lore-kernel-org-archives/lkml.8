Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39769C2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE92720738
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 17:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bO2Ol9Qq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgCQRSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 13:18:39 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33166 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgCQRSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 13:18:38 -0400
Received: by mail-pf1-f194.google.com with SMTP id n7so12319399pfn.0;
        Tue, 17 Mar 2020 10:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AwDUYbbc9sQvzgDy88Jgxy04udQ8jSEFrmrd2aWxxEY=;
        b=bO2Ol9QqjRfCK8MYLA9bRWrnKw92H5OkTKg56d6uJjXdU7XDKdOM5wgJYVGZguu1rO
         PAE2NVJvM//QNg6D09k54DKzgyANweDGan2tC7r3l596HxSpG+uVqZdoAwVzCCo3Fwu4
         Gp6d+ai6JuiRZPZicCkjPQRf5mVGx6OLctOnbJ/BIeQQ+sXE4yQu+uYhAJ7N0PKGIEt1
         I+AZnkDWMWbKSmazi/0uB22KuZn1Hs5Tmi1zcJy7Th2YKNAceDcWakhHcycdCWd7Xxq5
         wJPQUUiIXt1F/3YpK1Y4+7ygR31zXdzQhie/OHvuLX/ilQvuAkyP1hAgjin7Y6MR5srm
         3Csg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=AwDUYbbc9sQvzgDy88Jgxy04udQ8jSEFrmrd2aWxxEY=;
        b=Ic+b7wgs8lizPLn16IsDZxUonBCRqeYeKTM+8KepYNCYYRWz20Ip6zeJZgUTXyKfkY
         RNePbTWTklPuOXf1zFMi0gwP6hMNdruFikve7t+n81ebGb6rsepbk2T2eMyzzRxFVxzy
         mRxcvMJ77uIQwZ8VsGoJ6UX61+LfYXwn1Lcx28bGiidGSQf2dEpLI3PHDbspQ9Wi+tQ8
         q9AhNFdoxUoVZyhfbxO+YELxbQ6OwR9ieEfSB22obEQh0PPfT6HUJhr+B4hpfB6uQPQX
         5AljWg3pydWtJpK46fgE7Ld9I+Cw0LcVCv1vVTWRfjp9G1EDUv0L/dGaCS6RvARGqQUt
         euSw==
X-Gm-Message-State: ANhLgQ2cK9Ke4G1JUu/Ixg5VFPcEsDZL9yz768yEdVJLlnR1mIuBgplO
        TQimzZD7Tsl7srzqFOb1UdA=
X-Google-Smtp-Source: ADFU+vuyRlED4urxAZEtvVWvtyERvOV+Ak1uNKkrvzP5yMazp0Dtl66J4kom5PQ1+hucSfdbsyB9OA==
X-Received: by 2002:aa7:9348:: with SMTP id 8mr6487917pfn.36.1584465515882;
        Tue, 17 Mar 2020 10:18:35 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l7sm3768165pff.204.2020.03.17.10.18.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 10:18:34 -0700 (PDT)
Subject: Re: [PATCH v6 3/3] hwmon: add Gateworks System Controller support
To:     Tim Harvey <tharvey@gateworks.com>,
        Lee Jones <lee.jones@linaro.org>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
References: <1584464453-28200-1-git-send-email-tharvey@gateworks.com>
 <1584464453-28200-4-git-send-email-tharvey@gateworks.com>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <8570eb47-d446-9fcb-1033-682114c9ca59@roeck-us.net>
Date:   Tue, 17 Mar 2020 10:18:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1584464453-28200-4-git-send-email-tharvey@gateworks.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/17/20 10:00 AM, Tim Harvey wrote:
> The Gateworks System Controller has a hwmon sub-component that exposes
> up to 16 ADC's, some of which are temperature sensors, others which are
> voltage inputs. The ADC configuration (register mapping and name) is
> configured via device-tree and varies board to board.
> 
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v6:
> - fix size of info field
> - improve pwm output control documentation
> - include unit suffix in divider and offset
> - change adc subnode name to gsc-adc
> - change fan base to fan subnode
> - change adc type to mode
> - fix voltage offset scaling
> 
> v5:
> - fix various checkpatch issues
> - correct gsc-hwmon.rst in MAINTAINERS
> - encorporate Gunter's feedback:
>  - switch to SENSOR_DEVICE_ATTR_{RW,RO}
>  - use tmp value to avoid excessive pointer deference
>  - simplify shift operation
>  - scale voffset once
>  - simplify is_visible function
>  - remove empty line at end of file
> 
> v4:
> - adjust for uV offset from device-tree
> - remove unnecessary optional write function
> - remove register range check
> - change dev_err prints to use gsc dev
> - hard-code resolution/scaling for raw adcs
> - describe units of ADC resolution
> - move to using pwm<n>_auto_point<m>_{pwm,temp} for FAN PWM
> - ensure space before/after operators
> - remove unnecessary parens
> - remove more debugging
> - add default case and comment for type_voltage
> - remove unnecessary index bounds checks for channel
> - remove unnecessary clearing of struct fields
> - added Documentation/hwmon/gsc-hwmon.rst
> 
> v3:
> - add voltage_raw input type and supporting fields
> - add channel validation to is_visible function
> - remove unnecessary channel validation from read/write functions
> 
> v2:
> - change license comment style
> - remove DEBUG
> - simplify regmap_bulk_read err check
> - remove break after returns in switch statement
> - fix fan setpoint buffer address
> - remove unnecessary parens
> - consistently use struct device *dev pointer
> - change license/comment block
> - add validation for hwmon child node props
> - move parsing of of to own function
> - use strlcpy to ensure null termination
> - fix static array sizes and removed unnecessary initializers
> - dynamically allocate channels
> - fix fan input label
> - support platform data
> - fixed whitespace issues
> ---
>  Documentation/hwmon/gsc-hwmon.rst       |  53 +++++
>  Documentation/hwmon/index.rst           |   1 +
>  MAINTAINERS                             |   3 +
>  drivers/hwmon/Kconfig                   |   9 +
>  drivers/hwmon/Makefile                  |   1 +
>  drivers/hwmon/gsc-hwmon.c               | 372 ++++++++++++++++++++++++++++++++
>  include/linux/platform_data/gsc_hwmon.h |  44 ++++
>  7 files changed, 483 insertions(+)
>  create mode 100644 Documentation/hwmon/gsc-hwmon.rst
>  create mode 100644 drivers/hwmon/gsc-hwmon.c
>  create mode 100644 include/linux/platform_data/gsc_hwmon.h
> 
> diff --git a/Documentation/hwmon/gsc-hwmon.rst b/Documentation/hwmon/gsc-hwmon.rst
> new file mode 100644
> index 00000000..ffac392
> --- /dev/null
> +++ b/Documentation/hwmon/gsc-hwmon.rst
> @@ -0,0 +1,53 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Kernel driver gsc-hwmon
> +=======================
> +
> +Supported chips: Gateworks GSC
> +Datasheet: http://trac.gateworks.com/wiki/gsc
> +Author: Tim Harvey <tharvey@gateworks.com>
> +
> +Description:
> +------------
> +
> +This driver supports hardware monitoring for the temperature sensor,
> +various ADC's connected to the GSC, and optional FAN controller available
> +on some boards.
> +
> +
> +Voltage Monitoring
> +------------------
> +
> +The voltage inputs are scaled either internally or by the driver depending
> +on the GSC version and firmware. The values returned by the driver do not need
> +further scaling. The voltage input labels provide the voltage rail name:
> +
> +inX_input                  Measured voltage (mV).
> +inX_label                  Name of voltage rail.
> +
> +
> +Temperature Monitoring
> +----------------------
> +
> +Temperatures are measured with 12-bit or 10-bit resolution and are scaled
> +either internally or by the driver depending on the GSC version and firmware.
> +The values returned by the driver reflect millidegree Celcius:
> +
> +tempX_input                Measured temperature.
> +tempX_label                Name of temperature input.
> +
> +
> +PWM Output Control
> +------------------
> +
> +The GSC features 1 PWM output that operates in automatic mode where the
> +PWM value will be scalled depending on 6 temperature boundaries.
> +The tempeature boundaries are read-write and in millidegree Celcius and the
> +read-only PWM values range from 0 (off) to 255 (full speed).
> +Fan speed will be set to minimum (off) when the temperature sensor reads
> +less than pwm1_auto_point1_temp and maximum when the temperature sensor
> +equals or exceeds pwm1_auto_point6_temp.
> +
> +pwm1_auto_point[1-6]_pwm       PWM value.
> +pwm1_auto_point[1-6]_temp      Temperature boundary.
> +
> diff --git a/Documentation/hwmon/index.rst b/Documentation/hwmon/index.rst
> index 43cc605..a4fab69 100644
> --- a/Documentation/hwmon/index.rst
> +++ b/Documentation/hwmon/index.rst
> @@ -58,6 +58,7 @@ Hardware Monitoring Kernel Drivers
>     ftsteutates
>     g760a
>     g762
> +   gsc-hwmon
>     gl518sm
>     hih6130
>     ibmaem
> diff --git a/MAINTAINERS b/MAINTAINERS
> index bb79b60..3f15542 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6846,6 +6846,9 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
>  F:	drivers/mfd/gateworks-gsc.c
>  F:	include/linux/mfd/gsc.h
> +F:	Documentation/hwmon/gsc-hwmon.rst
> +F:	drivers/hwmon/gsc-hwmon.c
> +F:	include/linux/platform_data/gsc_hwmon.h
>  
>  GCC PLUGINS
>  M:	Kees Cook <keescook@chromium.org>
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 23dfe84..99dae13 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -494,6 +494,15 @@ config SENSORS_F75375S
>  	  This driver can also be built as a module. If so, the module
>  	  will be called f75375s.
>  
> +config SENSORS_GSC
> +        tristate "Gateworks System Controller ADC"
> +        depends on MFD_GATEWORKS_GSC
> +        help
> +          Support for the Gateworks System Controller A/D converters.
> +
> +	  To compile this driver as a module, choose M here:
> +	  the module will be called gsc-hwmon.
> +
>  config SENSORS_MC13783_ADC
>          tristate "Freescale MC13783/MC13892 ADC"
>          depends on MFD_MC13XXX
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 6db5db9..259cba7 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -71,6 +71,7 @@ obj-$(CONFIG_SENSORS_G760A)	+= g760a.o
>  obj-$(CONFIG_SENSORS_G762)	+= g762.o
>  obj-$(CONFIG_SENSORS_GL518SM)	+= gl518sm.o
>  obj-$(CONFIG_SENSORS_GL520SM)	+= gl520sm.o
> +obj-$(CONFIG_SENSORS_GSC)	+= gsc-hwmon.o
>  obj-$(CONFIG_SENSORS_GPIO_FAN)	+= gpio-fan.o
>  obj-$(CONFIG_SENSORS_HIH6130)	+= hih6130.o
>  obj-$(CONFIG_SENSORS_ULTRA45)	+= ultra45_env.o
> diff --git a/drivers/hwmon/gsc-hwmon.c b/drivers/hwmon/gsc-hwmon.c
> new file mode 100644
> index 00000000..c498786
> --- /dev/null
> +++ b/drivers/hwmon/gsc-hwmon.c
> @@ -0,0 +1,372 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for Gateworks System Controller Hardware Monitor module
> + *
> + * Copyright (C) 2020 Gateworks Corporation
> + */
> +#include <linux/hwmon.h>
> +#include <linux/hwmon-sysfs.h>
> +#include <linux/mfd/gsc.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +#include <linux/slab.h>
> +
> +#include <linux/platform_data/gsc_hwmon.h>
> +
> +#define GSC_HWMON_MAX_TEMP_CH	16
> +#define GSC_HWMON_MAX_IN_CH	16
> +
> +#define GSC_HWMON_RESOLUTION	12
> +#define GSC_HWMON_VREF		2500
> +
> +struct gsc_hwmon_data {
> +	struct gsc_dev *gsc;
> +	struct device *dev;

What is 'dev' used for ? I don't think it is necessary.

Guenter
