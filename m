Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA07C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 22:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D1352068E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 22:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnlMwCfC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgFNWZ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgFNWZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 18:25:58 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0ABAC05BD43;
        Sun, 14 Jun 2020 15:25:58 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id u8so5921968pje.4;
        Sun, 14 Jun 2020 15:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+E3c1OlnmfviQVr0//Dz1+IVCasUtyYvPR5dHz6vbFQ=;
        b=pnlMwCfCnqeBs4FNQe1pcT8pOPjEidtkFXBu4IpBOnapM6V7Pr6kcK08UvvCW2oauC
         aMblwz2sHLdr1BBNYePDUirSuT46/tUQ5iGde1FbFJNsUMpL+Y3pGjcIDziUqiGBHCVz
         n858O5c3+09ddM14TWjdocHiG75WLyCEbwMTmF/N/r/qVLzPMzH0SqLTqtQzg9H478/L
         2gPcCFnavTjtURMid3uoNy/DwPZa6g2br/AH2QuAvok0e43nFkX7ygbnetzbB2X8aINm
         NQNWi5JyrWsfPvCBq/LDaSuXD20EMWWUpSOovSyEE3o8dmQhaQw7O/cbxWnIoZQHyh8H
         aKCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=+E3c1OlnmfviQVr0//Dz1+IVCasUtyYvPR5dHz6vbFQ=;
        b=sy/WcdJzfdqlosmIx7f1kDbZpsgU181+SAtd8zCROoxqerF8KXDaxe/xzPYYsGZuDf
         zTd1DHZC62zkhgq7l6EgSMlNZMa9dHwq3eKH5t6Tj8rJ2ndr5aE24XUMoB2pleFvFz1F
         +dFyfXJ8pPEVHFxQhZMcY3k6XACBIC2gld4CAX1kG8/sZEvebgoac0a7jZ43D2YL9eh+
         iLy+fqFLcDgk0nMldQ8r5laZsU7LbXAqC2ExadFfxMMH2+XQZQQ+hBcW4AQm6Q0JdXfq
         xf0qRXjGc/u9J2bHNTJKCOXL9iuDRIG798rVFjfeNFeTnXioyZcIX3XNhjIJAt2nEzzf
         v7aw==
X-Gm-Message-State: AOAM530UysmvkHWBU4wjPWzMm8Sy4/8wZclkodalrlVVZg25GxgxGuEq
        CeKWXcSnC293kyp+bTIBFJOW0Vuj
X-Google-Smtp-Source: ABdhPJynqGd5wZTlpwDmxWn3u2NzqpBdBBfhpbw6TO/lU+jVd3LGuYnwKstn4+qdpLoOD2qN3bRMvg==
X-Received: by 2002:a17:902:d352:: with SMTP id l18mr20079885plk.68.1592173557558;
        Sun, 14 Jun 2020 15:25:57 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id 17sm12122577pfn.19.2020.06.14.15.25.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Jun 2020 15:25:56 -0700 (PDT)
Subject: Re: [RFC v2] hwmon: add Corsair Commander Pro driver
To:     Marius Zachmann <mail@mariuszachmann.de>
Cc:     jdelvare@suse.com, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <4064217.uIqdvtiHzK@marius>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <1bdfa5cb-ad9c-ab4c-351f-5b86d38c3eb8@roeck-us.net>
Date:   Sun, 14 Jun 2020 15:25:55 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <4064217.uIqdvtiHzK@marius>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/12/20 6:29 AM, Marius Zachmann wrote:
> This is a driver for the Corsair Commander Pro.
> It provides sysfs attributes for:
> - Reading fan speed
> - Reading temp sensors
> - Reading voltage values
> - Writing pwm and reading last written pwm
> 
> Changed it to a USB driver for a couple of reasons.
> Still need to add it to the hid_ignore_list in hid-quirks.c
> 
> Signed-off-by: Marius Zachmann <mail@mariuszachmann.de>
> ---
> 
> Changes from v1:
> - Style issues
> - Changed to USB driver
> - Clarify reading pwm in Documentation and code
> - Fixed attribute name number in Documentation
> - MODULE_LICENSE now "GPL"
> - Removed unneccesary hwmondev in ccp_device
> - Moved buffer to ccp_device and mutex out of send_usb_cmd
> - No more replacing or ignoring error codes
> - Use DIV_ROUND_CLOSEST in set_pwm
> - Changed fan_label when unknown to "fanX other"
> - Only accept 0 or 1 for fan_enable
> - Check for ERR_PTR in ccp_probe
> ---
>  Documentation/hwmon/corsair-cpro.rst |  43 +++

The new document needs to be added to Documentation/hwmon/index.rst.

>  MAINTAINERS                          |   6 +
>  drivers/hwmon/Kconfig                |  10 +
>  drivers/hwmon/Makefile               |   1 +
>  drivers/hwmon/corsair-cpro.c         | 451 +++++++++++++++++++++++++++
>  5 files changed, 511 insertions(+)
>  create mode 100644 Documentation/hwmon/corsair-cpro.rst
>  create mode 100644 drivers/hwmon/corsair-cpro.c
> 
> diff --git a/Documentation/hwmon/corsair-cpro.rst b/Documentation/hwmon/corsair-cpro.rst
> new file mode 100644
> index 000000000000..57de8f4d630b
> --- /dev/null
> +++ b/Documentation/hwmon/corsair-cpro.rst
> @@ -0,0 +1,43 @@

SPDX license identifier missing (see other recent files for examples).

> +Kernel driver corsair-cpro
> +==========================
> +
> +Supported devices:
> +
> +  * Corsair Commander Pro
> +  * Corsair Commander Pro (1000D)
> +
> +Author: Marius Zachmann
> +
> +Description
> +-----------
> +
> +This driver implements the sysfs interface for the Corsair Commander Pro.
> +The Corsair Commander Pro is a USB device with 6 fan connectors,
> +4 temperature sensor connectors and 2 Corsair LED connectors.
> +It can read the voltage levels on the SATA power connector.
> +
> +Usage Notes
> +-----------
> +
> +Since it is a USB device, hotswapping is possible. The device is autodetected.
> +
> +Sysfs entries
> +-------------
> +
> +in0_input		Voltage on SATA 12v
> +in1_input		Voltage on SATA 5v
> +in2_input		Voltage on SATA 3.3v
> +
> +temp[1-4]_input		Connected temperature sensors
> +
> +fan[1-6]_input		Connected fan rpm.
> +fan[1-6]_label		Shows connection status of the fan as detected by the
> +			device.
> +			"fanX nc"   no connection
> +			"fanX 3pin" 3-pin fan detected
> +			"fanX 4pin" 4-pin fan detected
> +fan[1-6]_enable		the driver only reports fan speeds when 1
> +

This use isn't acceptable as implemented. It is a pure software
flag, and not communicated to the chip/device.

To disable reporting of disconnected fans, mark it as "ignore"
in /etc/sensors3.conf.

> +pwm[1-6]		Sets the fan speed. Values from 0-255.
> +			When reading, it reports the last value if it was set by the driver.
> +			Otherwise returns 0.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f08f290df174..169530c7eede 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -4386,6 +4386,12 @@ S:	Maintained
>  F:	Documentation/hwmon/coretemp.rst
>  F:	drivers/hwmon/coretemp.c
>  
> +CORSAIR-CPRO HARDWARE MONITOR DRIVER
> +M:	Marius Zachmann <mail@mariuszachmann.de>
> +L:	linux-hwmon@vger.kernel.org
> +S:	Maintained
> +F:	drivers/hwmon/corsair-cpro.c
> +
>  COSA/SRP SYNC SERIAL DRIVER
>  M:	Jan "Yenya" Kasprzak <kas@fi.muni.cz>
>  S:	Maintained
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index 288ae9f63588..8b046a5dfa40 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -439,6 +439,16 @@ config SENSORS_BT1_PVT_ALARMS
>  	  the data conversion will be periodically performed and the data will be
>  	  saved in the internal driver cache.
>  
> +config SENSORS_CORSAIR_CPRO
> +	tristate "Corsair Commander Pro controller"
> +	depends on USB
> +	help
> +	  If you say yes here you get support for the Corsair Commander Pro
> +	  controller.
> +
> +	  This driver can also be built as a module. If so, the module
> +	  will be called corsair-cpro.
> +
>  config SENSORS_DRIVETEMP
>  	tristate "Hard disk drives with temperature sensors"
>  	depends on SCSI && ATA
> diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
> index 3e32c21f5efe..18e1ef74ade7 100644
> --- a/drivers/hwmon/Makefile
> +++ b/drivers/hwmon/Makefile
> @@ -56,6 +56,7 @@ obj-$(CONFIG_SENSORS_ATXP1)	+= atxp1.o
>  obj-$(CONFIG_SENSORS_AXI_FAN_CONTROL) += axi-fan-control.o
>  obj-$(CONFIG_SENSORS_BT1_PVT)	+= bt1-pvt.o
>  obj-$(CONFIG_SENSORS_CORETEMP)	+= coretemp.o
> +obj-$(CONFIG_SENSORS_CORSAIR_CPRO) += corsair-cpro.o
>  obj-$(CONFIG_SENSORS_DA9052_ADC)+= da9052-hwmon.o
>  obj-$(CONFIG_SENSORS_DA9055)+= da9055-hwmon.o
>  obj-$(CONFIG_SENSORS_DELL_SMM)	+= dell-smm-hwmon.o
> diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
> new file mode 100644
> index 000000000000..f7a4d80239c2
> --- /dev/null
> +++ b/drivers/hwmon/corsair-cpro.c
> @@ -0,0 +1,451 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * corsair-cpro.c - Linux driver for Corsair Commander Pro
> + * Copyright (C) 2020 Marius Zachmann <mail@mariuszachmann.de>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/hwmon.h>
> +#include <linux/mutex.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <linux/usb.h>
> +
> +#define USB_VENDOR_ID_CORSAIR               0x1b1c
> +#define USB_PRODUCT_ID_CORSAIR_COMMANDERPRO 0x0c10
> +#define USB_PRODUCT_ID_CORSAIR_1000D	    0x1d00
> +
> +#define OUT_BUFFER_SIZE	63
> +#define IN_BUFFER_SIZE	16
> +#define LABEL_LENGTH	11
> +
> +#define CTL_GET_TMP	 0x11  /* send: byte 1 is channel, rest zero		  */
> +			       /* rcv:  returns temp for channel in bytes 1 and 2 */
> +#define CTL_GET_VOLT	 0x12  /* send: byte 1 = rail number 12, 5, 3.3 */
> +			       /* rcv:  returns volt in bytes 1,2	*/
> +#define CTL_GET_FAN_CNCT 0x20  /* returns in bytes 1-6	*/
> +			       /* 0 for no connect	*/
> +			       /* 1 for 3pin, 2 for 4pin */
> +#define CTL_GET_FAN_RPM	 0x21  /* works like CTL_GET_TMP */
> +#define CTL_SET_FAN_FPWM 0x23  /* send: byte 1 is fan number		  */
> +			       /* send: byte 2 is percentage from 0 - 100 */
> +
> +struct ccp_device {
> +	struct usb_device *udev;
> +	struct mutex mutex; /* whenever buffer is used or usb calls are made */
> +	u8 *buffer;
> +	int pwm[6];
> +	int fan_enable[6];
> +	char fan_label[6][LABEL_LENGTH];
> +};
> +
> +/* send 63 byte buffer and receive response in same buffer */
> +static int send_usb_cmd(struct ccp_device *ccp)
> +{
> +	int ret;
> +	int actual_length;
> +
> +	ret = usb_bulk_msg(ccp->udev, usb_sndintpipe(ccp->udev, 2), ccp->buffer, OUT_BUFFER_SIZE,
> +			   &actual_length, 1000);
> +	if (ret) {
> +		dev_err(&ccp->udev->dev, "usb_bulk_msg send failed: %d", ret);
> +		return ret;
> +	}
> +
> +	ret = usb_bulk_msg(ccp->udev, usb_rcvintpipe(ccp->udev, 1), ccp->buffer, IN_BUFFER_SIZE,
> +			   &actual_length, 1000);
> +	if (ret) {
> +		dev_err(&ccp->udev->dev, "usb_bulk_msg receive failed: %d", ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +/* for commands, which return just a number depending on a channel: */
> +/* get_temp, get_volt, get_fan_rpm */

Please use standard multi-line comments.

> +static int get_data(struct ccp_device *ccp, int command, int channel, long *val)
> +{
> +	int ret;
> +
> +	mutex_lock(&ccp->mutex);
> +
> +	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> +	ccp->buffer[0] = command;
> +	ccp->buffer[1] = channel;
> +	ret = send_usb_cmd(ccp);
> +	if (ret)
> +		goto exit;
> +
> +	*val = (ccp->buffer[1] << 8) + ccp->buffer[2];
> +
> +exit:
> +	mutex_unlock(&ccp->mutex);
> +	return ret;
> +}
> +
> +static int set_pwm(struct ccp_device *ccp, int channel, long val)
> +{
> +	int ret;
> +
> +	if (val < 0 || val > 255)
> +		return -EINVAL;
> +
> +	ccp->pwm[channel] = val;
> +
> +	/* The Corsair Commander Pro uses values from 0-100 */
> +	val = DIV_ROUND_CLOSEST(val * 100, 255);
> +
> +	mutex_lock(&ccp->mutex);
> +
> +	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> +	ccp->buffer[0] = CTL_SET_FAN_FPWM;
> +	ccp->buffer[1] = channel;
> +	ccp->buffer[2] = val;

As it turns out (unless I am missing something), all commands have
one, two, or three parameters. Also, the full buffer is always
written. With that, it would be easier to add command, channel,
and value as parameters to send_usb_cmd() and handle both
memset() and assignments there.

> +	ret = send_usb_cmd(ccp);
> +

This makes me wonder if reading a response is always necessary.
If not, it might make sense to add a flag to the function indicating
that no response is needed, and skip the read part there. If it is
needed, it might make sense to add a comment into the send function,
explaining that a read command must be executed even if no data is
returned.

> +	mutex_unlock(&ccp->mutex);
> +	return ret;
> +}
> +
> +static int get_fan_mode_label(struct ccp_device *ccp, int channel)
> +{
> +	int ret;
> +	int mode;
> +
> +	mutex_lock(&ccp->mutex);
> +
> +	memset(ccp->buffer, 0x00, OUT_BUFFER_SIZE);
> +	ccp->buffer[0] = CTL_GET_FAN_CNCT;
> +	ret = send_usb_cmd(ccp);
> +	if (ret)
> +		goto exit;
> +
> +	mode = ccp->buffer[channel + 1];
> +
> +	switch (mode) {
> +	case 0:
> +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d nc", channel + 1);
> +		break;
> +	case 1:
> +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d 3pin", channel + 1);
> +		break;
> +	case 2:
> +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d 4pin", channel + 1);
> +		break;
> +	default:
> +		scnprintf(ccp->fan_label[channel], LABEL_LENGTH, "fan%d other", channel + 1);
> +		break;
> +	}
> +
> +exit:
> +	mutex_unlock(&ccp->mutex);
> +	return ret;
> +}
> +
> +static int get_voltage(struct ccp_device *ccp, int channel, long *val)
> +{
> +	int ret;
> +
> +	ret = get_data(ccp, CTL_GET_VOLT, channel, val);
> +
> +	return ret;

	return get_data(ccp, CTL_GET_VOLT, channel, val);

would accomplish the same.

> +}
> +
> +static int get_temp(struct ccp_device *ccp, int channel, long *val)
> +{
> +	int ret;
> +
> +	ret = get_data(ccp, CTL_GET_TMP, channel, val);
> +	*val = *val * 10;
> +
> +	return ret;
> +}
> +
> +static int get_rpm(struct ccp_device *ccp, int channel, long *val)
> +{
> +	int ret;
> +
> +	if (!ccp->fan_enable[channel])
> +		return -ENODATA;

As mentioned, this isn't the intended use case for enable attributes.
Unless it is indeed possible to inform the device that it shall not
monitor a given fan, please drop the attribute and handle it in userspace.

> +
> +	ret = get_data(ccp, CTL_GET_FAN_RPM, channel, val);
> +
> +	return ret;
> +}
> +
> +static int ccp_read_string(struct device *dev, enum hwmon_sensor_types type,
> +			   u32 attr, int channel, const char **str)
> +{
> +	int ret;
> +	struct ccp_device *ccp = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_label:
> +			ret = get_fan_mode_label(ccp, channel);
> +			if (ret == 0)
> +				*str = ccp->fan_label[channel];
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int ccp_read(struct device *dev, enum hwmon_sensor_types type,
> +		    u32 attr, int channel, long *val)
> +{
> +	int ret = 0;
> +	struct ccp_device *ccp = dev_get_drvdata(dev);
> +
> +	switch (type) {
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			ret = get_temp(ccp, channel, val);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			ret = get_rpm(ccp, channel, val);
> +			break;
> +		case hwmon_fan_enable:
> +			*val = ccp->fan_enable[channel];
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			/* how to read pwm values from the device is currently unknown */
> +			/* driver returns last set value or 0		               */
> +			*val = ccp->pwm[channel];
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			ret = get_voltage(ccp, channel, val);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +};
> +
> +static int ccp_write(struct device *dev, enum hwmon_sensor_types type,
> +		     u32 attr, int channel, long val)
> +{
> +	int ret = 0;
> +	struct ccp_device *ccp = dev_get_drvdata(dev);

Nit: Revertse christmas tree ordering of variables is preferred.

> +
> +	switch (type) {
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_enable:
> +			if (val == 0 || val == 1)
> +				ccp->fan_enable[channel] = val;
> +			else
> +				ret = -EINVAL;
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			ret = set_pwm(ccp, channel, val);
> +			break;
> +		default:
> +			ret = -EOPNOTSUPP;
> +			break;
> +		}
> +		break;
> +	default:
> +		ret = -EOPNOTSUPP;
> +		break;
> +	}
> +
> +	return ret;
> +};
> +
> +static umode_t ccp_is_visible(const void *data, enum hwmon_sensor_types type,
> +			      u32 attr, int channel)
> +{
> +	switch (type) {
> +	case hwmon_chip:
> +		switch (attr) {
> +		case hwmon_chip_update_interval:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_temp:
> +		switch (attr) {
> +		case hwmon_temp_input:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_fan:
> +		switch (attr) {
> +		case hwmon_fan_input:
> +			return 0444;
> +		case hwmon_fan_label:
> +			return 0444;
> +		case hwmon_fan_enable:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_pwm:
> +		switch (attr) {
> +		case hwmon_pwm_input:
> +			return 0644;
> +		default:
> +			break;
> +		}
> +		break;
> +	case hwmon_in:
> +		switch (attr) {
> +		case hwmon_in_input:
> +			return 0444;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +};
> +
> +static const struct hwmon_ops ccp_hwmon_ops = {
> +	.is_visible = ccp_is_visible,
> +	.read = ccp_read,
> +	.write = ccp_write,
> +	.read_string = ccp_read_string,
> +};
> +
> +static const struct hwmon_channel_info *ccp_info[] = {
> +	HWMON_CHANNEL_INFO(chip,
> +			   HWMON_C_REGISTER_TZ | HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(temp,
> +			   HWMON_T_INPUT | HWMON_T_MAX,
> +			   HWMON_T_INPUT | HWMON_T_MAX,
> +			   HWMON_T_INPUT | HWMON_T_MAX,
> +			   HWMON_T_INPUT | HWMON_T_MAX
> +			   ),
> +	HWMON_CHANNEL_INFO(fan,
> +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL,
> +			   HWMON_F_INPUT | HWMON_F_ENABLE | HWMON_F_LABEL
> +			   ),
> +	HWMON_CHANNEL_INFO(pwm,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT,
> +			   HWMON_PWM_INPUT
> +			   ),
> +	HWMON_CHANNEL_INFO(in,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT,
> +			   HWMON_I_INPUT
> +			   ),
> +	NULL
> +};
> +
> +static const struct hwmon_chip_info ccp_chip_info = {
> +	.ops = &ccp_hwmon_ops,
> +	.info = ccp_info,
> +};
> +
> +static int ccp_probe(struct usb_interface *intf, const struct usb_device_id *id)
> +{
> +	struct ccp_device *ccp;
> +	struct device *hwmon_dev;
> +
> +	ccp = devm_kzalloc(&intf->dev, sizeof(struct ccp_device), GFP_KERNEL);
> +	if (!ccp)
> +		return -ENOMEM;
> +
> +	ccp->buffer = devm_kmalloc(&intf->dev, OUT_BUFFER_SIZE, GFP_KERNEL);
> +	if (!ccp->buffer)
> +		return -ENOMEM;
> +
> +	mutex_init(&ccp->mutex);
> +
> +	ccp->fan_enable[0] = 1;
> +	ccp->fan_enable[1] = 1;
> +	ccp->fan_enable[2] = 1;
> +	ccp->fan_enable[3] = 1;
> +	ccp->fan_enable[4] = 1;
> +	ccp->fan_enable[5] = 1;
> +	ccp->udev = interface_to_usbdev(intf);
> +
> +	hwmon_dev = devm_hwmon_device_register_with_info(&intf->dev, "corsaircpro", ccp,
> +							 &ccp_chip_info, 0);
> +
> +	return PTR_ERR_OR_ZERO(hwmon_dev);
> +}
> +
> +void ccp_disconnect(struct usb_interface *intf)
> +{
> +}
> +
> +static const struct usb_device_id ccp_devices[] = {
> +	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_COMMANDERPRO) },
> +	{ USB_DEVICE(USB_VENDOR_ID_CORSAIR, USB_PRODUCT_ID_CORSAIR_1000D) },
> +	{ }
> +};
> +
> +static struct usb_driver ccp_driver = {
> +	.name = "corsair-cpro",
> +	.id_table = ccp_devices,
> +	.probe = ccp_probe,
> +	.disconnect = ccp_disconnect
> +};
> +
> +MODULE_DEVICE_TABLE(usb, ccp_devices);
> +MODULE_LICENSE("GPL");
> +
> +module_usb_driver(ccp_driver);
> 

