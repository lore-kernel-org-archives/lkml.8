Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F510C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:16:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0A392075B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 10:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728871AbgH0KQA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 06:16:00 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42609 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727897AbgH0KPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 06:15:41 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MXY6b-1k7EjF27d1-00YwRu for <linux-kernel@vger.kernel.org>; Thu, 27 Aug
 2020 12:15:38 +0200
Received: by mail-qk1-f178.google.com with SMTP id u3so5321133qkd.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 03:15:38 -0700 (PDT)
X-Gm-Message-State: AOAM5313IQgaB9CrcH4STsbn76UssYC5BUhgnbfqugXfRxcVUBnmLSup
        zm0Y4uiJPvoM4vZdF56tCd47hO43KXwK1kbY99c=
X-Google-Smtp-Source: ABdhPJzdaSYhoLaNpQK/mfzoY+l0Nc76rW6do3te9j00/vi91iqdAFRcbliHdY9cMdBv3s+wlm8XaSkhKHmrxyeOuls=
X-Received: by 2002:a37:b942:: with SMTP id j63mr18167411qkf.138.1598523337360;
 Thu, 27 Aug 2020 03:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200820145117.8348-1-daniel.gutson@eclypsium.com>
In-Reply-To: <20200820145117.8348-1-daniel.gutson@eclypsium.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 27 Aug 2020 12:15:21 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3Z_mw4k+FZbGiz8Qg-YOHo7f=bWgpZ2gGZYqZuKo-8Hw@mail.gmail.com>
Message-ID: <CAK8P3a3Z_mw4k+FZbGiz8Qg-YOHo7f=bWgpZ2gGZYqZuKo-8Hw@mail.gmail.com>
Subject: Re: [PATCH] Platform lockdown information in sysfs (v2)
To:     Daniel Gutson <daniel.gutson@eclypsium.com>
Cc:     Derek Kiernan <derek.kiernan@xilinx.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Richard Hughes <hughsient@gmail.com>,
        Alex Bazhaniuk <alex@eclypsium.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:ODR9pjc7whQH0JW1v7iW0KyUXm7FDdIpDPSvsgCyDbIjsOaKhwQ
 kkvVNmfM7gp18lJKyKg10YQrIZvgB+/c3RZfzXlPuI8J2RWTqRGJanKYajgl+IApSXyQjiw
 kvviFBK94KTT3RFrfJfSuK7gqgMy3Dlt3d5POC66pUFaFPpmKBzgxKSo/Xr9SyxOyTA8N0T
 gTHqrjCIPCZoz5xZiZHOg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:C0mUOtjFBpk=:c0M059xJJNfBjPL+pnFdEP
 twXe31XRQhZRVCnkkj8RaFHjZU+fNrOdVXbNX57m6/7nV9c9JH09eyLMVAEQeOghx47XOua/H
 sWJ5EKrQg0/x0bMkBoe3CcK1C6LL1ndc6uU9AtAgHEcbbGXqj4zUYiiaHlkcFVMI7I9LwQphl
 7pXZzhVL/xtb8qWTaPmAJwcyYyOLiDBKyswJQg4VIpQ1tXhP7f5n5WBoYdztV+mq4emXbTqlR
 7t2ojHnp06VXuIARloS6us812ZJcGmFAdvC0zgsQAi7n5ihhEL1/c0+N2Iqn1iwBH1ds10SDI
 azYVtYz8beIlm5PzHBHGqy+Wob0iwj3xjnDkyO/snFSTTc5RtpKgqhktX9vfpkz3AhNeUtoYw
 4ID5BEDBbK3rs+IQ/uIOyVo9T41QtdXTa1gtd7dRpMCfmyVUpaX0cSd0JJgWlQfeUU+EBtEvP
 MjbephVJjmXb4MfsZV9Hj1rE/uqSqqaBweAvQHwLW+50gDe4wb1oI/WEaDMpfOVenuo72Q6Ip
 7EIgdDXiw1K9D7EzCrxdU+73mIYTI7rjpJbiV+5xmwpuo7LlFFC1ZItNxo1eIkW+25L7GJ7Kc
 ilYEuls4pFP7hUTSney3G2Fzap0pWvLQIqT9ljNGor2dHNSI1IG0rnqQ8N+tsfjgezL2plWMM
 Fcskacol84dB+tG62TZ66Qk/X4TDBHREiL7jHt9w+hH2B+l3vbkD/AcQckwkABt/4MZBYu5s2
 DjAC0s1Osjrh1OLJDwEbqDgQ9AQNaK1+5ji0yLAw5nmBwnfZmq94Szo/VJK1ZBe8DFxgajN8e
 8qtnrTQxjL1nNmlioIAKTNXIhU3kDNBcuBfzh+aa0dnSqIp5WxgclYZ6TCK1NNPfdgP7O41
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 4:51 PM Daniel Gutson
<daniel.gutson@eclypsium.com> wrote:
>
> This patch exports information about the platform lockdown
> firmware configuration in the sysfs filesystem.
> In this initial patch, I include some configuration attributes
> for the system SPI chip.
>
> This initial version exports the BIOS Write Enable (bioswe),
> BIOS Lock Enable (ble), and the SMM BIOS Write Protect (SMM_BWP)
> fields of the BIOS Control register. The idea is to keep adding more
> flags, not only from the BC but also from other registers in following
> versions.
>
> The goal is that the attributes are avilable to fwupd when SecureBoot
> is turned on.
>
> The patch provides a new misc driver, as proposed in the previous patch,
> that provides a registration function for HW Driver devices to register
> class_attributes.
> In this case, the intel SPI flash chip (intel-spi) registers three
> class_attributes corresponding to the fields mentioned above.
>
> This version of the patch replaces class attributes by device
> attributes.
>
> Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>

This looks much better than before, thanks for addressing the feedback.
> diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> new file mode 100644
> index 000000000000..3fe75d775a42
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> @@ -0,0 +1,23 @@
> +What:          /sys/class/platform-lockdown/bioswe

platform-lockdown is a much better name than the previous suggestions.
I'm still hoping for an even better suggestion. Like everything the term
"lockdown" is also overloaded a bit, with the other common meaning
referring to the effort to give root users less privilege than the
kernel itself,
see https://lwn.net/Articles/750730/

Shouldn't there be a device name between the class name
("platform-lockdown") and the attribute name?

> +PLATFORM LOCKDOWN ATTRIBUTES MODULE
> +M:     Daniel Gutson <daniel.gutson@eclypsium.com>
> +S:     Supported
> +F:     Documentation/ABI/sysfs-class-platform-lockdown
> +F:     drivers/misc/platform-lockdown-attrs.c
> +F:     include/linux/platform_data/platform-lockdown-attrs.h

include/linux/platform_data/ is not the right place for the header,
this is defined to be the place for defining properties of devices
that are created from old-style board files.

Just put the header into include/linux/ directly.
the host.
>
> +config PLATFORM_LOCKDOWN_ATTRS
> +       tristate "Platform lockdown information in the sysfs"
> +       depends on SYSFS
> +       help
> +         This kernel module is a helper driver to provide information about
> +         platform lockdown settings and configuration.
> +         This module is used by other device drivers -such as the intel-spi-
> +         to publish the information in /sys/class/platform-lockdown.

Maybe mention fwupd in the description in some form.

> +
> +static struct class platform_lockdown_class = {
> +       .name = "platform-lockdown",
> +       .owner = THIS_MODULE,
> +};
> +
> +struct device *register_platform_lockdown_data_device(struct device *parent,
> +                                                     const char *name)
> +{
> +       return device_create(&platform_lockdown_class, parent, MKDEV(0, 0),
> +                            NULL, name);
> +}
> +EXPORT_SYMBOL_GPL(register_platform_lockdown_data_device);
> +
> +void unregister_platform_lockdown_data_device(struct device *dev)
> +{
> +       device_unregister(dev);
> +}
> +EXPORT_SYMBOL_GPL(unregister_platform_lockdown_data_device);
> +
> +int register_platform_lockdown_attribute(struct device *dev,
> +                                        struct device_attribute *dev_attr)
> +{
> +       return device_create_file(dev, dev_attr);
> +}
> +EXPORT_SYMBOL_GPL(register_platform_lockdown_attribute);
> +
> +void register_platform_lockdown_attributes(struct device *dev,
> +                                          struct device_attribute dev_attrs[])
> +{
> +       u32 idx = 0;
> +
> +       while (dev_attrs[idx].attr.name != NULL) {
> +               register_platform_lockdown_attribute(dev, &dev_attrs[idx]);
> +               idx++;
> +       }

There is a bit of a race with creating the device first and then
the attributes. Generally it seems better to me to use
device_create_with_groups() instead so the device shows up
with all attributes in place already.

> +void register_platform_lockdown_custom_attributes(struct device *dev,
> +                                                 void *custom_attrs,
> +                                                 size_t dev_attr_offset,
> +                                                 size_t custom_attr_size)

This interface seems to be overly complex, I would hope it can be avoided.

> +static ssize_t cnl_spi_attr_show(struct device *dev,
> +       struct device_attribute *attr, char *buf)
> +{
> +       u32 bcr;
> +       struct cnl_spi_attr *cnl_spi_attr = container_of(attr,
> +               struct cnl_spi_attr, dev_attr);
> +
> +       if (class_child_device != dev)
> +               return -EIO;
> +
> +       if (dev->parent == NULL)
> +               return -EIO;
> +
> +       if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
> +                               BCR, &bcr) != PCIBIOS_SUCCESSFUL)
> +               return -EIO;
> +
> +       return sprintf(buf, "%d\n", (int)!!(bcr & cnl_spi_attr->mask));
> +}

If I understand it right, that complexity comes from attempting to
have a single show callback for three different flags. To me that
actually feels more complicated than having an attribute group
with three similar but simpler show callbacks.

>  static void intel_spi_pci_remove(struct pci_dev *pdev)
>  {
> +       if (class_child_device != NULL) {

Please avoid the global variable here and just add a member in the
per-device data.

> +               unregister_platform_lockdown_custom_attributes(
> +                       class_child_device,
> +                       cnl_spi_attrs,
> +                       offsetof(struct cnl_spi_attr, dev_attr),
> +                       sizeof(struct cnl_spi_attr));
> +
> +               unregister_platform_lockdown_data_device(class_child_device);

It should be possible to just destroy the attributes as part of
unregister_platform_lockdown_data_device.

       Arnd
