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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83541C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A52C20739
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 20:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I92A6vFv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFNUBt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 16:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbgFNUBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 16:01:45 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BE6C08C5C3;
        Sun, 14 Jun 2020 13:01:45 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d27so3706628lfq.5;
        Sun, 14 Jun 2020 13:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vWfY4zIihMKIqVQsNJvI1F9WXeF9VfCOeT2znS/jkBE=;
        b=I92A6vFvYRmXFMFlLXE0dvrv2v1ZT86Q6B8yuD0d7W4+I6+lG5BtRpx6yMHvP2zWn3
         IQbQGP515wItCFw3PVnxaY1z9uIJzgi7PUq+BWx9EYmjRYDt5p0orxHCIFkVeRNrvrEF
         ZIaYIfF56FpyWmNBYPnZ9S9FiLM/Mlcgjsi04F2cg3tgBgRxufrcQY0RZRzSa/r42PrP
         NLV6ySPjIytaou8FXRmy0Vl/vANztw1x0K3DdpGSXZ6pw4zp3OAu/xGGScXn5iO5tIUu
         G9Ja2WdsdbPJq2HRB4tKmJUNpH02hqRDNkxkpovZ+PxLRYaHcO0wvCANcu2+emhGmj1j
         5XXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vWfY4zIihMKIqVQsNJvI1F9WXeF9VfCOeT2znS/jkBE=;
        b=UGmZ0+Yd4dSCDAxloivR3gHZRIGB7/nu6yd1lsHdNxnoPJlyhA8GC0qBesxnZqcDw0
         9IPuKgzKlpNwBqkgs7OnYhx/t8CkL1mea8ifyU60YAFhzVpnVwpDD2hwBLHmxyaMyKNL
         rDjO+KURuJZkn2cDHY7A/+Q/D8cIG/1sbfZ+lOfi5TSZdlTs9e05xX9c6wN9qaEjEVd6
         y0O33c2DWrgUn/wNnLjb/k4Cig9xt4/nvOGbWp6j7Ly+HEo8+1gr8B3dvBrVjFL3biT1
         Y59UTcfJ2j8UZ/ZLXHC9UMhOd8ygh6cwPwqEeYQOl4B/LdS4WsIWmgkY488WP5JTXvhE
         mHzQ==
X-Gm-Message-State: AOAM531PjuQzIBBf2GttniAaj7jNw3TvTZhH11NQ0u8znkdnfPZMwrkP
        h/xBqhMnjQNvCTfCEb1CtR06GAU6
X-Google-Smtp-Source: ABdhPJyquOv0rIens15YMdI/BhmzeC2GXeZ/2F8wC+6/DIjUEi9FTzACjRXR4/AQ7tL3D0TaQsUlCA==
X-Received: by 2002:a19:8389:: with SMTP id f131mr487597lfd.16.1592164903554;
        Sun, 14 Jun 2020 13:01:43 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id 144sm1422105lfm.87.2020.06.14.13.01.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2020 13:01:42 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] drm/panel: lvds: Set up panel orientation
Date:   Sun, 14 Jun 2020 23:01:18 +0300
Message-Id: <20200614200121.14147-3-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200614200121.14147-1-digetx@gmail.com>
References: <20200614200121.14147-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel orientation needs to parsed from a device-tree and assigned to
the panel's connector in order to make orientation property available to
userspace. That's what this patch does for the generic LVDS panel.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-lvds.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 5ce3f4a2b7a1..333d21cee5f6 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -37,6 +37,8 @@ struct panel_lvds {
 
 	struct gpio_desc *enable_gpio;
 	struct gpio_desc *reset_gpio;
+
+	enum drm_panel_orientation orientation;
 };
 
 static inline struct panel_lvds *to_panel_lvds(struct drm_panel *panel)
@@ -99,6 +101,7 @@ static int panel_lvds_get_modes(struct drm_panel *panel,
 	connector->display_info.bus_flags = lvds->data_mirror
 					  ? DRM_BUS_FLAG_DATA_LSB_TO_MSB
 					  : DRM_BUS_FLAG_DATA_MSB_TO_LSB;
+	drm_connector_set_panel_orientation(connector, lvds->orientation);
 
 	return 1;
 }
@@ -223,6 +226,11 @@ static int panel_lvds_probe(struct platform_device *pdev)
 	drm_panel_init(&lvds->panel, lvds->dev, &panel_lvds_funcs,
 		       DRM_MODE_CONNECTOR_LVDS);
 
+	ret = of_drm_get_panel_orientation(lvds->dev->of_node,
+					   &lvds->orientation);
+	if (ret)
+		return ret;
+
 	ret = drm_panel_of_backlight(&lvds->panel);
 	if (ret)
 		return ret;
-- 
2.26.0

