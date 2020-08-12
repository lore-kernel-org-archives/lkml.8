Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA828C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:25:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CF0720768
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 07:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C25vs753"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgHLHZ6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 03:25:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726695AbgHLHZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 03:25:57 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C93C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:25:57 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ep8so670183pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 00:25:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=am/paBIRBoe+TlJ53IdaKYgaEqNB1eUlysXKpuKQLNk=;
        b=C25vs753EXXXsK5OqNG2Ui+XT2YUKx+jtCvtGRutfG4Abx+VojyxZMvuklwDs1vqRb
         Q6FrjM0fP/wVcMDvvXOYuQVj52+Mufbub+vWq2NiR2cTIjOByTCza8r+IOinLFNp+nmC
         KbKUQ9gL8hDJI3Yna8G1I66e8qHJngeddNOJpnEPnFcrhkAgjE1oAfttTl6ZGNM7pgDH
         +J3FriGhWmdGQwmW4wwxep723I3os1EUF076ymoALS4MvPZn5fj7aP2fxkIRPjV0DkvT
         QKhWXEMFknTsNfzvrU2zIAB6sPTIanJcrliCJA1lTgIUXqp9x0VOxdhU9so8LFZhO0eO
         vwBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=am/paBIRBoe+TlJ53IdaKYgaEqNB1eUlysXKpuKQLNk=;
        b=fTgwSqKUHgf9/qbPRQRcDhTtSF8QpX/k/NV2uTjhA45Dw5dnbp+e2edv4d4GUIy7sd
         qYSAUovUQXKkUo97eZBfCBQK/67DgFdqocLP1U7FC9pjLqejHAKPwLuNADJFS9RhSPQR
         hlkCLEKVxJ53TTyNJ8q3cJWvRAuEXEO3/GjmYJ089FuG5e+clAmO4MI4xUgXzFuN8h6X
         sRtXDBa2k+zO14MwRM71N6ghLqgHH6rwecEwlJZPSAC7QNnRrxxaonA8TkJi9ikSyC5U
         IIcYiFW6VYyY4XAYM8Eeuwxt84pbsZQZqGMtEf/yhYJv4YfUxoqkwoM77nHvnAOeMPrM
         oxzA==
X-Gm-Message-State: AOAM533RO3FLjAwcT6QkNr0Q1twXe3/R/vp7E2z+vBa2YcwJtvu/Yy1/
        ZXPu1k4NmF8DX/Efi0j3ZCI=
X-Google-Smtp-Source: ABdhPJzFkJSt4zJGUvYGM5u7r3BGcsolIu2PvXSH3uAPyLDlQcexWsaVHAklvW72GugqcO1CQRUbLA==
X-Received: by 2002:a17:902:9a06:: with SMTP id v6mr4369543plp.57.1597217157333;
        Wed, 12 Aug 2020 00:25:57 -0700 (PDT)
Received: from inforce-server-Z9PE-D8-WS.routereb3c90.com ([106.51.138.45])
        by smtp.gmail.com with ESMTPSA id a24sm1336533pfg.113.2020.08.12.00.25.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Aug 2020 00:25:56 -0700 (PDT)
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
Subject: [PATCH] drm/bridge/tc358775: Fixes bus formats read
Date:   Wed, 12 Aug 2020 12:55:50 +0530
Message-Id: <1597217150-22911-1-git-send-email-simhavcs@gmail.com>
X-Mailer: git-send-email 2.7.4
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- bus formats read from drm_bridge_state.output_bus_cfg.format
  and .atomic_get_input_bus_fmts() instead of connector

Signed-off-by: Vinay Simha BN <simhavcs@gmail.com>

---
 v1:
 * Laurent Pinchart review comments incorporated
   drm_bridge_state.output_bus_cfg.format
   instead of connector
---
 drivers/gpu/drm/bridge/tc358775.c | 76 ++++++++++++++++++++++++++++++---------
 1 file changed, 59 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 7da15cd..5d8714a 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -271,6 +271,13 @@ struct tc_data {
 	struct gpio_desc	*stby_gpio;
 	u8			lvds_link; /* single-link or dual-link */
 	u8			bpc;
+	u32			output_bus_fmt;
+};
+
+static const u32 tc_lvds_out_bus_fmts[] = {
+	MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA,
+	MEDIA_BUS_FMT_RGB888_1X7X4_SPWG,
+	MEDIA_BUS_FMT_RGB666_1X7X3_SPWG,
 };
 
 static inline struct tc_data *bridge_to_tc(struct drm_bridge *b)
@@ -359,19 +366,6 @@ static void d2l_write(struct i2c_client *i2c, u16 addr, u32 val)
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
@@ -380,7 +374,6 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
 	u32 val = 0;
 	u16 dsiclk, clkdiv, byteclk, t1, t2, t3, vsdelay;
 	struct drm_display_mode *mode;
-	struct drm_connector *connector = get_connector(bridge->encoder);
 
 	mode = &bridge->encoder->crtc->state->adjusted_mode;
 
@@ -451,14 +444,13 @@ static void tc_bridge_enable(struct drm_bridge *bridge)
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
@@ -590,6 +582,51 @@ static int tc358775_parse_dt(struct device_node *np, struct tc_data *tc)
 	return 0;
 }
 
+static int tc_bridge_atomic_check(struct drm_bridge *bridge,
+				  struct drm_bridge_state *bridge_state,
+				  struct drm_crtc_state *crtc_state,
+				  struct drm_connector_state *conn_state)
+{
+	struct tc_data *tc = bridge_to_tc(bridge);
+
+	tc->output_bus_fmt = bridge_state->output_bus_cfg.format;
+
+	dev_dbg(tc->dev, "output_bus_fmt %04x\n", tc->output_bus_fmt);
+
+	return 0;
+}
+
+static u32 *
+tc_bridge_get_input_bus_fmts(struct drm_bridge *bridge,
+			     struct drm_bridge_state *bridge_state,
+			     struct drm_crtc_state *crtc_state,
+			     struct drm_connector_state *conn_state,
+			     u32 output_fmt,
+			     unsigned int *num_input_fmts)
+{
+	u32 *input_fmts = NULL;
+	int i;
+
+	*num_input_fmts = 0;
+
+	for (i = 0 ; i < ARRAY_SIZE(tc_lvds_out_bus_fmts) ; ++i) {
+		if (output_fmt == tc_lvds_out_bus_fmts[i]) {
+			*num_input_fmts = 1;
+			input_fmts = kcalloc(*num_input_fmts,
+					     sizeof(*input_fmts),
+					     GFP_KERNEL);
+			if (!input_fmts)
+				return NULL;
+
+			input_fmts[0] = output_fmt;
+
+			break;
+		}
+	}
+
+	return input_fmts;
+}
+
 static int tc_bridge_attach(struct drm_bridge *bridge,
 			    enum drm_bridge_attach_flags flags)
 {
@@ -639,6 +676,11 @@ static int tc_bridge_attach(struct drm_bridge *bridge,
 }
 
 static const struct drm_bridge_funcs tc_bridge_funcs = {
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_get_input_bus_fmts = tc_bridge_get_input_bus_fmts,
+	.atomic_check = tc_bridge_atomic_check,
 	.attach = tc_bridge_attach,
 	.pre_enable = tc_bridge_pre_enable,
 	.enable = tc_bridge_enable,
-- 
2.7.4

