Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C2BC33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C61A24670
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 20:25:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgANUZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 15:25:53 -0500
Received: from inva021.nxp.com ([92.121.34.21]:53258 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726491AbgANUZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 15:25:52 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id A94A42011F5;
        Tue, 14 Jan 2020 21:25:50 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 992D12004E0;
        Tue, 14 Jan 2020 21:25:50 +0100 (CET)
Received: from fsr-ub1864-112.ea.freescale.net (fsr-ub1864-112.ea.freescale.net [10.171.82.98])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 1A89420563;
        Tue, 14 Jan 2020 21:25:50 +0100 (CET)
From:   Leonard Crestez <leonard.crestez@nxp.com>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Will Deacon <will@kernel.org>
Cc:     Frank Li <frank.li@nxp.com>, Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] perf/imx_ddr: Fix cpu hotplug state cleanup
Date:   Tue, 14 Jan 2020 22:25:46 +0200
Message-Id: <ed960d212fb6bec383c7cdfc73362e5770bda9cd.1579033493.git.leonard.crestez@nxp.com>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver allocates a dynamic cpu hotplug state but never releases it.
If reloaded in a loop it will quickly trigger a WARN message:

	"No more dynamic states available for CPU hotplug"

Fix by calling cpuhp_remove_multi_state on remove like several other
perf pmu drivers.

Also fix the cleanup logic on probe error paths: add the missing
cpuhp_remove_multi_state call and properly check the return value from
cpuhp_state_add_instant_nocalls.

Fixes: 9a66d36cc7ac ("drivers/perf: imx_ddr: Add DDR performance counter support to perf")
Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

---

Changes since v1:
* Handle cpuhp_state_add_instant_nocalls error with additional error
labels.
Link to v1: https://patchwork.kernel.org/patch/11302423/
---
 drivers/perf/fsl_imx8_ddr_perf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 3be61be1ba91..f144f1fd9b4d 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -631,17 +631,21 @@ static int ddr_perf_probe(struct platform_device *pdev)
 				      NULL,
 				      ddr_perf_offline_cpu);
 
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
 	if (irq < 0) {
 		dev_err(&pdev->dev, "Failed to get irq: %d", irq);
@@ -672,23 +676,25 @@ static int ddr_perf_probe(struct platform_device *pdev)
 		goto ddr_perf_err;
 
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
 }
 
 static int ddr_perf_remove(struct platform_device *pdev)
 {
 	struct ddr_pmu *pmu = platform_get_drvdata(pdev);
 
 	cpuhp_state_remove_instance_nocalls(pmu->cpuhp_state, &pmu->node);
+	cpuhp_remove_multi_state(pmu->cpuhp_state);
 	irq_set_affinity_hint(pmu->irq, NULL);
 
 	perf_pmu_unregister(&pmu->pmu);
 
 	ida_simple_remove(&ddr_ida, pmu->id);
-- 
2.17.1

