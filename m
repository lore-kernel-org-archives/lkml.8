Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E41C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A2182084E
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 15:22:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgCHPWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 11:22:52 -0400
Received: from mail.manjaro.org ([176.9.38.148]:48434 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgCHPWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 11:22:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id B4E8437A1C4A;
        Sun,  8 Mar 2020 16:22:50 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MQOBT0Tcdx0E; Sun,  8 Mar 2020 16:22:47 +0100 (CET)
From:   Tobias Schramm <t.schramm@manjaro.org>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     Brian Masney <masneyb@onstation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Icenowy Zheng <icenowy@aosc.io>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <treding@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tobias Schramm <t.schramm@manjaro.org>
Subject: [PATCH v2 1/1] drm/bridge: anx78xx: fix calculation of dp link rate
Date:   Sun,  8 Mar 2020 16:22:38 +0100
Message-Id: <20200308152238.1294229-2-t.schramm@manjaro.org>
In-Reply-To: <20200308152238.1294229-1-t.schramm@manjaro.org>
References: <20200308152238.1294229-1-t.schramm@manjaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit ff1e8fb68ea0 ("drm/bridge: analogix-anx78xx: Avoid drm_dp_link helpers")
changed the link training logic to remove use of drm_dp_link helpers.
However the new logic stores the maximum link rate in a u8, overflowing
it.
This commit changes the logic to store the bw code directly, avoiding any
overflows.

Fixes: ff1e8fb68ea0 ("drm/bridge: analogix-anx78xx: Avoid drm_dp_link helpers")
Signed-off-by: Tobias Schramm <t.schramm@manjaro.org>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
index 41867be03751..0c6b049b5753 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c
@@ -722,8 +722,7 @@ static int anx78xx_dp_link_training(struct anx78xx *anx78xx)
 	if (err)
 		return err;
 
-	dpcd[0] = drm_dp_max_link_rate(anx78xx->dpcd);
-	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
+	dpcd[0] = anx78xx->dpcd[DP_MAX_LINK_RATE];
 	err = regmap_write(anx78xx->map[I2C_IDX_TX_P0],
 			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
 	if (err)
-- 
2.24.1

