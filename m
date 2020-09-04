Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79393C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FB9206B7
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 12:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="d0c4e8pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgIDMzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 08:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730010AbgIDMzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:55:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E98C061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 05:55:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k15so6622211wrn.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv8vkjDQK6hcRmOjhA1B4LKV5dcNKUU+lKopTGFxDEk=;
        b=d0c4e8pnx/zw8L1LUX1IDKWgDaOOcFOwkGN7pDeTnRSV3HcfbvwR2pF65F33Qq2OrP
         x0L8nWU/KikfnXLm0ad7qfVo32XRlkxz7Z0eDlEsVHr+cfAv784G2m9LTVfLv+L0f7y/
         /N0KuRUbHfIOdbBvB07yBYVOSJDW1Zi5LWqy6KbFBa/6nwLkxkd9MKkd95bfh20BkAeN
         RRubpy7nee7IrN1eT3+dighUN7LxYPJNkUVJ30yLVmCThHcyJhG2YMk/uW+8O+9hXuxX
         T76cIDTMe6zOR1Ub9D9DCmA+3lE1EuogygFRlm3pCq0Ql2rw04CMAx81n9gC7E/XmE6j
         jONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=yv8vkjDQK6hcRmOjhA1B4LKV5dcNKUU+lKopTGFxDEk=;
        b=WmWwXNX16edlcxNOZ+uaUJTdcbeDqnK6CJ9nCUeWAhLv9IJ5Ae5Flo6Yc8HExnDk1l
         S2PbrBvQWkNIVUKM5WPGHbnl/N7QnfzQ1Po/w0aUiVkrdnr76MOHHbucQvapyuaUApYv
         HtLQtwI9AqsTL3pQmf8nycIxhvpTBRgvSSTR9rgFwCqtMi1kve71e8Uu3BNgZaPGemDC
         KAzJZlMVp1+nrT0fKMv+fMxaYLxEtH9pX6s4L5kCJ81KGuHA30FMmR2pH742ViDzkH2m
         x2+wDV7NbGbKILDcQbd0KZQxrJi1X2SU6f9WRT7P2+42Bj0RGVwdqLcpf0Z+RxtQMYKm
         AZEA==
X-Gm-Message-State: AOAM533ijAYa5XycBgswM11RtFLMeCn4OgJip3XleUbVVMjACO8TGmWV
        4KSXOsiRW+F4BJ2J+J2xUE/DZA==
X-Google-Smtp-Source: ABdhPJxv90v+tFBoZCB4HpM62W+SkjjqW7sPC+ACOuh5qlqbSlXgZD7YYB18yLvhWxSjJbc4yvEFNw==
X-Received: by 2002:a5d:5486:: with SMTP id h6mr7572543wrv.415.1599224134577;
        Fri, 04 Sep 2020 05:55:34 -0700 (PDT)
Received: from bender.baylibre.local ([2a01:e35:2ec0:82b0:5405:9623:e2f1:b2ac])
        by smtp.gmail.com with ESMTPSA id z15sm11026236wrv.94.2020.09.04.05.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 05:55:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     a.hajda@samsung.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net
Cc:     yannick.fertre@st.com, heiko.stuebner@theobroma-systems.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH] drm/bridge: dw-mipi-dsi: permit configuring the escape clock rate
Date:   Fri,  4 Sep 2020 14:55:31 +0200
Message-Id: <20200904125531.15248-1-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic D-PHY in the Amlogic AXG SoC Family does support a frequency
higher than 10MHz for the TX Escape Clock, thus make the target rate
configurable.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c | 25 +++++++++++++++----
 include/drm/bridge/dw_mipi_dsi.h              |  1 +
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
index d580b2aa4ce9..31fc965c66fd 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi.c
@@ -562,15 +562,30 @@ static void dw_mipi_dsi_disable(struct dw_mipi_dsi *dsi)
 
 static void dw_mipi_dsi_init(struct dw_mipi_dsi *dsi)
 {
+	const struct dw_mipi_dsi_phy_ops *phy_ops = dsi->plat_data->phy_ops;
+	unsigned int esc_rate; /* in MHz */
+	u32 esc_clk_division;
+	int ret;
+
 	/*
 	 * The maximum permitted escape clock is 20MHz and it is derived from
-	 * lanebyteclk, which is running at "lane_mbps / 8".  Thus we want:
-	 *
-	 *     (lane_mbps >> 3) / esc_clk_division < 20
+	 * lanebyteclk, which is running at "lane_mbps / 8".
+	 */
+	if (phy_ops->get_esc_clk_rate) {
+		ret = phy_ops->get_esc_clk_rate(dsi->plat_data->priv_data,
+						&esc_rate);
+		if (ret)
+			DRM_DEBUG_DRIVER("Phy get_esc_clk_rate() failed\n");
+	} else
+		esc_rate = 20; /* Default to 20MHz */
+
+	/*
+	 * We want :
+	 *     (lane_mbps >> 3) / esc_clk_division < X
 	 * which is:
-	 *     (lane_mbps >> 3) / 20 > esc_clk_division
+	 *     (lane_mbps >> 3) / X > esc_clk_division
 	 */
-	u32 esc_clk_division = (dsi->lane_mbps >> 3) / 20 + 1;
+	esc_clk_division = (dsi->lane_mbps >> 3) / esc_rate + 1;
 
 	dsi_write(dsi, DSI_PWR_UP, RESET);
 
diff --git a/include/drm/bridge/dw_mipi_dsi.h b/include/drm/bridge/dw_mipi_dsi.h
index b0e390b3288e..bda8aa7c2280 100644
--- a/include/drm/bridge/dw_mipi_dsi.h
+++ b/include/drm/bridge/dw_mipi_dsi.h
@@ -36,6 +36,7 @@ struct dw_mipi_dsi_phy_ops {
 			     unsigned int *lane_mbps);
 	int (*get_timing)(void *priv_data, unsigned int lane_mbps,
 			  struct dw_mipi_dsi_dphy_timing *timing);
+	int (*get_esc_clk_rate)(void *priv_data, unsigned int *esc_clk_rate);
 };
 
 struct dw_mipi_dsi_host_ops {
-- 
2.22.0

