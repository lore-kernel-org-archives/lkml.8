Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05522C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D268F22224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:02:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbgGNMCU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:02:20 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:52608 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728116AbgGNMCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:02:18 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from vadimp@mellanox.com)
        with SMTP; 14 Jul 2020 15:02:12 +0300
Received: from r-build-lowlevel.mtr.labs.mlnx. (r-build-lowlevel.mtr.labs.mlnx [10.209.0.190])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 06EC25di004353;
        Tue, 14 Jul 2020 15:02:12 +0300
From:   Vadim Pasternak <vadimp@mellanox.com>
To:     andy@infradead.org, dvhart@infradead.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vadim Pasternak <vadimp@mellanox.com>
Subject: [PATCH platform-next v2 05/11] platform/mellanox: mlxreg-hotplug: Add environmental data to uevent
Date:   Tue, 14 Jul 2020 15:01:57 +0300
Message-Id: <20200714120203.10352-6-vadimp@mellanox.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200714120203.10352-1-vadimp@mellanox.com>
References: <20200714120203.10352-1-vadimp@mellanox.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send "udev" event with environmental data in order to allow handling
"ENV{}" variables in "udev" rules.

Signed-off-by: Vadim Pasternak <vadimp@mellanox.com>
---
v1->v2:
Comments pointed out by Andy:
- Add string_upper(), string_lower() helpers. Use string_upper() for
  label conversion.
- Simplify code for event string construction.
---
 drivers/platform/mellanox/mlxreg-hotplug.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/mellanox/mlxreg-hotplug.c b/drivers/platform/mellanox/mlxreg-hotplug.c
index d9863e7fd491..b013445147dd 100644
--- a/drivers/platform/mellanox/mlxreg-hotplug.c
+++ b/drivers/platform/mellanox/mlxreg-hotplug.c
@@ -16,6 +16,7 @@
 #include <linux/platform_data/mlxreg.h>
 #include <linux/platform_device.h>
 #include <linux/spinlock.h>
+#include <linux/string_helpers.h>
 #include <linux/regmap.h>
 #include <linux/workqueue.h>
 
@@ -71,6 +72,23 @@ struct mlxreg_hotplug_priv_data {
 	u8 not_asserted;
 };
 
+/* Environment variables array for udev. */
+static char *mlxreg_hotplug_udev_envp[] = { NULL, NULL };
+
+static int
+mlxreg_hotplug_udev_event_send(struct kobject *kobj,
+			       struct mlxreg_core_data *data, bool action)
+{
+	char event_str[MLXREG_CORE_LABEL_MAX_SIZE + 2];
+	char label[MLXREG_CORE_LABEL_MAX_SIZE] = { 0 };
+
+	mlxreg_hotplug_udev_envp[0] = event_str;
+	string_upper(label, data->label);
+	snprintf(event_str, MLXREG_CORE_LABEL_MAX_SIZE, "%s=%d", label, !!action);
+
+	return kobject_uevent_env(kobj, KOBJ_CHANGE, mlxreg_hotplug_udev_envp);
+}
+
 static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 					struct mlxreg_core_data *data)
 {
@@ -78,7 +96,7 @@ static int mlxreg_hotplug_device_create(struct mlxreg_hotplug_priv_data *priv,
 	struct i2c_client *client;
 
 	/* Notify user by sending hwmon uevent. */
-	kobject_uevent(&priv->hwmon->kobj, KOBJ_CHANGE);
+	mlxreg_hotplug_udev_event_send(&priv->hwmon->kobj, data, true);
 
 	/*
 	 * Return if adapter number is negative. It could be in case hotplug
@@ -118,7 +136,7 @@ mlxreg_hotplug_device_destroy(struct mlxreg_hotplug_priv_data *priv,
 			      struct mlxreg_core_data *data)
 {
 	/* Notify user by sending hwmon uevent. */
-	kobject_uevent(&priv->hwmon->kobj, KOBJ_CHANGE);
+	mlxreg_hotplug_udev_event_send(&priv->hwmon->kobj, data, false);
 
 	if (data->hpdev.client) {
 		i2c_unregister_device(data->hpdev.client);
-- 
2.11.0

