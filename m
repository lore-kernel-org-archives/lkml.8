Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F131C2D0E9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D6B2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgCZVKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:10:03 -0400
Received: from sauhun.de ([88.99.104.3]:54332 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727751AbgCZVJz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:09:55 -0400
Received: from localhost (p54B3331F.dip0.t-ipconnect.de [84.179.51.31])
        by pokefinder.org (Postfix) with ESMTPSA id C1D842C1F8A;
        Thu, 26 Mar 2020 22:09:53 +0100 (CET)
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-i2c@vger.kernel.org
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Andy Shevchenko <andy@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Vadim Pasternak <vadimp@mellanox.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/mellanox: mlxreg-hotplug: convert to use i2c_new_client_device()
Date:   Thu, 26 Mar 2020 22:09:52 +0100
Message-Id: <20200326210952.12857-3-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200326210952.12857-1-wsa+renesas@sang-engineering.com>
References: <20200326210952.12857-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move away from the deprecated API and return the shiny new ERRPTR where
useful.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index 77be37a1fbcf..ed48917af162 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -101,6 +101,7 @@ static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 					struct mlxreg_core_data *data)
 {
 	struct mlxreg_core_hotplug_platform_data *pdata;
+	struct i2c_client *client;
 
 	/* Notify user by sending hwmon uevent. */
 	kobject_uevent(&priv->hwmon->kobj, KOBJ_CHANGE);
@@ -121,18 +122,20 @@ static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 		return -EFAULT;
 	}
 
-	data->hpdev.client = i2c_new_device(data->hpdev.adapter,
-					    data->hpdev.brdinfo);
-	if (!data->hpdev.client) {
+	client = i2c_new_client_device(data->hpdev.adapter,
+				       data->hpdev.brdinfo);
+	if (IS_ERR(client)) {
 		dev_err(priv->dev, "Failed to create client %s at bus %d at addr 0x%02x\n",
 			data->hpdev.brdinfo->type, data->hpdev.nr +
 			pdata->shift_nr, data->hpdev.brdinfo->addr);
 
 		i2c_put_adapter(data->hpdev.adapter);
 		data->hpdev.adapter = NULL;
-		return -EFAULT;
+		return PTR_ERR(client);
 	}
 
+	data->hpdev.client = client;
+
 	return 0;
 }
 
-- 
2.20.1

