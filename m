Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFAFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13F2C21556
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhL6Q+i9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgFQXUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgFQXUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:20:16 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76398C061755;
        Wed, 17 Jun 2020 16:20:16 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id w15so2329010lfe.11;
        Wed, 17 Jun 2020 16:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9RXXDREzEvi9GJkz9Ew+kxIBw0+JCmn+dwyV4+Iogjo=;
        b=DhL6Q+i9H1kTLhsx/jJL8lSuJaElavKhd6ST9db/CbXsuk6jwmsjgZ8MTjd/YRdQHS
         SKta33F1AQVLw5b9TN66Y9hcba3AGfeV5ZPKOXhDqYXwex8bqtnbbZAxdzpaAXhILZed
         /Kn9oJ+sFyuvJ7UvBz3MVt0FUOMGPIrziDbxhLup6Iy+p+04IZesaJaUqbeg/wDVdh2G
         a8xPi+4E/rnOwFs85KQz2nlZzNckhUdRF0nnb4pT9rd8pQGWce1WsmD4fOcoBq+DAb7q
         YmtirL6GsWZu5GJ9fTuAhTIKqBX9atSzwRZmGZe5QRKEI7Tdy9quNl7rTkBvhNx/72Oa
         jXeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9RXXDREzEvi9GJkz9Ew+kxIBw0+JCmn+dwyV4+Iogjo=;
        b=k+AdL5ZGQFXKCQJQ6Ag5nVIl8tJsXSCp67zmoLk/9JVUN4q+1jjcbzWqXQElgGvfvu
         mjKiY1aK5M85eq5Jxh4i8yqnVM8iQsnkUEZRZcFT6XitC00o9qDCjNTC01Ls4o5n1Mkc
         9HS//9zDmp2cluFA+FsLiZ58XhHONG7mufDBcMPEhPxZNlh/J4fPIavLL5RFEo+D6VvH
         g5QFeI86P1vBcoaRYn5xFOEd/5V44ouqZKqej/WnIAlPKrhWa4Rv1NG7J0SKQ6ypePnA
         J0kYD54T76LzsyxsF54JrPZgHR83PuAV3590XzRj64YA0aAEVVOA9WrhvEhK/Q7R3gk8
         sVIg==
X-Gm-Message-State: AOAM531Eq33PfqRDzeOgEQG2h+9aB/YuqFNNyX13/PoqENK5UNm6RQ48
        tMiNSO6L8gBbZrQXdGxZMYo=
X-Google-Smtp-Source: ABdhPJwZXIhog4dfoVtf01rQeNtS3EPm83m3tQ88S1ioAOIyLA+qbTylfDrp24rpcDGN50czElcYXQ==
X-Received: by 2002:a19:c797:: with SMTP id x145mr680536lff.143.1592436014944;
        Wed, 17 Jun 2020 16:20:14 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id x3sm235100ljc.82.2020.06.17.16.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:20:14 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, Daniel Vetter <daniel@ffwll.ch>,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Daniel Stone <daniel@fooishbar.org>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v11 1/4] drm/panel: Add helper for reading DT rotation
Date:   Thu, 18 Jun 2020 02:18:39 +0300
Message-Id: <20200617231842.30671-2-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617231842.30671-1-digetx@gmail.com>
References: <20200617231842.30671-1-digetx@gmail.com>
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

