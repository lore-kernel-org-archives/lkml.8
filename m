Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E44CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 215FE2072E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXIhpuRo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgFWIJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731519AbgFWIJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:09:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57A9C061573;
        Tue, 23 Jun 2020 01:09:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id j18so2075374wmi.3;
        Tue, 23 Jun 2020 01:09:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qrM3mgIAu3PAw/VvP8u3kZd9W2W6kT+E5ciesUO/IF4=;
        b=uXIhpuRoky02yj+gvKs0OEYQUf6tj1aFlzImcx2bkmEOutQ+SMNdqOQ3F3po0pINJM
         9CxZPJFQBUfrLgXHSbYk0JcDlZpTJenNL7NEu2z41UBwcmWxxtiMbgbHCAnA+tR1C7Ad
         StgSH5/kKxCspTO4TtIuHn5w58pU5KK7EIb0LRuG/YV4768fliQB/9alH0nUIeP/Jf6X
         fo9IFBgMh9gIUjiQZEvPtEwCd8mLvyBqmNhKmOZNdBofsby7jYBadhHbvJI+GrP+HLes
         mokoJTFg1lTg5gV44MJWK30mBBVUcEPy/5/0x8+1ieffFMxqzTm7NY5R5XLGW2jqYZkp
         g3WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qrM3mgIAu3PAw/VvP8u3kZd9W2W6kT+E5ciesUO/IF4=;
        b=Kzp0QB067nsep8RIPAf9lEk3H+RER9+qMfGh7QUkyZXyt7KvOro+t/nyO6seQHWxC5
         a5lPwP7RM+KIeWmEp97dzUyGqfrMhSSubAhu+63U5RtuBUG/REASM9pk5q6cP879pJz7
         pLZEy99FIOX6LrTfXab+Zvz3Nj2WpQG1BOmm4szwqMzuhwfS4/MrNu8BMkQ+A1EiBAld
         cRfA0imvWWJiyddbJ7ldreah4V907fPJ/YlFHktp9Ant139EaQ7UnKKYOsAm4J7QLck8
         kZr/j3Dfx9CEOARFmfrH6q+jaQDTVp63tPYsTKmk+ATUsSziQG71xLEBXyB2jWB/Xqcw
         S+7w==
X-Gm-Message-State: AOAM532/bCpIvvgBjlqVBriqpWZhvRMEypVXsgklWhfawmhq5eKIGMZs
        XO1oQN2fETpbX2imKVBFpvzGduXnXmA+bOEqXvPzkC7m
X-Google-Smtp-Source: ABdhPJwovwBjjC0ANHrneljVz8SNsbBRNLyEOhA7DB0hJ2aj7aUXRwnjkijpGz4Nu26yjzCyVRYeDv1cECRXD6S0NLc=
X-Received: by 2002:a1c:7e52:: with SMTP id z79mr23772990wmc.104.1592899748217;
 Tue, 23 Jun 2020 01:09:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200616220403.1807003-1-james.hilliard1@gmail.com>
 <20200622085321.GA3334@localhost> <CADvTj4rOYs6F3J2A72GiWGbYW_Fu7VNCd0GpWaJ9it6tEt+4Hw@mail.gmail.com>
 <20200623075348.GD3334@localhost>
In-Reply-To: <20200623075348.GD3334@localhost>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Tue, 23 Jun 2020 02:08:57 -0600
Message-ID: <CADvTj4qn0nwyBY09pi5SZVuWHAZ65fVSUMA8QTAs1t0mYw6rmg@mail.gmail.com>
Subject: Re: [PATCH v2] USB: Serial: cypress_M8: Enable Simply Automated UPB PIM
To:     Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 1:53 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Mon, Jun 22, 2020 at 11:04:09AM -0600, James Hilliard wrote:
> > On Mon, Jun 22, 2020 at 2:53 AM Johan Hovold <johan@kernel.org> wrote:
> > >
> > > On Tue, Jun 16, 2020 at 04:04:03PM -0600, James Hilliard wrote:
> > > > This is a UPB(Universal Powerline Bus) PIM(Powerline Interface Module)
> > > > which allows for controlling multiple UPB compatible devices from
> > > > Linux using the standard serial interface.
> > > >
> > > > Based on vendor application source code there are two different models
> > > > of USB based PIM devices in addition to a number of RS232 based PIM's.
> > > >
> > > > The vendor UPB application source contains the following USB ID's:
> > > > #define USB_PCS_VENDOR_ID 0x04b4
> > > > #define USB_PCS_PIM_PRODUCT_ID 0x5500
> > > >
> > > > #define USB_SAI_VENDOR_ID 0x17dd
> > > > #define USB_SAI_PIM_PRODUCT_ID 0x5500
> > > >
> > > > The first set of ID's correspond to the PIM variant sold by Powerline
> > > > Control Systems while the second corresponds to the Simply Automated
> > > > Incorporated PIM. As the product ID for both of these match the default
> > > > cypress HID->COM RS232 product ID it assumed that they both use an
> > > > internal variant of this HID->COM RS232 converter hardware. However
> > > > as the vendor ID for the Simply Automated variant is different we need
> > > > to also add it to the cypress_M8 driver so that it is properly
> > > > detected.
> > > >
> > > > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > > > ---
> > > > Changes v1 -> v2:
> > > >   - Add more detailed commit message.
> > >
> > > Now applied, thanks.
> > >
> > > Would you mind posting the output of "lsusb -v" for this device for
> > > completeness?
> > Bus 001 Device 004: ID 17dd:5500
> > Device Descriptor:
> >   bLength                18
> >   bDescriptorType         1
> >   bcdUSB               1.00
> >   bDeviceClass            0
> >   bDeviceSubClass         0
> >   bDeviceProtocol         0
> >   bMaxPacketSize0         8
> >   idVendor           0x17dd
> >   idProduct          0x5500
> >   bcdDevice            0.00
> >   iManufacturer           1 Simply Automated Inc.
> >   iProduct                2 USB to Serial
> >   iSerial                 0
> >   bNumConfigurations      1
> >   Configuration Descriptor:
> >     bLength                 9
> >     bDescriptorType         2
> >     wTotalLength       0x0029
> >     bNumInterfaces          1
> >     bConfigurationValue     1
> >     iConfiguration          4 Sample HID
> >     bmAttributes         0x80
> >       (Bus Powered)
> >     MaxPower              100mA
> >     Interface Descriptor:
> >       bLength                 9
> >       bDescriptorType         4
> >       bInterfaceNumber        0
> >       bAlternateSetting       0
> >       bNumEndpoints           2
> >       bInterfaceClass         3
> >       bInterfaceSubClass      0
> >       bInterfaceProtocol      0
> >       iInterface              0
> >         HID Device Descriptor:
> >           bLength                 9
> >           bDescriptorType        33
> >           bcdHID               1.00
> >           bCountryCode            0 Not supported
> >           bNumDescriptors         1
> >           bDescriptorType        34 Report
> >           wDescriptorLength      37
> >          Report Descriptors:
> >            ** UNAVAILABLE **
>
> Thanks for posting this.
>
> Don't you need to add this device to the HID driver's ignore list
> to prevent it from claiming the device (see hid_ignore_list) just like
> for the Cypress VID?
Ah, yeah, that does look to be needed, do you want to edit my patch or
should I send a follow up patch with that added?
>
> Johan
