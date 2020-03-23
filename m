Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A103C10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3797520714
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FQCzKzSn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgCWTpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:45:17 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:35381 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgCWTpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:45:16 -0400
Received: by mail-pj1-f65.google.com with SMTP id g9so325352pjp.0
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 12:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gz4rDOjXchjqPi1nEVVmXK3+btJI8g3SNGoz9O5jtbU=;
        b=FQCzKzSnrYYmQWC2CSbKEn/Y+a4mEjYl0yrAbXpAW6bEpGUFofnjCIVRVNdfJ6grza
         6NQAXeuDPyK+Lgcqz9xjCE+OjQeoi/IKhLMIn8k369vrvYlj3lEoYjsp7iQnSDAYAbwk
         qgOBdQop3YcOTsD60DA2yneHrqsE2QnNHNaJs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gz4rDOjXchjqPi1nEVVmXK3+btJI8g3SNGoz9O5jtbU=;
        b=gGMJLzmXJfDRL6Kh0CvegeQky99/No4NbIl0+uqokKlLo9C8W5Q9VsmUdXAIuGJx8m
         hNGHSI8MTjbe2s/buqxUrt+urEIW3BmtUpY59aaZvnB/cKpKnJrZlNwH5+hLK6LG4/Jh
         Y9WlfOZU6f2Wg3fosZQHSsBdznQc53XYGXWBCZEb9j1Qt6JieJDeQ3EJq6AQan4Yd/11
         pc8cqph5eMHETBq656i+NA7Vy6cgUx7arSGLoCHz/1aRwvuoFKZaRwqVCo5z0uE6ykc4
         PsNZtEw55UnfSdMt8+WB1/gHeNS1QfePbMKfn+U1ORYqTwHAQyQ4IYupMlg7cRTife3C
         fsbQ==
X-Gm-Message-State: ANhLgQ0mCAhxAi7Mc9RFKTYtV2xkDOx2pJZKl9D4QnfPtEe3tlEugCpV
        /9hnKkiel6vBitL+sUzboQjAOQSJikE=
X-Google-Smtp-Source: ADFU+vtgxL11HS2OubBV8XWWkYQpV6F4ZBoCjXnruDl0thaI8CAUmp203GJx1kAPo9hxrSPL2dkAyw==
X-Received: by 2002:a17:90a:3188:: with SMTP id j8mr1058249pjb.82.1584992714874;
        Mon, 23 Mar 2020 12:45:14 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id s98sm344857pjb.46.2020.03.23.12.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 12:45:14 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Cc:     chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH v3 1/1] Bluetooth: Prioritize SCO traffic
Date:   Mon, 23 Mar 2020 12:45:07 -0700
Message-Id: <20200323124503.v3.1.I17e2220fd0c0822c76a15ef89b882fb4cfe3fe89@changeid>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200323194507.90944-1-abhishekpandit@chromium.org>
References: <20200323194507.90944-1-abhishekpandit@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When scheduling TX packets, send all SCO/eSCO packets first, check for
pending SCO/eSCO packets after every ACL/LE packet and send them if any
are pending.  This is done to make sure that we can meet SCO deadlines
on slow interfaces like UART.

If we were to queue up multiple ACL packets without checking for a SCO
packet, we might miss the SCO timing. For example:

The time it takes to send a maximum size ACL packet (1024 bytes):
t = 10/8 * 1024 bytes * 8 bits/byte * 1 packet / baudrate
        where 10/8 is uart overhead due to start/stop bits per byte

Replace t = 3.75ms (SCO deadline), which gives us a baudrate of 2730666.

At a baudrate of 3000000, if we didn't check for SCO packets within 1024
bytes, we would miss the 3.75ms timing window.

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v3:
* Removed hci_sched_sync

Changes in v2:
* Refactor to check for SCO/eSCO after each ACL/LE packet sent
* Enabled SCO priority all the time and removed the sched_limit variable

 net/bluetooth/hci_core.c | 106 +++++++++++++++++++++------------------
 1 file changed, 57 insertions(+), 49 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index dbd2ad3a26ed..9e5d7662a047 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4239,6 +4239,54 @@ static void __check_timeout(struct hci_dev *hdev, unsigned int cnt)
 	}
 }
 
+/* Schedule SCO */
+static void hci_sched_sco(struct hci_dev *hdev)
+{
+	struct hci_conn *conn;
+	struct sk_buff *skb;
+	int quote;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!hci_conn_num(hdev, SCO_LINK))
+		return;
+
+	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+			BT_DBG("skb %p len %d", skb, skb->len);
+			hci_send_frame(hdev, skb);
+
+			conn->sent++;
+			if (conn->sent == ~0)
+				conn->sent = 0;
+		}
+	}
+}
+
+static void hci_sched_esco(struct hci_dev *hdev)
+{
+	struct hci_conn *conn;
+	struct sk_buff *skb;
+	int quote;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!hci_conn_num(hdev, ESCO_LINK))
+		return;
+
+	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK,
+						     &quote))) {
+		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+			BT_DBG("skb %p len %d", skb, skb->len);
+			hci_send_frame(hdev, skb);
+
+			conn->sent++;
+			if (conn->sent == ~0)
+				conn->sent = 0;
+		}
+	}
+}
+
 static void hci_sched_acl_pkt(struct hci_dev *hdev)
 {
 	unsigned int cnt = hdev->acl_cnt;
@@ -4270,6 +4318,10 @@ static void hci_sched_acl_pkt(struct hci_dev *hdev)
 			hdev->acl_cnt--;
 			chan->sent++;
 			chan->conn->sent++;
+
+			/* Send pending SCO packets right away */
+			hci_sched_sco(hdev);
+			hci_sched_esco(hdev);
 		}
 	}
 
@@ -4354,54 +4406,6 @@ static void hci_sched_acl(struct hci_dev *hdev)
 	}
 }
 
-/* Schedule SCO */
-static void hci_sched_sco(struct hci_dev *hdev)
-{
-	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote;
-
-	BT_DBG("%s", hdev->name);
-
-	if (!hci_conn_num(hdev, SCO_LINK))
-		return;
-
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
-
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
-		}
-	}
-}
-
-static void hci_sched_esco(struct hci_dev *hdev)
-{
-	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote;
-
-	BT_DBG("%s", hdev->name);
-
-	if (!hci_conn_num(hdev, ESCO_LINK))
-		return;
-
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK,
-						     &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(hdev, skb);
-
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
-		}
-	}
-}
-
 static void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
@@ -4436,6 +4440,10 @@ static void hci_sched_le(struct hci_dev *hdev)
 			cnt--;
 			chan->sent++;
 			chan->conn->sent++;
+
+			/* Send pending SCO packets right away */
+			hci_sched_sco(hdev);
+			hci_sched_esco(hdev);
 		}
 	}
 
@@ -4458,9 +4466,9 @@ static void hci_tx_work(struct work_struct *work)
 
 	if (!hci_dev_test_flag(hdev, HCI_USER_CHANNEL)) {
 		/* Schedule queues and send stuff to HCI driver */
-		hci_sched_acl(hdev);
 		hci_sched_sco(hdev);
 		hci_sched_esco(hdev);
+		hci_sched_acl(hdev);
 		hci_sched_le(hdev);
 	}
 
-- 
2.25.1.696.g5e7596f4ac-goog

