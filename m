Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 622F6C54EEB
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:28:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39A0920714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 20:28:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eEVyWcqX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgCXU2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 16:28:05 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34330 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728219AbgCXU2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 16:28:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id 23so9930870pfj.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aG3ZG/JseQ9SHgEGTa48Huh2O7B5gsYW9O6b0GiUzZo=;
        b=eEVyWcqXnp/Fdd1gQU3vtTzHqjyGFSC1Gxxb4UYfyVOoa84+V7sy/oZDeYU7mJ3sOP
         S5ULEOjK3Bl5+CfiQGxI0p6lUuKqqQ2tmriaS0oqV7384B+05d3ZeTctCsvGUqWoAQ3E
         p0F1fBYGAsHKJmdkX/WDt9UvI9Xf37h8ZxQek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aG3ZG/JseQ9SHgEGTa48Huh2O7B5gsYW9O6b0GiUzZo=;
        b=UXEVePzZNDAghdbuEHhiCqzoMpYaVv1LQ3tkNU+NtMV387vLUYVB6m4MEE+yKsL6wD
         12LplyJaRt4t3fyGxHqd+VCNTvvH8RPAATmiAAWhBAvOEhX+dqHMa5wSTpmDB3ld0v+A
         kHczsr9sNVdtcsyngboxm/2hT6D0262vRioJVoUsro6UQ1Z/tLMhWqyIMqR5dvqA7aqL
         IDa6Bu0Sqxi9t9GOhlMtUedfiEOIfU4J85fVm9mf8Y5np7cE3nQydPYddNTuCC5XcKqP
         jdVtZf5qy+wHiv0/kAVS020YVQB8j3Z65FNtfw+ZKjtNrnnOExhocasTTv0RYhHP9OVE
         pz0A==
X-Gm-Message-State: ANhLgQ21DU/rH+dzxeJRzX8AuOOLJ1wsCqErernXnsNCeYQX1f1s9Myd
        zNQJ97H5OVmeUwZRZt/Asso9jg==
X-Google-Smtp-Source: ADFU+vsZBe8JrbNa0VLrHSDVrWMSTj1DEaHQdKmwz64a+ux0d1WYmgQc5n2eh8ePMaAouYw7QryK9w==
X-Received: by 2002:a65:5846:: with SMTP id s6mr29062581pgr.179.1585081680649;
        Tue, 24 Mar 2020 13:28:00 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id 193sm9900116pfa.182.2020.03.24.13.27.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2020 13:28:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v6 11/11] iio: cros_ec: flush as hwfifo attribute
Date:   Tue, 24 Mar 2020 13:27:36 -0700
Message-Id: <20200324202736.243314-12-gwendal@chromium.org>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
In-Reply-To: <20200324202736.243314-1-gwendal@chromium.org>
References: <20200324202736.243314-1-gwendal@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add buffer/hwfifo_flush. It is not part of the ABI, but it follows ST
and HID lead: Tells the sensor hub to send to the host all pending
sensor events.

Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
---
New in v6.

 .../cros_ec_sensors/cros_ec_sensors_core.c    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
index c831915ca7e56..aaf124a82e0e4 100644
--- a/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
+++ b/drivers/iio/common/cros_ec_sensors/cros_ec_sensors_core.c
@@ -113,6 +113,33 @@ static int cros_ec_sensor_set_ec_rate(struct cros_ec_sensors_core_state *st,
 	return ret;
 }
 
+static ssize_t cros_ec_sensors_flush(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t len)
+{
+	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
+	struct cros_ec_sensors_core_state *st = iio_priv(indio_dev);
+	int ret = 0;
+	bool flush;
+
+	ret = strtobool(buf, &flush);
+	if (ret < 0)
+		return ret;
+	if (!flush)
+		return -EINVAL;
+
+	mutex_lock(&st->cmd_lock);
+	st->param.cmd = MOTIONSENSE_CMD_FIFO_FLUSH;
+	ret = cros_ec_motion_send_host_cmd(st, 0);
+	if (ret != 0)
+		dev_warn(&indio_dev->dev, "Unable to flush sensor\n");
+	mutex_unlock(&st->cmd_lock);
+	return ret ? ret : len;
+}
+
+static IIO_DEVICE_ATTR(hwfifo_flush, 0644, NULL,
+		       cros_ec_sensors_flush, 0);
+
 static ssize_t cros_ec_sensor_set_report_latency(struct device *dev,
 						 struct device_attribute *attr,
 						 const char *buf, size_t len)
@@ -175,6 +202,7 @@ static ssize_t hwfifo_watermark_max_show(struct device *dev,
 static IIO_DEVICE_ATTR_RO(hwfifo_watermark_max, 0);
 
 const struct attribute *cros_ec_sensor_fifo_attributes[] = {
+	&iio_dev_attr_hwfifo_flush.dev_attr.attr,
 	&iio_dev_attr_hwfifo_timeout.dev_attr.attr,
 	&iio_dev_attr_hwfifo_watermark_max.dev_attr.attr,
 	NULL,
-- 
2.25.1.696.g5e7596f4ac-goog

