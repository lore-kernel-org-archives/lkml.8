Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D46C5C10F28
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD1420848
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 21:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UjEYkTs2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbgCHVYJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 17:24:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39967 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgCHVX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 17:23:59 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so3778137pgj.7
        for <linux-kernel@vger.kernel.org>; Sun, 08 Mar 2020 14:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7IXTL5Wmi6zHebO7YXtizBnQaWklYcKumiFOEII320M=;
        b=UjEYkTs2VZPBh87df/QUiPqkfDdGEiR8zd3UNoXzVKKcpNfosjh/+mFo+DHY7z9/Xd
         qPoikHqOyJPT33cpN5LlT6aWcPKzaXOvM7CAF3EQ5qP0HdSRHjPhLgyRNDNTV3vwETSW
         s8jAOyr+6oAcObpxUnQM7yt+BSyEIPEkwFhss=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7IXTL5Wmi6zHebO7YXtizBnQaWklYcKumiFOEII320M=;
        b=Qc6jbtmagsg71fUiiPfndwa493gPxeRrcFYC4AX7JJxz4HrKd+tK2ssddU+K7hnrer
         P+rABq+Y92H2/DJE8m88fgoY11JP8NFQMh6esE2w8tOh3JUAZF5rgojXqySdENdzciZC
         igtVYFMr289ETodDLn6K1z1RoBm0VwCfaYi3AsNfrqyu4JBGk/c07k64KkDHylbsL/1s
         4DO2VIef5yB1ghdoAUq92JAW2zuZ8kaBS5Cvos9hvVs9y47Z8TQirt7E2Q1mX1RH4KVo
         dj/tn7VdMsg0zJNsqzfpjIMCOKL58qfwtzQmfs5ctxTtELqv4nWY+L3riiMul3W4G28p
         U2dQ==
X-Gm-Message-State: ANhLgQ1uM6QCB57+Y+s3f7c1LCuae+WGDCbSGnatBQXcWWM4mTXiW8Na
        9JFwrANs1GqBlP8PlJV4XhxdwlyG0v8=
X-Google-Smtp-Source: ADFU+vsFTYtMUZMYAj7TfwyJ3OV44DTEhX06bnh246mFuKY7ODP2EQH4iqrq65PEpCOwyoCGAUTmEg==
X-Received: by 2002:a63:7311:: with SMTP id o17mr13071410pgc.377.1583702636376;
        Sun, 08 Mar 2020 14:23:56 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id k1sm39509228pgt.70.2020.03.08.14.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Mar 2020 14:23:55 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v5 5/5] Bluetooth: Add mgmt op set_wake_capable
Date:   Sun,  8 Mar 2020 14:23:34 -0700
Message-Id: <20200308142005.RFC.v5.5.I797e2f4cb824299043e771f3ab9cef86ee09f4db@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200308212334.213841-1-abhishekpandit@chromium.org>
References: <20200308212334.213841-1-abhishekpandit@chromium.org>
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
index 047aea280c84..ab9685e87b84 100644
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
@@ -7096,6 +7146,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ set_wideband_speech,	   MGMT_SETTING_SIZE },
+	{ set_wake_capable,	   MGMT_SET_WAKE_CAPABLE_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.25.1.481.gfbce0eb801-goog

