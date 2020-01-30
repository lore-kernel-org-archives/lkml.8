Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3A0C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9D6620708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VXfjs0W6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgA3Udn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:33:43 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41925 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgA3Udm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:33:42 -0500
Received: by mail-pf1-f194.google.com with SMTP id w62so2073007pfw.8
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 12:33:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wcndgd0ullupPWunk2nBzgw+HXrvW73y0wEp5E/hrZc=;
        b=VXfjs0W6pp9+jCuCiZNXj+H+QRs/2UQntYQ0Ub7ZtlFvk2xT27eVYS6xJE18WwVWes
         S03GVviC73ZQh+4ISoVp+lcgZv7jc8XAFoLAf7psqWzXNiJQ0x9NPn+gpr2SHIbRRkhn
         ZGSDDJfOrdMH+Sz7Dx5EORP4TLFBE88oGEdDU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wcndgd0ullupPWunk2nBzgw+HXrvW73y0wEp5E/hrZc=;
        b=JdpLBdHSkiyLUDFW0UFkFDdKjmZH9vujIjCX/k1Pm3K2uFQPwVOQitWZyzXhYUTMQC
         0d40Gj7bSzKMJoAaaayFirQkzKyA4+Vg6YVR9X+HIsTFumy5ushckJ2faDnd7qov/rp6
         13dItjy1MszSxRuKf6CaEIA9AKhKMpdeNvQ/xMtovpTbsm0GGU+5UUttZJc7H6d9ZHNy
         Q3mZk4+F503+VGgJT/1/sCsVQKiwR8x78/2oL7MUOgLFyG2JQ3AVjF5h/cu0X1hrvzkL
         7egfbVe10MhjlpiGFM3lz90zkko+51rM4wLAwlElQCQatNxfYdEhFWOAZXq8gRGxeIdc
         sL4w==
X-Gm-Message-State: APjAAAVZcsfkLBpfWeOROSdtcF5kLJsx4oQQX65L2g4dLSiJlzjUIB7y
        s0quCFLohP7UccQdEiZAPu5KNOceDNY=
X-Google-Smtp-Source: APXvYqzteMzJL26j3XsqNTyHRYwUKKxf/qF0+gDYKomlTZh4Ot9EemvZV6Ara6dcGuSf80Qrn1X4VA==
X-Received: by 2002:a63:5a23:: with SMTP id o35mr6481372pgb.4.1580416421875;
        Thu, 30 Jan 2020 12:33:41 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id q12sm7469321pfh.158.2020.01.30.12.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 12:33:41 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 06/17] platform/chrome: debugfs: Use send_cmd_msg()
Date:   Thu, 30 Jan 2020 12:30:44 -0800
Message-Id: <20200130203106.201894-7-pmalani@chromium.org>
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
cros_ec_send_cmd_msg(), which is more readable and does the message
setup code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---
 drivers/platform/chrome/cros_ec_debugfs.c | 135 ++++++++--------------
 1 file changed, 46 insertions(+), 89 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index 6ae484989d1f5f..58f2db1a4af032 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -32,7 +32,7 @@
  * @ec: EC device this debugfs information belongs to
  * @dir: dentry for debugfs files
  * @log_buffer: circular buffer for console log information
- * @read_msg: preallocated EC command and buffer to read console log
+ * @ec_buf: preallocated EC buffer to send and receive log commands and output.
  * @log_mutex: mutex to protect circular buffer
  * @log_wq: waitqueue for log readers
  * @log_poll_work: recurring task to poll EC for new console log data
@@ -43,7 +43,7 @@ struct cros_ec_debugfs {
 	struct dentry *dir;
 	/* EC log */
 	struct circ_buf log_buffer;
-	struct cros_ec_command *read_msg;
+	void *ec_buf;
 	struct mutex log_mutex;
 	wait_queue_head_t log_wq;
 	struct delayed_work log_poll_work;
@@ -63,18 +63,17 @@ static void cros_ec_console_log_work(struct work_struct *__work)
 			     log_poll_work);
 	struct cros_ec_dev *ec = debug_info->ec;
 	struct circ_buf *cb = &debug_info->log_buffer;
-	struct cros_ec_command snapshot_msg = {
-		.command = EC_CMD_CONSOLE_SNAPSHOT + ec->cmd_offset,
-	};
 
 	struct ec_params_console_read_v1 *read_params =
-		(struct ec_params_console_read_v1 *)debug_info->read_msg->data;
-	uint8_t *ec_buffer = (uint8_t *)debug_info->read_msg->data;
+		(struct ec_params_console_read_v1 *)debug_info->ec_buf;
+	uint8_t *ec_buffer = (uint8_t *)debug_info->ec_buf;
 	int idx;
 	int buf_space;
 	int ret;
 
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, &snapshot_msg);
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+				   EC_CMD_CONSOLE_SNAPSHOT + ec->cmd_offset,
+				   NULL, 0, NULL, 0);
 	if (ret < 0)
 		goto resched;
 
@@ -91,8 +90,11 @@ static void cros_ec_console_log_work(struct work_struct *__work)
 
 		memset(read_params, '\0', sizeof(*read_params));
 		read_params->subcmd = CONSOLE_READ_RECENT;
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev,
-					      debug_info->read_msg);
+
+		ret = cros_ec_send_cmd_msg(ec->ec_dev, 1,
+					   EC_CMD_CONSOLE_READ + ec->cmd_offset,
+					   read_params, sizeof(*read_params),
+					   ec_buffer, ec->ec_dev->max_response);
 		if (ret < 0)
 			break;
 
@@ -199,44 +201,29 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
 	char read_buf[EC_USB_PD_MAX_PORTS * 40], *p = read_buf;
 	struct cros_ec_debugfs *debug_info = file->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
-	struct {
-		struct cros_ec_command msg;
-		union {
-			struct ec_response_usb_pd_control_v1 resp;
-			struct ec_params_usb_pd_control params;
-		};
-	} __packed ec_buf;
-	struct cros_ec_command *msg;
-	struct ec_response_usb_pd_control_v1 *resp;
-	struct ec_params_usb_pd_control *params;
+	struct ec_response_usb_pd_control_v1 resp = {0};
+	struct ec_params_usb_pd_control params = {0};
 	int i;
 
-	msg = &ec_buf.msg;
-	params = (struct ec_params_usb_pd_control *)msg->data;
-	resp = (struct ec_response_usb_pd_control_v1 *)msg->data;
-
-	msg->command = EC_CMD_USB_PD_CONTROL;
-	msg->version = 1;
-	msg->insize = sizeof(*resp);
-	msg->outsize = sizeof(*params);
-
 	/*
 	 * Read status from all PD ports until failure, typically caused
 	 * by attempting to read status on a port that doesn't exist.
 	 */
 	for (i = 0; i < EC_USB_PD_MAX_PORTS; ++i) {
-		params->port = i;
-		params->role = 0;
-		params->mux = 0;
-		params->swap = 0;
-
-		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0)
+		params.port = i;
+		params.role = 0;
+		params.mux = 0;
+		params.swap = 0;
+
+		if (cros_ec_send_cmd_msg(ec_dev, 1, EC_CMD_USB_PD_CONTROL,
+					 &params, sizeof(params), &resp,
+					 sizeof(resp)) < 0)
 			break;
 
 		p += scnprintf(p, sizeof(read_buf) + read_buf - p,
 			       "p%d: %s en:%.2x role:%.2x pol:%.2x\n", i,
-			       resp->state, resp->enabled, resp->role,
-			       resp->polarity);
+			       resp.state, resp.enabled, resp.role,
+			       resp.polarity);
 	}
 
 	return simple_read_from_buffer(user_buf, count, ppos,
@@ -248,25 +235,17 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
 {
 	struct cros_ec_debugfs *debug_info = file->private_data;
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
-	struct {
-		struct cros_ec_command cmd;
-		struct ec_response_uptime_info resp;
-	} __packed msg = {};
-	struct ec_response_uptime_info *resp;
+	struct ec_response_uptime_info resp = {};
 	char read_buf[32];
 	int ret;
 
-	resp = (struct ec_response_uptime_info *)&msg.resp;
-
-	msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
-	msg.cmd.insize = sizeof(*resp);
-
-	ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
+	ret = cros_ec_send_cmd_msg(ec_dev, 0, EC_CMD_GET_UPTIME_INFO, NULL, 0,
+				   &resp, sizeof(resp));
 	if (ret < 0)
 		return ret;
 
 	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
-			resp->time_since_ec_boot_ms);
+			resp.time_since_ec_boot_ms);
 
 	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
 }
@@ -296,29 +275,16 @@ static const struct file_operations cros_ec_uptime_fops = {
 
 static int ec_read_version_supported(struct cros_ec_dev *ec)
 {
-	struct ec_params_get_cmd_versions_v1 *params;
-	struct ec_response_get_cmd_versions *response;
+	struct ec_params_get_cmd_versions_v1 params = {0};
+	struct ec_response_get_cmd_versions resp = {0};
 	int ret;
 
-	struct cros_ec_command *msg;
-
-	msg = kzalloc(sizeof(*msg) + max(sizeof(*params), sizeof(*response)),
-		GFP_KERNEL);
-	if (!msg)
-		return 0;
-
-	msg->command = EC_CMD_GET_CMD_VERSIONS + ec->cmd_offset;
-	msg->outsize = sizeof(*params);
-	msg->insize = sizeof(*response);
-
-	params = (struct ec_params_get_cmd_versions_v1 *)msg->data;
-	params->cmd = EC_CMD_CONSOLE_READ;
-	response = (struct ec_response_get_cmd_versions *)msg->data;
-
-	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg) >= 0 &&
-	      response->version_mask & EC_VER_MASK(1);
-
-	kfree(msg);
+	params.cmd = EC_CMD_CONSOLE_READ;
+	ret = cros_ec_send_cmd_msg(ec->ec_dev, 0,
+				   EC_CMD_GET_CMD_VERSIONS + ec->cmd_offset,
+				   &params, sizeof(params),
+				   &resp, sizeof(resp));
+	ret = ret >= 0 && resp.version_mask & EC_VER_MASK(1);
 
 	return ret;
 }
@@ -343,17 +309,11 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
 
 	read_params_size = sizeof(struct ec_params_console_read_v1);
 	read_response_size = ec->ec_dev->max_response;
-	debug_info->read_msg = devm_kzalloc(ec->dev,
-		sizeof(*debug_info->read_msg) +
-			max(read_params_size, read_response_size), GFP_KERNEL);
-	if (!debug_info->read_msg)
+	debug_info->ec_buf = devm_kzalloc(ec->dev,
+		max(read_params_size, read_response_size), GFP_KERNEL);
+	if (!debug_info->ec_buf)
 		return -ENOMEM;
 
-	debug_info->read_msg->version = 1;
-	debug_info->read_msg->command = EC_CMD_CONSOLE_READ + ec->cmd_offset;
-	debug_info->read_msg->outsize = read_params_size;
-	debug_info->read_msg->insize = read_response_size;
-
 	debug_info->log_buffer.buf = buf;
 	debug_info->log_buffer.head = 0;
 	debug_info->log_buffer.tail = 0;
@@ -383,20 +343,17 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 {
 	struct cros_ec_device *ec_dev = debug_info->ec->ec_dev;
 	int ret;
-	struct cros_ec_command *msg;
+	void *buf;
 	int insize;
 
 	insize = ec_dev->max_response;
 
-	msg = devm_kzalloc(debug_info->ec->dev,
-			sizeof(*msg) + insize, GFP_KERNEL);
-	if (!msg)
+	buf = devm_kzalloc(debug_info->ec->dev, insize, GFP_KERNEL);
+	if (!buf)
 		return -ENOMEM;
 
-	msg->command = EC_CMD_GET_PANIC_INFO;
-	msg->insize = insize;
-
-	ret = cros_ec_cmd_xfer_status(ec_dev, msg);
+	ret = cros_ec_send_cmd_msg(ec_dev, 0, EC_CMD_GET_PANIC_INFO,
+				   NULL, 0, buf, insize);
 	if (ret < 0) {
 		ret = 0;
 		goto free;
@@ -406,7 +363,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	if (ret == 0)
 		goto free;
 
-	debug_info->panicinfo_blob.data = msg->data;
+	debug_info->panicinfo_blob.data = buf;
 	debug_info->panicinfo_blob.size = ret;
 
 	debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
@@ -415,7 +372,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	return 0;
 
 free:
-	devm_kfree(debug_info->ec->dev, msg);
+	devm_kfree(debug_info->ec->dev, buf);
 	return ret;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

