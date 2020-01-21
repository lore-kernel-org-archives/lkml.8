Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A365BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:43:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 766BC24655
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 12:43:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbgAUMm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 07:42:57 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:54693 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729714AbgAUMmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 07:42:53 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 00LCgnbX010998, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 00LCgnbX010998
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 21 Jan 2020 20:42:49 +0800
Received: from fc30.localdomain (172.21.177.138) by RTITCASV01.realtek.com.tw
 (172.21.6.18) with Microsoft SMTP Server id 14.3.468.0; Tue, 21 Jan 2020
 20:42:47 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <netdev@vger.kernel.org>
CC:     <nic_swsd@realtek.com>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <pmalani@chromium.org>,
        <grundler@chromium.org>, Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net 2/9] r8152: reset flow control patch when linking on for RTL8153B
Date:   Tue, 21 Jan 2020 20:40:28 +0800
Message-ID: <1394712342-15778-340-Taiwan-albertk@realtek.com>
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <1394712342-15778-338-Taiwan-albertk@realtek.com>
References: <1394712342-15778-338-Taiwan-albertk@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.177.138]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When linking ON, the patch of flow control has to be reset. This
makes sure the patch works normally.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 115559707683..64efd58279b3 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -2857,6 +2857,7 @@ static void r8153_set_rx_early_size(struct r8152 *tp)
 
 static int rtl8153_enable(struct r8152 *tp)
 {
+	u32 ocp_data;
 	if (test_bit(RTL8152_UNPLUG, &tp->flags))
 		return -ENODEV;
 
@@ -2865,6 +2866,15 @@ static int rtl8153_enable(struct r8152 *tp)
 	r8153_set_rx_early_timeout(tp);
 	r8153_set_rx_early_size(tp);
 
+	if (tp->version == RTL_VER_09) {
+		ocp_data = ocp_read_word(tp, MCU_TYPE_USB, USB_FW_TASK);
+		ocp_data &= ~FC_PATCH_TASK;
+		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+		usleep_range(1000, 2000);
+		ocp_data |= FC_PATCH_TASK;
+		ocp_write_word(tp, MCU_TYPE_USB, USB_FW_TASK, ocp_data);
+	}
+
 	return rtl_enable(tp);
 }
 
-- 
2.21.0

