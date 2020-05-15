Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A446C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3805D20709
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 10:54:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MBp8l35N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgEOKyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 06:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726047AbgEOKyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 06:54:40 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFBCC061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:54:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z4so691070wmi.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 03:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=IwrZ0WdoI5tZaZzzOBHL3SSlbNqaieIG8m76ANK/LD8=;
        b=MBp8l35N8cKa9fTo/EyMr3FAsY3MQBon2114fVllM/wNd3CGTCAFUUlZAphgy5RCCy
         ghj+obFDAoKbTJqw4oE8AryLhZT6uxGd3xAx4IoKKrPHqLs679Iyvr8k5U6k5o2v3RBr
         2sV/5PVNAIP1LcYIEg6pqF8Avscb2kMgK6d9/fvRUYWef7VKipRs6M4IQigW01T2boG2
         Py4huMMZrexFmDFRF6i7bGE8FzueSLDOphT2qW9q9fg+9atNbtT1pIRBMbG9h8N4gYgE
         moXyl+1xyPlKAVm4JJr+At7nxv+16u9ouH+WSD4ePVjddrzrGB6j7//B0TN4CSapwohb
         vBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=IwrZ0WdoI5tZaZzzOBHL3SSlbNqaieIG8m76ANK/LD8=;
        b=Zk1QI2v+52OLzElj+y2ZQwXMmzvRAHvK7g2z/yCs4PFx/y4zlypZxFEFPzM0Rr2Nlk
         wrSMYBS1GDm0nmlaKt/b2Tl3xLV6aFmPRtKLBEAZf5CL/tmdrOITCjgMSfq0Uugme8W1
         UZN4pe0ITSm/4mZbl4TATGhE7yNTGJnfPVrPucDpyC6zI6CNXuKWdL0mxS7DrMVi6NNZ
         CVUFmqvX6fb9gNbXk1RO/lX1sqMG6xt+ZBtsAmHQpUditExIonJqlTohJFKWfG/95ADZ
         2WSR/tWF+Y5spNWM2PI+SLN7I4JcHzXUgbZNigwdxuH54sgHUUXAxuGs83mIJ0Y3dr2y
         RwBQ==
X-Gm-Message-State: AOAM532YpuRJxDnmL/NqyCC5z4q7CBQrOhkFvKqWkaP7q/yDTHH5VIck
        LCETP7RLuavYl7bdsxMJc377GQ==
X-Google-Smtp-Source: ABdhPJx+z4WBxH2HwMhoKEV3PPTzm/r8BuYaChb1qiTcaH/Ubdn66OddDUT3aEyOp6gk2w/z6HiMFg==
X-Received: by 2002:a05:600c:29a:: with SMTP id 26mr3595042wmk.151.1589540078883;
        Fri, 15 May 2020 03:54:38 -0700 (PDT)
Received: from dell ([2.31.163.63])
        by smtp.gmail.com with ESMTPSA id m82sm3215702wmf.3.2020.05.15.03.54.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:54:38 -0700 (PDT)
Date:   Fri, 15 May 2020 11:54:36 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        linux-hwmon@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Robert Jones <rjones@gateworks.com>
Subject: Re: [PATCH v9 2/3] mfd: add Gateworks System Controller core driver
Message-ID: <20200515105436.GL271301@dell>
References: <1588259247-15536-1-git-send-email-tharvey@gateworks.com>
 <1588259247-15536-3-git-send-email-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1588259247-15536-3-git-send-email-tharvey@gateworks.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Apr 2020, Tim Harvey wrote:

> The Gateworks System Controller (GSC) is an I2C slave controller
> implemented with an MSP430 micro-controller whose firmware embeds the
> following features:
>  - I/O expander (16 GPIO's) using PCA955x protocol
>  - Real Time Clock using DS1672 protocol
>  - User EEPROM using AT24 protocol
>  - HWMON using custom protocol
>  - Interrupt controller with tamper detect, user pushbotton
>  - Watchdog controller capable of full board power-cycle
>  - Power Control capable of full board power-cycle
> 
> see http://trac.gateworks.com/wiki/gsc for more details
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> ---
> v9:
> - rebase against 5.7-rc2
> - cleanup gsc_powerdown() by using BIT(), put_unaligned_le32(), and avoid
>   unnecessary assignments
> - rename GSC_CTRL_1 SLEEP related defines to simplify
> - add better description and sub-module info to driver description
> - whitespace changes per review
> - remove unused irq_data pointer in ddata
> - remove unnecesary i2c_set_clientdata
> - use devm_i2c_new_dummy_device to avoid need of free's
> - change regsiter definitions to enum
> - export gsc_{read,write} instead of sharing them via ddata
> 
> v8:
> - whitespace fixes
> - describe sub-devices in Kconfig
> - add error print for invalid command
> - update copyright
> - use devm_of_platform_populate
> - use probe_new
> - move hwmon's regmap init to hwmon
> 
> v7:
> - remove irq from private data struct
> 
> v6:
> - remove duplicate signature and fix commit log
> 
> v5:
> - simplify powerdown function
> 
> v4:
> - remove hwmon max reg check/define
> - fix powerdown function
> 
> v3:
> - rename gsc->gateworks-gsc
> - remove uncecessary include for linux/mfd/core.h
> - upercase I2C in comments
> - remove i2c debug
> - remove uncecessary comments
> - don't use KBUILD_MODNAME for name
> - remove unnecessary v1/v2/v3 tracking
> - unregister hwmon i2c adapter on remove
> 
> v2:
> - change license comment block style
> - remove COMPILE_TEST (Randy)
> - fixed whitespace issues
> - replaced a printk with dev_err
> ---
>  MAINTAINERS                 |   8 ++
>  drivers/mfd/Kconfig         |  16 +++
>  drivers/mfd/Makefile        |   1 +
>  drivers/mfd/gateworks-gsc.c | 284 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/gsc.h     |  76 ++++++++++++
>  5 files changed, 385 insertions(+)
>  create mode 100644 drivers/mfd/gateworks-gsc.c
>  create mode 100644 include/linux/mfd/gsc.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b816a45..035dfb9 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7032,6 +7032,14 @@ F:	kernel/futex.c
>  F:	tools/perf/bench/futex*
>  F:	tools/testing/selftests/futex/
>  
> +GATEWORKS SYSTEM CONTROLLER (GSC) DRIVER
> +M:	Tim Harvey <tharvey@gateworks.com>
> +M:	Robert Jones <rjones@gateworks.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/mfd/gateworks-gsc.yaml
> +F:	drivers/mfd/gateworks-gsc.c
> +F:	include/linux/mfd/gsc.h
> +
>  GASKET DRIVER FRAMEWORK
>  M:	Rob Springer <rspringer@google.com>
>  M:	Todd Poynor <toddpoynor@google.com>
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0a59249..d7546cd 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -407,6 +407,22 @@ config MFD_EXYNOS_LPASS
>  	  Select this option to enable support for Samsung Exynos Low Power
>  	  Audio Subsystem.
>  
> +config MFD_GATEWORKS_GSC
> +	tristate "Gateworks System Controller"
> +	depends on (I2C && OF)
> +	select MFD_CORE
> +	select REGMAP_I2C
> +	select REGMAP_IRQ
> +	help
> +	  Enable support for the Gateworks System Controller (GSC) found
> +	  on Gateworks Single Board Computers supporting system system

"system"

> +	  functions such as pushbutton monitor, multiple ADC's for voltage

"push-button"

> +	  and temperature, fan controller, and watchdog monitor. This

"voltage and temperature" what?

Monitoring, adjusting, guessing, mixing, matching?

I'd drop the pre-and comma myself.

> +	  driver provides common support for accessing the device and

Turn the "and" into a full-stop.

> +	  additional drivers must be enabled in order to use the
> +	  functionality of the device:
> +		gsc-hwmon for ADC readings and fan controller support

What does this line represent?  Is it an example?

>  config MFD_MC13XXX
>  	tristate
>  	depends on (SPI_MASTER || I2C)
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index f935d10..ed433ae 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -15,6 +15,7 @@ obj-$(CONFIG_MFD_BCM590XX)	+= bcm590xx.o
>  obj-$(CONFIG_MFD_BD9571MWV)	+= bd9571mwv.o
>  obj-$(CONFIG_MFD_CROS_EC_DEV)	+= cros_ec_dev.o
>  obj-$(CONFIG_MFD_EXYNOS_LPASS)	+= exynos-lpass.o
> +obj-$(CONFIG_MFD_GATEWORKS_GSC)	+= gateworks-gsc.o
>  
>  obj-$(CONFIG_HTC_PASIC3)	+= htc-pasic3.o
>  obj-$(CONFIG_HTC_I2CPLD)	+= htc-i2cpld.o
> diff --git a/drivers/mfd/gateworks-gsc.c b/drivers/mfd/gateworks-gsc.c
> new file mode 100644
> index 00000000..796effb
> --- /dev/null
> +++ b/drivers/mfd/gateworks-gsc.c
> @@ -0,0 +1,284 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The Gateworks System Controller (GSC) is a multi-function
> + * device designed for use in Gateworks Single Board Computers.
> + * The control interface is I2C, with an interrupt. The device supports
> + * system functions such as pushbutton monitoring, multiple ADC's for
> + * voltage and temperature, fan controller, and watchdog monitor.

As above.

> + * Copyright (C) 2020 Gateworks Corporation
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/mfd/gsc.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include <asm/unaligned.h>

[...]

> +static const struct i2c_device_id gsc_id_table[] = {
> +	{ "gsc", GSC_MISC },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, gsc_id_table);

Using probe_new means you can omit this unused table.

Once all of the above has been fixed, please add my:


For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
