Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D70C43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE9A20717
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fFJMe+uv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727795AbgC0Wev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:34:51 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37383 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727655AbgC0Weu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:34:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id h72so5187307pfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4W7il/SUE8zUP0mcJ/uA7eBv3zkE6qgGXJ8Gi2G1bGc=;
        b=fFJMe+uv7dx/GIdNbdWPiOEuHJbIMI2boKej//D6yPWsBog+iuRnO1i8EK8XtHwwQl
         tewoenQ+8uI/9F/fXK9tN2P9tMmV4WRFzFKGAJhcrT1WN695Hl1f91Q98A+E+H5QZ5Mf
         vs1iyY1rxXshI2BuE7UqTH1kWbEtPaqdLS1yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4W7il/SUE8zUP0mcJ/uA7eBv3zkE6qgGXJ8Gi2G1bGc=;
        b=Oc0dIGIgru5ZxUQJrCa/qkO9fS71t3wo1n+4v/2uLKpn8qxu+iOG1QcgLXd1MRZNie
         uOcrQy7tTmqAPGR6Am8QJtwCKdktgKtKWdc7us+lk9lSJEIxwxbNlFG8mXXc+gT01d8C
         EE+gL4sb+DMrhEyZrnikPY8TAQOP5lsSwNbpyixH6QZfAc21cD7r9ziJv4Lyzd7ym4TB
         WSr5q6T6ZyrpKe6pEGyhCZLId+Yd0hW2fHyv26xUFo6H+o1gYtLKkMGrwyQp7NTdt1Z1
         FCUInQ59VCD1TYwCfV4UaABejIB2BpngjofNZGer7qDk9LwB0T6mjxJZ7f1cbfdWvaEt
         yr+w==
X-Gm-Message-State: ANhLgQ1zx9EofGHsc/mceV03J0jp4es8dh/FqQcKzHmiUbErVryANxol
        ZLGT0f0bPaGJC8PTAUU2xyXZ7w==
X-Google-Smtp-Source: ADFU+vsEQm58Y6bck8dGuJISGBC8slSFs3004K27R3DUjblqN6/o1Gnrj1QUOPMHhugguLyolhfBsQ==
X-Received: by 2002:a63:5004:: with SMTP id e4mr1496115pgb.19.1585348487774;
        Fri, 27 Mar 2020 15:34:47 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id a2sm4441959pjq.20.2020.03.27.15.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:34:47 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 01/12] platform: chrome: sensorhub: Add the number of sensors in sensorhub
Date:   Fri, 27 Mar 2020 15:34:32 -0700
Message-Id: <20200327223443.6006-2-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To better manage resources, store the number of sensors reported by
the EC.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v7

 drivers/platform/chrome/cros_ec_sensorhub.c     | 4 +++-
 include/linux/platform_data/cros_ec_sensorhub.h | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 79fefd3bb0fa6..134ee5e460472 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -65,6 +65,7 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		return sensor_num;
 	}
 
+	sensorhub->sensor_num = sensor_num;
 	if (sensor_num == 0) {
 		dev_err(dev, "Zero sensors reported.\n");
 		return -EINVAL;
@@ -172,7 +173,8 @@ static int cros_ec_sensorhub_probe(struct platform_device *pdev)
 		 * If the device has sensors but does not claim to
 		 * be a sensor hub, we are in legacy mode.
 		 */
-		for (i = 0; i < 2; i++) {
+		data->sensor_num = 2;
+		for (i = 0; i < data->sensor_num; i++) {
 			ret = cros_ec_sensorhub_allocate_sensor(dev,
 						"cros-ec-accel-legacy", i);
 			if (ret)
diff --git a/include/linux/platform_data/cros_ec_sensorhub.h b/include/linux/platform_data/cros_ec_sensorhub.h
index bef7ffc7fce10..7e46a47fd642b 100644
--- a/include/linux/platform_data/cros_ec_sensorhub.h
+++ b/include/linux/platform_data/cros_ec_sensorhub.h
@@ -22,9 +22,11 @@ struct cros_ec_sensor_platform {
  * struct cros_ec_sensorhub - Sensor Hub device data.
  *
  * @ec: Embedded Controller where the hub is located.
+ * @sensor_num: Number of MEMS sensors present in the EC.
  */
 struct cros_ec_sensorhub {
 	struct cros_ec_dev *ec;
+	int sensor_num;
 };
 
 #endif   /* __LINUX_PLATFORM_DATA_CROS_EC_SENSORHUB_H */
-- 
2.26.0.rc2.310.g2932bb562d-goog

