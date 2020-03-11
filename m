Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,PDS_HP_HELO_NORDNS,RDNS_NONE,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46681 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730020AbgCKPyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 11:54:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id y30so1418212pga.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 08:54:17 -0700 (PDT)
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To: marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc: linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v6 5/5] Bluetooth: Add mgmt op set_wake_capable
Date: Wed, 11 Mar 2020 08:54:04 -0700
Message-Id: <20200311085359.RFC.v6.5.I797e2f4cb824299043e771f3ab9cef86ee09f4db@changeid>
In-Reply-To: <20200311155404.209990-1-abhishekpandit@chromium.org>
References: <20200311155404.209990-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

When the system is suspended, only some connected Bluetooth devices
cause user input that should wake the system (mostly HID devices). Add
a list to keep track of devices that can wake the system and add
a management API to let userspace tell the kernel whether a device is
wake capable or not. For LE devices, the wakeable property is added to
the connection parameter and can only be modified after calling
add_device.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v6: None
Changes in v5:
* Wakeable entries moved to other commits
* Patch moved to end of series

Changes in v4: None
Changes in v3:
* Added wakeable property to le_conn_param
* Use wakeable list for BR/EDR and wakeable property for LE

Changes in v2: None

 include/net/bluetooth/mgmt.h |  7 +++++
 net/bluetooth/mgmt.c         | 51 ++++++++++++++++++++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f41cd87550dc..17bbdcbeb67e 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -674,6 +674,13 @@ struct mgmt_cp_set_blocked_keys {
 
 #define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
 
+#define MGMT_OP_SET_WAKE_CAPABLE	0x0048
+#define MGMT_SET_WAKE_CAPABLE_SIZE	8
+struct mgmt_cp_set_wake_capable {
+	struct mgmt_addr_info addr;
+	u8 wake_capable;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170e..96f9f9f4086d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -108,6 +108,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_APPEARANCE,
 	MGMT_OP_SET_BLOCKED_KEYS,
 	MGMT_OP_SET_WIDEBAND_SPEECH,
+	MGMT_OP_SET_WAKE_CAPABLE,
 };
 
 static const u16 mgmt_events[] = {
@@ -4768,6 +4769,48 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_wake_capable(struct sock *sk, struct hci_dev *hdev, void *data,
+			    u16 len)
+{
+	struct mgmt_cp_set_wake_capable *cp = data;
+	struct hci_conn_params *params;
+	int err;
+	u8 status = MGMT_STATUS_FAILED;
+	u8 addr_type = cp->addr.type == BDADDR_BREDR ?
+			       cp->addr.type :
+			       le_addr_type(cp->addr.type);
+
+	bt_dev_dbg(hdev, "Set wake capable %pMR (type 0x%x) = 0x%x\n",
+		   &cp->addr.bdaddr, addr_type, cp->wake_capable);
+
+	if (cp->addr.type == BDADDR_BREDR) {
+		if (cp->wake_capable)
+			err = hci_bdaddr_list_add(&hdev->wakeable,
+						  &cp->addr.bdaddr, addr_type);
+		else
+			err = hci_bdaddr_list_del(&hdev->wakeable,
+						  &cp->addr.bdaddr, addr_type);
+
+		if (!err || err == -EEXIST || err == -ENOENT)
+			status = MGMT_STATUS_SUCCESS;
+
+		goto done;
+	}
+
+	/* Add wakeable param to le connection parameters */
+	params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr, addr_type);
+	if (params) {
+		params->wakeable = cp->wake_capable;
+		status = MGMT_STATUS_SUCCESS;
+	}
+
+done:
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_WAKE_CAPABLE, status,
+				cp, sizeof(*cp));
+
+	return err;
+}
+
 static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -5896,6 +5939,13 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 			err = hci_bdaddr_list_del(&hdev->whitelist,
 						  &cp->addr.bdaddr,
 						  cp->addr.type);
+
+			/* Don't check result since it either succeeds or device
+			 * wasn't there (not wakeable or invalid params as
+			 * covered by deleting from whitelist).
+			 */
+			hci_bdaddr_list_del(&hdev->wakeable, &cp->addr.bdaddr,
+					    cp->addr.type);
 			if (err) {
 				err = mgmt_cmd_complete(sk, hdev->id,
 							MGMT_OP_REMOVE_DEVICE,
@@ -7099,6 +7149,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ set_wideband_speech,	   MGMT_SETTING_SIZE },
+	{ set_wake_capable,	   MGMT_SET_WAKE_CAPABLE_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.25.1.481.gfbce0eb801-goog

