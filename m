Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CFBC352A2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7066121741
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 15:14:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbgBFPON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 10:14:13 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:59640 "HELO
        iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S1727389AbgBFPOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 10:14:12 -0500
Received: (qmail 2315 invoked by uid 2102); 6 Feb 2020 10:14:11 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 6 Feb 2020 10:14:11 -0500
Date:   Thu, 6 Feb 2020 10:14:11 -0500 (EST)
From:   Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To:     "Enderborg, Peter" <Peter.Enderborg@sony.com>
cc:     Jiri Kosina <jikos@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.4 17/78] HID: Fix slab-out-of-bounds read in
 hid_field_extract (Broken!)
In-Reply-To: <e80973cc-812a-df52-c54a-8edf500c0c75@sony.com>
Message-ID: <Pine.LNX.4.44L0.2002061011140.1503-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Feb 2020, Enderborg, Peter wrote:

> > Also, please post the output from "lsusb -v" for the StreamDeck.
> 
> Bus 002 Device 008: ID 0fd9:0060 Elgato Systems GmbH Stream Deck
> Device Descriptor:
>   bLength                18
>   bDescriptorType         1
>   bcdUSB               2.00
>   bDeviceClass            0
>   bDeviceSubClass         0
>   bDeviceProtocol         0
>   bMaxPacketSize0        64
>   idVendor           0x0fd9 Elgato Systems GmbH
>   idProduct          0x0060
>   bcdDevice            1.00
>   iManufacturer           1
>   iProduct                2
>   iSerial                 3
>   bNumConfigurations      1
>   Configuration Descriptor:
>     bLength                 9
>     bDescriptorType         2
>     wTotalLength       0x0029
>     bNumInterfaces          1
>     bConfigurationValue     1
>     iConfiguration          0
>     bmAttributes         0xe0
>       Self Powered
>       Remote Wakeup
>     MaxPower              400mA
>     Interface Descriptor:
>       bLength                 9
>       bDescriptorType         4
>       bInterfaceNumber        0
>       bAlternateSetting       0
>       bNumEndpoints           2
>       bInterfaceClass         3 Human Interface Device
>       bInterfaceSubClass      0
>       bInterfaceProtocol      0
>       iInterface              0
>         HID Device Descriptor:
>           bLength                 9
>           bDescriptorType        33
>           bcdHID               1.11
>           bCountryCode            0 Not supported
>           bNumDescriptors         1
>           bDescriptorType        34 Report
>           wDescriptorLength     248
>          Report Descriptors:
>            ** UNAVAILABLE **

I was hoping to see the report descriptors.  This would produce the 
actual descriptors as sent by the device, not the kernel's 
interpretation or modification of the descriptors.

I guess you have to unbind the device from the usbhid driver first in
order for lsusb to get them.  Can you do that?

Alan Stern

