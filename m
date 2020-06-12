Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49BDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:20:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7152520691
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:20:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HfdjK9TQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgFLMUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:20:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:49629 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725791AbgFLMUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:20:49 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591964449; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ImX6KAheCqiFcyKOlsoV5dQHbw5VKKyzEws+R8l2dO4=; b=HfdjK9TQZwEZHJaRPie8DcdbeUllNd1pJqKUF7ArSDy3QNaPe3aVczR+DOotBCGN9/Dvcrjd
 Qs0ecDnaz3QF2pOMMt8r2884HQlwxtB+OsqerOdtCgK/O+aa9gciMM+UgkmGBSRp6J4XHJkw
 FRRsVe25bXW9eFUTQB5YdeKg93Q=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n15.prod.us-east-1.postgun.com with SMTP id
 5ee3731da3d8a4474352b74f (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 12 Jun 2020 12:20:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B789C43387; Fri, 12 Jun 2020 12:20:44 +0000 (UTC)
Received: from bgodavar-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: bgodavar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 88337C433CA;
        Fri, 12 Jun 2020 12:20:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 88337C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=bgodavar@codeaurora.org
From:   Balakrishna Godavarthi <bgodavar@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, abhishekpandit@chromium.org,
        rjliao@codeaurora.org, gubbaven@codeaurora.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Disable SoC debug logging for WCN3991
Date:   Fri, 12 Jun 2020 17:50:28 +0530
Message-Id: <1591964428-9607-1-git-send-email-bgodavar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

By default, WCN3991 sent debug packets to HOST via ACL packet
with header 0xDC2E. This logging is not required on commercial
devices. With this patch SoC logging is disabled post fw
download.

Signed-off-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
 drivers/bluetooth/btqca.c | 27 +++++++++++++++++++++++++++
 drivers/bluetooth/btqca.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
index c598496..ce9dcff 100644
--- a/drivers/bluetooth/btqca.c
+++ b/drivers/bluetooth/btqca.c
@@ -400,6 +400,27 @@ static int qca_download_firmware(struct hci_dev *hdev,
 	return ret;
 }
 
+static int qca_disable_soc_logging(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	u8 cmd[2];
+	int err;
+
+	cmd[0] = QCA_DISABLE_LOGGING_SUB_OP;
+	cmd[1] = 0x00;
+	skb = __hci_cmd_sync_ev(hdev, QCA_DISABLE_LOGGING, sizeof(cmd), cmd,
+				HCI_EV_CMD_COMPLETE, HCI_INIT_TIMEOUT);
+	if (IS_ERR(skb)) {
+		err = PTR_ERR(skb);
+		bt_dev_err(hdev, "QCA Failed to disable soc logging(%d)", err);
+		return err;
+	}
+
+	kfree_skb(skb);
+
+	return 0;
+}
+
 int qca_set_bdaddr_rome(struct hci_dev *hdev, const bdaddr_t *bdaddr)
 {
 	struct sk_buff *skb;
@@ -486,6 +507,12 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t baudrate,
 		return err;
 	}
 
+	if (soc_type >= QCA_WCN3991) {
+		err = qca_disable_soc_logging(hdev);
+		if (err < 0)
+			return err;
+	}
+
 	/* Perform HCI reset */
 	err = qca_send_reset(hdev);
 	if (err < 0) {
diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
index 6e1e62d..d81b74c 100644
--- a/drivers/bluetooth/btqca.h
+++ b/drivers/bluetooth/btqca.h
@@ -14,6 +14,7 @@
 #define EDL_NVM_ACCESS_SET_REQ_CMD	(0x01)
 #define MAX_SIZE_PER_TLV_SEGMENT	(243)
 #define QCA_PRE_SHUTDOWN_CMD		(0xFC08)
+#define QCA_DISABLE_LOGGING		(0xFC17)
 
 #define EDL_CMD_REQ_RES_EVT		(0x00)
 #define EDL_PATCH_VER_RES_EVT		(0x19)
@@ -22,6 +23,7 @@
 #define EDL_CMD_EXE_STATUS_EVT		(0x00)
 #define EDL_SET_BAUDRATE_RSP_EVT	(0x92)
 #define EDL_NVM_ACCESS_CODE_EVT		(0x0B)
+#define QCA_DISABLE_LOGGING_SUB_OP	(0x14)
 
 #define EDL_TAG_ID_HCI			(17)
 #define EDL_TAG_ID_DEEP_SLEEP		(27)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

