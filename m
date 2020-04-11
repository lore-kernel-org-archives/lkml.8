Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1013AC2BA19
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D779520708
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 23:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586646639;
	bh=G6doahWEhEoWqA7g3gA5FqgZGobBc8m5pKoJLoAJSdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tjJ42O3eIbrPUdsDO55LodeEoh1RTtYvkGeWyO0twhZlABXhS3Kmtg4J5iKIbjumI
	 +aR5bTB62VXjcxZsBN8U7rP2dT0FdN5Q0jID14dSw2zpoa48kALEPS4yjk2XWwl/nf
	 1AuG64BJ0SacGZzoRyUL+8lXC+tChjsiF+uJF2fY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbgDKXKi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 19:10:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729627AbgDKXKe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 19:10:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7879A20757;
        Sat, 11 Apr 2020 23:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586646635;
        bh=G6doahWEhEoWqA7g3gA5FqgZGobBc8m5pKoJLoAJSdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ea3/W8vppEjMZBJj+YmXu2blDJKIRzCSlAVkoW/H0Uw6rrUBqo8faOJgXm/6oivrv
         uXPNKghB+oLNk6ueZPpGIeGWRa3tq4or1e/crA55rViajBXgSYwBUnSNt4a9n/lHdg
         Q5m+HQK07EEMmGN4DJbyl2PoNIvY5xaQE/LjBoPM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 042/108] drm/sun4i: dsi: Use NULL to signify "no panel"
Date:   Sat, 11 Apr 2020 19:08:37 -0400
Message-Id: <20200411230943.24951-42-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200411230943.24951-1-sashal@kernel.org>
References: <20200411230943.24951-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Holland <samuel@sholland.org>

[ Upstream commit 0e4e3fb4901d19f49e5c0a582f383b10dda8d1c5 ]

The continued use of an ERR_PTR to signify "no panel" outside of
sun6i_dsi_attach is confusing because it is a double negative. Because
the connector always reports itself as connected, there is also the
possibility of sending an ERR_PTR to drm_panel_get_modes(), which would
crash.

Solve both of these by only storing the panel pointer if it is valid.

Fixes: 133add5b5ad4 ("drm/sun4i: Add Allwinner A31 MIPI-DSI controller support")
Signed-off-by: Samuel Holland <samuel@sholland.org>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://patchwork.freedesktop.org/patch/msgid/20200211072858.30784-2-samuel@sholland.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
index f83522717488a..d2ade0ad67708 100644
--- a/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
+++ b/drivers/gpu/drm/sun4i/sun6i_mipi_dsi.c
@@ -748,7 +748,7 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	phy_configure(dsi->dphy, &opts);
 	phy_power_on(dsi->dphy);
 
-	if (!IS_ERR(dsi->panel))
+	if (dsi->panel)
 		drm_panel_prepare(dsi->panel);
 
 	/*
@@ -763,7 +763,7 @@ static void sun6i_dsi_encoder_enable(struct drm_encoder *encoder)
 	 * ordering on the panels I've tested it with, so I guess this
 	 * will do for now, until that IP is better understood.
 	 */
-	if (!IS_ERR(dsi->panel))
+	if (dsi->panel)
 		drm_panel_enable(dsi->panel);
 
 	sun6i_dsi_start(dsi, DSI_START_HSC);
@@ -779,7 +779,7 @@ static void sun6i_dsi_encoder_disable(struct drm_encoder *encoder)
 
 	DRM_DEBUG_DRIVER("Disabling DSI output\n");
 
-	if (!IS_ERR(dsi->panel)) {
+	if (dsi->panel) {
 		drm_panel_disable(dsi->panel);
 		drm_panel_unprepare(dsi->panel);
 	}
@@ -941,11 +941,13 @@ static int sun6i_dsi_attach(struct mipi_dsi_host *host,
 			    struct mipi_dsi_device *device)
 {
 	struct sun6i_dsi *dsi = host_to_sun6i_dsi(host);
+	struct drm_panel *panel = of_drm_find_panel(device->dev.of_node);
 
+	if (IS_ERR(panel))
+		return PTR_ERR(panel);
+
+	dsi->panel = panel;
 	dsi->device = device;
-	dsi->panel = of_drm_find_panel(device->dev.of_node);
-	if (IS_ERR(dsi->panel))
-		return PTR_ERR(dsi->panel);
 
 	dev_info(host->dev, "Attached device %s\n", device->name);
 
-- 
2.20.1

