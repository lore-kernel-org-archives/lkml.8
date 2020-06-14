Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00010C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6FC02071A
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p8FlROeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727861AbgFNUBp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:01:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B816C08C5C3;
        Sun, 14 Jun 2020 13:01:44 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d27so3706613lfq.5;
        Sun, 14 Jun 2020 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=//s7SgUTdZk+8R0ozrOfOf203NYUFv49iTLgW3uAUIg=;
        b=p8FlROeIHMU+80XLsAsY3zFZqSiEq7oaT2fgY3JL8e//OFfrvoGekDl4kI3JmydCIZ
         CpYcdY44klOGtGOluYcC/Zvope3pfNNDWyAIe7KM4swQYNeaKEZ1zb4Mm8tTbNhocus+
         PJMZfrqLJKnhQMUJl/0iyeFLNCJDCGnp8qTMHf7x4R1W34Kp+Bzs0qpNehklXR7fms1V
         L5clzZYyZE8+87NGdo9JL+Yaam8lvssz5FskCZ/LMRqShGIFpTzu6HgiXnlnEUSWV6tL
         fLy0zG3S7QKUZ6yMxIoFHzOOpfaj5QyqX+iGmk4m31zncYElQLlMrWjjHMcZhBcrOtQ2
         FpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=//s7SgUTdZk+8R0ozrOfOf203NYUFv49iTLgW3uAUIg=;
        b=F3C8XF/i5hTTfvRA9XeaaFYom7S/qR5p8IfVwmTjGOZb5gpZ0nHvILlU6m6OuZRX9+
         kVLjB/yxTswZ573Qs+NL71CUB5t+4FhyrLftqqAFgxx7IM4kaSeD66kRKZyQ/nHfZsdH
         9AXLFDu0ZH/Mglh+qhlgKN5ECKU9AxE4JIIrDcLcbMzBeHuQ1OuUJ2xcBdXXr5RcUysl
         GcnvyJot0f5induD8hO6wmJX/JwKXS3IunZ7t8/iKzzVxKDuc6kNIreNrk3v0VDuHfTv
         Lb5RzD0OluYNPzE8KS5eG2Ysp2/rhR1ZLS/z2WZOXwcvBwIUwBc+Rq7S+/D/tayQ9rlR
         fVeQ==
X-Gm-Message-State: AOAM533EmEoOr8dDpTxMhwuIQq5bSTpukDAGzL+qi7D/hryJB1hZ1iyr
        avMW0/tYxuwRQAyKfbLMqTM=
X-Google-Smtp-Source: ABdhPJzDUXrvTGWJPXT1RIij9O/dOiKRpxwRH+3PWIhrxfAWUuI7IRJJLtpJO2GCLBjc+jxQlKu/6w==
X-Received: by 2002:a19:4bd1:: with SMTP id y200mr3556664lfa.60.1592164902463;
        Sun, 14 Jun 2020 13:01:42 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 144sm1422105lfm.87.2020.06.14.13.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 13:01:41 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] drm/panel: Add helper for reading DT rotation
Date:   Sun, 14 Jun 2020 23:01:17 +0300
Message-Id: <20200614200121.14147-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614200121.14147-1-digetx@gmail.com>
References: <20200614200121.14147-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Derek Basehore <dbasehore@chromium.org>

This adds a helper function for reading the rotation (panel
orientation) from the device tree.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/drm_panel.c | 43 +++++++++++++++++++++++++++++++++++++
 include/drm/drm_panel.h     |  9 ++++++++
 2 files changed, 52 insertions(+)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index 8c7bac85a793..5557c75301f1 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -300,6 +300,49 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL(of_drm_find_panel);
+
+/**
+ * of_drm_get_panel_orientation - look up the orientation of the panel through
+ * the "rotation" binding from a device tree node
+ * @np: device tree node of the panel
+ * @orientation: orientation enum to be filled in
+ *
+ * Looks up the rotation of a panel in the device tree. The orientation of the
+ * panel is expressed as a property name "rotation" in the device tree. The
+ * rotation in the device tree is counter clockwise.
+ *
+ * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
+ * rotation property doesn't exist. -EERROR otherwise.
+ */
+int of_drm_get_panel_orientation(const struct device_node *np,
+				 enum drm_panel_orientation *orientation)
+{
+	int rotation, ret;
+
+	ret = of_property_read_u32(np, "rotation", &rotation);
+	if (ret == -EINVAL) {
+		/* Don't return an error if there's no rotation property. */
+		*orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+		return 0;
+	}
+
+	if (ret < 0)
+		return ret;
+
+	if (rotation == 0)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_NORMAL;
+	else if (rotation == 90)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+	else if (rotation == 180)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+	else if (rotation == 270)
+		*orientation = DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+	else
+		return -EINVAL;
+
+	return 0;
+}
+EXPORT_SYMBOL(of_drm_get_panel_orientation);
 #endif
 
 #if IS_REACHABLE(CONFIG_BACKLIGHT_CLASS_DEVICE)
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 6193cb555acc..781c735f0f9b 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -35,6 +35,8 @@ struct drm_device;
 struct drm_panel;
 struct display_timing;
 
+enum drm_panel_orientation;
+
 /**
  * struct drm_panel_funcs - perform operations on a given panel
  *
@@ -191,11 +193,18 @@ int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
+int of_drm_get_panel_orientation(const struct device_node *np,
+				 enum drm_panel_orientation *orientation);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
+static inline int of_drm_get_panel_orientation(const struct device_node *np,
+		enum drm_panel_orientation *orientation)
+{
+	return -ENODEV;
+}
 #endif
 
 #if IS_ENABLED(CONFIG_DRM_PANEL) && (IS_BUILTIN(CONFIG_BACKLIGHT_CLASS_DEVICE) || \
-- 
2.26.0

