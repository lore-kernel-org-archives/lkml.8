Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B25CC2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65B9220848
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 17:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581703128;
	bh=Oq3imaSnvk3qp2sKFwj8TW2fh3DxiGumyaDniiv4fZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FAGZuOfFrYZlKly7f5Id1gN5nHMgNvFb7r0iXBlKrb/risdKSRLirbYtLg3S1s1r7
	 UOELeEfesJCZ+PxYdUR0E8u8MPNwZH27045AXjdnIXtkmvOLMwcoq2khRKP9WdolkZ
	 u8reWBHEWZjZA8njEd9/X4exmRSZWtrM/nloVepg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388064AbgBNP47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 10:56:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:38718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387960AbgBNP4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 10:56:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A68002187F;
        Fri, 14 Feb 2020 15:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695803;
        bh=Oq3imaSnvk3qp2sKFwj8TW2fh3DxiGumyaDniiv4fZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zkj1vR1x/PYwrmfz2CygT9BuDX5T+Gtijp6QC9cT3/Mow0PeofPGMeVaaRs4n+mJC
         LAHYfKVpmFkjI4eulEtRM/czScXs5Y3N1rMe56v6pQZdiu9YBn9zrKwmxsy8AY/O2z
         PFqeq2VrXPYLQoaboyQgELuEA6vyrUUVk4rDgw1Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leonard Crestez <leonard.crestez@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Will Deacon <will@kernel.org>, Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.5 363/542] perf/imx_ddr: Fix cpu hotplug state cleanup
Date:   Fri, 14 Feb 2020 10:45:55 -0500
Message-Id: <20200214154854.6746-363-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leonard Crestez <leonard.crestez@nxp.com>

[ Upstream commit 9ee68b314e9aa63ed11b98beb8a68810b8234dcf ]

This driver allocates a dynamic cpu hotplug state but never releases it.
If reloaded in a loop it will quickly trigger a WARN message:

	"No more dynamic states available for CPU hotplug"

Fix by calling cpuhp_remove_multi_state on remove like several other
perf pmu drivers.

Also fix the cleanup logic on probe error paths: add the missing
cpuhp_remove_multi_state call and properly check the return value from
cpuhp_state_add_instant_nocalls.

Fixes: 9a66d36cc7ac ("drivers/perf: imx_ddr: Add DDR performance counter support to perf")
Acked-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 55083c67b2bb0..95dca2cb52650 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -633,13 +633,17 @@ static int ddr_perf_probe(struct platform_device *pdev)
 
 	if (ret < 0) {
 		dev_err(&pdev->dev, "cpuhp_setup_state_multi failed\n");
-		goto ddr_perf_err;
+		goto cpuhp_state_err;
 	}
 
 	pmu->cpuhp_state = ret;
 
 	/* Register the pmu instance for cpu hotplug */
-	cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	ret = cpuhp_state_add_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	if (ret) {
+		dev_err(&pdev->dev, "Error %d registering hotplug\n", ret);
+		goto cpuhp_instance_err;
+	}
 
 	/* Request irq */
 	irq = of_irq_get(np, 0);
@@ -673,9 +677,10 @@ static int ddr_perf_probe(struct platform_device *pdev)
 	return 0;
 
 ddr_perf_err:
-	if (pmu->cpuhp_state)
-		cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
-
+	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+cpuhp_instance_err:
+	cpuhp_remove_multi_state(pmu->cpuhp_state);
+cpuhp_state_err:
 	ida_simple_remove(&ddr_ida, pmu->id);
 	dev_warn(&pdev->dev, "i.MX8 DDR Perf PMU failed (%d), disabled\n", ret);
 	return ret;
@@ -686,6 +691,7 @@ static int ddr_perf_remove(struct platform_device *pdev)
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	cpuhp_remove_multi_state(pmu->cpuhp_state);
 	irq_set_affinity_hint(pmu->irq, NULL);
 
 	perf_pmu_unregister(&pmu->pmu);
-- 
2.20.1

