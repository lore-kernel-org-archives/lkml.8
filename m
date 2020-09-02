Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828ACC433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:01:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 475C4206EF
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 00:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dVoiHvF8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgIBABb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 20:01:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgIBAB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 20:01:29 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737EC061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 17:01:28 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id w186so1576818pgb.8
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 17:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D2WEXUnBtNgYcVUkQ3/LwiFn7s+fF2Pwd+++oZDF2GY=;
        b=dVoiHvF8xkb+xh0jz2vBgKA54XtDDHvge8f3y9fjbWCCpIQH/MS6l9tRx20SdW25mN
         5yPw1SB2sjp2BPqEqQOKbhNsVgLgc8t+KJBq6CtjDBx9WGXHduPLV/g6Ng0HGz1EPkfH
         4IcfAmrsKiznljRr2WR0q8XIm4P7txbZJzfVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D2WEXUnBtNgYcVUkQ3/LwiFn7s+fF2Pwd+++oZDF2GY=;
        b=pQMk7ID6u5umig0EbWnmTmKeQeRHefzI0pQUqkQYkc+S7f37NQsYthD1m5HdFRRNQA
         0avhY/goDrPJrORgsDP4LvpmHHIVLVPy/KD8lGLigKXziDDhz/gN12jJikBxL58fd/O9
         lx3Gfz+K5oKmeFzrBViNNlL+dkFUJX31ydH0TLJaHQYpum3P27XUluB4k7tMMYs43CGs
         gN1QRX0w7K1rfcoRLDaqAEZA65glryORiFQgNMvyaJ69OOigelr449T0u+JuTmIHddpX
         2tHr3l9tKU7tFschrcNRS63sprnUs5FSladH48KHdpmfQdiJArnfR+rZ8+442A71NjmQ
         pVBQ==
X-Gm-Message-State: AOAM531YADXoa7TgM5Wan7NvrTTrYl1P36qAn93iRbEOwgOROZ8WMQG+
        iNetWiCiimr4NAADpgsVSGmiiPztp4f9kw==
X-Google-Smtp-Source: ABdhPJxmXB3dvS+kss5V/Vx83ABtW3JyGzUayuq+2UZ8N0+62mhkI/ZuospZ+zvvOrO4uEH+QlFZNA==
X-Received: by 2002:aa7:9ed2:: with SMTP id r18mr646875pfq.151.1599004887517;
        Tue, 01 Sep 2020 17:01:27 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:f693:9fff:fef4:e70a])
        by smtp.gmail.com with ESMTPSA id i17sm3092590pfo.150.2020.09.01.17.01.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 17:01:26 -0700 (PDT)
Date:   Tue, 1 Sep 2020 17:01:25 -0700
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>,
        Bastien Nocera <hadess@hadess.net>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>, linux-usb@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>
Subject: Re: [RFC PATCH] USB: misc: Add usb_hub_pwr driver
Message-ID: <20200902000125.GD3419728@google.com>
References: <20200901132005.RFC.1.I7c9a1f1d6ced41dd8310e8a03da666a32364e790@changeid>
 <CAD=FV=V+T-8wxiufFEq6Tyq+KcTDLgnMfxNo6K1WxaRLWEKmtQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=V+T-8wxiufFEq6Tyq+KcTDLgnMfxNo6K1WxaRLWEKmtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On Tue, Sep 01, 2020 at 02:21:49PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Tue, Sep 1, 2020 at 1:21 PM Matthias Kaehlcke <mka@chromium.org> wrote:
> >
> > The driver combo usb_hub_pwr/usb_hub_psupply allows to control
> > the power supply of an onboard USB hub.
> >
> > The drivers address two issues:
> >  - a USB hub needs to be powered before it can be discovered
> >  - battery powered devices may want to switch the USB hub off
> >    during suspend to extend battery life
> >
> > The regulator of the hub is controlled by the usb_hub_psupply
> > platform driver. The regulator is switched on when the platform
> > device is initialized, which enables discovery of the hub. The
> > driver provides an external interface to enable/disable the
> > power supply which is used by the usb_hub_pwr driver.
> >
> > The usb_hub_pwr extends the generic USB hub driver. The device is
> > initialized when the hub is discovered by the USB subsystem. It
> > uses the usb_hub_psupply interface to make its own request to
> > enable the regulator (increasing the use count to 2).
> >
> > During system suspend usb_hub_pwr checks if any wakeup capable
> > devices are connected to the hub. If not it 'disables' the hub
> > regulator (decreasing the use count to 1, hence the regulator
> > stays enabled for now). When the usb_hub_psupply device suspends
> > it disables the hub regulator unconditionally (decreasing the use
> > count to 0 or 1, depending on the actions of usb_hub_pwr). This
> > is done to allow the usb_hub_pwr device to control the state of
> > the regulator during system suspend.
> >
> > Upon resume usb_hub_psupply enables the regulator again, the
> > usb_hub_pwr device does the same if it disabled the regulator
> > during resume.
> >
> > Co-developed-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Ravi Chandra Sadineni <ravisadineni@chromium.org>
> > Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> > ---
> > The driver currently only supports a single power supply. This should
> > work for most/many configurations/hubs, support for multiple power
> > supplies can be added later if needed.
> >
> > No DT bindings are included since this is just a RFC. Here is a DT
> > example:
> >
> > usb_hub_psupply: usb-hub-psupply {
> >     compatible = "linux,usb_hub_psupply";
> >     vdd-supply = <&pp3300_hub>;
> > };
> 
> Definitely bikeshedding, but I would name this differently.  The
> name/compatible you have makes this sound as if it's a software
> concept that we're sticking into DT.  That's generally discouraged.
> ...if we name it slightly different then I think the driver can work
> the same but be more in the spirit of DT describing hardware.
> Specifically, I think it'd be better as:
> 
> usb_hub: usb-hub {
>   compatible = "realtek,rts5411", "onboard-usb-hub";
>   vdd-supply = <&pp3300_hub>;
> };
> 
> Now we're describing hardware that's on the board.  We have a RTS5411
> hub and we've described its power supply.  There's also precedent for
> describing an on-board USB hub in a lop-level node like this
> (smsc,usb3503).

You are right, it definitely describes existing hardware, not some
linux-ism.

I also envisioned that there might be eventually device specific
compatible strings to support multiple regulators or even hub specific
power on/off sequences.

> Now, I know what you're saying: we're already describing this hub
> underneath the USB port node below.  I think this is OK to have
> different aspects of the device described in two places in the DT,
> though of course I could be corrected by someone more knowledgeable.
> 
> 
> > &usb_1_dwc3 {
> >     /* 2.0 hub on port 1 */
> >     hub@1 {
> >         compatible = "usbbda,5411";
> 
> What is "usbbda"?  I would probably just call this:
> 
> compatible = "realtek,rts5411-usb2", "onboard-usb-hub-usb2"

That's from the USB bindings:

  Required properties for device nodes:
  - compatible: "usbVID,PID", where VID is the vendor id and PID the product id.
    The textual representation of VID and PID shall be in lower case hexadecimal
    with leading zeroes suppressed. The other compatible strings from the above
    standard binding could also be used, but a device adhering to this binding
    may leave out all except for "usbVID,PID".

https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/usb/usb-device.txt

> 
> 
> >         reg = <1>;
> >         psupply = <&usb_hub_psupply>;
> 
> Calling this psupply sounds a bit too much like you're referring to a
> regulator (with the -supply suffix).  Given that I've proposed calling
> the main device "usb-hub" what about just saying "hub = <&usb_hub>;"

I envisioned it as an abstract regulator (potentially consisting of
multiple regulators), but modelling it with the regulator framework
also didn't seem the right thing to do.

Using the hub abstraction sounds good to me. Maybe we should also come
up with a better name for 'usb_hub_psupply', I never was overly fond
of it.

> >     };
> >
> >     /* 3.0 hub on port 2 */
> >     hub@2 {
> >         compatible = "usbbda,411";
> 
> Similar to above:
> 
> compatible = "realtek,rts5411-usb3", "onboard-usb-hub-usb3"

See above, need to follow the binding.

At some point I experimented with using device class matching instead
of VID/PID, but discarded it since I anticipated that the driver would
have to handle eventually device specific regulator handling. Now that
that is handled by the 'usb_hub_psupply' driver (initially there was a
single driver) it might be feasible again (e.g. manage all hubs that
have a DT node and a 'hub' property).

> >         reg = <2>;
> >         psupply = <&usb_hub_psupply>;
> >     };
> > };
> >
> >  drivers/usb/misc/Kconfig           |  14 +++
> >  drivers/usb/misc/Makefile          |   1 +
> >  drivers/usb/misc/usb_hub_psupply.c | 112 ++++++++++++++++++
> >  drivers/usb/misc/usb_hub_psupply.h |   9 ++
> >  drivers/usb/misc/usb_hub_pwr.c     | 177 +++++++++++++++++++++++++++++
> >  5 files changed, 313 insertions(+)
> >  create mode 100644 drivers/usb/misc/usb_hub_psupply.c
> >  create mode 100644 drivers/usb/misc/usb_hub_psupply.h
> >  create mode 100644 drivers/usb/misc/usb_hub_pwr.c
> >
> > diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> > index 6818ea689cd9..79ed50e6a7bf 100644
> > --- a/drivers/usb/misc/Kconfig
> > +++ b/drivers/usb/misc/Kconfig
> > @@ -275,3 +275,17 @@ config USB_CHAOSKEY
> >
> >           To compile this driver as a module, choose M here: the
> >           module will be called chaoskey.
> > +
> > +config USB_HUB_PWR
> > +       tristate "Control power supply for onboard USB hubs"
> > +       depends on PM
> > +       help
> > +         Say Y here if you want to control the power supply of an
> > +         onboard USB hub. The driver switches the power supply of the
> > +         hub on, to make sure the hub can be discovered. During system
> > +         suspend the power supply is switched off, unless a wakeup
> > +         capable device is connected to the hub. This may reduce power
> > +         consumption on battery powered devices.
> > +
> > +         To compile this driver as a module, choose M here: the
> > +         module will be called usb_hub_pwr.
> > diff --git a/drivers/usb/misc/Makefile b/drivers/usb/misc/Makefile
> > index da39bddb0604..2bd02388ca62 100644
> > --- a/drivers/usb/misc/Makefile
> > +++ b/drivers/usb/misc/Makefile
> > @@ -31,3 +31,4 @@ obj-$(CONFIG_USB_CHAOSKEY)            += chaoskey.o
> >
> >  obj-$(CONFIG_USB_SISUSBVGA)            += sisusbvga/
> >  obj-$(CONFIG_USB_LINK_LAYER_TEST)      += lvstest.o
> > +obj-$(CONFIG_USB_HUB_PWR)              += usb_hub_pwr.o usb_hub_psupply.o
> > diff --git a/drivers/usb/misc/usb_hub_psupply.c b/drivers/usb/misc/usb_hub_psupply.c
> > new file mode 100644
> > index 000000000000..6a155ae1f831
> > --- /dev/null
> > +++ b/drivers/usb/misc/usb_hub_psupply.c
> > @@ -0,0 +1,112 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2020, Google LLC
> > + */
> > +
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/regulator/consumer.h>
> > +
> > +struct usb_hub_psupply_dev {
> > +       struct regulator *vdd;
> > +};
> 
> Until someone has a need for more, I'd just pass your "struct
> regulator *" as the driver data and get rid of this pointless wrapper.

Sounds good, initially there was at least another field, but as of now
the struct is not needed.

> > +int usb_hub_psupply_on(struct device *dev)
> > +{
> > +       struct usb_hub_psupply_dev *usb_hub_psupply = dev_get_drvdata(dev);
> > +       int err;
> > +
> > +       err = regulator_enable(usb_hub_psupply->vdd);
> > +       if (err) {
> > +               dev_err(dev, "failed to enable regulator: %d\n", err);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +
> 
> nit: blank line
> 

ok

> > +}
> > +EXPORT_SYMBOL_GPL(usb_hub_psupply_on);
> > +
> > +int usb_hub_psupply_off(struct device *dev)
> > +{
> > +       struct usb_hub_psupply_dev *usb_hub_psupply = dev_get_drvdata(dev);
> > +       int err;
> > +
> > +       err = regulator_disable(usb_hub_psupply->vdd);
> > +       if (err) {
> > +               dev_err(dev, "failed to enable regulator: %d\n", err);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL_GPL(usb_hub_psupply_off);
> > +
> > +static int usb_hub_psupply_probe(struct platform_device *pdev)
> > +{
> > +       struct device *dev = &pdev->dev;
> > +       struct usb_hub_psupply_dev *usb_hub_psupply;
> > +
> > +       usb_hub_psupply = devm_kzalloc(dev, sizeof(*usb_hub_psupply), GFP_KERNEL);
> > +       if (!usb_hub_psupply)
> > +               return -ENOMEM;
> > +
> > +       dev_set_drvdata(dev, usb_hub_psupply);
> > +
> > +       usb_hub_psupply->vdd = devm_regulator_get(dev, "vdd");
> > +       if (IS_ERR(usb_hub_psupply->vdd))
> > +               return PTR_ERR(usb_hub_psupply->vdd);
> > +
> > +       return usb_hub_psupply_on(dev);
> > +}
> > +
> > +static int usb_hub_psupply_remove(struct platform_device *pdev)
> > +{
> > +       return usb_hub_psupply_off(&pdev->dev);
> > +}
> > +
> > +static int usb_hub_psupply_suspend(struct platform_device *pdev, pm_message_t msg)
> > +{
> > +       return usb_hub_psupply_off(&pdev->dev);
> > +}
> > +
> > +static int usb_hub_psupply_resume(struct platform_device *pdev)
> > +{
> > +       return usb_hub_psupply_on(&pdev->dev);
> > +}
> > +
> > +static const struct of_device_id usb_hub_psupply_match[] = {
> > +       { .compatible = "linux,usb_hub_psupply" },
> > +       {}
> > +};
> > +MODULE_DEVICE_TABLE(of, usb_hub_psupply_match);
> > +
> > +static struct platform_driver usb_hub_psupply_driver = {
> > +       .probe = usb_hub_psupply_probe,
> > +       .remove = usb_hub_psupply_remove,
> > +       .suspend = usb_hub_psupply_suspend,
> 
> SET_SYSTEM_SLEEP_PM_OPS?

ok

> Then you also need to add "__maybe_unused"
> to your suspend/resume functions.

Currently there is a dependency on CONFIG_PM, however that isn't strictly
needed, since the driver(s) is also useful besides suspend/resume to make
sure the hub is powered.

> > +       .resume = usb_hub_psupply_resume,
> > +       .driver = {
> > +               .name = "usb-hub-psupply",
> > +               .of_match_table = usb_hub_psupply_match,
> > +       },
> > +};
> > +
> > +static int __init usb_hub_psupply_init(void)
> > +{
> > +       return platform_driver_register(&usb_hub_psupply_driver);
> > +}
> > +device_initcall(usb_hub_psupply_init);
> > +
> > +static void __exit usb_hub_psupply_exit(void)
> > +{
> > +       platform_driver_unregister(&usb_hub_psupply_driver);
> > +}
> > +module_exit(usb_hub_psupply_exit);
> > +
> > +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> > +MODULE_DESCRIPTION("USB Hub Power Supply");
> > +MODULE_LICENSE("GPL v2");
> > diff --git a/drivers/usb/misc/usb_hub_psupply.h b/drivers/usb/misc/usb_hub_psupply.h
> > new file mode 100644
> > index 000000000000..284e88f45fcf
> > --- /dev/null
> > +++ b/drivers/usb/misc/usb_hub_psupply.h
> > @@ -0,0 +1,9 @@
> > +/* SPDX-License-Identifier: GPL-2.0-only */
> > +
> > +#ifndef _USB_HUB_PSUPPLY_H
> > +#define _USB_HUB_PSUPPLY_H
> > +
> > +int usb_hub_psupply_on(struct device *dev);
> > +int usb_hub_psupply_off(struct device *dev);
> > +
> > +#endif /* _USB_HUB_PSUPPLY_H */
> > diff --git a/drivers/usb/misc/usb_hub_pwr.c b/drivers/usb/misc/usb_hub_pwr.c
> > new file mode 100644
> > index 000000000000..33945ca4a8c0
> > --- /dev/null
> > +++ b/drivers/usb/misc/usb_hub_pwr.c
> > @@ -0,0 +1,177 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * USB hub power control
> > + *
> > + * Copyright (c) 2020, Google LLC
> > + */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/power_supply.h>
> > +#include <linux/regulator/consumer.h>
> > +#include <linux/slab.h>
> > +#include <linux/usb.h>
> > +#include <linux/usb/hcd.h>
> > +#include "../core/usb.h"
> > +#include "usb_hub_psupply.h"
> > +
> > +#define VENDOR_ID_REALTEK      0x0bda
> > +
> > +struct usb_hub_pwr_dev {
> > +       struct regulator *vdd;
> 
> You don't use the regulator directly, right?  So get rid of "vdd" here?

Right, that's still a remainder from the early days, when there was a single
driver.

> > +       struct device *psupply_dev;
> > +       bool powered_off;
> > +};
> > +
> > +static struct device *usb_pwr_find_psupply_dev(struct device *dev)
> > +{
> > +       const phandle *ph;
> > +       struct device_node *np;
> > +       struct platform_device *pdev;
> > +
> > +       ph = of_get_property(dev->of_node, "psupply", NULL);
> > +       if (!ph) {
> > +               dev_err(dev, "failed to read 'psupply' property\n");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       np = of_find_node_by_phandle(be32_to_cpu(*ph));
> > +       if (!np) {
> > +               dev_err(dev, "failed find device node for power supply\n");
> > +               return ERR_PTR(-EINVAL);
> > +       }
> > +
> > +       pdev = of_find_device_by_node(np);
> > +       of_node_put(np);
> > +       if (!pdev)
> > +               return ERR_PTR(-EPROBE_DEFER);
> > +
> > +       return &pdev->dev;
> > +}
> > +
> > +static int usb_hub_pwr_probe(struct usb_device *udev)
> > +{
> > +       struct device *dev = &udev->dev;
> > +       struct usb_hub_pwr_dev *uhpw;
> > +       struct device *psupply_dev;
> > +       int err;
> > +
> > +       /* ignore supported hubs without device tree node */
> > +       if (!dev->of_node)
> > +               return -ENODEV;
> 
> I can dig through the code if you don't know, but I'm hoping that
> -ENODEV means it'll fall back to the regular hub driver?

exactly

> > +       psupply_dev = usb_pwr_find_psupply_dev(dev);
> > +       if (IS_ERR(psupply_dev))
> > +               return PTR_ERR(psupply_dev);
> > +
> > +       err = usb_generic_driver_probe(udev);
> > +       if (err) {
> > +               put_device(psupply_dev);
> > +               return err;
> > +       }
> > +
> > +       uhpw = devm_kzalloc(dev, sizeof(*uhpw), GFP_KERNEL);
> > +       if (!uhpw) {
> > +               put_device(psupply_dev);
> > +               return -ENOMEM;
> > +       }
> > +
> > +       dev_set_drvdata(&udev->dev, uhpw);
> > +
> > +       uhpw->psupply_dev = psupply_dev;
> > +
> > +       err = usb_hub_psupply_on(psupply_dev);
> > +       if (err) {
> > +               dev_err(dev, "failed to enable regulator: %d\n", err);
> > +               put_device(psupply_dev);
> > +               return err;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static void usb_hub_pwr_disconnect(struct usb_device *udev)
> > +{
> > +       struct usb_hub_pwr_dev *uhpw = dev_get_drvdata(&udev->dev);
> > +
> > +       usb_hub_psupply_off(uhpw->psupply_dev);
> > +       put_device(uhpw->psupply_dev);
> > +}
> > +
> > +static int usb_hub_pwr_suspend(struct usb_device *udev, pm_message_t msg)
> > +{
> > +       struct usb_hub_pwr_dev *uhpw = dev_get_drvdata(&udev->dev);
> > +       int err;
> > +
> > +       err = usb_generic_driver_suspend(udev, msg);
> > +       if (err)
> > +               return err;
> > +
> > +       if (!usb_wakeup_enabled_descendants(udev)) {
> > +               usb_port_disable(udev);
> > +
> > +               err = usb_hub_psupply_off(uhpw->psupply_dev);
> > +               if (err)
> > +                       return err;
> > +
> > +               uhpw->powered_off = true;
> > +       }
> > +
> > +       return 0;
> > +}
> > +
> > +static int usb_hub_pwr_resume(struct usb_device *udev, pm_message_t msg)
> > +{
> > +       struct usb_hub_pwr_dev *uhpw = dev_get_drvdata(&udev->dev);
> > +       int err;
> > +
> > +       if (uhpw->powered_off) {
> > +               err = usb_hub_psupply_on(uhpw->psupply_dev);
> > +               if (err)
> > +                       return err;
> > +
> > +               uhpw->powered_off = false;
> > +       }
> > +
> > +       return usb_generic_driver_resume(udev, msg);
> > +}
> > +
> > +static const struct usb_device_id hub_id_table[] = {
> > +       { .idVendor = VENDOR_ID_REALTEK,
> > +         .idProduct = 0x0411, /* RTS5411 USB 3.0 */
> > +         .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
> > +       { .idVendor = VENDOR_ID_REALTEK,
> > +         .idProduct = 0x5411, /* RTS5411 USB 2.0 */
> > +         .match_flags = USB_DEVICE_ID_MATCH_DEVICE },
> > +       {},
> > +};
> > +
> > +MODULE_DEVICE_TABLE(usb, hub_id_table);
> > +
> > +static struct usb_device_driver usb_hub_pwr_driver = {
> > +
> > +       .name = "usb-hub-pwr",
> > +       .probe = usb_hub_pwr_probe,
> > +       .disconnect = usb_hub_pwr_disconnect,
> > +       .suspend = usb_hub_pwr_suspend,
> > +       .resume = usb_hub_pwr_resume,
> > +       .id_table = hub_id_table,
> 
> I'm not an expert, but do you need "supports_autosuspend"?  I think we
> want autosuspend enabled so nothing is plugged into the hub (or only
> things that can autosuspend) then we can save power.  I can dig more
> too, if you don't know.

Good point, I naively expected the generic driver would still handle
this automatically, but it doesn't.

This will require some filtering in the suspend/resume handling, it turns
out the handlers are called for runtime suspend/resume and we don't want to
turn off/on the regulator(s) in this case (even though it's a NOP since the
'psupply' driver keeps them enabled).

> > +};
> > +
> > +static int __init usb_hub_pwr_driver_init(void)
> > +{
> > +       return usb_register_device_driver(&usb_hub_pwr_driver, THIS_MODULE);
> > +}
> > +
> > +static void __exit usb_hub_pwr_driver_exit(void)
> > +{
> > +       usb_deregister_device_driver(&usb_hub_pwr_driver);
> > +}
> > +
> > +module_init(usb_hub_pwr_driver_init);
> > +module_exit(usb_hub_pwr_driver_exit);
> > +
> > +MODULE_AUTHOR("Matthias Kaehlcke <mka@chromium.org>");
> > +MODULE_DESCRIPTION("USB Hub Power Control");
> > +MODULE_LICENSE("GPL v2");
> 
> All the above is mostly just nits.  To me the concept here seems sane.

Thanks for the review!

m.
