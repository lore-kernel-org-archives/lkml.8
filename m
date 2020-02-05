Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47971C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07A7B20730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 19:08:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L499trew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBETIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 14:08:10 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:38496 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726822AbgBETIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 14:08:10 -0500
Received: by mail-pl1-f196.google.com with SMTP id t6so1267064plj.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 11:08:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mCMDuW/oivey8dV70zsdOcOPHrmTGp4xDwKWmxttDpM=;
        b=L499trewCBHTeKon/4Ad62mKmHVFBejn7oPAj1T7i2ALUnFteHMbmdcEAo+Q7U6bns
         pMsglusZuKX4RZ75/m9NV6Gwx+6q7jUOvP61hNmCSLUtluLL0P3+aWN27RmI4l8s0WXL
         xTb+6wA0pqPERQJkcwGivFlQ0Ozz03IpWe32M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mCMDuW/oivey8dV70zsdOcOPHrmTGp4xDwKWmxttDpM=;
        b=BhkQSoNDRtwz81yY3eChb3MZF8WiAxgBqWBmydNN4pnmDENeI/oNvZLv9MARS/W6xe
         EnNXCxK4aQfu/GOoQfGM6knxHn47q+hE129h9O1/JKAbaLxM4Sid9Z1CL6A3y/w06gDr
         1t0/3bCeL6Ju0ptLSqJTHfIT2gmIbKjlV9pDo0sXp3BRT/oExvQdUgliry70r7aWuYs5
         azf1IFhAvmGj61TV1zcclA7iCF4AVfB6+Iyn4fr1S6HkS2KnMdpUDV3uSPp75Hi6hQKK
         +lLZD4w0CWVBmh1IWJ00+E2zJw/d1Q4S69vupUeHYA40eGVHbTUFWHnV+3pw5onuDf03
         4tDg==
X-Gm-Message-State: APjAAAX5uZpgp31lYnIsX0iEUsPzBvGFZIqzKNc5cxRgfQvjSSxnTLPI
        x4kQX1127rBEDt/pq8Olm/ySSR6be7g=
X-Google-Smtp-Source: APXvYqx409TFfcRN34iibOLAc5nEWwGpjf3wifNnMrj9x7VH8qYX7f9Zzjc1F7cnY/HLVoqiSju+2A==
X-Received: by 2002:a17:902:8609:: with SMTP id f9mr34863924plo.203.1580929688825;
        Wed, 05 Feb 2020 11:08:08 -0800 (PST)
Received: from pmalani2.mtv.corp.google.com ([2620:15c:202:201:172e:4646:c089:ce59])
        by smtp.gmail.com with ESMTPSA id u23sm257224pfm.29.2020.02.05.11.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 11:08:08 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>
Subject: [PATCH v2 06/17] platform/chrome: debugfs: Use cros_ec_cmd()
Date:   Wed,  5 Feb 2020 11:00:05 -0800
Message-Id: <20200205190028.183069-7-pmalani@chromium.org>
X-Mailer: git-send-email 2.25.0.341.g760bfbb309-goog
In-Reply-To: <20200205190028.183069-1-pmalani@chromium.org>
References: <20200205190028.183069-1-pmalani@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace cros_ec_cmd_xfer_status() calls to the new function cros_ec_cmd(),
which is more readable and does the message setup code.

Signed-off-by: Prashant Malani <pmalani@chromium.org>
---

Changes in v2:
- Updated to use new function name and parameter list.

 drivers/platform/chrome/cros_ec_debugfs.c | 131 +++++++---------------
 1 file changed, 43 insertions(+), 88 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
index ecfada00e6c513..5eb3a341ede343 100644
--- a/drivers/platform/chrome/cros_ec_debugfs.c
+++ b/drivers/platform/chrome/cros_ec_debugfs.c
@@ -31,7 +31,7 @@
  * @ec: EC device this debugfs information belongs to
  * @dir: dentry for debugfs files
  * @log_buffer: circular buffer for console log information
- * @read_msg: preallocated EC command and buffer to read console log
+ * @ec_buf: preallocated EC buffer to send and receive log commands and output.
  * @log_mutex: mutex to protect circular buffer
  * @log_wq: waitqueue for log readers
  * @log_poll_work: recurring task to poll EC for new console log data
@@ -42,7 +42,7 @@ struct cros_ec_debugfs {
 	struct dentry *dir;
 	/* EC log */
 	struct circ_buf log_buffer;
-	struct cros_ec_command *read_msg;
+	void *ec_buf;
 	struct mutex log_mutex;
 	wait_queue_head_t log_wq;
 	struct delayed_work log_poll_work;
@@ -62,18 +62,17 @@ static void cros_ec_console_log_work(struct work_struct *__work)
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
+	ret = cros_ec_cmd(ec->ec_dev, 0,
+			  EC_CMD_CONSOLE_SNAPSHOT + ec->cmd_offset, NULL, 0,
+			  NULL, 0, NULL);
 	if (ret < 0)
 		goto resched;
 
@@ -90,8 +89,11 @@ static void cros_ec_console_log_work(struct work_struct *__work)
 
 		memset(read_params, '\0', sizeof(*read_params));
 		read_params->subcmd = CONSOLE_READ_RECENT;
-		ret = cros_ec_cmd_xfer_status(ec->ec_dev,
-					      debug_info->read_msg);
+
+		ret = cros_ec_cmd(ec->ec_dev, 1,
+				  EC_CMD_CONSOLE_READ + ec->cmd_offset,
+				  read_params, sizeof(*read_params), ec_buffer,
+				  ec->ec_dev->max_response, NULL);
 		if (ret < 0)
 			break;
 
@@ -198,44 +200,28 @@ static ssize_t cros_ec_pdinfo_read(struct file *file,
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
+		params.port = i;
+		params.role = 0;
+		params.mux = 0;
+		params.swap = 0;
 
-		if (cros_ec_cmd_xfer_status(ec_dev, msg) < 0)
+		if (cros_ec_cmd(ec_dev, 1, EC_CMD_USB_PD_CONTROL, &params,
+				sizeof(params), &resp, sizeof(resp), NULL) < 0)
 			break;
 
 		p += scnprintf(p, sizeof(read_buf) + read_buf - p,
 			       "p%d: %s en:%.2x role:%.2x pol:%.2x\n", i,
-			       resp->state, resp->enabled, resp->role,
-			       resp->polarity);
+			       resp.state, resp.enabled, resp.role,
+			       resp.polarity);
 	}
 
 	return simple_read_from_buffer(user_buf, count, ppos,
@@ -247,25 +233,17 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
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
+	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_UPTIME_INFO, NULL, 0, &resp,
+			  sizeof(resp), NULL);
 	if (ret < 0)
 		return ret;
 
 	ret = scnprintf(read_buf, sizeof(read_buf), "%u\n",
-			resp->time_since_ec_boot_ms);
+			resp.time_since_ec_boot_ms);
 
 	return simple_read_from_buffer(user_buf, count, ppos, read_buf, ret);
 }
@@ -295,29 +273,15 @@ static const struct file_operations cros_ec_uptime_fops = {
 
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
+	ret = cros_ec_cmd(ec->ec_dev, 0,
+			  EC_CMD_GET_CMD_VERSIONS + ec->cmd_offset, &params,
+			  sizeof(params), &resp, sizeof(resp), NULL);
+	ret = ret >= 0 && resp.version_mask & EC_VER_MASK(1);
 
 	return ret;
 }
@@ -342,17 +306,11 @@ static int cros_ec_create_console_log(struct cros_ec_debugfs *debug_info)
 
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
@@ -382,20 +340,17 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
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
+	ret = cros_ec_cmd(ec_dev, 0, EC_CMD_GET_PANIC_INFO, NULL, 0, buf,
+			  insize, NULL);
 	if (ret < 0) {
 		ret = 0;
 		goto free;
@@ -405,7 +360,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	if (ret == 0)
 		goto free;
 
-	debug_info->panicinfo_blob.data = msg->data;
+	debug_info->panicinfo_blob.data = buf;
 	debug_info->panicinfo_blob.size = ret;
 
 	debugfs_create_blob("panicinfo", S_IFREG | 0444, debug_info->dir,
@@ -414,7 +369,7 @@ static int cros_ec_create_panicinfo(struct cros_ec_debugfs *debug_info)
 	return 0;
 
 free:
-	devm_kfree(debug_info->ec->dev, msg);
+	devm_kfree(debug_info->ec->dev, buf);
 	return ret;
 }
 
-- 
2.25.0.341.g760bfbb309-goog

