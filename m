Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F4E9C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E15E2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 00:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QQf3QdM3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726935AbgFPAZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 20:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726691AbgFPAZQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 20:25:16 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427F6C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:25:15 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id z63so7703750pfb.1
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 17:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=REOPzdd/CmGs51lE8EakNqzbjCuJyFF9ASwe2jIWUkM=;
        b=QQf3QdM38flae/1AJQInyxK188sA8U7sK5aXS6/+HValDQd3+5X0itgwokmzTrHyA+
         R1UWCROn/vGGp+i+zlfxxGj+oentym6AFl6A1rlkv5qbNwgGreaxZYNKNATMIjHv4mi3
         7DH52UPZa2qJy9FxH86xmOA/wr0Eowqi5A8zo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=REOPzdd/CmGs51lE8EakNqzbjCuJyFF9ASwe2jIWUkM=;
        b=qcyH16AoDiwLtVfI7j6jrlNBShouZwsY7BBEeYrU9mfmPyy6B1SVvTRKrgEJWjtPAz
         dBfssl7xbG45zZZQsInszr76QQRoMiIgZXl6xWSaFNBTNLsrGgYlB2+IVxEF2kLHqYXZ
         lASI2AL0h1uFrRP5gVr9UE083uvNU145+6WWFTxwSwE8xqDRcDgfF8Cz/FbzAsO3Ca62
         d2n0wugnuu6nqU/DOD/Afk0r1Pjmasmerez71LD4UGtsTQrRsviM3Yy9Uk+ZZGs/S/31
         guuLtzuoEH1vDk+HzVTkvBCeJHgE8jL8FjmGFdEahA5+kKk0b2khBwAtsaK7eUuhyxG0
         nEAA==
X-Gm-Message-State: AOAM533KCEf/R4IHr80qV6vYBE6OLDQZt5XSEYEFxalm66e8ki4CQkXI
        anLmECMNKrJD2iUy/DU/LKIqvvzSeqM=
X-Google-Smtp-Source: ABdhPJwjD0VRrI+qI5cmgKfPUWYm0j1W4PB/wCepJPAVfYT/jpjtge+l0UXWhTKvO814Lyv1OULk0g==
X-Received: by 2002:a63:9742:: with SMTP id d2mr85117pgo.95.1592267114775;
        Mon, 15 Jun 2020 17:25:14 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id x2sm14783781pfr.186.2020.06.15.17.25.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Jun 2020 17:25:14 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Alain Michaud <alainm@chromium.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v5 4/7] Bluetooth: Add handler of MGMT_OP_REMOVE_ADV_MONITOR
Date:   Mon, 15 Jun 2020 17:25:02 -0700
Message-Id: <20200615172440.v5.4.Ib4effd5813fb2f8585e2c7394735050c16a765eb@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200615172440.v5.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds the request handler of MGMT_OP_REMOVE_ADV_MONITOR command.
Note that the controller-based monitoring is not yet in place. This
removes the internal monitor(s) without sending HCI traffic, so the
request returns immediately.

The following test was performed.
- Issue btmgmt advmon-remove with valid and invalid handles.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v5:
- Fix warnings.

Changes in v4:
- Fix warnings.

Changes in v3:
- Update the opcode in the mgmt table.
- Convert the endianness of the returned handle.

Changes in v2: None

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 31 ++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 35 ++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 862d94f711bc0..78ac7fd282d77 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1242,6 +1242,7 @@ void hci_adv_instances_set_rpa_expired(struct hci_dev *hdev, bool rpa_expired);
 void hci_adv_monitors_clear(struct hci_dev *hdev);
 void hci_free_adv_monitor(struct adv_monitor *monitor);
 int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor);
+int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fdbb58eb2fb22..d0f30e2e29471 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3041,6 +3041,37 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 	return 0;
 }
 
+static int free_adv_monitor(int id, void *ptr, void *data)
+{
+	struct hci_dev *hdev = data;
+	struct adv_monitor *monitor = ptr;
+
+	idr_remove(&hdev->adv_monitors_idr, monitor->handle);
+	hci_free_adv_monitor(monitor);
+
+	return 0;
+}
+
+/* This function requires the caller holds hdev->lock */
+int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle)
+{
+	struct adv_monitor *monitor;
+
+	if (handle) {
+		monitor = idr_find(&hdev->adv_monitors_idr, handle);
+		if (!monitor)
+			return -ENOENT;
+
+		idr_remove(&hdev->adv_monitors_idr, monitor->handle);
+		hci_free_adv_monitor(monitor);
+	} else {
+		/* Remove all monitors if handle is 0. */
+		idr_for_each(&hdev->adv_monitors_idr, &free_adv_monitor, hdev);
+	}
+
+	return 0;
+}
+
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
 					 bdaddr_t *bdaddr, u8 type)
 {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8e0d4ccf81f15..559d077a88b24 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -114,6 +114,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_EXP_FEATURE,
 	MGMT_OP_READ_ADV_MONITOR_FEATURES,
 	MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+	MGMT_OP_REMOVE_ADV_MONITOR,
 };
 
 static const u16 mgmt_events[] = {
@@ -3994,6 +3995,39 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+	struct mgmt_cp_remove_adv_monitor *cp = data;
+	struct mgmt_rp_remove_adv_monitor rp;
+	u16 handle;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	handle = __le16_to_cpu(cp->monitor_handle);
+
+	err = hci_remove_adv_monitor(hdev, handle);
+	if (err == -ENOENT) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_REMOVE_ADV_MONITOR,
+				      MGMT_STATUS_INVALID_INDEX);
+		goto unlock;
+	}
+
+	hci_dev_unlock(hdev);
+
+	rp.monitor_handle = cp->monitor_handle;
+
+	return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_ADV_MONITOR,
+				 MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static void read_local_oob_data_complete(struct hci_dev *hdev, u8 status,
 				         u16 opcode, struct sk_buff *skb)
 {
@@ -7451,6 +7485,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_adv_monitor_features, MGMT_READ_ADV_MONITOR_FEATURES_SIZE },
 	{ add_adv_patterns_monitor, MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ remove_adv_monitor, MGMT_REMOVE_ADV_MONITOR_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.26.2

