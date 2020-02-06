Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135CAC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C16E321741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:19:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora-corp-partner-google-com.20150623.gappssmtp.com header.i=@collabora-corp-partner-google-com.20150623.gappssmtp.com header.b="Ro6Vo+/9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgBFQTJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:19:09 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54457 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727392AbgBFQTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:19:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id g1so618522wmh.4
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 08:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=collabora-corp-partner-google-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BQ8igqJ1PW6ikDKGONAbl9+PHT1ZRlroanva6UJwgKw=;
        b=Ro6Vo+/9tpX/43HJox+ekDw+g90/S5Wo2SeYltizMZVsNR00BY+wbEhStREMNPlHu/
         DcCgfOIe2pxh10Uk0dQkU8R3D7GV62ELnKMBWNeZahXT4XEAhEpnJLUYhg/j4enCJASN
         iRS6z1pD6fyKyU/BMokOfEtvUsvlW6L/nsI2VSKAGwPULlZHSJVkn8KC/B6ElbiYtrRW
         5cgX6hu9OM3dVUYF9rMglweGqIRPkDiUXhgmQKbvRdaIjQu4J6x0UPnKMOd66cNxdE6s
         K5Zeeaa6qin/0bmK/35E6fagmf9jvhl9Zt4HPCIIQoDcp70JztHtehHtRjI5XlWMIleA
         UgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BQ8igqJ1PW6ikDKGONAbl9+PHT1ZRlroanva6UJwgKw=;
        b=kZAwVWdVL7p7h5szlAiZe5/L0dmSsox4F8GXow81CHuDJQ8xDFEpJwKZ1KnJPpzmI9
         6EsBCz8HBwC1z1Yxtk0dvWV5SQL+DslNsMjcOgR+KRyQDqIdQx5FSfpw6ZVbLFvh90kJ
         EqgoCeHPrW1HV1vPs98pn1CnCP+nc3V13p1qpuW8yjedzdIWRgktUFYiFUIaKOP80boU
         dlhmFyO2gQdHDfKxI/kO0UOuHnUQZL0xzdttuqDo6DMgeftL4qT1bM7DAdi4IS7q33ng
         brvcwxVnyhPo8WOGVfin0Wuzjdrn+mCyZU1vIby3AfKySAFcqeOljfyza3l3cqfpignx
         7RQg==
X-Gm-Message-State: APjAAAWzLH50FpXTbTKla9JR3zbv9JbToHIQkVZjfY/bISGak5ZdrTWx
        9ct/19aop+NuwXU8C6Ntwl3j
X-Google-Smtp-Source: APXvYqwSaiEIe8nnvllguVSl8W+WFUoJOZElEEjO1xrVjtCqc4W+P3/mQyY/1Xf/6XiX81Adivj7oA==
X-Received: by 2002:a1c:7205:: with SMTP id n5mr5630293wmc.9.1581005944609;
        Thu, 06 Feb 2020 08:19:04 -0800 (PST)
Received: from [192.168.1.15] ([84.236.220.84])
        by smtp.gmail.com with ESMTPSA id s1sm4962758wro.66.2020.02.06.08.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 08:19:04 -0800 (PST)
Subject: Re: [PATCH 1/3] platform/chrome: Add Type C connector class driver
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, bleung@chromium.org,
        Guenter Roeck <groeck@chromium.org>
References: <20200205205954.84503-1-pmalani@chromium.org>
 <20200205205954.84503-2-pmalani@chromium.org>
From:   Enric Balletbo i Serra 
        <enric.balletbo@collabora.corp-partner.google.com>
Message-ID: <544d31cc-e840-c91e-f65d-7f7b57ba1337@collabora.corp-partner.google.com>
Date:   Thu, 6 Feb 2020 17:19:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200205205954.84503-2-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant,

On 5/2/20 21:59, Prashant Malani wrote:
> Add a driver to implement the Type C connector class for Chrome OS
> devices with ECs (Embedded Controllers).
> 
> The driver relies on firmware device specifications for various port
> attributes. On ACPI platforms, this is specified using the logical
> device with HID GOOG0014. On DT platforms, this is specified using the
> DT node with compatible string "google,cros-ec-typec".
> 

If that's the case you should document this in a binding file. Will be this
driver a replacement of the cros-ec-extcon driver or is a different thing?

There is a device where I can test this?

> This patch reads the device FW node and uses the port attributes to
> register the typec ports with the Type C connector class framework, but
> doesn't do much else.
> 
> Subsequent patches will add more functionality to the driver, including
> obtaining current port information (polarity, vconn role, current power
> role etc.) after querying the EC.
> 
> Signed-off-by: Prashant Malani <pmalani@chromium.org>
> ---
>  drivers/platform/chrome/Kconfig         |  11 ++
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/cros_ec_typec.c | 228 ++++++++++++++++++++++++
>  3 files changed, 240 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 5f57282a28da00..1370dfd1ca1565 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -214,6 +214,17 @@ config CROS_EC_SYSFS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_sysfs.
>  
> +config CROS_EC_TYPEC
> +	tristate "ChromeOS EC Type-C Connector Control"
> +	depends on MFD_CROS_EC_DEV && TYPEC
> +	default n

Default value is already n, so you don't need to put it here. But I'd say that
we might be interested on have default MFD_CROS_EC_DEV like the other drivers.

> +	help
> +	  If you say Y here, you get support for accessing Type C connector
> +	  information from the Chrome OS EC.
> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called cros_ec_typec.
> +
>  config CROS_USBPD_LOGGER
>  	tristate "Logging driver for USB PD charger"
>  	depends on CHARGER_CROS_USBPD
> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
> index aacd5920d8a180..caf2a9cdb5e6d1 100644
> --- a/drivers/platform/chrome/Makefile
> +++ b/drivers/platform/chrome/Makefile
> @@ -12,6 +12,7 @@ obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
>  obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
>  obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
>  cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
> +obj-$(CONFIG_CROS_EC_TYPEC)		+= cros_ec_typec.o
>  obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
>  obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> new file mode 100644
> index 00000000000000..fe5659171c2a85
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -0,0 +1,228 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright 2020 Google LLC
> + *
> + * This driver provides the ability to view and manage Type C ports through the
> + * Chrome OS EC.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_data/cros_ec_commands.h>
> +#include <linux/platform_data/cros_ec_proto.h>
> +#include <linux/platform_device.h>
> +#include <linux/usb/typec.h>
> +
> +#define DRV_NAME "cros-ec-typec"
> +
> +/* Platform-specific data for the Chrome OS EC Type C controller. */
> +struct cros_typec_data {
> +	struct device *dev;
> +	struct cros_ec_device *ec;
> +	int num_ports;
> +	/* Array of ports, indexed by port number. */
> +	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
> +};
> +
> +int cros_typec_parse_port_props(struct typec_capability *cap,

static int

> +				struct fwnode_handle *fwnode,
> +				struct device *dev)
> +{
> +	const char *buf;
> +	int ret;
> +
> +	memset(cap, 0, sizeof(*cap));
> +	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "power-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = typec_find_port_power_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->type = ret;
> +
> +	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "data-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = typec_find_port_data_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->data = ret;
> +
> +	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
> +	if (ret) {
> +		dev_err(dev, "try-power-role not found: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = typec_find_power_role(buf);
> +	if (ret < 0)
> +		return ret;
> +	cap->prefer_role = ret;
> +
> +	cap->fwnode = fwnode;
> +
> +	return 0;
> +}
> +
> +static int cros_typec_init_ports(struct cros_typec_data *typec)
> +{
> +	struct device *dev = typec->dev;
> +	struct typec_capability cap;
> +	struct fwnode_handle *fwnode;
> +	int ret;
> +	int i;
> +	int nports;
> +	u32 port_num;
> +
> +	nports = device_get_child_node_count(dev);
> +	if (nports == 0) {
> +		dev_err(dev, "No port entries found.\n");
> +		return -ENODEV;
> +	}
> +
> +	device_for_each_child_node(dev, fwnode) {
> +		if (fwnode_property_read_u32(fwnode, "port-number",
> +					     &port_num)) {
> +			dev_err(dev, "No port-number for port, skipping.\n");
> +			ret = -EINVAL;
> +			goto unregister_ports;
> +		}
> +
> +		if (port_num >= typec->num_ports) {
> +			dev_err(dev, "Invalid port number.\n");
> +			ret = -EINVAL;
> +			goto unregister_ports;
> +		}
> +
> +		dev_dbg(dev, "Registering port %d\n", port_num);
> +		ret = cros_typec_parse_port_props(&cap, fwnode, dev);
> +		if (ret < 0)
> +			goto unregister_ports;
> +		typec->ports[port_num] = typec_register_port(dev, &cap);
> +		if (IS_ERR(typec->ports[port_num])) {
> +			dev_err(dev, "Failed to register port %d\n", port_num);
> +			ret = PTR_ERR(typec->ports[port_num]);
> +			goto unregister_ports;
> +		}
> +	}
> +
> +	return 0;
> +
> +unregister_ports:
> +	for (i = 0; i < typec->num_ports; i++)
> +		typec_unregister_port(typec->ports[i]);
> +	return ret;
> +}
> +
> +static int cros_typec_ec_command(struct cros_typec_data *typec,
> +				 unsigned int version,
> +				 unsigned int command,
> +				 void *outdata,
> +				 unsigned int outsize,
> +				 void *indata,
> +				 unsigned int insize)
> +{
> +	struct cros_ec_command *msg;
> +	int ret;
> +
> +	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> +	if (!msg)
> +		return -ENOMEM;
> +
> +	msg->version = version;
> +	msg->command = command;
> +	msg->outsize = outsize;
> +	msg->insize = insize;
> +
> +	if (outsize)
> +		memcpy(msg->data, outdata, outsize);
> +
> +	ret = cros_ec_cmd_xfer_status(typec->ec, msg);
> +	if (ret >= 0 && insize)
> +		memcpy(indata, msg->data, insize);
> +
> +	kfree(msg);
> +	return ret;
> +}
> +
> +
> +static int cros_typec_get_num_ports(struct cros_typec_data *typec)
> +{

This functions is only called once at probe, you can just put the code there. I
had some readibility problems trying to follow de code.

> +	struct ec_response_usb_pd_ports resp;
> +	int ret;
> +
> +	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
> +				    &resp, sizeof(resp));
> +	if (ret < 0)
> +		return ret;
> +
> +	typec->num_ports = resp.num_ports;
> +	if (typec->num_ports > EC_USB_PD_MAX_PORTS) {
> +		dev_warn(typec->dev,
> +			 "Too many ports reported: %d, limiting to max: %d\n",
> +			 typec->num_ports, EC_USB_PD_MAX_PORTS);

You say that you are limiting the number of ports to max but typec->num_ports is
still resp.num_ports, is that correct?

> +	}
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cros_typec_acpi_id[] = {
> +	{ "GOOG0014", 0 },
> +	{ /* sentinel */ }

No need to add /* sentinel */ here, is obvious.

> +};
> +MODULE_DEVICE_TABLE(acpi, cros_typec_acpi_id);
> +#endif
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_typec_of_match[] = {
> +	{ .compatible = "google,cros-ec-typec", },
> +	{ /* sentinel */ },

No need to add /* sentinel */ here, is obvious. And no need for the colon at the
end.

> +};
> +MODULE_DEVICE_TABLE(of, cros_typec_of_match);
> +#endif
> +
> +static int cros_typec_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_typec_data *typec;
> +	int ret;
> +
> +	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
> +	if (!typec)
> +		return -ENOMEM;
> +	typec->dev = dev;
> +	typec->ec = dev_get_drvdata(pdev->dev.parent);
> +	platform_set_drvdata(pdev, typec);
> +
> +	ret = cros_typec_get_num_ports(typec);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = cros_typec_init_ports(typec);

both, cros_typec_get_num_ports and cros_typec_init_ports are only called once,
as I said I had some problems of readibility because typec->num_ports is set in
one function and unregister in another function when fails.

I'd just remove those two functions and put the code directly here.

> +	if (!ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_typec_driver = {
> +	.driver	= {
> +		.name	= DRV_NAME,

no tab, just space after .-name

> +		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
> +		.of_match_table = of_match_ptr(cros_typec_of_match),
> +	},
> +	.probe		= cros_typec_probe,

no tab, just space after .probe

> +};
> +
> +module_platform_driver(cros_typec_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Chrome OS EC Type C control");
> 

You probably want to add the MODULE_AUTHOR here
