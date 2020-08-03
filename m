Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE74CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DAE2076E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 13:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgHCNlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 09:41:44 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59932 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727050AbgHCNln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 09:41:43 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 8313DBA214502E009910;
        Mon,  3 Aug 2020 21:41:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.487.0; Mon, 3 Aug 2020 21:41:30 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <gregkh@linuxfoundation.org>, <saiprakash.ranjan@codeaurora.org>,
        <suzuki.poulose@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] coresight: etm4x: Modify core-commit of cpu to avoid the overflow of HiSilicon ETM
Date:   Mon, 3 Aug 2020 21:40:42 +0800
Message-ID: <1596462042-28026-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When too much trace information is generated on-chip, the ETM will
overflow, and may cause data loss. This is a common phenomenon on
ETM devices.

But sometimes we do not want to lose any performance trace data, so
we suppress the speed of instructions sent from CPU core to ETM to
avoid the overflow of ETM.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 4a4f0bd..ca9fb11 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -43,6 +43,11 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
 #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
 #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */

+#define CORE_COMMIT_CLEAR	0x3000
+#define CORE_COMMIT_SHIFT	12
+#define HISI_ETM_AMBA_ID_V1	0x000b6d01
+#define HISI_ETM_AMBA_ID_V2	0x000b6d02
+
 static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
 module_param(pm_save_enable, int, 0444);
 MODULE_PARM_DESC(pm_save_enable,
@@ -104,11 +109,41 @@ struct etm4_enable_arg {
 	int rc;
 };

+static void etm4_cpu_actlr1_cfg(void *info)
+{
+	struct etm4_enable_arg *arg = (struct etm4_enable_arg *)info;
+	u64 val;
+
+	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
+	val &= ~CORE_COMMIT_CLEAR;
+	val |= arg->rc << CORE_COMMIT_SHIFT;
+	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
+}
+
+static void etm4_config_core_commit(int cpu, int val)
+{
+	struct etm4_enable_arg arg = {0};
+
+	arg.rc = val;
+	smp_call_function_single(cpu, etm4_cpu_actlr1_cfg, &arg, 1);
+}
+
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
+	struct amba_device *adev;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;
+	struct device *dev = drvdata->csdev->dev.parent;
+
+	adev = container_of(dev, struct amba_device, dev);
+	/*
+	 * If ETM device is HiSilicon ETM device, reduce the
+	 * core-commit to avoid ETM overflow.
+	 */
+	if (adev->periphid == HISI_ETM_AMBA_ID_V1 ||
+	    adev->periphid == HISI_ETM_AMBA_ID_V2)
+		etm4_config_core_commit(drvdata->cpu, 1);

 	CS_UNLOCK(drvdata->base);

@@ -469,11 +504,22 @@ static int etm4_enable(struct coresight_device *csdev,
 static void etm4_disable_hw(void *info)
 {
 	u32 control;
+	struct amba_device *adev;
 	struct etmv4_drvdata *drvdata = info;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;
+	struct device *dev = drvdata->csdev->dev.parent;
 	int i;

+	adev = container_of(dev, struct amba_device, dev);
+	/*
+	 * If ETM device is HiSilicon ETM device, resume the
+	 * core-commit after ETM trace is complete.
+	 */
+	if (adev->periphid == HISI_ETM_AMBA_ID_V1 ||
+	    adev->periphid == HISI_ETM_AMBA_ID_V2)
+		etm4_config_core_commit(drvdata->cpu, 0);
+
 	CS_UNLOCK(drvdata->base);

 	/* power can be removed from the trace unit now */
--
2.8.1

