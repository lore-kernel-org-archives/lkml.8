Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF570C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8586220848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 01:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="e65oJ0jZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgCDByt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 20:54:49 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:39628 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727865AbgCDBys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 20:54:48 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583286887; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2d5Y262DePEIPIUR2yBAB0B/4RF7KzllNdIYcmBIQ6I=; b=e65oJ0jZ/nk+sJ76Gf/oCGf7Bh/uNXtNa7sMDMv9JTuv2Dl245ja32tUlTLir3ZDo+oY3QiO
 tAfHx3mhpOqEC8d6WsEoOgoqA/+WmNYxa0oaAn1pHGnTrqJN8A8jPoen9hXqegW8+8fq6+aR
 9pAVi7o/yeEyBucjfAwxk7ho3Mo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e5f0a5c.7f5af96f1dc0-smtp-out-n03;
 Wed, 04 Mar 2020 01:54:36 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 329CFC447A0; Wed,  4 Mar 2020 01:54:36 +0000 (UTC)
Received: from rocky-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rjliao)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2D726C43383;
        Wed,  4 Mar 2020 01:54:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2D726C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=rjliao@codeaurora.org
From:   Rocky Liao <rjliao@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org, mka@chromium.org,
        Rocky Liao <rjliao@codeaurora.org>
Subject: [PATCH v1] Bluetooth: hci_qca: Make bt_en and susclk not mandatory for QCA Rome
Date:   Wed,  4 Mar 2020 09:54:29 +0800
Message-Id: <20200304015429.20615-1-rjliao@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some platforms the bt_en pin and susclk are default on and there
is no exposed resource to control them. This patch makes the bt_en
and susclk not mandatory to have BT work. It also will not set the
HCI_QUIRK_NON_PERSISTENT_SETUP and shutdown() callback if bt_en is
not available.

Signed-off-by: Rocky Liao <rjliao@codeaurora.org>
---
 drivers/bluetooth/hci_qca.c | 47 ++++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index bf436d6e638e..325baa046c3a 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1562,9 +1562,11 @@ static int qca_power_on(struct hci_dev *hdev)
 		ret = qca_wcn3990_init(hu);
 	} else {
 		qcadev = serdev_device_get_drvdata(hu->serdev);
-		gpiod_set_value_cansleep(qcadev->bt_en, 1);
-		/* Controller needs time to bootup. */
-		msleep(150);
+		if (!IS_ERR(qcadev->bt_en)) {
+			gpiod_set_value_cansleep(qcadev->bt_en, 1);
+			/* Controller needs time to bootup. */
+			msleep(150);
+		}
 	}
 
 	return ret;
@@ -1750,7 +1752,7 @@ static void qca_power_shutdown(struct hci_uart *hu)
 		host_set_baudrate(hu, 2400);
 		qca_send_power_pulse(hu, false);
 		qca_regulator_disable(qcadev);
-	} else {
+	} else if (!IS_ERR(qcadev->bt_en)) {
 		gpiod_set_value_cansleep(qcadev->bt_en, 0);
 	}
 }
@@ -1852,6 +1854,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 	struct hci_dev *hdev;
 	const struct qca_vreg_data *data;
 	int err;
+	bool power_ctrl_enabled = true;
 
 	qcadev = devm_kzalloc(&serdev->dev, sizeof(*qcadev), GFP_KERNEL);
 	if (!qcadev)
@@ -1901,35 +1904,37 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		qcadev->bt_en = devm_gpiod_get(&serdev->dev, "enable",
 					       GPIOD_OUT_LOW);
 		if (IS_ERR(qcadev->bt_en)) {
-			dev_err(&serdev->dev, "failed to acquire enable gpio\n");
-			return PTR_ERR(qcadev->bt_en);
+			dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
+			power_ctrl_enabled = false;
 		}
 
 		qcadev->susclk = devm_clk_get(&serdev->dev, NULL);
 		if (IS_ERR(qcadev->susclk)) {
-			dev_err(&serdev->dev, "failed to acquire clk\n");
-			return PTR_ERR(qcadev->susclk);
-		}
-
-		err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
-		if (err)
-			return err;
+			dev_warn(&serdev->dev, "failed to acquire clk\n");
+		} else {
+			err = clk_set_rate(qcadev->susclk, SUSCLK_RATE_32KHZ);
+			if (err)
+				return err;
 
-		err = clk_prepare_enable(qcadev->susclk);
-		if (err)
-			return err;
+			err = clk_prepare_enable(qcadev->susclk);
+			if (err)
+				return err;
+		}
 
 		err = hci_uart_register_device(&qcadev->serdev_hu, &qca_proto);
 		if (err) {
 			BT_ERR("Rome serdev registration failed");
-			clk_disable_unprepare(qcadev->susclk);
+			if (!IS_ERR(qcadev->susclk))
+				clk_disable_unprepare(qcadev->susclk);
 			return err;
 		}
 	}
 
-	hdev = qcadev->serdev_hu.hdev;
-	set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
-	hdev->shutdown = qca_power_off;
+	if (power_ctrl_enabled) {
+		hdev = qcadev->serdev_hu.hdev;
+		set_bit(HCI_QUIRK_NON_PERSISTENT_SETUP, &hdev->quirks);
+		hdev->shutdown = qca_power_off;
+	}
 
 	return 0;
 }
@@ -1940,7 +1945,7 @@ static void qca_serdev_remove(struct serdev_device *serdev)
 
 	if (qca_is_wcn399x(qcadev->btsoc_type))
 		qca_power_shutdown(&qcadev->serdev_hu);
-	else
+	else if (!IS_ERR(qcadev->susclk))
 		clk_disable_unprepare(qcadev->susclk);
 
 	hci_uart_unregister_device(&qcadev->serdev_hu);
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
