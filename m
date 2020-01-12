Return-Path: <SRS0=/A4t=3B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E181DC33CA9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27C520882
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jan 2020 01:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgALBzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 20:55:23 -0500
Received: from foss.arm.com ([217.140.110.172]:57796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731942AbgALBzV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 20:55:21 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EFAC611B3;
        Sat, 11 Jan 2020 17:55:20 -0800 (PST)
Received: from DESKTOP-VLO843J.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 18F633F6C4;
        Sat, 11 Jan 2020 17:55:19 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, smoch@web.de
Subject: [PATCH v2 3/5] mfd: rk808: Stop using syscore ops
Date:   Sun, 12 Jan 2020 01:55:02 +0000
Message-Id: <7fdcdb900c7dc4fba38266e1db637131c3090a67.1578789410.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1578789410.git.robin.murphy@arm.com>
References: <cover.1578789410.git.robin.murphy@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Setting the SLEEP pin to its shutdown function for appropriate PMICs
doesn't need to happen in single-CPU context, so there's really no point
involving the syscore machinery. Hook it up to the standard driver model
shutdown method instead. This also obviates the issue that the syscore
ops weren't being unregistered on probe failure or module removal.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---
 drivers/mfd/rk808.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/mfd/rk808.c b/drivers/mfd/rk808.c
index ac798053c26a..8116ed6cf2e7 100644
--- a/drivers/mfd/rk808.c
+++ b/drivers/mfd/rk808.c
@@ -19,7 +19,6 @@
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/regmap.h>
-#include <linux/syscore_ops.h>
 
 struct rk808_reg_data {
 	int addr;
@@ -509,28 +508,27 @@ static void rk818_device_shutdown(void)
 		dev_err(&rk808_i2c_client->dev, "Failed to shutdown device!\n");
 }
 
-static void rk8xx_syscore_shutdown(void)
+static void rk8xx_shutdown(struct i2c_client *client)
 {
-	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
+	struct rk808 *rk808 = i2c_get_clientdata(client);
 	int ret;
 
-	if (system_state == SYSTEM_POWER_OFF &&
-	    (rk808->variant == RK809_ID || rk808->variant == RK817_ID)) {
+	switch (rk808->variant) {
+	case RK809_ID:
+	case RK817_ID:
 		ret = regmap_update_bits(rk808->regmap,
 					 RK817_SYS_CFG(3),
 					 RK817_SLPPIN_FUNC_MSK,
 					 SLPPIN_DN_FUN);
-		if (ret) {
-			dev_warn(&rk808_i2c_client->dev,
-				 "Cannot switch to power down function\n");
-		}
+		break;
+	default:
+		return;
 	}
+	if (ret)
+		dev_warn(&client->dev,
+			 "Cannot switch to power down function\n");
 }
 
-static struct syscore_ops rk808_syscore_ops = {
-	.shutdown = rk8xx_syscore_shutdown,
-};
-
 static const struct of_device_id rk808_of_match[] = {
 	{ .compatible = "rockchip,rk805" },
 	{ .compatible = "rockchip,rk808" },
@@ -623,7 +621,6 @@ static int rk808_probe(struct i2c_client *client,
 		nr_pre_init_regs = ARRAY_SIZE(rk817_pre_init_reg);
 		cells = rk817s;
 		nr_cells = ARRAY_SIZE(rk817s);
-		register_syscore_ops(&rk808_syscore_ops);
 		break;
 	default:
 		dev_err(&client->dev, "Unsupported RK8XX ID %lu\n",
@@ -759,6 +756,7 @@ static struct i2c_driver rk808_i2c_driver = {
 	},
 	.probe    = rk808_probe,
 	.remove   = rk808_remove,
+	.shutdown = rk8xx_shutdown,
 };
 
 module_i2c_driver(rk808_i2c_driver);
-- 
2.17.1

