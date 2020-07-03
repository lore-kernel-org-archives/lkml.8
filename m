Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBBC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E2F120656
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726367AbgGCJpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:45:20 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:33504 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725972AbgGCJpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:45:20 -0400
Received: from localhost (unknown [192.168.167.13])
        by lucky1.263xmail.com (Postfix) with ESMTP id 29F09A17BF;
        Fri,  3 Jul 2020 17:45:13 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P9648T140518671496960S1593769508246067_;
        Fri, 03 Jul 2020 17:45:14 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <61a8935fbe4ef8a294067815218e3673>
X-RL-SENDER: andy.yan@rock-chips.com
X-SENDER: yxj@rock-chips.com
X-LOGIN-NAME: andy.yan@rock-chips.com
X-FST-TO: daniel@ffwll.ch
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Andy Yan <andy.yan@rock-chips.com>
To:     daniel@ffwll.ch
Cc:     airlied@linux.ie, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Andy Yan <andy.yan@rock-chips.com>
Subject: [PATCH v2] drm/connector: Add of_drm_find_connector
Date:   Fri,  3 Jul 2020 17:45:06 +0800
Message-Id: <20200703094506.22527-1-andy.yan@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a function to look up a connector by
device tree node, like what of_drm_find_bridge/panel
does.

Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
Reported-by: kernel test robot <lkp@intel.com>

---

Changes in v2:
- Add function declaration

 drivers/gpu/drm/drm_connector.c | 33 +++++++++++++++++++++++++++++++++
 include/drm/drm_connector.h     | 14 ++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index d877ddc6dc57..516376cd1868 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -743,6 +743,39 @@ void drm_connector_list_iter_end(struct drm_connector_list_iter *iter)
 }
 EXPORT_SYMBOL(drm_connector_list_iter_end);
 
+#ifdef CONFIG_OF
+/**
+ * of_drm_find_connector - look up a connector using a device tree node
+ * @np: device tree node of the connector
+ *
+ *
+ * Return: A pointer to the connector which match the specified device tree
+ * node or NULL if no panel matching the device tree node can be found, or
+ * -ENODEV: the device is not available (status != "okay" or "ok")
+ */
+struct drm_connector *of_drm_find_connector(struct drm_device *dev, const struct device_node *np)
+{
+	struct drm_connector *connector;
+	struct drm_connector_list_iter conn_iter;
+
+	if (!of_device_is_available(np))
+		return ERR_PTR(-ENODEV);
+
+	drm_connector_list_iter_begin(dev, &conn_iter);
+	drm_for_each_connector_iter(connector, &conn_iter) {
+		if (connector->of_node == np) {
+			drm_connector_list_iter_end(&conn_iter);
+			return connector;
+		}
+	}
+	drm_connector_list_iter_end(&conn_iter);
+
+	return NULL;
+}
+EXPORT_SYMBOL(of_drm_find_connector);
+#endif
+
+
 static const struct drm_prop_enum_list drm_subpixel_enum_list[] = {
 	{ SubPixelUnknown, "Unknown" },
 	{ SubPixelHorizontalRGB, "Horizontal RGB" },
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index fd543d1db9b2..d249e0498375 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1129,6 +1129,9 @@ struct drm_connector {
 	/** @attr: sysfs attributes */
 	struct device_attribute *attr;
 
+	/** @of_node: device tree node */
+	struct device_node *of_node;
+
 	/**
 	 * @head:
 	 *
@@ -1647,6 +1650,17 @@ void drm_connector_list_iter_end(struct drm_connector_list_iter *iter);
 bool drm_connector_has_possible_encoder(struct drm_connector *connector,
 					struct drm_encoder *encoder);
 
+#if defined(CONFIG_OF)
+struct drm_connector *
+of_drm_find_connector(struct drm_device *dev, const struct device_node *np);
+#else
+static inline struct drm_connector *
+of_drm_find_connector(struct drm_device *dev, const struct device_node *np)
+{
+	return ERR_PTR(-ENODEV);
+}
+#endif
+
 /**
  * drm_for_each_connector_iter - connector_list iterator macro
  * @connector: &struct drm_connector pointer used as cursor
-- 
2.17.1



