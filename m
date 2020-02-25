Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF95BC35DEA
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 969052072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:01:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nrNCzO17"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbgBYABD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:01:03 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51554 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728634AbgBYAAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:00:55 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so462173pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xHRY7WtQ/mTsM4blN4RvkEu7lSvJwYKGrcsPCUjqi1w=;
        b=nrNCzO17Ip6gwc/HJhU+z2ULsZYfZdYh52BwHIBofjhEaQsisKLQf+p4DpHb39Oz0A
         fslccTXzhPbffblSV+7qwYDEzFnRhDJ2UO8upFmFz8pebaVwFKlzX6/aNp/PQiCAIZuE
         LUNM5OwUt4WxcD1GG0/k1WkBhamtpYE+LX6OE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xHRY7WtQ/mTsM4blN4RvkEu7lSvJwYKGrcsPCUjqi1w=;
        b=THJr8rAf0Gus71aBH1CUNGAixmVgiL2WmZnuHqJtd3pQKUzCmvCH25jym9gKZjCvM2
         nGRI3jWe3iDE4V8mwMkaFSMXkdrvR/NZvzrcpAo0dKbGyXlAERDtsg3+Hz6ldK/4wqMu
         wiMKNUqiwv9VEZvKeAICUGBY2jbIa23sdPrWvyA23pytsoH49lLuHwc4rbJkj3r9glUQ
         GD5OUomRsnE29SvsaiZ1L2/H8wvD2pxXnYHXE+5dHVdQPSURDfg+6QVvf+Wa0Y6STM3Y
         hd3IZNkmwp4BE/8IRptALk3Rjw+GiWWOCseGlxfUjpFkEGYaS020+iB7b8grkYcAUN7c
         E70w==
X-Gm-Message-State: APjAAAXzePKt/ITt7q3FiWZBk2e7uef96OrqlYMtSuTs3pv9iCiWohGI
        17Bo5EAoFZHDgi9uz5GjsK0xEw==
X-Google-Smtp-Source: APXvYqyEo8nafOO4GtiPLOCcQTE8wcq6OhIY5ASSpLxQpulK8z0O3H5wWbZb8HqXzVnKaUSlYPIemw==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr1892450pjn.113.1582588854288;
        Mon, 24 Feb 2020 16:00:54 -0800 (PST)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id c188sm14477657pfb.151.2020.02.24.16.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 16:00:53 -0800 (PST)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, luiz.dentz@gmail.com, alainm@chromium.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [RFC PATCH v3 5/5] Bluetooth: Pause discovery and advertising during suspend
Date:   Mon, 24 Feb 2020 16:00:36 -0800
Message-Id: <20200224160019.RFC.v3.5.Iccdad520469ca3524a7e5966c5f88e5bca756e13@changeid>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200225000036.156250-1-abhishekpandit@chromium.org>
References: <20200225000036.156250-1-abhishekpandit@chromium.org>
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

Changes in v3: None
Changes in v2:
* Refactored pause discovery + advertising into its own patch

 include/net/bluetooth/hci_core.h | 11 ++++++++
 net/bluetooth/hci_request.c      | 43 ++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 41 ++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2723a608183e..41ea2d8c73d4 100644
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
@@ -407,6 +413,11 @@ struct hci_dev {
 
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
index 9a873097000b..b41c2e3cf3bb 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1383,6 +1383,12 @@ static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
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
 
@@ -3866,6 +3872,13 @@ void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status)
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
@@ -3927,6 +3940,13 @@ static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
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
@@ -4094,6 +4114,12 @@ void mgmt_stop_discovery_complete(struct hci_dev *hdev, u8 status)
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
@@ -4325,6 +4351,17 @@ static void set_advertising_complete(struct hci_dev *hdev, u8 status,
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
@@ -4376,6 +4413,10 @@ static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data,
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

