Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F15C41621
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:31:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 182512076F
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 16:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728152AbgCXQbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:31:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51726 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727693AbgCXQbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 12:31:17 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1E5862969FD
Subject: Re: [PATCH v2] platform: x86: Add ACPI driver for ChromeOS
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
References: <20200322094334.1872663-1-enric.balletbo@collabora.com>
 <20200322111022.GA72939@kroah.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c480f318-c326-d51c-e757-c65c2526ab4d@collabora.com>
Date:   Tue, 24 Mar 2020 17:31:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200322111022.GA72939@kroah.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Many thanks for your quick answer, some comments below.

On 22/3/20 12:10, Greg Kroah-Hartman wrote:
> On Sun, Mar 22, 2020 at 10:43:34AM +0100, Enric Balletbo i Serra wrote:
>> This driver attaches to the ChromeOS ACPI device and then exports the values
>> reported by the ACPI in a sysfs directory. The ACPI values are presented in
>> the string form (numbers as decimal values) or binary blobs, and can be
>> accessed as the contents of the appropriate read only files in the sysfs
>> directory tree originating in /sys/devices/platform/chromeos_acpi.
>>
>> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> 
> What is wrong with the "default" ACPI sysfs access?  Why do you need a
> special driver just for this specific ACPI firmware?
> 

Please correct me if I am wrong, as I'm not an ACPI expert and I probably have
some ACPI leaks and misunderstandings.

What is exporting this driver is the attributes for the non-default Chromebook
specific MLST ACPI method. Hence, I assumed we needed a special driver to expose
these values that can't be done using "default" ACPI sysfs. Note that these
attributes are dynamically created and are different between Chromebooks so need
some parsing.

I didn't find a "standard" way to expose these attributes to userspace, so,
please kindly point me to one if there is one.

> Also, you forgot to add Documentation/ABI/ entries for your new files :(
> 

Right, my bad. Not all Chromebooks have the same values. I can document the ones
that are created on the devices I have but I'll probably miss some of them. I'll
do some firmware research regarding this.


>> +config ACPI_CHROMEOS
>> +	tristate "ChromeOS specific ACPI extensions"
>> +	depends on ACPI
>> +	depends on CHROME_PLATFORMS
> 
> No BUILD_TEST?
> 

Will add in the next version.

> 
>> +static void
>> +chromeos_acpi_remove_attribs(struct chromeos_acpi_attribute_group *aag)
>> +{
>> +	struct chromeos_acpi_attribute *attr, *tmp_attr;
>> +
>> +	list_for_each_entry_safe(attr, tmp_attr, &aag->attribs, list) {
>> +		sysfs_remove_bin_file(aag->kobj, &attr->bin_attr);
> 
> Attribute groups are your friend, do not do this "by hand".
> 

I thought that the code is more readable doing it attribute by attribute, and
the reason is that apart from remove the bin file I should also free the name,
the data and the specific struct to store the attribute itself as all are
dynamically allocated.

Using attribute groups I should do two steps:

sysfs_remove_group()
list_for_each_entry_safe(attr, tmp_attr, &aag->attribs, list)  {
   kfree(attr->name);
   kfree(attr->data);
   kfree(attr);
}

Ok, will do that in next version.

>> +		kfree(attr->name);
>> +		kfree(attr->data);
>> +		kfree(attr);
>> +	}
>> +}
>> +
>> +/**
>> + * chromeos_acpi_add_group() - Create a sysfs group including attributes
>> + *			       representing a nested ACPI package.
>> + *
>> + * @obj: Package contents as returned by ACPI.
>> + * @name: Name of the group.
>> + * @num_attrs: Number of attributes of this package.
>> + * @index: Index number of this particular group.
>> + *
>> + * The created group is called @name in case there is a single instance, or
>> + * @name.@index otherwise.
>> + *
>> + * All group and attribute storage allocations are included in the lists for
>> + * tracking of allocated memory.
>> + *
>> + * Return: 0 on success, negative errno on failure.
>> + */
>> +static int chromeos_acpi_add_group(union acpi_object *obj, char *name,
>> +				   int num_attrs, int index)
>> +{
>> +	struct device *dev = &chromeos_acpi.pdev->dev;
>> +	struct chromeos_acpi_attribute_group *aag;
>> +	union acpi_object *element;
>> +	int i, count, ret;
>> +
>> +	aag = kzalloc(sizeof(*aag), GFP_KERNEL);
>> +	if (!aag)
>> +		return -ENOMEM;
>> +
>> +	aag->name = chromeos_acpi_alloc_name(name, num_attrs, index);
>> +	if (!aag->name) {
>> +		ret = -ENOMEM;
>> +		goto free_group;
>> +	}
>> +
>> +	aag->kobj = kobject_create_and_add(aag->name, &dev->kobj);
> 
> By using "raw" kobjects, you just now prevented any userspace tool from
> seeing these attributes (like udev).  Not nice :(
> 
> Why, if you really really have to do this, are you not just using
> "normal" struct device attributes instead?
> 

Ok.

>> +static int __init chromeos_acpi_init(void)
>> +{
>> +	int ret;
>> +
>> +	chromeos_acpi.pdev = platform_device_register_simple("chromeos_acpi",
>> +						PLATFORM_DEVID_NONE, NULL, 0);
>> +	if (IS_ERR(chromeos_acpi.pdev)) {
>> +		pr_err("unable to register chromeos_acpi platform device\n");
>> +		return PTR_ERR(chromeos_acpi.pdev);
>> +	}
> 
> Only use platform devices and drivers for things that are actually
> platform devices and drivers.  That's not what this is, it is an ACPI
> device and driver.  Don't abuse the platform interface please.
> 

Ok. The purpose was to not break ChromeOS userspace since is looking for the
attributes inside /sys/devices/platform/chromeos_acpi. Not a good reason, I
know, and I assume we will need to change userspace instead, and convert this to
a ACPI device and driver only, right?

I'll investigate the different places in userspace where this is used and see
how difficult it is to do the changes.

Thanks,

~Enric

> thanks,
> 
> greg k-h
> 
