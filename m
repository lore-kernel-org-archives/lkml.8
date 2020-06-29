Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84E27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59780208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388192AbgF2VYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:24:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34467 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729349AbgF2SuQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:16 -0400
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05T63kQL2014575, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05T63kQL2014575
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 29 Jun 2020 14:03:46 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 14:03:46 +0800
Received: from localhost.localdomain (172.21.87.237) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 29 Jun 2020 14:03:46 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <matthias.bgg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>, <kidman@realtek.com>
Subject: [PATCH] Bluetooth: btusb: WBS support USB alternate setting 1
Date:   Mon, 29 Jun 2020 14:03:38 +0800
Message-ID: <20200629060338.10705-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.87.237]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

For WBS support, btusb driver could be set to alternate setting 1.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
 drivers/bluetooth/btusb.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c7cc8e594166..7942f9314fd7 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -453,6 +453,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_DISABLE	14
+#define BTUSB_WBS_ALT1		15
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1666,14 +1667,18 @@ static void btusb_work(struct work_struct *work)
 				new_alts = data->sco_num;
 			}
 		} else if (data->air_mode == HCI_NOTIFY_ENABLE_SCO_TRANSP) {
-
-			data->usb_alt6_packet_flow = true;
-
 			/* Check if Alt 6 is supported for Transparent audio */
-			if (btusb_find_altsetting(data, 6))
+			if (btusb_find_altsetting(data, 6)) {
+				data->usb_alt6_packet_flow = true;
 				new_alts = 6;
-			else
+			} else if (test_bit(BTUSB_WBS_ALT1, &data->flags)) {
+				if (btusb_find_altsetting(data, 1))
+					new_alts = 1;
+				else
+					bt_dev_err(hdev, "Device does not support ALT setting 1");
+			} else {
 				bt_dev_err(hdev, "Device does not support ALT setting 6");
+			}
 		}
 
 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
@@ -3965,6 +3970,7 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+		set_bit(BTUSB_WBS_ALT1, &data->flags);
 
 		err = usb_autopm_get_interface(intf);
 		if (err < 0)
-- 
2.17.1

