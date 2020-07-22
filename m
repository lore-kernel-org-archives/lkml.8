Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63C15C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A51420781
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732221AbgGVRVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:20 -0400
Received: from foss.arm.com ([217.140.110.172]:60046 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729000AbgGVRVJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 069361478;
        Wed, 22 Jul 2020 10:21:09 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 222703F66F;
        Wed, 22 Jul 2020 10:21:08 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 12/14] coresight: etm4x: Refactor probing routine
Date:   Wed, 22 Jul 2020 18:20:38 +0100
Message-Id: <20200722172040.1299289-13-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CoreSight ETM with system register access may not have a
memory mapped i/o access. Refactor the ETM specific probing
into a common routine to allow reusing the code for such ETMs.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 64 ++++++++++++-------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 831206f7f306..e91af23ac419 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1541,27 +1541,43 @@ static bool etm4_cpu_supports_sysreg(int cpu)
 	return sys_reg_support;
 }
 
-static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
+static int etm4_probe_common(struct device *dev, void __iomem *base)
 {
 	int ret, cpu;
 	bool sys_reg = false;
-	void __iomem *base;
-	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
 	struct etmv4_drvdata *drvdata;
-	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
+	cpu = coresight_get_cpu(dev);
+	if (cpu < 0)
+		return cpu;
+
 	cpu = coresight_get_cpu(dev);
 	if (cpu < 0 || !cpu_online(cpu))
 		return -EPROBE_DEFER;
 
 	sys_reg = etm4_cpu_supports_sysreg(cpu);
+	if (sys_reg) {
+		desc.access = (struct csdev_access){
+			.no_iomem = true,
+			.read = etm4x_sysreg_read,
+			.write = etm4x_sysreg_write,
+		};
+	} else if (base) {
+		desc.access.base = base;
+	} else {
+		dev_crit(dev, "etm4x: Unable to detect access\n");
+		return -ENODEV;
+	}
+
+
 
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->base = base;
 	drvdata->cpu = cpu;
 	dev_set_drvdata(dev, drvdata);
 
@@ -1579,22 +1595,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
 
-	if (sys_reg) {
-		desc.access = (struct csdev_access){
-			.no_iomem = true,
-			.read = etm4x_sysreg_read,
-			.write = etm4x_sysreg_write,
-		};
-	} else {
-		/* Validity for the resource is already checked by the AMBA core */
-		base = devm_ioremap_resource(dev, res);
-		if (IS_ERR(base))
-			return PTR_ERR(base);
-
-		drvdata->base = base;
-		desc.access.base = base;
-	}
-
 	spin_lock_init(&drvdata->spinlock);
 
 	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
@@ -1630,7 +1630,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		ret = PTR_ERR(pdata);
 		goto err_arch_supported;
 	}
-	adev->dev.platform_data = pdata;
+	dev->platform_data = pdata;
 
 	desc.type = CORESIGHT_DEV_TYPE_SOURCE;
 	desc.subtype.source_subtype = CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
@@ -1650,7 +1650,6 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		goto err_arch_supported;
 	}
 
-	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
 	if (sys_reg)
@@ -1669,6 +1668,25 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return ret;
 }
 
+static int etm4_probe_amba(struct amba_device *adev, const struct amba_id *id)
+{
+	void __iomem *base;
+	struct device *dev = &adev->dev;
+	struct resource *res = &adev->res;
+	int ret;
+
+	/* Validity for the resource is already checked by the AMBA core */
+	base = devm_ioremap_resource(dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = etm4_probe_common(dev, base);
+	if (!ret)
+		pm_runtime_put(&adev->dev);
+
+	return ret;
+}
+
 static struct amba_cs_uci_id uci_id_etm4[] = {
 	{
 		/*  ETMv4 UCI data */
@@ -1700,7 +1718,7 @@ static struct amba_driver etm4x_driver = {
 		.name   = "coresight-etm4x",
 		.suppress_bind_attrs = true,
 	},
-	.probe		= etm4_probe,
+	.probe		= etm4_probe_amba,
 	.id_table	= etm4_ids,
 };
 builtin_amba_driver(etm4x_driver);
-- 
2.24.1

