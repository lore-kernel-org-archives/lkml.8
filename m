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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749D2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5414720884
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 23:20:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5Lw8nME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgFQXU0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 19:20:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbgFQXUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 19:20:20 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E9C061755;
        Wed, 17 Jun 2020 16:20:20 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so4938443lji.10;
        Wed, 17 Jun 2020 16:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDuNPkLsn+qFGP55GoH5xYzbgggRa+4B+kAR6hG962I=;
        b=g5Lw8nME1Hx+IKrcWvFOiOO3x5pYdTMxJsp+tioyT1hBv02M1bMp5s01sY8XgGifIG
         So0Ny31B115rEJ9QMjDp8X36aSgKBRzJ2CatKNoSGXImoQh3Qx7fue8sdYY9qh+MDLNJ
         bGkpUXtm00F4oUHZqwtlOflj2lGUYqYqSiip1o1TdsYhFYJ24inX8mpaj8I6qFht7eaw
         gGdhYgGitPewoIYECH11D3uCl4slXBSWGKjprY+5/PZinDjsXNg48UdQMI9LI3xnKkG2
         zMRBNZoGnnQVZ+1a1jURa/3L6pxFCMPAYiGoKEYJduzsOsIeN5hN7nBLpP1YT6KKzZ4l
         M19w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDuNPkLsn+qFGP55GoH5xYzbgggRa+4B+kAR6hG962I=;
        b=Ud9xiHFnsGuIeWWJIaDrGnnWpYGvZb0JUZsCoMXrCZ5p9TEVn98x4Rh0BI0tCIRZAq
         i2aaD3ezcWvyxYunylTqrQtNMe7W+Zp1Q8WMT/ntJ/b0VkQCCL5ZKRUxsudIH8uDD3SE
         POpR91zebnF8a7gnO+RonZ4TOcByOmLGyTylzHOKzbNnGqTdHlOFbb45r+brtY7V06r8
         ro7del38b9BNkMQzee3nMxVjALRLBKsWMHYrVjhQV4WH5HATupyuiiUpVjUIKu+5ixtm
         jyJMPiChM+QUCE2Rui/n5OhQwgvA+RLgmnLIW6QvmwnczAvuEYLAlAXNoXeGeWv5qAjB
         srTg==
X-Gm-Message-State: AOAM531iHINSeWasJ+a8f/IwLv5t6tx0VMH/fXjCWCwm3HClPyATSGRD
        vQeZIkAbNnZ9HgMK7o507R0=
X-Google-Smtp-Source: ABdhPJxT3+3ITtvZoxfpauwQtWfxUAcDCm937r+DCvi1iRnPkjGrWGExiRvyaUOt2t6UOl7y6A9wsQ==
X-Received: by 2002:a2e:b550:: with SMTP id a16mr830166ljn.345.1592436018131;
        Wed, 17 Jun 2020 16:20:18 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id x3sm235100ljc.82.2020.06.17.16.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 16:20:17 -0700 (PDT)
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
Subject: [PATCH v11 4/4] drm/panel-simple: Read panel orientation
Date:   Thu, 18 Jun 2020 02:18:42 +0300
Message-Id: <20200617231842.30671-5-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617231842.30671-1-digetx@gmail.com>
References: <20200617231842.30671-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The panel orientation needs to parsed from a device-tree and assigned to
the panel's connector in order to make orientation property available to
userspace. That's what this patch does for the panel-simple driver.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 6764ac630e22..2dee1320216c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -112,6 +112,8 @@ struct panel_simple {
 	struct gpio_desc *hpd_gpio;
 
 	struct drm_display_mode override_mode;
+
+	enum drm_panel_orientation orientation;
 };
 
 static inline struct panel_simple *to_panel_simple(struct drm_panel *panel)
@@ -371,6 +373,9 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	/* add hard-coded panel modes */
 	num += panel_simple_get_non_edid_modes(p, connector);
 
+	/* set up connector's "panel orientation" property */
+	drm_connector_set_panel_orientation(connector, p->orientation);
+
 	return num;
 }
 
@@ -530,6 +535,12 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
 		return err;
 	}
 
+	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	if (err) {
+		dev_err(dev, "failed to parse rotation property: %d\n", err);
+		return err;
+	}
+
 	ddc = of_parse_phandle(dev->of_node, "ddc-i2c-bus", 0);
 	if (ddc) {
 		panel->ddc = of_find_i2c_adapter_by_node(ddc);
-- 
2.26.0

