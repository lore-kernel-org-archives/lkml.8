Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108E9C10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:36:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF691206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326192;
	bh=/o1Xr498tkQFQ/oFiaM4/uN7/67/7a1kWePFN3V31LI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vao7msLKVSJaVuf10k6iwjtIhJ98jGhMSaoW+f5J9h+Y1oJOYRSpnglqDT6d/RfwB
	 u3ZR6QMRcCQzsdtUFNN+Ji6ocKGzDX2umTynTUXpNU8C8bIrgBgJO3SUN5xxM20yDe
	 404MFR2V7HhPbVz/LkXvRSvrDX2A4YqlGZvREqOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730015AbgCPCgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:36:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:40476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729826AbgCPCfp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:45 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFB4B20722;
        Mon, 16 Mar 2020 02:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326144;
        bh=/o1Xr498tkQFQ/oFiaM4/uN7/67/7a1kWePFN3V31LI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZTKIIRepsoM2vN8rGanJIGrb3iTku26rQqbA7d5JbUPf+k/ydpyAm0zjsZo+4v9jz
         /9wtLoK6hY7+N5VEDZQJwmAm7Ila+JiWdYT+K9eNd6PHhXwtBOS2VY+T0cKaZ/1/To
         k4C/yPGq80ieWIskh8x3HSuk1czNOsjKjGbmpkvU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 5/7] drm/exynos: dsi: propagate error value and silence meaningless warning
Date:   Sun, 15 Mar 2020 22:35:36 -0400
Message-Id: <20200316023538.2232-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023538.2232-1-sashal@kernel.org>
References: <20200316023538.2232-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Szyprowski <m.szyprowski@samsung.com>

[ Upstream commit 0a9d1e3f3f038785ebc72d53f1c409d07f6b4ff5 ]

Properly propagate error value from devm_regulator_bulk_get() and don't
confuse user with meaningless warning about failure in getting regulators
in case of deferred probe.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Inki Dae <inki.dae@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_drm_dsi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_dsi.c b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
index e07cb1fe48604..5e202af7fbf53 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1775,8 +1775,9 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(dsi->supplies),
 				      dsi->supplies);
 	if (ret) {
-		dev_info(dev, "failed to get regulators: %d\n", ret);
-		return -EPROBE_DEFER;
+		if (ret != -EPROBE_DEFER)
+			dev_info(dev, "failed to get regulators: %d\n", ret);
+		return ret;
 	}
 
 	dsi->clks = devm_kzalloc(dev,
-- 
2.20.1

