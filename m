Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53B13C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 159FA21734
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 13:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580478142;
	bh=DCR+0TCQvaLxVbLgiAiMiZCq07yRiBpwTs50WCNYNdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:List-ID:From;
	b=emPO3KglpYCSb8WBrf3gWPX1iC4ilp40ph3hz3wUEHScguulCHsLJMHKdJ/bieAdx
	 v/2zMxQU+0Kl47FiWbN5r0AyvppKMn5+LGihokstbwWaLRvU2/bg3f6awZYVXZhKKK
	 2LFoLq5W9Ra24SDaF0jKU+ac6Pr+hZUxEBOlQBYY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728955AbgAaNmV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 08:42:21 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:34331 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAaNmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 08:42:20 -0500
Received: by mail-lf1-f67.google.com with SMTP id l18so4928288lfc.1;
        Fri, 31 Jan 2020 05:42:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=swGoaLp5XkgEaKdTKVoVCKg9Mf+SjLQNMQC+hY/qEZo=;
        b=Vc0YH9OQYAl97Ap8EEnIti1iXFnxaFmvefFQypMvepURp9pbp+N1cfv/0rTNMdu/PZ
         3L6hSZ/VIF78tVjPdauzcUe/Ghgwi5QJEN9xdiCYRLYCWe2TO3XRSEPh4OpYGxGHBfrU
         f3fwYWfgkk2QFstesx0TOLhFUSYtQIznNKc6ApsWlGnitSfL6Q31ZIgJfDZNpOIuyu+R
         7f8pf9U10X6UDY4sSvOXyGw+f3rBU0gWlRIwKhqvWklsWZU2FAa4mpx7vrGTx0Yvo8bu
         xpw4R5sZVvvbZA2CEUfQ54RijluvBI+WnhRTk5Rp9zDyys9Y9qsVMWzYFDmunWsS+ZNU
         PG8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :date:message-id:mime-version;
        bh=swGoaLp5XkgEaKdTKVoVCKg9Mf+SjLQNMQC+hY/qEZo=;
        b=PjR5DumLqZNDscGvAK2N52phxBX/995JmvaWgtM0r9oO49G+V41btMnIcV06l14xPQ
         T1vQm8wQcKwP1cr75kxdTgkSm32e7XcKukhM226ZKuPUJnxw1w6ofTComB+2xCWkXRSW
         2o80s3uNcKUaSpUqGutfEWEoVqXFJfP30ZqU9jNAAx4awIxT/2W33xHIIxLauCQbWal4
         hYUVCl78gIjExp3qG4D0B+aJ+CG9+usMBaI7sKPkZpWM1t4gLtwKxzCITep3dTWBRQVZ
         jcqd2Xgtkp5aOF+09XTx1AzUxNoSspcUPigVWj/r+InB9wFghieV8aSMdbkPfpHqplvy
         1ekQ==
X-Gm-Message-State: APjAAAXNqRutesqfmhNab0aOIXzbt8jbvGwqDSRngFlTPCiKWPcTH6A1
        ik8OCLIoS5PjvDgpSw/IGAM=
X-Google-Smtp-Source: APXvYqzqhbZP8wEuN8VueWWDtIUfAYhpjnujwwxIA0lHj/ZJdjnEu1L9fR/W7mGXMwZ2FZcCPhHokA==
X-Received: by 2002:ac2:4909:: with SMTP id n9mr5462365lfi.21.1580478136030;
        Fri, 31 Jan 2020 05:42:16 -0800 (PST)
Received: from saruman (88-113-215-33.elisa-laajakaista.fi. [88.113.215.33])
        by smtp.gmail.com with ESMTPSA id r26sm4599627lfm.82.2020.01.31.05.42.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Jan 2020 05:42:15 -0800 (PST)
From:   Felipe Balbi <balbi@kernel.org>
To:     Andrey Konovalov <andreyknvl@google.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
In-Reply-To: <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
Date:   Fri, 31 Jan 2020 15:42:11 +0200
Message-ID: <87ftfv7nf0.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Hi,

Andrey Konovalov <andreyknvl@google.com> writes:
> USB Raw Gadget is a kernel module that provides a userspace interface for
> the USB Gadget subsystem. Essentially it allows to emulate USB devices
> from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> currently a strictly debugging feature and shouldn't be used in
> production.
>
> Raw Gadget is similar to GadgetFS, but provides a more low-level and
> direct access to the USB Gadget layer for the userspace. The key
> differences are:
>
> 1. Every USB request is passed to the userspace to get a response, while
>    GadgetFS responds to some USB requests internally based on the provided
>    descriptors. However note, that the UDC driver might respond to some
>    requests on its own and never forward them to the Gadget layer.
>
> 2. GadgetFS performs some sanity checks on the provided USB descriptors,
>    while Raw Gadget allows you to provide arbitrary data as responses to
>    USB requests.
>
> 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
>    while GadgetFS currently binds to the first available UDC.
>
> 4. Raw Gadget uses predictable endpoint names (handles) across different
>    UDCs (as long as UDCs have enough endpoints of each required transfer
>    type).
>
> 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>
> Greg, I've assumed your LGTM meant that I can add a Reviewed-by from you.
>
> Felipe, looking forward to your review, thanks!
>
>  Documentation/usb/index.rst            |    1 +
>  Documentation/usb/raw-gadget.rst       |   59 ++
>  drivers/usb/gadget/legacy/Kconfig      |   11 +
>  drivers/usb/gadget/legacy/Makefile     |    1 +
>  drivers/usb/gadget/legacy/raw_gadget.c | 1068 ++++++++++++++++++++++++
>  include/uapi/linux/usb/raw_gadget.h    |  167 ++++
>  6 files changed, 1307 insertions(+)
>  create mode 100644 Documentation/usb/raw-gadget.rst
>  create mode 100644 drivers/usb/gadget/legacy/raw_gadget.c
>  create mode 100644 include/uapi/linux/usb/raw_gadget.h
>
> diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
> index e55386a4abfb..90310e2a0c1f 100644
> --- a/Documentation/usb/index.rst
> +++ b/Documentation/usb/index.rst
> @@ -22,6 +22,7 @@ USB support
>      misc_usbsevseg
>      mtouchusb
>      ohci
> +    raw-gadget
>      rio
>      usbip_protocol
>      usbmon
> diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gad=
get.rst
> new file mode 100644
> index 000000000000..cbedf5451ed3
> --- /dev/null
> +++ b/Documentation/usb/raw-gadget.rst
> @@ -0,0 +1,59 @@
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +USB Raw Gadget
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +USB Raw Gadget is a kernel module that provides a userspace interface for
> +the USB Gadget subsystem. Essentially it allows to emulate USB devices
> +from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> +currently a strictly debugging feature and shouldn't be used in
> +production, use GadgetFS instead.
> +
> +Comparison to GadgetFS
> +~~~~~~~~~~~~~~~~~~~~~~
> +
> +Raw Gadget is similar to GadgetFS, but provides a more low-level and
> +direct access to the USB Gadget layer for the userspace. The key
> +differences are:
> +
> +1. Every USB request is passed to the userspace to get a response, while
> +   GadgetFS responds to some USB requests internally based on the provid=
ed
> +   descriptors. However note, that the UDC driver might respond to some
> +   requests on its own and never forward them to the Gadget layer.
> +
> +2. GadgetFS performs some sanity checks on the provided USB descriptors,
> +   while Raw Gadget allows you to provide arbitrary data as responses to
> +   USB requests.
> +
> +3. Raw Gadget provides a way to select a UDC device/driver to bind to,
> +   while GadgetFS currently binds to the first available UDC.
> +
> +4. Raw Gadget uses predictable endpoint names (handles) across different
> +   UDCs (as long as UDCs have enough endpoints of each required transfer
> +   type).
> +
> +5. Raw Gadget has ioctl-based interface instead of a filesystem-based on=
e.
> +
> +Userspace interface
> +~~~~~~~~~~~~~~~~~~~
> +
> +To create a Raw Gadget instance open /dev/raw-gadget. Multiple raw-gadget
> +instances (bound to different UDCs) can be used at the same time. The
> +interaction with the opened file happens through the ioctl() calls, see
> +comments in include/uapi/linux/usb/raw_gadget.h for details.
> +
> +The typical usage of Raw Gadget looks like:
> +
> +1. Open Raw Gadget instance via /dev/raw-gadget.
> +2. Initialize the instance via USB_RAW_IOCTL_INIT.
> +3. Launch the instance with USB_RAW_IOCTL_RUN.
> +4. In a loop issue USB_RAW_IOCTL_EVENT_FETCH calls to receive events from
> +   Raw Gadget and react to those depending on what kind of USB device
> +   needs to be emulated.
> +
> +Potential future improvements
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +- Implement ioctl's for setting/clearing halt status on endpoints.
> +
> +- Reporting more events (suspend, resume, etc.) through
> +  USB_RAW_IOCTL_EVENT_FETCH.
> diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legac=
y/Kconfig
> index 119a4e47681f..55e495f5d103 100644
> --- a/drivers/usb/gadget/legacy/Kconfig
> +++ b/drivers/usb/gadget/legacy/Kconfig
> @@ -489,3 +489,14 @@ config USB_G_WEBCAM
>=20=20
>  	  Say "y" to link the driver statically, or "m" to build a
>  	  dynamically linked module called "g_webcam".
> +
> +config USB_RAW_GADGET
> +	tristate "USB Raw Gadget"
> +	help
> +	  USB Raw Gadget is a kernel module that provides a userspace interface
> +	  for the USB Gadget subsystem. Essentially it allows to emulate USB
> +	  devices from userspace. See Documentation/usb/raw-gadget.rst for
> +	  details.
> +
> +	  Say "y" to link the driver statically, or "m" to build a
> +	  dynamically linked module called "raw_gadget".
> diff --git a/drivers/usb/gadget/legacy/Makefile b/drivers/usb/gadget/lega=
cy/Makefile
> index abd0c3e66a05..4d864bf82799 100644
> --- a/drivers/usb/gadget/legacy/Makefile
> +++ b/drivers/usb/gadget/legacy/Makefile
> @@ -43,3 +43,4 @@ obj-$(CONFIG_USB_G_WEBCAM)	+=3D g_webcam.o
>  obj-$(CONFIG_USB_G_NCM)		+=3D g_ncm.o
>  obj-$(CONFIG_USB_G_ACM_MS)	+=3D g_acm_ms.o
>  obj-$(CONFIG_USB_GADGET_TARGET)	+=3D tcm_usb_gadget.o
> +obj-$(CONFIG_USB_RAW_GADGET)	+=3D raw_gadget.o
> diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/=
legacy/raw_gadget.c
> new file mode 100644
> index 000000000000..51796af48069
> --- /dev/null
> +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> @@ -0,0 +1,1068 @@
> +// SPDX-License-Identifier: GPL-2.0

V2 only

> +/*
> + * USB Raw Gadget driver.
> + * See Documentation/usb/raw-gadget.rst for more details.
> + *
> + * Andrey Konovalov <andreyknvl@gmail.com>
> + */
> +
> +#include <linux/compiler.h>
> +#include <linux/debugfs.h>
> +#include <linux/delay.h>
> +#include <linux/kref.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/semaphore.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/uaccess.h>
> +#include <linux/wait.h>
> +
> +#include <linux/usb.h>
> +#include <linux/usb/ch9.h>
> +#include <linux/usb/ch11.h>
> +#include <linux/usb/gadget.h>
> +
> +#include <uapi/linux/usb/raw_gadget.h>
> +
> +#define	DRIVER_DESC "USB Raw Gadget"
> +#define DRIVER_NAME "raw-gadget"
> +
> +MODULE_DESCRIPTION(DRIVER_DESC);
> +MODULE_AUTHOR("Andrey Konovalov");
> +MODULE_LICENSE("GPL");

v2+. Care to fix?

> +
> +/*----------------------------------------------------------------------=
*/
> +
> +#define RAW_EVENT_QUEUE_SIZE	128
> +
> +struct raw_event_queue {
> +	/* See the comment in raw_event_queue_fetch() for locking details. */
> +	spinlock_t		lock;
> +	struct semaphore	sema;
> +	struct usb_raw_event	*events[RAW_EVENT_QUEUE_SIZE];
> +	int			size;
> +};
> +
> +static void raw_event_queue_init(struct raw_event_queue *queue)
> +{
> +	spin_lock_init(&queue->lock);
> +	sema_init(&queue->sema, 0);
> +	queue->size =3D 0;
> +}
> +
> +static int raw_event_queue_add(struct raw_event_queue *queue,
> +	enum usb_raw_event_type type, size_t length, const void *data)
> +{
> +	unsigned long flags;
> +	struct usb_raw_event *event;
> +
> +	spin_lock_irqsave(&queue->lock, flags);
> +	if (WARN_ON(queue->size >=3D RAW_EVENT_QUEUE_SIZE)) {
> +		spin_unlock_irqrestore(&queue->lock, flags);
> +		return -ENOMEM;
> +	}
> +	event =3D kmalloc(sizeof(*event) + length, GFP_ATOMIC);

I would very much prefer dropping GFP_ATOMIC here. Must you have this
allocation under a spinlock?

=2D-=20
balbi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElLzh7wn96CXwjh2IzL64meEamQYFAl40LrMACgkQzL64meEa
mQZ34A/+PEsPJGJEwaPe8uSyOnxcLGfX6nQcG+umeqh87OX+SYRm89gvVrefAHkb
K9PMn377Pwi4OTbbKqvWu9GVBD5Rt+XvFifyu81b4muLZH8SPAiYBr1z604pCAr0
oa94r46PL0WuMQCQw7ah3GoaQYbhQgBA1VBE7LBjtpDvTBVC6HTAA4Y4O6uaRqw9
zjRRmb1E+jO6J8/PeMqr8tcif4s3bubH6ogTBjD1ktTrZV095dCCL4ys8XaVhsc5
NutWsx35mrLczMvy976eYUvrNPAFwEDMjShC9lb1W675jdgFx1wbJhUax47Et83P
RRu3YfKIwGJ9Kyukrccj/ReH10jaFvlsK9EMTR94B6789vP2vyfmSGTiyoxS4c65
Avm2n5aTO581rnr9qBFmF3hu17akOvJYcFWIHDW8wvJESTdreSNTf2zYDA4+V0Ca
Gft582uo1YwwWv0SVjjxykpcFBb/QWyKqhDxfvSjzmZI1dHmtDjkVobnXW6x9H25
9If6xMTAJTHz1GKZCvjMrvuk9UcvNGaztSmOILDbB1lssyivRpuvJjwU77bpvjas
8eOwOEg0Yl1tVyReeSJZPIHcTYqyV340arQPm2/wzJRJ4wd2TrLlKM5Sa71MhciH
EfgAbEo6C4aMu1dULcBy/5Pg0q00ZBoyT3zH57OU23eRyi/fL80=
=zN+s
-----END PGP SIGNATURE-----
--=-=-=--
