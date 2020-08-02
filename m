Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2B5C433E1
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33FD32072A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 14:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgHBO5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:57:02 -0400
Received: from hera.iit.uni-miskolc.hu ([193.6.5.4]:46182 "EHLO
        hera.iit.uni-miskolc.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgHBO5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 10:57:01 -0400
Received: from localhost (localhost [127.0.0.1])
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTP id 401AB127;
        Sun,  2 Aug 2020 16:56:55 +0200 (CEST)
X-Virus-Scanned: Kamavis at iit.uni-miskolc.hu
Received: from hera.iit.uni-miskolc.hu ([127.0.0.1])
        by localhost (hera.iit.uni-miskolc.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id V-SdNRgwAo2I; Sun,  2 Aug 2020 16:56:47 +0200 (CEST)
Received: from titan.hitronhub.home (unknown [IPv6:2a02:8109:a180:908:226:9eff:fe30:2af8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: szucst@iit.uni-miskolc.hu)
        by hera.iit.uni-miskolc.hu (Postfix) with ESMTPSA id 77BA5126;
        Sun,  2 Aug 2020 16:56:47 +0200 (CEST)
From:   =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Tam=C3=A1s=20Sz=C5=B1cs?= <tszucs@protonmail.ch>
Subject: [PATCH] Bluetooth: btmrvl: eliminate duplicates introducing btmrvl_reg_89xx
Date:   Sun,  2 Aug 2020 16:56:42 +0200
Message-Id: <20200802145642.9990-1-tszucs@protonmail.ch>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SD89xx devices use identical card register settings. Make sure a single common
instance is used to describe them.

Signed-off-by: Tamás Szűcs <tszucs@protonmail.ch>
---
 drivers/bluetooth/btmrvl_sdio.c | 54 +++------------------------------
 1 file changed, 4 insertions(+), 50 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index cfb9f9db44a0..92b28ff331b4 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -215,30 +215,7 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_8897 = {
 	.fw_dump_end = 0xea,
 };
 
-static const struct btmrvl_sdio_card_reg btmrvl_reg_8977 = {
-	.cfg = 0x00,
-	.host_int_mask = 0x08,
-	.host_intstatus = 0x0c,
-	.card_status = 0x5c,
-	.sq_read_base_addr_a0 = 0xf8,
-	.sq_read_base_addr_a1 = 0xf9,
-	.card_revision = 0xc8,
-	.card_fw_status0 = 0xe8,
-	.card_fw_status1 = 0xe9,
-	.card_rx_len = 0xea,
-	.card_rx_unit = 0xeb,
-	.io_port_0 = 0xe4,
-	.io_port_1 = 0xe5,
-	.io_port_2 = 0xe6,
-	.int_read_to_clear = true,
-	.host_int_rsr = 0x04,
-	.card_misc_cfg = 0xD8,
-	.fw_dump_ctrl = 0xf0,
-	.fw_dump_start = 0xf1,
-	.fw_dump_end = 0xf8,
-};
-
-static const struct btmrvl_sdio_card_reg btmrvl_reg_8987 = {
+static const struct btmrvl_sdio_card_reg btmrvl_reg_89xx = {
 	.cfg = 0x00,
 	.host_int_mask = 0x08,
 	.host_intstatus = 0x0c,
@@ -261,29 +238,6 @@ static const struct btmrvl_sdio_card_reg btmrvl_reg_8987 = {
 	.fw_dump_end = 0xf8,
 };
 
-static const struct btmrvl_sdio_card_reg btmrvl_reg_8997 = {
-	.cfg = 0x00,
-	.host_int_mask = 0x08,
-	.host_intstatus = 0x0c,
-	.card_status = 0x5c,
-	.sq_read_base_addr_a0 = 0xf8,
-	.sq_read_base_addr_a1 = 0xf9,
-	.card_revision = 0xc8,
-	.card_fw_status0 = 0xe8,
-	.card_fw_status1 = 0xe9,
-	.card_rx_len = 0xea,
-	.card_rx_unit = 0xeb,
-	.io_port_0 = 0xe4,
-	.io_port_1 = 0xe5,
-	.io_port_2 = 0xe6,
-	.int_read_to_clear = true,
-	.host_int_rsr = 0x04,
-	.card_misc_cfg = 0xD8,
-	.fw_dump_ctrl = 0xf0,
-	.fw_dump_start = 0xf1,
-	.fw_dump_end = 0xf8,
-};
-
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8688 = {
 	.helper		= "mrvl/sd8688_helper.bin",
 	.firmware	= "mrvl/sd8688.bin",
@@ -332,7 +286,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8977 = {
 	.helper         = NULL,
 	.firmware       = "mrvl/sdsd8977_combo_v2.bin",
-	.reg            = &btmrvl_reg_8977,
+	.reg            = &btmrvl_reg_89xx,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl = 256,
 	.supports_fw_dump = true,
@@ -341,7 +295,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8977 = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8987 = {
 	.helper		= NULL,
 	.firmware	= "mrvl/sd8987_uapsta.bin",
-	.reg		= &btmrvl_reg_8987,
+	.reg		= &btmrvl_reg_89xx,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl	= 256,
 	.supports_fw_dump = true,
@@ -350,7 +304,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8987 = {
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 = {
 	.helper         = NULL,
 	.firmware       = "mrvl/sdsd8997_combo_v4.bin",
-	.reg            = &btmrvl_reg_8997,
+	.reg            = &btmrvl_reg_89xx,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl = 256,
 	.supports_fw_dump = true,
-- 
2.20.1

