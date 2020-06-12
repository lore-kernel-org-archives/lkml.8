Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C3DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2B1A2078A
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 23:46:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bYIfnUI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgFLXqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 19:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbgFLXqZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 19:46:25 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DD7C08C5C3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 16:46:24 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so4517844pje.4
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 16:46:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMh9znkko3Eeh+wj8HArzemUcagcDQr49Ksm6hwe3xM=;
        b=bYIfnUI3ZsF13U18gugxCWcabmkVVttN6ouoWxFNjLXkQxBw4bOLvhNQXHwfl5Ta78
         qSTu/nhbk6kErxjVmwNX6FgFULT86Jo1njCz46rxueK4oOfUw/M6fgnCPO/7jj8Bl0qf
         x9dVQ4qJtVaLIVRSCkzay00w19I5VhxZTNU+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMh9znkko3Eeh+wj8HArzemUcagcDQr49Ksm6hwe3xM=;
        b=PVNe8UJp3v5Je1MV/cF4087oVtri83UeyOm3MEeHlZG8PaKRzVVtt8cjeLoPF31Ux6
         mETZQ9y9VU8/Zg60nGW9zwqHWvS3pkmolwSQTNeQeTTsmH799KK5opF4t0wckVEIvMch
         VwcJ8zG4csdqYUytnyzd2tGTUlu1Sk43CRBUFBVvEpMMRX+ZpZBVWQWNFVN7nBKQgomo
         yqPZ2yA/Pbob+c9bV1frD5tm9Xjbzp0khwLt56MDK302OcQfveoAT4GReZZuUQmwbTE+
         ESBN/Yz/ting4SoZs5SYUJMjL5ObF6ivQzFz8JGaF5zBgCa3n4CzK7Ue2grPuN++9wvP
         fHdA==
X-Gm-Message-State: AOAM5319ZopxviVdNDLyXNOeEWB8rOZcaKTQGbG0hclGlEfLKEN85OTW
        T7RskzTI8MMVPHpRmQQ/mkmc+w==
X-Google-Smtp-Source: ABdhPJzfVJcmfIwdz1PSyA1t6VJIL0U0DwB9RBAIapD125Ni28J2wNcedoi2eX/MR0IitTtm0JxyKw==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr13815334ply.122.1592005583736;
        Fri, 12 Jun 2020 16:46:23 -0700 (PDT)
Received: from mcchou0.mtv.corp.google.com ([2620:15c:202:201:b46:ac84:1014:9555])
        by smtp.gmail.com with ESMTPSA id b19sm6198639pjo.57.2020.06.12.16.46.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 16:46:23 -0700 (PDT)
From:   Miao-chen Chou <mcchou@chromium.org>
To:     Bluetooth Kernel Mailing List <linux-bluetooth@vger.kernel.org>
Cc:     Alain Michaud <alainm@chromium.org>,
        Michael Sun <michaelfsun@google.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Yoni Shavit <yshavit@chromium.org>,
        Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
        Miao-chen Chou <mcchou@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 7/7] Bluetooth: Update background scan and report device based on advertisement monitors
Date:   Fri, 12 Jun 2020 16:45:56 -0700
Message-Id: <20200612164243.v4.7.Id9ca021d5a3e8c748ea5c0a1c81582b9a8183f45@changeid>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200612164243.v4.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
References: <20200612164243.v4.1.I636f906bf8122855dfd2ba636352bbdcb50c35ed@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This calls hci_update_background_scan() when there is any update on the
advertisement monitors. If there is at least one advertisement monitor,
the filtering policy of scan parameters should be 0x00. This also reports
device found mgmt events if there is at least one monitor.

The following cases were tested with btmgmt advmon-* commands.
(1) add a ADV monitor and observe that the passive scanning is
triggered.
(2) remove the last ADV monitor and observe that the passive scanning is
terminated.
(3) with a LE peripheral paired, repeat (1) and observe the passive
scanning continues.
(4) with a LE peripheral paired, repeat (2) and observe the passive
scanning continues.
(5) with a ADV monitor, suspend/resume the host and observe the passive
scanning continues.

Signed-off-by: Miao-chen Chou <mcchou@chromium.org>
---

Changes in v4: None
Changes in v3: None
Changes in v2: None

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 13 +++++++++++++
 net/bluetooth/hci_event.c        |  5 +++--
 net/bluetooth/hci_request.c      | 17 ++++++++++++++---
 net/bluetooth/mgmt.c             |  5 ++++-
 5 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 78ac7fd282d77..1ce89e546a64e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1243,6 +1243,7 @@ void hci_adv_monitors_clear(struct hci_dev *hdev);
 void hci_free_adv_monitor(struct adv_monitor *monitor);
 int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor);
 int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle);
+bool hci_is_adv_monitoring(struct hci_dev *hdev);
 
 void hci_event_packet(struct hci_dev *hdev, struct sk_buff *skb);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d0f30e2e29471..2d318916e9ebc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3005,6 +3005,8 @@ void hci_adv_monitors_clear(struct hci_dev *hdev)
 		hci_free_adv_monitor(monitor);
 
 	idr_destroy(&hdev->adv_monitors_idr);
+
+	hci_update_background_scan(hdev);
 }
 
 void hci_free_adv_monitor(struct adv_monitor *monitor)
@@ -3038,6 +3040,9 @@ int hci_add_adv_monitor(struct hci_dev *hdev, struct adv_monitor *monitor)
 
 	hdev->adv_monitors_cnt++;
 	monitor->handle = handle;
+
+	hci_update_background_scan(hdev);
+
 	return 0;
 }
 
@@ -3069,9 +3074,17 @@ int hci_remove_adv_monitor(struct hci_dev *hdev, u16 handle)
 		idr_for_each(&hdev->adv_monitors_idr, &free_adv_monitor, hdev);
 	}
 
+	hci_update_background_scan(hdev);
+
 	return 0;
 }
 
+/* This function requires the caller holds hdev->lock */
+bool hci_is_adv_monitoring(struct hci_dev *hdev)
+{
+	return !idr_is_empty(&hdev->adv_monitors_idr);
+}
+
 struct bdaddr_list *hci_bdaddr_list_lookup(struct list_head *bdaddr_list,
 					 bdaddr_t *bdaddr, u8 type)
 {
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cfeaee347db32..cbcc0b590fd41 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5447,14 +5447,15 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 
 	/* Passive scanning shouldn't trigger any device found events,
 	 * except for devices marked as CONN_REPORT for which we do send
-	 * device found events.
+	 * device found events, or advertisement monitoring requested.
 	 */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
 		if (!hci_pend_le_action_lookup(&hdev->pend_le_reports,
-					       bdaddr, bdaddr_type))
+					       bdaddr, bdaddr_type) &&
+		    idr_is_empty(&hdev->adv_monitors_idr))
 			return;
 
 		if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND)
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 1acf5b8e0910c..d465dbbb1963c 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -418,11 +418,15 @@ static void __hci_update_background_scan(struct hci_request *req)
 	 */
 	hci_discovery_filter_clear(hdev);
 
+	BT_DBG("%s ADV monitoring is %s", hdev->name,
+	       hci_is_adv_monitoring(hdev) ? "on" : "off");
+
 	if (list_empty(&hdev->pend_le_conns) &&
-	    list_empty(&hdev->pend_le_reports)) {
+	    list_empty(&hdev->pend_le_reports) &&
+	    !hci_is_adv_monitoring(hdev)) {
 		/* If there is no pending LE connections or devices
-		 * to be scanned for, we should stop the background
-		 * scanning.
+		 * to be scanned for or no ADV monitors, we should stop the
+		 * background scanning.
 		 */
 
 		/* If controller is not scanning we are done. */
@@ -798,6 +802,13 @@ static u8 update_white_list(struct hci_request *req)
 			return 0x00;
 	}
 
+	/* Once the controller offloading of advertisement monitor is in place,
+	 * the if condition should include the support of MSFT extension
+	 * support.
+	 */
+	if (!idr_is_empty(&hdev->adv_monitors_idr))
+		return 0x00;
+
 	/* Select filter policy to use white list */
 	return 0x01;
 }
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 325e528a1773e..10a239d396827 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -8435,8 +8435,11 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	if (!hci_discovery_active(hdev)) {
 		if (link_type == ACL_LINK)
 			return;
-		if (link_type == LE_LINK && list_empty(&hdev->pend_le_reports))
+		if (link_type == LE_LINK &&
+		    list_empty(&hdev->pend_le_reports) &&
+		    !hci_is_adv_monitoring(hdev)) {
 			return;
+		}
 	}
 
 	if (hdev->discovery.result_filtering) {
-- 
2.26.2

