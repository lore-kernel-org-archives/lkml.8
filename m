Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694D7C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFCD2078E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 05:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Gav9O9yd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgCZFmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 01:42:08 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:45416 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbgCZFmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 01:42:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id o26so2316756pgc.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 22:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GAtp02xkzcXTpQVd6eNZ6e9QAobCmX4PQ/bu6ncX+V8=;
        b=Gav9O9ydwdK++YUnd3IMS6cNflMzwIphGTaGQJBtPJx+iXD2x0HBVJYtMggTQZlnZQ
         Ed4lwh6OvbtumiMpLwpLntyFkFWb5GcSirNrgYv+WvnzvT2M7wrqEPqo4DP/ASZGd0/Q
         ix5lqjduBOwfPM7cxgUisfwdbx9i2xAAmPklA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GAtp02xkzcXTpQVd6eNZ6e9QAobCmX4PQ/bu6ncX+V8=;
        b=Os0YgJ/DKHwgYQVaHzH1jbl9CUP2SUrtnhG5VvrcC5U1K0vZf1uMJS8s7JC3TtWVLL
         zFQQLX+9LX7F8HnY0Hyj2wq+Ki0xforLtDH+57It4pEoTv/sRoMeNfor0hAu1A7e/I+f
         ADwZdB7+4wLILWPJT8V0ddEZUlbmoAdsl04RH2wK+MZECSf+pnkklXe+mtYLGl8Q0PwV
         p4eL/+U6DEd3kd2VaglOohdqvIEUEIGMTDMyWHjjnDT5OvxWeR4+/XPU+QWEO1x81T6v
         pJUjdQpjZFxcTRTMvcK3XC5vC3ItKLbCYWbJq/CkVO/OL+nwLFRotpPsCGcPHBDdflR0
         gScQ==
X-Gm-Message-State: ANhLgQ0yLGhgNGjSMrZBQshT5ipbhxXco/qylaU/2RqqL9Lkw/82Z4CJ
        KPZEXC6ZJATtYYlFcXcB8aIL4Q==
X-Google-Smtp-Source: ADFU+vsZgMeDCxKHPHjGYbZhk8LncJ1ytMqCvgZsIcf8XqiYbTF3nFfv9g0EuUyt27Crks0bIfsmHg==
X-Received: by 2002:a62:ce8a:: with SMTP id y132mr7013942pfg.163.1585201326283;
        Wed, 25 Mar 2020 22:42:06 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b3sm710855pgs.69.2020.03.25.22.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 22:42:05 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org
Cc:     linux-bluetooth@vger.kernel.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 1/1] Bluetooth: Update add_device with wakeable actions
Date:   Wed, 25 Mar 2020 22:39:17 -0700
Message-Id: <20200325223803.1.I196e4af9cde6c6e6aa7102906722cb9df8c80a7b@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200326053917.65024-1-abhishekpandit@chromium.org>
References: <20200326053917.65024-1-abhishekpandit@chromium.org>
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

 net/bluetooth/mgmt.c | 56 ++++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6552003a170e..8688673542b3 100644
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
 
@@ -5834,6 +5855,21 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
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

