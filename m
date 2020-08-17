Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9792C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89DB62067C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 17:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597686452;
	bh=kuynjF7Ogyf5SCgAhHKGjEUVqGvyDfBFxRNKHrCkplc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vKFRli0nBFJA3E5pbmJ85Q4xtKn2SURw0v8l1pH43gIkFl89NiNYLwGZl94ulN8nc
	 iw0c9E30as+gHvNVyISkFctDVq6oLdRJW2ZEmpAyvc066tBwm4i3MamATCbjCSVydd
	 q70uONVs++R9qqX2TV7TjatGE8B5+hxyVi+VM/8A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389289AbgHQRra (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 13:47:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388554AbgHQQNi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 12:13:38 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D8CC22B43;
        Mon, 17 Aug 2020 16:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597680803;
        bh=kuynjF7Ogyf5SCgAhHKGjEUVqGvyDfBFxRNKHrCkplc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sqmTqVSeb+O3M6T8L54nNWQde46Pm6wdM2wQDA+ezeb1i759crgzuefLEDb/smLC0
         e12P8Nwiu0iN0PFF29afVjcUdBiWd5OxS7SoalV04b7O6MeMzq0wSP0S65Y2kRtKez
         QOqL+fDWHzW1dU8LLn+GnzcHmVKdh04h88TnQXmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Liviu Dudau <Liviu.Dudau@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 062/168] drm/arm: fix unintentional integer overflow on left shift
Date:   Mon, 17 Aug 2020 17:16:33 +0200
Message-Id: <20200817143736.842080392@linuxfoundation.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200817143733.692105228@linuxfoundation.org>
References: <20200817143733.692105228@linuxfoundation.org>
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
index 29409a65d8647..a347b27405d88 100644
--- a/drivers/gpu/drm/arm/malidp_planes.c
+++ b/drivers/gpu/drm/arm/malidp_planes.c
@@ -446,7 +446,7 @@ int malidp_de_planes_init(struct drm_device *drm)
 	const struct malidp_hw_regmap *map = &malidp->dev->hw->map;
 	struct malidp_plane *plane = NULL;
 	enum drm_plane_type plane_type;
-	unsigned long crtcs = 1 << drm->mode_config.num_crtc;
+	unsigned long crtcs = BIT(drm->mode_config.num_crtc);
 	unsigned long flags = DRM_MODE_ROTATE_0 | DRM_MODE_ROTATE_90 | DRM_MODE_ROTATE_180 |
 			      DRM_MODE_ROTATE_270 | DRM_MODE_REFLECT_X | DRM_MODE_REFLECT_Y;
 	u32 *formats;
-- 
2.25.1



