Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC0FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12FA320823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 21:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7/JdmWV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390466AbgFXVSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 17:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389773AbgFXVSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 17:18:09 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9919FC061573;
        Wed, 24 Jun 2020 14:18:09 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t6so2079136pgq.1;
        Wed, 24 Jun 2020 14:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NRzCLA7O4yoo4CK0D6JzW9iY/LolqowIQ1VcLyZX85w=;
        b=H7/JdmWVIO5T5GxbQ2aid1gD1aMhLZBIoNy0Ck5MkDloSN6GJa9Cjk8j8oYXhanuV5
         3qQQe8IRz+XyZ9XxwDeeGTtTMLEpVN2CluHCF5NsD/T2YWI4LrAebdB7bBwv/KQw0bus
         ey5HxlGfor8aZp/F1uPq1ppb/Tsw84hvEiZvVKzybRrhjMKEy/SNzuvpn74Co5FwvIOW
         GzM0byLxEusjhUayBfdSzoDEKxifof52BoCPXeun62SoXXvUbMpQt/iSsVJtw8ULoT8m
         MxI3Ne3Xb0pVsVKlnvnAyVJ6D9QVJFZJ4DKt/x571T8s+k60cQdvVF3hCFXKvcY5pQ8K
         ob+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=NRzCLA7O4yoo4CK0D6JzW9iY/LolqowIQ1VcLyZX85w=;
        b=d2sYmKE7EvITS/fDiTkgcmm2m0y3YkIcX/oDohlt9K0NIE5bJP5G1hyNPXnyGOIy0k
         wC2Y2AkOhUoB+qsP/d82hjRoMXsVd5x25MHfAxNbJEM0FYrdcnMDPU2SzJCfHgIDtA7Q
         SdO6dpOnm7unqA/FP8jak11rLljGH1fjioXFwK5A720uFIxS3IahCp7FWuTQeYlajZGe
         q1+xTQaC649+Plcpde1o+p1OxRS7IJpejhO37aZErNRYJMQI8LfnoZ9TxeucUdt/4GC0
         WVXezA9P2mBXUE4b/wmFAuWQqNFCZW4wpjeZ0oUu93yaqHBq93EGfccbED8yGgUCTmA6
         qDag==
X-Gm-Message-State: AOAM533TK6GwRA3HFMAON/vetPxWgfH44o0QJ8vjxxohewgytVO22JDp
        nLm8QwthYD2yt7dSyU2A+eI=
X-Google-Smtp-Source: ABdhPJwA/MRTNNMwZys901eyc1IpyqubmLQ3cTtXEX8Lkv0SCtEDweT8ZT23q233+ptPVmsACNkdgQ==
X-Received: by 2002:a63:e23:: with SMTP id d35mr16527434pgl.435.1593033488974;
        Wed, 24 Jun 2020 14:18:08 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u74sm17246504pgc.58.2020.06.24.14.18.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Jun 2020 14:18:08 -0700 (PDT)
Date:   Wed, 24 Jun 2020 14:18:07 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     alexandru.tachici@analog.com
Cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh+dt@kernel.org
Subject: Re: [PATCH v4 1/7] hwmon: pmbus: adm1266: add support
Message-ID: <20200624211807.GA73801@roeck-us.net>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
 <20200623173659.41358-2-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623173659.41358-2-alexandru.tachici@analog.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 08:36:53PM +0300, alexandru.tachici@analog.com wrote:
> From: Alexandru Tachici <alexandru.tachici@analog.com>
> 
> Add pmbus probing driver for the adm1266 Cascadable
> Super Sequencer with Margin Control and Fault Recording.
> Driver is using the pmbus_core, creating sysfs files
> under hwmon for inputs: vh1->vh4 and vp1->vp13.
> 
> Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
> ---
>  Documentation/hwmon/adm1266.rst | 35 +++++++++++++++++++

Needs to be added to index.rst.

>  drivers/hwmon/pmbus/Kconfig     |  9 +++++
>  drivers/hwmon/pmbus/Makefile    |  1 +
>  drivers/hwmon/pmbus/adm1266.c   | 62 +++++++++++++++++++++++++++++++++
>  4 files changed, 107 insertions(+)
>  create mode 100644 Documentation/hwmon/adm1266.rst
>  create mode 100644 drivers/hwmon/pmbus/adm1266.c
> 
> diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
> new file mode 100644
> index 000000000000..65662115750c
> --- /dev/null
> +++ b/Documentation/hwmon/adm1266.rst
> @@ -0,0 +1,35 @@

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#99: FILE: Documentation/hwmon/adm1266.rst:1:
+Kernel driver adm1266

> +Kernel driver adm1266
> +=====================
> +
> +Supported chips:
> +  * Analog Devices ADM1266
> +    Prefix: 'adm1266'
> +    Datasheet: https://www.analog.com/media/en/technical-documentation/data-sheets/ADM1266.pdf
> +
> +Author: Alexandru Tachici <alexandru.tachici@analog.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports hardware monitoring for Analog Devices ADM1266 sequencer.
> +
> +ADM1266 is a sequencer that features voltage readback from 17 channels via an
> +integrated 12 bit SAR ADC, accessed using a PMBus interface.
> +
> +The driver is a client driver to the core PMBus driver. Please see
> +Documentation/hwmon/pmbus for details on PMBus client drivers.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported. Limits are read-write, history reset
> +attributes are write-only, all other attributes are read-only.
> +
> +inX_label		"voutx"
> +inX_input		Measured voltage.
> +inX_min			Minimum Voltage.
> +inX_max			Maximum voltage.
> +inX_min_alarm		Voltage low alarm.
> +inX_max_alarm		Voltage high alarm.
> diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
> index de12a565006d..6949483aa732 100644
> --- a/drivers/hwmon/pmbus/Kconfig
> +++ b/drivers/hwmon/pmbus/Kconfig
> @@ -26,6 +26,15 @@ config SENSORS_PMBUS
>  	  This driver can also be built as a module. If so, the module will
>  	  be called pmbus.
>  
> +config SENSORS_ADM1266
> +	tristate "Analog Devices ADM1266 Sequencer"
> +	help
> +	  If you say yes here you get hardware monitoring support for Analog
> +	  Devices ADM1266 Cascadable Super Sequencer.
> +
> +	  This driver can also be built as a module. If so, the module will
> +	  be called adm1266.
> +
>  config SENSORS_ADM1275
>  	tristate "Analog Devices ADM1275 and compatibles"
>  	help
> diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
> index 5feb45806123..ed38f6d6f845 100644
> --- a/drivers/hwmon/pmbus/Makefile
> +++ b/drivers/hwmon/pmbus/Makefile
> @@ -5,6 +5,7 @@
>  
>  obj-$(CONFIG_PMBUS)		+= pmbus_core.o
>  obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
> +obj-$(CONFIG_SENSORS_ADM1266)	+= adm1266.o
>  obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
>  obj-$(CONFIG_SENSORS_BEL_PFE)	+= bel-pfe.o
>  obj-$(CONFIG_SENSORS_IBM_CFFPS)	+= ibm-cffps.o
> diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
> new file mode 100644
> index 000000000000..a7ef048a9a5c
> --- /dev/null
> +++ b/drivers/hwmon/pmbus/adm1266.c
> @@ -0,0 +1,62 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ADM1266 - Cascadable Super Sequencer with Margin
> + * Control and Fault Recording
> + *
> + * Copyright 2020 Analog Devices Inc.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/init.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>

Alphabetic include file order, please.

> +
> +#include "pmbus.h"
> +
> +static int adm1266_probe(struct i2c_client *client,
> +			 const struct i2c_device_id *id)
> +{
> +	struct pmbus_driver_info *info;
> +	u32 funcs;
> +	int i;
> +
> +	info = devm_kzalloc(&client->dev, sizeof(struct pmbus_driver_info),
> +			    GFP_KERNEL);
> +
> +	info->pages = 17;
> +	info->format[PSC_VOLTAGE_OUT] = linear;
> +	funcs = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
> +	for (i = 0; i < info->pages; i++)
> +		info->func[i] = funcs;

		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;

and drop the variable.

> +
> +	return pmbus_do_probe(client, id, info);
> +}
> +
> +static const struct of_device_id adm1266_of_match[] = {
> +	{ .compatible = "adi,adm1266" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, adm1266_of_match);
> +
> +static const struct i2c_device_id adm1266_id[] = {
> +	{ "adm1266", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, adm1266_id);
> +
> +static struct i2c_driver adm1266_driver = {
> +	.driver = {
> +		   .name = "adm1266",
> +		   .of_match_table = adm1266_of_match,
> +		  },
> +	.probe = adm1266_probe,
> +	.remove = pmbus_do_remove,
> +	.id_table = adm1266_id,
> +};
> +
> +module_i2c_driver(adm1266_driver);
> +
> +MODULE_AUTHOR("Alexandru Tachici <alexandru.tachici@analog.com>");
> +MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1266");
> +MODULE_LICENSE("GPL v2");
