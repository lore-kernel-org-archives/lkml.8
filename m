Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B89EC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44039208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599059098;
	bh=UZsEqgnFpRCIfv/X8lhKedsjXG7tPysKFsM4O+5c1og=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Mno70J74geJhAHQW/X4XX6wjxGLTAskV6MEXvt6S8vNdmdl9OgwKfA2iYsgB2SGgy
	 5YgJ7CBBTLDVV3X4Q57SewwKR/zB8WgID6mGEsfAFIfhZJeGzLl5wrTFL1MatdGlj6
	 8r2rFXq4WDOVdnaNSy2PVY8dA3foT9T/r44T+uAo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727951AbgIBPEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:04:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:41758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726927AbgIBPEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:04:25 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9506721527;
        Wed,  2 Sep 2020 15:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599059065;
        bh=UZsEqgnFpRCIfv/X8lhKedsjXG7tPysKFsM4O+5c1og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pFq+pQYc6BCe2NtK7+Ig4Fdw+9S38KkYFXn8TIkEETbiabdtq0tgVHZ/k9Pw74Cqx
         PCf4+yC0vOzAjjqQrsEfJLtXDD9AgYzuRNQPSlXc2O+fJyET6GDcxzxobEXRbpeY3Y
         5jVIIsyW/+qgVU+p/Ns2ZuirTc5iI7Zhou59OcVo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        David Lechner <david@lechnology.com>,
        Sekhar Nori <nsekhar@ti.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 06/10] clk: keystone: Simplify with dev_err_probe()
Date:   Wed,  2 Sep 2020 17:03:44 +0200
Message-Id: <20200902150348.14465-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200902150348.14465-1-krzk@kernel.org>
References: <20200902150348.14465-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/keystone/syscon-clk.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/clk/keystone/syscon-clk.c b/drivers/clk/keystone/syscon-clk.c
index 5b3d36462174..12ddcbed00e4 100644
--- a/drivers/clk/keystone/syscon-clk.c
+++ b/drivers/clk/keystone/syscon-clk.c
@@ -102,12 +102,9 @@ static int ti_syscon_gate_clk_probe(struct platform_device *pdev)
 		return -EINVAL;
 
 	regmap = syscon_node_to_regmap(dev->of_node);
-	if (IS_ERR(regmap)) {
-		if (PTR_ERR(regmap) == -EPROBE_DEFER)
-			return -EPROBE_DEFER;
-		dev_err(dev, "failed to find parent regmap\n");
-		return PTR_ERR(regmap);
-	}
+	if (IS_ERR(regmap))
+		return dev_err_probe(dev, PTR_ERR(regmap),
+				     "failed to find parent regmap\n");
 
 	num_clks = 0;
 	for (p = data; p->name; p++)
-- 
2.17.1

