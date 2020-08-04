Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87EBC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A765D207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MWmWPfyu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgHDVxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHDVxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:53:46 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AA6C06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:53:46 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id t6so32393691ljk.9
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3K3L4xTeO8WJCN+4NojLDn6Y8YSzCs4qmbjou++O18=;
        b=MWmWPfyuzwdNg9q2g+29NTxHzaGLOrxeuTRC408PBWbTE+YkaEz8HSqsobjqtOaQ/z
         70d6L8UAUiHz1p+VcjNPfU7naDCdM+DjhDAeaJWS7f+bnknAb14wg/GJKiMkVCn0n/6G
         IdgWZypumOkDEVOvhqDqgFPyee1My/OXeufFtVZxBjZjyFkCZKudZOoHN3apGwWO4LdI
         3rw8PGAHaxIlLlZ6jBsaew9768f1eKqLiTBlQPjKO0QlGLxow1y3Yp/QTTTHtzyK6QN3
         9ZFMR5GpLgwP8ERIyhLs9veF3GJzia5gQTvmNbc6CzYyZDOSwlFL1VUHO9/kA2Vjessl
         EdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K3K3L4xTeO8WJCN+4NojLDn6Y8YSzCs4qmbjou++O18=;
        b=R7qBCPunYXhS+P89zDCCNrqIXmwMOTEo0got8SNbbZ1sZEroVsLPDLEvv71ar9P6Aw
         LHj4Q643Mv/CfteLa6kieqZOTH9H3dyZOQf80mrzcACA8OlI+ds5CU7M2PUrqlaAWTu+
         cbJstCg/7ttDTjqhSu2bSw8wktDm1+ZQm3x6zDOk/sevZYNY6HJgWu/HF4CwCJuL9YFS
         9YnRIDC6Khclmxq2oUAJ2PXP1TdwkB3ic4Fk4M8bL/KrWtyVLlq9+qj+HjrbKAD//SGZ
         S/N+PZPtGEAoBjMAXwFDSb+7mkpaSOZGgIUbxSOKPE8xNS2pHHhFKlg51Ni/Q8pEO5Og
         Ke5A==
X-Gm-Message-State: AOAM531+ywLXGiRXdoV5k9TPSH1fjl1sUXoIVAdMYvNDsu1m/8Am/SZF
        tGmg59B7vID55x5UVOkInNE=
X-Google-Smtp-Source: ABdhPJwiC0cpr3FJfUYKJrqCch2gBqlXqGqNcWWZqSugmiQnC2850yxYAawikNYWZXTD4a66x8o2yg==
X-Received: by 2002:a2e:9643:: with SMTP id z3mr4685419ljh.282.1596578024897;
        Tue, 04 Aug 2020 14:53:44 -0700 (PDT)
Received: from localhost.localdomain (h-82-196-111-59.NA.cust.bahnhof.se. [82.196.111.59])
        by smtp.gmail.com with ESMTPSA id 15sm5534378ljw.92.2020.08.04.14.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:53:44 -0700 (PDT)
From:   Rikard Falkeborn <rikard.falkeborn@gmail.com>
To:     mripard@kernel.org, wens@csie.org, jernej.skrabec@siol.net
Cc:     airlied@linux.ie, daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [PATCH] drm/sun4i: Constify static structs
Date:   Tue,  4 Aug 2020 23:53:37 +0200
Message-Id: <20200804215337.54594-1-rikard.falkeborn@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A number of static variables are not modified and can be made const to
allow the compiler to put them in read-only memory.

Signed-off-by: Rikard Falkeborn <rikard.falkeborn@gmail.com>
---
Perhaps it should be split up? If so, some guidance on how would be
appreciated.

 drivers/gpu/drm/sun4i/sun4i_backend.c     | 2 +-
 drivers/gpu/drm/sun4i/sun4i_framebuffer.c | 2 +-
 drivers/gpu/drm/sun4i/sun4i_frontend.c    | 2 +-
 drivers/gpu/drm/sun4i/sun4i_lvds.c        | 2 +-
 drivers/gpu/drm/sun4i/sun4i_rgb.c         | 4 ++--
 drivers/gpu/drm/sun4i/sun4i_tcon.c        | 2 +-
 drivers/gpu/drm/sun4i/sun4i_tv.c          | 6 +++---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c    | 2 +-
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c    | 2 +-
 drivers/gpu/drm/sun4i/sun8i_mixer.c       | 2 +-
 drivers/gpu/drm/sun4i/sun8i_ui_layer.c    | 2 +-
 drivers/gpu/drm/sun4i/sun8i_vi_layer.c    | 2 +-
 12 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_backend.c b/drivers/gpu/drm/sun4i/sun4i_backend.c
index 072ea113e6be..f025534eb30c 100644
--- a/drivers/gpu/drm/sun4i/sun4i_backend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_backend.c
@@ -769,7 +769,7 @@ static const struct sunxi_engine_ops sun4i_backend_engine_ops = {
 	.vblank_quirk			= sun4i_backend_vblank_quirk,
 };
 
-static struct regmap_config sun4i_backend_regmap_config = {
+static const struct regmap_config sun4i_backend_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
diff --git a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
index 1568f68f9a9e..6825ef46f43f 100644
--- a/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
+++ b/drivers/gpu/drm/sun4i/sun4i_framebuffer.c
@@ -35,7 +35,7 @@ static const struct drm_mode_config_funcs sun4i_de_mode_config_funcs = {
 	.fb_create		= drm_gem_fb_create,
 };
 
-static struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers = {
+static const struct drm_mode_config_helper_funcs sun4i_de_mode_config_helpers = {
 	.atomic_commit_tail	= drm_atomic_helper_commit_tail_rpm,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_frontend.c b/drivers/gpu/drm/sun4i/sun4i_frontend.c
index ec2a032e07b9..b51cc685c13a 100644
--- a/drivers/gpu/drm/sun4i/sun4i_frontend.c
+++ b/drivers/gpu/drm/sun4i/sun4i_frontend.c
@@ -545,7 +545,7 @@ int sun4i_frontend_enable(struct sun4i_frontend *frontend)
 }
 EXPORT_SYMBOL(sun4i_frontend_enable);
 
-static struct regmap_config sun4i_frontend_regmap_config = {
+static const struct regmap_config sun4i_frontend_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
diff --git a/drivers/gpu/drm/sun4i/sun4i_lvds.c b/drivers/gpu/drm/sun4i/sun4i_lvds.c
index ffda3184aa12..ea430b0ab0f3 100644
--- a/drivers/gpu/drm/sun4i/sun4i_lvds.c
+++ b/drivers/gpu/drm/sun4i/sun4i_lvds.c
@@ -47,7 +47,7 @@ static int sun4i_lvds_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(lvds->panel, connector);
 }
 
-static struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
+static const struct drm_connector_helper_funcs sun4i_lvds_con_helper_funcs = {
 	.get_modes	= sun4i_lvds_get_modes,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun4i_rgb.c b/drivers/gpu/drm/sun4i/sun4i_rgb.c
index 5a7d43939ae6..20a49c1963cc 100644
--- a/drivers/gpu/drm/sun4i/sun4i_rgb.c
+++ b/drivers/gpu/drm/sun4i/sun4i_rgb.c
@@ -138,7 +138,7 @@ static enum drm_mode_status sun4i_rgb_mode_valid(struct drm_encoder *crtc,
 	return MODE_OK;
 }
 
-static struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
+static const struct drm_connector_helper_funcs sun4i_rgb_con_helper_funcs = {
 	.get_modes	= sun4i_rgb_get_modes,
 };
 
@@ -183,7 +183,7 @@ static void sun4i_rgb_encoder_disable(struct drm_encoder *encoder)
 	}
 }
 
-static struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
+static const struct drm_encoder_helper_funcs sun4i_rgb_enc_helper_funcs = {
 	.disable	= sun4i_rgb_encoder_disable,
 	.enable		= sun4i_rgb_encoder_enable,
 	.mode_valid	= sun4i_rgb_mode_valid,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tcon.c b/drivers/gpu/drm/sun4i/sun4i_tcon.c
index 359b56e43b83..ae177b2bcf4b 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -825,7 +825,7 @@ static int sun4i_tcon_init_irq(struct device *dev,
 	return 0;
 }
 
-static struct regmap_config sun4i_tcon_regmap_config = {
+static const struct regmap_config sun4i_tcon_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
diff --git a/drivers/gpu/drm/sun4i/sun4i_tv.c b/drivers/gpu/drm/sun4i/sun4i_tv.c
index 63f4428ac3bf..cb91bc11a0c7 100644
--- a/drivers/gpu/drm/sun4i/sun4i_tv.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tv.c
@@ -468,7 +468,7 @@ static void sun4i_tv_mode_set(struct drm_encoder *encoder,
 	regmap_write(tv->regs, SUN4I_TVE_SLAVE_REG, 0);
 }
 
-static struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
+static const struct drm_encoder_helper_funcs sun4i_tv_helper_funcs = {
 	.disable	= sun4i_tv_disable,
 	.enable		= sun4i_tv_enable,
 	.mode_set	= sun4i_tv_mode_set,
@@ -504,7 +504,7 @@ static int sun4i_tv_comp_mode_valid(struct drm_connector *connector,
 	return MODE_OK;
 }
 
-static struct drm_connector_helper_funcs sun4i_tv_comp_connector_helper_funcs = {
+static const struct drm_connector_helper_funcs sun4i_tv_comp_connector_helper_funcs = {
 	.get_modes	= sun4i_tv_comp_get_modes,
 	.mode_valid	= sun4i_tv_comp_mode_valid,
 };
@@ -523,7 +523,7 @@ static const struct drm_connector_funcs sun4i_tv_comp_connector_funcs = {
 	.atomic_destroy_state	= drm_atomic_helper_connector_destroy_state,
 };
 
-static struct regmap_config sun4i_tv_regmap_config = {
+static const struct regmap_config sun4i_tv_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index aa67cb037e9d..76822c6902c0 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -820,7 +820,7 @@ static int sun6i_dsi_get_modes(struct drm_connector *connector)
 	return drm_panel_get_modes(dsi->panel, connector);
 }
 
-static struct drm_connector_helper_funcs sun6i_dsi_connector_helper_funcs = {
+static const struct drm_connector_helper_funcs sun6i_dsi_connector_helper_funcs = {
 	.get_modes	= sun6i_dsi_get_modes,
 };
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 156d00e5165b..35c2133724e2 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -534,7 +534,7 @@ void sun8i_hdmi_phy_set_ops(struct sun8i_hdmi_phy *phy,
 	}
 }
 
-static struct regmap_config sun8i_hdmi_phy_regmap_config = {
+static const struct regmap_config sun8i_hdmi_phy_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
diff --git a/drivers/gpu/drm/sun4i/sun8i_mixer.c b/drivers/gpu/drm/sun4i/sun8i_mixer.c
index cc4fb916318f..4b59806b30df 100644
--- a/drivers/gpu/drm/sun4i/sun8i_mixer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_mixer.c
@@ -303,7 +303,7 @@ static const struct sunxi_engine_ops sun8i_engine_ops = {
 	.layers_init	= sun8i_layers_init,
 };
 
-static struct regmap_config sun8i_mixer_regmap_config = {
+static const struct regmap_config sun8i_mixer_regmap_config = {
 	.reg_bits	= 32,
 	.val_bits	= 32,
 	.reg_stride	= 4,
diff --git a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
index 54f937a7d5e7..816ad4ce8996 100644
--- a/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_ui_layer.c
@@ -298,7 +298,7 @@ static void sun8i_ui_layer_atomic_update(struct drm_plane *plane,
 			      true, zpos, old_zpos);
 }
 
-static struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
+static const struct drm_plane_helper_funcs sun8i_ui_layer_helper_funcs = {
 	.prepare_fb	= drm_gem_fb_prepare_fb,
 	.atomic_check	= sun8i_ui_layer_atomic_check,
 	.atomic_disable	= sun8i_ui_layer_atomic_disable,
diff --git a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
index 22c8c5375d0d..a360697a4a4a 100644
--- a/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
+++ b/drivers/gpu/drm/sun4i/sun8i_vi_layer.c
@@ -401,7 +401,7 @@ static void sun8i_vi_layer_atomic_update(struct drm_plane *plane,
 			      true, zpos, old_zpos);
 }
 
-static struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
+static const struct drm_plane_helper_funcs sun8i_vi_layer_helper_funcs = {
 	.prepare_fb	= drm_gem_fb_prepare_fb,
 	.atomic_check	= sun8i_vi_layer_atomic_check,
 	.atomic_disable	= sun8i_vi_layer_atomic_disable,
-- 
2.28.0

