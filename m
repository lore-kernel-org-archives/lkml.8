Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782A8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FA22065F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 20:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kMwWd2No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgENUON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 16:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727935AbgENUOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 16:14:12 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91581C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:14:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id x77so1865506pfc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 13:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ2/s9c4x/GRQ86qgnYEX7vyrjQPUH1/Y15C1WKzHao=;
        b=kMwWd2NostkcBQxxD2U1/OTKQgmVqcW4Xy3QDrqqUrjfnNW+bzK2kNLTAzDZKICpL0
         uPtTD0Ecm07LUzRt2kHXnGDt06sdSYHkOVOjn7lgtW2iuYxRr7ZrlGcWtip9LUz7HkLo
         Cip0q6hUfXhLmYD46xfj/SzniXQe9UjMYqFVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJ2/s9c4x/GRQ86qgnYEX7vyrjQPUH1/Y15C1WKzHao=;
        b=XHP7A1pCpap6HnBnws9aQI7sQ8FGOiDeHzdWFr/5QD72hA4Fsc3zI4T/0PLXv5MY2Q
         MGhpwmEzKPo7yKV6bDAHabKnEg6cBZWdO1fV2ClwO56byhGSK2FJ5MpPzMyafzjj6Rh9
         tKiL1pUdYFZW0At7PMryolEce2C9UsF4tfzcJu1sC/TtoG3Zd1X4XEmp56zhk0Aug4Lo
         MqT9LVT0N0gzEqrQ4oXfHqUC/aI3ff7o1BSM+39LQMYxrAjfZMUG81snnldW+rx96fyw
         4STuoTCp1uKnZ27JeYyPxpY4aE+4Jj2jjqqbwwGDh1rvzWaLlhpjrZILzsYfluoEiWds
         snPw==
X-Gm-Message-State: AOAM533QF0YTzzFBTwSv7TaGIFzoJJ3hXgUnxNd32hBRLhHTsLapRGP6
        WoImE9fqWY49vzV5cYXcAiwJSg==
X-Google-Smtp-Source: ABdhPJyPB7gYBmXgUcIuK1YP0CJLnYLlD09/RV0gTyEYarKT7RL1tBbHatRlmAwznWOixjiH6xH/CA==
X-Received: by 2002:a63:ad0b:: with SMTP id g11mr5570990pgf.275.1589487251084;
        Thu, 14 May 2020 13:14:11 -0700 (PDT)
Received: from apsdesk.mtv.corp.google.com ([2620:15c:202:1:e09a:8d06:a338:aafb])
        by smtp.gmail.com with ESMTPSA id b8sm18482276pjz.51.2020.05.14.13.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 13:14:10 -0700 (PDT)
From:   Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
To:     linux-bluetooth@vger.kernel.org, bgodavar@codeaurora.org
Cc:     alainm@chromium.org, marcel@holtmann.org, mka@chromium.org,
        chromeos-bluetooth-upstreaming@chromium.org,
        Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] Bluetooth: hci_qca: Enable WBS support for wcn3991
Date:   Thu, 14 May 2020 13:14:04 -0700
Message-Id: <20200514131338.v2.1.I68404fc395a3dbc57c8a89ca02490013e8003a87@changeid>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WCN3991 supports transparent WBS (host encoded mSBC). Add a flag to the
device match data to show WBS is supported.

This requires the matching firmware for WCN3991 in linux-firmware:
        1a8b0dc00f77 (qca: Enable transparent WBS for WCN3991)

Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
---

Changes in v2:
- Rename struct to qca_capabilities and fix enum naming

 drivers/bluetooth/hci_qca.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index b3fd07a6f8127..96799644f0933 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -75,6 +75,9 @@ enum qca_flags {
 	QCA_HW_ERROR_EVENT
 };
 
+enum qca_capabilities {
+	QCA_CAP_WIDEBAND_SPEECH_SUPPORTED = BIT(0),
+};
 
 /* HCI_IBS transmit side sleep protocol states */
 enum tx_ibs_states {
@@ -187,10 +190,11 @@ struct qca_vreg {
 	unsigned int load_uA;
 };
 
-struct qca_vreg_data {
+struct qca_device_data {
 	enum qca_btsoc_type soc_type;
 	struct qca_vreg *vregs;
 	size_t num_vregs;
+	uint32_t capabilities;
 };
 
 /*
@@ -1691,7 +1695,7 @@ static const struct hci_uart_proto qca_proto = {
 	.dequeue	= qca_dequeue,
 };
 
-static const struct qca_vreg_data qca_soc_data_wcn3990 = {
+static const struct qca_device_data qca_soc_data_wcn3990 = {
 	.soc_type = QCA_WCN3990,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 15000  },
@@ -1702,7 +1706,7 @@ static const struct qca_vreg_data qca_soc_data_wcn3990 = {
 	.num_vregs = 4,
 };
 
-static const struct qca_vreg_data qca_soc_data_wcn3991 = {
+static const struct qca_device_data qca_soc_data_wcn3991 = {
 	.soc_type = QCA_WCN3991,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 15000  },
@@ -1711,9 +1715,10 @@ static const struct qca_vreg_data qca_soc_data_wcn3991 = {
 		{ "vddch0", 450000 },
 	},
 	.num_vregs = 4,
+	.capabilities = QCA_CAP_WIDEBAND_SPEECH_SUPPORTED,
 };
 
-static const struct qca_vreg_data qca_soc_data_wcn3998 = {
+static const struct qca_device_data qca_soc_data_wcn3998 = {
 	.soc_type = QCA_WCN3998,
 	.vregs = (struct qca_vreg []) {
 		{ "vddio", 10000  },
@@ -1724,7 +1729,7 @@ static const struct qca_vreg_data qca_soc_data_wcn3998 = {
 	.num_vregs = 4,
 };
 
-static const struct qca_vreg_data qca_soc_data_qca6390 = {
+static const struct qca_device_data qca_soc_data_qca6390 = {
 	.soc_type = QCA_QCA6390,
 	.num_vregs = 0,
 };
@@ -1860,7 +1865,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 {
 	struct qca_serdev *qcadev;
 	struct hci_dev *hdev;
-	const struct qca_vreg_data *data;
+	const struct qca_device_data *data;
 	int err;
 	bool power_ctrl_enabled = true;
 
@@ -1948,6 +1953,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
 		hdev->shutdown = qca_power_off;
 	}
 
+	/* Wideband speech support must be set per driver since it can't be
+	 * queried via hci.
+	 */
+	if (data && (data->capabilities & QCA_CAP_WIDEBAND_SPEECH_SUPPORTED))
+		set_bit(HCI_QUIRK_WIDEBAND_SPEECH_SUPPORTED, &hdev->quirks);
+
 	return 0;
 }
 
-- 
2.26.2.761.g0e0b3e54be-goog

