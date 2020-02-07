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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FFBC352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87B2F217BA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 08:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n/k9kZG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727049AbgBGIQT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 03:16:19 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52453 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgBGIQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 03:16:17 -0500
Received: by mail-wm1-f68.google.com with SMTP id p9so1585631wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 00:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EgBjzM+LzxjYQxRLU84HU0fTy/P2Sfw9wT6Kz3w/daU=;
        b=n/k9kZG8g5Cmtmpwo6o5eoW+OiDjcNKAAVD3dI7ZnH5wli9lX2WY+yZTBjOHHGK7/L
         cCtXQLMXaG3+VHaG38iDqWA5i5JY0FljcbX7Sx82d0BdAo9uDwiSJ1ZzJZ0GUBDgSmN2
         tpJXC17gssVdG+lyTLSxkI0wySaF7Jzj00+7H88J7qhVcpfLmL8tsJ8CxrxjV+JmJhV4
         vhXwPbemQLAUeWFr1earbCdAwQ9us66XsIh2TxOaGy855WNjLtT6te4qswIY0fxAYaIF
         T7GO9uW79BTcsyUmPNUmyG9XUQi1+hTjT6aRkka1G+H3K/zkjlUrpAkqPhPyBc6OF9Kl
         2yMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EgBjzM+LzxjYQxRLU84HU0fTy/P2Sfw9wT6Kz3w/daU=;
        b=DJwZrGYTwlWfUzipN6z9OA7LicvZ5A2Gm8yHRMPx042FZe26JjAWfeyEPl1v1T8SPU
         kGLVdo7VrDrChJ5QRi+GQ0S/Cjgd2O1TIfpbdJtimOOp5NXRnjuiYx54ZoZ3pkgkDDjj
         gRj+mJxeTbGsMDQQHIIEqLrRSlQ/u6mJ+IHIwViTpkg3nQr7d2EpBPLi5zcbYjBm7NxM
         YFLGGcaOKhP+v7YE+rm0JceTxmJcn8Zjt5TeZYKx3+LPPxwyZlTWvDStiK/FWzrXHZEg
         edWF6EyBewRIHKatDblxDy5i2J9mTN6aLHFv6PSjYLhCE8OFJGcapjdgtrwTqk+gwkhi
         8sQQ==
X-Gm-Message-State: APjAAAUX2q7XzikDAOM6yX7msUAX11F5jt8yjTaj9aDCZmzbEZuE+V2d
        5sEa5K/bGWGccmojWZQjn1JwjOoVKJU=
X-Google-Smtp-Source: APXvYqwlGrwyJdhi8ZYigA75t6alfbxcQiUMu6zJN8Dy9Jte9OYCBMxW2kApi9+kdfX+ir9RwPLxGA==
X-Received: by 2002:a1c:988e:: with SMTP id a136mr2976489wme.181.1581063374799;
        Fri, 07 Feb 2020 00:16:14 -0800 (PST)
Received: from ogabbay-VM.habana-labs.com ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id o4sm2466182wrx.25.2020.02.07.00.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 00:16:13 -0800 (PST)
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     linux-kernel@vger.kernel.org, oshpigelman@habana.ai,
        ttayar@habana.ai
Cc:     gregkh@linuxfoundation.org, Moti Haimovski <mhaimovski@habana.ai>
Subject: [PATCH 4/5] habanalabs: modify the return values of hl_read/write routines
Date:   Fri,  7 Feb 2020 10:15:19 +0200
Message-Id: <20200207081520.5368-4-oded.gabbay@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200207081520.5368-1-oded.gabbay@gmail.com>
References: <20200207081520.5368-1-oded.gabbay@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moti Haimovski <mhaimovski@habana.ai>

The hl read and write routines implement the hwmon_ops read and write
interface routines respectively.
These routines are expected to return a completion status when called,
which was not the case until this commit.
This commit modifies these routines to return 0 upon success and a
negative error value upon failure.

Signed-off-by: Moti Haimovski <mhaimovski@habana.ai>
Reviewed-by: Oded Gabbay <oded.gabbay@gmail.com>
Signed-off-by: Oded Gabbay <oded.gabbay@gmail.com>
---
 drivers/misc/habanalabs/habanalabs.h | 17 +++++---
 drivers/misc/habanalabs/hwmon.c      | 63 ++++++++++++++--------------
 2 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/misc/habanalabs/habanalabs.h b/drivers/misc/habanalabs/habanalabs.h
index 4de12d3ff836..9472da3ef847 100644
--- a/drivers/misc/habanalabs/habanalabs.h
+++ b/drivers/misc/habanalabs/habanalabs.h
@@ -1609,13 +1609,18 @@ int hl_pci_set_dma_mask(struct hl_device *hdev, u8 dma_mask);
 
 long hl_get_frequency(struct hl_device *hdev, u32 pll_index, bool curr);
 void hl_set_frequency(struct hl_device *hdev, u32 pll_index, u64 freq);
-long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr);
+int hl_get_temperature(struct hl_device *hdev,
+		       int sensor_index, u32 attr, long *value);
 int hl_set_temperature(struct hl_device *hdev,
-			int sensor_index, u32 attr, long value);
-long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr);
-long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr);
-long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr);
-long hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr);
+		       int sensor_index, u32 attr, long value);
+int hl_get_voltage(struct hl_device *hdev,
+		   int sensor_index, u32 attr, long *value);
+int hl_get_current(struct hl_device *hdev,
+		   int sensor_index, u32 attr, long *value);
+int hl_get_fan_speed(struct hl_device *hdev,
+		     int sensor_index, u32 attr, long *value);
+int hl_get_pwm_info(struct hl_device *hdev,
+		    int sensor_index, u32 attr, long *value);
 void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
 			long value);
 u64 hl_get_max_power(struct hl_device *hdev);
diff --git a/drivers/misc/habanalabs/hwmon.c b/drivers/misc/habanalabs/hwmon.c
index 70088fdb0a5b..3539190b1caa 100644
--- a/drivers/misc/habanalabs/hwmon.c
+++ b/drivers/misc/habanalabs/hwmon.c
@@ -113,6 +113,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 			u32 attr, int channel, long *val)
 {
 	struct hl_device *hdev = dev_get_drvdata(dev);
+	int rc;
 
 	if (hl_device_disabled_or_in_reset(hdev))
 		return -ENODEV;
@@ -131,7 +132,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 			return -EINVAL;
 		}
 
-		*val = hl_get_temperature(hdev, channel, attr);
+		rc = hl_get_temperature(hdev, channel, attr, val);
 		break;
 	case hwmon_in:
 		switch (attr) {
@@ -143,7 +144,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 			return -EINVAL;
 		}
 
-		*val = hl_get_voltage(hdev, channel, attr);
+		rc = hl_get_voltage(hdev, channel, attr, val);
 		break;
 	case hwmon_curr:
 		switch (attr) {
@@ -155,7 +156,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 			return -EINVAL;
 		}
 
-		*val = hl_get_current(hdev, channel, attr);
+		rc = hl_get_current(hdev, channel, attr, val);
 		break;
 	case hwmon_fan:
 		switch (attr) {
@@ -166,7 +167,7 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		default:
 			return -EINVAL;
 		}
-		*val = hl_get_fan_speed(hdev, channel, attr);
+		rc = hl_get_fan_speed(hdev, channel, attr, val);
 		break;
 	case hwmon_pwm:
 		switch (attr) {
@@ -176,12 +177,12 @@ static int hl_read(struct device *dev, enum hwmon_sensor_types type,
 		default:
 			return -EINVAL;
 		}
-		*val = hl_get_pwm_info(hdev, channel, attr);
+		rc = hl_get_pwm_info(hdev, channel, attr, val);
 		break;
 	default:
 		return -EINVAL;
 	}
-	return 0;
+	return rc;
 }
 
 static int hl_write(struct device *dev, enum hwmon_sensor_types type,
@@ -277,10 +278,10 @@ static const struct hwmon_ops hl_hwmon_ops = {
 	.write = hl_write
 };
 
-long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr)
+int hl_get_temperature(struct hl_device *hdev,
+			int sensor_index, u32 attr, long *value)
 {
 	struct armcp_packet pkt;
-	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -291,16 +292,16 @@ long hl_get_temperature(struct hl_device *hdev, int sensor_index, u32 attr)
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-			SENSORS_PKT_TIMEOUT, &result);
+			SENSORS_PKT_TIMEOUT, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to get temperature from sensor %d, error %d\n",
 			sensor_index, rc);
-		result = 0;
+		*value = 0;
 	}
 
-	return result;
+	return rc;
 }
 
 int hl_set_temperature(struct hl_device *hdev,
@@ -328,10 +329,10 @@ int hl_set_temperature(struct hl_device *hdev,
 	return rc;
 }
 
-long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr)
+int hl_get_voltage(struct hl_device *hdev,
+			int sensor_index, u32 attr, long *value)
 {
 	struct armcp_packet pkt;
-	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -342,22 +343,22 @@ long hl_get_voltage(struct hl_device *hdev, int sensor_index, u32 attr)
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, &result);
+					SENSORS_PKT_TIMEOUT, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to get voltage from sensor %d, error %d\n",
 			sensor_index, rc);
-		result = 0;
+		*value = 0;
 	}
 
-	return result;
+	return rc;
 }
 
-long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr)
+int hl_get_current(struct hl_device *hdev,
+			int sensor_index, u32 attr, long *value)
 {
 	struct armcp_packet pkt;
-	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -368,22 +369,22 @@ long hl_get_current(struct hl_device *hdev, int sensor_index, u32 attr)
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, &result);
+					SENSORS_PKT_TIMEOUT, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to get current from sensor %d, error %d\n",
 			sensor_index, rc);
-		result = 0;
+		*value = 0;
 	}
 
-	return result;
+	return rc;
 }
 
-long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr)
+int hl_get_fan_speed(struct hl_device *hdev,
+			int sensor_index, u32 attr, long *value)
 {
 	struct armcp_packet pkt;
-	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -394,22 +395,22 @@ long hl_get_fan_speed(struct hl_device *hdev, int sensor_index, u32 attr)
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, &result);
+					SENSORS_PKT_TIMEOUT, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to get fan speed from sensor %d, error %d\n",
 			sensor_index, rc);
-		result = 0;
+		*value = 0;
 	}
 
-	return result;
+	return rc;
 }
 
-long hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr)
+int hl_get_pwm_info(struct hl_device *hdev,
+			int sensor_index, u32 attr, long *value)
 {
 	struct armcp_packet pkt;
-	long result;
 	int rc;
 
 	memset(&pkt, 0, sizeof(pkt));
@@ -420,16 +421,16 @@ long hl_get_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr)
 	pkt.type = __cpu_to_le16(attr);
 
 	rc = hdev->asic_funcs->send_cpu_message(hdev, (u32 *) &pkt, sizeof(pkt),
-					SENSORS_PKT_TIMEOUT, &result);
+					SENSORS_PKT_TIMEOUT, value);
 
 	if (rc) {
 		dev_err(hdev->dev,
 			"Failed to get pwm info from sensor %d, error %d\n",
 			sensor_index, rc);
-		result = 0;
+		*value = 0;
 	}
 
-	return result;
+	return rc;
 }
 
 void hl_set_pwm_info(struct hl_device *hdev, int sensor_index, u32 attr,
-- 
2.17.1

