Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4184C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AB020828
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MCQYn/yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387487AbgCDBHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:07:01 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:40877 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387400AbgCDBHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:07:00 -0500
Received: by mail-pf1-f194.google.com with SMTP id l184so53948pfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5tQW6IIZTiEE/7w7rYSblz9K9YpAzfJmG3Peiq+HwDA=;
        b=MCQYn/yzbQrMb2XpoV29yJVfl32waAjnAgA+oSz2g3tayVCQ15PO7CCm+xgfx8V19y
         /caLRvZhmwRQMWp2ruKLZzbPNSDpbs2eBkwNOAHL8q6nYpHXtolWEw+JjJlV4gzC0fwJ
         csCVtEykMlRME9BK4RDDS5e2vCDDmf7xdREWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5tQW6IIZTiEE/7w7rYSblz9K9YpAzfJmG3Peiq+HwDA=;
        b=R7ffg0raLhGux2dm55hm0L9jeObdeMoaAMOzKF4JRZzKvWMSvjbP3OU635sFVTnJs6
         KyZFoKxsyqGo1g+OMPak3cK4NCoL0KHLd8Dss3w5etIVXtcrk3H3HQuUQRDV/IFfckOu
         mJ+l9a1s5p4uBuAKS/7KQL9bGYEBLtQtgLcLVn0ikUgDBvWcM6aDPdl4l6IzJ3G+etKB
         wJNhrUUK3YFt8ef6ujvyOVchOrnLlvNcF3OQH8P/xKGNMewZenHYnvIVeLQktnyhFmnm
         5j03ossEuBmm/g/6wYpMPLn6XPwE6Z7hTcrEiD0Q+mxOLqGQQVVnra4ll7mIVOxN0TL0
         E1Zg==
X-Gm-Message-State: ANhLgQ07+rcFRrWSl47fVvGwjaCILzTDYPh2pFlTaw83q2m4faXZMEjL
        ZDpNhVBrOqIh2Jk0zSpeiL8vyA==
X-Google-Smtp-Source: ADFU+vtijU31N/s/q98n18FnTrHBJKxxB192IFocLtPdCGUu2qEvqGyMpeGjae88mlBxGUgo5OsXKQ==
X-Received: by 2002:a65:63d1:: with SMTP id n17mr200533pgv.298.1583284018765;
        Tue, 03 Mar 2020 17:06:58 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm17780889pfb.138.2020.03.03.17.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:06:58 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v4 1/5] Bluetooth: Add mgmt op set_wake_capable
Date:   Tue,  3 Mar 2020 17:06:46 -0800
Message-Id: <20200303170610.RFC.v4.1.I797e2f4cb824299043e771f3ab9cef86ee09f4db@changeid>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200304010650.259961-1-abhishekpandit@chromium.org>
References: <20200304010650.259961-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the system is suspended, only some connected Bluetooth devices
cause user input that should wake the system (mostly HID devices). Add
a list to keep track of devices that can wake the system and add
a management API to let userspace tell the kernel whether a device is
wake capable or not. For LE devices, the wakeable property is added to
the connection parameter and can only be modified after calling
add_device.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4: None
Changes in v3:
* Added wakeable property to le_conn_param
* Use wakeable list for BR/EDR and wakeable property for LE

Changes in v2: None

 include/net/bluetooth/hci_core.h |  2 ++
 include/net/bluetooth/mgmt.h     |  7 +++++
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/mgmt.c             | 51 ++++++++++++++++++++++++++++++++
 4 files changed, 61 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dcc0dc6e2624..9d9ada5bc9d4 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -394,6 +394,7 @@ struct hci_dev {
 	struct list_head	mgmt_pending;
 	struct list_head	blacklist;
 	struct list_head	whitelist;
+	struct list_head	wakeable;
 	struct list_head	uuids;
 	struct list_head	link_keys;
 	struct list_head	long_term_keys;
@@ -575,6 +576,7 @@ struct hci_conn_params {
 
 	struct hci_conn *conn;
 	bool explicit_connect;
+	bool wakeable;
 };
 
 extern struct list_head hci_dev_list;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f69f88e8e109..42ad5c44ad5a 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -672,6 +672,13 @@ struct mgmt_cp_set_blocked_keys {
 } __packed;
 #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
 
+#define MGMT_OP_SET_WAKE_CAPABLE	0x0047
+#define MGMT_SET_WAKE_CAPABLE_SIZE	8
+struct mgmt_cp_set_wake_capable {
+	struct mgmt_addr_info addr;
+	u8 wake_capable;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4e6d61a95b20..b0b0308127a3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3299,6 +3299,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->mgmt_pending);
 	INIT_LIST_HEAD(&hdev->blacklist);
 	INIT_LIST_HEAD(&hdev->whitelist);
+	INIT_LIST_HEAD(&hdev->wakeable);
 	INIT_LIST_HEAD(&hdev->uuids);
 	INIT_LIST_HEAD(&hdev->link_keys);
 	INIT_LIST_HEAD(&hdev->long_term_keys);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1002c657768a..f6751ce0d561 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -107,6 +107,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
 	MGMT_OP_SET_BLOCKED_KEYS,
+	MGMT_OP_SET_WAKE_CAPABLE,
 };
 
 static const u16 mgmt_events[] = {
@@ -4667,6 +4668,48 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
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
+	BT_DBG("Set wake capable %pMR (type 0x%x) = 0x%x\n", &cp->addr.bdaddr,
+	       addr_type, cp->wake_capable);
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
@@ -5795,6 +5838,13 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
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
@@ -6994,6 +7044,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ set_wake_capable,	   MGMT_SET_WAKE_CAPABLE_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.25.0.265.gbab2e86ba0-goog

