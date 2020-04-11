Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A2DBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 150102078E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 05:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725945AbgDKF4j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 01:56:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:34536 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbgDKF4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 01:56:39 -0400
Received: from marcel-macbook.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7699ECED16;
        Sat, 11 Apr 2020 08:06:13 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH v2 1/1] Bluetooth: btrtl: Add support for RTL8761B
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <bb48d88a-3b4f-dfa6-bbed-777a76d072ed@gmail.com>
Date:   Sat, 11 Apr 2020 07:56:37 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Bluetooth Kernel Mailing List 
        <linux-bluetooth@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, icenowy@aosc.io
Content-Transfer-Encoding: 8BIT
Message-Id: <3E2F3893-FA3E-4C58-AD0C-879C7A3DD30E@holtmann.org>
References: <20200410145420.108868-1-sztsian@gmail.com>
 <20200410145420.108868-2-sztsian@gmail.com>
 <5CD9EBAA-44A6-4DFF-870E-4F862FB7A60E@holtmann.org>
 <bb48d88a-3b4f-dfa6-bbed-777a76d072ed@gmail.com>
To:     Zamir SUN <sztsian@gmail.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zamir,

>>> Add new compatible device RTL8761B.
>>> 
>>> Signed-off-by: Ziqian SUN (Zamir) <sztsian@gmail.com>
>>> ---
>>> drivers/bluetooth/btrtl.c | 10 +++++++++-
>>> 1 file changed, 9 insertions(+), 1 deletion(-)
>> can you also please include the content of /sys/kernel/debug/usb/devices for this device in the commit message.
>> And if you run btmon before plugging it in, I like to see what LE Features of Bluetooth 5.0 this dongle really offers.
> 
> Hi Marcel,
> 
> I think you want this section
> 
>        Supported settings: 0x0001bfff
>          Powered
>          Connectable
>          Fast Connectable
>          Discoverable
>          Bondable
>          Link Security
>          Secure Simple Pairing
>          BR/EDR
>          High Speed
>          Low Energy
>          Advertising
>          Secure Connections
>          Debug Keys
>          Privacy
>          Static Address
>          PHY Configuration
> 
> Full log of btmon is available here, with the mac address masked http://fars.ee/Lu85
> 
> I'll send a v3 to include the usb info in the commit message shortly.

This hardware is funny. Before the firmware patching it says this:

< HCI Command: Read Local Version In.. (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
      Read Local Version Information (0x04|0x0001) ncmd 2
        Status: Success (0x00)
        HCI version: Bluetooth 5.1 (0x0a) - Revision 11 (0x000b)
        LMP version: Bluetooth 5.1 (0x0a) - Subversion 34657 (0x8761)
        Manufacturer: Realtek Semiconductor Corporation (93)

And after the firmware patching it downgrades to Bluetooth 5.0 standard:

< HCI Command: Read Local Version... (0x04|0x0001) plen 0
> HCI Event: Command Complete (0x0e) plen 12
      Read Local Version Information (0x04|0x0001) ncmd 2
        Status: Success (0x00)
        HCI version: Bluetooth 5.0 (0x09) - Revision 55448 (0xd898)
        LMP version: Bluetooth 5.0 (0x09) - Subversion 50044 (0xc37c)
        Manufacturer: Realtek Semiconductor Corporation (93)

Anyway, I was after these LE Features:

< HCI Command: LE Read Local Suppo.. (0x08|0x0003) plen 0
> HCI Event: Command Complete (0x0e) plen 12
      LE Read Local Supported Features (0x08|0x0003) ncmd 2
        Status: Success (0x00)
        Features: 0xfd 0x5f 0x00 0x00 0x00 0x00 0x00 0x00
          LE Encryption
          Extended Reject Indication
          Slave-initiated Features Exchange
          LE Ping
          LE Data Packet Length Extension
          LL Privacy
          Extended Scanner Filter Policies
          LE 2M PHY
          Stable Modulation Index - Transmitter
          Stable Modulation Index - Receiver
          LE Coded PHY
          LE Extended Advertising
          Channel Selection Algorithm #2

This seems to be a genuine USB dongle with Bluetooth 5.0 features.

Regards

Marcel

