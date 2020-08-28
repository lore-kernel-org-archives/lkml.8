Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5515C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D45720825
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598629106;
	bh=rz+YnW/NU1w7RBHrnA+Vdo53RMowxauy6+hc7EkPeBw=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=AOUv4vC62vPGVQGY9PgEJE3mA2ZEiHjW5yYTM5RAOugW1NxltG8axEpxFMoeSC7nA
	 TFaBgW5T1K0H0dXYQUDgGE1UEhceR8bVNJHGAhr54T0htTyaOwlnpm5STR/z/3mdOW
	 dYo74P2jvevnkDAVdepwC3CRb9R/pb+pWzVtL+G8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728164AbgH1PiT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:38:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:45100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726321AbgH1Ph5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:37:57 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1158208FE;
        Fri, 28 Aug 2020 15:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598629077;
        bh=rz+YnW/NU1w7RBHrnA+Vdo53RMowxauy6+hc7EkPeBw=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=RaOWpqbCF//gU0W3Oxad24QDE98DGFLI3m0uxEgchtqQW7iHq45gGFlf2wgmmRTmg
         qXD08AbJkBZflYJyGVkcN5+ymNT3X774q5SVqOw0WtOdOpkP/s73yH07iSVQ02NoIu
         ohzZNPzJeDCUhTtXbcJlL1XliSafKc7kryECVmeo=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH 2/2] memory: tegra186-emc: Simplify with dev_err_probe()
Date:   Fri, 28 Aug 2020 17:37:47 +0200
Message-Id: <20200828153747.22358-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828153747.22358-1-krzk@kernel.org>
References: <20200828153747.22358-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Common pattern of handling deferred probe can be simplified with
dev_err_probe().  Less code and the error value gets printed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/memory/tegra/tegra186-emc.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/memory/tegra/tegra186-emc.c b/drivers/memory/tegra/tegra186-emc.c
index 8478f59db432..fa8af17b0e2d 100644
--- a/drivers/memory/tegra/tegra186-emc.c
+++ b/drivers/memory/tegra/tegra186-emc.c
@@ -172,14 +172,8 @@ static int tegra186_emc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	emc->bpmp = tegra_bpmp_get(&pdev->dev);
-	if (IS_ERR(emc->bpmp)) {
-		err = PTR_ERR(emc->bpmp);
-
-		if (err != -EPROBE_DEFER)
-			dev_err(&pdev->dev, "failed to get BPMP: %d\n", err);
-
-		return err;
-	}
+	if (IS_ERR(emc->bpmp))
+		return dev_err_probe(&pdev->dev, PTR_ERR(emc->bpmp), "failed to get BPMP\n");
 
 	emc->clk = devm_clk_get(&pdev->dev, "emc");
 	if (IS_ERR(emc->clk)) {
-- 
2.17.1

