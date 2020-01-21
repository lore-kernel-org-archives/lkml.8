Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3858CC33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:48:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F4C524125
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 22:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727816AbgAUWss (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 17:48:48 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35976 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbgAUWss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 17:48:48 -0500
Received: from mail.linser.at ([80.109.168.170] helo=phil.Hitronhub.home)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1iu2KA-0005xB-3m; Tue, 21 Jan 2020 23:48:42 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     hjc@rock-chips.com
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com,
        christoph.muellner@theobroma-systems.com, heiko@sntech.de,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
Subject: [PATCH] drm/rockchip: rgb: don't count non-existent devices when determining subdrivers
Date:   Tue, 21 Jan 2020 23:48:28 +0100
Message-Id: <20200121224828.4070067-1-heiko@sntech.de>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>

rockchip_drm_endpoint_is_subdriver() may also return error codes.
For example if the target-node is in the disabled state, so no
platform-device is getting created for it.

In that case current code would count that as external rgb device,
which in turn would make probing the rockchip-drm device fail.

So only count the target as rgb device if the function actually
returns 0.

Signed-off-by: Heiko Stuebner <heiko.stuebner@theobroma-systems.com>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index ae730275a34f..79a7e60633e0 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -98,7 +98,8 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 		if (of_property_read_u32(endpoint, "reg", &endpoint_id))
 			endpoint_id = 0;
 
-		if (rockchip_drm_endpoint_is_subdriver(endpoint) > 0)
+		/* if subdriver (> 0) or error case (< 0), ignore entry */
+		if (rockchip_drm_endpoint_is_subdriver(endpoint) != 0)
 			continue;
 
 		child_count++;
-- 
2.24.1

