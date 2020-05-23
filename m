Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E9CFC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 10:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 479CA2071C
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 10:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731306AbgEWKmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 06:42:20 -0400
Received: from v6.sk ([167.172.42.174]:40074 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731237AbgEWKmR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 06:42:17 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id B8966610CD;
        Sat, 23 May 2020 10:41:45 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     Russell King <linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH v2 2/4] drm/etnaviv: Don't ignore errors on getting clocks
Date:   Sat, 23 May 2020 12:41:35 +0200
Message-Id: <20200523104137.12562-3-lkundrak@v3.sk>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523104137.12562-1-lkundrak@v3.sk>
References: <20200523104137.12562-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There might be good reasons why the getting a clock failed. To treat the
clocks as optional we're specifically only interested in ignoring -ENOENT,
and devm_clk_get_optional() does just that.

Note that this preserves the original behavior of all clocks being
optional. The binding document mandates the "bus" clock while the dove
machine only specifies "core".

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

---
Changes since v1:
- Fix the actual return value
---
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
index c6dacfe3d321..f303172c091d 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_gpu.c
@@ -1786,26 +1786,26 @@ static int etnaviv_gpu_platform_probe(struct platform_device *pdev)
 	}
 
 	/* Get Clocks: */
-	gpu->clk_reg = devm_clk_get(&pdev->dev, "reg");
+	gpu->clk_reg = devm_clk_get_optional(&pdev->dev, "reg");
 	DBG("clk_reg: %p", gpu->clk_reg);
 	if (IS_ERR(gpu->clk_reg))
-		gpu->clk_reg = NULL;
+		return PTR_ERR(gpu->clk_reg);
 
-	gpu->clk_bus = devm_clk_get(&pdev->dev, "bus");
+	gpu->clk_bus = devm_clk_get_optional(&pdev->dev, "bus");
 	DBG("clk_bus: %p", gpu->clk_bus);
 	if (IS_ERR(gpu->clk_bus))
-		gpu->clk_bus = NULL;
+		return PTR_ERR(gpu->clk_bus);
 
-	gpu->clk_core = devm_clk_get(&pdev->dev, "core");
+	gpu->clk_core = devm_clk_get_optional(&pdev->dev, "core");
 	DBG("clk_core: %p", gpu->clk_core);
 	if (IS_ERR(gpu->clk_core))
-		gpu->clk_core = NULL;
+		return PTR_ERR(gpu->clk_core);
 	gpu->base_rate_core = clk_get_rate(gpu->clk_core);
 
-	gpu->clk_shader = devm_clk_get(&pdev->dev, "shader");
+	gpu->clk_shader = devm_clk_get_optional(&pdev->dev, "shader");
 	DBG("clk_shader: %p", gpu->clk_shader);
 	if (IS_ERR(gpu->clk_shader))
-		gpu->clk_shader = NULL;
+		return PTR_ERR(gpu->clk_shader);
 	gpu->base_rate_shader = clk_get_rate(gpu->clk_shader);
 
 	/* TODO: figure out max mapped size */
-- 
2.26.2

