Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD0EC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB04A207CD
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbgGVRV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:26 -0400
Received: from foss.arm.com ([217.140.110.172]:60022 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732001AbgGVRVI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:21:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E3A9F31B;
        Wed, 22 Jul 2020 10:21:07 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0A3AA3F66F;
        Wed, 22 Jul 2020 10:21:06 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 11/14] coresight: etm4x: Detect system register access support
Date:   Wed, 22 Jul 2020 18:20:37 +0100
Message-Id: <20200722172040.1299289-12-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check if the etm4x supports system register access and use
it instead of the memory mapped IO.

We need to detect that :
 a) The CPU implements system register access to the Trace unit
	AND
 b) The trace unit is an ETMv4.x component.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm4x.c | 76 +++++++++++++++----
 drivers/hwtracing/coresight/coresight-etm4x.h | 16 ++++
 2 files changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index 776a59f62710..831206f7f306 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -19,6 +19,7 @@
 #include <linux/clk.h>
 #include <linux/cpu.h>
 #include <linux/cpu_pm.h>
+#include <linux/cpumask.h>
 #include <linux/coresight.h>
 #include <linux/coresight-pmu.h>
 #include <linux/pm_wakeup.h>
@@ -1507,9 +1508,43 @@ static void etm4_pm_clear(void)
 	}
 }
 
+static inline bool trace_unit_is_etmv4(u32 devarch)
+{
+	return (devarch & ETM_DEVARCH_ID_MASK) == ETM_DEVARCH_ETMv4x_ARCH;
+}
+
+static void etm4_check_sysreg_access(void *arg)
+{
+	bool *status = arg;
+	u32 devarch;
+
+	if (!arch_cpu_supports_sysreg_trace()) {
+		*status = false;
+		return;
+	}
+
+	devarch = read_etm4x_sysreg_const_offset(TRCDEVARCH);
+	if (!trace_unit_is_etmv4(devarch)) {
+		*status = false;
+		return;
+	}
+
+	*status = true;
+}
+
+static bool etm4_cpu_supports_sysreg(int cpu)
+{
+	bool sys_reg_support = false;
+
+	smp_call_function_single(cpu, etm4_check_sysreg_access, &sys_reg_support, 1);
+
+	return sys_reg_support;
+}
+
 static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 {
-	int ret;
+	int ret, cpu;
+	bool sys_reg = false;
 	void __iomem *base;
 	struct device *dev = &adev->dev;
 	struct coresight_platform_data *pdata = NULL;
@@ -1517,10 +1552,17 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	struct resource *res = &adev->res;
 	struct coresight_desc desc = { 0 };
 
+	cpu = coresight_get_cpu(dev);
+	if (cpu < 0 || !cpu_online(cpu))
+		return -EPROBE_DEFER;
+
+	sys_reg = etm4_cpu_supports_sysreg(cpu);
+
 	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
 	if (!drvdata)
 		return -ENOMEM;
 
+	drvdata->cpu = cpu;
 	dev_set_drvdata(dev, drvdata);
 
 	if (pm_save_enable == PARAM_PM_SAVE_FIRMWARE)
@@ -1537,26 +1579,30 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	if (fwnode_property_present(dev_fwnode(dev), "qcom,skip-power-up"))
 		drvdata->skip_power_up = true;
 
-	/* Validity for the resource is already checked by the AMBA core */
-	base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	drvdata->base = base;
-	desc.access.base = base;
+	if (sys_reg) {
+		desc.access = (struct csdev_access){
+			.no_iomem = true,
+			.read = etm4x_sysreg_read,
+			.write = etm4x_sysreg_write,
+		};
+	} else {
+		/* Validity for the resource is already checked by the AMBA core */
+		base = devm_ioremap_resource(dev, res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+
+		drvdata->base = base;
+		desc.access.base = base;
+	}
 
 	spin_lock_init(&drvdata->spinlock);
 
-	drvdata->cpu = coresight_get_cpu(dev);
-	if (drvdata->cpu < 0)
-		return drvdata->cpu;
-
 	desc.name = devm_kasprintf(dev, GFP_KERNEL, "etm%d", drvdata->cpu);
 	if (!desc.name)
 		return -ENOMEM;
 
 	cpus_read_lock();
-	etmdrvdata[drvdata->cpu] = drvdata;
+	etmdrvdata[cpu] = drvdata;
 
 	if (smp_call_function_single(drvdata->cpu,
 				etm4_init_arch_data,  &desc.access, 1))
@@ -1607,6 +1653,8 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	pm_runtime_put(&adev->dev);
 	dev_info(&drvdata->csdev->dev, "CPU%d: ETM v%d.%d initialized\n",
 		 drvdata->cpu, drvdata->arch >> 4, drvdata->arch & 0xf);
+	if (sys_reg)
+		dev_info(&drvdata->csdev->dev, "Using system register accesses\n");
 
 	if (boot_enable) {
 		coresight_enable(drvdata->csdev);
@@ -1616,7 +1664,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 	return 0;
 
 err_arch_supported:
-	etmdrvdata[drvdata->cpu] = NULL;
+	etmdrvdata[cpu] = NULL;
 	etm4_pm_clear();
 	return ret;
 }
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.h b/drivers/hwtracing/coresight/coresight-etm4x.h
index ab3d1c195387..86fdcbafc895 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.h
+++ b/drivers/hwtracing/coresight/coresight-etm4x.h
@@ -152,6 +152,13 @@
 #define write_etm4x_sysreg_const_offset(val, offset)		\
 	WRITE_ETM4x_REG(val, ETM4x_OFFSET_TO_REG(offset))
 
+static inline bool arch_cpu_supports_sysreg_trace(void)
+{
+	u64 dfr0 = read_sysreg_s(SYS_ID_AA64DFR0_EL1);
+
+	return ((dfr0 >> ID_AA64DFR0_TRACEVER_SHIFT) & 0xfUL) > 0;
+}
+
 #elif defined(CONFIG_ARM)
 
 #include <asm/hardware/cp14.h>
@@ -172,6 +179,15 @@
 #define write_etm4x_sysreg_const_offset(val, offset)		\
 	WRITE_ETM4x_REG(val, ETM4x_OFFSET_TO_REG(offset))
 
+#define ID_DFR0_CopTrc_SHIFT	12
+static inline bool arch_cpu_supports_sysreg_trace(void)
+{
+	u32 dfr0;
+
+	asm volatile("mrc p15, 0, %0, c0, c1, 2" : "=r" (dfr0));
+
+	return ((dfr0 >> ID_DFR0_CopTrc_SHIFT) & 0xfUL) > 0;
+}
 #endif
 
 #define CASE_READ(res, x)					\
-- 
2.24.1

