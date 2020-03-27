Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A85C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:35:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2599820748
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 22:35:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CnPBKlyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727934AbgC0WfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 18:35:14 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40826 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbgC0WfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 18:35:03 -0400
Received: by mail-pg1-f196.google.com with SMTP id t24so5263614pgj.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Mar 2020 15:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3+1xmr1a9eg3AmnjLomjOPKSe+onX/qqluNCv1dv8I0=;
        b=CnPBKlywSOzMLnPL2jTSRxHG2ElBI7BnPECo8RQl/yi5yG38NJr86kKApXZ1+Dt/lN
         C4OVdG0T0UngFQM7gI8byJaTjJZGMRWfLB7jrTyrlD3XrPZDsbmuQZVGcP9F5PSZccUe
         OjLYATwVq5Q9BtbteK+guA18WiPtI3oRfVTTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3+1xmr1a9eg3AmnjLomjOPKSe+onX/qqluNCv1dv8I0=;
        b=oNTevf3CnxBfFc+n/r6ivdDv3vjJ2nXb9hzaakYtAt3pbxBnpIr5dfNujssJ2gEQxA
         0UM7a5VtL94qWZWJZ3rpDqOe+Apdaxej/WzPyrJ4zkIFortz96xHPvSQW8IlKwSJXL5Z
         r6xhiaCf1G+D6yTnXeY5ql2V17IV6w23DICzosWm9wZBA5sTvZP5vvISi0yIBPFNQYmJ
         JySYEFPrsuk2Rjvogop457DUtGMuCyEFwvgkBAwTD0rXNCO9ycv2J5pWB/IrwqDW9Qrf
         CFv8SeunM/M4KWwra5oIX1gTg/5aSHO60y5bEMFuzh4edZVgn3HmBYqzPQOg7tugc34P
         gHkw==
X-Gm-Message-State: ANhLgQ2oLLjMyNIhWr4FYwN47i1lhr1SWbYTX5dhmiHXOMgh29Lqn/GT
        /6bzAu5WNfN6chNHj2rRO8WTjA==
X-Google-Smtp-Source: ADFU+vsD97GkxfZVdvTRqrAFA5EqUkKPIHRm7Zw+f1cdlx7onYBRpR49+dsNQdauolRMFSp/iCv48w==
X-Received: by 2002:a63:5847:: with SMTP id i7mr1534992pgm.127.1585348501236;
        Fri, 27 Mar 2020 15:35:01 -0700 (PDT)
Received: from localhost ([2620:15c:202:1:4cc0:7eee:97c9:3c1a])
        by smtp.gmail.com with ESMTPSA id f22sm4588981pgl.20.2020.03.27.15.35.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Mar 2020 15:35:00 -0700 (PDT)
From:   Gwendal Grignou <gwendal@chromium.org>
To:     bleung@chromium.org, enric.balletbo@collabora.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH v7 12/12] iio: cros_ec: flush as hwfifo attribute
Date:   Fri, 27 Mar 2020 15:34:43 -0700
Message-Id: <20200327223443.6006-13-gwendal@chromium.org>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200327223443.6006-1-gwendal@chromium.org>
References: <20200327223443.6006-1-gwendal@chromium.org>
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
No changes in v7.
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
2.26.0.rc2.310.g2932bb562d-goog

