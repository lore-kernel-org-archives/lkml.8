Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 298AFC3B187
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0742321739
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:27:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBKL1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:27:00 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:34182 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgBKL1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:27:00 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C8D2C28A178
Subject: Re: [PATCH v2 2/4] platform/chrome: Add Type C connector class driver
To:     Prashant Malani <pmalani@chromium.org>,
        linux-kernel@vger.kernel.org
Cc:     heikki.krogerus@intel.com, bleung@chromium.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20200207203752.209296-1-pmalani@chromium.org>
 <20200207203752.209296-3-pmalani@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <ac5676d4-4198-6d5d-3607-45b23d817f39@collabora.com>
Date:   Tue, 11 Feb 2020 12:26:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200207203752.209296-3-pmalani@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant, Heikki

On 7/2/20 21:37, Prashant Malani wrote:
> Add a driver to implement the Type C connector class for Chrome OS
> devices with ECs (Embedded Controllers).
> 
> The driver relies on firmware device specifications for various port
> attributes. On ACPI platforms, this is specified using the logical
> device with HID GOOG0014. On DT platforms, this is specified using the
> DT node with compatible string "google,cros-ec-typec".
> 
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

Would be good a review from Heikki if possible.

> 
> Changes in v2:
> - Updated Kconfig to default to MFD_CROS_EC_DEV.
> - Fixed code comments.
> - Moved get_num_ports() code into probe().
> - Added module author.
> 
>  drivers/platform/chrome/Kconfig         |  11 ++
>  drivers/platform/chrome/Makefile        |   1 +
>  drivers/platform/chrome/cros_ec_typec.c | 218 ++++++++++++++++++++++++
>  3 files changed, 230 insertions(+)
>  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
> 
> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
> index 5f57282a28da00..2320a4f0d93019 100644
> --- a/drivers/platform/chrome/Kconfig
> +++ b/drivers/platform/chrome/Kconfig
> @@ -214,6 +214,17 @@ config CROS_EC_SYSFS
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called cros_ec_sysfs.
>  
> +config CROS_EC_TYPEC
> +	tristate "ChromeOS EC Type-C Connector Control"
> +	depends on MFD_CROS_EC_DEV && TYPEC
> +	default MFD_CROS_EC_DEV
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
> index 00000000000000..8374ccfe784f3b
> --- /dev/null
> +++ b/drivers/platform/chrome/cros_ec_typec.c
> @@ -0,0 +1,218 @@
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
> +static int cros_typec_parse_port_props(struct typec_capability *cap,
> +				       struct fwnode_handle *fwnode,
> +				       struct device *dev)
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
> +#ifdef CONFIG_ACPI
> +static const struct acpi_device_id cros_typec_acpi_id[] = {
> +	{ "GOOG0014", 0 },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(acpi, cros_typec_acpi_id);
> +#endif
> +
> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_typec_of_match[] = {
> +	{ .compatible = "google,cros-ec-typec", },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, cros_typec_of_match);
> +#endif
> +
> +static int cros_typec_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct cros_typec_data *typec;
> +	struct ec_response_usb_pd_ports resp;
> +	int ret;
> +
> +	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
> +	if (!typec)
> +		return -ENOMEM;
> +	typec->dev = dev;
> +	typec->ec = dev_get_drvdata(pdev->dev.parent);
> +	platform_set_drvdata(pdev, typec);
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
> +		typec->num_ports = EC_USB_PD_MAX_PORTS;
> +	}
> +
> +	ret = cros_typec_init_ports(typec);
> +	if (!ret)
> +		return ret;
> +
> +	return 0;
> +}
> +
> +static struct platform_driver cros_typec_driver = {
> +	.driver	= {
> +		.name = DRV_NAME,
> +		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
> +		.of_match_table = of_match_ptr(cros_typec_of_match),
> +	},
> +	.probe = cros_typec_probe,
> +};
> +
> +module_platform_driver(cros_typec_driver);
> +
> +MODULE_AUTHOR("Prashant Malani <pmalani@chromium.org>");
> +MODULE_DESCRIPTION("Chrome OS EC Type C control");
> +MODULE_LICENSE("GPL");
> 
