Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1EAAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB72B20781
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 15:32:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGbnnhSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHMPcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 11:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbgHMPb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 11:31:59 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C6EC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:31:58 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id f5so2772216plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 08:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1LEusT9oa0L+q3BIsPrMMq4pG+6qT2ZmHiLBsZn4HGE=;
        b=FGbnnhSH6cfKYN3u4+YOy8mBz3vPAnoWPkXX0A8ALZqSEW7UkJRXmyNT3Rey0B5EbS
         D0wLgqb7vd7CXUxNgq0Ffv3zwFFbcyruuZNss8A+6md3fCyAZr9GZSlC+7l8RBjSuRob
         217twVJaBLKu6evVJ1ntryGbbJJ8TXo5s+kV8DH2bT9biH7dw2KzM9/AbIAlP1QSvjdT
         BVUByhWWjshyUXgIYvJFrWe+Txrf/CRgIzA/xQ06yPcpKSONbhQPEp2KaR5rZRczzZH4
         Fls7ABA+AW/6Y3rB93hLkeL3CIYWEOYQJKz69AqKs6rDabIUtSsg99ZVs1ebenBEgkum
         4sqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1LEusT9oa0L+q3BIsPrMMq4pG+6qT2ZmHiLBsZn4HGE=;
        b=moB1/uUCxuPanYJAVZHEDTuZz2zS59FiCsb0vn1erqv2M5m/SCm3l89n5KW3F4YfGX
         /oHcG74vQFMdt2qbUqkNUDVJfX5/de1ol/UvpSzewvkoom2fBLtTN7UyUTK9GYV54aDh
         I33VJTA/We6yLTJyMPeGIty/em01niYmYgxavSm4nTsAjb1Znbt2L+WKfhx6Tl0fW8Oc
         gY0s/DJqmbQ0Ma1V9M4yDtdHfuneRhTnuqp1KDjosNz1g1ACEHD0whEqCp24eZWqPXaF
         Cdza1153j19Su+/MvH3QtmkHu5OxKvXyD0Kogyf/8JrBuUb71MekqK0jOIn3HiLh/qQe
         rVbg==
X-Gm-Message-State: AOAM530zOE2YazDdi/DhBxKV1kmUcM4RIuhApc/6HP2rK6PvrSt600qy
        +dJqMmu713X+NAytb/InejPJ84138t4=
X-Google-Smtp-Source: ABdhPJxQDSrZyCASJdEXe4r1OePxEki+gNmooht0uyTMPChsOUS8l0VZpXPidd7yAIoUVJa9u5yf7w==
X-Received: by 2002:a17:902:40a:: with SMTP id 10mr4553478ple.260.1597332716468;
        Thu, 13 Aug 2020 08:31:56 -0700 (PDT)
Received: from inforce-server-Z9PE-D8-WS.routereb3c90.com ([106.51.138.45])
        by smtp.gmail.com with ESMTPSA id s8sm5532689pju.54.2020.08.13.08.31.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 08:31:55 -0700 (PDT)
From:   Vinay Simha BN <simhavcs@gmail.com>
Cc:     Vinay Simha BN <simhavcs@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/bridge/tc358775: Fixes bus formats read
Date:   Thu, 13 Aug 2020 21:01:26 +0530
Message-Id: <1597332687-23938-1-git-send-email-simhavcs@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- atomic_check removed
- video data input and output formats added
- bus formats read from drm_bridge_state.output_bus_cfg.format
  and .atomic_get_input_bus_fmts() instead of connector

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

---
v1:
 * Laurent Pinchart review comments incorporated
   drm_bridge_state.output_bus_cfg.format
   instead of connector
v2:
 * Laurent Pinchart review comments incorporated
   atomic_check removed
   video data input and output formats added
---
 drivers/gpu/drm/bridge/tc358775.c | 75 ++++++++++++++++++++++++++++++---------
 1 file changed, 58 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 7da15cd..58f87ec 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -271,6 +271,20 @@ struct tc_data {
 	struct gpio_desc	*stby_gpio;
 	u8			lvds_link; /* single-link or dual-link */
 	u8			bpc;
+	u32			output_bus_fmt;
+};
+
+static const u32 tc_lvds_in_bus_fmts[] = {
+	MEDIA_BUS_FMT_RGB565_1X16,
+	MEDIA_BUS_FMT_RGB666_1X18,
+	MEDIA_BUS_FMT_RGB666_1X24_CPADHI,
+	MEDIA_BUS_FMT_RBG888_1X24,
+};
+
+static const u32 tc_lvds_out_bus_fmts[] = {
+	MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
+	MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
 };
 
 static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
@@ -359,19 +373,6 @@ static void d2l_write(struct i2c_client *i2c, u16 addr, u32 val)
 			ret, addr);
 }
 
-/* helper function to access bus_formats */
-static struct drm_connector *get_connector(struct drm_encoder *encoder)
-{
-	struct drm_device *dev = encoder->dev;
-	struct drm_connector *connector;
-
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head)
-		if (connector->encoder == encoder)
-			return connector;
-
-	return NULL;
-}
-
 static void tc_bridge_enable(struct drm_bridge *bridge)
 {
 	struct tc_data *tc = bridge_to_tc(bridge);
@@ -380,7 +381,10 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	u32 val = 0;
 	u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
 	struct drm_display_mode *mode;
-	struct drm_connector *connector = get_connector(bridge->encoder);
+	struct drm_bridge_state *state =
+			drm_priv_to_bridge_state(bridge->base.state);
+
+	tc->output_bus_fmt = state->output_bus_cfg.format;
 
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 
@@ -451,14 +455,13 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	d2l_write(tc->i2c, LVPHY0, LV_PHY0_PRBS_ON(4) | LV_PHY0_ND(6));
 
 	dev_dbg(tc->dev, "bus_formats %04x bpc %d\n",
-		connector->display_info.bus_formats[0],
+		tc->output_bus_fmt,
 		tc->bpc);
 	/*
 	 * Default hardware register settings of tc358775 configured
 	 * with MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA jeida-24 format
 	 */
-	if (connector->display_info.bus_formats[0] ==
-		MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
+	if (tc->output_bus_fmt == MEDIA_BUS_FMT_RGB888_1X7X4_SPWG) {
 		/* VESA-24 */
 		d2l_write(tc->i2c, LV_MX0003, LV_MX(LVI_R0, LVI_R1, LVI_R2, LVI_R3));
 		d2l_write(tc->i2c, LV_MX0407, LV_MX(LVI_R4, LVI_R7, LVI_R5, LVI_G0));
@@ -590,6 +593,40 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
 	return 0;
 }
 
+static u32 *
+tc_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
+			     struct drm_bridge_state *bridge_state,
+			     struct drm_crtc_state *crtc_state,
+			     struct drm_connector_state *conn_state,
+			     u32 output_fmt,
+			     unsigned int *num_input_fmts)
+{
+	u32 *input_fmts = NULL;
+	u8 i;
+
+	*num_input_fmts = 0;
+
+	for (i = 0 ; i < ARRAY_SIZE(tc_lvds_out_bus_fmts) ; ++i) {
+		if (output_fmt == tc_lvds_out_bus_fmts[i])
+			break;
+	}
+
+	if (i == ARRAY_SIZE(tc_lvds_out_bus_fmts))
+		return NULL;
+
+	*num_input_fmts = ARRAY_SIZE(tc_lvds_in_bus_fmts);
+
+	input_fmts = kcalloc(*num_input_fmts, ARRAY_SIZE(tc_lvds_in_bus_fmts),
+			     GFP_KERNEL);
+	if (!input_fmts)
+		return NULL;
+
+	for (i = 0; i < ARRAY_SIZE(tc_lvds_in_bus_fmts); ++i)
+		input_fmts[i] = tc_lvds_in_bus_fmts[i];
+
+	return input_fmts;
+}
+
 static int tc_bridge_attach(struct drm_bridge *bridge,
 			    enum drm_bridge_attach_flags flags)
 {
@@ -639,6 +676,10 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs tc_bridge_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_get_input_bus_fmts = tc_bridge_get_input_bus_fmts,
 	.attach = tc_bridge_attach,
 	.pre_enable = tc_bridge_pre_enable,
 	.enable = tc_bridge_enable,
-- 
2.7.4

