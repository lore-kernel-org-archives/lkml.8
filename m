Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24511C4332B
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:21:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27FB2074D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 15:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgCVPVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 11:21:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:41111 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbgCVPVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 11:21:16 -0400
IronPort-SDR: qVP+vRUw8zx1fVRyZ7Y67P7QG+/aQGcHp9q7aU4mSNY5NOJK7tfR4aj8vNIsCIhvKO23GzcQR7
 M2b63njDsRAw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2020 08:21:13 -0700
IronPort-SDR: Rp62BvmZaIOxor7iKHDwzvK0wyupwSl8ybPNdFwmoTZ9a6Rgmwxd/4tY3R4gewrSKXqdefatSl
 CbeUIz+mUJ4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,293,1580803200"; 
   d="scan'208";a="237702038"
Received: from spandruv-mobl3.jf.intel.com ([10.254.114.98])
  by fmsmga007.fm.intel.com with ESMTP; 22 Mar 2020 08:21:11 -0700
Message-ID: <f29b78b579ae04cfedbe7a7aebaa7a1f4dcc3a68.camel@linux.intel.com>
Subject: Re: [PATCH v2] platform: x86: Add ACPI driver for ChromeOS
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     vbendeb@chromium.org, groeck@chromium.org, bleung@chromium.org,
        dtor@chromium.org, gwendal@chromium.org, andy@infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
Date:   Sun, 22 Mar 2020 08:21:11 -0700
In-Reply-To: <20200322094334.1872663-1-enric.balletbo@collabora.com>
References: <20200322094334.1872663-1-enric.balletbo@collabora.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-22 at 10:43 +0100, Enric Balletbo i Serra wrote:
> This driver attaches to the ChromeOS ACPI device and then exports the
> values
> reported by the ACPI in a sysfs directory. The ACPI values are
> presented in
> the string form (numbers as decimal values) or binary blobs, and can
> be
> accessed as the contents of the appropriate read only files in the
> sysfs
> directory tree originating in /sys/devices/platform/chromeos_acpi.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 

[...]

>  /sys/devices/platform/chromeos_acpi/BINF.2 : 1
Just wondering why don't you create additional attributes under ACPI
device itself, like in your case:
/sys/bus/acpi/devices/GGL0001/*

Additional attributes are added for ACPI device objects at such
location in other cases also for some PNP* and INT3* objects.

This will make your driver simple with one attr group.

Thanks,
Srinivas 


>  /sys/devices/platform/chromeos_acpi/FMAP : -2031616
>  /sys/devices/platform/chromeos_acpi/HWID : SAMUS E25-G7R-W35
>  /sys/devices/platform/chromeos_acpi/BINF.0 : 0
>  /sys/devices/platform/chromeos_acpi/GPIO.0/GPIO.2 : -1
>  /sys/devices/platform/chromeos_acpi/GPIO.0/GPIO.0 : 1
>  /sys/devices/platform/chromeos_acpi/GPIO.0/GPIO.3 : INT3437:00
>  /sys/devices/platform/chromeos_acpi/GPIO.0/GPIO.1 : 0
>  /sys/devices/platform/chromeos_acpi/FRID : Google_Samus.6300.102.0
>  /sys/devices/platform/chromeos_acpi/VBNV.0 : 38
>  /sys/devices/platform/chromeos_acpi/BINF.3 : 2
>  /sys/devices/platform/chromeos_acpi/BINF.1 : 1
>  /sys/devices/platform/chromeos_acpi/GPIO.1/GPIO.2 : 16
>  /sys/devices/platform/chromeos_acpi/GPIO.1/GPIO.0 : 3
>  /sys/devices/platform/chromeos_acpi/GPIO.1/GPIO.3 : INT3437:00
>  /sys/devices/platform/chromeos_acpi/GPIO.1/GPIO.1 : 1
>  /sys/devices/platform/chromeos_acpi/CHSW : 0
>  /sys/devices/platform/chromeos_acpi/FWID : Google_Samus.6300.330.0
>  /sys/devices/platform/chromeos_acpi/VBNV.1 : 16
>  /sys/devices/platform/chromeos_acpi/BINF.4 : 0
> 
> And for binary packages:
> 
> cat /sys/devices/platform/chromeos_acpi/MECK | hexdump
>  0000000 02fb 8e72 a025 0a73 0f13 095e 9e07 41e6
>  0000010 f9e6 bb4e 76cc bef9 cca7 70e2 8f6d 863d
>  0000020
> 
> cat /sys/devices/platform/chromeos_acpi/VDAT | hexdump
>  0000000 6256 4453 0002 0000 0448 0000 0000 0000
>  0000010 0c00 0000 0000 0000 0850 0000 0000 0000
>  0000020 7c54 0003 0000 0000 0420 0000 0000 0000
>  0000030 0408 0000 0000 0000 0007 0000 0000 0000
>  0000040 0003 0000 0000 0000 0448 0000 0000 0000
>  0000050 0408 0000 0000 0000 9335 1f80 0000 0000
>  0000060 69a8 21f3 0000 0000 1d02 21f9 0000 0000
>  0000070 ba55 371b 0000 0000 0000 0000 0000 0000
>  0000080 bcae 001d 0000 0000 0003 0001 0001 0003
>  0000090 000c 0000 0003 0001 0003 0001 0001 0000
>  00000a0 0001 0000 0000 0000 cc00 01da 0000 0000
>  00000b0 0200 0000 0204 0000 0001 0000 0000 0000
>  00000c0 0800 0000 0000 0000 0000 0001 0000 0000
>  00000d0 0001 0001 1301 0000 0000 0000 0000 0000
>  00000e0 0000 0000 0000 0000 0000 0000 0000 0000
>  *
> 
> Thanks,
>  Enric
> 
> [1] https://lkml.org/lkml/2017/7/31/378
> 
> Changes in v2:
> - Note that this version is a total rework, with those major changes:
>   - Use lists to track dinamically allocated attributes and groups.
>   - Use sysfs binary attributes to store the ACPI contents.
>   - Remove all the functionalities except the one that creates the
> sysfs files.
> 
>  drivers/platform/x86/Kconfig         |  12 +
>  drivers/platform/x86/Makefile        |   1 +
>  drivers/platform/x86/chromeos_acpi.c | 489
> +++++++++++++++++++++++++++
>  3 files changed, 502 insertions(+)
>  create mode 100644 drivers/platform/x86/chromeos_acpi.c
> 
> diff --git a/drivers/platform/x86/Kconfig
> b/drivers/platform/x86/Kconfig
> index 587403c44598..917a1c1a0758 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -72,6 +72,18 @@ config ACERHDF
>  	  If you have an Acer Aspire One netbook, say Y or M
>  	  here.
>  
> +config ACPI_CHROMEOS
> +	tristate "ChromeOS specific ACPI extensions"
> +	depends on ACPI
> +	depends on CHROME_PLATFORMS
> +	help
> +	  This driver provides the firmware interface for the services
> +	  exported through the ChromeOS interfaces when using ChromeOS
> +	  ACPI firmware.
> +
> +	  If you have an ACPI-compatible Chromebook, say Y or M
> +	  here.
> +
>  config ALIENWARE_WMI
>  	tristate "Alienware Special feature control"
>  	depends on ACPI
> diff --git a/drivers/platform/x86/Makefile
> b/drivers/platform/x86/Makefile
> index 3747b1f07cf1..222e2e88ccb8 100644
> --- a/drivers/platform/x86/Makefile
> +++ b/drivers/platform/x86/Makefile
> @@ -83,6 +83,7 @@ obj-$(CONFIG_SAMSUNG_Q10)	+= samsung-q10.o
>  obj-$(CONFIG_APPLE_GMUX)	+= apple-gmux.o
>  obj-$(CONFIG_INTEL_RST)		+= intel-rst.o
>  obj-$(CONFIG_INTEL_SMARTCONNECT)	+= intel-smartconnect.o
> +obj-$(CONFIG_ACPI_CHROMEOS)	+= chromeos_acpi.o
>  
>  obj-$(CONFIG_ALIENWARE_WMI)	+= alienware-wmi.o
>  obj-$(CONFIG_INTEL_PMC_IPC)	+= intel_pmc_ipc.o
> diff --git a/drivers/platform/x86/chromeos_acpi.c
> b/drivers/platform/x86/chromeos_acpi.c
> new file mode 100644
> index 000000000000..4d9addee2473
> --- /dev/null
> +++ b/drivers/platform/x86/chromeos_acpi.c
> @@ -0,0 +1,489 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * ChromeOS specific ACPI extensions
> + *
> + * Copyright 2011 Google, Inc.
> + * Copyright 2020 Google LLC
> + *
> + * This file is a rework and part of the code is ported from
> + * drivers/platform/x86/chromeos_acpi.c of the chromeos-3.18 kernel
> and
> + * was originally written by Vadim Bendebury <vbendeb@chromium.org>.
> + *
> + * This driver attaches to the ChromeOS ACPI device and then exports
> the
> + * values reported by the ACPI in a sysfs directory. All values are
> + * presented in the string form (numbers as decimal values) and can
> be
> + * accessed as the contents of the appropriate read only files in
> the
> + * sysfs directory tree originating in
> /sys/devices/platform/chromeos_acpi.
> + */
> +
> +#include <linux/acpi.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +
> +/*
> + * ACPI method name for MLST; the response for this method is a
> package of
> + * strings listing the methods which should be reflected in sysfs.
> + */
> +#define MLST "MLST"
> +
> +/*
> + * The default list of methods the ChromeOS ACPI device is supposed
> to export,
> + * if the MLST method is not present or is poorly formed.  The MLST
> method
> + * itself is included, to aid in debugging.
> + */
> +static char *chromeos_acpi_default_methods[] = {
> +	"CHSW", "HWID", "BINF", "GPIO", "CHNV", "FWID", "FRID", MLST
> +};
> +
> +/*
> + * Representation of a single sysfs attribute. In addition to the
> standard
> + * bin_attribute structure has a list of these structures (to keep
> track for
> + * de-allocation when removing the driver) and a pointer to the
> actual
> + * attribute name and value, reported when accessing the appropriate
> sysfs
> + * file.
> + */
> +struct chromeos_acpi_attribute {
> +	struct bin_attribute bin_attr;
> +	struct list_head list;
> +	char *name;
> +	char *data;
> +};
> +
> +/*
> + * Representation of a sysfs attribute group (a sub directory in the
> device's
> + * sysfs directory). In addition to the standard structure has lists
> to allow
> + * to keep track of the allocated structures.
> + */
> +struct chromeos_acpi_attribute_group {
> +	struct list_head attribs;
> +	struct list_head list;
> +	struct kobject *kobj;	/* chromeos_acpi/name directory */
> +	char *name;
> +};
> +
> +/*
> + * This is the main structure, we use it to store data and adds
> links pointing
> + * at lists of allocated attributes and attribute groups.
> + */
> +struct chromeos_acpi_dev {
> +	struct platform_device *pdev;
> +
> +	struct chromeos_acpi_attribute_group root;
> +	struct list_head groups;
> +};
> +
> +static struct chromeos_acpi_dev chromeos_acpi;
> +
> +static ssize_t chromeos_acpi_read_bin_attribute(struct file *filp,
> +						struct kobject *kobj,
> +						struct bin_attribute
> *bin_attr,
> +						char *buffer, loff_t
> pos,
> +						size_t count)
> +{
> +	struct chromeos_acpi_attribute *info = bin_attr->private;
> +
> +	return memory_read_from_buffer(buffer, count, &pos, info->data,
> +				       info->bin_attr.size);
> +}
> +
> +static char *chromeos_acpi_alloc_name(char *name, int count, int
> index)
> +{
> +	char *str;
> +
> +	if (count == 1)
> +		str = kstrdup(name, GFP_KERNEL);
> +	else
> +		str = kasprintf(GFP_KERNEL, "%s.%d", name, index);
> +
> +	return str;
> +}
> +
> +static int
> +chromeos_acpi_add_attr(struct chromeos_acpi_attribute_group *aag,
> +		       union acpi_object *element, char *name,
> +		       int count, int index)
> +{
> +	struct chromeos_acpi_attribute *info;
> +	char buffer[24]; /* enough to store a u64 and "\n\0" */
> +	int length;
> +	int ret;
> +
> +	info = kzalloc(sizeof(*info), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	info->name = chromeos_acpi_alloc_name(name, count, index);
> +	if (!info->name) {
> +		ret = -ENOMEM;
> +		goto free_attribute;
> +	}
> +
> +	sysfs_bin_attr_init(&info->bin_attr);
> +	info->bin_attr.attr.name = info->name;
> +	info->bin_attr.attr.mode = 0444;
> +
> +	switch (element->type) {
> +	case ACPI_TYPE_BUFFER:
> +		length = element->buffer.length;
> +		info->data = kmemdup(element->buffer.pointer,
> +				     length, GFP_KERNEL);
> +		break;
> +	case ACPI_TYPE_INTEGER:
> +		length = snprintf(buffer, sizeof(buffer), "%d",
> +				  (int)element->integer.value);
> +		info->data = kmemdup(buffer, length, GFP_KERNEL);
> +		break;
> +	case ACPI_TYPE_STRING:
> +		length = element->string.length + 1;
> +		info->data = kstrdup(element->string.pointer,
> GFP_KERNEL);
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		goto free_attr_name;
> +	}
> +
> +	if (!info->data) {
> +		ret = -ENOMEM;
> +		goto free_attr_name;
> +	}
> +
> +	info->bin_attr.size = length;
> +	info->bin_attr.read = chromeos_acpi_read_bin_attribute;
> +	info->bin_attr.private = info;
> +
> +	INIT_LIST_HEAD(&info->list);
> +
> +	ret = sysfs_create_bin_file(aag->kobj, &info->bin_attr);
> +	if (ret)
> +		goto free_attr_data;
> +
> +	list_add(&info->list, &aag->attribs);
> +
> +	return 0;
> +
> +free_attr_data:
> +	kfree(info->data);
> +free_attr_name:
> +	kfree(info->name);
> +free_attribute:
> +	kfree(info);
> +	return ret;
> +}
> +
> +static void
> +chromeos_acpi_remove_attribs(struct chromeos_acpi_attribute_group
> *aag)
> +{
> +	struct chromeos_acpi_attribute *attr, *tmp_attr;
> +
> +	list_for_each_entry_safe(attr, tmp_attr, &aag->attribs, list) {
> +		sysfs_remove_bin_file(aag->kobj, &attr->bin_attr);
> +		kfree(attr->name);
> +		kfree(attr->data);
> +		kfree(attr);
> +	}
> +}
> +
> +/**
> + * chromeos_acpi_add_group() - Create a sysfs group including
> attributes
> + *			       representing a nested ACPI package.
> + *
> + * @obj: Package contents as returned by ACPI.
> + * @name: Name of the group.
> + * @num_attrs: Number of attributes of this package.
> + * @index: Index number of this particular group.
> + *
> + * The created group is called @name in case there is a single
> instance, or
> + * @name.@index otherwise.
> + *
> + * All group and attribute storage allocations are included in the
> lists for
> + * tracking of allocated memory.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int chromeos_acpi_add_group(union acpi_object *obj, char
> *name,
> +				   int num_attrs, int index)
> +{
> +	struct device *dev = &chromeos_acpi.pdev->dev;
> +	struct chromeos_acpi_attribute_group *aag;
> +	union acpi_object *element;
> +	int i, count, ret;
> +
> +	aag = kzalloc(sizeof(*aag), GFP_KERNEL);
> +	if (!aag)
> +		return -ENOMEM;
> +
> +	aag->name = chromeos_acpi_alloc_name(name, num_attrs, index);
> +	if (!aag->name) {
> +		ret = -ENOMEM;
> +		goto free_group;
> +	}
> +
> +	aag->kobj = kobject_create_and_add(aag->name, &dev->kobj);
> +	if (!aag->kobj) {
> +		ret = -EINVAL;
> +		goto free_group_name;
> +	}
> +
> +	INIT_LIST_HEAD(&aag->attribs);
> +	INIT_LIST_HEAD(&aag->list);
> +
> +	count = obj->package.count;
> +	element = obj->package.elements;
> +	for (i = 0; i < count; i++, element++) {
> +		ret = chromeos_acpi_add_attr(aag, element, name, count,
> i);
> +		if (ret)
> +			goto free_group_attr;
> +	}
> +
> +	list_add(&aag->list, &chromeos_acpi.groups);
> +
> +	return 0;
> +
> +free_group_attr:
> +	chromeos_acpi_remove_attribs(aag);
> +	kobject_put(aag->kobj);
> +free_group_name:
> +	kfree(aag->name);
> +free_group:
> +	kfree(aag);
> +	return ret;
> +}
> +
> +static void chromeos_acpi_remove_groups(void)
> +{
> +	struct chromeos_acpi_attribute_group *aag, *tmp_aag;
> +
> +	list_for_each_entry_safe(aag, tmp_aag, &chromeos_acpi.groups,
> list) {
> +		chromeos_acpi_remove_attribs(aag);
> +		kfree(aag->name);
> +		kobject_put(aag->kobj);
> +		kfree(aag);
> +	}
> +}
> +
> +/**
> + * chromeos_acpi_handle_package() - Create sysfs group including
> attributes
> + *				    representing an ACPI package.
> + *
> + * @obj: Package contents as returned by ACPI.
> + * @name: Name of the group.
> + *
> + * Scalar objects included in the package get sysfs attributes
> created for
> + * them. Nested packages are passed to a function creating a sysfs
> group per
> + * package.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int chromeos_acpi_handle_package(union acpi_object *obj, char
> *name)
> +{
> +	struct device *dev = &chromeos_acpi.pdev->dev;
> +	int count = obj->package.count;
> +	union acpi_object *element;
> +	int i, ret = 0;
> +
> +	element = obj->package.elements;
> +	for (i = 0; i < count; i++, element++) {
> +		if (element->type == ACPI_TYPE_BUFFER ||
> +		    element->type == ACPI_TYPE_STRING ||
> +		    element->type == ACPI_TYPE_INTEGER)
> +			/* Create a single attribute in the root
> directory */
> +			ret =
> chromeos_acpi_add_attr(&chromeos_acpi.root,
> +						     element, name,
> +						     count, i);
> +		else if (element->type == ACPI_TYPE_PACKAGE)
> +			/* Create a group of attributes */
> +			ret = chromeos_acpi_add_group(element, name,
> +						      count, i);
> +		else
> +			ret = -EINVAL;
> +		if (ret)
> +			dev_err(dev,
> +				"failed to create group attributes
> (%d)\n",
> +				ret);
> +	}
> +
> +	return ret;
> +}
> +
> +/**
> + * chromeos_acpi_add_method() - Evaluate an ACPI method and create
> sysfs
> + *				attributes.
> + *
> + * @adev: ACPI device
> + * @name: Name of the method to evaluate
> + *
> + * Return: 0 on success, non-zero on failure
> + */
> +static int chromeos_acpi_add_method(struct acpi_device *adev, char
> *name)
> +{
> +	struct device *dev = &chromeos_acpi.pdev->dev;
> +	struct acpi_buffer output;
> +	union acpi_object *obj;
> +	acpi_status status;
> +	int ret = 0;
> +
> +	output.length = ACPI_ALLOCATE_BUFFER;
> +
> +	status = acpi_evaluate_object(adev->handle, name, NULL,
> &output);
> +	if (ACPI_FAILURE(status)) {
> +		dev_err(dev, "failed to retrieve %s (%d)\n", name,
> status);
> +		return status;
> +	}
> +
> +	obj = output.pointer;
> +	if (obj->type == ACPI_TYPE_PACKAGE)
> +		ret = chromeos_acpi_handle_package(obj, name);
> +
> +	kfree(output.pointer);
> +
> +	return ret;
> +}
> +
> +/**
> + * chromeos_acpi_process_mlst() - Evaluate the MLST method and add
> methods
> + *				  listed in the response.
> + *
> + * @adev: ACPI device
> + *
> + * Returns: 0 if successful, non-zero if error.
> + */
> +static int chromeos_acpi_process_mlst(struct acpi_device *adev)
> +{
> +	char name[ACPI_NAMESEG_SIZE + 1];
> +	union acpi_object *element, *obj;
> +	struct acpi_buffer output;
> +	acpi_status status;
> +	int ret = 0;
> +	int size;
> +	int i;
> +
> +	output.length = ACPI_ALLOCATE_BUFFER;
> +	status = acpi_evaluate_object(adev->handle, MLST, NULL,
> +				      &output);
> +	if (ACPI_FAILURE(status))
> +		return status;
> +
> +	obj = output.pointer;
> +	if (obj->type != ACPI_TYPE_PACKAGE) {
> +		ret = -EINVAL;
> +		goto free_acpi_buffer;
> +	}
> +
> +	element = obj->package.elements;
> +	for (i = 0; i < obj->package.count; i++, element++) {
> +		if (element->type == ACPI_TYPE_STRING) {
> +			size = min(element->string.length + 1,
> +				   (u32)ACPI_NAMESEG_SIZE + 1);
> +			strlcpy(name, element->string.pointer, size);
> +			ret = chromeos_acpi_add_method(adev, name);
> +			if (ret) {
> +				chromeos_acpi_remove_groups();
> +				break;
> +			}
> +		}
> +	}
> +
> +free_acpi_buffer:
> +	kfree(output.pointer);
> +
> +	return ret;
> +}
> +
> +static int chromeos_acpi_device_add(struct acpi_device *adev)
> +{
> +	struct chromeos_acpi_attribute_group *aag =
> &chromeos_acpi.root;
> +	struct device *dev = &chromeos_acpi.pdev->dev;
> +	int i, ret;
> +
> +	INIT_LIST_HEAD(&aag->attribs);
> +	INIT_LIST_HEAD(&aag->list);
> +
> +	aag->kobj = &dev->kobj;
> +
> +	/*
> +	 * Attempt to add methods by querying the device's MLST method
> +	 * for the list of methods.
> +	 */
> +	if (!chromeos_acpi_process_mlst(adev))
> +		return 0;
> +
> +	dev_info(dev, "falling back to default list of methods\n");
> +
> +	for (i = 0; i < ARRAY_SIZE(chromeos_acpi_default_methods); i++)
> {
> +		ret = chromeos_acpi_add_method(adev,
> +					     chromeos_acpi_default_meth
> ods[i]);
> +		if (ret) {
> +			dev_err(dev, "failed to add default methods
> (%d)\n",
> +				ret);
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int chromeos_acpi_device_remove(struct acpi_device *adev)
> +{
> +	/* Remove dinamically allocated sysfs groups and attributes */
> +	chromeos_acpi_remove_groups();
> +	/* Remove attributes from the root group */
> +	chromeos_acpi_remove_attribs(&chromeos_acpi.root);
> +
> +	return 0;
> +}
> +
> +static const struct acpi_device_id chromeos_device_ids[] = {
> +	{ "GGL0001", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(acpi, chromeos_device_ids);
> +
> +static struct acpi_driver chromeos_acpi_driver = {
> +	.name = "ChromeOS ACPI driver",
> +	.class = "chromeos-acpi",
> +	.ids = chromeos_device_ids,
> +	.ops = {
> +		.add = chromeos_acpi_device_add,
> +		.remove = chromeos_acpi_device_remove,
> +	},
> +	.owner = THIS_MODULE,
> +};
> +
> +static int __init chromeos_acpi_init(void)
> +{
> +	int ret;
> +
> +	chromeos_acpi.pdev =
> platform_device_register_simple("chromeos_acpi",
> +						PLATFORM_DEVID_NONE,
> NULL, 0);
> +	if (IS_ERR(chromeos_acpi.pdev)) {
> +		pr_err("unable to register chromeos_acpi platform
> device\n");
> +		return PTR_ERR(chromeos_acpi.pdev);
> +	}
> +
> +	INIT_LIST_HEAD(&chromeos_acpi.groups);
> +
> +	ret = acpi_bus_register_driver(&chromeos_acpi_driver);
> +	if (ret < 0) {
> +		pr_err("failed to register chromeos_acpi driver
> (%d)\n", ret);
> +		platform_device_unregister(chromeos_acpi.pdev);
> +		chromeos_acpi.pdev = NULL;
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit chromeos_acpi_exit(void)
> +{
> +	acpi_bus_unregister_driver(&chromeos_acpi_driver);
> +	platform_device_unregister(chromeos_acpi.pdev);
> +}
> +
> +module_init(chromeos_acpi_init);
> +module_exit(chromeos_acpi_exit);
> +
> +MODULE_AUTHOR("Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ");
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("ChromeOS specific ACPI extensions");

