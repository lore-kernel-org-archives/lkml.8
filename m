Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20F8CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09AA52072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 15:57:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbgFIP5h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 11:57:37 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:19073 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728888AbgFIP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 11:57:36 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 09 Jun 2020 21:27:33 +0530
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg01-blr.qualcomm.com with ESMTP; 09 Jun 2020 21:27:12 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 40474216F2; Tue,  9 Jun 2020 21:27:11 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v2] Bluetooth: hci_qca: Bug fix during SSR timeout
Date:   Tue,  9 Jun 2020 21:27:08 +0530
Message-Id: <1591718228-18819-1-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to race conditions between qca_hw_error and qca_controller_memdump
during SSR timeout,the same pointer is freed twice. This results in a
double free. Now a lock is acquired before checking the stauts of SSR
state.

Fixes: d841502c79e3 ("Bluetooth: hci_qca: Collect controller memory dump during SSR")
Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 28c34a1..f3fde99 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -981,8 +981,11 @@ static void qca_controller_memdump(struct work_struct *work)
 	while ((skb = skb_dequeue(&qca->rx_memdump_q))) {
 
 		mutex_lock(&qca->hci_memdump_lock);
-		/* Skip processing the received packets if timeout detected. */
-		if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT) {
+		/* Skip processing the received packets if timeout detected
+		 * or memdump collection completed.
+		 */
+		if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT ||
+		    qca->memdump_state == QCA_MEMDUMP_COLLECTED) {
 			mutex_unlock(&qca->hci_memdump_lock);
 			return;
 		}
@@ -1483,8 +1486,6 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 {
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct qca_data *qca = hu->priv;
-	struct qca_memdump_data *qca_memdump = qca->qca_memdump;
-	char *memdump_buf = NULL;
 
 	set_bit(QCA_HW_ERROR_EVENT, &qca->flags);
 	bt_dev_info(hdev, "mem_dump_status: %d", qca->memdump_state);
@@ -1507,19 +1508,23 @@ static void qca_hw_error(struct hci_dev *hdev, u8 code)
 		qca_wait_for_dump_collection(hdev);
 	}
 
+	mutex_lock(&qca->hci_memdump_lock);
 	if (qca->memdump_state != QCA_MEMDUMP_COLLECTED) {
 		bt_dev_err(hu->hdev, "clearing allocated memory due to memdump timeout");
-		mutex_lock(&qca->hci_memdump_lock);
-		if (qca_memdump)
-			memdump_buf = qca_memdump->memdump_buf_head;
-		vfree(memdump_buf);
-		kfree(qca_memdump);
-		qca->qca_memdump = NULL;
+		if (qca->qca_memdump) {
+			vfree(qca->qca_memdump->memdump_buf_head);
+			kfree(qca->qca_memdump);
+			qca->qca_memdump = NULL;
+		}
 		qca->memdump_state = QCA_MEMDUMP_TIMEOUT;
 		cancel_delayed_work(&qca->ctrl_memdump_timeout);
-		skb_queue_purge(&qca->rx_memdump_q);
-		mutex_unlock(&qca->hci_memdump_lock);
+	}
+	mutex_unlock(&qca->hci_memdump_lock);
+
+	if (qca->memdump_state == QCA_MEMDUMP_TIMEOUT ||
+	    qca->memdump_state == QCA_MEMDUMP_COLLECTED) {
 		cancel_work_sync(&qca->ctrl_memdump_evt);
+		skb_queue_purge(&qca->rx_memdump_q);
 	}
 
 	clear_bit(QCA_HW_ERROR_EVENT, &qca->flags);
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

