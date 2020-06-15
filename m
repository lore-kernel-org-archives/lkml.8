Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0065DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3FB20644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730827AbgFOOyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:54:55 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:37122 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730405AbgFOOyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:54:53 -0400
Received: from [78.43.71.214] (helo=marius.localnet)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <mail@mariuszachmann.de>)
        id 1jkqVb-0000IA-5J; Mon, 15 Jun 2020 16:54:47 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC v2] hwmon: add Corsair Commander Pro driver
Date:   Mon, 15 Jun 2020 16:54:46 +0200
Message-ID: <2951227.8AuJ4AEgc1@marius>
In-Reply-To: <1bdfa5cb-ad9c-ab4c-351f-5b86d38c3eb8@roeck-us.net>
References: <4064217.uIqdvtiHzK@marius> <1bdfa5cb-ad9c-ab4c-351f-5b86d38c3eb8@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Con-Id: 241080
X-Con-U: 0-mail
X-Originating-IP: 78.43.71.214
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15.06.20 at 00:25:55 CEST, Guenter Roeck wrote
> On 6/12/20 6:29 AM, Marius Zachmann wrote:
> > This is a driver for the Corsair Commander Pro.
> > It provides sysfs attributes for:
> > - Reading fan speed
> > - Reading temp sensors
> > - Reading voltage values
> > - Writing pwm and reading last written pwm
> > 
> > Changed it to a USB driver for a couple of reasons.
> > Still need to add it to the hid_ignore_list in hid-quirks.c
> > 
> > Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> > ---
> > 
> > Changes from v1:
> > - Style issues
> > - Changed to USB driver
> > - Clarify reading pwm in Documentation and code
> > - Fixed attribute name number in Documentation
> > - MODULE_LICENSE now "GPL"
> > - Removed unneccesary hwmondev in ccp_device
> > - Moved buffer to ccp_device and mutex out of send_usb_cmd
> > - No more replacing or ignoring error codes
> > - Use DIV_ROUND_CLOSEST in set_pwm
> > - Changed fan_label when unknown to "fanX other"
> > - Only accept 0 or 1 for fan_enable
> > - Check for ERR_PTR in ccp_probe
> > ---
> >  Documentation/hwmon/corsair-cpro.rst |  43 +++
> 
> The new document needs to be added to Documentation/hwmon/index.rst.
> 
> >  MAINTAINERS                          |   6 +
> >  drivers/hwmon/Kconfig                |  10 +
> >  drivers/hwmon/Makefile               |   1 +
> >  drivers/hwmon/corsair-cpro.c         | 451 +++++++++++++++++++++++++++
> >  5 files changed, 511 insertions(+)
> >  create mode 100644 Documentation/hwmon/corsair-cpro.rst
> >  create mode 100644 drivers/hwmon/corsair-cpro.c
> > 
> > diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> > new file mode 100644
> > index 000000000000..57de8f4d630b
> > --- /dev/null
> > +++ b/Documentation/hwmon/corsair-cpro.rst
> > @@ -0,0 +1,43 @@
> 
> SPDX license identifier missing (see other recent files for examples).
> 
> > +Kernel driver corsair-cpro
> > +==========================
> > +
> > +Supported devices:
> > +
> > +  * Corsair Commander Pro
> > +  * Corsair Commander Pro (1000D)
> > +
> > +Author: Marius Zachmann
> > +
> > +Description
> > +-----------
> > +
> > +This driver implements the sysfs interface for the Corsair Commander Pro.
> > +The Corsair Commander Pro is a USB device with 6 fan connectors,
> > +4 temperature sensor connectors and 2 Corsair LED connectors.
> > +It can read the voltage levels on the SATA power connector.
> > +
> > +Usage Notes
> > +-----------
> > +
> > +Since it is a USB device, hotswapping is possible. The device is autodetected.
> > +
> > +Sysfs entries
> > +-------------
> > +
> > +in0_input		Voltage on SATA 12v
> > +in1_input		Voltage on SATA 5v
> > +in2_input		Voltage on SATA 3.3v
> > +
> > +temp[1-4]_input		Connected temperature sensors
> > +
> > +fan[1-6]_input		Connected fan rpm.
> > +fan[1-6]_label		Shows connection status of the fan as detected by the
> > +			device.
> > +			"fanX nc"   no connection
> > +			"fanX 3pin" 3-pin fan detected
> > +			"fanX 4pin" 4-pin fan detected
> > +fan[1-6]_enable		the driver only reports fan speeds when 1
> > +
> 
> This use isn't acceptable as implemented. It is a pure software
> flag, and not communicated to the chip/device.
> 
> To disable reporting of disconnected fans, mark it as "ignore"
> in /etc/sensors3.conf.
> 
> > +pwm[1-6]		Sets the fan speed. Values from 0-255.
> > +			When reading, it reports the last value if it was set by the driver.
> > +			Otherwise returns 0.
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f08f290df174..169530c7eede 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -4386,6 +4386,12 @@ S:	Maintained
> >  F:	Documentation/hwmon/coretemp.rst
> >  F:	drivers/hwmon/coretemp.c
> >  
> > +CORSAIR-CPRO HARDWARE MONITOR DRIVER
> > +M:	Marius Zachmann <mail@mariuszachmann.de>
> > +L:	linux-hwmon@vger.kernel.org
> > +S:	Maintained
> > +F:	drivers/hwmon/corsair-cpro.c
> > +
> >  COSA/SRP SYNC SERIAL DRIVER
> >  M:	Jan "Yenya" Kasprzak <kas@fi.muni.cz>
> >  S:	Maintained
> > diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> > index 288ae9f63588..8b046a5dfa40 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -439,6 +439,16 @@ config SENSORS_BT1_PVT_ALARMS
> >  	  the data conversion will be periodically performed and the data will be
> >  	  saved in the internal driver cache.
> >  
> > +config SENSORS_CORSAIR_CPRO
> > +	tristate "Corsair Commander Pro controller"
> > +	depends on USB
> > +	help
> > +	  If you say yes here you get support for the Corsair Commander Pro
> > +	  controller.
> > +
> > +	  This driver can also be built as a module. If so, the module
> > +	  will be called corsair-cpro.
> > +
> >  config SENSORS_DRIVETEMP
> >  	tristate "Hard disk drives with temperature sensors"
> >  	depends on SCSI && ATA
> > diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> > index 3e32c21f5efe..18e1ef74ade7 100644
> > --- a/drivers/hwmon/Makefile
> > +++ b/drivers/hwmon/Makefile
> > @@ -56,6 +56,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
> >  obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
> >  obj-$(CONFIG_SENSORS_BT1_PVT)	+= bt1-pvt.o
> >  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
> > +obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
> >  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
> >  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
> >  obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
> > diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> > new file mode 100644
> > index 000000000000..f7a4d80239c2
> > --- /dev/null
> > +++ b/drivers/hwmon/corsair-cpro.c
> > @@ -0,0 +1,451 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * corsair-cpro.c - Linux driver for Corsair Commander Pro
> > + * Copyright (C) 2020 Marius Zachmann <mail@mariuszachmann.de>
> > + */
> > +
> > +#include <linux/kernel.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/mutex.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/usb.h>
> > +
> > +#define USB_VENDOR_ID_CORSAIR               0x1b1c
> > +#define USB_PRODUCT_ID_CORSAIR_COMMANDERPRO 0x0c10
> > +#define USB_PRODUCT_ID_CORSAIR_1000D	    0x1d00
> > +
> > +#define OUT_BUFFER_SIZE	63
> > +#define IN_BUFFER_SIZE	16
> > +#define LABEL_LENGTH	11
> > +
> > +#define CTL_GET_TMP	 0x11  /* send: byte 1 is channel, rest zero		  */
> > +			       /* rcv:  returns temp for channel in bytes 1 and 2 */
> > +#define CTL_GET_VOLT	 0x12  /* send: byte 1 = rail number 12, 5, 3.3 */
> > +			       /* rcv:  returns volt in bytes 1,2	*/
> > +#define CTL_GET_FAN_CNCT 0x20  /* returns in bytes 1-6	*/
> > +			       /* 0 for no connect	*/
> > +			       /* 1 for 3pin, 2 for 4pin */
> > +#define CTL_GET_FAN_RPM	 0x21  /* works like CTL_GET_TMP */
> > +#define CTL_SET_FAN_FPWM 0x23  /* send: byte 1 is fan number		  */
> > +			       /* send: byte 2 is percentage from 0 - 100 */
> > +
> > +struct ccp_device {
> > +	struct usb_device *udev;
> > +	struct mutex mutex; /* whenever buffer is used or usb calls are made */
> > +	u8 *buffer;
> > +	int pwm[6];
> > +	int fan_enable[6];
> > +	char fan_label[6][LABEL_LENGTH];
> > +};
> > +
> > +/* send 63 byte buffer and receive response in same buffer */
> > +static int send_usb_cmd(struct ccp_device *ccp)
> > +{
> > +	int ret;
> > +	int actual_length;
> > +
> > +	ret = usb_bulk_msg(ccp->udev, usb_sndintpipe(ccp->udev, 2), ccp->buffer, OUT_BUFFER_SIZE,
> > +			   &actual_length, 1000);
> > +	if (ret) {
> > +		dev_err(&ccp->udev->dev, "usb_bulk_msg send failed: %d", ret);
> > +		return ret;
> > +	}
> > +
> > +	ret = usb_bulk_msg(ccp->udev, usb_rcvintpipe(ccp->udev, 1), ccp->buffer, IN_BUFFER_SIZE,
> > +			   &actual_length, 1000);
> > +	if (ret) {
> > +		dev_err(&ccp->udev->dev, "usb_bulk_msg receive failed: %d", ret);
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +/* for commands, which return just a number depending on a channel: */
> > +/* get_temp, get_volt, get_fan_rpm */
> 
> Please use standard multi-line comments.
> 
> > +static int get_data(struct ccp_device *ccp, int command, int channel, long *val)
> > +{
> > +	int ret;
> > +
> > +	mutex_lock(&ccp->mutex);
> > +
> > +	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> > +	ccp->buffer[0] = command;
> > +	ccp->buffer[1] = channel;
> > +	ret = send_usb_cmd(ccp);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	*val = (ccp->buffer[1] << 8) + ccp->buffer[2];
> > +
> > +exit:
> > +	mutex_unlock(&ccp->mutex);
> > +	return ret;
> > +}
> > +
> > +static int set_pwm(struct ccp_device *ccp, int channel, long val)
> > +{
> > +	int ret;
> > +
> > +	if (val < 0 || val > 255)
> > +		return -EINVAL;
> > +
> > +	ccp->pwm[channel] = val;
> > +
> > +	/* The Corsair Commander Pro uses values from 0-100 */
> > +	val = DIV_ROUND_CLOSEST(val * 100, 255);
> > +
> > +	mutex_lock(&ccp->mutex);
> > +
> > +	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> > +	ccp->buffer[0] = CTL_SET_FAN_FPWM;
> > +	ccp->buffer[1] = channel;
> > +	ccp->buffer[2] = val;
> 
> As it turns out (unless I am missing something), all commands have
> one, two, or three parameters. Also, the full buffer is always
> written. With that, it would be easier to add command, channel,
> and value as parameters to send_usb_cmd() and handle both
> memset() and assignments there.
> 

There is at least one command for setting a fan curve (0x25),
which I intend to implement at a later point. It needs 27 bytes.
There seem to be more long commands related to the RGB output.
Also there is CTL_GET_FAN_CNCT which needs read 6 bytes of the
response.

> > +	ret = send_usb_cmd(ccp);
> > +
> 
> This makes me wonder if reading a response is always necessary.
> If not, it might make sense to add a flag to the function indicating
> that no response is needed, and skip the read part there. If it is
> needed, it might make sense to add a comment into the send function,
> explaining that a read command must be executed even if no data is
> returned.
> 

Actually yes. After a bit of further testing it seems, there is an
error code in the first byte of the response, when sending invalid
commands. I will check for it, return -EIO and log it, since I
do not know, what all the error codes are.
Also: Thank You!

> > +	mutex_unlock(&ccp->mutex);
> > +	return ret;
> > +}
> > +
> > +static int get_fan_mode_label(struct ccp_device *ccp, int channel)
> > +{
> > +	int ret;
> > +	int mode;
> > +
> > +	mutex_lock(&ccp->mutex);
> > +
> > +	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> > +	ccp->buffer[0] = CTL_GET_FAN_CNCT;
> > +	ret = send_usb_cmd(ccp);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	mode = ccp->buffer[channel + 1];
> > +
> > +	switch (mode) {
> > +	case 0:
> > +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d nc", channel + 1);
> > +		break;
> > +	case 1:
> > +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d 3pin", channel + 1);
> > +		break;
> > +	case 2:
> > +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d 4pin", channel + 1);
> > +		break;
> > +	default:
> > +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d other", channel + 1);
> > +		break;
> > +	}
> > +
> > +exit:
> > +	mutex_unlock(&ccp->mutex);
> > +	return ret;
> > +}
> > +
> > +static int get_voltage(struct ccp_device *ccp, int channel, long *val)
> > +{
> > +	int ret;
> > +
> > +	ret = get_data(ccp, CTL_GET_VOLT, channel, val);
> > +
> > +	return ret;
> 
> 	return get_data(ccp, CTL_GET_VOLT, channel, val);
> 
> would accomplish the same.
> 
> > +}
> > +
> > +static int get_temp(struct ccp_device *ccp, int channel, long *val)
> > +{
> > +	int ret;
> > +
> > +	ret = get_data(ccp, CTL_GET_TMP, channel, val);
> > +	*val = *val * 10;
> > +
> > +	return ret;
> > +}
> > +
> > +static int get_rpm(struct ccp_device *ccp, int channel, long *val)
> > +{
> > +	int ret;
> > +
> > +	if (!ccp->fan_enable[channel])
> > +		return -ENODATA;
> 
> As mentioned, this isn't the intended use case for enable attributes.
> Unless it is indeed possible to inform the device that it shall not
> monitor a given fan, please drop the attribute and handle it in userspace.
> 
> > +
> > +	ret = get_data(ccp, CTL_GET_FAN_RPM, channel, val);
> > +
> > +	return ret;
> > +}
> > +
> > +static int ccp_read_string(struct device *dev, enum hwmon_sensor_types type,
> > +			   u32 attr, int channel, const char **str)
> > +{
> > +	int ret;
> > +	struct ccp_device *ccp = dev_get_drvdata(dev);
> > +
> > +	switch (type) {
> > +	case hwmon_fan:
> > +		switch (attr) {
> > +		case hwmon_fan_label:
> > +			ret = get_fan_mode_label(ccp, channel);
> > +			if (ret == 0)
> > +				*str = ccp->fan_label[channel];
> > +			break;
> > +		default:
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EOPNOTSUPP;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
> > +		    u32 attr, int channel, long *val)
> > +{
> > +	int ret = 0;
> > +	struct ccp_device *ccp = dev_get_drvdata(dev);
> > +
> > +	switch (type) {
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			ret = get_temp(ccp, channel, val);
> > +			break;
> > +		default:
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_fan:
> > +		switch (attr) {
> > +		case hwmon_fan_input:
> > +			ret = get_rpm(ccp, channel, val);
> > +			break;
> > +		case hwmon_fan_enable:
> > +			*val = ccp->fan_enable[channel];
> > +			break;
> > +		default:
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_pwm:
> > +		switch (attr) {
> > +		case hwmon_pwm_input:
> > +			/* how to read pwm values from the device is currently unknown */
> > +			/* driver returns last set value or 0		               */
> > +			*val = ccp->pwm[channel];
> > +			break;
> > +		default:
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_in:
> > +		switch (attr) {
> > +		case hwmon_in_input:
> > +			ret = get_voltage(ccp, channel, val);
> > +			break;
> > +		default:
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EOPNOTSUPP;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +};
> > +
> > +static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
> > +		     u32 attr, int channel, long val)
> > +{
> > +	int ret = 0;
> > +	struct ccp_device *ccp = dev_get_drvdata(dev);
> 
> Nit: Revertse christmas tree ordering of variables is preferred.
> 
> > +
> > +	switch (type) {
> > +	case hwmon_fan:
> > +		switch (attr) {
> > +		case hwmon_fan_enable:
> > +			if (val == 0 || val == 1)
> > +				ccp->fan_enable[channel] = val;
> > +			else
> > +				ret = -EINVAL;
> > +			break;
> > +		default:
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_pwm:
> > +		switch (attr) {
> > +		case hwmon_pwm_input:
> > +			ret = set_pwm(ccp, channel, val);
> > +			break;
> > +		default:
> > +			ret = -EOPNOTSUPP;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EOPNOTSUPP;
> > +		break;
> > +	}
> > +
> > +	return ret;
> > +};
> > +
> > +static umode_t ccp_is_visible(const void *data, enum hwmon_sensor_types type,
> > +			      u32 attr, int channel)
> > +{
> > +	switch (type) {
> > +	case hwmon_chip:
> > +		switch (attr) {
> > +		case hwmon_chip_update_interval:
> > +			return 0644;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			return 0444;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_fan:
> > +		switch (attr) {
> > +		case hwmon_fan_input:
> > +			return 0444;
> > +		case hwmon_fan_label:
> > +			return 0444;
> > +		case hwmon_fan_enable:
> > +			return 0644;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_pwm:
> > +		switch (attr) {
> > +		case hwmon_pwm_input:
> > +			return 0644;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_in:
> > +		switch (attr) {
> > +		case hwmon_in_input:
> > +			return 0444;
> > +		default:
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
> > +
> > +	return 0;
> > +};
> > +
> > +static const struct hwmon_ops ccp_hwmon_ops = {
> > +	.is_visible = ccp_is_visible,
> > +	.read = ccp_read,
> > +	.write = ccp_write,
> > +	.read_string = ccp_read_string,
> > +};
> > +
> > +static const struct hwmon_channel_info *ccp_info[] = {
> > +	HWMON_CHANNEL_INFO(chip,
> > +			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
> > +	HWMON_CHANNEL_INFO(temp,
> > +			   HWMON_T_INPUT | HWMON_T_MAX,
> > +			   HWMON_T_INPUT | HWMON_T_MAX,
> > +			   HWMON_T_INPUT | HWMON_T_MAX,
> > +			   HWMON_T_INPUT | HWMON_T_MAX
> > +			   ),
> > +	HWMON_CHANNEL_INFO(fan,
> > +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> > +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> > +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> > +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> > +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> > +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL
> > +			   ),
> > +	HWMON_CHANNEL_INFO(pwm,
> > +			   HWMON_PWM_INPUT,
> > +			   HWMON_PWM_INPUT,
> > +			   HWMON_PWM_INPUT,
> > +			   HWMON_PWM_INPUT,
> > +			   HWMON_PWM_INPUT,
> > +			   HWMON_PWM_INPUT
> > +			   ),
> > +	HWMON_CHANNEL_INFO(in,
> > +			   HWMON_I_INPUT,
> > +			   HWMON_I_INPUT,
> > +			   HWMON_I_INPUT
> > +			   ),
> > +	NULL
> > +};
> > +
> > +static const struct hwmon_chip_info ccp_chip_info = {
> > +	.ops = &ccp_hwmon_ops,
> > +	.info = ccp_info,
> > +};
> > +
> > +static int ccp_probe(struct usb_interface *intf, const struct usb_device_id *id)
> > +{
> > +	struct ccp_device *ccp;
> > +	struct device *hwmon_dev;
> > +
> > +	ccp = devm_kzalloc(&intf->dev, sizeof(struct ccp_device), GFP_KERNEL);
> > +	if (!ccp)
> > +		return -ENOMEM;
> > +
> > +	ccp->buffer = devm_kmalloc(&intf->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
> > +	if (!ccp->buffer)
> > +		return -ENOMEM;
> > +
> > +	mutex_init(&ccp->mutex);
> > +
> > +	ccp->fan_enable[0] = 1;
> > +	ccp->fan_enable[1] = 1;
> > +	ccp->fan_enable[2] = 1;
> > +	ccp->fan_enable[3] = 1;
> > +	ccp->fan_enable[4] = 1;
> > +	ccp->fan_enable[5] = 1;
> > +	ccp->udev = interface_to_usbdev(intf);
> > +
> > +	hwmon_dev = devm_hwmon_device_register_with_info(&intf->dev, "corsaircpro", ccp,
> > +							 &ccp_chip_info, 0);
> > +
> > +	return PTR_ERR_OR_ZERO(hwmon_dev);
> > +}
> > +
> > +void ccp_disconnect(struct usb_interface *intf)
> > +{
> > +}
> > +
> > +static const struct usb_device_id ccp_devices[] = {
> > +	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_COMMANDERPRO) },
> > +	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_1000D) },
> > +	{ }
> > +};
> > +
> > +static struct usb_driver ccp_driver = {
> > +	.name = "corsair-cpro",
> > +	.id_table = ccp_devices,
> > +	.probe = ccp_probe,
> > +	.disconnect = ccp_disconnect
> > +};
> > +
> > +MODULE_DEVICE_TABLE(usb, ccp_devices);
> > +MODULE_LICENSE("GPL");
> > +
> > +module_usb_driver(ccp_driver);
> > 
> 
> 




