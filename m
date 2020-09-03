Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E2FC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A632206EB
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 11:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbgICLxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 07:53:34 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728737AbgICLi1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 07:38:27 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 034C48D1C9FB848B0584;
        Thu,  3 Sep 2020 19:38:26 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.487.0; Thu, 3 Sep 2020 19:38:17 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <Al.Grant@arm.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] coresight: etm4x: Modify core-commit of cpu to avoid the overflow of HiSilicon ETM
Date:   Thu, 3 Sep 2020 19:37:14 +0800
Message-ID: <1599133034-38747-1-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ETM device can't keep up with the core pipeline when cpu core
is at full speed. This may cause overflow within core and its ETM.
This is a common phenomenon on ETM devices.

On HiSilicon Hip08 platform, a specific feature is added to set
core pipeline. So commit rate can be reduced manually to avoid ETM
overflow.

Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
link of the RFC patch:
https://lore.kernel.org/linux-arm-kernel/1597824397-29894-1-git-send-email-liuqi115@huawei.com/

drivers/hwtracing/coresight/coresight-etm4x.c | 46 +++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 7bcac88..5833be1 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -45,6 +45,10 @@ static int etm4_set_event_filters(struct etmv4_drvdata *drvdata,

 static enum cpuhp_state hp_online;

+#define HISI_HIP08_CORE_COMMIT_CLEAR	0x3000
+#define HISI_HIP08_CORE_COMMIT_SHIFT	12
+#define HISI_HIP08_ETM_ID		0x000b6d01
+
 static void etm4_os_unlock(struct etmv4_drvdata *drvdata)
 {
 	/* Writing any value to ETMOSLAR unlocks the trace registers */
@@ -84,12 +88,38 @@ struct etm4_enable_arg {
 	int rc;
 };

+static void etm4_hisi_config_core_commit(int flag)
+{
+	u64 val;
+
+	asm volatile("mrs %0,s3_1_c15_c2_5" : "=r"(val));
+	val &= ~HISI_HIP08_CORE_COMMIT_CLEAR;
+	val |= flag << HISI_HIP08_CORE_COMMIT_SHIFT;
+	asm volatile("msr s3_1_c15_c2_5,%0" : : "r"(val));
+}
+
+static void etm4_enable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+	struct device *dev = drvdata->csdev->dev.parent;
+	struct amba_device *adev;
+
+	adev = container_of(dev, struct amba_device, dev);
+
+	/*
+	 * If ETM device is HiSilicon ETM device, reduce the
+	 * core-commit to avoid ETM overflow.
+	 */
+	if (adev->periphid == HISI_HIP08_ETM_ID)
+		etm4_hisi_config_core_commit(1);
+}
+
 static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 {
 	int i, rc;
 	struct etmv4_config *config = &drvdata->config;
 	struct device *etm_dev = &drvdata->csdev->dev;

+	etm4_enable_arch_specific(drvdata);
 	CS_UNLOCK(drvdata->base);

 	etm4_os_unlock(drvdata);
@@ -436,11 +466,27 @@ static int etm4_enable(struct coresight_device *csdev,
 	return ret;
 }

+static void etm4_disable_arch_specific(struct etmv4_drvdata *drvdata)
+{
+	struct device *dev = drvdata->csdev->dev.parent;
+	struct amba_device *adev;
+
+	adev = container_of(dev, struct amba_device, dev);
+
+	/*
+	 * If ETM device is HiSilicon ETM device, resume the
+	 * core-commit after ETM trace is complete.
+	 */
+	if (adev->periphid == HISI_HIP08_ETM_ID)
+		etm4_hisi_config_core_commit(0);
+}
+
 static void etm4_disable_hw(void *info)
 {
 	u32 control;
 	struct etmv4_drvdata *drvdata = info;

+	etm4_disable_arch_specific(drvdata);
 	CS_UNLOCK(drvdata->base);

 	/* power can be removed from the trace unit now */
--
2.8.1

