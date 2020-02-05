Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D2CC35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55CB921741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:09:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bEaYo/0O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbgBETJi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:09:38 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41577 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbgBETJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:09:38 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so1260990plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:09:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQwjxtnCuhNLgby4wbmF8n20Zz+eQKPbKb6xRpOo1+Y=;
        b=bEaYo/0OG7G4bg2lFM5kTYQQvYQPiVHZd9xuqDapJFMOgmPc8N5xliVdxLcbn2mH3z
         9NKCaueAjDicw43YIh3MRNyiuMwLVk7728Yc5U9U0Fo+b35KIYghdR9aodPRIeYaZIwq
         QQDVJzwXvMLeEFjin4Z2yNy+SKPP7KOLSJhXM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQwjxtnCuhNLgby4wbmF8n20Zz+eQKPbKb6xRpOo1+Y=;
        b=fJGQAQVoftJVWqLpOQpE4DeGZhJ60/1awg+kzWKUGqIIQpzXY2I2Wf/voEumxGka2w
         L2KHHmTP76G8xkvQQtJTc9NqnqrGrungq3Cl1K6A7JGNuS5leUQE+pZwB9PbVVfY4HiV
         tRWZgCIgAep2tNdLFDMswdVwYIro4MKXEVr2D8QjeWVcspQPO0Bn1rOoEJG4zSqNH4/5
         oiNkyqf7Vx/tSvkJZf49YP0YgbaqMIlcF0guD8bhkTJEZ5QFIzVcwJRxMt+IAZjFaEPA
         zc7O8S75NUBfBQNuqRVFIWgqQuffcLsTaw6KC9rw61Ud6XpZUxEKiG+8FR9I5oaW3oXT
         v6cA==
X-Gm-Message-State: APjAAAXkJzZQpw/xpQ9S4b8XAQ72u6Tq4K5BhCuF8iGNHDmfKwNbzfDf
        y3kK7Hkkzo/r+ToNGVMEP10G07Tm/t8=
X-Google-Smtp-Source: APXvYqzE0wh0/PvbAsBgluXB7J12nEot424BnZLQBg4/3szM5HNdx6KpcwShp85X6JrHeKUB7lztFg==
X-Received: by 2002:a17:902:8642:: with SMTP id y2mr35879837plt.306.1580929777005;
        Wed, 05 Feb 2020 11:09:37 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.09.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:09:36 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 07/17] platform/chrome: sysfs: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:07 -0800
Message-Id: <20200205190028.183069-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() calls to the new function
cros_ec_cmd() which is more readable and does the message setup code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/platform/chrome/cros_ec_sysfs.c | 103 +++++++++---------------
 1 file changed, 39 insertions(+), 64 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 07dac97ad57c67..107eb81dff1305 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -51,20 +51,13 @@ static ssize_t reboot_store(struct device *dev,
 		{"hibernate",    EC_REBOOT_HIBERNATE, 0},
 		{"at-shutdown",  -1, EC_REBOOT_FLAG_ON_AP_SHUTDOWN},
 	};
-	struct cros_ec_command *msg;
-	struct ec_params_reboot_ec *param;
+	struct ec_params_reboot_ec param = {0};
 	int got_cmd = 0, offset = 0;
 	int i;
 	int ret;
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
-	msg = kmalloc(sizeof(*msg) + sizeof(*param), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	param = (struct ec_params_reboot_ec *)msg->data;
-
-	param->flags = 0;
+	param.flags = 0;
 	while (1) {
 		/* Find word to start scanning */
 		while (buf[offset] && isspace(buf[offset]))
@@ -76,9 +69,9 @@ static ssize_t reboot_store(struct device *dev,
 			if (!strncasecmp(words[i].str, buf+offset,
 					 strlen(words[i].str))) {
 				if (words[i].flags) {
-					param->flags |= words[i].flags;
+					param.flags |= words[i].flags;
 				} else {
-					param->cmd = words[i].cmd;
+					param.cmd = words[i].cmd;
 					got_cmd = 1;
 				}
 				break;
@@ -95,15 +88,11 @@ static ssize_t reboot_store(struct device *dev,
 		goto exit;
 	}
 
-	msg->version = 0;
-	msg->command = EC_CMD_REBOOT_EC + ec->cmd_offset;
-	msg->outsize = sizeof(*param);
-	msg->insize = 0;
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	ret = cros_ec_cmd(ec->ec_dev, 0, EC_CMD_REBOOT_EC + ec->cmd_offset,
+			  &param, sizeof(param), NULL, 0, NULL);
 	if (ret < 0)
 		count = ret;
 exit:
-	kfree(msg);
 	return count;
 }
 
@@ -115,25 +104,23 @@ static ssize_t version_show(struct device *dev,
 	struct ec_response_get_chip_info *r_chip;
 	struct ec_response_board_version *r_board;
 	struct cros_ec_command *msg;
+	void *ec_buf;
 	int ret;
 	int count = 0;
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
-	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
-	if (!msg)
+	ec_buf = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!ec_buf)
 		return -ENOMEM;
 
 	/* Get versions. RW may change. */
-	msg->version = 0;
-	msg->command = EC_CMD_GET_VERSION + ec->cmd_offset;
-	msg->insize = sizeof(*r_ver);
-	msg->outsize = 0;
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	ret = cros_ec_cmd(ec->ec_dev, 0, EC_CMD_GET_VERSION  + ec->cmd_offset,
+			  NULL, 0, ec_buf, sizeof(*r_ver), NULL);
 	if (ret < 0) {
 		count = ret;
 		goto exit;
 	}
-	r_ver = (struct ec_response_get_version *)msg->data;
+	r_ver = (struct ec_response_get_version *)ec_buf;
 	/* Strings should be null-terminated, but let's be sure. */
 	r_ver->version_string_ro[sizeof(r_ver->version_string_ro) - 1] = '\0';
 	r_ver->version_string_rw[sizeof(r_ver->version_string_rw) - 1] = '\0';
@@ -145,8 +132,10 @@ static ssize_t version_show(struct device *dev,
 			   "Firmware copy: %s\n",
 			   (r_ver->current_image < ARRAY_SIZE(image_names) ?
 			    image_names[r_ver->current_image] : "?"));
+	memset(ec_buf, 0, sizeof(*msg) + EC_HOST_PARAM_SIZE);
 
 	/* Get build info. */
+	msg = (struct cros_ec_command *)ec_buf;
 	msg->command = EC_CMD_GET_BUILD_INFO + ec->cmd_offset;
 	msg->insize = EC_HOST_PARAM_SIZE;
 	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
@@ -205,40 +194,28 @@ static ssize_t version_show(struct device *dev,
 	}
 
 exit:
-	kfree(msg);
+	kfree(ec_buf);
 	return count;
 }
 
 static ssize_t flashinfo_show(struct device *dev,
 			      struct device_attribute *attr, char *buf)
 {
-	struct ec_response_flash_info *resp;
-	struct cros_ec_command *msg;
+	struct ec_response_flash_info resp = {0};
 	int ret;
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 
-	msg = kmalloc(sizeof(*msg) + sizeof(*resp), GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
-
-	/* The flash info shouldn't ever change, but ask each time anyway. */
-	msg->version = 0;
-	msg->command = EC_CMD_FLASH_INFO + ec->cmd_offset;
-	msg->insize = sizeof(*resp);
-	msg->outsize = 0;
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	ret = cros_ec_cmd(ec->ec_dev, 0, EC_CMD_FLASH_INFO + ec->cmd_offset,
+			  NULL, 0, &resp, sizeof(resp), NULL);
 	if (ret < 0)
 		goto exit;
 
-	resp = (struct ec_response_flash_info *)msg->data;
-
 	ret = scnprintf(buf, PAGE_SIZE,
 			"FlashSize %d\nWriteSize %d\n"
 			"EraseSize %d\nProtectSize %d\n",
-			resp->flash_size, resp->write_block_size,
-			resp->erase_block_size, resp->protect_block_size);
+			resp.flash_size, resp.write_block_size,
+			resp.erase_block_size, resp.protect_block_size);
 exit:
-	kfree(msg);
 	return ret;
 }
 
@@ -249,29 +226,27 @@ static ssize_t kb_wake_angle_show(struct device *dev,
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct ec_response_motion_sense *resp;
 	struct ec_params_motion_sense *param;
-	struct cros_ec_command *msg;
+	void *ec_buf;
 	int ret;
 
-	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
-	if (!msg)
+	ec_buf = kmalloc(EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!ec_buf)
 		return -ENOMEM;
 
-	param = (struct ec_params_motion_sense *)msg->data;
-	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
-	msg->version = 2;
+	param = (struct ec_params_motion_sense *)ec_buf;
+	resp = (struct ec_response_motion_sense *)ec_buf;
 	param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
 	param->kb_wake_angle.data = EC_MOTION_SENSE_NO_VALUE;
-	msg->outsize = sizeof(*param);
-	msg->insize = sizeof(*resp);
 
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	ret = cros_ec_cmd(ec->ec_dev, 2,
+			  EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset, param,
+			  sizeof(*param), resp, sizeof(*resp), NULL);
 	if (ret < 0)
 		goto exit;
 
-	resp = (struct ec_response_motion_sense *)msg->data;
 	ret = scnprintf(buf, PAGE_SIZE, "%d\n", resp->kb_wake_angle.ret);
 exit:
-	kfree(msg);
+	kfree(ec_buf);
 	return ret;
 }
 
@@ -281,7 +256,8 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 {
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct ec_params_motion_sense *param;
-	struct cros_ec_command *msg;
+	struct ec_response_motion_sense *resp;
+	void *ec_buf;
 	u16 angle;
 	int ret;
 
@@ -289,20 +265,19 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 	if (ret)
 		return ret;
 
-	msg = kmalloc(sizeof(*msg) + EC_HOST_PARAM_SIZE, GFP_KERNEL);
-	if (!msg)
+	ec_buf = kmalloc(EC_HOST_PARAM_SIZE, GFP_KERNEL);
+	if (!ec_buf)
 		return -ENOMEM;
 
-	param = (struct ec_params_motion_sense *)msg->data;
-	msg->command = EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset;
-	msg->version = 2;
+	param = (struct ec_params_motion_sense *)ec_buf;
+	resp = (struct ec_response_motion_sense *)ec_buf;
 	param->cmd = MOTIONSENSE_CMD_KB_WAKE_ANGLE;
 	param->kb_wake_angle.data = angle;
-	msg->outsize = sizeof(*param);
-	msg->insize = sizeof(struct ec_response_motion_sense);
 
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
-	kfree(msg);
+	ret = cros_ec_cmd(ec->ec_dev, 2,
+			  EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset, param,
+			  sizeof(*param), resp, sizeof(*resp), NULL);
+	kfree(ec_buf);
 	if (ret < 0)
 		return ret;
 	return count;
-- 
2.25.0.341.g760bfbb309-goog

