Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 087F7C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E044620776
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034573;
	bh=f0dcE6W115T5VxT/KN7MkC4LUM/7jojD1bWJ0yqovdc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cYlbVUiPu60N4kkjUlos/N5sXOVkvThZYpYVL7xfbBwAjxf0IJdkANoN+JXnUW8BH
	 BuWHZWGjDRh3AtfKE0bZ9T21s47VGPf9oVQB3MK2R+UGxbrR/Q+r8zuW5/XWfQvRn6
	 8S1hKKXWs8T2h76QUo3GJ2ncP+EYMMNWWW2HmJ6g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730004AbgFASCx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:02:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729973AbgFASCq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:02:46 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9CD52065C;
        Mon,  1 Jun 2020 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034566;
        bh=f0dcE6W115T5VxT/KN7MkC4LUM/7jojD1bWJ0yqovdc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2t0UgWvln2t8UzJJazTffGyqXAFI9FnkSskFxNNqwH7tJlrPig9KzZbgrd9i4TDWj
         4dy4bpEs9XqxYrux3pNEJgow6dE2QI5A7C32MCs2Q/KHrbbSZGIvHdsRhga0eEXPxI
         UUEWXx8c8w+Wkc8XXecViEOkVu/HfJR0RBDLGyVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Payne <marc.payne@mdpsys.co.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 11/95] r8152: support additional Microsoft Surface Ethernet Adapter variant
Date:   Mon,  1 Jun 2020 19:53:11 +0200
Message-Id: <20200601174022.649608320@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174020.759151073@linuxfoundation.org>
References: <20200601174020.759151073@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Payne <marc.payne@mdpsys.co.uk>

[ Upstream commit c27a204383616efba5a4194075e90819961ff66a ]

Device id 0927 is the RTL8153B-based component of the 'Surface USB-C to
Ethernet and USB Adapter' and may be used as a component of other devices
in future. Tested and working with the r8152 driver.

Update the cdc_ether blacklist due to the RTL8153 'network jam on suspend'
issue which this device will cause (personally confirmed).

Signed-off-by: Marc Payne <marc.payne@mdpsys.co.uk>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/usb/cdc_ether.c |   11 +++++++++--
 drivers/net/usb/r8152.c     |    1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -821,14 +821,21 @@ static const struct usb_device_id	produc
 	.driver_info = 0,
 },
 
-/* Microsoft Surface 3 dock (based on Realtek RTL8153) */
+/* Microsoft Surface Ethernet Adapter (based on Realtek RTL8153) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(MICROSOFT_VENDOR_ID, 0x07c6, USB_CLASS_COMM,
 			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
 	.driver_info = 0,
 },
 
-	/* TP-LINK UE300 USB 3.0 Ethernet Adapters (based on Realtek RTL8153) */
+/* Microsoft Surface Ethernet Adapter (based on Realtek RTL8153B) */
+{
+	USB_DEVICE_AND_INTERFACE_INFO(MICROSOFT_VENDOR_ID, 0x0927, USB_CLASS_COMM,
+			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
+	.driver_info = 0,
+},
+
+/* TP-LINK UE300 USB 3.0 Ethernet Adapters (based on Realtek RTL8153) */
 {
 	USB_DEVICE_AND_INTERFACE_INFO(TPLINK_VENDOR_ID, 0x0601, USB_CLASS_COMM,
 			USB_CDC_SUBCLASS_ETHERNET, USB_CDC_PROTO_NONE),
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -5344,6 +5344,7 @@ static const struct usb_device_id rtl815
 	{REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8153)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07c6)},
+	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3062)},


