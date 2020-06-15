Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0647EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D044B206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:35:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbgFOUfa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgFOUfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:35:30 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3444C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 13:35:29 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 1BC2D2A2CF6
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Collabora Kernel ML <kernel@collabora.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Benson Leung <bleung@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lee Jones <lee.jones@linaro.org>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Yicheng Li <yichengli@chromium.org>
Subject: [PATCH] platform/chrome: cros_ec_proto: Do not export cros_ec_cmd_xfer()
Date:   Mon, 15 Jun 2020 22:35:21 +0200
Message-Id: <20200615203521.787132-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that all the remaining users of cros_ec_cmd_xfer() has been removed,
make this function private to the cros_ec_proto module.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/platform/chrome/cros_ec_proto.c     | 5 ++---
 include/linux/platform_data/cros_ec_proto.h | 3 ---
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
index 3e745e0fe092c..11a2db7cd0f76 100644
--- a/drivers/platform/chrome/cros_ec_proto.c
+++ b/drivers/platform/chrome/cros_ec_proto.c
@@ -496,8 +496,8 @@ EXPORT_SYMBOL(cros_ec_query_all);
  *
  * Return: 0 on success or negative error code.
  */
-int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
-		     struct cros_ec_command *msg)
+static int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
+			    struct cros_ec_command *msg)
 {
 	int ret;
 
@@ -541,7 +541,6 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
 
 	return ret;
 }
-EXPORT_SYMBOL(cros_ec_cmd_xfer);
 
 /**
  * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
index 3832433266762..4a415ae851ef0 100644
--- a/include/linux/platform_data/cros_ec_proto.h
+++ b/include/linux/platform_data/cros_ec_proto.h
@@ -216,9 +216,6 @@ int cros_ec_prepare_tx(struct cros_ec_device *ec_dev,
 int cros_ec_check_result(struct cros_ec_device *ec_dev,
 			 struct cros_ec_command *msg);
 
-int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
-		     struct cros_ec_command *msg);
-
 int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
 			    struct cros_ec_command *msg);
 
-- 
2.27.0

