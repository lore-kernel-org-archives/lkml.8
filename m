Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C79C54FCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A567E2076A
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgCWOAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:00:25 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36350 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728446AbgCWOAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:00:25 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 15C09296394
Subject: Re: [PATCH v5 2/4] platform/chrome: Add Type C connector class driver
To:     Benson Leung <bleung@google.com>,
        Prashant Malani <pmalani@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
References: <20200316090021.52148-1-pmalani@chromium.org>
 <20200316090021.52148-3-pmalani@chromium.org>
 <20200318174302.GA137510@google.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <f750f229-ef44-a046-3653-d9af3370be40@collabora.com>
Date:   Mon, 23 Mar 2020 15:00:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200318174302.GA137510@google.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prashant and Benson,

On 18/3/20 18:43, Benson Leung wrote:
> Hi Prashant,
> 
> On Mon, Mar 16, 2020 at 02:00:17AM -0700, Prashant Malani wrote:
>> Add a driver to implement the Type C connector class for Chrome OS
>> devices with ECs (Embedded Controllers).
>>
>> The driver relies on firmware device specifications for various port
>> attributes. On ACPI platforms, this is specified using the logical
>> device with HID GOOG0014. On DT platforms, this is specified using the
>> DT node with compatible string "google,cros-ec-typec".
>>
>> The driver reads the device FW node and uses the port attributes to
>> register the typec ports with the Type C connector class framework, but
>> doesn't do much else.
>>
>> Subsequent patches will add more functionality to the driver, including
>> obtaining current port information (polarity, vconn role, current power
>> role etc.) after querying the EC.
>>
>> Signed-off-by: Prashant Malani <pmalani@chromium.org>
>> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 
> Thanks for posting this. For my bit:
> Co-developed-by: Benson Leung <bleung@chromium.org>
> 

Squashed 3 and 4 and queued together with 2 for 5.7. Patch 1 will go through the
Rob's tree.

Thanks,
 Enric

>> ---
>>
>> Changes in v5:
>> - Added Reviewed-by tag which was missed in earlier version.
>>
>> Changes in v4:
>> - Added Reviewed-by tag from previous review cycle
>> - Added code to store port caps within the Cros EC type C data structure
>> - Added code to use reg to get the port-number in DT platforms.
>>
>> Changes in v3:
>> - Fixed minor spacing nits, and moved a modification to probe() if check
>>   from later patch to here instead.
>>
>> Changes in v2:
>> - Updated Kconfig to default to MFD_CROS_EC_DEV.
>> - Fixed code comments.
>> - Moved get_num_ports() code into probe().
>> - Added module author.
>>
>>  drivers/platform/chrome/Kconfig         |  11 ++
>>  drivers/platform/chrome/Makefile        |   1 +
>>  drivers/platform/chrome/cros_ec_typec.c | 238 ++++++++++++++++++++++++
>>  3 files changed, 250 insertions(+)
>>  create mode 100644 drivers/platform/chrome/cros_ec_typec.c
>>
>> diff --git a/drivers/platform/chrome/Kconfig b/drivers/platform/chrome/Kconfig
>> index 5f57282a28da0..2320a4f0d9301 100644
>> --- a/drivers/platform/chrome/Kconfig
>> +++ b/drivers/platform/chrome/Kconfig
>> @@ -214,6 +214,17 @@ config CROS_EC_SYSFS
>>  	  To compile this driver as a module, choose M here: the
>>  	  module will be called cros_ec_sysfs.
>>  
>> +config CROS_EC_TYPEC
>> +	tristate "ChromeOS EC Type-C Connector Control"
>> +	depends on MFD_CROS_EC_DEV && TYPEC
>> +	default MFD_CROS_EC_DEV
>> +	help
>> +	  If you say Y here, you get support for accessing Type C connector
>> +	  information from the Chrome OS EC.
>> +
>> +	  To compile this driver as a module, choose M here: the module will be
>> +	  called cros_ec_typec.
>> +
>>  config CROS_USBPD_LOGGER
>>  	tristate "Logging driver for USB PD charger"
>>  	depends on CHARGER_CROS_USBPD
>> diff --git a/drivers/platform/chrome/Makefile b/drivers/platform/chrome/Makefile
>> index aacd5920d8a18..caf2a9cdb5e6d 100644
>> --- a/drivers/platform/chrome/Makefile
>> +++ b/drivers/platform/chrome/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_CROS_EC_ISHTP)		+= cros_ec_ishtp.o
>>  obj-$(CONFIG_CROS_EC_RPMSG)		+= cros_ec_rpmsg.o
>>  obj-$(CONFIG_CROS_EC_SPI)		+= cros_ec_spi.o
>>  cros_ec_lpcs-objs			:= cros_ec_lpc.o cros_ec_lpc_mec.o
>> +obj-$(CONFIG_CROS_EC_TYPEC)		+= cros_ec_typec.o
>>  obj-$(CONFIG_CROS_EC_LPC)		+= cros_ec_lpcs.o
>>  obj-$(CONFIG_CROS_EC_PROTO)		+= cros_ec_proto.o cros_ec_trace.o
>>  obj-$(CONFIG_CROS_KBD_LED_BACKLIGHT)	+= cros_kbd_led_backlight.o
>> diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
>> new file mode 100644
>> index 0000000000000..02e6d5cbbbf7a
>> --- /dev/null
>> +++ b/drivers/platform/chrome/cros_ec_typec.c
>> @@ -0,0 +1,238 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright 2020 Google LLC
>> + *
>> + * This driver provides the ability to view and manage Type C ports through the
>> + * Chrome OS EC.
>> + */
>> +
>> +#include <linux/acpi.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/platform_data/cros_ec_commands.h>
>> +#include <linux/platform_data/cros_ec_proto.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/usb/typec.h>
>> +
>> +#define DRV_NAME "cros-ec-typec"
>> +
>> +/* Platform-specific data for the Chrome OS EC Type C controller. */
>> +struct cros_typec_data {
>> +	struct device *dev;
>> +	struct cros_ec_device *ec;
>> +	int num_ports;
>> +	/* Array of ports, indexed by port number. */
>> +	struct typec_port *ports[EC_USB_PD_MAX_PORTS];
>> +	/* Initial capabilities for each port. */
>> +	struct typec_capability *caps[EC_USB_PD_MAX_PORTS];
>> +};
>> +
>> +static int cros_typec_parse_port_props(struct typec_capability *cap,
>> +				       struct fwnode_handle *fwnode,
>> +				       struct device *dev)
>> +{
>> +	const char *buf;
>> +	int ret;
>> +
>> +	memset(cap, 0, sizeof(*cap));
>> +	ret = fwnode_property_read_string(fwnode, "power-role", &buf);
>> +	if (ret) {
>> +		dev_err(dev, "power-role not found: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = typec_find_port_power_role(buf);
>> +	if (ret < 0)
>> +		return ret;
>> +	cap->type = ret;
>> +
>> +	ret = fwnode_property_read_string(fwnode, "data-role", &buf);
>> +	if (ret) {
>> +		dev_err(dev, "data-role not found: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = typec_find_port_data_role(buf);
>> +	if (ret < 0)
>> +		return ret;
>> +	cap->data = ret;
>> +
>> +	ret = fwnode_property_read_string(fwnode, "try-power-role", &buf);
>> +	if (ret) {
>> +		dev_err(dev, "try-power-role not found: %d\n", ret);
>> +		return ret;
>> +	}
>> +
>> +	ret = typec_find_power_role(buf);
>> +	if (ret < 0)
>> +		return ret;
>> +	cap->prefer_role = ret;
>> +
>> +	cap->fwnode = fwnode;
>> +
>> +	return 0;
>> +}
>> +
>> +static int cros_typec_init_ports(struct cros_typec_data *typec)
>> +{
>> +	struct device *dev = typec->dev;
>> +	struct typec_capability *cap;
>> +	struct fwnode_handle *fwnode;
>> +	const char *port_prop;
>> +	int ret;
>> +	int i;
>> +	int nports;
>> +	u32 port_num = 0;
>> +
>> +	nports = device_get_child_node_count(dev);
>> +	if (nports == 0) {
>> +		dev_err(dev, "No port entries found.\n");
>> +		return -ENODEV;
>> +	}
>> +
>> +	if (nports > typec->num_ports) {
>> +		dev_err(dev, "More ports listed than can be supported.\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* DT uses "reg" to specify port number. */
>> +	port_prop = dev->of_node ? "reg" : "port-number";
>> +	device_for_each_child_node(dev, fwnode) {
>> +		if (fwnode_property_read_u32(fwnode, port_prop, &port_num)) {
>> +			ret = -EINVAL;
>> +			dev_err(dev, "No port-number for port, aborting.\n");
>> +			goto unregister_ports;
>> +		}
>> +
>> +		if (port_num >= typec->num_ports) {
>> +			dev_err(dev, "Invalid port number.\n");
>> +			ret = -EINVAL;
>> +			goto unregister_ports;
>> +		}
>> +
>> +		dev_dbg(dev, "Registering port %d\n", port_num);
>> +
>> +		cap = devm_kzalloc(dev, sizeof(*cap), GFP_KERNEL);
>> +		if (!cap) {
>> +			ret = -ENOMEM;
>> +			goto unregister_ports;
>> +		}
>> +
>> +		typec->caps[port_num] = cap;
>> +
>> +		ret = cros_typec_parse_port_props(cap, fwnode, dev);
>> +		if (ret < 0)
>> +			goto unregister_ports;
>> +
>> +		typec->ports[port_num] = typec_register_port(dev, cap);
>> +		if (IS_ERR(typec->ports[port_num])) {
>> +			dev_err(dev, "Failed to register port %d\n", port_num);
>> +			ret = PTR_ERR(typec->ports[port_num]);
>> +			goto unregister_ports;
>> +		}
>> +	}
>> +
>> +	return 0;
>> +
>> +unregister_ports:
>> +	for (i = 0; i < typec->num_ports; i++)
>> +		typec_unregister_port(typec->ports[i]);
>> +	return ret;
>> +}
>> +
>> +static int cros_typec_ec_command(struct cros_typec_data *typec,
>> +				 unsigned int version,
>> +				 unsigned int command,
>> +				 void *outdata,
>> +				 unsigned int outsize,
>> +				 void *indata,
>> +				 unsigned int insize)
>> +{
>> +	struct cros_ec_command *msg;
>> +	int ret;
>> +
>> +	msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
>> +	if (!msg)
>> +		return -ENOMEM;
>> +
>> +	msg->version = version;
>> +	msg->command = command;
>> +	msg->outsize = outsize;
>> +	msg->insize = insize;
>> +
>> +	if (outsize)
>> +		memcpy(msg->data, outdata, outsize);
>> +
>> +	ret = cros_ec_cmd_xfer_status(typec->ec, msg);
>> +	if (ret >= 0 && insize)
>> +		memcpy(indata, msg->data, insize);
>> +
>> +	kfree(msg);
>> +	return ret;
>> +}
>> +
>> +#ifdef CONFIG_ACPI
>> +static const struct acpi_device_id cros_typec_acpi_id[] = {
>> +	{ "GOOG0014", 0 },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(acpi, cros_typec_acpi_id);
>> +#endif
>> +
>> +#ifdef CONFIG_OF
>> +static const struct of_device_id cros_typec_of_match[] = {
>> +	{ .compatible = "google,cros-ec-typec", },
>> +	{}
>> +};
>> +MODULE_DEVICE_TABLE(of, cros_typec_of_match);
>> +#endif
>> +
>> +static int cros_typec_probe(struct platform_device *pdev)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct cros_typec_data *typec;
>> +	struct ec_response_usb_pd_ports resp;
>> +	int ret;
>> +
>> +	typec = devm_kzalloc(dev, sizeof(*typec), GFP_KERNEL);
>> +	if (!typec)
>> +		return -ENOMEM;
>> +
>> +	typec->dev = dev;
>> +	typec->ec = dev_get_drvdata(pdev->dev.parent);
>> +	platform_set_drvdata(pdev, typec);
>> +
>> +	ret = cros_typec_ec_command(typec, 0, EC_CMD_USB_PD_PORTS, NULL, 0,
>> +				    &resp, sizeof(resp));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	typec->num_ports = resp.num_ports;
>> +	if (typec->num_ports > EC_USB_PD_MAX_PORTS) {
>> +		dev_warn(typec->dev,
>> +			 "Too many ports reported: %d, limiting to max: %d\n",
>> +			 typec->num_ports, EC_USB_PD_MAX_PORTS);
>> +		typec->num_ports = EC_USB_PD_MAX_PORTS;
>> +	}
>> +
>> +	ret = cros_typec_init_ports(typec);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver cros_typec_driver = {
>> +	.driver	= {
>> +		.name = DRV_NAME,
>> +		.acpi_match_table = ACPI_PTR(cros_typec_acpi_id),
>> +		.of_match_table = of_match_ptr(cros_typec_of_match),
>> +	},
>> +	.probe = cros_typec_probe,
>> +};
>> +
>> +module_platform_driver(cros_typec_driver);
>> +
>> +MODULE_AUTHOR("Prashant Malani <pmalani@chromium.org>");
>> +MODULE_DESCRIPTION("Chrome OS EC Type C control");
>> +MODULE_LICENSE("GPL");
>> -- 
>> 2.25.1.481.gfbce0eb801-goog
>>
> 
