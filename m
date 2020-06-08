Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91554C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:26:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B64E207ED
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 00:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591662381;
	bh=BSyonC01oOJYjmrWgRtX+/RL9lb+1Yqc92A7PwcFbRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WrEMcXpaluWgtjV3Dt1Ok7Uxka9XIz0q4UHky+gkkfsQce3ZkHLoCMwPKyNgAhSe3
	 lLe07oE1+MKcZCVug0nCCOWPgRVjaQ6IkG2qFFkd2WzxN934akI9/TsLu3QN/Eoix3
	 VvbBBaP4sVMjQEntU3R8zcZhwqtQkbPio5pHeAOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733062AbgFIA0S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 20:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:38202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730343AbgFHXQr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 19:16:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 594F220775;
        Mon,  8 Jun 2020 23:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591658207;
        bh=BSyonC01oOJYjmrWgRtX+/RL9lb+1Yqc92A7PwcFbRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FfsQ7hs4K9ReujV9aUh3DDpCwDbWYzpps63aDatXg4mQx8C28QgMo3FIMXCBHUKp1
         zr56vJU/gej3f6FI9AkPCYZd9xY8ORKUS6xmPuMA3dNLOEf3Nzal67p/emd0tDJQU+
         pB4kmK6DzjbEDVzAf44nNOBabfotNdbRyIGWguQQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Payne <marc.payne@mdpsys.co.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 225/606] r8152: support additional Microsoft Surface Ethernet Adapter variant
Date:   Mon,  8 Jun 2020 19:05:50 -0400
Message-Id: <20200608231211.3363633-225-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
 drivers/net/usb/cdc_ether.c | 11 +++++++++--
 drivers/net/usb/r8152.c     |  1 +
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ether.c b/drivers/net/usb/cdc_ether.c
index 0cdb2ce47645..a657943c9f01 100644
--- a/drivers/net/usb/cdc_ether.c
+++ b/drivers/net/usb/cdc_ether.c
@@ -815,14 +815,21 @@ static const struct usb_device_id	products[] = {
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
diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 95b19ce96513..7c8c45984a5c 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -6901,6 +6901,7 @@ static const struct usb_device_id rtl8152_table[] = {
 	{REALTEK_USB_DEVICE(VENDOR_ID_REALTEK, 0x8153)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07ab)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x07c6)},
+	{REALTEK_USB_DEVICE(VENDOR_ID_MICROSOFT, 0x0927)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_SAMSUNG, 0xa101)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x304f)},
 	{REALTEK_USB_DEVICE(VENDOR_ID_LENOVO,  0x3062)},
-- 
2.25.1

