Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE581C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3102072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgFJMEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:04:05 -0400
Received: from ms-10.1blu.de ([178.254.4.101]:44276 "EHLO ms-10.1blu.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728647AbgFJMEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:04:04 -0400
Received: from [78.43.71.214] (helo=marius.localnet)
        by ms-10.1blu.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.86_2)
        (envelope-from <mail@mariuszachmann.de>)
        id 1jizSV-0003XU-UT; Wed, 10 Jun 2020 14:03:56 +0200
From:   Marius Zachmann <mail@mariuszachmann.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC] drivers/hwmon: Corsair Commander Pro driver
Date:   Wed, 10 Jun 2020 14:03:55 +0200
Message-ID: <5812362.fiZtzxMu5m@marius>
In-Reply-To: <20200610040145.GA83576@roeck-us.net>
References: <20200610040145.GA83576@roeck-us.net>
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

On 10.06.20 at 06:01:45 CEST, Guenter Roeck wrote:
> On Wed, Jun 10, 2020 at 12:26:40AM +0200, Marius Zachmann wrote:
> > This is a driver for the Corsair Commander Pro.
> > Since this is my first addition to the kernel I would be happy, if you would take a look at it.
> > I am using this driver on my computer at home and I had a few people test it.
> > 
> > The device:
> > 
> > The Corsair Commander Pro is a USB device, which is usually connected on the internal USB headers on the mainboard.
> > It has 6 fan connectors, 4 thermal sensor connectors and 2 RGB connectors.
> > It also reads the voltages on the SATA connector, which it needs for power.
> > 
> > The driver:
> > 
> > I hope hwmon is the right place.
> > The driver is a HID driver, but it uses usb_bulk_msg for communication.
> > The device registers as a HID device and there are userspace tools, which use hidraw to access it. I think, it would be good to maintain compatibility with these tools, but the driver can easily be rewritten to be a pure USB driver.
> > For now it can read temp sensors, fan speeds, voltage values and set pwm values.
> > It also reads the connection status on the fan headers.
> > 
> > There are a few more things, which I would like to add in the near future:
> > * Fan curves (not yet sure about the nicest way to provide sysfs access)
> > * Force 3pin or 4pin mode. (Sometimes the device doesn't detect the fans correctly)
> > * Setting fixed RPM
> > 
> > I do not work for Corsair and I intend to keep the driver maintainted as long as I use the device privately.
> > 
> The above should be limited to the driver description. Discussion should be
> below the '---'. Either case, make sure to split your lines.
> 
> > Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> > ---
> >  Documentation/hwmon/corsair-cpro.rst |  42 +++
> 
> Needs to be added to Documentation/hwmon/index.rst.
> 
> >  MAINTAINERS                          |   6 +
> >  drivers/hwmon/Kconfig                |  10 +
> >  drivers/hwmon/Makefile               |   1 +
> >  drivers/hwmon/corsair-cpro.c         | 481 +++++++++++++++++++++++++++
> >  5 files changed, 540 insertions(+)
> >  create mode 100644 Documentation/hwmon/corsair-cpro.rst
> >  create mode 100644 drivers/hwmon/corsair-cpro.c
> > 
> > diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> > new file mode 100644
> > index 000000000000..d4ea1b6b9336
> > --- /dev/null
> > +++ b/Documentation/hwmon/corsair-cpro.rst
> > @@ -0,0 +1,42 @@
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
> > +temp[0-3]_input		Connected temperature sensors
> > +
> Index starts with 1 for everything except inX.
> 
> > +fan[0-5]_input		Connected fan rpm.
> > +fan[0-5]_label		Shows connection status of the fan as detected by the
> > +			device.
> > +			"fanX nc"   no connection
> > +			"fanX 3pin" 3-pin fan detected
> > +			"fanX 4pin" 4-pin fan detected
> > +fan[0-5]_enable		the driver only reports fan speeds when 1
> > +pwm[0-5]		Sets the fan speed. Values from 0-255.
> > +			When reading, it reports the last value, which
> > +			was set by the driver.
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
> > index 288ae9f63588..9f5a808768ca 100644
> > --- a/drivers/hwmon/Kconfig
> > +++ b/drivers/hwmon/Kconfig
> > @@ -439,6 +439,16 @@ config SENSORS_BT1_PVT_ALARMS
> >  	  the data conversion will be periodically performed and the data will be
> >  	  saved in the internal driver cache.
> >  
> > +config SENSORS_CORSAIR_CPRO
> > +	tristate "Corsair Commander Pro controller"
> > +	depends on USB_HID
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
> > index 000000000000..8ba7fb061184
> > --- /dev/null
> > +++ b/drivers/hwmon/corsair-cpro.c
> > @@ -0,0 +1,481 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> 
> This conflicts with MODULE_LICENSE which explicitly states GPL v2.
> 
> > +/*
> > + * corsair-cpro.c - Linux driver for Corsair Commander Pro
> > + * Copyright (C) 2020 Marius Zachmann <mail@mariuszachmann.de>
> > + *
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/hid.h>
> > +#include <linux/hwmon.h>
> > +#include <linux/mutex.h>
> > +#include <linux/module.h>
> > +#include <linux/slab.h>
> > +#include <linux/usb.h>
> > +
> > +#define	hid_to_usb_dev(hid_dev) \
> > +	to_usb_device(hid_dev->dev.parent->parent)
> 
> Unnecessary line break.
> 
> > +
> > +#define USB_VENDOR_ID_CORSAIR               0x1b1c
> > +#define USB_PRODUCT_ID_CORSAIR_COMMANDERPRO 0x0c10
> > +#define USB_PRODUCT_ID_CORSAIR_1000D	    0x1d00
> > +
> > +#define OUT_BUFFER_SIZE 63
> > +#define IN_BUFFER_SIZE 16
> > +#define LABEL_LENGTH 10
> > +
> > +#define CTL_GET_TMP	 0x11  /* byte 1 is channel, rest zero              */
> > +			       /* returns temp for channel in bytes 1 and 2 */
> > +#define CTL_GET_VOLT	 0x12  /* byte 1 = rail number 12, 5, 3.3 */
> > +			       /* returns volt in bytes 1,2       */
> > +#define CTL_GET_FAN_CNCT 0x20  /* returns in bytes 1-6   */
> > +			       /* 0 for no connect       */
> > +			       /* 1 for 3pin, 2 for 4pin */
> > +#define CTL_GET_FAN_RPM	 0x21  /* works like CTL_GET_TMP */
> > +#define CTL_SET_FAN_FPWM 0x23  /* byte 1 is fan number              */
> > +			       /* byte 2 is percentage from 0 - 100 */
> > +
> 
> Please use tabs consistently after the defined name, eg
> 
> #define OUT_BUFFER_SIZE	63
> #define IN_BUFFER_SIZE	16
> #define LABEL_LENGTH	10
> 
> > +struct ccp_device {
> > +	struct hid_device *hdev;
> > +	struct device *hwmondev;
> 
> Not used anywhere.
> 
> > +	struct mutex mutex;
> > +	int pwm[6];
> > +	int fan_enable[6];
> > +	char fan_label[6][LABEL_LENGTH];
> > +
> 
> Unnecessary empty line.
> 
> > +};
> > +
> > +/* send 63 byte buffer and receive response in same buffer */
> > +static int send_usb_cmd(struct ccp_device *ccp, u8 *buffer)
> > +{
> > +	int ret;
> > +	struct usb_device *udev = hid_to_usb_dev(ccp->hdev);
> > +	int actual_length;
> > +
> > +
> Unnecessary empty line
> 
> > +	mutex_lock(&ccp->mutex);
> > +
> > +	ret = usb_bulk_msg(udev,
> > +			usb_sndintpipe(udev, 2),
> > +			buffer,
> > +			OUT_BUFFER_SIZE,
> > +			&actual_length,
> > +			1000);
> 
> Too many line breaks. All over the place. Please only split lines where
> necessary (line length limit is now 100).
> 
> > +	if (ret < 0) {
> > +		hid_err(ccp->hdev,
> > +			"usb_bulk_msg send failed: %d", ret);
> > +		goto exit;
> > +	}
> > +
> > +	ret = usb_bulk_msg(udev,
> > +			usb_rcvintpipe(udev, 1),
> > +			buffer,
> > +			IN_BUFFER_SIZE,
> > +			&actual_length,
> > +			1000);
> > +	if (ret) {
> > +		hid_err(ccp->hdev,
> > +			"usb_bulk_msg receive failed: %d", ret);
> > +		goto exit;
> > +	}
> > +
> > +exit:
> > +	mutex_unlock(&ccp->mutex);
> > +	return ret;
> > +}
> > +
> > +/* for commands, which return just a number depending on a channel: */
> > +/* get_temp, get_volt, get_fan_rpm */
> > +static int get_data(struct ccp_device *ccp, int command, int channel, long *val)
> > +{
> > +	int ret = 0;
> 
> Unnecessary initialization (almost everywhere).
> 
> > +	u8 *buffer;
> > +
> > +	buffer = kzalloc(OUT_BUFFER_SIZE, GFP_KERNEL);
> > +	if (buffer == 0)
> > +		return -ENOMEM;
> 
> AFAICS all those commands end up locking anyway. Might as well
> move the buffer into struct ccp_device and use it from there
> (ie lock while using it).
> 
> > +
> > +	buffer[0] = command;
> > +	buffer[1] = channel;
> > +	ret = send_usb_cmd(ccp, buffer);
> > +	if (ret)
> > +		return -EIO;
> 
> Please do not replace error codes - not just here, everywhere.
> 
> > +
> > +	*val = (buffer[1] << 8) + buffer[2];
> > +
> > +	kfree(buffer);
> > +	return ret;
> 
> Just return 0;
> 
> > +}
> > +
> > +static int set_pwm(struct ccp_device *ccp, int channel, long val)
> > +{
> > +	int ret = 0;
> > +	u8 *buffer;
> > +
> > +	if (val > 255)
> > +		return -EINVAL;
> 
> How about val < 0 ?
> 
> > +
> > +	ccp->pwm[channel] = val;
> > +
> > +	/* The Corsair Commander Pro uses values from 0-100 */
> > +	val = val << 8;
> > +	val = val / 255;
> > +	val = val * 100;
> > +	val = val >> 8;
> 
> 	val = DIV_ROUND_CLOSEST(val * 100, 255);
> 
> would be much easier to read.
> 
> > +
> > +	buffer = kzalloc(OUT_BUFFER_SIZE, GFP_KERNEL);
> > +	if (buffer == 0)
> 
> 	if (!buffer)
> > +		return -ENOMEM;
> > +
> > +	buffer[0] = CTL_SET_FAN_FPWM;
> > +	buffer[1] = channel;
> > +	buffer[2] = val;
> > +	ret = send_usb_cmd(ccp, buffer);
> > +
> > +	kfree(buffer);
> > +	return ret == 0 ? 0 : -EIO;
> > +}
> > +
> > +static int get_fan_mode_label(struct ccp_device *ccp, int channel)
> > +{
> > +	int ret = 0;
> > +	int mode;
> > +	u8 *buffer;
> > +
> > +	buffer = kzalloc(OUT_BUFFER_SIZE, GFP_KERNEL);
> > +	if (buffer == 0)
> > +		return -ENOMEM;
> > +
> > +	buffer[0] = CTL_GET_FAN_CNCT;
> > +	ret = send_usb_cmd(ccp, buffer);
> > +	if (ret)
> > +		goto exit;
> > +
> > +	mode = buffer[channel+1];
> 
> Space around operators (use checkpatch --strict to find all locations).
> 
> > +
> > +	switch (mode) {
> > +	case 0:
> > +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH,
> > +			  "fan%d nc", channel+1);
> > +		break;
> > +	case 1:
> > +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH,
> > +			  "fan%d 3pin", channel+1);
> > +		break;
> > +	case 2:
> > +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH,
> > +			  "fan%d 4pin", channel+1);
> > +		break;
> > +	default:
> > +		dev_err(&ccp->hdev->dev,
> > +			"Mode Description %d not implemented", mode);
> 
> If this is an error that needs to be logged you have to return an error.
> I would suggest to name the label something like "fanX other" instead
> in this situation.
> 
> > +		break;
> > +	}
> > +
> > +exit:
> > +	kfree(buffer);
> > +	return ret == 0 ? 0 : -EIO;
> 
> While it is unacceptable, I am curious why you override error codes everywhere.
> 
> > +}
> > +
> > +static int get_voltages(struct ccp_device *ccp, int channel, long *val)
> > +{
> > +	int ret = 0;
> > +
> > +	ret = get_data(ccp, CTL_GET_VOLT, channel, val);
> > +
> > +	return ret == 0 ? 0 : -EIO;
> > +}
> > +
> > +static int get_temp(struct ccp_device *ccp, int channel, long *val)
> > +{
> > +	int ret = 0;
> > +
> > +	ret = get_data(ccp, CTL_GET_TMP, channel, val);
> > +	*val = *val * 10;
> > +
> > +	return ret == 0 ? 0 : -EIO;
> > +}
> > +
> > +static int get_rpm(struct ccp_device *ccp, int channel, long *val)
> > +{
> > +	int ret = 0;
> > +
> > +	if (ccp->fan_enable[channel] != 1)
> 
> Valid values are 0 and 1, so != 1 is unnecessary. Use
> 	if (!ccp->fan_enable[channel])
> instead.
> 
> > +		return -ENODATA;
> > +
> > +	ret = get_data(ccp, CTL_GET_FAN_RPM, channel, val);
> > +
> > +	return ret == 0 ? 0 : -EIO;
> > +}
> > +
> > +static int ccp_read_string(struct device *dev, enum hwmon_sensor_types type,
> > +			   u32 attr, int channel, const char **str)
> > +{
> > +	int ret = 0;
> > +	struct ccp_device *ccp = dev_get_drvdata(dev);
> > +
> > +	switch (type) {
> > +	case hwmon_fan:
> > +		switch (attr) {
> > +		case hwmon_fan_label:
> > +			ret = get_fan_mode_label(ccp, channel);
> > +			*str = ccp->fan_label[channel];
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
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
> > +			ret = -EINVAL;
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
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_pwm:
> > +		switch (attr) {
> > +		case hwmon_pwm_input:
> > +			*val = ccp->pwm[channel];
> 
> This returns 0 if pwm wasn't set. Is this indeed not readable from the
> device ?

I could not find any possibility, because the official Corsair software does not use it.
I am not sure, whether it would be better to return an error, if it was not set.

> 
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_in:
> > +		switch (attr) {
> > +		case hwmon_in_input:
> > +			ret = get_voltages(ccp, channel, val);
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	return ret;
> > +};
> > +
> > +static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
> > +		     u32 attr, int channel, long val)
> > +{
> > +	int ret = 0;
> > +	struct ccp_device *ccp = dev_get_drvdata(dev);
> > +
> > +	switch (type) {
> > +	case hwmon_fan:
> > +		switch (attr) {
> > +		case hwmon_fan_enable:
> > +			ccp->fan_enable[channel] = val;
> 
> Needs to be validated. Accepting random values does not make sense here.
> 
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> 
> -EOPNOTSUPP for those cases.
> 
> > +			break;
> > +		}
> > +		break;
> > +	case hwmon_pwm:
> > +		switch (attr) {
> > +		case hwmon_pwm_input:
> > +			set_pwm(ccp, channel, val);
> 
> Do not ignore errors.
> 
> > +			break;
> > +		default:
> > +			ret = -EINVAL;
> > +			break;
> > +		}
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +		break;
> > +	}
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
> 
> 		default:
> 
> missing everywhere here.
> 
> > +		}
> > +		break;
> > +	case hwmon_temp:
> > +		switch (attr) {
> > +		case hwmon_temp_input:
> > +			return 0444;
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
> > +		}
> > +		break;
> > +	case hwmon_pwm:
> > +		switch (attr) {
> > +		case hwmon_pwm_input:
> > +			return 0644;
> > +		}
> > +		break;
> > +	case hwmon_in:
> > +		switch (attr) {
> > +		case hwmon_in_input:
> > +			return 0444;
> > +		}
> > +		break;
> > +	default:
> > +		break;
> > +	}
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
> > +
> 
> 
> Another unnecessary empty line.
> 
> > +};
> > +
> > +static int ccp_probe(struct hid_device *hdev, const struct hid_device_id *id)
> > +{
> > +	struct ccp_device *ccp;
> > +	int ret = 0;
> > +
> > +	ret = hid_parse(hdev);
> > +	if (ret) {
> > +		hid_err(hdev, "hid_parse failed\n");
> > +		goto exit;
> 
> 		return ret;
> 
> > +	}
> > +
> > +	ccp = devm_kzalloc(&hdev->dev, sizeof(struct ccp_device), GFP_KERNEL);
> > +	if (ccp == NULL)
> > +		goto exit;
> 
> 		return -ENOMEM;
> 
> > +
> > +	mutex_init(&ccp->mutex);
> > +
> > +	ccp->fan_enable[0] = 1;
> > +	ccp->fan_enable[1] = 1;
> > +	ccp->fan_enable[2] = 1;
> > +	ccp->fan_enable[3] = 1;
> > +	ccp->fan_enable[4] = 1;
> > +	ccp->fan_enable[5] = 1;
> > +
> > +	hid_set_drvdata(hdev, ccp);
> > +
> > +	ccp->hdev = hdev;
> > +	ccp->hwmondev = devm_hwmon_device_register_with_info(&hdev->dev,
> > +				"corsaircpro",
> > +				ccp,
> > +				&ccp_chip_info,
> > +				0);
> 
> This can return an ERR_PTR.
> 
> > +
> > +exit:
> > +	return ret;
> > +}
> > +
> > +static void ccp_remove(struct hid_device *hdev)
> > +{
> > +	struct ccp_device *ccp;
> > +
> > +	ccp = hid_get_drvdata(hdev);
> > +	mutex_destroy(&ccp->mutex);
> 
> The memory is about to be released, so this doesn't really add value.
> Just drop the remove function and forget about mutex_destroy().
> 
> > +}
> > +
> > +static const struct hid_device_id ccp_devices[] = {
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
> > +			 USB_PRODUCT_ID_CORSAIR_COMMANDERPRO) },
> > +	{ HID_USB_DEVICE(USB_VENDOR_ID_CORSAIR,
> > +			 USB_PRODUCT_ID_CORSAIR_1000D) },
> > +	{ }
> > +};
> > +
> > +static struct hid_driver ccp_driver = {
> > +	.name = "corsair-cpro",
> > +	.id_table = ccp_devices,
> > +	.probe = ccp_probe,
> > +	.remove = ccp_remove
> > +};
> > +
> > +MODULE_DEVICE_TABLE(hid, ccp_devices);
> > +MODULE_LICENSE("GPL v2");
> > +
> > +module_hid_driver(ccp_driver);
> 

Thank you for your time!


