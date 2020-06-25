Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DA4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B871A206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 07:10:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bZ8LS7yT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390241AbgFYHKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 03:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389406AbgFYHKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 03:10:53 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC88BC061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:10:53 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ne5so2611712pjb.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 00:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=C3E5bCblfbs30r1XU315yBgD8126admDm8YrzZcdpZQ=;
        b=bZ8LS7yTnULtax1NcyW5j3SUSeKma0z8ZN0iy9LPxIkk4QD5z7HhLb/NCyjdh7UieJ
         8AWCtvJPFYGTwRx2aFo306oT2qqvXCB6SUgTM9cRKwq70o89CFn1jQUYci2E15raGFNW
         d8bOEPTlBJ9SXDOvMm6CleakfzGN3MOmarRrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=C3E5bCblfbs30r1XU315yBgD8126admDm8YrzZcdpZQ=;
        b=YyMJySALXIsUyEScihO4417Tp5Y07dFBFnjU+RK32BsqIHkrD/rcGcDS4YdeB5BkFu
         FroDqzFUGcvSlT9QX+NaVsz8QQcNTD+29g7rNKIM02v9EXr33DWOOisBZa/oYYBMV/9c
         c2URtZtWVRxPQ0MoKQGnaqeKjesrJFKsoNcZ3sF7Uty/sT2v3Qous2BmrJCoxOl0SYLD
         YYQv5gPio51XYKUQrbQHNq57zsuZk5OxEEcPK2dISbDrFTyO/l/67xTPAVc3UtkoLXqK
         hXBlt7aM493GncFiuU0LWd7VJBz6sXX6ugfELwBxWKR1+wCFWrxRY0675xWSUz29ZWhr
         z/Iw==
X-Gm-Message-State: AOAM532H6dKErXcqeiMY48j9Tp5G9GbTqcV4mnNxTHLqVZtZiw1uYJ7y
        CvA5KvVink8XW0Tof5OYtZmdYQ==
X-Google-Smtp-Source: ABdhPJzwyQvxKsyk9IGJV1XmQQF1BdEFXsofmM3QHECOOUTKPhvswo70lJXbsXM5gGSjxIh3tttv3g==
X-Received: by 2002:a17:90b:3105:: with SMTP id gc5mr1789808pjb.36.1593069053316;
        Thu, 25 Jun 2020 00:10:53 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id c141sm7254944pfc.167.2020.06.25.00.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2020 00:10:52 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200407082923.2001556-3-patrick.rudolph@9elements.com>
References: <20200407082923.2001556-1-patrick.rudolph@9elements.com> <20200407082923.2001556-3-patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 2/2] firmware: google: Expose coreboot tables over sysfs
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     coreboot@coreboot.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Julius Werner <jwerner@chromium.org>,
        Samuel Holland <samuel@sholland.org>
To:     linux-kernel@vger.kernel.org, patrick.rudolph@9elements.com
Date:   Thu, 25 Jun 2020 00:10:51 -0700
Message-ID: <159306905194.62212.10204515187655751787@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting patrick.rudolph@9elements.com (2020-04-07 01:29:07)
> From: Patrick Rudolph <patrick.rudolph@9elements.com>
>=20
> Make all coreboot table entries available to userland. This is useful for
> tools that are currently using /dev/mem.
>=20
> Besides the tag and size also expose the raw table data itself.
>=20
> Update the ABI documentation to explain the new sysfs interface.
>=20
> Tools can easily scan for the right coreboot table by reading
> /sys/bus/coreboot/devices/coreboot*/attributes/id
> The binary table data can then be read from
> /sys/bus/coreboot/devices/coreboot*/attributes/data
>=20
> Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

Minor nits below:

>  -v2:
>         - Add ABI documentation
>         - Add 0x prefix on hex values
>         - Remove wrong ioremap hint as found by CI
>  -v3:
>         - Use BIN_ATTR_RO
>  -v4:
>         - Updated ABI documentation
> ---
>  Documentation/ABI/stable/sysfs-bus-coreboot | 30 +++++++++++
>  drivers/firmware/google/coreboot_table.c    | 58 +++++++++++++++++++++
>  2 files changed, 88 insertions(+)
>=20
> diff --git a/Documentation/ABI/stable/sysfs-bus-coreboot b/Documentation/=
ABI/stable/sysfs-bus-coreboot
> index 6055906f41f2..328153a1b3f4 100644
> --- a/Documentation/ABI/stable/sysfs-bus-coreboot
> +++ b/Documentation/ABI/stable/sysfs-bus-coreboot
> diff --git a/drivers/firmware/google/coreboot_table.c b/drivers/firmware/=
google/coreboot_table.c
> index 0205987a4fd4..d0fc3eb93f4f 100644
> --- a/drivers/firmware/google/coreboot_table.c
> +++ b/drivers/firmware/google/coreboot_table.c
> @@ -3,9 +3,11 @@
>   * coreboot_table.c
>   *
>   * Module providing coreboot table access.
> + * Exports coreboot tables as attributes in sysfs.
>   *
>   * Copyright 2017 Google Inc.
>   * Copyright 2017 Samuel Holland <samuel@sholland.org>
> + * Copyright 2019 9elements Agency GmbH
>   */
> =20
>  #include <linux/acpi.h>
> @@ -84,6 +86,60 @@ void coreboot_driver_unregister(struct coreboot_driver=
 *driver)
>  }
>  EXPORT_SYMBOL(coreboot_driver_unregister);
> =20
> +static ssize_t id_show(struct device *dev,
> +                      struct device_attribute *attr, char *buffer)
> +{
> +       struct coreboot_device *device =3D CB_DEV(dev);

Wouldn't hurt to throw const in front of these.

> +
> +       return sprintf(buffer, "0x%08x\n", device->entry.tag);
> +}
> +
> +static ssize_t size_show(struct device *dev,
> +                        struct device_attribute *attr, char *buffer)
> +{
> +       struct coreboot_device *device =3D CB_DEV(dev);

And these. But the function is so short probably doesn't really matter.

> +
> +       return sprintf(buffer, "%u\n", device->entry.size);
> +}
> +
> +static DEVICE_ATTR_RO(id);
> +static DEVICE_ATTR_RO(size);
> +
> +static struct attribute *cb_dev_attrs[] =3D {
> +       &dev_attr_id.attr,
> +       &dev_attr_size.attr,
> +       NULL
> +};
> +
> +static ssize_t data_read(struct file *filp, struct kobject *kobj,
> +                        struct bin_attribute *bin_attr,
> +                        char *buffer, loff_t offset, size_t count)
> +{
> +       struct device *dev =3D kobj_to_dev(kobj);
> +       struct coreboot_device *device =3D CB_DEV(dev);
> +
> +       return memory_read_from_buffer(buffer, count, &offset,
> +                                      &device->entry, device->entry.size=
);
> +}
> +
> +static BIN_ATTR_RO(data, 0);

Still no way to figure out the actual size? Can we add the bin_attribute
at runtime?

> +
> +static struct bin_attribute *cb_dev_bin_attrs[] =3D {
> +       &bin_attr_data,
> +       NULL
> +};
> +
