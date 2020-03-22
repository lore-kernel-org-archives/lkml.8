Return-Path: <SRS0=o5Nk=5H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68EEBC54EEB
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A27A2077D
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Mar 2020 11:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584875429;
	bh=iH2xpwbdk0la4ImkwS0diiu4fTYIIucmeHAgAm8qw5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zyiRSwgYpJvc0xqX3NJodRK02ylEZa+iDb6rfUXspI4J1knUnqip+lgyzmDD1W/F9
	 ZSrEPf1DddYPhVki33vgvcmhxhiJhc3dzx9/eRWro95+KtI5z7/eZ8QEvtoAjQU2ry
	 0puWmscLab1OCfIkAnc0eNJlvFxOjMebwIObwrO4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgCVLK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Mar 2020 07:10:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:52552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726866AbgCVLK2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Mar 2020 07:10:28 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 355E220753;
        Sun, 22 Mar 2020 11:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584875425;
        bh=iH2xpwbdk0la4ImkwS0diiu4fTYIIucmeHAgAm8qw5k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QyiYfLvszE7iCfPTahohxPlDecflGZpl5nj5yHJNjHrQ+GWXpSZk3pvC+EqSNSru/
         gnW8SK1idnSYcM178YtQa30H2/QGdizdWcMFcqsMUEXLXhEZSX4lE0LN96C2ThtjS0
         EhqKWZBzr5ZMgacLTmqokmfJyzI6V9cW/D7Xn7VM=
Date:   Sun, 22 Mar 2020 12:10:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     linux-kernel@vger.kernel.org, vbendeb@chromium.org,
        groeck@chromium.org, bleung@chromium.org, dtor@chromium.org,
        gwendal@chromium.org, andy@infradead.org,
        Collabora Kernel ML <kernel@collabora.com>,
        Ayman Bagabas <ayman.bagabas@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jeremy Soller <jeremy@system76.com>,
        Mattias Jacobsson <2pi@mok.nu>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rajat Jain <rajatja@google.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Yauhen Kharuzhy <jekhor@gmail.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2] platform: x86: Add ACPI driver for ChromeOS
Message-ID: <20200322111022.GA72939@kroah.com>
References: <20200322094334.1872663-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200322094334.1872663-1-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 22, 2020 at 10:43:34AM +0100, Enric Balletbo i Serra wrote:
> This driver attaches to the ChromeOS ACPI device and then exports the values
> reported by the ACPI in a sysfs directory. The ACPI values are presented in
> the string form (numbers as decimal values) or binary blobs, and can be
> accessed as the contents of the appropriate read only files in the sysfs
> directory tree originating in /sys/devices/platform/chromeos_acpi.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

What is wrong with the "default" ACPI sysfs access?  Why do you need a
special driver just for this specific ACPI firmware?

Also, you forgot to add Documentation/ABI/ entries for your new files :(

> +config ACPI_CHROMEOS
> +	tristate "ChromeOS specific ACPI extensions"
> +	depends on ACPI
> +	depends on CHROME_PLATFORMS

No BUILD_TEST?


> +static void
> +chromeos_acpi_remove_attribs(struct chromeos_acpi_attribute_group *aag)
> +{
> +	struct chromeos_acpi_attribute *attr, *tmp_attr;
> +
> +	list_for_each_entry_safe(attr, tmp_attr, &aag->attribs, list) {
> +		sysfs_remove_bin_file(aag->kobj, &attr->bin_attr);

Attribute groups are your friend, do not do this "by hand".

> +		kfree(attr->name);
> +		kfree(attr->data);
> +		kfree(attr);
> +	}
> +}
> +
> +/**
> + * chromeos_acpi_add_group() - Create a sysfs group including attributes
> + *			       representing a nested ACPI package.
> + *
> + * @obj: Package contents as returned by ACPI.
> + * @name: Name of the group.
> + * @num_attrs: Number of attributes of this package.
> + * @index: Index number of this particular group.
> + *
> + * The created group is called @name in case there is a single instance, or
> + * @name.@index otherwise.
> + *
> + * All group and attribute storage allocations are included in the lists for
> + * tracking of allocated memory.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int chromeos_acpi_add_group(union acpi_object *obj, char *name,
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

By using "raw" kobjects, you just now prevented any userspace tool from
seeing these attributes (like udev).  Not nice :(

Why, if you really really have to do this, are you not just using
"normal" struct device attributes instead?

> +static int __init chromeos_acpi_init(void)
> +{
> +	int ret;
> +
> +	chromeos_acpi.pdev = platform_device_register_simple("chromeos_acpi",
> +						PLATFORM_DEVID_NONE, NULL, 0);
> +	if (IS_ERR(chromeos_acpi.pdev)) {
> +		pr_err("unable to register chromeos_acpi platform device\n");
> +		return PTR_ERR(chromeos_acpi.pdev);
> +	}

Only use platform devices and drivers for things that are actually
platform devices and drivers.  That's not what this is, it is an ACPI
device and driver.  Don't abuse the platform interface please.

thanks,

greg k-h
