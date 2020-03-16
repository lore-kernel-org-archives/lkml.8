Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE2C1C10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:41:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEA8206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326484;
	bh=FTweWN98BoOY115uzLhzfrdwPwGcwkAI9w3aSqZ/KUs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FLWl7Jzywz0NgO60/iyrAlYhhpD2tyItzJjHoX3ebqTRX6oY62fSGKRcST4lVog6q
	 aQ6FktFbV8qxyluf3nnK0NjAvqnJ/s6FQgS30a4fbywXGjRWmZPk3iLN6nMv2xFqOU
	 wn7+V4pMX1+j6L+ofObK39V81Gim3QMOyEJWR3Gk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730499AbgCPClX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:41:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:36532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729601AbgCPCdm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:33:42 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EDA4620749;
        Mon, 16 Mar 2020 02:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326021;
        bh=FTweWN98BoOY115uzLhzfrdwPwGcwkAI9w3aSqZ/KUs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X0Zs5UgKu3xxitsZTLbBLMKIq8W5bLidA8Oqk6qGrvy+AJ0xhW3ZPSYqz2S7B1WMQ
         yZONk77GiaH+e/Xs6/1CsciYyoKui6J531bp1VT0Al3AU8omUxxJ319MaLa0i3RV9i
         lAe3PhkZRBHj/c1aflB9kpjzEUeMkzdEfSgNm8jQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 5.5 18/41] drm/exynos: dsi: propagate error value and silence meaningless warning
Date:   Sun, 15 Mar 2020 22:32:56 -0400
Message-Id: <20200316023319.749-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023319.749-1-sashal@kernel.org>
References: <20200316023319.749-1-sashal@kernel.org>
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
index 72726f2c7a9fb..8d880012b5876 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1751,8 +1751,9 @@ static int exynos_dsi_probe(struct platform_device *pdev)
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(dsi->supplies),
 				      dsi->supplies);
 	if (ret) {
-		dev_info(dev, "failed to get regulators: %d\n", ret);
-		return -EPROBE_DEFER;
+		if (ret != -EPROBE_DEFER)
+			dev_info(dev, "failed to get regulators: %d\n", ret);
+		return ret;
 	}
 
 	dsi->clks = devm_kcalloc(dev,
-- 
2.20.1

