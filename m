Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 218D9C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F368120659
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728668AbgBTP70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:59:26 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47606 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728664AbgBTP7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:59:22 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9BD312951A0
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>, groeck@chromium.org,
        bleung@chromium.org, dtor@chromium.org, gwendal@chromium.org,
        pmalani@chromium.org
Subject: [PATCH 5/8] platform/chrome: cros_ec_sysfs: Use cros_ec_cmd_xfer_status helper
Date:   Thu, 20 Feb 2020 16:58:56 +0100
Message-Id: <20200220155859.906647-6-enric.balletbo@collabora.com>
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
cros_ec_cmd_xfer(). In this case the change is trivial and the only
reason to do it is because we want to make cros_ec_cmd_xfer() a private
function for the EC protocol and let people only use the
cros_ec_cmd_xfer_status() to return Linux standard error codes.

Looking at the code I am even unsure that makes sense differentiate
these two errors but let's not change the behaviour for now.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_sysfs.c | 36 ++++++++++++-------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_sysfs.c b/drivers/platform/chrome/cros_ec_sysfs.c
index 07dac97ad57c..d45ea5d5bfa4 100644
--- a/drivers/platform/chrome/cros_ec_sysfs.c
+++ b/drivers/platform/chrome/cros_ec_sysfs.c
@@ -149,14 +149,14 @@ static ssize_t version_show(struct device *dev,
 	/* Get build info. */
 	msg->command = EC_CMD_GET_BUILD_INFO + ec->cmd_offset;
 	msg->insize = EC_HOST_PARAM_SIZE;
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0)
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Build info:    XFER ERROR %d\n", ret);
-	else if (msg->result != EC_RES_SUCCESS)
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret == -EPROTO) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    EC error %d\n", msg->result);
-	else {
+	} else if (ret < 0) {
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "Build info:    XFER ERROR %d\n", ret);
+	} else {
 		msg->data[EC_HOST_PARAM_SIZE - 1] = '\0';
 		count += scnprintf(buf + count, PAGE_SIZE - count,
 				   "Build info:    %s\n", msg->data);
@@ -165,14 +165,14 @@ static ssize_t version_show(struct device *dev,
 	/* Get chip info. */
 	msg->command = EC_CMD_GET_CHIP_INFO + ec->cmd_offset;
 	msg->insize = sizeof(*r_chip);
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0)
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Chip info:     XFER ERROR %d\n", ret);
-	else if (msg->result != EC_RES_SUCCESS)
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret == -EPROTO) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
 				   "Chip info:     EC error %d\n", msg->result);
-	else {
+	} else if (ret < 0) {
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "Chip info:     XFER ERROR %d\n", ret);
+	} else {
 		r_chip = (struct ec_response_get_chip_info *)msg->data;
 
 		r_chip->vendor[sizeof(r_chip->vendor) - 1] = '\0';
@@ -189,14 +189,14 @@ static ssize_t version_show(struct device *dev,
 	/* Get board version */
 	msg->command = EC_CMD_GET_BOARD_VERSION + ec->cmd_offset;
 	msg->insize = sizeof(*r_board);
-	ret = cros_ec_cmd_xfer(ec->ec_dev, msg);
-	if (ret < 0)
-		count += scnprintf(buf + count, PAGE_SIZE - count,
-				   "Board version: XFER ERROR %d\n", ret);
-	else if (msg->result != EC_RES_SUCCESS)
+	ret = cros_ec_cmd_xfer_status(ec->ec_dev, msg);
+	if (ret == -EPROTO) {
 		count += scnprintf(buf + count, PAGE_SIZE - count,
 				   "Board version: EC error %d\n", msg->result);
-	else {
+	} else if (ret < 0) {
+		count += scnprintf(buf + count, PAGE_SIZE - count,
+				   "Board version: XFER ERROR %d\n", ret);
+	} else {
 		r_board = (struct ec_response_board_version *)msg->data;
 
 		count += scnprintf(buf + count, PAGE_SIZE - count,
-- 
2.25.0

