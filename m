Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F95FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:13:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02B5420658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 16:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597680829;
	bh=79hPRqgXWFr+ObCSA7EIGI00pw8gXvjZdWf2oaJ+dAQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nNiJxL51tg/xmzF8QJcpP3RzrK/+YOJYCLOPXKyX+GefaAtShdXDwy99o76gEKBdD
	 FfN9l4y6Shx+lf5mntLhtONeCBKMg2NvOjWThdDrSP1kN2w8Rx+krybn4trxXlHFY1
	 9dkpfNEpcoofcYbNqTwYjmnEb90OW5vm+fbObS58=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbgHQQNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 12:13:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730619AbgHQPr1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:47:27 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B769F2075B;
        Mon, 17 Aug 2020 15:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597679246;
        bh=79hPRqgXWFr+ObCSA7EIGI00pw8gXvjZdWf2oaJ+dAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjf6NS81rMxeqSBJ1WAnQSDUFrD8vLtTW00RhgVJfbU1PGt+oJpBTlRxzY3MlKMa+
         jiQ9oFt30eBH3UfI+ZOCyL+T1jAUfXB1pEstZkNv89Fo/9BTVQ/6fW609qBoX3/YkS
         uqRDOSMfT0AsM1h4a2k6/7ZAOKzoDlZfbMC4yPkU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 145/393] drm/arm: fix unintentional integer overflow on left shift
Date:   Mon, 17 Aug 2020 17:13:15 +0200
Message-Id: <20200817143826.646254076@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143819.579311991@linuxfoundation.org>
References: <20200817143819.579311991@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 5f368ddea6fec519bdb93b5368f6a844b6ea27a6 ]

Shifting the integer value 1 is evaluated using 32-bit arithmetic
and then used in an expression that expects a long value leads to
a potential integer overflow. Fix this by using the BIT macro to
perform the shift to avoid the overflow.

Addresses-Coverity: ("Unintentional integer overflow")
Fixes: ad49f8602fe8 ("drm/arm: Add support for Mali Display Processors")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Liviu Dudau <Liviu.Dudau@arm.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20200618100400.11464-1-colin.king@canonical.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/arm/malidp_planes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/malidp_planes.c
index 37715cc6064e6..ab45ac445045a 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -928,7 +928,7 @@ int malidp_de_planes_init(struct drm_device *drm)
 	const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
 	struct malidp_plane *plane = NULL;
 	enum drm_plane_type plane_type;
-	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
+	unsigned long crtcs = BIT(drm->mode_config.num_crtc);
 	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
 			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
 	unsigned int blend_caps = BIT(DRM_MODE_BLEND_PIXEL_NONE) |
-- 
2.25.1



