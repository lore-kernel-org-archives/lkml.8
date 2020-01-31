Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FC4C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 665012067C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 14:43:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SHSxG5L9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAaOnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 09:43:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46295 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728827AbgAaOnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 09:43:41 -0500
Received: by mail-pg1-f196.google.com with SMTP id z124so3556783pgb.13
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 06:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0uf4K/bU0Jq2F11YubyeM+XdX9ASXf47CXUmvq9CKcA=;
        b=SHSxG5L9Mx4GBouBpHdb1qvxjf06/IIvCnMGL0XaEb5Y2BxSex9UfYidM8R2iR38oz
         SbbTvB0klh7upLcpCK61EnawtYHsjw+bKxVzYXi+Iji29YCCI1uHUuGiWJIx3r+xd6ox
         NYi2f1qxbgIVeUDSkNMSdkGENgfyAvvOB0Ln4i0ZvI1MVGDbS04yh4nkw5gLK80Pw75S
         uuH6tIedEpWIexuEFQyBY83fcuaA+XG+imrW/bjiPE0gzx7dsOg5HX/3SkgIxxaBCB8x
         tKDOhMfs6w1v+xqjAyvArbmgS1UTiQV4+TvTslod74souOi8xiZI7WmgcCT0PVaMa5P1
         tlQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0uf4K/bU0Jq2F11YubyeM+XdX9ASXf47CXUmvq9CKcA=;
        b=rVCFKD60R1Yt1/zqLFuBAe/PcOsYjaNMSNTUlZVvapD66o4KGGw1HBDyOXu/HAmU3z
         XX7Cnnby4ErssXIZbjDmKfYxQidysnD/oDDv2yVIsbqV8LCdgeHISJkpQ9ChBG1pT0DF
         J6/cAq66YvnRjQ0Ec5TTDY0YQ7cg6eE4ZwZsVEHdi5tthHuy6zk7u/YaYp7pIgIM40EI
         7pFKHdr0laUJ4ChnMffKOjVxiU3901Mh5RRkv19bsqfAYvhkY+MaQywyxMU+BGSiVX+F
         8BevbgfeaOVZpbIQaeb+QjIgMBUf3uX8HIjjHgnWpwX4JU18ZDf+/yZh59e6q2ZOsTkY
         rd8w==
X-Gm-Message-State: APjAAAVSG/SeEuINEapgmgqAsjYYx+73bqSO0H41Rr3EfYOHQsglsm+1
        dOhQoMXPCMop4/oHd1VuG63MLPLeXH56NsVTE+76CQ==
X-Google-Smtp-Source: APXvYqzVLJWvwCi1PPl6Qt0kbR09VreCD5GUZpNyd/x9zxIt1/nxR1dv3G9O7xj4WO86W1hgBs2TpvyOq70OQfCLNn4=
X-Received: by 2002:a65:678f:: with SMTP id e15mr10760407pgr.130.1580481819799;
 Fri, 31 Jan 2020 06:43:39 -0800 (PST)
MIME-Version: 1.0
References: <cover.1579007786.git.andreyknvl@google.com> <461a787e63a9a01d83edc563575b8585bc138e8d.1579007786.git.andreyknvl@google.com>
 <87ftfv7nf0.fsf@kernel.org>
In-Reply-To: <87ftfv7nf0.fsf@kernel.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 31 Jan 2020 15:43:28 +0100
Message-ID: <CAAeHK+wwmis4z9ifPAnkM36AnfG2oESSLAkKvDkuAa0QUM2wRg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] usb: gadget: add raw-gadget interface
To:     Felipe Balbi <balbi@kernel.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 31, 2020 at 2:42 PM Felipe Balbi <balbi@kernel.org> wrote:
>
>
> Hi,
>
> Andrey Konovalov <andreyknvl@google.com> writes:
> > USB Raw Gadget is a kernel module that provides a userspace interface for
> > the USB Gadget subsystem. Essentially it allows to emulate USB devices
> > from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> > currently a strictly debugging feature and shouldn't be used in
> > production.
> >
> > Raw Gadget is similar to GadgetFS, but provides a more low-level and
> > direct access to the USB Gadget layer for the userspace. The key
> > differences are:
> >
> > 1. Every USB request is passed to the userspace to get a response, while
> >    GadgetFS responds to some USB requests internally based on the provided
> >    descriptors. However note, that the UDC driver might respond to some
> >    requests on its own and never forward them to the Gadget layer.
> >
> > 2. GadgetFS performs some sanity checks on the provided USB descriptors,
> >    while Raw Gadget allows you to provide arbitrary data as responses to
> >    USB requests.
> >
> > 3. Raw Gadget provides a way to select a UDC device/driver to bind to,
> >    while GadgetFS currently binds to the first available UDC.
> >
> > 4. Raw Gadget uses predictable endpoint names (handles) across different
> >    UDCs (as long as UDCs have enough endpoints of each required transfer
> >    type).
> >
> > 5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
> >
> > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> > ---
> >
> > Greg, I've assumed your LGTM meant that I can add a Reviewed-by from you.
> >
> > Felipe, looking forward to your review, thanks!
> >
> >  Documentation/usb/index.rst            |    1 +
> >  Documentation/usb/raw-gadget.rst       |   59 ++
> >  drivers/usb/gadget/legacy/Kconfig      |   11 +
> >  drivers/usb/gadget/legacy/Makefile     |    1 +
> >  drivers/usb/gadget/legacy/raw_gadget.c | 1068 ++++++++++++++++++++++++
> >  include/uapi/linux/usb/raw_gadget.h    |  167 ++++
> >  6 files changed, 1307 insertions(+)
> >  create mode 100644 Documentation/usb/raw-gadget.rst
> >  create mode 100644 drivers/usb/gadget/legacy/raw_gadget.c
> >  create mode 100644 include/uapi/linux/usb/raw_gadget.h
> >
> > diff --git a/Documentation/usb/index.rst b/Documentation/usb/index.rst
> > index e55386a4abfb..90310e2a0c1f 100644
> > --- a/Documentation/usb/index.rst
> > +++ b/Documentation/usb/index.rst
> > @@ -22,6 +22,7 @@ USB support
> >      misc_usbsevseg
> >      mtouchusb
> >      ohci
> > +    raw-gadget
> >      rio
> >      usbip_protocol
> >      usbmon
> > diff --git a/Documentation/usb/raw-gadget.rst b/Documentation/usb/raw-gadget.rst
> > new file mode 100644
> > index 000000000000..cbedf5451ed3
> > --- /dev/null
> > +++ b/Documentation/usb/raw-gadget.rst
> > @@ -0,0 +1,59 @@
> > +==============
> > +USB Raw Gadget
> > +==============
> > +
> > +USB Raw Gadget is a kernel module that provides a userspace interface for
> > +the USB Gadget subsystem. Essentially it allows to emulate USB devices
> > +from userspace. Enabled with CONFIG_USB_RAW_GADGET. Raw Gadget is
> > +currently a strictly debugging feature and shouldn't be used in
> > +production, use GadgetFS instead.
> > +
> > +Comparison to GadgetFS
> > +~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +Raw Gadget is similar to GadgetFS, but provides a more low-level and
> > +direct access to the USB Gadget layer for the userspace. The key
> > +differences are:
> > +
> > +1. Every USB request is passed to the userspace to get a response, while
> > +   GadgetFS responds to some USB requests internally based on the provided
> > +   descriptors. However note, that the UDC driver might respond to some
> > +   requests on its own and never forward them to the Gadget layer.
> > +
> > +2. GadgetFS performs some sanity checks on the provided USB descriptors,
> > +   while Raw Gadget allows you to provide arbitrary data as responses to
> > +   USB requests.
> > +
> > +3. Raw Gadget provides a way to select a UDC device/driver to bind to,
> > +   while GadgetFS currently binds to the first available UDC.
> > +
> > +4. Raw Gadget uses predictable endpoint names (handles) across different
> > +   UDCs (as long as UDCs have enough endpoints of each required transfer
> > +   type).
> > +
> > +5. Raw Gadget has ioctl-based interface instead of a filesystem-based one.
> > +
> > +Userspace interface
> > +~~~~~~~~~~~~~~~~~~~
> > +
> > +To create a Raw Gadget instance open /dev/raw-gadget. Multiple raw-gadget
> > +instances (bound to different UDCs) can be used at the same time. The
> > +interaction with the opened file happens through the ioctl() calls, see
> > +comments in include/uapi/linux/usb/raw_gadget.h for details.
> > +
> > +The typical usage of Raw Gadget looks like:
> > +
> > +1. Open Raw Gadget instance via /dev/raw-gadget.
> > +2. Initialize the instance via USB_RAW_IOCTL_INIT.
> > +3. Launch the instance with USB_RAW_IOCTL_RUN.
> > +4. In a loop issue USB_RAW_IOCTL_EVENT_FETCH calls to receive events from
> > +   Raw Gadget and react to those depending on what kind of USB device
> > +   needs to be emulated.
> > +
> > +Potential future improvements
> > +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > +
> > +- Implement ioctl's for setting/clearing halt status on endpoints.
> > +
> > +- Reporting more events (suspend, resume, etc.) through
> > +  USB_RAW_IOCTL_EVENT_FETCH.
> > diff --git a/drivers/usb/gadget/legacy/Kconfig b/drivers/usb/gadget/legacy/Kconfig
> > index 119a4e47681f..55e495f5d103 100644
> > --- a/drivers/usb/gadget/legacy/Kconfig
> > +++ b/drivers/usb/gadget/legacy/Kconfig
> > @@ -489,3 +489,14 @@ config USB_G_WEBCAM
> >
> >         Say "y" to link the driver statically, or "m" to build a
> >         dynamically linked module called "g_webcam".
> > +
> > +config USB_RAW_GADGET
> > +     tristate "USB Raw Gadget"
> > +     help
> > +       USB Raw Gadget is a kernel module that provides a userspace interface
> > +       for the USB Gadget subsystem. Essentially it allows to emulate USB
> > +       devices from userspace. See Documentation/usb/raw-gadget.rst for
> > +       details.
> > +
> > +       Say "y" to link the driver statically, or "m" to build a
> > +       dynamically linked module called "raw_gadget".
> > diff --git a/drivers/usb/gadget/legacy/Makefile b/drivers/usb/gadget/legacy/Makefile
> > index abd0c3e66a05..4d864bf82799 100644
> > --- a/drivers/usb/gadget/legacy/Makefile
> > +++ b/drivers/usb/gadget/legacy/Makefile
> > @@ -43,3 +43,4 @@ obj-$(CONFIG_USB_G_WEBCAM)  += g_webcam.o
> >  obj-$(CONFIG_USB_G_NCM)              += g_ncm.o
> >  obj-$(CONFIG_USB_G_ACM_MS)   += g_acm_ms.o
> >  obj-$(CONFIG_USB_GADGET_TARGET)      += tcm_usb_gadget.o
> > +obj-$(CONFIG_USB_RAW_GADGET) += raw_gadget.o
> > diff --git a/drivers/usb/gadget/legacy/raw_gadget.c b/drivers/usb/gadget/legacy/raw_gadget.c
> > new file mode 100644
> > index 000000000000..51796af48069
> > --- /dev/null
> > +++ b/drivers/usb/gadget/legacy/raw_gadget.c
> > @@ -0,0 +1,1068 @@
> > +// SPDX-License-Identifier: GPL-2.0
>
> V2 only

Like this: SPDX-License-Identifier: GPL-2.0 only ?

>
> > +/*
> > + * USB Raw Gadget driver.
> > + * See Documentation/usb/raw-gadget.rst for more details.
> > + *
> > + * Andrey Konovalov <andreyknvl@gmail.com>
> > + */
> > +
> > +#include <linux/compiler.h>
> > +#include <linux/debugfs.h>
> > +#include <linux/delay.h>
> > +#include <linux/kref.h>
> > +#include <linux/miscdevice.h>
> > +#include <linux/module.h>
> > +#include <linux/semaphore.h>
> > +#include <linux/sched.h>
> > +#include <linux/slab.h>
> > +#include <linux/uaccess.h>
> > +#include <linux/wait.h>
> > +
> > +#include <linux/usb.h>
> > +#include <linux/usb/ch9.h>
> > +#include <linux/usb/ch11.h>
> > +#include <linux/usb/gadget.h>
> > +
> > +#include <uapi/linux/usb/raw_gadget.h>
> > +
> > +#define      DRIVER_DESC "USB Raw Gadget"
> > +#define DRIVER_NAME "raw-gadget"
> > +
> > +MODULE_DESCRIPTION(DRIVER_DESC);
> > +MODULE_AUTHOR("Andrey Konovalov");
> > +MODULE_LICENSE("GPL");
>
> v2+. Care to fix?

MODULE_LICENSE("GPL-v2+")?

>
> > +
> > +/*----------------------------------------------------------------------*/
> > +
> > +#define RAW_EVENT_QUEUE_SIZE 128
> > +
> > +struct raw_event_queue {
> > +     /* See the comment in raw_event_queue_fetch() for locking details. */
> > +     spinlock_t              lock;
> > +     struct semaphore        sema;
> > +     struct usb_raw_event    *events[RAW_EVENT_QUEUE_SIZE];
> > +     int                     size;
> > +};
> > +
> > +static void raw_event_queue_init(struct raw_event_queue *queue)
> > +{
> > +     spin_lock_init(&queue->lock);
> > +     sema_init(&queue->sema, 0);
> > +     queue->size = 0;
> > +}
> > +
> > +static int raw_event_queue_add(struct raw_event_queue *queue,
> > +     enum usb_raw_event_type type, size_t length, const void *data)
> > +{
> > +     unsigned long flags;
> > +     struct usb_raw_event *event;
> > +
> > +     spin_lock_irqsave(&queue->lock, flags);
> > +     if (WARN_ON(queue->size >= RAW_EVENT_QUEUE_SIZE)) {
> > +             spin_unlock_irqrestore(&queue->lock, flags);
> > +             return -ENOMEM;
> > +     }
> > +     event = kmalloc(sizeof(*event) + length, GFP_ATOMIC);
>
> I would very much prefer dropping GFP_ATOMIC here. Must you have this
> allocation under a spinlock?

The issue here is not the spinlock, but that this might be called in
interrupt context. The number of atomic allocations here is restricted
by 128, and we can reduce the limit even further (until some point in
the future when and if we'll report more different events). Another
option would be to preallocate the required number of objects
(although we don't know the required size in advance, so we'll waste
some memory) and use those. What would you prefer?

Thank you for the review!
