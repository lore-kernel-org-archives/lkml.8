Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2292BC81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:59:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC591206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FUGkiwYn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgD0W7K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0W7I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:59:08 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE3CC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:59:08 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id p25so9719050pfn.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQHSqB0WnK/F39fArXNFhdkTTuthtRGhQjjrFqJ6DzE=;
        b=FUGkiwYnU/t1yt6i9nCEXctMk1sekaVRcU3TtBoKL+v2Wa92y4Ai+qYQtMOQpEU6cR
         qKvMq6WCR83VideF/CGOWmdiTT0Sil1BNYXoyOTDgZfZWY+E9tqZSO4L6/k4Z2swE3uo
         w2xi8FyVALg/Xz7E2QSIpmI7FEMxmTPj9B02g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wQHSqB0WnK/F39fArXNFhdkTTuthtRGhQjjrFqJ6DzE=;
        b=sY+TpVMS3jyGaRn0FlXBMxScMSUXKjvKLj2wAI5rBvs1eP8pd+cKw/yC7Ty2qbpeUz
         ok50Z+CekeKHq/ZnvlFZo8S42co9RCdjavDLI2xIjwO+d02FQAgInMRl4TdF6oH4Cusw
         ddSeD84MnbO18n3+d+qS9Llfl8pEXI24OTUI4cbZdQRcWPiZT1GqZHLJwDwacUsO/2bj
         NbuICoRvmZuBETPkJctTfZrjPBczG3sOjRjd3kaxeQh0f/shgBHbB65dg0MYMSZevGSS
         /tfvM9aMjAcd432anIhK9jY91zfMg8r95xiT72hnEuMQ/oOwrzdTev+ZAaBneJ0HLBFO
         FH0w==
X-Gm-Message-State: AGi0PuYFWpiTVSojnrKaxSDhM3Ng45S8pGdInFXIr3Ab3iYxnf22Gfsk
        R9yEBEWsA/pJngEZ7I02o7c+CA==
X-Google-Smtp-Source: APiQypJcIW+MiErlyxz5HPETYDkr9PjSfuxY0bvpYVIlZh7dxsqpQ8byCe7E/wkVOBxjmLX929iEGQ==
X-Received: by 2002:aa7:8489:: with SMTP id u9mr7030764pfn.248.1588028348060;
        Mon, 27 Apr 2020 15:59:08 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id d124sm8511909pfa.98.2020.04.27.15.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 15:59:07 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     enric.balletbo@collabora.com, dianders@chromium.org
Cc:     bleung@chromium.org, groeck@chromium.org,
        linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] platform: chrome: Allocate sensorhub resource before claiming sensors
Date:   Mon, 27 Apr 2020 15:59:02 -0700
Message-Id: <20200427225902.30404-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.2.303.gf8c07b1a785-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allocate callbacks array before enumerating the sensors:
The probe routine for these sensors (for instance cros_ec_sensors_probe)
can be called within the sensorhub probe routine
(cros_ec_sensors_probe())

Fixes: 145d59baff594 ("platform/chrome: cros_ec_sensorhub: Add FIFO support")

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
 drivers/platform/chrome/cros_ec_sensorhub.c   | 80 +++++++++++--------
 .../platform/chrome/cros_ec_sensorhub_ring.c  | 73 ++++++++++-------
 .../linux/platform_data/cros_ec_sensorhub.h   |  1 +
 3 files changed, 93 insertions(+), 61 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index b7f2c00db5e1e..9c4af76a9956e 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -52,28 +52,15 @@ static int cros_ec_sensorhub_register(struct device *dev,
 	int sensor_type[MOTIONSENSE_TYPE_MAX] = { 0 };
 	struct cros_ec_command *msg = sensorhub->msg;
 	struct cros_ec_dev *ec = sensorhub->ec;
-	int ret, i, sensor_num;
+	int ret, i;
 	char *name;
 
-	sensor_num = cros_ec_get_sensor_count(ec);
-	if (sensor_num < 0) {
-		dev_err(dev,
-			"Unable to retrieve sensor information (err:%d)\n",
-			sensor_num);
-		return sensor_num;
-	}
-
-	sensorhub->sensor_num = sensor_num;
-	if (sensor_num == 0) {
-		dev_err(dev, "Zero sensors reported.\n");
-		return -EINVAL;
-	}
 
 	msg->version = 1;
 	msg->insize = sizeof(struct ec_response_motion_sense);
 	msg->outsize = sizeof(struct ec_params_motion_sense);
 
-	for (i = 0; i < sensor_num; i++) {
+	for (i = 0; i < sensorhub->sensor_num; i++) {
 		sensorhub->params->cmd = MOTIONSENSE_CMD_INFO;
 		sensorhub->params->info.sensor_num = i;
 
@@ -140,8 +127,7 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 	struct cros_ec_dev *ec = dev_get_drvdata(dev->parent);
 	struct cros_ec_sensorhub *data;
 	struct cros_ec_command *msg;
-	int ret;
-	int i;
+	int ret, i, sensor_num;
 
 	msg = devm_kzalloc(dev, sizeof(struct cros_ec_command) +
 			   max((u16)sizeof(struct ec_params_motion_sense),
@@ -166,10 +152,52 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, data);
 
 	/* Check whether this EC is a sensor hub. */
-	if (cros_ec_check_features(data->ec, EC_FEATURE_MOTION_SENSE)) {
+	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE)) {
+		sensor_num = cros_ec_get_sensor_count(ec);
+		if (sensor_num < 0) {
+			dev_err(dev,
+				"Unable to retrieve sensor information (err:%d)\n",
+				sensor_num);
+			return sensor_num;
+		}
+		if (sensor_num == 0) {
+			dev_err(dev, "Zero sensors reported.\n");
+			return -EINVAL;
+		}
+		data->sensor_num = sensor_num;
+
+		/*
+		 * Prepare the ring handler before enumering the
+		 * sensors.
+		 */
+		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+			ret = cros_ec_sensorhub_ring_allocate(data);
+			if (ret)
+				return ret;
+		}
+
+		/* Enumerate the sensors.*/
 		ret = cros_ec_sensorhub_register(dev, data);
 		if (ret)
 			return ret;
+
+		/*
+		 * When the EC does not have a FIFO, the sensors will query
+		 * their data themselves via sysfs or a software trigger.
+		 */
+		if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
+			ret = cros_ec_sensorhub_ring_add(data);
+			if (ret)
+				return ret;
+			/*
+			 * The msg and its data is not under the control of the
+			 * ring handler.
+			 */
+			return devm_add_action_or_reset(dev,
+					cros_ec_sensorhub_ring_remove,
+					data);
+		}
+
 	} else {
 		/*
 		 * If the device has sensors but does not claim to
@@ -184,22 +212,6 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 		}
 	}
 
-	/*
-	 * If the EC does not have a FIFO, the sensors will query their data
-	 * themselves via sysfs or a software trigger.
-	 */
-	if (cros_ec_check_features(ec, EC_FEATURE_MOTION_SENSE_FIFO)) {
-		ret = cros_ec_sensorhub_ring_add(data);
-		if (ret)
-			return ret;
-		/*
-		 * The msg and its data is not under the control of the ring
-		 * handler.
-		 */
-		return devm_add_action_or_reset(dev,
-						cros_ec_sensorhub_ring_remove,
-						data);
-	}
 
 	return 0;
 }
diff --git a/drivers/platform/chrome/cros_ec_sensorhub_ring.c b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
index c48e5b38a4417..24e48d96ed766 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub_ring.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub_ring.c
@@ -957,17 +957,15 @@ static int cros_ec_sensorhub_event(struct notifier_block *nb,
 }
 
 /**
- * cros_ec_sensorhub_ring_add() - Add the FIFO functionality if the EC
- *				  supports it.
+ * cros_ec_sensorhub_ring_allocate() - Prepare the FIFO functionality if the EC
+ *				       supports it.
  *
  * @sensorhub : Sensor Hub object.
  *
  * Return: 0 on success.
  */
-int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
+int cros_ec_sensorhub_ring_allocate(struct cros_ec_sensorhub *sensorhub)
 {
-	struct cros_ec_dev *ec = sensorhub->ec;
-	int ret;
 	int fifo_info_length =
 		sizeof(struct ec_response_motion_sense_fifo_info) +
 		sizeof(u16) * sensorhub->sensor_num;
@@ -978,6 +976,49 @@ int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
 	if (!sensorhub->fifo_info)
 		return -ENOMEM;
 
+	/*
+	 * Allocate the callback area based on the number of sensors.
+	 * Add one for the sensor ring.
+	 */
+	sensorhub->push_data = devm_kcalloc(sensorhub->dev,
+			sensorhub->sensor_num,
+			sizeof(*sensorhub->push_data),
+			GFP_KERNEL);
+	if (!sensorhub->push_data)
+		return -ENOMEM;
+
+	sensorhub->tight_timestamps = cros_ec_check_features(
+			sensorhub->ec,
+			EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS);
+
+	if (sensorhub->tight_timestamps) {
+		sensorhub->batch_state = devm_kcalloc(sensorhub->dev,
+				sensorhub->sensor_num,
+				sizeof(*sensorhub->batch_state),
+				GFP_KERNEL);
+		if (!sensorhub->batch_state)
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/**
+ * cros_ec_sensorhub_ring_add() - Add the FIFO functionality if the EC
+ *				  supports it.
+ *
+ * @sensorhub : Sensor Hub object.
+ *
+ * Return: 0 on success.
+ */
+int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
+{
+	struct cros_ec_dev *ec = sensorhub->ec;
+	int ret;
+	int fifo_info_length =
+		sizeof(struct ec_response_motion_sense_fifo_info) +
+		sizeof(u16) * sensorhub->sensor_num;
+
 	/* Retrieve FIFO information */
 	sensorhub->msg->version = 2;
 	sensorhub->params->cmd = MOTIONSENSE_CMD_FIFO_INFO;
@@ -998,31 +1039,9 @@ int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub)
 	if (!sensorhub->ring)
 		return -ENOMEM;
 
-	/*
-	 * Allocate the callback area based on the number of sensors.
-	 */
-	sensorhub->push_data = devm_kcalloc(
-			sensorhub->dev, sensorhub->sensor_num,
-			sizeof(*sensorhub->push_data),
-			GFP_KERNEL);
-	if (!sensorhub->push_data)
-		return -ENOMEM;
-
 	sensorhub->fifo_timestamp[CROS_EC_SENSOR_LAST_TS] =
 		cros_ec_get_time_ns();
 
-	sensorhub->tight_timestamps = cros_ec_check_features(
-			ec, EC_FEATURE_MOTION_SENSE_TIGHT_TIMESTAMPS);
-
-	if (sensorhub->tight_timestamps) {
-		sensorhub->batch_state = devm_kcalloc(sensorhub->dev,
-				sensorhub->sensor_num,
-				sizeof(*sensorhub->batch_state),
-				GFP_KERNEL);
-		if (!sensorhub->batch_state)
-			return -ENOMEM;
-	}
-
 	/* Register the notifier that will act as a top half interrupt. */
 	sensorhub->notifier.notifier_call = cros_ec_sensorhub_event;
 	ret = blocking_notifier_chain_register(&ec->ec_dev->event_notifier,
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index c588be843f61b..0ecce6aa69d5e 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -185,6 +185,7 @@ int cros_ec_sensorhub_register_push_data(struct cros_ec_sensorhub *sensorhub,
 void cros_ec_sensorhub_unregister_push_data(struct cros_ec_sensorhub *sensorhub,
 					    u8 sensor_num);
 
+int cros_ec_sensorhub_ring_allocate(struct cros_ec_sensorhub *sensorhub);
 int cros_ec_sensorhub_ring_add(struct cros_ec_sensorhub *sensorhub);
 void cros_ec_sensorhub_ring_remove(void *arg);
 int cros_ec_sensorhub_ring_fifo_enable(struct cros_ec_sensorhub *sensorhub,
-- 
2.26.2.303.gf8c07b1a785-goog

