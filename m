Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D821C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 312A5206C0
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 23:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HNyKIyFS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732959AbgCPXCs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 19:02:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40593 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732944AbgCPXCq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 19:02:46 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so10593888pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFldnhHR4FvIlyqPBYaYhGWDFp241P7KWgJl+2anZeM=;
        b=HNyKIyFSg56MAzexNmc1EcKLakALcfZ6WUOT+uw9jO12zez7ADNaTjXxPdyPFdJyge
         ZeFjbRIATLWlbNsttg1zST3WtvB3ZGMjBe+7dXxNTt8jVDCCTATmwEBP81ntSoHvnYRm
         c+IttRqT2+Yl9zTzlpKV2CnfuqHX5DQQutj7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFldnhHR4FvIlyqPBYaYhGWDFp241P7KWgJl+2anZeM=;
        b=uKRjMIb0Pk4wpA94RoE1Y49oEy6Axinz7bYC2gZYfNrxPYkZ26JANptB6UYeCt1qnx
         Nq6+X3F+WA6XRV54PB+Fo1nITBw9vAunGCMUSeCU51zkoqxfgc2U3r9+xA0Vub3p5L5Z
         7aGp+xnmuTHSbydIvmixev5R+k7jeeqPs0TaMwdBQMNIWcp31VrkRxYTAYzu+A2n7FB8
         hQsMDouH5ri/KgZPP2HcjvvaTOyFNRj5oqH3RBkJxTuoMzRKLW9rKEm9b1WhfubVo+Ag
         o/UZ8PlT0k7jqFczEpyqw0SNizv5baYuU+VQoKaEuIqRSVNpl62JUDWENWVf2Ii4AyCW
         5/BA==
X-Gm-Message-State: ANhLgQ1w0ZuXm6VtohSDd6e/cdTYrDgffNttnwY579AWAHl5ZG28HbNt
        zpmshZHsSJc88GCpJN/z5Cn54g==
X-Google-Smtp-Source: ADFU+vsyd3l6BYNoDk6jaL1eugHapfGyKaomhfILyN8S5k/+SwzY1HqOD31nswmWGtADhlZjJm+3HQ==
X-Received: by 2002:a63:c20e:: with SMTP id b14mr1998907pgd.394.1584399763669;
        Mon, 16 Mar 2020 16:02:43 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4fff:7a6b:a335:8fde])
        by smtp.gmail.com with ESMTPSA id a18sm884587pfr.109.2020.03.16.16.02.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Mar 2020 16:02:43 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Harish Bandi <c-hbandi@codeaurora.org>,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>,
        Rocky Liao <rjliao@codeaurora.org>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH 2/2] Bluetooth: hci_qca: consolidate memdump fields in a struct
Date:   Mon, 16 Mar 2020 16:02:33 -0700
Message-Id: <20200316160202.2.I7dd277f9093996ec8c3918f296c9454b4a61f1e8@changeid>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
In-Reply-To: <20200316230233.138696-1-mka@chromium.org>
References: <20200316230233.138696-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move memdump related fields from 'struct qca_data' to a dedicated
struct which is part of 'struct qca_data'.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---

 drivers/bluetooth/hci_qca.c | 107 +++++++++++++++++++-----------------
 1 file changed, 56 insertions(+), 51 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index c578c7c92680a6..662fa9b5554d4d 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -164,21 +164,26 @@ struct qca_ibs {
 	struct qca_ibs_stats stats;
 };
 
+struct qca_memdump {
+	struct sk_buff_head rx_q;	/* Memdump wait queue	*/
+	struct work_struct ctrl_evt;
+	struct delayed_work ctrl_timeout;
+	struct qca_memdump_data *data;
+	enum qca_memdump_states state;
+	struct mutex lock;
+};
+
 struct qca_data {
 	struct hci_uart *hu;
 	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
-	struct sk_buff_head rx_memdump_q;	/* Memdump wait queue	*/
+
 	struct workqueue_struct *workqueue;
-	struct work_struct ctrl_memdump_evt;
-	struct delayed_work ctrl_memdump_timeout;
-	struct qca_memdump_data *qca_memdump;
 	struct qca_ibs ibs;
+	struct qca_memdump memdump;
 	unsigned long flags;
 	struct completion drop_ev_comp;
 	wait_queue_head_t suspend_wait_q;
-	enum qca_memdump_states memdump_state;
-	struct mutex hci_memdump_lock;
 };
 
 enum qca_speed_type {
@@ -539,12 +544,12 @@ static void hci_ibs_wake_retrans_timeout(struct timer_list *t)
 static void qca_controller_memdump_timeout(struct work_struct *work)
 {
 	struct qca_data *qca = container_of(work, struct qca_data,
-					ctrl_memdump_timeout.work);
+					memdump.ctrl_timeout.work);
 	struct hci_uart *hu = qca->hu;
 
-	mutex_lock(&qca->hci_memdump_lock);
+	mutex_lock(&qca->memdump.lock);
 	if (test_bit(QCA_MEMDUMP_COLLECTION, &qca->flags)) {
-		qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
+		qca->memdump.state = QCA_MEMDUMP_TIMEOUT;
 		if (!test_bit(QCA_HW_ERROR_EVENT, &qca->flags)) {
 			/* Inject hw error event to reset the device
 			 * and driver.
@@ -553,7 +558,7 @@ static void qca_controller_memdump_timeout(struct work_struct *work)
 		}
 	}
 
-	mutex_unlock(&qca->hci_memdump_lock);
+	mutex_unlock(&qca->memdump.lock);
 }
 
 
@@ -574,9 +579,9 @@ static int qca_open(struct hci_uart *hu)
 
 	skb_queue_head_init(&qca->txq);
 	skb_queue_head_init(&qca->ibs.tx_wait_q);
-	skb_queue_head_init(&qca->rx_memdump_q);
+	skb_queue_head_init(&qca->memdump.rx_q);
 	spin_lock_init(&qca->ibs.lock);
-	mutex_init(&qca->hci_memdump_lock);
+	mutex_init(&qca->memdump.lock);
 	qca->workqueue = alloc_ordered_workqueue("qca_wq", 0);
 	if (!qca->workqueue) {
 		BT_ERR("QCA Workqueue not initialized properly");
@@ -588,8 +593,8 @@ static int qca_open(struct hci_uart *hu)
 	INIT_WORK(&qca->ibs.ws_awake_device, qca_wq_awake_device);
 	INIT_WORK(&qca->ibs.ws_rx_vote_off, qca_wq_serial_rx_clock_vote_off);
 	INIT_WORK(&qca->ibs.ws_tx_vote_off, qca_wq_serial_tx_clock_vote_off);
-	INIT_WORK(&qca->ctrl_memdump_evt, qca_controller_memdump);
-	INIT_DELAYED_WORK(&qca->ctrl_memdump_timeout,
+	INIT_WORK(&qca->memdump.ctrl_evt, qca_controller_memdump);
+	INIT_DELAYED_WORK(&qca->memdump.ctrl_timeout,
 			  qca_controller_memdump_timeout);
 	init_waitqueue_head(&qca->suspend_wait_q);
 
@@ -704,7 +709,7 @@ static int qca_close(struct hci_uart *hu)
 
 	skb_queue_purge(&qca->ibs.tx_wait_q);
 	skb_queue_purge(&qca->txq);
-	skb_queue_purge(&qca->rx_memdump_q);
+	skb_queue_purge(&qca->memdump.rx_q);
 	del_timer(&qca->ibs.tx_idle_timer);
 	del_timer(&qca->ibs.wake_retrans_timer);
 	destroy_workqueue(qca->workqueue);
@@ -979,23 +984,23 @@ static int qca_recv_acl_data(struct hci_dev *hdev, struct sk_buff *skb)
 static void qca_controller_memdump(struct work_struct *work)
 {
 	struct qca_data *qca = container_of(work, struct qca_data,
-					    ctrl_memdump_evt);
+					    memdump.ctrl_evt);
 	struct hci_uart *hu = qca->hu;
 	struct sk_buff *skb;
 	struct qca_memdump_event_hdr *cmd_hdr;
-	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
+	struct qca_memdump_data *qca_memdump = qca->memdump.data;
 	struct qca_dump_size *dump;
 	char *memdump_buf;
 	char nullBuff[QCA_DUMP_PACKET_SIZE] = { 0 };
 	u16 seq_no;
 	u32 dump_size;
 
-	while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
+	while ((skb = skb_dequeue(&qca->memdump.rx_q))) {
 
-		mutex_lock(&qca->hci_memdump_lock);
+		mutex_lock(&qca->memdump.lock);
 		/* Skip processing the received packets if timeout detected. */
-		if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT) {
-			mutex_unlock(&qca->hci_memdump_lock);
+		if (qca->memdump.state == QCA_MEMDUMP_TIMEOUT) {
+			mutex_unlock(&qca->memdump.lock);
 			return;
 		}
 
@@ -1003,14 +1008,14 @@ static void qca_controller_memdump(struct work_struct *work)
 			qca_memdump = kzalloc(sizeof(struct qca_memdump_data),
 					      GFP_ATOMIC);
 			if (!qca_memdump) {
-				mutex_unlock(&qca->hci_memdump_lock);
+				mutex_unlock(&qca->memdump.lock);
 				return;
 			}
 
-			qca->qca_memdump = qca_memdump;
+			qca->memdump.data = qca_memdump;
 		}
 
-		qca->memdump_state = QCA_MEMDUMP_COLLECTING;
+		qca->memdump.state = QCA_MEMDUMP_COLLECTING;
 		cmd_hdr = (void *) skb->data;
 		seq_no = __le16_to_cpu(cmd_hdr->seq_no);
 		skb_pull(skb, sizeof(struct qca_memdump_event_hdr));
@@ -1030,14 +1035,14 @@ static void qca_controller_memdump(struct work_struct *work)
 			if (!(dump_size)) {
 				bt_dev_err(hu->hdev, "Rx invalid memdump size");
 				kfree_skb(skb);
-				mutex_unlock(&qca->hci_memdump_lock);
+				mutex_unlock(&qca->memdump.lock);
 				return;
 			}
 
 			bt_dev_info(hu->hdev, "QCA collecting dump of size:%u",
 				    dump_size);
 			queue_delayed_work(qca->workqueue,
-					   &qca->ctrl_memdump_timeout,
+					   &qca->memdump.ctrl_timeout,
 					msecs_to_jiffies(MEMDUMP_TIMEOUT_MS));
 
 			skb_pull(skb, sizeof(dump_size));
@@ -1055,8 +1060,8 @@ static void qca_controller_memdump(struct work_struct *work)
 			bt_dev_err(hu->hdev, "QCA: Discarding other packets");
 			kfree(qca_memdump);
 			kfree_skb(skb);
-			qca->qca_memdump = NULL;
-			mutex_unlock(&qca->hci_memdump_lock);
+			qca->memdump.data = NULL;
+			mutex_unlock(&qca->memdump.lock);
 			return;
 		}
 
@@ -1079,7 +1084,7 @@ static void qca_controller_memdump(struct work_struct *work)
 		qca_memdump->memdump_buf_tail = memdump_buf;
 		qca_memdump->current_seq_no = seq_no + 1;
 		qca_memdump->received_dump += skb->len;
-		qca->qca_memdump = qca_memdump;
+		qca->memdump.data = qca_memdump;
 		kfree_skb(skb);
 		if (seq_no == QCA_LAST_SEQUENCE_NUM) {
 			bt_dev_info(hu->hdev, "QCA writing crash dump of size %d bytes",
@@ -1087,14 +1092,14 @@ static void qca_controller_memdump(struct work_struct *work)
 			memdump_buf = qca_memdump->memdump_buf_head;
 			dev_coredumpv(&hu->serdev->dev, memdump_buf,
 				      qca_memdump->received_dump, GFP_KERNEL);
-			cancel_delayed_work(&qca->ctrl_memdump_timeout);
-			kfree(qca->qca_memdump);
-			qca->qca_memdump = NULL;
-			qca->memdump_state = QCA_MEMDUMP_COLLECTED;
+			cancel_delayed_work(&qca->memdump.ctrl_timeout);
+			kfree(qca->memdump.data);
+			qca->memdump.data = NULL;
+			qca->memdump.state = QCA_MEMDUMP_COLLECTED;
 			clear_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 		}
 
-		mutex_unlock(&qca->hci_memdump_lock);
+		mutex_unlock(&qca->memdump.lock);
 	}
 
 }
@@ -1105,8 +1110,8 @@ static int qca_controller_memdump_event(struct hci_dev *hdev,
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
 
-	skb_queue_tail(&qca->rx_memdump_q, skb);
-	queue_work(qca->workqueue, &qca->ctrl_memdump_evt);
+	skb_queue_tail(&qca->memdump.rx_q, skb);
+	queue_work(qca->workqueue, &qca->memdump.ctrl_evt);
 
 	return 0;
 }
@@ -1462,13 +1467,13 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
-	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
+	struct qca_memdump_data *qca_memdump = qca->memdump.data;
 	char *memdump_buf = NULL;
 
 	set_bit(QCA_HW_ERROR_EVENT, &qca->flags);
-	bt_dev_info(hdev, "mem_dump_status: %d", qca->memdump_state);
+	bt_dev_info(hdev, "mem_dump_status: %d", qca->memdump.state);
 
-	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
+	if (qca->memdump.state == QCA_MEMDUMP_IDLE) {
 		/* If hardware error event received for other than QCA
 		 * soc memory dump event, then we need to crash the SOC
 		 * and wait here for 8 seconds to get the dump packets.
@@ -1478,7 +1483,7 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 		set_bit(QCA_MEMDUMP_COLLECTION, &qca->flags);
 		qca_send_crashbuffer(hu);
 		qca_wait_for_dump_collection(hdev);
-	} else if (qca->memdump_state == QCA_MEMDUMP_COLLECTING) {
+	} else if (qca->memdump.state == QCA_MEMDUMP_COLLECTING) {
 		/* Let us wait here until memory dump collected or
 		 * memory dump timer expired.
 		 */
@@ -1486,19 +1491,19 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 		qca_wait_for_dump_collection(hdev);
 	}
 
-	if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
+	if (qca->memdump.state != QCA_MEMDUMP_COLLECTED) {
 		bt_dev_err(hu->hdev, "clearing allocated memory due to memdump timeout");
-		mutex_lock(&qca->hci_memdump_lock);
+		mutex_lock(&qca->memdump.lock);
 		if (qca_memdump)
 			memdump_buf = qca_memdump->memdump_buf_head;
 		vfree(memdump_buf);
 		kfree(qca_memdump);
-		qca->qca_memdump = NULL;
-		qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
-		cancel_delayed_work(&qca->ctrl_memdump_timeout);
-		skb_queue_purge(&qca->rx_memdump_q);
-		mutex_unlock(&qca->hci_memdump_lock);
-		cancel_work_sync(&qca->ctrl_memdump_evt);
+		qca->memdump.data = NULL;
+		qca->memdump.state = QCA_MEMDUMP_TIMEOUT;
+		cancel_delayed_work(&qca->memdump.ctrl_timeout);
+		skb_queue_purge(&qca->memdump.rx_q);
+		mutex_unlock(&qca->memdump.lock);
+		cancel_work_sync(&qca->memdump.ctrl_evt);
 	}
 
 	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
@@ -1509,7 +1514,7 @@ static void qca_cmd_timeout(struct hci_dev *hdev)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
 
-	if (qca->memdump_state == QCA_MEMDUMP_IDLE)
+	if (qca->memdump.state == QCA_MEMDUMP_IDLE)
 		qca_send_crashbuffer(hu);
 	else
 		bt_dev_info(hdev, "Dump collection is in process");
@@ -1781,12 +1786,12 @@ static int qca_power_off(struct hci_dev *hdev)
 	struct qca_data *qca = hu->priv;
 
 	/* Stop sending shutdown command if soc crashes. */
-	if (qca->memdump_state == QCA_MEMDUMP_IDLE) {
+	if (qca->memdump.state == QCA_MEMDUMP_IDLE) {
 		qca_send_pre_shutdown_cmd(hdev);
 		usleep_range(8000, 10000);
 	}
 
-	qca->memdump_state = QCA_MEMDUMP_IDLE;
+	qca->memdump.state = QCA_MEMDUMP_IDLE;
 	qca_power_shutdown(hu);
 	return 0;
 }
-- 
2.25.1.481.gfbce0eb801-goog

