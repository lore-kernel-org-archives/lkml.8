Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B0CC433EA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30B32073E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 15:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bd/2zj9R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727781AbgGZPEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727038AbgGZPEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 11:04:33 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638BFC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:04:33 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id r12so10985151ilh.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jul 2020 08:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cy1kfKoqbBTOduGPLXAZJZZM3FjDMdb2kIV7jTqpvB8=;
        b=bd/2zj9R8xWtjO21N1sls5F2Xk7J+WhtbgNOZvvXAh6W/gMWO035F1HWuLBlPRrAaZ
         Zw9jCiob4FrzUt5UV00l1EEGn7dpQ5pFoP7CWoIdMEfxpnKK+D6HTU6SafGSNbLvIENa
         IQfu/Pz2/8eWFR1jJl0vkwQ9JE1s7qqTaFPAXJrI82pXhk1MRimq4VSpT7tSokChRwCD
         dWpkDAwBpsTOVpUdNzPW7B2Yep5wNHuR1VNcrZ36fzsju25GH+Ckz4fHTYlAIn0WpTFx
         +oaF+5T6Tij+dGwzJO1keF1voVXzk57gvWHh1yTTxA0Ze8NUy48GZY9AHDxar5C/kLPn
         D+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cy1kfKoqbBTOduGPLXAZJZZM3FjDMdb2kIV7jTqpvB8=;
        b=CjxgkBKP67y6+aJp86zGIj71WhXnblvshenAqmFW8SqFgTVxJ66w8PYeoWv+LRb7Se
         1ipmj3EqqxU0wvu9xh/4aBFBPxb51ikd886wRxKnsk8Swyi2LBjGA3EWgo3fA54kl/3M
         wVprHd+EruCDjtkx+WoMaPNVdmET5LsxWu3Exn8gtHK1BLJt2kD8Pqo8Q13qu2IGRd3H
         kU/TNA1V8+0C5jxVfv4HUZkSmFFTOqw6H2jQ2SvgOMVG6mVjwmlky3lve1JlJr/yCTvT
         Rf+80gPJondTpJByMLEBzOOstrlDJ2LSG4jpEJQjVLO0kUf5svlsXQhY75nY9AXT0Srs
         YUog==
X-Gm-Message-State: AOAM530ybwe/m1py0tne+9XPVOl8P8emM2kMNkhcswcOPmT104sA9CyK
        vVmn4Bo4Bq4bENnPw88FqCMI2Q==
X-Google-Smtp-Source: ABdhPJycyhUKj6KfmxZ1g+GPrmDf2xnV06MJN3uQht1n/gQwLKFRRALdlldaJzYqqbS7i54/l9p7gw==
X-Received: by 2002:a92:41d2:: with SMTP id o201mr18650504ila.298.1595775871885;
        Sun, 26 Jul 2020 08:04:31 -0700 (PDT)
Received: from [172.22.22.26] (c-73-185-129-58.hsd1.mn.comcast.net. [73.185.129.58])
        by smtp.googlemail.com with ESMTPSA id y7sm6676088ili.56.2020.07.26.08.04.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jul 2020 08:04:31 -0700 (PDT)
Subject: Re: [greybus-dev] [PATCH] RFC : mikroBUS driver for add-on boards
To:     Vaishnav M A <vaishnav@beagleboard.org>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, johan@kernel.org,
        elder@kernel.org
Cc:     rajkovic@mikroe.com, robh@kernel.org, mchehab+huawei@kernel.org,
        robertcnelson@beagleboard.org, drew@beagleboard.org,
        davem@davemloft.net, zoran.stojsavljevic@gmail.com
References: <20200724120637.GA427284@vaishnav-VirtualBox>
From:   Alex Elder <elder@linaro.org>
Message-ID: <15cab987-6eaa-9137-0f70-4735b3fea87f@linaro.org>
Date:   Sun, 26 Jul 2020 10:04:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200724120637.GA427284@vaishnav-VirtualBox>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/24/20 7:06 AM, Vaishnav M A wrote:
> Attached is a patch for the mikroBUS driver which helps to
> instantiate an add-on board device on a mikrobus port by fetching
> the device identifier manifest binary from an EEPROM on-board
> the device. mikroBUS is an add-on board socket standard by
> MikroElektronika that can be freely used by anyone
> following the guidelines, more details and discussions on
> the status of the driver can be found here in this eLinux wiki:
> https://elinux.org/Mikrobus

I had some other things I would comment on in this code review,
but there are a lot of somewhat superficial things you should
fix.  I looked at much--but not all--of this, and I'll want to
review this again after you've fixed the simple things.  I also
can provide more substantive feedback after I've had more time
to digest the bigger picture of microBUS.

You should assume it will take a few iterations to get to the
point where things are shaping up for acceptance.

All that said, your basic foundation looks good.

> In the current state of the driver, more than 80 different
> add-on boards have been tested on the BeagleBoard.org
> PocketBeagle and the manifest binary is generated using the same
> manifesto tool used to generate Greybus manifest binaries,
> The pull request to manifesto to add new descriptors specific
> to mikrobus is here : https://github.com/projectara/manifesto/pull/2
> The utilization of Greybus manifest binaries here is not entirely
> coincidental, We are evaluating ways to add mikroBUS sockets and
> devices via Greybus expansion.
> 
> The mikroBUS standard includes SPI, I2C, UART, PWM, ADC, GPIO
> and power (3.3V and 5V) connections to interface common embedded
> peripherals, There are more than 750 add-on boards ranging from
> wireless connectivity boards to human-machine interface sensors
> which conform to the mikroBUS standard, out of which more than 140
> boards already have support in the Linux kernel.Today, there is no
> mainlinesolution for enabling mikroBUS add-on boards at run-time, the
> most straight forward method for loading drivers is to provide
> device-tree overlay fragments at boot time, this method suffers
> from the need to maintain a large out-of-tree database for which there
> is need to maintain an overlay for every mikroBUS add-on board for every
> Linux system and for every mikroBUS socket on that system.
> 
> The mikroBUS driver tries to solve the problem by using extended version
> of the greybus manifest to describe the add-on board device specific
> information required by the device driver and uses it along with the fixed
> port specific information to probe the specific device driver.The manifest
> binary is now fetched from an I2C EEPROM over the I2C bus on the mikroBUS
> port(subject to change in mikroBUS v3 specification) and enumerate drivers
> for the add-on devices.There is also ongoing work to define a mikroBUS
> v3 standard in which the addon board includes a non-volatile storage to
> store the device identifier manifest binary, once the mikroBUS v3 standard
> is released, the mikroBUS can be seen as a probeable bus such that the
> kernel can discover the device on the bus at boot time.
> 
> The driver also has a few debug SysFS interfaces for testing on add-on
> boards without an EEPROM, these can be used in the following manner:
> (example for mikroBUS port 1 on BeagleBoard.org PocketBeagle):

You should probably use debugfs, since this is a temporary thing.
But I guess if it's not actually upstream (and it sounds like you
might be avoiding the need for this with EEPROM anyway) maybe
that doesn't matter much.

> printf "%b" '\x01\x00\x00\x59\x32\x17' > /sys/bus/mikrobus/add_port
> 
> The bytes in the byte array sequence are (in order):
> 
> 	* i2c_adap_nr
> 	* spi_master_nr
> 	* serdev_ctlr_nr
> 	* rst_gpio_nr
> 	* pwm_gpio_nr
> 	* int_gpio_nr
> * add_port sysFS entry is purely for debug and in the actual state
> of the driver, port configuration will be loaded from a suitable
> device tree overlay fragment.
> 
> echo 0 > /sys/bus/mikrobus/del_port (to delete the attached port)
> echo 1 >  /sys/class/mikrobus-port/mikrobus-0/rescan (to rescan the EEPROM
> contents on the I2C bus on the mikroBUS port).
> 
> cat board_manifest.mnfb >  /sys/class/mikrobus-port/mikrobus-0/new_device
> * debug interface to pass the manifest binary in case an EEPROM is absent
> echo 0 >  /sys/class/mikrobus-port/mikrobus-0/delete_device
> * to unload the loaded board on the mikrobus port
> 
> These sysFS interfaces are only implemented for debug purposes and
> in the actual implementation of the driver these will be removed and
> the manifest binary will be fetched from the non volatile storage on-board
> the device.
> 
> The mikroBUS driver enable the mikroBUS to be a probeable bus such that
> the kernel can discover the device and automatically load the drivers.
> There are already several Linux platforms with mikroBUS sockets and the
> mikroBUS driver helps to reduce the time to develop and debug
> support for various mikroBUS add-on boards. Further, it opens up
> the possibility for support under dynamically instantiated buses
> such as with Greybus.
> 
> Please let know the feedback you have on this patch or the approach used.
> 
> Thanks,
> 
> Vaishnav M A
> 
> Signed-off-by: Vaishnav M A <vaishnav@beagleboard.org>
> ---
>  MAINTAINERS                               |   6 +
>  drivers/misc/Kconfig                      |   1 +
>  drivers/misc/Makefile                     |   1 +
>  drivers/misc/mikrobus/Kconfig             |  16 +
>  drivers/misc/mikrobus/Makefile            |   5 +
>  drivers/misc/mikrobus/mikrobus_core.c     | 649 ++++++++++++++++++++++
>  drivers/misc/mikrobus/mikrobus_core.h     | 130 +++++
>  drivers/misc/mikrobus/mikrobus_manifest.c | 390 +++++++++++++
>  drivers/misc/mikrobus/mikrobus_manifest.h |  21 +
>  include/linux/greybus/greybus_manifest.h  |  53 ++
>  10 files changed, 1272 insertions(+)
>  create mode 100644 drivers/misc/mikrobus/Kconfig
>  create mode 100644 drivers/misc/mikrobus/Makefile
>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.c
>  create mode 100644 drivers/misc/mikrobus/mikrobus_core.h
>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.c
>  create mode 100644 drivers/misc/mikrobus/mikrobus_manifest.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d53db30d1365..9a049746203f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -11402,6 +11402,12 @@ M:	Oliver Neukum <oliver@neukum.org>
>  S:	Maintained
>  F:	drivers/usb/image/microtek.*
>  
> +MIKROBUS ADDON BOARD DRIVER
> +M:	Vaishnav M A <vaishnav@beagleboard.org>
> +S:	Maintained
> +W:	https://elinux.org/Mikrobus
> +F:	drivers/misc/mikrobus/
> +
>  MIPS
>  M:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>  L:	linux-mips@vger.kernel.org
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index e1b1ba5e2b92..334f0c39d56b 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -472,4 +472,5 @@ source "drivers/misc/ocxl/Kconfig"
>  source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/habanalabs/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
> +source "drivers/misc/mikrobus/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index c7bd01ac6291..45486dd77da5 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -40,6 +40,7 @@ obj-$(CONFIG_VMWARE_BALLOON)	+= vmw_balloon.o
>  obj-$(CONFIG_PCH_PHUB)		+= pch_phub.o
>  obj-y				+= ti-st/
>  obj-y				+= lis3lv02d/
> +obj-y				+= mikrobus/
>  obj-$(CONFIG_ALTERA_STAPL)	+=altera-stapl/
>  obj-$(CONFIG_INTEL_MEI)		+= mei/
>  obj-$(CONFIG_VMWARE_VMCI)	+= vmw_vmci/
> diff --git a/drivers/misc/mikrobus/Kconfig b/drivers/misc/mikrobus/Kconfig
> new file mode 100644
> index 000000000000..c3b93e12daad
> --- /dev/null
> +++ b/drivers/misc/mikrobus/Kconfig
> @@ -0,0 +1,16 @@
> +menuconfig MIKROBUS
> +	tristate "Module for instantiating devices on mikroBUS ports"
> +	help
> +	  This option enables the mikroBUS driver. mikroBUS is an add-on
> +	  board socket standard that offers maximum expandability with
> +	  the smallest number of pins. The mikroBUS driver helps in
> +	  instantiating devices on the mikroBUS port with identifier
> +	  data fetched from an EEPROM on the device, more details on
> +	  the mikroBUS driver support and discussion can be found in
> +	  this eLinux wiki : elinux.org/Mikrobus

This text could be cleaned up a bit.  For example:
	The mikroBUS driver instantiates devices on a mikroBUS port
	described by identifying data present in device-resident EEPROM.

Using well-defined terms can help a lot.  Is a physical thing that
plugs into a microbus port called a "board"?  Can a "board" present
more than one device to the system?  Is the EEPROM associated with
the board, or a device?  My point isn't that those answers belong
here, but that having meaningful terms can help you describe things
concisely.

> +	  Say Y here to enable support for this driver.
> +
> +	  To compile this code as a module, chose M here: the module
> +	  will be called mikrobus.ko
> diff --git a/drivers/misc/mikrobus/Makefile b/drivers/misc/mikrobus/Makefile
> new file mode 100644
> index 000000000000..1f80ed4064d8
> --- /dev/null
> +++ b/drivers/misc/mikrobus/Makefile
> @@ -0,0 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +# mikroBUS Core
> +
> +mikrobus-y :=	mikrobus_core.o	mikrobus_manifest.o
> +obj-$(CONFIG_MIKROBUS) += mikrobus.o
> \ No newline at end of file
> diff --git a/drivers/misc/mikrobus/mikrobus_core.c b/drivers/misc/mikrobus/mikrobus_core.c
> new file mode 100644
> index 000000000000..78c96c637632
> --- /dev/null
> +++ b/drivers/misc/mikrobus/mikrobus_core.c
> @@ -0,0 +1,649 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mikroBUS driver for instantiating add-on
> + * board devices with an identifier EEPROM
> + *
> + * Copyright 2020 Vaishnav M A, BeagleBoard.org Foundation.
> + */
> +
> +#define pr_fmt(fmt) "mikrobus: " fmt
> +
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/idr.h>
> +#include <linux/init.h>
> +#include <linux/jump_label.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/mutex.h>
> +#include <linux/device.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/i2c.h>
> +#include <linux/gpio.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/nvmem-consumer.h>
> +#include <linux/nvmem-provider.h>
> +#include <linux/interrupt.h>
> +#include <linux/spi/spi.h>
> +#include <linux/serdev.h>
> +#include <linux/property.h>
> +#include <linux/slab.h>
> +
> +#include "mikrobus_core.h"
> +#include "mikrobus_manifest.h"
> +
> +#define ATMEL_24C32_I2C_ADDR 0x57

I'm just getting started looking through this, so maybe I'll find
out soon. But why is this ATMEL I2C address needed in the core code?

> +static DEFINE_IDR(mikrobus_port_idr);
> +static struct class_compat *mikrobus_port_compat_class;
> +static bool is_registered;
> +
> +static ssize_t add_port_store(struct bus_type *bt, const char *buf,
> +			      size_t count)
> +{
> +	struct mikrobus_port_config *cfg;
> +
> +	if (count < sizeof(*cfg)) {

Perhaps this should be:
	if (count != sizeof(*cfg)) {

> +		pr_err("add_port: incorrect config data received: %s\n", buf);

I don't think you need to include "add_port: ".

This is binary data you are writing to this sysfs file, correct?
Don't try to interpret it as a string.  You could avoid the problem
with something more like:
    pr_err("bad port config size (%zu, should be %zu)", count, sizeof(*cfg));

> +		return -EINVAL;
> +	}
> +	mikrobus_register_port_config((void *)buf);

mikrobus_register_port_config() returns an error value, and
that should be returned from this function if it's non-zero.

Don't cast the buffer to a void pointer; cast it to the actual
type represents (struct mikrobus_port_config *).

> +	return count;
> +}
> +BUS_ATTR_WO(add_port);
> +
> +static ssize_t del_port_store(struct bus_type *bt, const char *buf,
> +							  size_t count)
> +{
> +	int id;
> +	char end;
> +	int res;
> +
> +	res = sscanf(buf, "%d%c", &id, &end);

The id value you pass to idr_find() is an unsigned long.
You might as well define "id" with that type and scan that
type here.  Make sure it's in the valid range for your
identifier as a separate step.  (There might be a good
reason you use a signed int as an identifier, but I would
recommend unsigned, with a well-defined number of bits,
such as u32).

Is "end" intended to just consume an optional trailing newline?

> +	if (res < 1) {
> +		pr_err("delete_port: cannot parse mikrobus port ID\n");

I don't think "delete_port: " here is necessary.  (Take this
comment to apply in all similar cases; I won't mention it
again.)

> +		return -EINVAL;
> +	}
> +	if (!idr_find(&mikrobus_port_idr, id)) {
> +		pr_err("attempting to delete unregistered port [%d]\n", id);

Maybe just "mikrobus port %lu not registered".

> +		return -EINVAL;
> +	}
> +	mikrobus_del_port(idr_find(&mikrobus_port_idr, id));
> +	return count;
> +}
> +BUS_ATTR_WO(del_port);
> +
> +static struct attribute *mikrobus_attrs[] = {
> +	&bus_attr_add_port.attr,
> +	&bus_attr_del_port.attr,
> +	 NULL
> +};
> +ATTRIBUTE_GROUPS(mikrobus);
> +
> +struct bus_type mikrobus_bus_type = {
> +	.name = "mikrobus",
> +	.bus_groups = mikrobus_groups,
> +};
> +EXPORT_SYMBOL_GPL(mikrobus_bus_type);
> +
> +static int mikrobus_manifest_header_validate(struct mikrobus_port *port)
> +{
> +	char header[12];
> +	struct addon_board_info *board;
> +	int manifest_size;
> +	int retval;
> +	char *buf;
> +
> +	nvmem_device_read(port->eeprom, 0, 12, header);

This function returns a value, and if it's less than zero you
should return it as the result of mikrobus_manifest_header_validate()
(possibly after reporting an error).

> +	manifest_size = mikrobus_manifest_header_validate(header, 12);
> +	if (manifest_size > 0) {
> +		buf = kzalloc(manifest_size, GFP_KERNEL);

Check whether kzalloc() returns NULL, and if so, return -ENOMEM.

> +		nvmem_device_read(port->eeprom, 0, manifest_size, buf);

Check the return value here, and if negative, free your buffer
and return the error.  (I won't make this comment any more if
I see other instances of ignoring the nvmem_device_read()
return value.)

> +		board = kzalloc(sizeof(*board), GFP_KERNEL);
> +		if (!board)
> +			return -ENOMEM;

You need to free the buffer you allocated before you return here.
It is helpful to use the "goto <error path>" pattern.  I.e.:

	if (!board) {
		retval = -ENOMEM;
		goto err_free_buf;
	}
...

err_free_buf:
	kfree(buf);

	return retval;
}

> +		INIT_LIST_HEAD(&board->manifest_descs);
> +		INIT_LIST_HEAD(&board->devices);
> +		retval = mikrobus_manifest_parse(board, (void *)buf, manifest_size);

No need to cast buf to (void *).

I have more comments on mikrobus_manifest_parse() below.  But it
might be useful to have it return an integer (0 or error code)
rather than Boolean.  Assuming you did that...

> +		if (!retval) {
> +			pr_err("failed to parse manifest, size: %d", manifest_size);

	if (retval)
		goto err_free_board;
...

err_free_board:
	free_board(board);
err_free_buf:
	free_buf(buf);

	return retval;
}

> +			return -EINVAL;
> +		}
> +		retval = mikrobus_register_board(port, board);
> +		if (retval) {
> +			pr_err("failed to register board: %s", board->name);

	goto err_free_board;

> +			return -EINVAL;
> +		}
> +		kfree(buf);
> +	} else {
> +		pr_err("inavlide manifest port %d", port->id);

s/inavlide/invalid/

> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t name_show(struct device *dev, struct device_attribute *attr,
> +						 char *buf)
> +{
> +	return sprintf(buf, "%s\n", to_mikrobus_port(dev)->name);
> +}
> +static DEVICE_ATTR_RO(name);
> +
> +static ssize_t new_device_store(struct device *dev, struct device_attribute *attr,
> +					 const char *buf, size_t count)
> +{
> +	struct mikrobus_port *port = to_mikrobus_port(dev);
> +	struct addon_board_info *board;
> +	int retval;
> +
> +	if (port->board == NULL) {

This is just a style suggestion, but I would prefer this, because it
reduces the indentation of the normal path:

	if (port->board) {
		pr_err("mikrobus port %d already has a board registered\n",
			port->id);
		return -EBUSY;
	}

	port->board = kzalloc(...);
	if (!port->board)
		return -ENOMEM;

Also note the return values I suggest here.

> +		board = kzalloc(sizeof(*board), GFP_KERNEL);
> +		if (!board)
> +			return -EINVAL;
> +		INIT_LIST_HEAD(&board->manifest_descs);
> +		INIT_LIST_HEAD(&board->devices);
> +	} else {
> +		pr_err("port %d already has board registered", port->id);
> +		return -EINVAL;
> +	}
> +	retval = mikrobus_manifest_parse(board, (void *)buf, count);
> +	if (!retval) {
> +		pr_err("failed to parse manifest");
> +		return -EINVAL;
> +	}
> +	retval = mikrobus_register_board(port, board);
> +	if (retval) {
> +		pr_err("failed to register board: %s", board->name);
> +		return -EINVAL;
> +	}
> +	return count;
> +}
> +static DEVICE_ATTR_WO(new_device);
> +
> +static ssize_t rescan_store(struct device *dev, struct device_attribute *attr,
> +							const char *buf, size_t count)
> +{
> +	struct mikrobus_port *port = to_mikrobus_port(dev);
> +	int id;
> +	char end;
> +	int res;
> +	int retval;
> +
> +	res = sscanf(buf, "%d%c", &id, &end);
> +	if (res < 1) {
> +		pr_err("rescan: Can't parse trigger\n");
> +		return -EINVAL;
> +	}
> +	if (port->board != NULL) {
> +		pr_err("port %d already has board registered", port->id);
> +		return -EINVAL;
> +	}
> +	retval = mikrobus_port_scan_eeprom(port);
> +	if (retval) {
> +		pr_err("port %d board register from manifest failed", port->id);
> +		return -EINVAL;
> +	}
> +	return count;
> +}
> +static DEVICE_ATTR_WO(rescan);
> +
> +static ssize_t delete_device_store(struct device *dev, struct device_attribute *attr,
> +							const char *buf, size_t count)
> +{
> +	int id;
> +	char end;
> +	int res;
> +	struct mikrobus_port *port = to_mikrobus_port(dev);
> +
> +	res = sscanf(buf, "%d%c", &id, &end);
> +	if (res < 1) {
> +		pr_err("delete_board: Can't parse board ID\n");
> +		return -EINVAL;
> +	}
> +	if (port->board == NULL) {

Normally in kernel code this form is used:

	if (!port->board) {

> +		pr_err("delete_board: port does not have any boards registered\n");
> +		return -EINVAL;
> +	}
> +	mikrobus_unregister_board(port, port->board);
> +	return count;
> +}
> +static DEVICE_ATTR_IGNORE_LOCKDEP(delete_device, 0200, NULL, delete_device_store);
> +
> +static struct attribute *mikrobus_port_attrs[] = {
> +	&dev_attr_new_device.attr, &dev_attr_rescan.attr,
> +	&dev_attr_delete_device.attr, &dev_attr_name.attr, NULL};
> +ATTRIBUTE_GROUPS(mikrobus_port);
> +
> +static void mikrobus_dev_release(struct device *dev)
> +{
> +	struct mikrobus_port *port = to_mikrobus_port(dev);
> +
> +	idr_remove(&mikrobus_port_idr, port->id);
> +	kfree(port);
> +}
> +
> +struct device_type mikrobus_port_type = {
> +	.groups = mikrobus_port_groups,
> +	.release = mikrobus_dev_release,
> +};
> +EXPORT_SYMBOL_GPL(mikrobus_port_type);
> +
> +static int mikrobus_get_irq(struct mikrobus_port *port, int irqno,
> +							int irq_type)
> +{
> +	int irq;
> +
> +	switch (irqno) {
> +	case MIKROBUS_GPIO_INT:
> +	irq = gpiod_to_irq(port->int_gpio);
> +	break;

Please fix your indentation here.  (And everywhere; I give
an example of the proper way to do it below.)

> +	case MIKROBUS_GPIO_RST:
> +	irq = gpiod_to_irq(port->rst_gpio);
> +	break;
> +	case MIKROBUS_GPIO_PWM:
> +	irq = gpiod_to_irq(port->pwm_gpio);
> +	break;
> +	default:
> +	return -EINVAL;
> +	}
> +	if (irq < 0) {
> +		pr_err("Could not get irq for irq type: %d", irqno);
> +		return -EINVAL;
> +	}
> +	irq_set_irq_type(irq, irq_type);

It shouldn't return an error, but please check the
return value here.

> +	return irq;
> +}
> +
> +static int mikrobus_setup_gpio(struct gpio_desc *gpio, int gpio_state)
> +{
> +	int retval;
> +
> +	if (gpio_state == MIKROBUS_GPIO_UNUSED)
> +		return 0;
> +	switch (gpio_state) {
> +	case MIKROBUS_GPIO_INPUT:
> +	retval = gpiod_direction_input(gpio);
> +	break;
> +	case MIKROBUS_GPIO_OUTPUT_HIGH:
> +	retval = gpiod_direction_output(gpio, 1);
> +	gpiod_set_value_cansleep(gpio, 1);
> +	break;
> +	case MIKROBUS_GPIO_OUTPUT_LOW:
> +	retval = gpiod_direction_output(gpio, 0);
> +	gpiod_set_value_cansleep(gpio, 0);
> +	break;
> +	default:
> +	return -EINVAL;
> +	}
> +	return retval;
> +}
> +
> +static void mikrobus_spi_device_delete(struct spi_master *master, unsigned int cs)
> +{
> +	struct device *dev;
> +	char str[32];
> +
> +	snprintf(str, sizeof(str), "%s.%u", dev_name(&master->dev), cs);
> +	dev = bus_find_device_by_name(&spi_bus_type, NULL, str);
> +	if (dev != NULL) {
> +		spi_unregister_device(to_spi_device(dev));
> +		put_device(dev);
> +	}
> +}
> +
> +static char *mikrobus_get_gpio_chip_name(struct mikrobus_port *port, int gpio)
> +{
> +	char *name;
> +	struct gpio_chip *gpiochip;
> +
> +	switch (gpio) {
> +	case MIKROBUS_GPIO_INT:
> +	gpiochip = gpiod_to_chip(port->int_gpio);
> +	name = kmemdup(gpiochip->label, 40, GFP_KERNEL);

Why 40?  Please use a symbolic constant so you can
change it easily, and to give you a place to explain
why 40 is the limit used.

> +	break;
> +	case MIKROBUS_GPIO_RST:
> +	gpiochip = gpiod_to_chip(port->rst_gpio);
> +	name = kmemdup(gpiochip->label, 40, GFP_KERNEL);
> +	break;
> +	case MIKROBUS_GPIO_PWM:
> +	gpiochip = gpiod_to_chip(port->pwm_gpio);
> +	name = kmemdup(gpiochip->label, 40, GFP_KERNEL);
> +	break;
> +	}
> +	return name;
> +}
> +
> +static int mikrobus_get_gpio_hwnum(struct mikrobus_port *port, int gpio)
> +{
> +	int hwnum;
> +	struct gpio_chip *gpiochip;
> +
> +	switch (gpio) {
> +	case MIKROBUS_GPIO_INT:
> +	gpiochip = gpiod_to_chip(port->int_gpio);
> +	hwnum = desc_to_gpio(port->int_gpio) - gpiochip->base;
> +	break;
> +	case MIKROBUS_GPIO_RST:
> +	gpiochip = gpiod_to_chip(port->rst_gpio);
> +	hwnum = desc_to_gpio(port->rst_gpio) - gpiochip->base;
> +	break;
> +	case MIKROBUS_GPIO_PWM:
> +	gpiochip = gpiod_to_chip(port->pwm_gpio);
> +	hwnum = desc_to_gpio(port->pwm_gpio) - gpiochip->base;
> +	break;
> +	}
> +	return hwnum;
> +}
> +
> +static void release_mikrobus_device(struct board_device_info *dev)

We tend to follow a convention throughout the Greybus code
that has the object name as the prefix for things you do
to the object.  I don't know how consistent that is, but
my suggestion would be that these functions would be named
something more like:
    mikrobus_gpio_chip_name_get()
    mikrobus_gpio_hwnum_get()
    mikrobus_board_release_device_all()
    mikrobus_device_register()
    mikrobus_device_unregister()
    mikrobus_board_register()
    mikrobus_board_unregister()
and so on.

> +{
> +	list_del(&dev->links);
> +	kfree(dev);
> +}
> +

(I skipped reviewing a lot here...)
. . .

> diff --git a/drivers/misc/mikrobus/mikrobus_core.h b/drivers/misc/mikrobus/mikrobus_core.h
> new file mode 100644
> index 000000000000..9684d315f564
> --- /dev/null
> +++ b/drivers/misc/mikrobus/mikrobus_core
. . .

> diff --git a/drivers/misc/mikrobus/mikrobus_manifest.c b/drivers/misc/mikrobus/mikrobus_manifest.c
> new file mode 100644
> index 000000000000..60ebca560f0d
> --- /dev/null
> +++ b/drivers/misc/mikrobus/mikrobus_manifest.c
> @@ -0,0 +1,390 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * mikroBUS manifest parsing, an
> + * extension to Greybus Manifest Parsing
> + * under drivers/greybus/manifest.c
> + *
> + * Copyright 2014-2015 Google Inc.
> + * Copyright 2014-2015 Linaro Ltd.
> + */
> +
> +#define pr_fmt(fmt) "mikrobus_manifest: " fmt
> +
> +#include <linux/bits.h>
> +#include <linux/types.h>
> +#include <linux/property.h>
> +#include <linux/greybus/greybus_manifest.h>
> +
> +#include "mikrobus_manifest.h"
> +
> +struct manifest_desc {
> +	struct list_head links;
> +	size_t size;
> +	void *data;
> +	enum greybus_descriptor_type type;
> +};
> +
> +static void release_manifest_descriptor(struct manifest_desc *descriptor)
> +{
> +	list_del(&descriptor->links);
> +	kfree(descriptor);
> +}
> +
> +static void release_manifest_descriptors(struct addon_board_info *info)
> +{
> +	struct manifest_desc *descriptor;
> +	struct manifest_desc *next;
> +
> +	list_for_each_entry_safe(descriptor, next, &info->manifest_descs, links)
> +		release_manifest_descriptor(descriptor);
> +}
> +
> +static int identify_descriptor(struct addon_board_info *info, struct greybus_descriptor *desc,
> +										 size_t size)
> +{

I know it's technically acceptable now, but please limit your lines to
80 characters in the Greybus code if possible.

> +	struct greybus_descriptor_header *desc_header = &desc->header;
> +	struct manifest_desc *descriptor;
> +	size_t desc_size;
> +	size_t expected_size;
> +
> +	if (size < sizeof(*desc_header))
> +		return -EINVAL;
> +	desc_size = le16_to_cpu(desc_header->size);
> +	if (desc_size > size)
> +		return -EINVAL;

Probably check if (desc_size != size) here.

> +	expected_size = sizeof(*desc_header);
> +	switch (desc_header->type) {
> +	case GREYBUS_TYPE_STRING:
> +	expected_size += sizeof(struct greybus_descriptor_string);
> +	expected_size += desc->string.length;
> +	expected_size = ALIGN(expected_size, 4);
> +	break;

Your indentation is wrong here.  Please use:

	switch (desc_header->type) {
	case GREYBUS_TYPE_STRING:
		expected_size += ...;
		...
		break;
	case GREYBUS_TYPE_PROPERTY:
		...

> +	case GREYBUS_TYPE_PROPERTY:
> +	expected_size += sizeof(struct greybus_descriptor_property);
> +	expected_size += desc->property.length;
> +	expected_size = ALIGN(expected_size, 4);
> +	break;
> +	case GREYBUS_TYPE_DEVICE:
> +	expected_size += sizeof(struct greybus_descriptor_device);
> +	break;
> +	case GREYBUS_TYPE_MIKROBUS:
> +	expected_size += sizeof(struct greybus_descriptor_mikrobus);
> +	break;
> +	case GREYBUS_TYPE_INTERFACE:
> +	expected_size += sizeof(struct greybus_descriptor_interface);
> +	break;
> +	case GREYBUS_TYPE_CPORT:
> +	expected_size += sizeof(struct greybus_descriptor_cport);
> +	break;
> +	case GREYBUS_TYPE_BUNDLE:
> +	expected_size += sizeof(struct greybus_descriptor_bundle);
> +	break;
> +	case GREYBUS_TYPE_INVALID:
> +	default:
> +	return -EINVAL;
> +	}
> +
> +	descriptor = kzalloc(sizeof(*descriptor), GFP_KERNEL);
> +	if (!descriptor)
> +		return -ENOMEM;
> +	descriptor->size = desc_size;
> +	descriptor->data = (char *)desc + sizeof(*desc_header);
> +	descriptor->type = desc_header->type;
> +	list_add_tail(&descriptor->links, &info->manifest_descs);
> +	return desc_size;
> +}

. . .

> +static int mikrobus_manifest_attach_device(struct addon_board_info *info,
> +						struct greybus_descriptor_device *dev_desc)
> +{
> +	struct board_device_info *dev;

I would suggest something other than "dev" as the name of
a board_device.  The use of "dev" for (struct device *)
is pretty prevalent in the kernel, and so using it here
can be more confusing than it has to be.

> +	struct gpiod_lookup_table *lookup;
> +	struct greybus_descriptor_property *desc_property;
> +	struct manifest_desc *descriptor;
> +	int i;
> +	u8 *prop_link;
> +	u8 *gpio_desc_link;
> +
> +	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +	dev->id = dev_desc->id;
> +	dev->drv_name = mikrobus_string_get(info, dev_desc->driver_stringid);

This can return NULL.  You need to check for that, and free
the board device you have already allocated.

> +	dev->protocol = dev_desc->protocol;
> +	dev->reg = dev_desc->reg;
> +	dev->irq = dev_desc->irq;
> +	dev->irq_type = dev_desc->irq_type;
> +	dev->max_speed_hz = le32_to_cpu(dev_desc->max_speed_hz);
> +	dev->mode = dev_desc->mode;
> +	dev->cs_gpio = dev_desc->cs_gpio;
> +	dev->num_gpio_resources = dev_desc->num_gpio_resources;
> +	dev->num_properties = dev_desc->num_properties;
> +	pr_info("device %d , number of properties=%d , number of gpio resources=%d\n",
> +	dev->id, dev->num_properties, dev->num_gpio_resources);
> +	if (dev->num_properties > 0) {
> +		prop_link = mikrobus_property_link_get(info, dev_desc->prop_link,
> +								MIKROBUS_PROPERTY_TYPE_LINK);
> +		dev->properties = mikrobus_property_entry_get(info, prop_link, dev->num_properties);
> +	}
> +	if (dev->num_gpio_resources > 0) {
> +		lookup = kzalloc(struct_size(lookup, table, dev->num_gpio_resources),
> +					GFP_KERNEL);
> +	if (!lookup)
> +		return -ENOMEM;

You can't return without freeing your previously-allocated resources.

> +	gpio_desc_link = mikrobus_property_link_get(info, dev_desc->gpio_link,
> +						MIKROBUS_PROPERTY_TYPE_GPIO);
> +	for (i = 0; i < dev->num_gpio_resources; i++) {
> +		list_for_each_entry(descriptor, &info->manifest_descs, links) {
> +			if (descriptor->type != GREYBUS_TYPE_PROPERTY)
> +				continue;
> +			desc_property = descriptor->data;
> +			if (desc_property->id == gpio_desc_link[i]) {
> +				lookup->table[i].chip_hwnum = *desc_property->value;
> +				lookup->table[i].con_id =
> +				mikrobus_string_get(info, desc_property->propname_stringid);
> +				break;
> +				}
> +		}
> +	}
> +	dev->gpio_lookup = lookup;
> +	}
> +	list_add_tail(&dev->links, &info->devices);
> +	return 0;
> +}
> +
> +static int mikrobus_manifest_parse_devices(struct addon_board_info *info)
> +{
> +	struct greybus_descriptor_device *desc_device;
> +	struct manifest_desc *desc, *next;
> +	int devcount = 0;
> +
> +	if (WARN_ON(!list_empty(&info->devices)))
> +		return false;

The manifest comes from outside the kernel  I might be misunderstanding
something, but you should not be using WARN_ON() if its content doesn't
match what you expect.

> +	list_for_each_entry_safe(desc, next, &info->manifest_descs, links) {
> +		if (desc->type != GREYBUS_TYPE_DEVICE)
> +			continue;
> +		desc_device = desc->data;
> +		mikrobus_manifest_attach_device(info, desc_device);

You are ignoring the return value of mikrobus_manifest_attach_device().

> +		devcount++;
> +	}
> +	return devcount;
> +}
> +
> +bool mikrobus_manifest_parse(struct addon_board_info *info, void *data,
> +							 size_t size)

You use "board" as the name of a "board_info" variable elsewhere.
That is much more helpful than "info".  Please use a consistent
naming convention for your variables of given types if possible.
It makes it easier to follow the code.

> +{
> +	struct greybus_manifest *manifest;
> +	struct greybus_manifest_header *header;
> +	struct greybus_descriptor *desc;
> +	u16 manifest_size;
> +	int dev_count;
> +	int desc_size;
> +

Check the size before you bother checking anything else.

> +	if (WARN_ON(!list_empty(&info->manifest_descs)))
> +		return false;
> +	if (size < sizeof(*header))
> +		return false;
> +	manifest = data;
> +	header = &manifest->header;
> +	manifest_size = le16_to_cpu(header->size);
> +	if (manifest_size != size)
> +		return false;

It would be helpful to report what the problem with the
manifest is (here and in all cases).  Otherwise it's a
little mysterious why adding a board fails.

> +	if (header->version_major > MIKROBUS_VERSION_MAJOR)
> +		return false;

Version checks!!!  This is good!  But the topic is of great
interest to Greybus people!  Not sure we ever completely
resolved that.  That's my only comment on this for now.

> +	desc = manifest->descriptors;
> +	size -= sizeof(*header);

Why aren't you using mikrobus_manifest_header_validate() here?

> +	while (size) {
> +		desc_size = identify_descriptor(info, desc, size);

What you're really doing with identify_descriptor() is adding
a valid descriptor to a board's list of descriptors.  I think
the name of that function shoudl reflect that.  If it isn't
identified, that's an error--but that's not the purpose of
that function.  So maybe:
	desc_ = board_descriptor_add(board, desc, size);

> +		if (desc_size < 0) {
> +			pr_err("invalid manifest descriptor");
> +		return -EINVAL;
Your indentation of the return statement here is wrong.

> +		}
> +		desc = (struct greybus_descriptor *)((char *)desc + desc_size);

I don't know if this is better, but this could be:
		desc = (void *)desc + desc_size;

> +		size -= desc_size;
> +	}
> +	mikrobus_state_get(info);
> +	dev_count = mikrobus_manifest_parse_devices(info);
> +	pr_info(" %s manifest parsed with %d device(s)\n", info->name,
> +		info->num_devices);
> +	release_manifest_descriptors(info);
> +	return true;
> +}
> +
> +size_t mikrobus_manifest_header_validate(void *data, size_t size)
> +{
> +	struct greybus_manifest_header *header;
> +	u16 manifest_size;
> +
> +	if (size < sizeof(*header))
> +		return 0;
> +
> +	header = data;
> +	manifest_size = le16_to_cpu(header->size);
> +	if (header->version_major > MIKROBUS_VERSION_MAJOR)
> +		return 0;
> +	return manifest_size;
> +}
> diff --git a/drivers/misc/mikrobus/mikrobus_manifest.h b/drivers/misc/mikrobus/mikrobus_manifest.h
> new file mode 100644
> index 000000000000..a195d1c26493
> --- /dev/null
> +++ b/drivers/misc/mikrobus/mikrobus_manifest.h
> @@ -0,0 +1,21 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * mikroBUS manifest definition
> + * extension to Greybus Manifest Definition
> + *
> + * Copyright 2014-2015 Google Inc.
> + * Copyright 2014-2015 Linaro Ltd.
> + *
> + * Released under the GPLv2 and BSD licenses.
> + */
> +
> +#ifndef __MIKROBUS_MANIFEST_H
> +#define __MIKROBUS_MANIFEST_H
> +
> +#include "mikrobus_core.h"
> +
> +bool mikrobus_manifest_parse(struct addon_board_info *info, void *data,
> +							 size_t size);
> +size_t mikrobus_manifest_header_validate(void *data, size_t size);
> +
> +#endif /* __MIKROBUS_MANIFEST_H */
> diff --git a/include/linux/greybus/greybus_manifest.h b/include/linux/greybus/greybus_manifest.h
> index 6e62fe478712..79c8cab9ef96 100644
> --- a/include/linux/greybus/greybus_manifest.h
> +++ b/include/linux/greybus/greybus_manifest.h
> @@ -23,6 +23,9 @@ enum greybus_descriptor_type {
>  	GREYBUS_TYPE_STRING		= 0x02,
>  	GREYBUS_TYPE_BUNDLE		= 0x03,
>  	GREYBUS_TYPE_CPORT		= 0x04,
> +	GREYBUS_TYPE_MIKROBUS	= 0x05,
> +	GREYBUS_TYPE_PROPERTY	= 0x06,
> +	GREYBUS_TYPE_DEVICE	= 0x07,

Please align your new values with the rest, for consistency.

>  };
>  
>  enum greybus_protocol {
> @@ -151,6 +154,53 @@ struct greybus_descriptor_cport {
>  	__u8	protocol_id;	/* enum greybus_protocol */
>  } __packed;
>  
> +/*
> + * A mikrobus descriptor is used to describe the details
> + * about the add-on board connected to the mikrobus port.
> + * It describes the number of indivdual devices on the
> + * add-on board and the default states of the GPIOs
> + */
> +struct greybus_descriptor_mikrobus {
> +	__u8 num_devices;
> +	__u8 rst_gpio_state;
> +	__u8 pwm_gpio_state;
> +	__u8 int_gpio_state;
> +} __packed;
> +
> +/*
> + * A property descriptor is used to pass named properties
> + * to device drivers through the unified device properties
> + * interface under linux/property.h
> + */
> +struct greybus_descriptor_property {
> +	__u8 length;
> +	__u8 id;
> +	__u8 propname_stringid;
> +	__u8 type;
> +	__u8 value[0];
> +} __packed;
> +
> +/*
> + * A device descriptor is used to describe the
> + * details required by a add-on board device
> + * driver.
> + */
> +struct greybus_descriptor_device {
> +	__u8 id;
> +	__u8 driver_stringid;
> +	__u8 num_properties;
> +	__u8 protocol;
> +	__le32 max_speed_hz;
> +	__u8 reg;
> +	__u8 mode;
> +	__u8 num_gpio_resources;
> +	__u8 cs_gpio;
> +	__u8 irq;
> +	__u8 irq_type;
> +	__u8 prop_link;
> +	__u8 gpio_link;
> +} __packed;
> +
>  struct greybus_descriptor_header {
>  	__le16	size;
>  	__u8	type;		/* enum greybus_descriptor_type */
> @@ -164,6 +214,9 @@ struct greybus_descriptor {
>  		struct greybus_descriptor_interface	interface;
>  		struct greybus_descriptor_bundle	bundle;
>  		struct greybus_descriptor_cport		cport;
> +		struct greybus_descriptor_mikrobus	mikrobus;
> +		struct greybus_descriptor_property	property;
> +		struct greybus_descriptor_device	device;

We're going to need to talk about these things...  But I can't
comment much more without learning more about the broader
architecture.

					-Alex

>  	};
>  } __packed;
>  
> 

