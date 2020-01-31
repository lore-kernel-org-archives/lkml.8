Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3686CC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 092C120CC7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728119AbgAaHj2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 02:39:28 -0500
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:63041 "EHLO
        alexa-out-blr-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727525AbgAaHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:39:28 -0500
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr-02.qualcomm.com with ESMTP/TLS/AES256-SHA; 31 Jan 2020 13:09:24 +0530
Received: from gubbaven-linux.qualcomm.com ([10.206.64.32])
  by ironmsg01-blr.qualcomm.com with ESMTP; 31 Jan 2020 13:08:58 +0530
Received: by gubbaven-linux.qualcomm.com (Postfix, from userid 2365015)
        id 1DB9D213CD; Fri, 31 Jan 2020 13:08:57 +0530 (IST)
From:   Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     mka@chromium.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, robh@kernel.org,
        hemantg@codeaurora.org, linux-arm-msm@vger.kernel.org,
        bgodavar@codeaurora.org, tientzu@chromium.org,
        seanpaul@chromium.org, rjliao@codeaurora.org, yshavit@google.com,
        Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
Subject: [PATCH v2 1/2] Bluetooth: hci_qca: Enable clocks required for BT SOC
Date:   Fri, 31 Jan 2020 13:08:54 +0530
Message-Id: <1580456335-7317-1-git-send-email-gubbaven@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of relying on other subsytem to turn ON clocks
required for BT SoC to operate, voting them from the driver.

Signed-off-by: Venkata Lakshmi Narayana Gubba <gubbaven@codeaurora.org>
---
v2:
   * addressed forward declarations
   * updated with devm_clk_get_optional()
 
---
 drivers/bluetooth/hci_qca.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index d6e0c99..73706f3 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -1738,6 +1738,15 @@ static int qca_power_off(struct hci_dev *hdev)
 	return 0;
 }
 
+static int qca_setup_clock(struct clk *clk, bool enable)
+{
+	if (enable)
+		return clk_prepare_enable(clk);
+
+	clk_disable_unprepare(clk);
+	return 0;
+}
+
 static int qca_regulator_enable(struct qca_serdev *qcadev)
 {
 	struct qca_power *power = qcadev->bt_power;
@@ -1755,6 +1764,13 @@ static int qca_regulator_enable(struct qca_serdev *qcadev)
 
 	power->vregs_on = true;
 
+	ret = qca_setup_clock(qcadev->susclk, true);
+	if (ret) {
+		/* Turn off regulators to overcome power leakage */
+		qca_regulator_disable(qcadev);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1773,6 +1789,9 @@ static void qca_regulator_disable(struct qca_serdev *qcadev)
 
 	regulator_bulk_disable(power->num_vregs, power->vreg_bulk);
 	power->vregs_on = false;
+
+	if (qcadev->susclk)
+		qca_setup_clock(qcadev->susclk, false);
 }
 
 static int qca_init_regulators(struct qca_power *qca,
@@ -1839,6 +1858,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 
 		qcadev->bt_power->vregs_on = false;
 
+		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
+		if (IS_ERR(qcadev->susclk)) {
+			dev_err(&serdev->dev, "failed to acquire clk\n");
+			return PTR_ERR(qcadev->susclk);
+		}
+
 		device_property_read_u32(&serdev->dev, "max-speed",
 					 &qcadev->oper_speed);
 		if (!qcadev->oper_speed)
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

