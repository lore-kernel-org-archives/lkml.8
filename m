Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4429FC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DC1020708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BmOwB5s2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgA3UeA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:34:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:54333 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727801AbgA3Ud7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:59 -0500
Received: by mail-pj1-f65.google.com with SMTP id dw13so1833382pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:33:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6aPMzV2Twuv/PNe7f+NGNr6jf/YyibOiqVxBpI/Om0U=;
        b=BmOwB5s2VR3gXrSAcICvbniyjGZRamp2jkUqWxzFxoZwoPNSFHzlYpVUpoESdUtMmN
         Dk+06KpWRAIb3gNW6L4X0My2rocciAsC4NnP5LfuN3VjkOZ/NWxRSNkafXsIhrenwP1C
         v/R8WF+DNtBBes06nxn9UVqQT2D0FaXB3RKUo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6aPMzV2Twuv/PNe7f+NGNr6jf/YyibOiqVxBpI/Om0U=;
        b=DIBQ6/RP2nXbS4B4kTeW8QhQHwOuBtBEm8ArAG1qPmbwxYn7t8svs+eb+734iDX6jg
         6nezx+BL7+ewCorbOGXDaPiz1fMbuEAqa/FvFS98zg5bt4H+pOGJqpUaib7cXKSiuA1z
         Az2lTTQefDjnNogGpxWOZOlMpU19yuMnvEfDzpxQUSxmLONKvry+tH80ysdCKOwIO11i
         piJaW5/21Vm15jfTVWbtz5YSwIHtnBGiEo9elqFxkz4doFB9o94vMvskfRQSYIkGJx0R
         usHZXM5Mrv4YIN1WAij4++23SOLvBwdveNM+RHDe5FKst5JUdfZVjtG3FZ3T7FOe4kb3
         VwOQ==
X-Gm-Message-State: APjAAAWOQRK+qLWbad/wAqaq+e9v/7dDGZTUaR5FqAiFa0JYzW5spScm
        D6MeCTrnjeuFJKeQQHwl4+dpp8yJQlo=
X-Google-Smtp-Source: APXvYqyIoAwW3bIE4yiLiJHEAs0ZRiFzLRL9e37f9nSuDNYegDj3aB1doTXCHljKX5/FfL/9C+7PMA==
X-Received: by 2002:a17:90a:8a0c:: with SMTP id w12mr7924130pjn.61.1580416438940;
        Thu, 30 Jan 2020 12:33:58 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:58 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 07/17] platform/chrome: sysfs: Use send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:47 -0800
Message-Id: <20200130203106.201894-8-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200130203106.201894-1-pmalani@chromium.org>
References: <20200130203106.201894-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() calls to the new function
cros_ec_send_cmd_msg() which is more readable and does the message setup code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_sysfs.c | 106 ++++++++++--------------
 1 file changed, 42 insertions(+), 64 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 74d36b8d4f46c7..87d5bfa1fcfa61 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -52,20 +52,13 @@ static ssize_t reboot_store(struct device *dev,
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
@@ -77,9 +70,9 @@ static ssize_t reboot_store(struct device *dev,
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
@@ -96,15 +89,12 @@ static ssize_t reboot_store(struct device *dev,
 		goto exit;
 	}
 
-	msg->version = 0;
-	msg->command = EC_CMD_REBOOT_EC + ec->cmd_offset;
-	msg->outsize = sizeof(*param);
-	msg->insize = 0;
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+				   EC_CMD_REBOOT_EC + ec->cmd_offset,
+				   &param, sizeof(param), NULL, 0);
 	if (ret < 0)
 		count = ret;
 exit:
-	kfree(msg);
 	return count;
 }
 
@@ -116,25 +106,24 @@ static ssize_t version_show(struct device *dev,
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
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+				   EC_CMD_GET_VERSION  + ec->cmd_offset,
+				   NULL, 0, ec_buf, sizeof(*r_ver));
 	if (ret < 0) {
 		count = ret;
 		goto exit;
 	}
-	r_ver = (struct ec_response_get_version *)msg->data;
+	r_ver = (struct ec_response_get_version *)ec_buf;
 	/* Strings should be null-terminated, but let's be sure. */
 	r_ver->version_string_ro[sizeof(r_ver->version_string_ro) - 1] = '\0';
 	r_ver->version_string_rw[sizeof(r_ver->version_string_rw) - 1] = '\0';
@@ -146,8 +135,10 @@ static ssize_t version_show(struct device *dev,
 			   "Firmware copy: %s\n",
 			   (r_ver->current_image < ARRAY_SIZE(image_names) ?
 			    image_names[r_ver->current_image] : "?"));
+	memset(ec_buf, 0, sizeof(*msg) + EC_HOST_PARAM_SIZE);
 
 	/* Get build info. */
+	msg = (struct cros_ec_command *)ec_buf;
 	msg->command = EC_CMD_GET_BUILD_INFO + ec->cmd_offset;
 	msg->insize = EC_HOST_PARAM_SIZE;
 	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
@@ -206,40 +197,29 @@ static ssize_t version_show(struct device *dev,
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
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+				   EC_CMD_FLASH_INFO + ec->cmd_offset,
+				   NULL, 0, &resp, sizeof(resp));
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
 
@@ -250,29 +230,27 @@ static ssize_t kb_wake_angle_show(struct device *dev,
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
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 2,
+				   EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset,
+				   param, sizeof(*param), resp, sizeof(*resp));
 	if (ret < 0)
 		goto exit;
 
-	resp = (struct ec_response_motion_sense *)msg->data;
 	ret = scnprintf(buf, PAGE_SIZE, "%d\n", resp->kb_wake_angle.ret);
 exit:
-	kfree(msg);
+	kfree(ec_buf);
 	return ret;
 }
 
@@ -282,7 +260,8 @@ static ssize_t kb_wake_angle_store(struct device *dev,
 {
 	struct cros_ec_dev *ec = to_cros_ec_dev(dev);
 	struct ec_params_motion_sense *param;
-	struct cros_ec_command *msg;
+	struct ec_response_motion_sense *resp;
+	void *ec_buf;
 	u16 angle;
 	int ret;
 
@@ -290,20 +269,19 @@ static ssize_t kb_wake_angle_store(struct device *dev,
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
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 2,
+				   EC_CMD_MOTION_SENSE_CMD + ec->cmd_offset,
+				   param, sizeof(*param), resp, sizeof(*resp));
+	kfree(ec_buf);
 	if (ret < 0)
 		return ret;
 	return count;
-- 
2.25.0.341.g760bfbb309-goog

