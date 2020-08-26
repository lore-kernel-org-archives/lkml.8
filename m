Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA50C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E0AE221E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598453742;
	bh=9szlv9ZLbjunuES/WDg3stvsnLb6CAlrLlpLvophpUM=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bQmM/CxZEjKmJTFjVvrgDXXWV5Vpg2Ylg+k/K3AbLNbkok+tFP2XOJru88JzaSPFm
	 6EvoWtY9klz6GHs6G38uxSGXcT7Jnoowmyv4+wAuUVN5Zh8OtEV6o4nppU45j3v+VA
	 ZBz3L8y+BWBnQ6b1GHRj7NxvHEMZl4Q4rZBf2pMQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHZOzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:55:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:43944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727056AbgHZOz3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:55:29 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE47722B49;
        Wed, 26 Aug 2020 14:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598453723;
        bh=9szlv9ZLbjunuES/WDg3stvsnLb6CAlrLlpLvophpUM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=E48zCAbaF/pKMDmaXf1RUXxlIYnpyLjWhrRM4YcHj3wGKvInb9E54Ii0UdjTNHHGP
         892YaAzdlR5CLq2zZEnGtHcufwCqEygAYzpYYOgNqrRINfw2KKQdEe+aGJmBlB73cb
         F+qSUA96Rp2FdQ4pVAKXHZ2NSqwE5y71lhZCF6QA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Inki Dae <inki.dae@samsung.com>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] drm/exynos: hdmi: Simplify with dev_err_probe()
Date:   Wed, 26 Aug 2020 16:55:13 +0200
Message-Id: <20200826145513.10657-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200826145513.10657-1-krzk@kernel.org>
References: <20200826145513.10657-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and also it prints the error value.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index c5ba32fca5f3..dc01c188c0e0 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -1797,11 +1797,8 @@ static int hdmi_resources_init(struct hdmi_context *hdata)
 		hdata->regul_bulk[i].supply = supply[i];
 
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(supply), hdata->regul_bulk);
-	if (ret) {
-		if (ret != -EPROBE_DEFER)
-			DRM_DEV_ERROR(dev, "failed to get regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
 	hdata->reg_hdmi_en = devm_regulator_get_optional(dev, "hdmi-en");
 
-- 
2.17.1

