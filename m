Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 051ACC35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC83E222C4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=aosc.io header.i=@aosc.io header.b="CGpuMZck"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgBUQ7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:59:31 -0500
Received: from hermes.aosc.io ([199.195.250.187]:47627 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725995AbgBUQ7b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:59:31 -0500
X-Greylist: delayed 450 seconds by postgrey-1.27 at vger.kernel.org; Fri, 21 Feb 2020 11:59:30 EST
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id EE6F748C57;
        Fri, 21 Feb 2020 16:51:53 +0000 (UTC)
From:   Icenowy Zheng <icenowy@aosc.io>
To:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Torsten Duwe <duwe@lst.de>, Maxime Ripard <maxime@cerno.tech>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Icenowy Zheng <icenowy@aosc.io>
Subject: [PATCH] drm/bridge: analogix-anx6345: fix set of link bandwidth
Date:   Sat, 22 Feb 2020 00:51:27 +0800
Message-Id: <20200221165127.813325-1-icenowy@aosc.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aosc.io; s=dkim;
        t=1582303919;
        h=from:subject:date:message-id:to:cc:mime-version:content-transfer-encoding;
        bh=YNbFrFHVB1l3mDgNrrl772T+WtA//BPVhMlOVwCxv2w=;
        b=CGpuMZckC4RiokZ8E/hXX2HzrZi04PYP127dKuQ0zyygfRpucOHsUVCrFfVVxuUPjKMhGE
        i+mn3cNlswA+wrkBj8iP1MGIySNiv10k9D/bXsv6YLywh16R+Agx4TDPjG1Pj1wp38zvmv
        YUBojk1AXs8ACNVGMe6E6ZydjLRFrsw=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current code tries to store the link rate (in bps, which is a big
number) in a u8, which surely overflow. Then it's converted back to
bandwidth code (which is thus 0) and written to the chip.

The code sometimes works because the chip will automatically fallback to
the lowest possible DP link rate (1.62Gbps) when get the invalid value.
However, on the eDP panel of Olimex TERES-I, which wants 2.7Gbps link,
it failed.

As we had already read the link bandwidth as bandwidth code in earlier
code (to check whether it is supported), use it when setting bandwidth,
instead of converting it to link rate and then converting back.

Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for v5.5")
Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index 56f55c53abfd..2dfa2fd2a23b 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -210,8 +210,7 @@ static int anx6345_dp_link_training(struct anx6345 *anx6345)
 	if (err)
 		return err;
 
-	dpcd[0] = drm_dp_max_link_rate(anx6345->dpcd);
-	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
+	dpcd[0] = dp_bw;
 	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
 			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
 	if (err)
-- 
2.24.1

