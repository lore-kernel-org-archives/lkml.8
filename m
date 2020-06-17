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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E37C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9110C20885
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FoJaxzrF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgFQXUe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726941AbgFQXUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:20:20 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CAFBC06174E;
        Wed, 17 Jun 2020 16:20:17 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t74so2363058lff.2;
        Wed, 17 Jun 2020 16:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8a80cd6rsqQPYsCUSUM1tVHpjysV4lBd8Pl7EvdCM6E=;
        b=FoJaxzrFflE6LaxOfQk0IXXpNw1TcB02BfpukudUJvvz0sjvCgMY8OmLJaKiwz6XDx
         C/gDE3IRJKA2HqRaebAbdKt3EM4L0NCotHTWYsjSM/Mo+wvbvRSzwV0vKZdqaEs8YHHw
         Q4yN2ni8w97tvCST897K2FmpQWGITAxaGsNkGnZQ7dP/MXpaR1zkfQgG7yVdgXBq1hvS
         4tNNMXJAeC5nwzeVdBpl+XLE3E9umAlbP515ioqawoagpNJMgNrwWNiUMTOaqpJQI95M
         eweugxKOUmR8JXv6E2amCZgwBBDFAaS/mlBa79sH6in53tIFz2lVaVJEMD1AGdg95Jy+
         RPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8a80cd6rsqQPYsCUSUM1tVHpjysV4lBd8Pl7EvdCM6E=;
        b=MCjHZMwQgF8scFJgpWJL6Ct2LY0ddkOeWpFcMDOI26Vn3RHyl0nU/L77sCx6+H69sE
         MJGrVTr9vMzeljy9EDaqOuYRCdNnnwi4xc2kG3VoyAZG5xIoGyr7CjB0EEOZf3cGtgJ/
         Kv+V3+n9za9W2FhA1A/HWEpYUZf0+1YCpC/Cqq30YC/I7u4OZJqDWYbuvVdjFtXUPeLN
         IZjvVpmJxiyxrjQiZhF5bhvatR1EXptRq9c70kiwVPQCxXe4zFPcBhX40VNcpB7KHA1e
         UMZtELCkkOBtVjrUviJTnqLCS9O7Q3KyR1moUSRlRMIyrG3RqL5rfiuiMFt88hKKCubP
         bH5w==
X-Gm-Message-State: AOAM5329NW3Xy6IDNlayhMVvr0x6enJpZNZ7TtjskU0qjkSwxb2zBxmI
        n6zVXRZq23UvWxLJwzg9y/o=
X-Google-Smtp-Source: ABdhPJyQaSu56OgPGPclXqeIRJpQaUDkKkpFcF+C8Dt6uF1baj+c8borYAv8N0iz6g9JAlKh/k/ULw==
X-Received: by 2002:ac2:560f:: with SMTP id v15mr704327lfd.160.1592436015981;
        Wed, 17 Jun 2020 16:20:15 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id x3sm235100ljc.82.2020.06.17.16.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:20:15 -0700 (PDT)
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
Subject: [PATCH v11 2/4] drm/panel: Read panel orientation for BOE TV101WUM-NL6
Date:   Thu, 18 Jun 2020 02:18:40 +0300
Message-Id: <20200617231842.30671-3-digetx@gmail.com>
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

This reads the DT setting for the panel rotation to set the panel
orientation in the get_modes callback.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index db5b866357f2..4bd9397972e8 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -11,6 +11,7 @@
 #include <linux/of_device.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_panel.h>
@@ -43,6 +44,7 @@ struct boe_panel {
 
 	const struct panel_desc *desc;
 
+	enum drm_panel_orientation orientation;
 	struct regulator *pp1800;
 	struct regulator *avee;
 	struct regulator *avdd;
@@ -740,6 +742,7 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
+	drm_connector_set_panel_orientation(connector, boe->orientation);
 
 	return 1;
 }
@@ -779,6 +782,9 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
+	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
+	if (err < 0)
+		return err;
 
 	err = drm_panel_of_backlight(&boe->base);
 	if (err)
-- 
2.26.0

