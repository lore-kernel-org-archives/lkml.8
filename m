Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EACC38A29
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:07:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FFA120882
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 00:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="X3qCotOx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j/LmYC61"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726069AbgDTAHo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 20:07:44 -0400
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:47209 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725947AbgDTAHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 20:07:43 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id F1CC63AA;
        Sun, 19 Apr 2020 20:07:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 19 Apr 2020 20:07:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=j
        KPX4aiFB8HlVPvIgQHPpjtH0cunwi5HivF3p49j9EY=; b=X3qCotOxskCvsoPcB
        d92mJSLG1vYnG5heCHdRy6TEsefHLlRAIt3r+wp4JCZZUwT2rD7ehbKMUrim5aGd
        X/5lE2Y2JX2SgrE+cgW/lmuIXRfEUZMq8G65QvUopKG8H5dC+LFcQ1j+cyYcTS+3
        TiV0rX1w3wO7aKGOTl/8z6aDPyrwmZRUwBWVLY0v4DJdJOn89ag8s26pHlgL6TAn
        Ss/K0D7Yh3QryYfW9vzKg1SyB33XSySTYtntzAbH9Hlj/Q8+7lANuh3Jn/gMrBOK
        s2QkcbTvZVgGcqNCpNlSI1TI36MMWDhFpWaFFVWoOg3X2ohCBM6OLRiv5ehtBbnL
        qrkcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=jKPX4aiFB8HlVPvIgQHPpjtH0cunwi5HivF3p49j9
        EY=; b=j/LmYC61M1RtUGpMVSPg5vra2PXxnYK+zLgJw0T3L55BjpFhPRJRbtiL+
        bOFFJPtZL7ONxAPYA8wJCu6Gw+LVtK0l5JiKl8a1100lMw0cx3Sko2NXOMGS7PhT
        ZlttyfljSnmHNc6PEbXM4tZSSdBuNPWqUrrnjXiFgNJZdqPm6bdw4hExkVhTlJJ/
        L7DvIityiJlMsGNaP+mlenMRxbEV3sQPzanqYpXG/KmIaz8/MUAc/lTEWs8ZGCGz
        Ib8NqTIxk/Xbt5CeTWleRfYkW9YVjydSEhAAwI9yb2Azl3gFYQHTSDyLQjdhC2It
        Pgo5XxDcD+XRDHhOKFEQ9GbJNb4/w==
X-ME-Sender: <xms:zeecXmXUs-O0fFwAnde0bxiKwfiXnaJBX1ZrnmXcEyTmJU5VPzSUIw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgedvgddvlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:zeecXiQCCB4inheZTAddBSdmTquBQMFztn4PBJwuO1mizow0SdA1fg>
    <xmx:zeecXlOHX3_dZL2N0zjvfxX7OCjAiSFuEOi6W050r9DQzWtfkbaFqA>
    <xmx:zeecXvzrFejhU2UuIw2mE1Mn3bYT806tUWdaTBXnCDZm95ZFQttUiw>
    <xmx:zeecXqLpxqLxywYAr_5AxzTfjk8dXysjK_RJl7_O_CwTlpjR8JYfzA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B96EF3280065;
        Sun, 19 Apr 2020 20:07:40 -0400 (EDT)
Subject: Re: [PATCH v4 1/2] firmware: google: Expose CBMEM over sysfs
To:     patrick.rudolph@9elements.com, linux-kernel@vger.kernel.org
Cc:     coreboot@coreboot.org, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Allison Randal <allison@lohutok.net>,
        Julius Werner <jwerner@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com>
 <20200407082923.2001556-2-patrick.rudolph@9elements.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <a624d2a1-a839-f9f2-c54f-410fd86664a0@sholland.org>
Date:   Sun, 19 Apr 2020 19:07:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200407082923.2001556-2-patrick.rudolph@9elements.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/20 3:29 AM, patrick.rudolph@9elements.com wrote:
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
> 
> Make all CBMEM buffers available to userland. This is useful for tools
> that are currently using /dev/mem.
> 
> Make the id, size and address available, as well as the raw table data.
> 
> Tools can easily scan the right CBMEM buffer by reading
> /sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/id
> or
> /sys/bus/coreboot/devices/coreboot*/cbmem_attributes/id
> 
> The binary table data can then be read from
> /sys/bus/coreboot/drivers/cbmem/coreboot*/cbmem_attributes/data
> or
> /sys/bus/coreboot/devices/coreboot*/cbmem_attributes/data
> 
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---
>  -v2:
>         - Add ABI documentation
>         - Add 0x prefix on hex values
>  -v3:
>         - Use BIN_ATTR_RO
>  -v4:
>         - Use temporary memremap instead of persistent ioremap
>         - Constify a struct
>         - Get rid of unused headers
>         - Use dev_{get|set}_drvdata
>         - Use dev_groups to automatically handle attributes
>         - Updated file description
>         - Updated ABI documentation
> ---
>  Documentation/ABI/stable/sysfs-bus-coreboot |  44 +++++++
>  drivers/firmware/google/Kconfig             |   9 ++
>  drivers/firmware/google/Makefile            |   1 +
>  drivers/firmware/google/cbmem-coreboot.c    | 128 ++++++++++++++++++++
>  drivers/firmware/google/coreboot_table.h    |  14 +++
>  5 files changed, 196 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-bus-coreboot
>  create mode 100644 drivers/firmware/google/cbmem-coreboot.c
> 
> diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/ABI/stable/sysfs-bus-coreboot
> new file mode 100644
> index 000000000000..6055906f41f2
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-bus-coreboot
> @@ -0,0 +1,44 @@
> +What:		/sys/bus/coreboot/devices/.../cbmem_attributes/id
> +Date:		Apr 2020
> +KernelVersion:	5.6

I guess these will be 5.8 now.

> +Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +		coreboot device directory can contain a file named
> +		cbmem_attributes/id if the device corresponds to a CBMEM
> +		buffer.
> +		The file holds an ASCII representation of the CBMEM ID in hex
> +		(e.g. 0xdeadbeef).
> +
> +What:		/sys/bus/coreboot/devices/.../cbmem_attributes/size
> +Date:		Apr 2020
> +KernelVersion:	5.6
> +Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +		coreboot device directory can contain a file named
> +		cbmem_attributes/size if the device corresponds to a CBMEM
> +		buffer.
> +		The file holds an representation as decimal number of the

nit: "a representation" (maybe "a decimal representation"?)

> +		CBMEM buffer size (e.g. 64).
> +
> +What:		/sys/bus/coreboot/devices/.../cbmem_attributes/address
> +Date:		Apr 2020
> +KernelVersion:	5.6
> +Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +		coreboot device directory can contain a file named
> +		cbmem_attributes/address if the device corresponds to a CBMEM
> +		buffer.
> +		The file holds an ASCII representation of the physical address
> +		of the CBMEM buffer in hex (e.g. 0x000000008000d000) and should
> +		be used for debugging only.
> +
> +What:		/sys/bus/coreboot/devices/.../cbmem_attributes/data
> +Date:		Apr 2020
> +KernelVersion:	5.6
> +Contact:	Patrick Rudolph <patrick.rudolph@9elements.com>
> +Description:
> +		coreboot device directory can contain a file named
> +		cbmem_attributes/data if the device corresponds to a CBMEM
> +		buffer.
> +		The file holds a read-only binary representation of the CBMEM
> +		buffer.
> diff --git a/drivers/firmware/google/Kconfig b/drivers/firmware/google/Kconfig
> index a3a6ca659ffa..11a67c397ab3 100644
> --- a/drivers/firmware/google/Kconfig
> +++ b/drivers/firmware/google/Kconfig
> @@ -58,6 +58,15 @@ config GOOGLE_FRAMEBUFFER_COREBOOT
>  	  This option enables the kernel to search for a framebuffer in
>  	  the coreboot table.  If found, it is registered with simplefb.
>  
> +config GOOGLE_CBMEM_COREBOOT
> +	tristate "Coreboot CBMEM access"
> +	depends on GOOGLE_COREBOOT_TABLE
> +	help
> +	  This option exposes all available CBMEM buffers to userland.
> +	  The CBMEM id, size and address as well as the raw table data
> +	  are exported as sysfs attributes of the corresponding coreboot
> +	  table.
> +
>  config GOOGLE_MEMCONSOLE_COREBOOT
>  	tristate "Firmware Memory Console"
>  	depends on GOOGLE_COREBOOT_TABLE
> diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
> index d17caded5d88..62053cd6d058 100644
> --- a/drivers/firmware/google/Makefile
> +++ b/drivers/firmware/google/Makefile
> @@ -2,6 +2,7 @@
>  
>  obj-$(CONFIG_GOOGLE_SMI)		+= gsmi.o
>  obj-$(CONFIG_GOOGLE_COREBOOT_TABLE)        += coreboot_table.o
> +obj-$(CONFIG_GOOGLE_CBMEM_COREBOOT)        += cbmem-coreboot.o
>  obj-$(CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT)  += framebuffer-coreboot.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
>  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
> diff --git a/drivers/firmware/google/cbmem-coreboot.c b/drivers/firmware/google/cbmem-coreboot.c
> new file mode 100644
> index 000000000000..f76704a6eec7
> --- /dev/null
> +++ b/drivers/firmware/google/cbmem-coreboot.c
> @@ -0,0 +1,128 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * cbmem-coreboot.c
> + *
> + * Exports CBMEM as attributes in sysfs.
> + *
> + * Copyright 2012-2013 David Herrmann <dh.herrmann@gmail.com>
> + * Copyright 2017 Google Inc.
> + * Copyright 2019 9elements Agency GmbH
> + */
> +
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/module.h>
> +#include <linux/io.h>
> +
> +#include "coreboot_table.h"
> +
> +#define CB_TAG_CBMEM_ENTRY 0x31
> +
> +struct cb_priv {
> +	struct lb_cbmem_entry entry;
> +};
> +
> +static ssize_t id_show(struct device *dev,
> +		       struct device_attribute *attr, char *buffer)
> +{
> +	const struct cb_priv *priv = dev_get_drvdata(dev);
> +
> +	return sprintf(buffer, "%#08x\n", priv->entry.id);
> +}
> +
> +static ssize_t size_show(struct device *dev,
> +			 struct device_attribute *attr, char *buffer)
> +{
> +	const struct cb_priv *priv = dev_get_drvdata(dev);
> +
> +	return sprintf(buffer, "%u\n", priv->entry.entry_size);
> +}
> +
> +static ssize_t address_show(struct device *dev,
> +			    struct device_attribute *attr, char *buffer)
> +{
> +	const struct cb_priv *priv = dev_get_drvdata(dev);
> +
> +	return sprintf(buffer, "%#016llx\n", priv->entry.address);
> +}
> +
> +static DEVICE_ATTR_RO(id);
> +static DEVICE_ATTR_RO(size);
> +static DEVICE_ATTR_RO(address);
> +
> +static struct attribute *cb_mem_attrs[] = {
> +	&dev_attr_address.attr,
> +	&dev_attr_id.attr,
> +	&dev_attr_size.attr,
> +	NULL
> +};
> +
> +static ssize_t data_read(struct file *filp, struct kobject *kobj,
> +			 struct bin_attribute *bin_attr,
> +			 char *buffer, loff_t offset, size_t count)
> +{
> +	const struct device *dev = kobj_to_dev(kobj);
> +	const struct cb_priv *priv = dev_get_drvdata(dev);
> +	void *ptr;
> +
> +	/* CBMEM is always RAM with unknown caching attributes. */
> +	ptr = memremap(priv->entry.address, priv->entry.entry_size,
> +		       MEMREMAP_WB | MEMREMAP_WT);
> +	if (!ptr)
> +		return -ENOMEM;
> +
> +	count = memory_read_from_buffer(buffer, count, &offset, ptr,
> +					priv->entry.entry_size);
> +	memunmap(ptr);
> +
> +	return count;
> +}
> +
> +static BIN_ATTR_RO(data, 0);
> +
> +static struct bin_attribute *cb_mem_bin_attrs[] = {
> +	&bin_attr_data,
> +	NULL
> +};
> +
> +static const struct attribute_group cb_mem_attr_group = {
> +	.name = "cbmem_attributes",
> +	.attrs = cb_mem_attrs,
> +	.bin_attrs = cb_mem_bin_attrs,
> +};
> +
> +static const struct attribute_group *attribute_groups[] = {
> +	&cb_mem_attr_group,
> +	NULL,
> +};
> +
> +static int cbmem_probe(struct coreboot_device *cdev)
> +{
> +	struct device *dev = &cdev->dev;
> +	struct cb_priv *priv;
> +
> +	priv = devm_kmalloc(dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	memcpy(&priv->entry, &cdev->cbmem_entry, sizeof(priv->entry));

I don't think it is necessary to create a second copy of the table entry, when
it is already available at cdev->cbmem_entry. You could do:

	dev_set_drvdata(dev, cdev);

and that removes the need for struct cb_priv.

Otherwise,

Reviewed-by: Samuel Holland <samuel@sholland.org>
Tested-by: Samuel Holland <samuel@sholland.org>

I hacked nvramtool to pull the CMOS layout from
/sys/bus/coreboot/devices/coreboot0/attributes/data, and that seemed to work.

Cheers,
Samuel

> +
> +	dev_set_drvdata(dev, priv);
> +
> +	return 0;
> +}
> +
> +static struct coreboot_driver cbmem_driver = {
> +	.probe = cbmem_probe,
> +	.drv = {
> +		.name = "cbmem",
> +		.dev_groups = attribute_groups,
> +	},
> +	.tag = CB_TAG_CBMEM_ENTRY,
> +};
> +
> +module_coreboot_driver(cbmem_driver);
> +
> +MODULE_AUTHOR("9elements Agency GmbH");
> +MODULE_LICENSE("GPL");
> diff --git a/drivers/firmware/google/coreboot_table.h b/drivers/firmware/google/coreboot_table.h
> index 7b7b4a6eedda..fc20b8649882 100644
> --- a/drivers/firmware/google/coreboot_table.h
> +++ b/drivers/firmware/google/coreboot_table.h
> @@ -59,6 +59,19 @@ struct lb_framebuffer {
>  	u8  reserved_mask_size;
>  };
>  
> +/*
> + * There can be more than one of these records as there is one per cbmem entry.
> + * Describes a buffer in memory containing runtime data.
> + */
> +struct lb_cbmem_entry {
> +	u32 tag;
> +	u32 size;
> +
> +	u64 address;
> +	u32 entry_size;
> +	u32 id;
> +};
> +
>  /* A device, additionally with information from coreboot. */
>  struct coreboot_device {
>  	struct device dev;
> @@ -66,6 +79,7 @@ struct coreboot_device {
>  		struct coreboot_table_entry entry;
>  		struct lb_cbmem_ref cbmem_ref;
>  		struct lb_framebuffer framebuffer;
> +		struct lb_cbmem_entry cbmem_entry;
>  	};
>  };
>  
> 

