Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C58C11D10
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2985E24672
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 17:26:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgBTR0A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 12:26:00 -0500
Received: from sauhun.de ([88.99.104.3]:35130 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728654AbgBTRZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 12:25:55 -0500
Received: from localhost (p5486CC48.dip0.t-ipconnect.de [84.134.204.72])
        by pokefinder.org (Postfix) with ESMTPSA id A6F8A2C1EBF;
        Thu, 20 Feb 2020 18:25:52 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org, linux-i3c@lists.infradead.org,
        Kieran Bingham <kieran@ksquared.org.uk>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 4/7] i2c: of: remove superfluous parameter from exported function
Date:   Thu, 20 Feb 2020 18:24:00 +0100
Message-Id: <20200220172403.26062-5-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
References: <20200220172403.26062-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'dev' is only used for printing an error message. However, that
information is not needed because '%pOF' fully describes the location of
the error. Drop the 'dev' and remove the superfluous parameter.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/i2c/i2c-core-of.c | 7 +++----
 drivers/i3c/master.c      | 2 +-
 include/linux/i2c.h       | 6 ++----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/i2c/i2c-core-of.c b/drivers/i2c/i2c-core-of.c
index d8d111ad6c85..710704cd583e 100644
--- a/drivers/i2c/i2c-core-of.c
+++ b/drivers/i2c/i2c-core-of.c
@@ -19,8 +19,7 @@
 
 #include "i2c-core.h"
 
-int of_i2c_get_board_info(struct device *dev, struct device_node *node,
-			  struct i2c_board_info *info)
+int of_i2c_get_board_info(struct device_node *node, struct i2c_board_info *info)
 {
 	u32 addr;
 	int ret;
@@ -29,7 +28,7 @@ int of_i2c_get_board_info(struct device *dev, struct device_node *node,
 
 	ret = of_property_read_u32(node, "reg", &addr);
 	if (ret) {
-		dev_err(dev, "of_i2c: invalid reg on %pOF\n", node);
+		pr_err("of_i2c: invalid reg on %pOF\n", node);
 		return ret;
 	}
 
@@ -69,7 +68,7 @@ static struct i2c_client *of_i2c_register_device(struct i2c_adapter *adap,
 
 	dev_dbg(&adap->dev, "of_i2c: register %pOF\n", node);
 
-	ret = of_i2c_get_board_info(&adap->dev, node, &info);
+	ret = of_i2c_get_board_info(node, &info);
 	if (ret)
 		return ERR_PTR(ret);
 
diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index 7f8f896fa0c3..cc0549a9fc64 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -1943,7 +1943,7 @@ of_i3c_master_add_i2c_boardinfo(struct i3c_master_controller *master,
 	if (!boardinfo)
 		return -ENOMEM;
 
-	ret = of_i2c_get_board_info(dev, node, &boardinfo->base);
+	ret = of_i2c_get_board_info(node, &boardinfo->base);
 	if (ret)
 		return ret;
 
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index f834687989f7..d84aaf0d83d5 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -942,8 +942,7 @@ const struct of_device_id
 *i2c_of_match_device(const struct of_device_id *matches,
 		     struct i2c_client *client);
 
-int of_i2c_get_board_info(struct device *dev, struct device_node *node,
-			  struct i2c_board_info *info);
+int of_i2c_get_board_info(struct device_node *node, struct i2c_board_info *info);
 
 #else
 
@@ -969,8 +968,7 @@ static inline const struct of_device_id
 	return NULL;
 }
 
-static inline int of_i2c_get_board_info(struct device *dev,
-					struct device_node *node,
+static inline int of_i2c_get_board_info(struct device_node *node,
 					struct i2c_board_info *info)
 {
 	return -ENOTSUPP;
-- 
2.20.1

