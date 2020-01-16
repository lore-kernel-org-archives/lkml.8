Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CCBC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:23:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A64EA2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 03:23:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="cMgX6n3a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgAPDXJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 22:23:09 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:51451 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726552AbgAPDXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 22:23:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1579144987; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=i6cUUbHdFxmyxXtrww4Y2pJJyGUa7lN7JxrT7wp+jjg=; b=cMgX6n3aAIDhKAlY020Eix88hr5aDJyd01WIx7SpyeODUW8ZsZxf98c5QqCs4UVrUYX2ksYG
 PlXvWn+cpFmfpUnYqJTfGgYkKLByz3ZACpq+9u5UwS2oJWEhIdZ+8UcT98lX+cEaKh5FAGwK
 OZPLbpyjcXPu9ufpEXlLLR/UXkA=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e1fd71a.7f48c320cc00-smtp-out-n03;
 Thu, 16 Jan 2020 03:23:06 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DA8BFC43383; Thu, 16 Jan 2020 03:23:06 +0000 (UTC)
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DDB28C433A2;
        Thu, 16 Jan 2020 03:23:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DDB28C433A2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, hemantg@codeaurora.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v5] Bluetooth: hci_qca: Enable power off/on support during hci down/up for QCA Rome
Date:   Thu, 16 Jan 2020 11:22:54 +0800
Message-Id: <20200116032254.20549-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191225060317.5258-1-rjliao@codeaurora.org>
References: <20191225060317.5258-1-rjliao@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch registers hdev->shutdown() callback and also sets
HCI_QUIRK_NON_PERSISTENT_SETUP for QCA Rome. It will power-off the BT chip
during hci down and power-on/initialize the chip again during hci up. As
wcn399x already enabled this, this patch also removed the callback register
and QUIRK setting in qca_setup() for wcn399x and uniformly do this in the
probe() routine.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---

Changes in v2: None
Changes in v3:
  -moved the quirk and callback register to probe()
Changes in v4:
  -rebased the patch with latest code
  -moved the quirk and callback register to probe() for wcn399x
  -updated commit message
Changed in v5:
  -removed the "out" label and return err when fails

 drivers/bluetooth/hci_qca.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index 1139142e8eed..d6e0c99ee5eb 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1569,12 +1569,7 @@ static int qca_setup(struct hci_uart *hu)
 		return ret;
 
 	if (qca_is_wcn399x(soc_type)) {
-		/* Enable NON_PERSISTENT_SETUP QUIRK to ensure to execute
-		 * setup for every hci up.
-		 */
-		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
 		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
-		hu->hdev->shutdown = qca_power_off;
 
 		ret = qca_read_soc_version(hdev, &soc_ver, soc_type);
 		if (ret)
@@ -1813,6 +1808,7 @@ static int qca_init_regulators(struct qca_power *qca,
 static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
+	struct hci_dev *hdev;
 	const struct qca_vreg_data *data;
 	int err;
 
@@ -1838,7 +1834,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 					  data->num_vregs);
 		if (err) {
 			BT_ERR("Failed to init regulators:%d", err);
-			goto out;
+			return err;
 		}
 
 		qcadev->bt_power->vregs_on = false;
@@ -1851,7 +1847,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 		if (err) {
 			BT_ERR("wcn3990 serdev registration failed");
-			goto out;
+			return err;
 		}
 	} else {
 		qcadev->btsoc_type = QCA_ROME;
@@ -1877,12 +1873,18 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 			return err;
 
 		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
-		if (err)
+		if (err) {
+			BT_ERR("Rome serdev registration failed");
 			clk_disable_unprepare(qcadev->susclk);
+			return err;
+		}
 	}
 
-out:	return err;
+	hdev = qcadev->serdev_hu.hdev;
+	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+	hdev->shutdown = qca_power_off;
 
+	return 0;
 }
 
 static void qca_serdev_remove(struct serdev_device *serdev)
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
