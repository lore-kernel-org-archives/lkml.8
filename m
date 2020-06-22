Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB28C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8571320707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:04:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBbD4AKK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729808AbgFVREY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgFVREX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:04:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D33DC061573;
        Mon, 22 Jun 2020 10:04:22 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id q5so5049543wru.6;
        Mon, 22 Jun 2020 10:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/YZmxJHhtEEJpXAJrYVtI3xkqXDiS8o7ELQWSGYDdQ4=;
        b=jBbD4AKKTlfxveLKvJ3n8gvN7zOp7mztpZckngE9wTLFNwXqnsfDkXWiJqqKQWgbAs
         L6dXmHnZaEwlDgYyA9KEa1tvJY5vB2DeBNALgmY/GJaDjzzF2a7MYftY4/D+AF69eH3u
         mao68Pi9jJKjjg+mV1ihC+ieKjXycnYfdPRRxkiSToyEvAC5g09ZK4RMhggAzVPBxGgn
         sccG9Nra+7qE04tAO5iZhZ9WsJ49xLRHirEQK4ub9MsV7MX5VWo0fP6AlFo3fZ7WC7Qq
         X3ib3mttnoeiUN+IinUIoSNfi8n0Rf0T2xurPPSX7tP+dvb1/3Xj7A0w4P/TEfQGApHS
         CQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/YZmxJHhtEEJpXAJrYVtI3xkqXDiS8o7ELQWSGYDdQ4=;
        b=Oqg3mhnan4b+36QUXBiQxA/QybjUPgLacZN7zxZTbNC7U5gMAr62Ti8U/bKDTfGtnB
         9IQLqfHWPVA38X4xZXdaFV3K7bdKUhCFh4z7FpvRdrdtguAM5pNSOD3xxZZZQtIuFym2
         NfE9B2qmZVikMdv0fkaAEJ84IZEF3w27cEEKB1oEOrauFmmfXgqYibmxyD10+xgPuK4l
         d+RhwEjcBzhxtpde9lhHDXrwbFNcfLedFHwV7R48xqulwdH2LKH3Bdpt2bPsRF0mrvG3
         AuW88rD8LA5b86OWiYQ26sUq8QB+YoyHW3nxNDTBs4IbBdmWsvY1kVeN6hawDH324zT6
         4HMA==
X-Gm-Message-State: AOAM53295BtWQ94BEo8YIjrZJMyjnaSvxDDyMv19FAiU02msiybmsnXL
        hTsR847JkUzQRiKSoUE91oxbs9MYnwpFYJzZ13yabS2qK0I=
X-Google-Smtp-Source: ABdhPJzuX5VTbn+UwgvL2wwzS49Z8KZe9AvBqyoNF++74pjXJiF08eyOSUE+r/vnqoS5O8wwB/GoBC/kIkgxlSeHygI=
X-Received: by 2002:a5d:610a:: with SMTP id v10mr1796254wrt.108.1592845460681;
 Mon, 22 Jun 2020 10:04:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200616220403.1807003-1-james.hilliard1@gmail.com> <20200622085321.GA3334@localhost>
In-Reply-To: <20200622085321.GA3334@localhost>
From:   James Hilliard <james.hilliard1@gmail.com>
Date:   Mon, 22 Jun 2020 11:04:09 -0600
Message-ID: <CADvTj4rOYs6F3J2A72GiWGbYW_Fu7VNCd0GpWaJ9it6tEt+4Hw@mail.gmail.com>
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

On Mon, Jun 22, 2020 at 2:53 AM Johan Hovold <johan@kernel.org> wrote:
>
> On Tue, Jun 16, 2020 at 04:04:03PM -0600, James Hilliard wrote:
> > This is a UPB(Universal Powerline Bus) PIM(Powerline Interface Module)
> > which allows for controlling multiple UPB compatible devices from
> > Linux using the standard serial interface.
> >
> > Based on vendor application source code there are two different models
> > of USB based PIM devices in addition to a number of RS232 based PIM's.
> >
> > The vendor UPB application source contains the following USB ID's:
> > #define USB_PCS_VENDOR_ID 0x04b4
> > #define USB_PCS_PIM_PRODUCT_ID 0x5500
> >
> > #define USB_SAI_VENDOR_ID 0x17dd
> > #define USB_SAI_PIM_PRODUCT_ID 0x5500
> >
> > The first set of ID's correspond to the PIM variant sold by Powerline
> > Control Systems while the second corresponds to the Simply Automated
> > Incorporated PIM. As the product ID for both of these match the default
> > cypress HID->COM RS232 product ID it assumed that they both use an
> > internal variant of this HID->COM RS232 converter hardware. However
> > as the vendor ID for the Simply Automated variant is different we need
> > to also add it to the cypress_M8 driver so that it is properly
> > detected.
> >
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
> > Changes v1 -> v2:
> >   - Add more detailed commit message.
>
> Now applied, thanks.
>
> Would you mind posting the output of "lsusb -v" for this device for
> completeness?
Bus 001 Device 004: ID 17dd:5500
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               1.00
  bDeviceClass            0
  bDeviceSubClass         0
  bDeviceProtocol         0
  bMaxPacketSize0         8
  idVendor           0x17dd
  idProduct          0x5500
  bcdDevice            0.00
  iManufacturer           1 Simply Automated Inc.
  iProduct                2 USB to Serial
  iSerial                 0
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength       0x0029
    bNumInterfaces          1
    bConfigurationValue     1
    iConfiguration          4 Sample HID
    bmAttributes         0x80
      (Bus Powered)
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass         3
      bInterfaceSubClass      0
      bInterfaceProtocol      0
      iInterface              0
        HID Device Descriptor:
          bLength                 9
          bDescriptorType        33
          bcdHID               1.00
          bCountryCode            0 Not supported
          bNumDescriptors         1
          bDescriptorType        34 Report
          wDescriptorLength      37
         Report Descriptors:
           ** UNAVAILABLE **
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0008  1x 8 bytes
        bInterval              10
can't get debug descriptor: Resource temporarily unavailable
Device Status:     0x0000
  (Bus Powered)
>
> Johan
