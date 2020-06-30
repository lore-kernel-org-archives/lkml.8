Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144CBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB647206EB
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:11:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729512AbgF3NLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:11:08 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:53132 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgF3NLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:11:04 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 05UD9m3N2022713, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 05UD9m3N2022713
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 30 Jun 2020 21:09:48 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 21:09:48 +0800
Received: from localhost.localdomain (172.21.87.237) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 30 Jun 2020 21:09:47 +0800
From:   <hildawu@realtek.com>
To:     <marcel@holtmann.org>
CC:     <johan.hedberg@gmail.com>, <matthias.bgg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>, <max.chou@realtek.com>,
        <alex_lu@realsil.com.cn>, <kidman@realtek.com>
Subject: [PATCH v2] Bluetooth: btusb: USB alternate setting 1 for WBS
Date:   Tue, 30 Jun 2020 21:09:40 +0800
Message-ID: <20200630130940.14339-1-hildawu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.87.237]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hilda Wu <hildawu@realtek.com>

RTL8822CE supports transparent WBS to apply USB alternate setting 1.
Add a flag to the device match data to apply alternate setting 1 which
meet the transfer speed for WBS support.

Signed-off-by: Hilda Wu <hildawu@realtek.com>
---
Changes in v2:
- More descriptive commit log and short description.
- Use BTUSB_USE_ALT1_FOR_WBS replace BTUSB_WBS_ALT1 for descriptive name.
- Move alternate setting 1 check into the btusb_probe() function and adjust position of data->isoc for alternate setting check.
---
---
 drivers/bluetooth/btusb.c | 34 ++++++++++++++++++++--------------
 1 file changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c7cc8e594166..e4a12c58501e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -453,6 +453,7 @@ static const struct dmi_system_id btusb_needs_reset_resume_table[] = {
 #define BTUSB_HW_RESET_ACTIVE	12
 #define BTUSB_TX_WAIT_VND_EVT	13
 #define BTUSB_WAKEUP_DISABLE	14
+#define BTUSB_USE_ALT1_FOR_WBS	15
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1666,14 +1667,15 @@ static void btusb_work(struct work_struct *work)
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
+			} else if (test_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags)) {
+				new_alts = 1;
+			} else {
 				bt_dev_err(hdev, "Device does not support ALT setting 6");
+			}
 		}
 
 		if (btusb_switch_alt_setting(hdev, new_alts) < 0)
@@ -3954,6 +3956,15 @@ static int btusb_probe(struct usb_interface *intf,
 		btusb_check_needs_reset_resume(intf);
 	}
 
+	if (id->driver_info & BTUSB_AMP) {
+		/* AMP controllers do not support SCO packets */
+		data->isoc = NULL;
+	} else {
+		/* Interface orders are hardcoded in the specification */
+		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
+		data->isoc_ifnum = ifnum_base + 1;
+	}
+
 	if (IS_ENABLED(CONFIG_BT_HCIBTUSB_RTL) &&
 	    (id->driver_info & BTUSB_REALTEK)) {
 		hdev->setup = btrtl_setup_realtek;
@@ -3965,21 +3976,16 @@ static int btusb_probe(struct usb_interface *intf,
 		 * (DEVICE_REMOTE_WAKEUP)
 		 */
 		set_bit(BTUSB_WAKEUP_DISABLE, &data->flags);
+		if (btusb_find_altsetting(data, 1))
+			set_bit(BTUSB_USE_ALT1_FOR_WBS, &data->flags);
+		else
+			bt_dev_err(hdev, "Device does not support ALT setting 1");
 
 		err = usb_autopm_get_interface(intf);
 		if (err < 0)
 			goto out_free_dev;
 	}
 
-	if (id->driver_info & BTUSB_AMP) {
-		/* AMP controllers do not support SCO packets */
-		data->isoc = NULL;
-	} else {
-		/* Interface orders are hardcoded in the specification */
-		data->isoc = usb_ifnum_to_if(data->udev, ifnum_base + 1);
-		data->isoc_ifnum = ifnum_base + 1;
-	}
-
 	if (!reset)
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
-- 
2.17.1

