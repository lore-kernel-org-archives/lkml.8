Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B83DBC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86979206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326160;
	bh=RtkAOZXuRvJwL8YLTO8SpGSdqHr4pqf4Wyne0iQzA6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AboiB0WWlIakvsBANI/hET+sUO4C7+TfCqDb/G/W0+xPor0ViA8g8e9LmluyLcjEt
	 fngSD6vpCUx9LKlwjymKxvoWE0Jbc4WhqUzF85SCXMz9B1pQhkCjN5y7Do5ACiP1oS
	 nO6OiXCmMH+vpb6EparyvyVmUDQWkohoCaV2HxOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730313AbgCPCf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:35:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:40796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729530AbgCPCfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B9E0620724;
        Mon, 16 Mar 2020 02:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326154;
        bh=RtkAOZXuRvJwL8YLTO8SpGSdqHr4pqf4Wyne0iQzA6o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QMSN9gD/9yR7B27hbxlnZrz3yD/Qb7p5FTZn0YIpIDctUw2dtt3Z6NxVp7sz6iXGc
         JSDJvqytXktRuuH/3svepvAyf3MRdaoeFODbYKfSKTjKy5q1pWGw70sWchRlKW0E3W
         ps63CSUdl6qMVwbwYLT9P5RsQx6uHUvkxVjbtn7c=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Inki Dae <inki.dae@samsung.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 5/7] drm/exynos: dsi: propagate error value and silence meaningless warning
Date:   Sun, 15 Mar 2020 22:35:45 -0400
Message-Id: <20200316023548.2347-5-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023548.2347-1-sashal@kernel.org>
References: <20200316023548.2347-1-sashal@kernel.org>
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
index 12b03b3647034..1ee0b70472fd8 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_dsi.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_dsi.c
@@ -1899,8 +1899,9 @@ static int exynos_dsi_probe(struct platform_device *pdev)
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

