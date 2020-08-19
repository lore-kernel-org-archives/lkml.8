Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FBC4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A5E2067C
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726685AbgHSIIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:08:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51614 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726211AbgHSIHo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:07:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 6F9F573DCBE657F3034D;
        Wed, 19 Aug 2020 16:07:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Wed, 19 Aug 2020 16:07:33 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <gregkh@linuxfoundation.org>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <mike.leach@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2] coresight: etm4x: Modify core-commit of cpu to avoid the overflow of HiSilicon ETM
Date:   Wed, 19 Aug 2020 16:06:37 +0800
Message-ID: <1597824397-29894-1-git-send-email-liuqi115@huawei.com>
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
overflow, and cause data loss. This is a common phenomenon on ETM
devices.

But sometimes we do not want to lose performance trace data, so we
suppress the speed of instructions sent from CPU core to ETM to
avoid the overflow of ETM.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---

Changes since v1:
- ETM on HiSilicon Hip09 platform supports backpressure, so does
not need to modify core commit.

 drivers/hwtracing/coresight/coresight-etm4x.c | 43 +++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 7797a57..7641f89 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -43,6 +43,10 @@ MODULE_PARM_DESC(boot_enable, "Enable tracing on boot");
 #define PARAM_PM_SAVE_NEVER	  1 /* never save any state */
 #define PARAM_PM_SAVE_SELF_HOSTED 2 /* save self-hosted state only */

+#define CORE_COMMIT_CLEAR	0x3000
+#define CORE_COMMIT_SHIFT	12
+#define HISI_ETM_AMBA_ID_V1	0x000b6d01
+
 static int pm_save_enable = PARAM_PM_SAVE_FIRMWARE;
 module_param(pm_save_enable, int, 0444);
 MODULE_PARM_DESC(pm_save_enable,
@@ -104,11 +108,40 @@ struct etm4_enable_arg {
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
+	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
+		etm4_config_core_commit(drvdata->cpu, 1);

 	CS_UNLOCK(drvdata->base);

@@ -472,10 +505,20 @@ static void etm4_disable_hw(void *info)
 {
 	u32 control;
 	struct etmv4_drvdata *drvdata = info;
+	struct device *dev = drvdata->csdev->dev.parent;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;
+	struct amba_device *adev;
 	int i;

+	adev = container_of(dev, struct amba_device, dev);
+	/*
+	 * If ETM device is HiSilicon ETM device, resume the
+	 * core-commit after ETM trace is complete.
+	 */
+	if (adev->periphid == HISI_ETM_AMBA_ID_V1)
+		etm4_config_core_commit(drvdata->cpu, 0);
+
 	CS_UNLOCK(drvdata->base);

 	if (!drvdata->skip_power_up) {
--
2.8.1

