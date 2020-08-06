Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12EC5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F11623119
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596732499;
	bh=RDm3gl0Uxr6dxdsLlUrcFLzvueJ/vGVG+WrmJzHA6KU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AkP4pjZfjZG8kYK3Kgt45g0W4xVZKSxSt/I2LL2PRnxeofscZlT2h4aamE2sIrntX
	 Mry5cUA5Mw+zNGvQiPSFiwOTbpFNm8dW2DnfPTA/2TuaSmak2S/eXFdprAeEzbH5xR
	 kLm1KBck3ej38mfOxG6IIKUgt+mwQTiwfW6z0N14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbgHFQsQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:48:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43481 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729009AbgHFQmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:42:49 -0400
Received: by mail-ed1-f66.google.com with SMTP id b18so4487958edv.10;
        Thu, 06 Aug 2020 09:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=O7b6zzBbEswhT1r045fM/qsaYWnifcvdI3BJNWUghN0=;
        b=dPs2Jf9mdsFOSfeP4RUxvVmNpO9ZC6St6BomLKCPcZiRclaDf7jZybK2NP+tjv8TdX
         0xDi5O+UJIIk7CMl4g4WzT+b9BJli7e37ijstJo/E1GDs+xtMvbjJAZvHJ9UFiITNOZS
         5zHqT+Vny61OrrUX24RQPyUJ0qVEY5nbMrfkkcn+RRRUExRev+B+Xqe+MPfoyOF7+xxC
         cWiGIrpUs2peC+OieaEUQR9KbzyWN6TQB0FtVQXxcCB5LSOrCds4B+1k/DOmEYHdI/z+
         Xfa2+7KD9OlT1Jpb/QTX4T/RJHnjisgB4rv9BmZIp69dNwxEOURZEWGCuJqwLWzy5z70
         ymow==
X-Gm-Message-State: AOAM530G/8vm2/bR+rIiC+oVpApKlXg9ut+u7HeZ0UxxQbr0GxBulMmj
        UKCY0/OZopQB11o5Kr/JXIIIRs0vPUY=
X-Google-Smtp-Source: ABdhPJyHniBgsghgZjB//lGvj5nz1YqjaBKR9ZEZZ2nKGP7t+QwlCAdzva9yQdEXnpi9Gds5MbvK5g==
X-Received: by 2002:ac2:4d4f:: with SMTP id 15mr3791625lfp.163.1596717213497;
        Thu, 06 Aug 2020 05:33:33 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id o23sm2658274lfr.67.2020.08.06.05.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 05:33:32 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1k3f5T-0003Cq-KO; Thu, 06 Aug 2020 14:33:36 +0200
Date:   Thu, 6 Aug 2020 14:33:35 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        patong.mxl@gmail.com, linus.walleij@linaro.org,
        mchehab+huawei@kernel.org
Subject: Re: [RESEND PATCH v4 1/3] usb: serial: Add MaxLinear/Exar USB to
 Serial driver
Message-ID: <20200806123335.GS3634@localhost>
References: <20200607162350.21297-1-mani@kernel.org>
 <20200607162350.21297-2-mani@kernel.org>
 <20200701103433.GC3334@localhost>
 <20200726154928.GA12036@Mani-XPS-13-9360>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200726154928.GA12036@Mani-XPS-13-9360>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 09:19:28PM +0530, Manivannan Sadhasivam wrote:
> Hi,
> 
> Sorry for the late reply!

No worries at all.

> On Wed, Jul 01, 2020 at 12:34:33PM +0200, Johan Hovold wrote:
> > On Sun, Jun 07, 2020 at 09:53:48PM +0530, Manivannan Sadhasivam wrote:
> > > Add support for MaxLinear/Exar USB to Serial converters. This driver
> > > only supports XR21V141X series but it can be extended to other series
> > > from Exar as well in future.
> > > 
> > > This driver is inspired from the initial one submitted by Patong Yang:
> > > 
> > > https://patchwork.kernel.org/patch/10543261/
> > 
> > You've also copied code from that driver so you need to maintain its
> > copyright as well.
> > 
> > Probably better you link to lore than patchwork. Do that in the file
> > header as well.
> > 
> > > While the initial driver was a custom tty USB driver exposing whole
> > > new serial interface ttyXRUSBn, this version is completely based on USB
> > > serial core thus exposing the interfaces as ttyUSBn. This will avoid
> > > the overhead of exposing a new USB serial interface which the userspace
> > > tools are unaware of.
> > > 
> > > Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > Tested-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> > > ---
> > >  drivers/usb/serial/Kconfig     |   9 +
> > >  drivers/usb/serial/Makefile    |   1 +
> > >  drivers/usb/serial/xr_serial.c | 650 +++++++++++++++++++++++++++++++++
> > >  3 files changed, 660 insertions(+)
> > >  create mode 100644 drivers/usb/serial/xr_serial.c

> > > +#define XR21V141X_CLOCK_DIVISOR_0	0x4
> > > +#define XR21V141X_CLOCK_DIVISOR_1	0x5
> > > +#define XR21V141X_CLOCK_DIVISOR_2	0x6
> > > +#define XR21V141X_TX_CLOCK_MASK_0	0x7
> > > +#define XR21V141X_TX_CLOCK_MASK_1	0x8
> > > +#define XR21V141X_RX_CLOCK_MASK_0	0x9
> > > +#define XR21V141X_RX_CLOCK_MASK_1	0xa
> > 
> > Please 0-pad these are they are registers.
> 
> You mean adding 0 after 0x?

Yes, exactly.

> > > +static int xr_attach(struct usb_serial *serial)
> > > +{
> > > +	/* Do not register tty device for the control interface */
> > > +	if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
> > > +		return 1;
> > 
> > Ok, so you went for my first suggestion here instead of explicitly
> > claiming the sibling interface.
> > 
> > I still think you should bind to the data interface and then explicitly
> > claim the control interface instead, since that better reflects that
> > these interfaces are used together (and allows for unbinding through
> > sysfs etc).
> 
> How about something like below?
> 
> static int xr_probe(struct usb_serial *serial, const struct usb_device_id *id)
> {
>         struct usb_device *usb_dev = interface_to_usbdev(serial->interface);
>         struct usb_driver *driver = serial->type->usb_driver;
>         struct usb_interface *control_interface;
> 
>         /* Don't bind to control interface */
>         if (serial->interface->cur_altsetting->desc.bInterfaceNumber == 0)
>                 return -ENODEV;
> 
>         /* But claim the control interface during data interface probe */
>         control_interface = usb_ifnum_to_if(usb_dev, 0);
>         if (usb_driver_claim_interface(driver, control_interface, NULL) != 0)
>                 dev_err(serial->interface->dev, "Can't claim control interface");
> 
>         return 0;
> }

Yes, something like that, but with error handling and a '\n' added to
the error message. ;)

Johan
