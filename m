Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1788BC4345D
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B83A21508
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 15:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389190AbgEMPAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 11:00:21 -0400
Received: from v6.sk ([167.172.42.174]:54028 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389176AbgEMPAS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 11:00:18 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id D41E6610D7;
        Wed, 13 May 2020 15:00:16 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 3/3] drm/etnaviv: Simplify clock enable/disable
Date:   Wed, 13 May 2020 17:00:07 +0200
Message-Id: <20200513150007.1315395-4-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200513150007.1315395-1-lkundrak@v3.sk>
References: <[PATCH 0/3] drm/etnaviv: Clock fixes>
 <20200513150007.1315395-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the NULL checks are pointless, clk_*() routines already deal with NULL
just fine.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 53 ++++++++++-----------------
 1 file changed, 19 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index e7dbb924f576..f5b95cb4f058 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1487,55 +1487,40 @@ static int etnaviv_gpu_clk_enable(struct etnaviv_gpu *gpu)
 {
 	int ret;
 
-	if (gpu->clk_reg) {
-		ret = clk_prepare_enable(gpu->clk_reg);
-		if (ret)
-			return ret;
-	}
+	ret = clk_prepare_enable(gpu->clk_reg);
+	if (ret)
+		return ret;
 
-	if (gpu->clk_bus) {
-		ret = clk_prepare_enable(gpu->clk_bus);
-		if (ret)
-			goto disable_clk_reg;
-	}
+	ret = clk_prepare_enable(gpu->clk_bus);
+	if (ret)
+		goto disable_clk_reg;
 
-	if (gpu->clk_core) {
-		ret = clk_prepare_enable(gpu->clk_core);
-		if (ret)
-			goto disable_clk_bus;
-	}
+	ret = clk_prepare_enable(gpu->clk_core);
+	if (ret)
+		goto disable_clk_bus;
 
-	if (gpu->clk_shader) {
-		ret = clk_prepare_enable(gpu->clk_shader);
-		if (ret)
-			goto disable_clk_core;
-	}
+	ret = clk_prepare_enable(gpu->clk_shader);
+	if (ret)
+		goto disable_clk_core;
 
 	return 0;
 
 disable_clk_core:
-	if (gpu->clk_core)
-		clk_disable_unprepare(gpu->clk_core);
+	clk_disable_unprepare(gpu->clk_core);
 disable_clk_bus:
-	if (gpu->clk_bus)
-		clk_disable_unprepare(gpu->clk_bus);
+	clk_disable_unprepare(gpu->clk_bus);
 disable_clk_reg:
-	if (gpu->clk_reg)
-		clk_disable_unprepare(gpu->clk_reg);
+	clk_disable_unprepare(gpu->clk_reg);
 
 	return ret;
 }
 
 static int etnaviv_gpu_clk_disable(struct etnaviv_gpu *gpu)
 {
-	if (gpu->clk_shader)
-		clk_disable_unprepare(gpu->clk_shader);
-	if (gpu->clk_core)
-		clk_disable_unprepare(gpu->clk_core);
-	if (gpu->clk_bus)
-		clk_disable_unprepare(gpu->clk_bus);
-	if (gpu->clk_reg)
-		clk_disable_unprepare(gpu->clk_reg);
+	clk_disable_unprepare(gpu->clk_shader);
+	clk_disable_unprepare(gpu->clk_core);
+	clk_disable_unprepare(gpu->clk_bus);
+	clk_disable_unprepare(gpu->clk_reg);
 
 	return 0;
 }
-- 
2.26.2

