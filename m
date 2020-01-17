Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930F3C33C9E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5FFDF2072E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 21:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Pvg5bZcN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbgAQV1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 16:27:41 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:46618 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbgAQV1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 16:27:38 -0500
Received: by mail-pl1-f194.google.com with SMTP id y8so10347418pll.13
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 13:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dX/yXK6iGHzCms4pl61rtiy1PGwacxrcd9Tk97W7YsY=;
        b=Pvg5bZcNdzM5pAw6eZyeKd+iwD+/Wc8Ds4gXDLa8Ait4HAK+v3N6lyvrZIOKc+cA/j
         OjWx4Q8wrkjDxMo0vwYwjZzlAUuLfKxrSG7T8z75QJ8vU/EXBTUuPSL1gSxr5mLV49hj
         HCDANuBi9waZGp7+doBXa6E0NNzP3iRSLfNps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dX/yXK6iGHzCms4pl61rtiy1PGwacxrcd9Tk97W7YsY=;
        b=uX3mKErxoRnGj1GWEBxgXz4i1nn/vKaDOVVUZXVJNTd/fjysuZRwkoOJeazere5EOV
         Gkb111H251MbkxHU8blKaowZRyUeHHS8NsZAbBv84DDMCRQHruqdrXVspFwQK92bS8x4
         dPZH/IKaiio9YIJ0wYM5fuMwLl9EiMX4N03qOgyuGYWrOkwwyVfoG1ZF1a8ncPFyoxaO
         AoGUmpJq2ASifwXW90NFx+p8gD5mty3qz03FBkBVnGdhTQ09eUaWwHCqWDy6Zy1hXROl
         jEvzUxTV8ytSmwyjNQmZp1OcvGV9JVLwRqombXNxsY6SoyTRjrHTbCUUvb8J19vgdW4p
         GhpQ==
X-Gm-Message-State: APjAAAXJTeX/TxBc6sTklNZF2XKh5F907WI6AsxClbcFQxa6umGzLVpp
        MMal6gwKFKCXbXYB26r/kuuBbQ==
X-Google-Smtp-Source: APXvYqwslGxdRr74On+Vps0DvyMpkZkcdh94uBscad3mS3VPMZeOUdw6vYpCI3buduc19L9K27E8UA==
X-Received: by 2002:a17:90b:258:: with SMTP id fz24mr7917727pjb.6.1579296457428;
        Fri, 17 Jan 2020 13:27:37 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k5sm6999655pju.29.2020.01.17.13.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 13:27:37 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/2] Bluetooth: Add mgmt op set_wake_capable
Date:   Fri, 17 Jan 2020 13:27:04 -0800
Message-Id: <20200117132623.RFC.1.I797e2f4cb824299043e771f3ab9cef86ee09f4db@changeid>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200117212705.57436-1-abhishekpandit@chromium.org>
References: <20200117212705.57436-1-abhishekpandit@chromium.org>
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
wake capable or not.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  7 ++++++
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/mgmt.c             | 42 ++++++++++++++++++++++++++++++++
 4 files changed, 51 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 89ecf0a80aa1..ce4bebcb0265 100644
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
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index a90666af05bd..283ba5320bdb 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -671,6 +671,13 @@ struct mgmt_cp_set_blocked_keys {
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
index 1ca7508b6ca7..7057b9b65173 100644
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
index 0dc610faab70..95092130f16c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -106,7 +106,10 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_START_LIMITED_DISCOVERY,
 	MGMT_OP_READ_EXT_INFO,
 	MGMT_OP_SET_APPEARANCE,
+	MGMT_OP_GET_PHY_CONFIGURATION,
+	MGMT_OP_SET_PHY_CONFIGURATION,
 	MGMT_OP_SET_BLOCKED_KEYS,
+	MGMT_OP_SET_WAKE_CAPABLE,
 };
 
 static const u16 mgmt_events[] = {
@@ -4663,6 +4666,37 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_wake_capable(struct sock *sk, struct hci_dev *hdev, void *data,
+			    u16 len)
+{
+	int err;
+	u8 status;
+	struct mgmt_cp_set_wake_capable *cp = data;
+	u8 addr_type = cp->addr.type == BDADDR_BREDR ?
+			       cp->addr.type :
+			       le_addr_type(cp->addr.type);
+
+	BT_DBG("Set wake capable %pMR (type 0x%x) = 0x%x\n", &cp->addr.bdaddr,
+	       addr_type, cp->wake_capable);
+
+	if (cp->wake_capable)
+		err = hci_bdaddr_list_add(&hdev->wakeable, &cp->addr.bdaddr,
+					  addr_type);
+	else
+		err = hci_bdaddr_list_del(&hdev->wakeable, &cp->addr.bdaddr,
+					  addr_type);
+
+	if (!err || err == -EEXIST || err == -ENOENT)
+		status = MGMT_STATUS_SUCCESS;
+	else
+		status = MGMT_STATUS_FAILED;
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_SET_WAKE_CAPABLE, status,
+				cp, sizeof(*cp));
+
+	return err;
+}
+
 static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -5791,6 +5825,13 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
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
@@ -6990,6 +7031,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_phy_configuration,   MGMT_SET_PHY_CONFIGURATION_SIZE },
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ set_wake_capable,	   MGMT_SET_WAKE_CAPABLE_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.25.0.341.g760bfbb309-goog

