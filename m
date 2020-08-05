Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFB7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D73B521744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 08:37:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbgHEIhV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 04:37:21 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:49546 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728021AbgHEIhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 04:37:01 -0400
Received: from localhost (unknown [192.168.167.209])
        by lucky1.263xmail.com (Postfix) with ESMTP id E6688B0743;
        Wed,  5 Aug 2020 16:36:50 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P12030T139956846577408S1596616609190052_;
        Wed, 05 Aug 2020 16:36:50 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <8e8bd938e45a208ef8604a951d9c156f>
X-RL-SENDER: hjc@rock-chips.com
X-SENDER: hjc@rock-chips.com
X-LOGIN-NAME: hjc@rock-chips.com
X-FST-TO: heiko@sntech.de
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Sandy Huang <hjc@rock-chips.com>
To:     heiko@sntech.de,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     huangtao@rock-chips.com, andy.yan@rock-chips.com,
        linux-rockchip@lists.infradead.org,
        dri-devel@lists.freedesktop.org, kever.yang@rock-chips.com,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] drm: sysfs: Add to get current mode
Date:   Wed,  5 Aug 2020 16:36:46 +0800
Message-Id: <20200805083646.4123-1-hjc@rock-chips.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

add this node to get the current true mode.

Signed-off-by: Sandy Huang <hjc@rock-chips.com>
---
 drivers/gpu/drm/drm_sysfs.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/drm_sysfs.c b/drivers/gpu/drm/drm_sysfs.c
index 939f0032aab1..f39bcd34853b 100644
--- a/drivers/gpu/drm/drm_sysfs.c
+++ b/drivers/gpu/drm/drm_sysfs.c
@@ -19,6 +19,7 @@
 #include <linux/slab.h>
 
 #include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <drm/drm_file.h>
 #include <drm/drm_modes.h>
@@ -236,16 +237,45 @@ static ssize_t modes_show(struct device *device,
 	return written;
 }
 
+static ssize_t current_mode_show(struct device *device,
+		      struct device_attribute *attr,
+		      char *buf)
+{
+	struct drm_connector *connector = to_drm_connector(device);
+	struct drm_display_mode *mode;
+	struct drm_crtc_state *crtc_state;
+	bool interlaced;
+	int written = 0;
+
+	if (!connector->state || !connector->state->crtc)
+		return written;
+
+	crtc_state = connector->state->crtc->state;
+	if (!crtc_state)
+		return written;
+
+	mode = &crtc_state->mode;
+
+	interlaced = !!(mode->flags & DRM_MODE_FLAG_INTERLACE);
+	written += snprintf(buf + written, PAGE_SIZE - written, "%dx%d%s%d\n",
+			    mode->hdisplay, mode->vdisplay,
+			    interlaced ? "i" : "p", drm_mode_vrefresh(mode));
+
+	return written;
+}
+
 static DEVICE_ATTR_RW(status);
 static DEVICE_ATTR_RO(enabled);
 static DEVICE_ATTR_RO(dpms);
 static DEVICE_ATTR_RO(modes);
+static DEVICE_ATTR_RO(current_mode);
 
 static struct attribute *connector_dev_attrs[] = {
 	&dev_attr_status.attr,
 	&dev_attr_enabled.attr,
 	&dev_attr_dpms.attr,
 	&dev_attr_modes.attr,
+	&dev_attr_current_mode.attr,
 	NULL
 };
 
-- 
2.17.1



