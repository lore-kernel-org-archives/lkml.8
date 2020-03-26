Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDA6C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F41172070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:48:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="Zq8FyuU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgCZRsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:48:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38127 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgCZRsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:48:12 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so7681878qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 10:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UdzathrvJR4jBf7F/I3MbOudIL3YUZaxVWJlak5sKcI=;
        b=Zq8FyuU39YhoJErv0PWz7r1nc08kY94S4Pdlabi/HURBH1p9dBfba425PKa6v6PJt4
         XLf5dZyquYrfHb65FM714FJxb8ic4esiZd7TyupZxVLWtDwLCoDccyynFMyHKAXDeanz
         9hxh9Ql69QhiCe6h73hTyuDc4B6omXS46zWl90iyiGO043QfH9HI1QHjhy87e7PaFooI
         5pDnjU/yFJCMk/5XqSXOrFNojvlSnIjoMOgYGyTOrl0yMqMYrBxyW2oFAwNAxaeLqJ7D
         K/TGMi2M7DHzPcD+yotcBKb9oUVF9+rl5iXT6BLiqcV9hIRQftTMcp6Nl05JheKB8kE2
         tFGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UdzathrvJR4jBf7F/I3MbOudIL3YUZaxVWJlak5sKcI=;
        b=RuFuHsHOXsaXMKc9igM5+G1bjetoLG9sN6010QTNYIAlS+Un6inoXxQBfQblIE0wqH
         kCn3mtn3QazIfM1ZOSfJyhrdOz5gYx39kXk1lu8R+fE2laXmgrKQg7ZaYtJIStjEORmR
         0cu28T3gnRfXZOh1Hq1k4bJh32FNHQW0W+BhzYb2ivDLI+zCqfwCM6ACkXWXgudr6ThT
         JjYVJ24oH0e9MYD2/DAAkR5Y2l6NeUj0J5+CcaF8Dy9He9oPGlMxSOyfHcCh3mFyU60X
         ZCsB62AYixgkF9xG/3F6yMrKwjaMqhNaimNBsUNquZdgDe3gIuT1a+btOrk/mMRkyXAP
         gVhQ==
X-Gm-Message-State: ANhLgQ1fMBVfH+AkT13pqItD3Ob62ApLgNaMQCEbHKKKKg7BLhHWuNWb
        5ESHx6pcf8YrtPJxQgx7kDuPTaGPw1uSxMfKBFWZLg==
X-Google-Smtp-Source: ADFU+vvJ8xbBOuqKCiv4VZmIKjFDD2oxqXeZaKqzly9zC2/bbQwsZwdxkNyXRYptfnRBVx4mUyxlC+TgKOkjCe+cJJk=
X-Received: by 2002:a37:3c9:: with SMTP id 192mr9514408qkd.330.1585244891403;
 Thu, 26 Mar 2020 10:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200326131721.6404-1-brgl@bgdev.pl> <c71a132d-dc33-0b8a-29e0-9cf93056ef52@gmail.com>
In-Reply-To: <c71a132d-dc33-0b8a-29e0-9cf93056ef52@gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 26 Mar 2020 18:48:00 +0100
Message-ID: <CAMpxmJWLbUR5ojGi3vdMw-vrG3ias9yUE+ycrhZ8m=EL-GrreQ@mail.gmail.com>
Subject: Re: [PATCH] net: core: provide devm_register_netdev()
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 26 mar 2020 o 18:39 Heiner Kallweit <hkallweit1@gmail.com> napisa=C5=
=82(a):
>
> On 26.03.2020 14:17, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Create a new source file for networking devres helpers and provide
> > devm_register_netdev() - a managed variant of register_netdev().
> >
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> > I'm writing a new ethernet driver and I realized there's no devres
> > variant for register_netdev(). Since this is the only function I need
> > to get rid of the remove() callback, I thought I'll just go ahead and
> > add it and send it even before the driver to make it available to other
> > drivers.
> >
>
> Such a new functionality typically is accepted as part of series adding
> at least one user only. Therefore best submit it together with the new
> network driver.
>

Sure, will do.

> >  .../driver-api/driver-model/devres.rst        |  3 ++
> >  include/linux/netdevice.h                     |  1 +
> >  net/core/Makefile                             |  2 +-
> >  net/core/devres.c                             | 41 +++++++++++++++++++
> >  4 files changed, 46 insertions(+), 1 deletion(-)
> >  create mode 100644 net/core/devres.c
> >
> > diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documen=
tation/driver-api/driver-model/devres.rst
> > index 46c13780994c..11a03b65196e 100644
> > --- a/Documentation/driver-api/driver-model/devres.rst
> > +++ b/Documentation/driver-api/driver-model/devres.rst
> > @@ -372,6 +372,9 @@ MUX
> >    devm_mux_chip_register()
> >    devm_mux_control_get()
> >
> > +NET
> > +  devm_register_netdev()
> > +
> >  PER-CPU MEM
> >    devm_alloc_percpu()
> >    devm_free_percpu()
> > diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> > index 6c3f7032e8d9..710a7bcfc3dc 100644
> > --- a/include/linux/netdevice.h
> > +++ b/include/linux/netdevice.h
> > @@ -4196,6 +4196,7 @@ struct net_device *alloc_netdev_mqs(int sizeof_pr=
iv, const char *name,
> >                        count)
> >
> >  int register_netdev(struct net_device *dev);
> > +int devm_register_netdev(struct device *dev, struct net_device *ndev);
> >  void unregister_netdev(struct net_device *dev);
> >
> >  /* General hardware address lists handling functions */
> > diff --git a/net/core/Makefile b/net/core/Makefile
> > index 3e2c378e5f31..f530894068d2 100644
> > --- a/net/core/Makefile
> > +++ b/net/core/Makefile
> > @@ -8,7 +8,7 @@ obj-y :=3D sock.o request_sock.o skbuff.o datagram.o st=
ream.o scm.o \
> >
> >  obj-$(CONFIG_SYSCTL) +=3D sysctl_net_core.o
> >
> > -obj-y                     +=3D dev.o dev_addr_lists.o dst.o netevent.o=
 \
> > +obj-y                     +=3D dev.o devres.o dev_addr_lists.o dst.o n=
etevent.o \
> >                       neighbour.o rtnetlink.o utils.o link_watch.o filt=
er.o \
> >                       sock_diag.o dev_ioctl.o tso.o sock_reuseport.o \
> >                       fib_notifier.o xdp.o flow_offload.o
> > diff --git a/net/core/devres.c b/net/core/devres.c
> > new file mode 100644
> > index 000000000000..3c080abd1935
> > --- /dev/null
> > +++ b/net/core/devres.c
>
> Why a new source file and not just add the function to net/core/dev.c?
>

This is a common approach in most sub-systems to have a dedicated
devres.c source file for managed helpers. Eventually we could move
devm_alloc_etherdev() here as well.

>
> > @@ -0,0 +1,41 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (C) 2020 BayLibre SAS
> > + * Author: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > + */
> > +
> > +#include <linux/device.h>
> > +#include <linux/netdevice.h>
> > +
> > +struct netdevice_devres {
> > +     struct net_device *ndev;
> > +};
> > +
>
> Adding such a struct isn't strictly needed.
>

I believe it's better in terms of readability.

> > +static void devm_netdev_release(struct device *dev, void *res)
> > +{
> > +     struct netdevice_devres *this =3D res;
> > +
> > +     unregister_netdev(this->ndev);
> > +}
> > +
> > +int devm_register_netdev(struct device *dev, struct net_device *ndev)
> > +{
>
> In this function you'd need to consider the dependency on a previous
> call to devm_alloc_etherdev(). If the netdevice is allocated non-managed,
> then free_netdev() would be called whilst the netdevice is still
> registered, what would trigger a BUG_ON(). Therefore devm_register_netdev=
()
> should return an error if the netdevice was allocated non-managed.
> The mentioned scenario would result from a severe programming error
> of course, but there are less experienced driver authors and the net core
> should deal gently with wrong API usage.
>

Thank you for bringing this to my attention, I wasn't aware of that.
I'll rework this.

Best regards,
Bartosz

> An example how this could be done you can find in the PCI subsystem,
> see pcim_release() and related functions like pcim_enable() and
> pcim_set_mwi().
>
> > +     struct netdevice_devres *devres;
> > +     int ret;
> > +
> > +     devres =3D devres_alloc(devm_netdev_release, sizeof(*devres), GFP=
_KERNEL);
> > +     if (!devres)
> > +             return -ENOMEM;
> > +
> > +     ret =3D register_netdev(ndev);
> > +     if (ret) {
> > +             devres_free(devres);
> > +             return ret;
> > +     }
> > +
> > +     devres->ndev =3D ndev;
> > +     devres_add(dev, devres);
> > +
> > +     return 0;
> > +}
> > +EXPORT_SYMBOL(devm_register_netdev);
> >
>
