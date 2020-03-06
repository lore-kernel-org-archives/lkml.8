Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3C9AC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:21:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BCE72072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:21:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ML2beaIH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgCFAVY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:21:24 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:39216 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726775AbgCFAVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:21:22 -0500
Received: by mail-pj1-f68.google.com with SMTP id d8so297671pje.4
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 16:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hQNm02H2pkyGLIgvDKszi1b0CdSZhepdAZyMaDXtVwg=;
        b=ML2beaIHhWoozMw1+GSjXS6qI18fIn3bQiw4wGMoMgs7HoD+Tac2WoXr33cjpS4ql4
         43z7U70hRhKReNNVfPIm18tp61lQKs41g/2G0HkyyE9sIEOrzn3W86c45EfrK1TQEgdL
         amSUe8jJvSy0iNM7lBbUtjU3vOQwXczM68WDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hQNm02H2pkyGLIgvDKszi1b0CdSZhepdAZyMaDXtVwg=;
        b=TMrYBdE5cGXJKZ5U4qu/eVOXCoD2GvkKNHQ1T6lLhfOEiATJpK/JSgzXAyE0fIqCt2
         5Oqjo8gxtHHLLop/GwDATujgOr22IH6hLPW1Kuq+btlh+Ex/tlnQ5fOcElxhh233z5ag
         WQjjTuJj6RLy1KmDezYf5UrWgZYIxSsFUjZjTy1a1NZ7z6Tr5m1uQxJKx73U6zv2iq95
         NnUEypPJCo6Y0GHRB5dcp8j0JnSxeVkRFb4/l/mLph22SHP9eSm5QCmKn4KaV0RM5IHI
         ZGnRTXk94F/ukUVSsIqG8yoSr81o75jmds/Nr7VYAhSSbXIyTN8ESp8siSFx4MgTuvky
         c2vQ==
X-Gm-Message-State: ANhLgQ0SPsMWnN1UDtRWTInLPTTVgBaL6XZkjjF6yNZug7ZMs5ClJyCu
        Pyr92/asYLu9e+es5hit4uQjP5aDY8s=
X-Google-Smtp-Source: ADFU+vv9+4Lv/MOLWzhzniPKnDbwFzcA2Mk2UDwJzSTrY1lkMFavDoPeI8WQLyuZ9uYwMmBe4J2X1w==
X-Received: by 2002:a17:90a:170e:: with SMTP id z14mr725943pjd.156.1583454080536;
        Thu, 05 Mar 2020 16:21:20 -0800 (PST)
Received: from exogeni.mtv.corp.google.com ([2620:15c:202:1:5be8:f2a6:fd7b:7459])
        by smtp.gmail.com with ESMTPSA id y1sm30080225pgs.74.2020.03.05.16.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 16:21:19 -0800 (PST)
From:   Derek Basehore <dbasehore@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Derek Basehore <dbasehore@chromium.org>
Subject: [PATCH v10 2/2] drm/panel: read panel orientation for BOE tv101wum-nl6
Date:   Thu,  5 Mar 2020 16:21:12 -0800
Message-Id: <20200306002112.255361-3-dbasehore@chromium.org>
X-Mailer: git-send-email 2.25.0.265.gbab2e86ba0-goog
In-Reply-To: <20200306002112.255361-1-dbasehore@chromium.org>
References: <20200306002112.255361-1-dbasehore@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reads the DT setting for the panel rotation to set the panel
orientation in the get_modes callback.

Signed-off-by: Derek Basehore <dbasehore@chromium.org>
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 48a164257d18..ee2d96413900 100644
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
@@ -717,6 +719,7 @@ static int boe_panel_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = boe->desc->size.width_mm;
 	connector->display_info.height_mm = boe->desc->size.height_mm;
 	connector->display_info.bpc = boe->desc->bpc;
+	drm_connector_set_panel_orientation(connector, boe->orientation);
 
 	return 1;
 }
@@ -756,6 +759,9 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	drm_panel_init(&boe->base, dev, &boe_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
+	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
+	if (err < 0)
+		return err;
 
 	err = drm_panel_of_backlight(&boe->base);
 	if (err)
-- 
2.25.0.265.gbab2e86ba0-goog

