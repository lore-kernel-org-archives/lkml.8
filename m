Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C7B8C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C73F20872
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 18:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591034851;
	bh=pfcGmj5nONLg8d3yahc7JfKten971wfqBGm95XtwZMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YVFZzpaNLmjcyJObfe0ivS1wgjJ0fH/W6H5bgDTC0Dhekj5bS9g+1Erj8XfYr3Fzd
	 QaD6uMpIISFwNphJgUN6STqJQrzToKqg85BQg1o1PhlTr2JsecGsyXBXQ87c6Tlg92
	 it5hHF0V775jadh07XAWSM2PHvg5tqxxFw5vsXE8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730591AbgFASHa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 14:07:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:52646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730505AbgFASGz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 14:06:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1F9242158C;
        Mon,  1 Jun 2020 18:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591034813;
        bh=pfcGmj5nONLg8d3yahc7JfKten971wfqBGm95XtwZMs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DzSERNyA06Wv22FpV7EuYWhV3jrQUcwLjL3jnKRpwrPSOGixD0I35y/JcCAUa5FOD
         ZXaB1Nz0A8M3AqCr6+u0E0N/YxHM6u+cjb6ciipO9v5OdpZFCMYPSTtX7/0CVx97oz
         kZdjb57oj3dqoDAG+TSPa3ZohnqZJ0SfzDydVe0k=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Marc Payne <marc.payne@mdpsys.co.uk>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 017/142] r8152: support additional Microsoft Surface Ethernet Adapter variant
Date:   Mon,  1 Jun 2020 19:52:55 +0200
Message-Id: <20200601174039.675289427@linuxfoundation.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601174037.904070960@linuxfoundation.org>
References: <20200601174037.904070960@linuxfoundation.org>
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
@@ -808,14 +808,21 @@ static const struct usb_device_id	produc
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
@@ -5837,6 +5837,7 @@ static const struct usb_device_id rtl815
 	{REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8153)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07c6)},
+	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3062)},


