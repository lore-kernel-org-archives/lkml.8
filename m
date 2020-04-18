Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F0A4C352BE
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59C05214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 08:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="udRAL9LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726136AbgDRIY4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbgDRIYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:24:54 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E5BC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:52 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id u127so4226553wmg.1
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 01:24:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Z9RZqtfs5Cag4mQdzJShlNAQuGjvhVeQdujbGHU9q2o=;
        b=udRAL9LOXx8sHcgH2psl9sOtzCWWqi5tKzVYRnHlvoLpQTwr8+MGGPyKtuAlLgLGA3
         YJCW6HoZeFRDlle3YWdF4HgGB+obotwbPtAB5d1swWi9WjN+ky7grYmW8ot0WHnjVFrU
         xkV/j4YkRMUTjTIQ6Oqslu9j+0nWCI8KPup1G5z2WaCTMAkDSyZnG/zSKrY4qHK/vUZW
         Pxxeq9gRVGuSAe+kPYnFhS5yiHByv69mlep+El41GYxquHL40kj+tNNKpM0EmYWq9Fqr
         Tw2KIvNkJnnR9G2nFk6hLs55hKiBv/Nbd3BSOOdZAlbGpkDUQHeV5mOT7dacVddaiNCm
         zepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Z9RZqtfs5Cag4mQdzJShlNAQuGjvhVeQdujbGHU9q2o=;
        b=AjSF4kwouEFr9UJmg6AweRWVSRBBpOlF0Te0t6+KDdjKTpWORHCkrNOpMHy7vWriG1
         briseipk7dqZT88+2atabdpU4t+nXMuveZNEruI/tHaSd0mGj6JrvMmZY+iJKCNL/Etp
         tyf6p6gUk7IxIyORoklq6qYyAqR0L1yZcjzfOpHB4N5rd8Swpy2vSN06j7Sapp5kdFVx
         Ng7o59r8wipZMpF7XSg/zGjPMSBR0uu3w4wkp8UN0ACYM+Uanr8T4Sz9lxpDKnK9Ku8K
         N07i0Le7Yrj6LF5OCXsFzDri22X30vn4TT3Q2w2UERfegylYuP8QXIw/lxaXZnSfCmI2
         jzaQ==
X-Gm-Message-State: AGi0PuYzKQt1yNMOtv+nEaskX+TF51FdpssKnpl5NFY9xTYaHuQiL8/t
        zzzL5zx+6ejl6AFbo3hPauN1sSa5
X-Google-Smtp-Source: APiQypIEIDe7Z/I6ywI8HeoGP5y+3cFVoP+kz/+v0w45dm8jPE+eWmm58eROAhUkism9qCx+x2h8/Q==
X-Received: by 2002:a1c:ac44:: with SMTP id v65mr7261340wme.33.1587198291090;
        Sat, 18 Apr 2020 01:24:51 -0700 (PDT)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id c190sm10898087wme.4.2020.04.18.01.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 01:24:50 -0700 (PDT)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org,
        Christine Gharzuzi <cgharzuzi@habana.ai>
Subject: [PATCH 4/5] habanalabs: support hwmon_reset_history attribute
Date:   Sat, 18 Apr 2020 11:24:39 +0300
Message-Id: <20200418082440.21277-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200418082440.21277-1-oded.gabbay@gmail.com>
References: <20200418082440.21277-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christine Gharzuzi <cgharzuzi@habana.ai>

Support hwmon_temp_reset_histroy, hwmon_in_reset_history and
hwmon_curr_reset attribute which resets the historical highest value.

Signed-off-by: Christine Gharzuzi <cgharzuzi@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h       |  4 ++
 drivers/misc/habanalabs/hwmon.c            | 75 ++++++++++++++++++++++
 drivers/misc/habanalabs/include/armcp_if.h | 21 +++++-
 3 files changed, 97 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index a8ee241b2fce..0d3d3c59ae2b 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1676,6 +1676,10 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 			long value);
 u64 hl_get_max_power(struct hl_device *hdev);
 void hl_set_max_power(struct hl_device *hdev, u64 value);
+int hl_set_voltage(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value);
+int hl_set_current(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value);
 
 #ifdef CONFIG_DEBUG_FS
 
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index a21a26e07c3b..8c6cd77e6af6 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -200,6 +200,7 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 	case hwmon_temp:
 		switch (attr) {
 		case hwmon_temp_offset:
+		case hwmon_temp_reset_history:
 			break;
 		default:
 			return -EINVAL;
@@ -216,6 +217,24 @@ static int hl_write(struct device *dev, enum hwmon_sensor_types type,
 		}
 		hl_set_pwm_info(hdev, channel, attr, val);
 		break;
+	case hwmon_in:
+		switch (attr) {
+		case hwmon_in_reset_history:
+			break;
+		default:
+			return -EINVAL;
+		}
+		hl_set_voltage(hdev, channel, attr, val);
+		break;
+	case hwmon_curr:
+		switch (attr) {
+		case hwmon_curr_reset_history:
+			break;
+		default:
+			return -EINVAL;
+		}
+		hl_set_current(hdev, channel, attr, val);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -237,6 +256,8 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 			return 0444;
 		case hwmon_temp_offset:
 			return 0644;
+		case hwmon_temp_reset_history:
+			return 0200;
 		}
 		break;
 	case hwmon_in:
@@ -246,6 +267,8 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_in_max:
 		case hwmon_in_highest:
 			return 0444;
+		case hwmon_in_reset_history:
+			return 0200;
 		}
 		break;
 	case hwmon_curr:
@@ -255,6 +278,8 @@ static umode_t hl_is_visible(const void *data, enum hwmon_sensor_types type,
 		case hwmon_curr_max:
 		case hwmon_curr_highest:
 			return 0444;
+		case hwmon_curr_reset_history:
+			return 0200;
 		}
 		break;
 	case hwmon_fan:
@@ -462,6 +487,56 @@ void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 			sensor_index, rc);
 }
 
+int hl_set_voltage(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_VOLTAGE_SET <<
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
+			"Failed to set voltage of sensor %d, error %d\n",
+			sensor_index, rc);
+
+	return rc;
+}
+
+int hl_set_current(struct hl_device *hdev,
+			int sensor_index, u32 attr, long value)
+{
+	struct armcp_packet pkt;
+	int rc;
+
+	memset(&pkt, 0, sizeof(pkt));
+
+	pkt.ctl = cpu_to_le32(ARMCP_PACKET_CURRENT_SET <<
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
+			"Failed to set current of sensor %d, error %d\n",
+			sensor_index, rc);
+
+	return rc;
+}
+
 int hl_hwmon_init(struct hl_device *hdev)
 {
 	struct device *dev = hdev->pdev ? &hdev->pdev->dev : hdev->dev;
diff --git a/drivers/misc/habanalabs/include/armcp_if.h b/drivers/misc/habanalabs/include/armcp_if.h
index bdd0a4c3a9cf..9e3bc21f20a0 100644
--- a/drivers/misc/habanalabs/include/armcp_if.h
+++ b/drivers/misc/habanalabs/include/armcp_if.h
@@ -193,6 +193,16 @@ enum pq_init_status {
  *       Set the value of the offset property of a specified thermal sensor.
  *       The packet's arguments specify the desired sensor and the field to
  *       set.
+ *
+ * ARMCP_PACKET_VOLTAGE_SET -
+ *       Trigger the reset_history property of a specified voltage sensor.
+ *       The packet's arguments specify the desired sensor and the field to
+ *       set.
+ *
+ * ARMCP_PACKET_CURRENT_SET -
+ *       Trigger the reset_history property of a specified current sensor.
+ *       The packet's arguments specify the desired sensor and the field to
+ *       set.
  */
 
 enum armcp_packet_id {
@@ -220,6 +230,8 @@ enum armcp_packet_id {
 	ARMCP_PACKET_EEPROM_DATA_GET,		/* sysfs */
 	ARMCP_RESERVED,
 	ARMCP_PACKET_TEMPERATURE_SET,		/* sysfs */
+	ARMCP_PACKET_VOLTAGE_SET,		/* sysfs */
+	ARMCP_PACKET_CURRENT_SET,		/* sysfs */
 };
 
 #define ARMCP_PACKET_FENCE_VAL	0xFE8CE7A5
@@ -288,21 +300,24 @@ enum armcp_temp_type {
 	armcp_temp_crit,
 	armcp_temp_crit_hyst,
 	armcp_temp_offset = 19,
-	armcp_temp_highest = 22
+	armcp_temp_highest = 22,
+	armcp_temp_reset_history = 23
 };
 
 enum armcp_in_attributes {
 	armcp_in_input,
 	armcp_in_min,
 	armcp_in_max,
-	armcp_in_highest = 7
+	armcp_in_highest = 7,
+	armcp_in_reset_history
 };
 
 enum armcp_curr_attributes {
 	armcp_curr_input,
 	armcp_curr_min,
 	armcp_curr_max,
-	armcp_curr_highest = 7
+	armcp_curr_highest = 7,
+	armcp_curr_reset_history
 };
 
 enum armcp_fan_attributes {
-- 
2.17.1

