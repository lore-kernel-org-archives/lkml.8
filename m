Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2223C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F58720748
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 07:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yk3MljGx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgC3HfC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 03:35:02 -0400
Received: from mail-pj1-f74.google.com ([209.85.216.74]:50806 "EHLO
        mail-pj1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729367AbgC3HfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 03:35:02 -0400
Received: by mail-pj1-f74.google.com with SMTP id e8so14088224pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 00:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=phDCFfqedeK2nIuOQYdahcZFuPfEjGWdo8PSqHFGRb0=;
        b=Yk3MljGxsw2Dce27LqyBYu3zdDn9P/XLAdiMvH2Fx5nycKiePxzicoZyhGMkSfi+q0
         fd9bPuZznGtrk9njmJ5/jts5NvuQxRwG9oyNXKJBGCkcgFk0Qtd59e0GGFa5Uw5FDLW0
         HkUXW1LF+Fhg3Pwcl5vzI1eiR3X0jrXrIiD8fRLzOil8nAt1tnXXZXSmjhq5gQWlZ0A8
         XuyGAWfWQZ8G+QtJe0Wo1VkVC/nNWr5q7hrarMCsUl5/JKmrXHn5GHcSEdztN5kgn64P
         AhuQmQzmSAKtoT0p6CoHCXgQGNCa9lUqBgwuwe5t6XqBIv0rP/YUq6RHDjPOVOSlf2rZ
         Rq+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=phDCFfqedeK2nIuOQYdahcZFuPfEjGWdo8PSqHFGRb0=;
        b=mqWJcn3umytJUh5fGGJzhkDH3y2Doj+aU8WaINnefYAxFjYcRfmPekOaYbGUV8bZyw
         AdmzYIv2gFsqZh1BOccmYgmD8hoeOHSqeHEwYGlMOPVU22vyo516H5o5xcd6KSblsCIb
         3lpq7zqrG+5u5RWl6fFpPBShPUqoaWUzwrPO4L3xQzqiYHmgoDOaPIz2I4ahWgf4Aj00
         kYa5YHebeodvNhIN59X9CLemYclhZN7gORzJAQBrFqtn0d/vaxaUAiP3slbI1Ipggw7k
         6miPR+Qnaq1C8kmm+gIABLlcZxRJuVhBSvD018l2LqiI/YLFpqy4MYP0E/K3QcP1b3T/
         qK6Q==
X-Gm-Message-State: ANhLgQ0dFvrHSzisHA+f95Dwv/OsBH5YRqmk2gnrB63LAMcPHRDaK2RJ
        bOZ8HiX4Vrnt+wtZ5cDcppXGZDiTn3H37xfWTw==
X-Google-Smtp-Source: ADFU+vsFm2tW39LaJ0Q8SDu01jYb1uXH8SZ0d1iiWD3a9o3PBHnStZhq2O/4hMt5K5iW586qjrvnp15tHZLXNt03Ew==
X-Received: by 2002:a17:90a:4497:: with SMTP id t23mr13864569pjg.102.1585553700153;
 Mon, 30 Mar 2020 00:35:00 -0700 (PDT)
Date:   Mon, 30 Mar 2020 15:34:35 +0800
Message-Id: <20200330153143.Bluez.v1.1.Id488d4a31aa751827c55c79ca20033013156ea0a@changeid>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [Bluez PATCH v1] bluetooth: set advertising intervals
From:   Howard Chung <howardchung@google.com>
To:     linux-bluetooth@vger.kernel.org, marcel@holtmann.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Joseph Hwang <josephsih@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joseph Hwang <josephsih@chromium.org>

This patch supports specification of advertising intervals in
bluetooth kernel subsystem.

A new set_advertising_intervals mgmt handler is added to support
the new mgmt opcode MGMT_OP_SET_ADVERTISING_INTERVALS. The
min_interval and max_interval are simply recorded in hdev struct.

The intervals together with other advertising parameters would be
sent to the controller before advertising is enabled in the procedure
of registering an advertisement.

In cases that advertising has been enabled before
set_advertising_intervals is invoked, it would re-enable advertising
to make the intervals take effect. This is less preferable since
bluetooth core specification states that the parameters should be set
before advertising is enabled. However, the advertising re-enabling
feature is kept since it might be useful in multi-advertisements.

Signed-off-by: Joseph Hwang <josephsih@chromium.org>
---

 include/net/bluetooth/hci.h      |   1 +
 include/net/bluetooth/hci_core.h |  11 +++
 include/net/bluetooth/mgmt.h     |   8 ++
 net/bluetooth/hci_core.c         |   4 +-
 net/bluetooth/mgmt.c             | 147 +++++++++++++++++++++++++++++++
 5 files changed, 169 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5f60e135aeb6..4877289b0f95 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -278,6 +278,7 @@ enum {
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
 	HCI_ADVERTISING_CONNECTABLE,
+	HCI_ADVERTISING_INTERVALS,
 	HCI_CONNECTABLE,
 	HCI_DISCOVERABLE,
 	HCI_LIMITED_DISCOVERABLE,
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index d4e28773d378..a3a23e2daa64 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -220,6 +220,17 @@ struct adv_info {
 #define HCI_MAX_ADV_INSTANCES		5
 #define HCI_DEFAULT_ADV_DURATION	2
 
+/*
+ * Refer to BLUETOOTH SPECIFICATION Version 5.2 [Vol 4, Part E]
+ * Section 7.8.5 about
+ * - the default min/max intervals, and
+ * - the valid range of min/max intervals.
+ */
+#define HCI_DEFAULT_LE_ADV_MIN_INTERVAL	0x0800
+#define HCI_DEFAULT_LE_ADV_MAX_INTERVAL	0x0800
+#define HCI_VALID_LE_ADV_MIN_INTERVAL	0x0020
+#define HCI_VALID_LE_ADV_MAX_INTERVAL	0x4000
+
 #define HCI_MAX_SHORT_NAME_LENGTH	10
 
 /* Min encryption key size to match with SMP */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f41cd87550dc..32a21f77260e 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -103,6 +103,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_STATIC_ADDRESS	0x00008000
 #define MGMT_SETTING_PHY_CONFIGURATION	0x00010000
 #define MGMT_SETTING_WIDEBAND_SPEECH	0x00020000
+#define MGMT_SETTING_ADVERTISING_INTERVALS	0x00040000
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -674,6 +675,13 @@ struct mgmt_cp_set_blocked_keys {
 
 #define MGMT_OP_SET_WIDEBAND_SPEECH	0x0047
 
+#define MGMT_OP_SET_ADVERTISING_INTERVALS	0x0048
+struct mgmt_cp_set_advertising_intervals {
+	__le16	min_interval;
+	__le16	max_interval;
+} __packed;
+#define MGMT_SET_ADVERTISING_INTERVALS_SIZE	4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2e7bc2da8371..34ed8a11991d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3382,8 +3382,8 @@ struct hci_dev *hci_alloc_dev(void)
 	hdev->sniff_min_interval = 80;
 
 	hdev->le_adv_channel_map = 0x07;
-	hdev->le_adv_min_interval = 0x0800;
-	hdev->le_adv_max_interval = 0x0800;
+	hdev->le_adv_min_interval = HCI_DEFAULT_LE_ADV_MIN_INTERVAL;
+	hdev->le_adv_max_interval = HCI_DEFAULT_LE_ADV_MAX_INTERVAL;
 	hdev->le_scan_interval = 0x0060;
 	hdev->le_scan_window = 0x0030;
 	hdev->le_conn_min_interval = 0x0018;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170e..235fff7b14cc 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -108,6 +108,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_APPEARANCE,
 	MGMT_OP_SET_BLOCKED_KEYS,
 	MGMT_OP_SET_WIDEBAND_SPEECH,
+	MGMT_OP_SET_ADVERTISING_INTERVALS,
 };
 
 static const u16 mgmt_events[] = {
@@ -775,6 +776,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 		settings |= MGMT_SETTING_SECURE_CONN;
 		settings |= MGMT_SETTING_PRIVACY;
 		settings |= MGMT_SETTING_STATIC_ADDRESS;
+		settings |= MGMT_SETTING_ADVERTISING_INTERVALS;
 	}
 
 	if (test_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks) ||
@@ -854,6 +856,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_WIDEBAND_SPEECH_ENABLED))
 		settings |= MGMT_SETTING_WIDEBAND_SPEECH;
 
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING_INTERVALS))
+		settings |= MGMT_SETTING_ADVERTISING_INTERVALS;
+
 	return settings;
 }
 
@@ -4768,6 +4773,147 @@ static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static void set_advertising_intervals_complete(struct hci_dev *hdev,
+					       u8 status, u16 opcode)
+{
+	struct cmd_lookup match = { NULL, hdev };
+	struct hci_request req;
+	u8 instance;
+	struct adv_info *adv_instance;
+	int err;
+
+	hci_dev_lock(hdev);
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING_INTERVALS, hdev,
+				     cmd_status_rsp, &mgmt_err);
+		goto unlock;
+	}
+
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV))
+		hci_dev_set_flag(hdev, HCI_ADVERTISING);
+	else
+		hci_dev_clear_flag(hdev, HCI_ADVERTISING);
+
+	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING_INTERVALS, hdev,
+			     settings_rsp, &match);
+
+	new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+
+	/* If "Set Advertising" was just disabled and instance advertising was
+	 * set up earlier, then re-enable multi-instance advertising.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_ADVERTISING) ||
+	    list_empty(&hdev->adv_instances))
+		goto unlock;
+
+	instance = hdev->cur_adv_instance;
+	if (!instance) {
+		adv_instance = list_first_entry_or_null(&hdev->adv_instances,
+							struct adv_info, list);
+		if (!adv_instance)
+			goto unlock;
+
+		instance = adv_instance->instance;
+	}
+
+	hci_req_init(&req, hdev);
+
+	err = __hci_req_schedule_adv_instance(&req, instance, true);
+	if (!err)
+		err = hci_req_run(&req, enable_advertising_instance);
+	else
+		BT_ERR("Failed to re-configure advertising intervals");
+
+unlock:
+	hci_dev_unlock(hdev);
+}
+
+static int _reenable_advertising(struct sock *sk, struct hci_dev *hdev,
+				 void *data, u16 len)
+{
+	struct mgmt_pending_cmd *cmd;
+	struct hci_request req;
+	int err;
+
+	if (pending_find(MGMT_OP_SET_ADVERTISING_INTERVALS, hdev)) {
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_ADVERTISING_INTERVALS,
+				       MGMT_STATUS_BUSY);
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_ADVERTISING_INTERVALS, hdev,
+			       data, len);
+	if (!cmd)
+		return -ENOMEM;
+
+	hci_req_init(&req, hdev);
+	cancel_adv_timeout(hdev);
+
+	/* Switch to instance "0" for the Set Advertising setting.
+	 * We cannot use update_[adv|scan_rsp]_data() here as the
+	 * HCI_ADVERTISING flag is not yet set.
+	 */
+	hdev->cur_adv_instance = 0x00;
+	/* This function disables advertising before enabling it. */
+	__hci_req_enable_advertising(&req);
+
+	err = hci_req_run(&req, set_advertising_intervals_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+	return err;
+}
+
+static int set_advertising_intervals(struct sock *sk, struct hci_dev *hdev,
+				     void *data, u16 len)
+{
+	struct mgmt_cp_set_advertising_intervals *cp = data;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	/* This method is intended for LE devices only.*/
+	if (!hci_dev_test_flag(hdev, HCI_LE_ENABLED))
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_ADVERTISING_INTERVALS,
+				       MGMT_STATUS_REJECTED);
+
+	/* Check the validity of the intervals. */
+	if (cp->min_interval < HCI_VALID_LE_ADV_MIN_INTERVAL ||
+	    cp->max_interval > HCI_VALID_LE_ADV_MAX_INTERVAL ||
+	    cp->min_interval > cp->max_interval) {
+		return mgmt_cmd_status(sk, hdev->id,
+				       MGMT_OP_SET_ADVERTISING_INTERVALS,
+				       MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	hci_dev_lock(hdev);
+
+	hci_dev_set_flag(hdev, HCI_ADVERTISING_INTERVALS);
+	hdev->le_adv_min_interval = cp->min_interval;
+	hdev->le_adv_max_interval = cp->max_interval;
+
+	/* Re-enable advertising only when it is already on. */
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		err = _reenable_advertising(sk, hdev, data, len);
+		goto unlock;
+	}
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_ADVERTISING_INTERVALS, hdev);
+	new_settings(hdev, sk);
+
+unlock:
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void set_bredr_complete(struct hci_dev *hdev, u8 status, u16 opcode)
 {
 	struct mgmt_pending_cmd *cmd;
@@ -7099,6 +7245,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ set_blocked_keys,	   MGMT_OP_SET_BLOCKED_KEYS_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ set_wideband_speech,	   MGMT_SETTING_SIZE },
+	{ set_advertising_intervals, MGMT_SET_ADVERTISING_INTERVALS_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.26.0.rc2.310.g2932bb562d-goog

