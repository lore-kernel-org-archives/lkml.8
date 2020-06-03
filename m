Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54D8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:03:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9644E22229
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 23:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RXaj8umF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726410AbgFCXDb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 19:03:31 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38662 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgFCXDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 19:03:25 -0400
Received: by mail-pg1-f194.google.com with SMTP id u5so2641304pgn.5
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 16:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SMKjPO0yxsKBw6WaCh5n1Xmlj31zLb02Q9MXdGn3Ze0=;
        b=RXaj8umFhhG77e1G0o5PsTSZeyKLdOhk40x2RCi2Ln9Cy3sUcUcRPpJasNJna+KFi/
         ragEizEIi39TWrfbX3gMMfGKqqIjyZrswzTbbzRNkkjc/AUzixnySmWKIQOd9hv5hbzV
         EPKAyjwNtx6/XLCFhdFkhZ/dKWtfQt9iBQt3Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SMKjPO0yxsKBw6WaCh5n1Xmlj31zLb02Q9MXdGn3Ze0=;
        b=Gq6nEDpBC/HoBgYC6uCkOiMwTS0Mkdv7NAIgvoMJPN5bpgqM4K+k1wgijq1v4VFTPh
         9UFA3EExPtPGR1WcA1At5Pqo2p2v5utM+SFkXbSu3Ibi0csyFjxE+yF7MCDaQu849o0s
         wHbT3M4T1Oja2+J/AWBoBWZXFn5b4mKAiUYuld6rrNgIrOPOqVApIBe2lsRff/7908DJ
         KbhYhYNuAYhCabv5t6FI7lTbWJ5gtjjD1MONKMyuOvqsMfCLHY3H+U/vX3LRkEp/kOnH
         joREgRW24C8t0Vcw+8mCIAlth84PIGslosZ4ybnfxDI+jo4BI/JVLaL3eXNHs9WPqtXV
         nvhQ==
X-Gm-Message-State: AOAM532gfkh0UFZF5g/ERNMeMU8Ry9NS+JOc5xcIC2kxiRoOWb67hFL4
        /4uo3/t+V0ifXbBUSYyBq9IEllD0BcE=
X-Google-Smtp-Source: ABdhPJwsbgPFzkQaNLtmD4/tdIAgUcZYm9TuZxQdqYWnzToxP8aVHM3oVc0dtA316AHj8sgMm+4sxw==
X-Received: by 2002:a63:1207:: with SMTP id h7mr1568237pgl.241.1591225338558;
        Wed, 03 Jun 2020 16:02:18 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id b11sm2715999pfd.178.2020.06.03.16.02.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 16:02:17 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Manish Mandlik <mmandlik@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 4/7] Bluetooth: Add handler of MGMT_OP_REMOVE_ADV_MONITOR
Date:   Wed,  3 Jun 2020 16:01:47 -0700
Message-Id: <20200603160058.v2.4.Ib4effd5813fb2f8585e2c7394735050c16a765eb@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200603160058.v2.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200603160058.v2.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
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

Changes in v2: None

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 31 +++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+)

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
index 93c16bfc6da15..1fcd0cc2dcc5b 100644
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
index e302f90fda9ce..a43a1e6d17cf9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -114,6 +114,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_EXP_FEATURE,
 	MGMT_OP_READ_ADV_MONITOR_FEATURES,
 	MGMT_OP_ADD_ADV_PATTERNS_MONITOR,
+	MGMT_OP_REMOVE_ADV_MONITOR,
 };
 
 static const u16 mgmt_events[] = {
@@ -3994,6 +3995,36 @@ static int add_adv_patterns_monitor(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int remove_adv_monitor(struct sock *sk, struct hci_dev *hdev,
+			      void *data, u16 len)
+{
+	struct mgmt_cp_remove_adv_monitor *cp = data;
+	struct mgmt_rp_remove_adv_monitor rp;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	hci_dev_lock(hdev);
+
+	err = hci_remove_adv_monitor(hdev, cp->monitor_handle);
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
@@ -7445,6 +7476,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ read_adv_monitor_features, MGMT_READ_ADV_MONITOR_FEATURES_SIZE },
 	{ add_adv_patterns_monitor, MGMT_ADD_ADV_PATTERNS_MONITOR_SIZE,
 						HCI_MGMT_VAR_LEN },
+	{ remove_adv_monitor, MGMT_REMOVE_ADV_MONITOR_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.26.2

