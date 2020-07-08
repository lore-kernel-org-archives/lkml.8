Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFC20C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:45:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7E0D20739
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p+ZUDfsB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgGHHpi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726281AbgGHHph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:45:37 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7C4C08C5DC
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:45:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 22so1865611wmg.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=Byq5CSVuNAlKM28K02LWdTCSOV+ENVyB2tOJ77Rhipo=;
        b=p+ZUDfsB2NNmcUFsFthaAET3QrPVXM41lctMlRIdoObKW/bmjnmqXanaDdKGc1Qgq/
         CF83Vy3MvpOpbE/5c7r8XAvK0rcOGlslEhxDLciA+UtIChs+0cA85X5YkEDza8l2l9Eu
         q91yialcK+FN5DxDnBKSxyfVE7HuvWPkqz+cyu+zgq42PgA75sLw8Y6g0lXVV4HPEBlv
         V6UR1ILpClFb6ISp6YvYtBL4HmWhXzQkZMtz9QqJZL9Xa5lG13wbOnvHUx2FkfBUfaoC
         uN4BN2Kv4Xqb1xDIf+YZMd9h6HPYwmn/k+BX7E4gUQdejwXbqU7P/9JLoO0+1jyOPV+/
         kc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=Byq5CSVuNAlKM28K02LWdTCSOV+ENVyB2tOJ77Rhipo=;
        b=Soas6dCrDsSHMdkwOcHeKsDoruEhswFhS+pjPsOem8P8ZtnTVFNxfS5LIu4OjCra57
         lihbRtQpFgfDsbV4r5IHj+GzwQ23wq4XEeiUrtmKK+xUONRYiNrGLmtKvrqtVs4oeo4F
         hLLaCuV1D/3p0xySAO+cZTQpTW6L5P3WgWIkdei2PFu1rUNEOG284zZWmOqNz0yB8hxY
         glrjFKZicrudde5x595RuVxr4qhi6wO+H/fUIJijtpC/ONcyHhscXzN6PqK3/6g1E9K+
         7D+DoKvPgIt0/Ea9x3VDQz9a6xmWHqCZ7OnGgoK6nMX/mVi/N/DuooBWlqOxLfa26rtB
         8TyA==
X-Gm-Message-State: AOAM531IY5XRnptLxvQVXdygT0mjEO91A5BX0VaRNdErwGs+yBocTiDz
        dlfWYY1nThM2DGDoX62AQIhpunxH
X-Google-Smtp-Source: ABdhPJzJjuyMCP4zmmERamNBjqwQ8OPL02ys4LSzJE70F8/qAPPIxnGm3aYr9/qx5L1gKipNzZK8dw==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr7553136wme.23.1594194334797;
        Wed, 08 Jul 2020 00:45:34 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([213.57.90.10])
        by smtp.gmail.com with ESMTPSA id k185sm4486799wmk.47.2020.07.08.00.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 00:45:33 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, SW_Drivers@habana.ai
Subject: [PATCH] habanalabs: set 4s timeout for message to device CPU
Date:   Wed,  8 Jul 2020 10:45:38 +0300
Message-Id: <20200708074538.24016-1-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We see that sometimes the CPU in GOYA and GAUDI is occupied by the
power/thermal loop and can't answer requests from the driver fast enough.

Therefore, to avoid false notifications on timeouts, increase the timeout
to 4 seconds on each message sent to the device CPU.

Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/debugfs.c     |  6 +++---
 drivers/misc/habanalabs/firmware_if.c | 10 +++++-----
 drivers/misc/habanalabs/gaudi/gaudi.c |  4 ++++
 drivers/misc/habanalabs/goya/goya.c   | 12 ++++++++----
 drivers/misc/habanalabs/habanalabs.h  |  6 +++++-
 drivers/misc/habanalabs/hwmon.c       | 19 +++++++++----------
 drivers/misc/habanalabs/sysfs.c       | 11 ++++-------
 7 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/misc/habanalabs/debugfs.c b/drivers/misc/habanalabs/debugfs.c
index 136b8f6fa0b3..0bc036e01ee8 100644
--- a/drivers/misc/habanalabs/debugfs.c
+++ b/drivers/misc/habanalabs/debugfs.c
@@ -36,7 +36,7 @@ static int hl_debugfs_i2c_read(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	pkt.i2c_reg = i2c_reg;
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					HL_DEVICE_TIMEOUT_USEC, (long *) val);
+						0, (long *) val);
 
 	if (rc)
 		dev_err(hdev->dev, "Failed to read from I2C, error %d\n", rc);
@@ -63,7 +63,7 @@ static int hl_debugfs_i2c_write(struct hl_device *hdev, u8 i2c_bus, u8 i2c_addr,
 	pkt.value = cpu_to_le64(val);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					HL_DEVICE_TIMEOUT_USEC, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev, "Failed to write to I2C, error %d\n", rc);
@@ -87,7 +87,7 @@ static void hl_debugfs_led_set(struct hl_device *hdev, u8 led, u8 state)
 	pkt.value = cpu_to_le64(state);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						HL_DEVICE_TIMEOUT_USEC, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev, "Failed to set LED %d, error %d\n", led, rc);
diff --git a/drivers/misc/habanalabs/firmware_if.c b/drivers/misc/habanalabs/firmware_if.c
index baf790cf4b78..d27841cb5bcb 100644
--- a/drivers/misc/habanalabs/firmware_if.c
+++ b/drivers/misc/habanalabs/firmware_if.c
@@ -61,7 +61,7 @@ int hl_fw_send_pci_access_msg(struct hl_device *hdev, u32 opcode)
 	pkt.ctl = cpu_to_le32(opcode << ARMCP_PKT_CTL_OPCODE_SHIFT);
 
 	return hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt,
-				sizeof(pkt), HL_DEVICE_TIMEOUT_USEC, NULL);
+						sizeof(pkt), 0, NULL);
 }
 
 int hl_fw_send_cpu_message(struct hl_device *hdev, u32 hw_queue_id, u32 *msg,
@@ -144,7 +144,7 @@ int hl_fw_unmask_irq(struct hl_device *hdev, u16 event_type)
 	pkt.value = cpu_to_le64(event_type);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			HL_DEVICE_TIMEOUT_USEC, &result);
+						0, &result);
 
 	if (rc)
 		dev_err(hdev->dev, "failed to unmask RAZWI IRQ %d", event_type);
@@ -183,7 +183,7 @@ int hl_fw_unmask_irq_arr(struct hl_device *hdev, const u32 *irq_arr,
 						ARMCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
-			total_pkt_size, HL_DEVICE_TIMEOUT_USEC, &result);
+						total_pkt_size, 0, &result);
 
 	if (rc)
 		dev_err(hdev->dev, "failed to unmask IRQ array\n");
@@ -204,7 +204,7 @@ int hl_fw_test_cpu_queue(struct hl_device *hdev)
 	test_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &test_pkt,
-			sizeof(test_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+						sizeof(test_pkt), 0, &result);
 
 	if (!rc) {
 		if (result != ARMCP_PACKET_FENCE_VAL)
@@ -248,7 +248,7 @@ int hl_fw_send_heartbeat(struct hl_device *hdev)
 	hb_pkt.value = cpu_to_le64(ARMCP_PACKET_FENCE_VAL);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &hb_pkt,
-			sizeof(hb_pkt), HL_DEVICE_TIMEOUT_USEC, &result);
+						sizeof(hb_pkt), 0, &result);
 
 	if ((rc) || (result != ARMCP_PACKET_FENCE_VAL))
 		rc = -EIO;
diff --git a/drivers/misc/habanalabs/gaudi/gaudi.c b/drivers/misc/habanalabs/gaudi/gaudi.c
index 9d6aebef8854..637a9d608707 100644
--- a/drivers/misc/habanalabs/gaudi/gaudi.c
+++ b/drivers/misc/habanalabs/gaudi/gaudi.c
@@ -80,6 +80,7 @@
 #define GAUDI_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
 #define GAUDI_PLDM_TPC_KERNEL_WAIT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
 #define GAUDI_BOOT_FIT_REQ_TIMEOUT_USEC	1000000		/* 1s */
+#define GAUDI_MSG_TO_CPU_TIMEOUT_USEC	4000000		/* 4s */
 
 #define GAUDI_QMAN0_FENCE_VAL		0x72E91AB9
 
@@ -3479,6 +3480,9 @@ static int gaudi_send_cpu_message(struct hl_device *hdev, u32 *msg,
 		return 0;
 	}
 
+	if (!timeout)
+		timeout = GAUDI_MSG_TO_CPU_TIMEOUT_USEC;
+
 	return hl_fw_send_cpu_message(hdev, GAUDI_QUEUE_ID_CPU_PQ, msg, len,
 						timeout, result);
 }
diff --git a/drivers/misc/habanalabs/goya/goya.c b/drivers/misc/habanalabs/goya/goya.c
index 83f0c70f140b..88460b2138d8 100644
--- a/drivers/misc/habanalabs/goya/goya.c
+++ b/drivers/misc/habanalabs/goya/goya.c
@@ -88,6 +88,7 @@
 #define GOYA_PLDM_MMU_TIMEOUT_USEC	(MMU_CONFIG_TIMEOUT_USEC * 100)
 #define GOYA_PLDM_QMAN0_TIMEOUT_USEC	(HL_DEVICE_TIMEOUT_USEC * 30)
 #define GOYA_BOOT_FIT_REQ_TIMEOUT_USEC	1000000		/* 1s */
+#define GOYA_MSG_TO_CPU_TIMEOUT_USEC	4000000		/* 4s */
 
 #define GOYA_QMAN0_FENCE_VAL		0xD169B243
 
@@ -2830,6 +2831,9 @@ int goya_send_cpu_message(struct hl_device *hdev, u32 *msg, u16 len,
 		return 0;
 	}
 
+	if (!timeout)
+		timeout = GOYA_MSG_TO_CPU_TIMEOUT_USEC;
+
 	return hl_fw_send_cpu_message(hdev, GOYA_QUEUE_ID_CPU_PQ, msg, len,
 					timeout, result);
 }
@@ -4431,8 +4435,8 @@ static int goya_unmask_irq_arr(struct hl_device *hdev, u32 *irq_arr,
 	pkt->armcp_pkt.ctl = cpu_to_le32(ARMCP_PACKET_UNMASK_RAZWI_IRQ_ARRAY <<
 						ARMCP_PKT_CTL_OPCODE_SHIFT);
 
-	rc = goya_send_cpu_message(hdev, (u32 *) pkt, total_pkt_size,
-			HL_DEVICE_TIMEOUT_USEC, &result);
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) pkt,
+						total_pkt_size,	0, &result);
 
 	if (rc)
 		dev_err(hdev->dev, "failed to unmask IRQ array\n");
@@ -4464,8 +4468,8 @@ static int goya_unmask_irq(struct hl_device *hdev, u16 event_type)
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 	pkt.value = cpu_to_le64(event_type);
 
-	rc = goya_send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			HL_DEVICE_TIMEOUT_USEC, &result);
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						0, &result);
 
 	if (rc)
 		dev_err(hdev->dev, "failed to unmask RAZWI IRQ %d", event_type);
diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index dee5cc25fe5b..194d83352696 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -588,7 +588,11 @@ enum hl_pll_frequency {
  * @hw_queues_unlock: release H/W queues lock.
  * @get_pci_id: retrieve PCI ID.
  * @get_eeprom_data: retrieve EEPROM data from F/W.
- * @send_cpu_message: send buffer to ArmCP.
+ * @send_cpu_message: send message to F/W. If the message is timedout, the
+ *                    driver will eventually reset the device. The timeout can
+ *                    be determined by the calling function or it can be 0 and
+ *                    then the timeout is the default timeout for the specific
+ *                    ASIC
  * @get_hw_state: retrieve the H/W state
  * @pci_bars_map: Map PCI BARs.
  * @set_dram_bar_base: Set DRAM BAR to map specific device address. Returns
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 8c6cd77e6af6..b997336fa75f 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -10,7 +10,6 @@
 #include <linux/pci.h>
 #include <linux/hwmon.h>
 
-#define SENSORS_PKT_TIMEOUT		1000000	/* 1s */
 #define HWMON_NR_SENSOR_TYPES		(hwmon_pwm + 1)
 
 int hl_build_hwmon_channel_info(struct hl_device *hdev,
@@ -323,7 +322,7 @@ int hl_get_temperature(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			SENSORS_PKT_TIMEOUT, value);
+						0, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -350,7 +349,7 @@ int hl_set_temperature(struct hl_device *hdev,
 	pkt.value = __cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						SENSORS_PKT_TIMEOUT, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev,
@@ -374,7 +373,7 @@ int hl_get_voltage(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, value);
+						0, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -400,7 +399,7 @@ int hl_get_current(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, value);
+						0, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -426,7 +425,7 @@ int hl_get_fan_speed(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, value);
+						0, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -452,7 +451,7 @@ int hl_get_pwm_info(struct hl_device *hdev,
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, value);
+						0, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -479,7 +478,7 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 	pkt.value = cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev,
@@ -502,7 +501,7 @@ int hl_set_voltage(struct hl_device *hdev,
 	pkt.value = __cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						SENSORS_PKT_TIMEOUT, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev,
@@ -527,7 +526,7 @@ int hl_set_current(struct hl_device *hdev,
 	pkt.value = __cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						SENSORS_PKT_TIMEOUT, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev,
diff --git a/drivers/misc/habanalabs/sysfs.c b/drivers/misc/habanalabs/sysfs.c
index 5d78d5e1c782..70b6b1863c2e 100644
--- a/drivers/misc/habanalabs/sysfs.c
+++ b/drivers/misc/habanalabs/sysfs.c
@@ -9,9 +9,6 @@
 
 #include <linux/pci.h>
 
-#define SET_CLK_PKT_TIMEOUT	1000000	/* 1s */
-#define SET_PWR_PKT_TIMEOUT	1000000	/* 1s */
-
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 {
 	struct armcp_packet pkt;
@@ -29,7 +26,7 @@ long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr)
 	pkt.pll_index = cpu_to_le32(pll_index);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						SET_CLK_PKT_TIMEOUT, &result);
+						0, &result);
 
 	if (rc) {
 		dev_err(hdev->dev,
@@ -54,7 +51,7 @@ void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq)
 	pkt.value = cpu_to_le64(freq);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SET_CLK_PKT_TIMEOUT, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev,
@@ -74,7 +71,7 @@ u64 hl_get_max_power(struct hl_device *hdev)
 				ARMCP_PKT_CTL_OPCODE_SHIFT);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-						SET_PWR_PKT_TIMEOUT, &result);
+						0, &result);
 
 	if (rc) {
 		dev_err(hdev->dev, "Failed to get max power, error %d\n", rc);
@@ -96,7 +93,7 @@ void hl_set_max_power(struct hl_device *hdev, u64 value)
 	pkt.value = cpu_to_le64(value);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SET_PWR_PKT_TIMEOUT, NULL);
+						0, NULL);
 
 	if (rc)
 		dev_err(hdev->dev, "Failed to set max power, error %d\n", rc);
-- 
2.17.1

