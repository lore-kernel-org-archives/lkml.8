Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16612C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF4862177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:05:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eclypsium.com header.i=@eclypsium.com header.b="XW0csSKc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbgH0PFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727940AbgH0PEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:04:39 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB6F4C061233
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:04:38 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d27so4743035qtg.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 08:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qMGmC0JqGhgnSsAE+tyJqcCe+jJ8ExSl/fNNYQ+aD2Q=;
        b=XW0csSKc4tYY0U7nBo00AjWWMhpxLvOFsKwp7w7NmLNFCj8ThnP4y/HV0TycZhAgcM
         OV7+coGiDAc5h84bOWo/BffRbcn3NNOvTlFi+0uWVXKPQflc9ToKnFj8OeU8+EfhSaih
         6crZWbOEmPVzMtEKAc0ZepeeRNObZfGcBDIXUrnupRMuvPz+Q2qZ5pyICTeK4cVIn44m
         P32Hhhn7bHFFrClTDK++vjIWUlP40W/QGg3LxqvU+PltOX6DHmDyzT4EtXs1p3lthnI9
         G47hNHB9pivg2UPNuWmH/vrz5d/Il6u9jef42fXuOYeb9SIbQGWD6Spjgni/ZElZQC+C
         Pc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qMGmC0JqGhgnSsAE+tyJqcCe+jJ8ExSl/fNNYQ+aD2Q=;
        b=OGqSVrmOBdkQ9EXfVZJG847prh7CbRPbYJqdjpRTgXDG+FSYWKWuRb7ngPPEAgQI+8
         VcklwxjoH3AJ8JdD4fPCwEn+V5pjDttX9GvSzGEwIN4ilYswEMxCyaj94HFIRfQ2Nst7
         Suak7iUlBqyDi/+utgLjssd/s6c4HhliogKjSBebRwM2gSB1181q9E0+IyQXgmBXj5mJ
         3iU66x/qM91eXypbipzoF2YelIzHeTbfpROnaz4OIEgOpzBLZn8EKLhyYCTFvJr3bF/4
         KzVyV0FR/vzxAJ1HCeAMluPkQdER3qp2PB0MSdmvMrcbpf7mxnzCHfMLqWmCGAKxNBvq
         XhFA==
X-Gm-Message-State: AOAM530JFdJjHeWbr1ORRi5oGEbEAXjjsNOBzPJSswzECl3+So/sIoV1
        VeoKdBghqMp0C2UKoCVB8w2LigPjckyiiEGC2nKTpg==
X-Google-Smtp-Source: ABdhPJwgrd22oYrACZCPTpcTsOrg7YAw9Qs+eq51rqZ/cL9ztiHy+hFROQrlYbSMSX+wMrzNEx5It8NQLQTTjy40a64=
X-Received: by 2002:ac8:1bb3:: with SMTP id z48mr6033161qtj.203.1598540677708;
 Thu, 27 Aug 2020 08:04:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200820145117.8348-1-daniel.gutson@eclypsium.com> <CAK8P3a3Z_mw4k+FZbGiz8Qg-YOHo7f=bWgpZ2gGZYqZuKo-8Hw@mail.gmail.com>
In-Reply-To: <CAK8P3a3Z_mw4k+FZbGiz8Qg-YOHo7f=bWgpZ2gGZYqZuKo-8Hw@mail.gmail.com>
From:   Daniel Gutson <daniel@eclypsium.com>
Date:   Thu, 27 Aug 2020 12:04:26 -0300
Message-ID: <CAFmMkTHWBpJNMHAP_hKFdRZDOYs-ESU453Ldy78s0u-E1SJPag@mail.gmail.com>
Subject: Re: [PATCH] Platform lockdown information in sysfs (v2)
To:     Arnd Bergmann <arnd@arndb.de>
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 7:15 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Aug 20, 2020 at 4:51 PM Daniel Gutson
> <daniel.gutson@eclypsium.com> wrote:
> >
> > This patch exports information about the platform lockdown
> > firmware configuration in the sysfs filesystem.
> > In this initial patch, I include some configuration attributes
> > for the system SPI chip.
> >
> > This initial version exports the BIOS Write Enable (bioswe),
> > BIOS Lock Enable (ble), and the SMM BIOS Write Protect (SMM_BWP)
> > fields of the BIOS Control register. The idea is to keep adding more
> > flags, not only from the BC but also from other registers in following
> > versions.
> >
> > The goal is that the attributes are avilable to fwupd when SecureBoot
> > is turned on.
> >
> > The patch provides a new misc driver, as proposed in the previous patch,
> > that provides a registration function for HW Driver devices to register
> > class_attributes.
> > In this case, the intel SPI flash chip (intel-spi) registers three
> > class_attributes corresponding to the fields mentioned above.
> >
> > This version of the patch replaces class attributes by device
> > attributes.
> >
> > Signed-off-by: Daniel Gutson <daniel.gutson@eclypsium.com>
>
> This looks much better than before, thanks for addressing the feedback.
Thanks for providing it.


> > diff --git a/Documentation/ABI/stable/sysfs-class-platform-lockdown b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> > new file mode 100644
> > index 000000000000..3fe75d775a42
> > --- /dev/null
> > +++ b/Documentation/ABI/stable/sysfs-class-platform-lockdown
> > @@ -0,0 +1,23 @@
> > +What:          /sys/class/platform-lockdown/bioswe
>
> platform-lockdown is a much better name than the previous suggestions.
> I'm still hoping for an even better suggestion. Like everything the term
> "lockdown" is also overloaded a bit, with the other common meaning
> referring to the effort to give root users less privilege than the
> kernel itself,
> see https://lwn.net/Articles/750730/

I'd want to set the name for good before I proceed with the rest.
A list of suggestions:
platform-firmware
platform-defence
firmware-surety
firmware-control
platform-inspection
platform-lookout
platform-diligence
platform-integrity

I like the last want, what do you think? Any other suggestion?

Thanks again!

    Daniel.
>
> Shouldn't there be a device name between the class name
> ("platform-lockdown") and the attribute name?
>
> > +PLATFORM LOCKDOWN ATTRIBUTES MODULE
> > +M:     Daniel Gutson <daniel.gutson@eclypsium.com>
> > +S:     Supported
> > +F:     Documentation/ABI/sysfs-class-platform-lockdown
> > +F:     drivers/misc/platform-lockdown-attrs.c
> > +F:     include/linux/platform_data/platform-lockdown-attrs.h
>
> include/linux/platform_data/ is not the right place for the header,
> this is defined to be the place for defining properties of devices
> that are created from old-style board files.
>
> Just put the header into include/linux/ directly.
> the host.
> >
> > +config PLATFORM_LOCKDOWN_ATTRS
> > +       tristate "Platform lockdown information in the sysfs"
> > +       depends on SYSFS
> > +       help
> > +         This kernel module is a helper driver to provide information about
> > +         platform lockdown settings and configuration.
> > +         This module is used by other device drivers -such as the intel-spi-
> > +         to publish the information in /sys/class/platform-lockdown.
>
> Maybe mention fwupd in the description in some form.
>
> > +
> > +static struct class platform_lockdown_class = {
> > +       .name = "platform-lockdown",
> > +       .owner = THIS_MODULE,
> > +};
> > +
> > +struct device *register_platform_lockdown_data_device(struct device *parent,
> > +                                                     const char *name)
> > +{
> > +       return device_create(&platform_lockdown_class, parent, MKDEV(0, 0),
> > +                            NULL, name);
> > +}
> > +EXPORT_SYMBOL_GPL(register_platform_lockdown_data_device);
> > +
> > +void unregister_platform_lockdown_data_device(struct device *dev)
> > +{
> > +       device_unregister(dev);
> > +}
> > +EXPORT_SYMBOL_GPL(unregister_platform_lockdown_data_device);
> > +
> > +int register_platform_lockdown_attribute(struct device *dev,
> > +                                        struct device_attribute *dev_attr)
> > +{
> > +       return device_create_file(dev, dev_attr);
> > +}
> > +EXPORT_SYMBOL_GPL(register_platform_lockdown_attribute);
> > +
> > +void register_platform_lockdown_attributes(struct device *dev,
> > +                                          struct device_attribute dev_attrs[])
> > +{
> > +       u32 idx = 0;
> > +
> > +       while (dev_attrs[idx].attr.name != NULL) {
> > +               register_platform_lockdown_attribute(dev, &dev_attrs[idx]);
> > +               idx++;
> > +       }
>
> There is a bit of a race with creating the device first and then
> the attributes. Generally it seems better to me to use
> device_create_with_groups() instead so the device shows up
> with all attributes in place already.
>
> > +void register_platform_lockdown_custom_attributes(struct device *dev,
> > +                                                 void *custom_attrs,
> > +                                                 size_t dev_attr_offset,
> > +                                                 size_t custom_attr_size)
>
> This interface seems to be overly complex, I would hope it can be avoided.
>
> > +static ssize_t cnl_spi_attr_show(struct device *dev,
> > +       struct device_attribute *attr, char *buf)
> > +{
> > +       u32 bcr;
> > +       struct cnl_spi_attr *cnl_spi_attr = container_of(attr,
> > +               struct cnl_spi_attr, dev_attr);
> > +
> > +       if (class_child_device != dev)
> > +               return -EIO;
> > +
> > +       if (dev->parent == NULL)
> > +               return -EIO;
> > +
> > +       if (pci_read_config_dword(container_of(dev->parent, struct pci_dev, dev),
> > +                               BCR, &bcr) != PCIBIOS_SUCCESSFUL)
> > +               return -EIO;
> > +
> > +       return sprintf(buf, "%d\n", (int)!!(bcr & cnl_spi_attr->mask));
> > +}
>
> If I understand it right, that complexity comes from attempting to
> have a single show callback for three different flags. To me that
> actually feels more complicated than having an attribute group
> with three similar but simpler show callbacks.
>
> >  static void intel_spi_pci_remove(struct pci_dev *pdev)
> >  {
> > +       if (class_child_device != NULL) {
>
> Please avoid the global variable here and just add a member in the
> per-device data.
>
> > +               unregister_platform_lockdown_custom_attributes(
> > +                       class_child_device,
> > +                       cnl_spi_attrs,
> > +                       offsetof(struct cnl_spi_attr, dev_attr),
> > +                       sizeof(struct cnl_spi_attr));
> > +
> > +               unregister_platform_lockdown_data_device(class_child_device);
>
> It should be possible to just destroy the attributes as part of
> unregister_platform_lockdown_data_device.
>
>        Arnd



-- 
Daniel Gutson
Argentina Site Director
Enginieering Director
Eclypsium

Below The Surface: Get the latest threat research and insights on
firmware and supply chain threats from the research team at Eclypsium.
https://eclypsium.com/research/#threatreport
