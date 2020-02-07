Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65EECC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE41E21741
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZyEXdFqm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgBGIQQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:16:16 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46763 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726136AbgBGIQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:16:14 -0500
Received: by mail-wr1-f65.google.com with SMTP id z7so1500058wrl.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e+XQKMnS6uB2eOmBonoHVpQNZcrYnah2nemNBQLuzfY=;
        b=ZyEXdFqmTdla5A8sdqL6RcGqTbbOp2Vz3u67vIvYXr1BgLntVt2yqtWZcC8MvZiNzk
         HLbzgroNMRkpiWmFy8tYfWl7N0ZRmZyQtvq1jjhXIUUL5sQfUN/6RBv+b248KpxZgKCq
         5MaGKw6E483byDDUG6aV6Rg79E4TlR3Xypec62V5Yc1Pq9bOOkuOFvhjBYeSZx59QNY9
         19FVQmKfOIBVt7/2Mx1ptK5T2u4fDDnk7iwo1x8jfZrdtsagBugwSJ+evJVmYwedOJoB
         Cj728zI47bYWnqpKUSwBo+cfc6QVM6AKHunFt5O8m9jg7mC8Xq9Z2rKBRz89828hfPdI
         BIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e+XQKMnS6uB2eOmBonoHVpQNZcrYnah2nemNBQLuzfY=;
        b=L/Bm9ZOA3/rx/RBLd0vjwmbmADdg22RRILxHyaT4YZAaRd72Y92m+t+OL3eXwcBcj2
         45+9x4hXr2udBLiRa5AP3QFhPXcVp00hNHR8qjzwRHsdeo9/mIchXduXUVTGkGqm77A3
         I+SEqCcKcG2Xw6TLT/w0ClMTpHLSBSpnQtn++F6b47wxHcvY31AyQbvgrdS2RJnpSUc0
         t0OQ+Oz2/KWvXS7PCjczCikRfO0YeMx3Y8UoVhsTTzh0kNEpV9MYMlceT/k8NMoDFHnt
         PFngt7jeTev7MZkoS1dKZbobuNwJB5i6afj9h738q1VIejki3xhYhlUD67a646vJGjO+
         NB3A==
X-Gm-Message-State: APjAAAWmigW7nrj5CyQi9m8B5k3wUCF4ZkteQon1bNGj5ue4wKakq5Hp
        n3luP1l175qA0z+dAqx1m3MMKvwwTIk=
X-Google-Smtp-Source: APXvYqxnwfAKhbg0wgV/vstw+xokYj16+19aEeW8/ITSunqAtrExzRG8fr6s2XB66XQ6qAMf5wiIuw==
X-Received: by 2002:a5d:484f:: with SMTP id n15mr3211005wrs.365.1581063371675;
        Fri, 07 Feb 2020 00:16:11 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm2466182wrx.25.2020.02.07.00.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 00:16:10 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 3/5] habanalabs: support temperature offset via sysfs
Date:   Fri,  7 Feb 2020 10:15:18 +0200
Message-Id: <20200207081520.5368-3-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207081520.5368-1-oded.gabbay@gmail.com>
References: <20200207081520.5368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

This commit adds support for offsetting the temperatures reading
by a specified value as defined in
https://www.kernel.org/doc/Documentation/hwmon/sysfs-interface
using the standard sysfs defined for hwmon.
This is required by system administrators to inject errors to test
their monitoring applications in data centers.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h       |  2 ++
 drivers/misc/habanalabs/hwmon.c            | 37 ++++++++++++++++++++++
 drivers/misc/habanalabs/include/armcp_if.h | 13 +++++++-
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 4ef8cf23d099..4de12d3ff836 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1610,6 +1610,8 @@ int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask);
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
 long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
+int hl_set_temperature(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value);
 long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr);
 long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr);
 long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr);
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 7be4bace9b4f..70088fdb0a5b 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -125,6 +125,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		case hwmon_temp_crit:
 		case hwmon_temp_max_hyst:
 		case hwmon_temp_crit_hyst:
+		case hwmon_temp_offset:
 			break;
 		default:
 			return -EINVAL;
@@ -192,6 +193,15 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		return -ENODEV;
 
 	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_offset:
+			break;
+		default:
+			return -EINVAL;
+		}
+		hl_set_temperature(hdev, channel, attr, val);
+		break;
 	case hwmon_pwm:
 		switch (attr) {
 		case hwmon_pwm_input:
@@ -220,6 +230,8 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_temp_crit:
 		case hwmon_temp_crit_hyst:
 			return 0444;
+		case hwmon_temp_offset:
+			return 0644;
 		}
 		break;
 	case hwmon_in:
@@ -291,6 +303,31 @@ long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr)
 	return result;
 }
 
+int hl_set_temperature(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_TEMPERATURE_SET <<
+				ARMCP_PKT_CTL_OPCODE_SHIFT);
+	pkt.sensor_index = __cpu_to_le16(sensor_index);
+	pkt.type = __cpu_to_le16(attr);
+	pkt.value = __cpu_to_le64(value);
+
+	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
+						SENSORS_PKT_TIMEOUT, NULL);
+
+	if (rc)
+		dev_err(hdev->dev,
+			"Failed to set temperature of sensor %d, error %d\n",
+			sensor_index, rc);
+
+	return rc;
+}
+
 long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr)
 {
 	struct armcp_packet pkt;
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index e4c6699a1868..014549eaf919 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -189,6 +189,10 @@ enum pq_init_status {
  *       ArmCP to write to the structure, to prevent data corruption in case of
  *       mismatched driver/FW versions.
  *
+ * ARMCP_PACKET_TEMPERATURE_SET -
+ *       Set the value of the offset property of a specified thermal sensor.
+ *       The packet's arguments specify the desired sensor and the field to
+ *       set.
  */
 
 enum armcp_packet_id {
@@ -214,6 +218,8 @@ enum armcp_packet_id {
 	ARMCP_PACKET_MAX_POWER_GET,		/* sysfs */
 	ARMCP_PACKET_MAX_POWER_SET,		/* sysfs */
 	ARMCP_PACKET_EEPROM_DATA_GET,		/* sysfs */
+	ARMCP_RESERVED,
+	ARMCP_PACKET_TEMPERATURE_SET,		/* sysfs */
 };
 
 #define ARMCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -271,12 +277,17 @@ enum armcp_packet_rc {
 	armcp_packet_fault
 };
 
+/*
+ * armcp_temp_type should adhere to hwmon_temp_attributes
+ * defined in Linux kernel hwmon.h file
+ */
 enum armcp_temp_type {
 	armcp_temp_input,
 	armcp_temp_max = 6,
 	armcp_temp_max_hyst,
 	armcp_temp_crit,
-	armcp_temp_crit_hyst
+	armcp_temp_crit_hyst,
+	armcp_temp_offset = 19
 };
 
 enum armcp_in_attributes {
-- 
2.17.1

