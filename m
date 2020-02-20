Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF761C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA56420659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728760AbgBTP7l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:59:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47612 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728684AbgBTP7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:23 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 5A61C2951A3
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org
Subject: [PATCH 6/8] platform/chrome: cros_ec_lightbar: Use cros_ec_cmd_xfer_status helper
Date:   Thu, 20 Feb 2020 16:58:57 +0100
Message-Id: <20200220155859.906647-7-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200220155859.906647-1-enric.balletbo@collabora.com>
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes use of cros_ec_cmd_xfer_status() instead of
cros_ec_cmd_xfer(). It allows us to remove some redundand code. In this
case, though, we are changing a bit the behaviour because of returning
-EINVAL on protocol error we propagate the error return for
cros_ec_cmd_xfer_status() function, but I think it will be fine, even
more clear as we don't mask the Linux error code.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_lightbar.c | 50 ++++++----------------
 1 file changed, 13 insertions(+), 37 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_lightbar.c b/drivers/platform/chrome/cros_ec_lightbar.c
index b4c110c5fee0..b59180bff5a3 100644
--- a/drivers/platform/chrome/cros_ec_lightbar.c
+++ b/drivers/platform/chrome/cros_ec_lightbar.c
@@ -116,7 +116,7 @@ static int get_lightbar_version(struct cros_ec_dev *ec,
 
 	param = (struct ec_params_lightbar *)msg->data;
 	param->cmd = LIGHTBAR_CMD_VERSION;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0) {
 		ret = 0;
 		goto exit;
@@ -193,15 +193,10 @@ static ssize_t brightness_store(struct device *dev,
 	if (ret)
 		goto exit;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		goto exit;
 
-	if (msg->result != EC_RES_SUCCESS) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	ret = count;
 exit:
 	kfree(msg);
@@ -258,13 +253,10 @@ static ssize_t led_rgb_store(struct device *dev, struct device_attribute *attr,
 					goto exit;
 			}
 
-			ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+			ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 			if (ret < 0)
 				goto exit;
 
-			if (msg->result != EC_RES_SUCCESS)
-				goto exit;
-
 			i = 0;
 			ok = 1;
 		}
@@ -305,14 +297,13 @@ static ssize_t sequence_show(struct device *dev,
 	if (ret)
 		goto exit;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0)
-		goto exit;
-
-	if (msg->result != EC_RES_SUCCESS) {
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret == -EPROTO) {
 		ret = scnprintf(buf, PAGE_SIZE,
 				"ERROR: EC returned %d\n", msg->result);
 		goto exit;
+	} else if (ret < 0) {
+		goto exit;
 	}
 
 	resp = (struct ec_response_lightbar *)msg->data;
@@ -344,13 +335,10 @@ static int lb_send_empty_cmd(struct cros_ec_dev *ec, uint8_t cmd)
 	if (ret)
 		goto error;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		goto error;
-	if (msg->result != EC_RES_SUCCESS) {
-		ret = -EINVAL;
-		goto error;
-	}
+
 	ret = 0;
 error:
 	kfree(msg);
@@ -377,13 +365,10 @@ static int lb_manual_suspend_ctrl(struct cros_ec_dev *ec, uint8_t enable)
 	if (ret)
 		goto error;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		goto error;
-	if (msg->result != EC_RES_SUCCESS) {
-		ret = -EINVAL;
-		goto error;
-	}
+
 	ret = 0;
 error:
 	kfree(msg);
@@ -425,15 +410,10 @@ static ssize_t sequence_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		goto exit;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		goto exit;
 
-	if (msg->result != EC_RES_SUCCESS) {
-		ret = -EINVAL;
-		goto exit;
-	}
-
 	ret = count;
 exit:
 	kfree(msg);
@@ -487,13 +467,9 @@ static ssize_t program_store(struct device *dev, struct device_attribute *attr,
 	 */
 	msg->outsize = count + extra_bytes;
 
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
 	if (ret < 0)
 		goto exit;
-	if (msg->result != EC_RES_SUCCESS) {
-		ret = -EINVAL;
-		goto exit;
-	}
 
 	ret = count;
 exit:
-- 
2.25.0

