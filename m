Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05DFBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFB3D20771
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 07:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592898835;
	bh=FY0gG9an0Bpgrfx22y41033NMyUZ7t83bH1KTUVJ2RI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Z8qKQXasuZVU4mynaTwS/C6/ZzZrxkp4u0jTgyNbjkneA8wBd4XXTlGwMKxiAeIQN
	 i75TQbBaBSo1cj9YyiKkyUVdj/q0lmiSBWuH/tMNqEFVC3UxQEYLdYEi5FNn6Lhfxa
	 azPL8SiHrDm6tIONWBHo55jM9d7CyoL8aVuQLzww=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731547AbgFWHxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 03:53:54 -0400
Received: from mail-lj1-f176.google.com ([209.85.208.176]:40604 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731158AbgFWHxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 03:53:53 -0400
Received: by mail-lj1-f176.google.com with SMTP id n23so22284766ljh.7;
        Tue, 23 Jun 2020 00:53:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VH2f8geP5bsEeviiLJElCQbL4T/ZyD7yVRFLLYJHgAE=;
        b=JwnrqjQNipKc8sxqbHzLIwHcvmjUMnWy+FOi9l0CrePM3BkLqVxgXOjCo+L+HGMQs9
         1MIsr/zdG3pEXyntr3m4DTqj3A0CBQMMXsobb/2dkykUqZqvgJDHkigeKXx1+6WlIQrJ
         Zz3BzLjHk2UjYRtP5u+YLBvP+DSbrW26fOfLa27z24mVrCDm07TPDy7meYcNb9YgB49z
         nngYsy1+95vPW74l9qs+Jm0l8yYSi3miXy3utZC9fufFlA5MG4mvuylI4Xp5qllZuhwN
         TKLgMNoojNpISjvzejSqnJslf7MB41AhIKrcyywvNMN+DOvOJ3IegvnK+e4mIRDHbsXH
         o7aQ==
X-Gm-Message-State: AOAM532zmfKMBl1ldHohO+ycVc9QMTHJ4JrzZ8FNhUx8ctoq1KaXEtsi
        su9VhboXZdhFA4RfV+l/5fk=
X-Google-Smtp-Source: ABdhPJy0uxWFjhCG4fPkYjOPRME5QUJ/s+7E9N0EkLfgzE3/FRTnH8tDUdNcwAfbB1pd9R0Gr+3rqg==
X-Received: by 2002:a2e:b612:: with SMTP id r18mr9907331ljn.195.1592898830897;
        Tue, 23 Jun 2020 00:53:50 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id y188sm4661722lfc.36.2020.06.23.00.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 00:53:49 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jndka-0000gZ-FF; Tue, 23 Jun 2020 09:53:49 +0200
Date:   Tue, 23 Jun 2020 09:53:48 +0200
From:   Johan Hovold <johan@kernel.org>
To:     James Hilliard <james.hilliard1@gmail.com>
Cc:     Johan Hovold <johan@kernel.org>, linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2] USB: Serial: cypress_M8: Enable Simply Automated UPB
 PIM
Message-ID: <20200623075348.GD3334@localhost>
References: <20200616220403.1807003-1-james.hilliard1@gmail.com>
 <20200622085321.GA3334@localhost>
 <CADvTj4rOYs6F3J2A72GiWGbYW_Fu7VNCd0GpWaJ9it6tEt+4Hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADvTj4rOYs6F3J2A72GiWGbYW_Fu7VNCd0GpWaJ9it6tEt+4Hw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 11:04:09AM -0600, James Hilliard wrote:
> On Mon, Jun 22, 2020 at 2:53 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Tue, Jun 16, 2020 at 04:04:03PM -0600, James Hilliard wrote:
> > > This is a UPB(Universal Powerline Bus) PIM(Powerline Interface Module)
> > > which allows for controlling multiple UPB compatible devices from
> > > Linux using the standard serial interface.
> > >
> > > Based on vendor application source code there are two different models
> > > of USB based PIM devices in addition to a number of RS232 based PIM's.
> > >
> > > The vendor UPB application source contains the following USB ID's:
> > > #define USB_PCS_VENDOR_ID 0x04b4
> > > #define USB_PCS_PIM_PRODUCT_ID 0x5500
> > >
> > > #define USB_SAI_VENDOR_ID 0x17dd
> > > #define USB_SAI_PIM_PRODUCT_ID 0x5500
> > >
> > > The first set of ID's correspond to the PIM variant sold by Powerline
> > > Control Systems while the second corresponds to the Simply Automated
> > > Incorporated PIM. As the product ID for both of these match the default
> > > cypress HID->COM RS232 product ID it assumed that they both use an
> > > internal variant of this HID->COM RS232 converter hardware. However
> > > as the vendor ID for the Simply Automated variant is different we need
> > > to also add it to the cypress_M8 driver so that it is properly
> > > detected.
> > >
> > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > ---
> > > Changes v1 -> v2:
> > >   - Add more detailed commit message.
> >
> > Now applied, thanks.
> >
> > Would you mind posting the output of "lsusb -v" for this device for
> > completeness?
> Bus 001 Device 004: ID 17dd:5500
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               1.00
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0         8
>   idVendor           0x17dd
>   idProduct          0x5500
>   bcdDevice            0.00
>   iManufacturer           1 Simply Automated Inc.
>   iProduct                2 USB to Serial
>   iSerial                 0
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x0029
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          4 Sample HID
>     bmAttributes         0x80
>       (Bus Powered)
>     MaxPower              100mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         3
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.00
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength      37
>          Report Descriptors:
>            ** UNAVAILABLE **

Thanks for posting this.

Don't you need to add this device to the HID driver's ignore list
to prevent it from claiming the device (see hid_ignore_list) just like
for the Cypress VID?

Johan
