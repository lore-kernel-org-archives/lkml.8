Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50FBC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949BA22527
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 15:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgBRPrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 10:47:49 -0500
Received: from verein.lst.de ([213.95.11.211]:38826 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgBRPrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 10:47:48 -0500
Received: by verein.lst.de (Postfix, from userid 2005)
        id BCB6D68BFE; Tue, 18 Feb 2020 16:47:45 +0100 (CET)
From:   Torsten Duwe <duwe@lst.de>
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [RESEND][PATCH] drm/bridge: analogix-anx6345: Fix drm_dp_link helper removal
Message-Id: <20200218154745.BCB6D68BFE@verein.lst.de>
Date:   Tue, 18 Feb 2020 16:47:45 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

drm_dp_link_rate_to_bw_code and ...bw_code_to_link_rate simply divide by
and multiply with 27000, respectively. Avoid an overflow in the u8 dpcd[0]
and the multiply+divide alltogether.

fixes: e1cff82c1097bda2478 ("fix anx6345 compilation for v5.5")
Signed-off-by: Torsten Duwe <duwe@suse.de>
---
https://patchwork.freedesktop.org/patch/343004/
https://lists.freedesktop.org/archives/dri-devel/2020-January/253535.html

--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -210,10 +210,9 @@ static int anx6345_dp_link_training(struct anx6345 *anx6345)
 	if (err)
 		return err;
 
-	dpcd[0] = drm_dp_max_link_rate(anx6345->dpcd);
-	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
 	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
-			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
+			   SP_DP_MAIN_LINK_BW_SET_REG,
+			   anx6345->dpcd[DP_MAX_LINK_RATE]);
 	if (err)
 		return err;
 
