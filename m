Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD1AC43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:45:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBE622070A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i+w8pe4i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCZFp0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:45:26 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:36540 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726014AbgCZFpY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:45:24 -0400
Received: by mail-pf1-f195.google.com with SMTP id i13so2240605pfe.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gj5gA3T2046detFgpaRzX1gpdaCMHsoqR5CDuNT7U/U=;
        b=i+w8pe4isMbYIcvhm9pHUk6A7TMoqqnVLGnLaPq17Fd/yK4bwHvXfykBbX5oFBKkFB
         qZ/ihFxifMLWvRJIUef3SE9A/fRZ+5KPjxg2G8zOpWIZyo9whRLOJXygR+rYyayuywci
         Rfp1mEm7rNzmffmZFT9W/TOmy3eo1qpPvurbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gj5gA3T2046detFgpaRzX1gpdaCMHsoqR5CDuNT7U/U=;
        b=g+bvSQTUFRi28+2F4kSfHy8NlnsqmkewuVKXWqrODdY1hotI1EnOzWdq1VsWOcebll
         thuaacT78hec2BU1wPzHdvZ37oOSMoWuVqE8CA70JXDc9QHFLYha6NWiUYAQEgcp5l3j
         u0oLoExYHKwJ7Sxic1SiQGByJkYAe6AFDxZzxPk7gJy0nFPr8m7hmyPWIjGrmHU/dcfo
         omZ0OWskRANG1nK/Cli1aiySnaWw+g8WNHC9B0xr58rSgQk+YPazfmU3s8NdvCMEW/if
         cwizJj4TBQ/JWP50gJeohUsUb9gVRbHW3bvMsldfBdZT4gWe3eJcm3n7gRFhrdpL7HZM
         7Ulg==
X-Gm-Message-State: ANhLgQ0l45zascI2ML1f2s+Y1Dwp8sRNtpD+XQXujZkZ8FZ/FcfEM+T0
        R30ewc/bvHIr6eH+7lMaPBKOCA==
X-Google-Smtp-Source: ADFU+vtQ7QDI/m9me2BsixnCCLZBImKuzbFcg9Epi89olgvg/Y5NE+Rg1Qs2S2J7lAj4lQCVnmzDPg==
X-Received: by 2002:a65:5a4f:: with SMTP id z15mr6873211pgs.103.1585201523086;
        Wed, 25 Mar 2020 22:45:23 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id d1sm727302pfc.3.2020.03.25.22.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 22:45:22 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v2 1/1] Bluetooth: Update add_device with wakeable actions
Date:   Wed, 25 Mar 2020 22:45:17 -0700
Message-Id: <20200325224500.v2.1.I196e4af9cde6c6e6aa7102906722cb9df8c80a7b@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200326054517.71462-1-abhishekpandit@chromium.org>
References: <20200326054517.71462-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new actions to add_device to allow it to set or unset a device as
wakeable. When the set wakeable and unset wakeable actions are used, the
autoconnect property is not updated and the device is not added to the
whitelist (if BR/EDR).

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
* Added missing goto unlock

 net/bluetooth/mgmt.c | 57 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 47 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170e..8643089e758f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5775,6 +5775,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		      void *data, u16 len)
 {
 	struct mgmt_cp_add_device *cp = data;
+	struct hci_conn_params *params;
 	u8 auto_conn, addr_type;
 	int err;
 
@@ -5786,7 +5787,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 					 MGMT_STATUS_INVALID_PARAMS,
 					 &cp->addr, sizeof(cp->addr));
 
-	if (cp->action != 0x00 && cp->action != 0x01 && cp->action != 0x02)
+	if (cp->action > 0x04)
 		return mgmt_cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 					 MGMT_STATUS_INVALID_PARAMS,
 					 &cp->addr, sizeof(cp->addr));
@@ -5794,8 +5795,35 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (cp->addr.type == BDADDR_BREDR) {
-		/* Only incoming connections action is supported for now */
-		if (cp->action != 0x01) {
+		switch (cp->action) {
+		case 0x3:
+			/* Set wakeable */
+			err = hci_bdaddr_list_add(&hdev->wakeable,
+						  &cp->addr.bdaddr,
+						  cp->addr.type);
+			if (err && err != -EEXIST)
+				goto unlock;
+			break;
+		case 0x4:
+			/* Remove wakeable */
+			err = hci_bdaddr_list_del(&hdev->wakeable,
+						  &cp->addr.bdaddr,
+						  cp->addr.type);
+			if (err)
+				goto unlock;
+
+			break;
+		case 0x1:
+			/* Allow incoming connection */
+			err = hci_bdaddr_list_add(&hdev->whitelist,
+						  &cp->addr.bdaddr,
+						  cp->addr.type);
+			if (err && err != -EEXIST)
+				goto unlock;
+
+			hci_req_update_scan(hdev);
+			break;
+		default:
 			err = mgmt_cmd_complete(sk, hdev->id,
 						MGMT_OP_ADD_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS,
@@ -5803,13 +5831,6 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		err = hci_bdaddr_list_add(&hdev->whitelist, &cp->addr.bdaddr,
-					  cp->addr.type);
-		if (err)
-			goto unlock;
-
-		hci_req_update_scan(hdev);
-
 		goto added;
 	}
 
@@ -5834,6 +5855,22 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 		goto unlock;
 	}
 
+	/* Only allow wakeable property to be set/unset on existing device */
+	if (cp->action == 0x03 || cp->action == 0x04) {
+		params = hci_conn_params_lookup(hdev, &cp->addr.bdaddr,
+						addr_type);
+		if (!params) {
+			err = mgmt_cmd_complete(sk, hdev->id,
+						MGMT_OP_ADD_DEVICE,
+						MGMT_STATUS_FAILED, &cp->addr,
+						sizeof(cp->addr));
+			goto unlock;
+		}
+
+		params->wakeable = cp->action == 0x03;
+		goto added;
+	}
+
 	/* If the connection parameters don't exist for this device,
 	 * they will be created and configured with defaults.
 	 */
-- 
2.25.1.696.g5e7596f4ac-goog

