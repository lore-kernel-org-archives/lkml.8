Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8ECC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2F7220728
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:07:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fuOzDyed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387545AbgCDBHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:07:08 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37895 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387500AbgCDBHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:07:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id x7so154567pgh.5
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 17:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nD+wnBhhfQhuDyVD/p4juSDEz0XYbWsV3xmvIsrSGoU=;
        b=fuOzDyedOT41VselIwWAdvNYMWy9E/KizTuApFA/s5v7ACZ07hGKbeSmlg/ey40Kxs
         ZRpCYtouebwtC7xBQFquifnlBFOeX3wZJf8WNSEnrFCN0lJ9TqNA3cl7nIQfsxqjroO6
         iAeVm39vTW4To8RSn7UED3s6Apz5RGOrg6N/Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nD+wnBhhfQhuDyVD/p4juSDEz0XYbWsV3xmvIsrSGoU=;
        b=Tk8/+HhExX9dyyq7formMHE1HqKaIQD7q/XbWcKMq4CE+eN5XziKiumYjVzlvsdBHN
         eNK+JZe+SpKz8V5tHybD/NbLVnh15wvPKmaAc/ErAp1XvzpK9v+oQ1cdEuzeBVlob/5l
         rSlsjCsrX4nfNQc1X/aJ1FidghigayB620Uh2BJerzL2R8w4zQ2sY5OhSyxP75qPk9lR
         QQw3pvo5ra/m9T5MjNPxmiJBLXrc7NeySORV//KnxUmjrjXSyv9QMeXELf48eT3aL1YZ
         y9G5FLbC98WbbeS2ME9aJ12XMVtCaMxeoVHf2pyqZlKTtFhM3DekzDye8/b0wfG8ufWL
         k6KQ==
X-Gm-Message-State: ANhLgQ264pAGYIpJfhgmIaQJWhMqdGFA2p3Cv9U9SX0wSuQUuzEeBXgf
        OUEVyE1DwgJY3+cwEM0dZMV2lQ==
X-Google-Smtp-Source: ADFU+vsiaY96ILHdMFTfDO71SnXViDlXug3o6LVMBkUChm8M7lLilDq660pblxYNL4fKFnPbFOzsgA==
X-Received: by 2002:a63:8f17:: with SMTP id n23mr195471pgd.161.1583284024010;
        Tue, 03 Mar 2020 17:07:04 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id w2sm17780889pfb.138.2020.03.03.17.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2020 17:07:03 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v4 5/5] Bluetooth: Pause discovery and advertising during suspend
Date:   Tue,  3 Mar 2020 17:06:50 -0800
Message-Id: <20200303170610.RFC.v4.5.Iccdad520469ca3524a7e5966c5f88e5bca756e13@changeid>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200304010650.259961-1-abhishekpandit@chromium.org>
References: <20200304010650.259961-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To prevent spurious wake ups, we disable any discovery or advertising
when we enter suspend and restore it when we exit suspend. While paused,
we disable any management requests to modify discovery or advertising.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2:
* Refactored pause discovery + advertising into its own patch

 include/net/bluetooth/hci_core.h | 11 ++++++++
 net/bluetooth/hci_request.c      | 43 ++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 41 ++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4eb5b2786048..af264a247636 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -91,6 +91,12 @@ struct discovery_state {
 #define SUSPEND_NOTIFIER_TIMEOUT	msecs_to_jiffies(2000) /* 2 seconds */
 
 enum suspend_tasks {
+	SUSPEND_PAUSE_DISCOVERY,
+	SUSPEND_UNPAUSE_DISCOVERY,
+
+	SUSPEND_PAUSE_ADVERTISING,
+	SUSPEND_UNPAUSE_ADVERTISING,
+
 	SUSPEND_SCAN_DISABLE,
 	SUSPEND_SCAN_ENABLE,
 	SUSPEND_DISCONNECTING,
@@ -409,6 +415,11 @@ struct hci_dev {
 
 	struct discovery_state	discovery;
 
+	int			discovery_old_state;
+	bool			discovery_paused;
+	int			advertising_old_state;
+	bool			advertising_paused;
+
 	struct notifier_block	suspend_notifier;
 	struct work_struct	suspend_prepare;
 	enum suspended_state	suspend_state_next;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 88fd95d70f89..e25cfb6fd9aa 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1036,6 +1036,28 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		/* Mark device as suspended */
 		hdev->suspended = true;
 
+		/* Pause discovery if not already stopped */
+		old_state = hdev->discovery.state;
+		if (old_state != DISCOVERY_STOPPED) {
+			set_bit(SUSPEND_PAUSE_DISCOVERY, hdev->suspend_tasks);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPING);
+			queue_work(hdev->req_workqueue, &hdev->discov_update);
+		}
+
+		hdev->discovery_paused = true;
+		hdev->discovery_old_state = old_state;
+
+		/* Stop advertising */
+		old_state = hci_dev_test_flag(hdev, HCI_ADVERTISING);
+		if (old_state) {
+			set_bit(SUSPEND_PAUSE_ADVERTISING, hdev->suspend_tasks);
+			cancel_delayed_work(&hdev->discov_off);
+			queue_delayed_work(hdev->req_workqueue,
+					   &hdev->discov_off, 0);
+		}
+
+		hdev->advertising_paused = true;
+		hdev->advertising_old_state = old_state;
 		/* Disable page scan */
 		page_scan = SCAN_DISABLED;
 		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &page_scan);
@@ -1081,6 +1103,27 @@ void hci_req_prepare_suspend(struct hci_dev *hdev, enum suspended_state next)
 		hci_req_clear_event_filter(&req);
 		/* Reset passive/background scanning to normal */
 		hci_req_config_le_suspend_scan(&req);
+
+		/* Unpause advertising */
+		hdev->advertising_paused = false;
+		if (hdev->advertising_old_state) {
+			set_bit(SUSPEND_UNPAUSE_ADVERTISING,
+				hdev->suspend_tasks);
+			hci_dev_set_flag(hdev, HCI_ADVERTISING);
+			queue_work(hdev->req_workqueue,
+				   &hdev->discoverable_update);
+			hdev->advertising_old_state = 0;
+		}
+
+		/* Unpause discovery */
+		hdev->discovery_paused = false;
+		if (hdev->discovery_old_state != DISCOVERY_STOPPED &&
+		    hdev->discovery_old_state != DISCOVERY_STOPPING) {
+			set_bit(SUSPEND_UNPAUSE_DISCOVERY, hdev->suspend_tasks);
+			hci_discovery_set_state(hdev, DISCOVERY_STARTING);
+			queue_work(hdev->req_workqueue, &hdev->discov_update);
+		}
+
 		hci_req_run(&req, suspend_req_complete);
 	}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f6751ce0d561..28572579c06d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1387,6 +1387,12 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
+	if (hdev->advertising_paused) {
+		err = mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
+				      MGMT_STATUS_BUSY);
+		goto failed;
+	}
+
 	if (!hdev_is_powered(hdev)) {
 		bool changed = false;
 
@@ -3870,6 +3876,13 @@ void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status)
 	}
 
 	hci_dev_unlock(hdev);
+
+	/* Handle suspend notifier */
+	if (test_and_clear_bit(SUSPEND_UNPAUSE_DISCOVERY,
+			       hdev->suspend_tasks)) {
+		BT_DBG("Unpaused discovery");
+		wake_up(&hdev->suspend_wait_q);
+	}
 }
 
 static bool discovery_type_is_valid(struct hci_dev *hdev, uint8_t type,
@@ -3931,6 +3944,13 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	/* Can't start discovery when it is paused */
+	if (hdev->discovery_paused) {
+		err = mgmt_cmd_complete(sk, hdev->id, op, MGMT_STATUS_BUSY,
+					&cp->type, sizeof(cp->type));
+		goto failed;
+	}
+
 	/* Clear the discovery filter first to free any previously
 	 * allocated memory for the UUID list.
 	 */
@@ -4098,6 +4118,12 @@ void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status)
 	}
 
 	hci_dev_unlock(hdev);
+
+	/* Handle suspend notifier */
+	if (test_and_clear_bit(SUSPEND_PAUSE_DISCOVERY, hdev->suspend_tasks)) {
+		BT_DBG("Paused discovery");
+		wake_up(&hdev->suspend_wait_q);
+	}
 }
 
 static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
@@ -4329,6 +4355,17 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
 	if (match.sk)
 		sock_put(match.sk);
 
+	/* Handle suspend notifier */
+	if (test_and_clear_bit(SUSPEND_PAUSE_ADVERTISING,
+			       hdev->suspend_tasks)) {
+		BT_DBG("Paused advertising");
+		wake_up(&hdev->suspend_wait_q);
+	} else if (test_and_clear_bit(SUSPEND_UNPAUSE_ADVERTISING,
+				      hdev->suspend_tasks)) {
+		BT_DBG("Unpaused advertising");
+		wake_up(&hdev->suspend_wait_q);
+	}
+
 	/* If "Set Advertising" was just disabled and instance advertising was
 	 * set up earlier, then re-enable multi-instance advertising.
 	 */
@@ -4380,6 +4417,10 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
 				       MGMT_STATUS_INVALID_PARAMS);
 
+	if (hdev->advertising_paused)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				       MGMT_STATUS_BUSY);
+
 	hci_dev_lock(hdev);
 
 	val = !!cp->val;
-- 
2.25.0.265.gbab2e86ba0-goog

