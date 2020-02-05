Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC6C3C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:06:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A2120730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X3hdG3lT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727457AbgBETGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:06:38 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:51669 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727079AbgBETGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:06:38 -0500
Received: by mail-pj1-f68.google.com with SMTP id fa20so1380334pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:06:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2yFXXmlOg1wnpeRlTtc5VQSQ7oIwXBFZwL1fsNj+6KM=;
        b=X3hdG3lT+pAciwWcbgJri3QYb2vSDW3CgEYZFlaziYvEbrx4OLIPlCgYBWJTCP/dX3
         dZ6wPCCD54hUBgW43se+m8T+6M3fuo5IzNUgthSmzSqEYMZm2VZT2XyS/F8JKSXCFuPE
         dTLqUZGM2ctY/Vi7hjQ5AxlPmiiheNMzrQFU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2yFXXmlOg1wnpeRlTtc5VQSQ7oIwXBFZwL1fsNj+6KM=;
        b=i2M7lB0U4O8XBXerObJGMFzkdGIG++0FYnluPdY7jmf0O/xobu1Q/t/xEigBEhIRpi
         5ISMtq7RAwaL+AwS+R7idd5VmPJ5+yrsr9ndwWSW8ata0i9hFDlgnVA0bEcn6dQHyAPv
         LkZ1DPG7pmjhdn6w2qyrYM0AZO88x+KJx5JKYaxLjnq8CkIY9+tZqX51r0lgNQidBoO5
         JnDBzJcS0yQ3iXtDxctNXPa8wmiex7Cl1sxYCRtd7XICkKSbJYd1xJK0vOCfrV2N8Hbz
         +4pR5ospkfLlatTSNnuQjfRWdYdMx2GRpMNwPZoIviJlupV3CX+hfrkGd2vhlzES1GU/
         R2Vw==
X-Gm-Message-State: APjAAAWiySTXoDx2OGZPyx7+wrlYEj+fCOHqb44ZjIjwCwB5V1HmpKvh
        jzkUMh+DUTdsOtywCExz00JLbfTeiVE=
X-Google-Smtp-Source: APXvYqy5N9/p0fWTe+U2Lu6ZxOE1Y1VTGKOI7fW9trk66v34MJXnTxboA1xkXuEeWI6hKHMU9R3RYw==
X-Received: by 2002:a17:902:567:: with SMTP id 94mr35829341plf.174.1580929597230;
        Wed, 05 Feb 2020 11:06:37 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.06.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:06:36 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 05/17] platform/chrome: sensorhub: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:03 -0800
Message-Id: <20200205190028.183069-6-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the register() function to use the new cros_ec_cmd() function
instead of cros_ec_cmd_xfer_status().

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/platform/chrome/cros_ec_sensorhub.c | 30 +++++++++------------
 1 file changed, 13 insertions(+), 17 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sensorhub.c b/drivers/platform/chrome/cros_ec_sensorhub.c
index 79fefd3bb0fa61..3ccf98af89453c 100644
--- a/drivers/platform/chrome/cros_ec_sensorhub.c
+++ b/drivers/platform/chrome/cros_ec_sensorhub.c
@@ -53,7 +53,7 @@ static int cros_ec_sensorhub_register(struct device *dev,
 	struct cros_ec_dev *ec = sensorhub->ec;
 	struct ec_params_motion_sense *params;
 	struct ec_response_motion_sense *resp;
-	struct cros_ec_command *msg;
+	void *ec_buf;
 	int ret, i, sensor_num;
 	char *name;
 
@@ -70,27 +70,24 @@ static int cros_ec_sensorhub_register(struct device *dev,
 		return -EINVAL;
 	}
 
-	/* Prepare a message to send INFO command to each sensor. */
-	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*resp)),
-		      GFP_KERNEL);
-	if (!msg)
+	ec_buf = kzalloc(max(sizeof(*params), sizeof(*resp)), GFP_KERNEL);
+	if (!ec_buf)
 		return -ENOMEM;
 
-	msg->version = 1;
-	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
-	msg->outsize = sizeof(*params);
-	msg->insize = sizeof(*resp);
-	params = (struct ec_params_motion_sense *)msg->data;
-	resp = (struct ec_response_motion_sense *)msg->data;
+	params = ec_buf;
+	resp = ec_buf;
 
 	for (i = 0; i < sensor_num; i++) {
 		params->cmd = MOTIONSENSE_CMD_INFO;
 		params->info.sensor_num = i;
 
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+		ret = cros_ec_cmd(ec->ec_dev, 1,
+				  EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset,
+				  params, sizeof(*params), resp, sizeof(*resp),
+				  NULL);
 		if (ret < 0) {
-			dev_warn(dev, "no info for EC sensor %d : %d/%d\n",
-				 i, ret, msg->result);
+			dev_warn(dev, "no info for EC sensor %d : %d\n",
+				 i, ret);
 			continue;
 		}
 
@@ -140,11 +137,10 @@ static int cros_ec_sensorhub_register(struct device *dev,
 			goto error;
 	}
 
-	kfree(msg);
-	return 0;
+	ret =  0;
 
 error:
-	kfree(msg);
+	kfree(ec_buf);
 	return ret;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

