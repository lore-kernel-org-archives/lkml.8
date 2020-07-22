Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77F6C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 871C0207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 17:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgGVRVD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 13:21:03 -0400
Received: from foss.arm.com ([217.140.110.172]:59956 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730800AbgGVRU7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 13:20:59 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E840E1063;
        Wed, 22 Jul 2020 10:20:57 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0E0523F66F;
        Wed, 22 Jul 2020 10:20:56 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mike.leach@linaro.org,
        mathieu.poirier@linaro.org, coresight@lists.linaro.org,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 02/14] coresight: Introduce device access abstraction
Date:   Wed, 22 Jul 2020 18:20:28 +0100
Message-Id: <20200722172040.1299289-3-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200722172040.1299289-1-suzuki.poulose@arm.com>
References: <20200722172040.1299289-1-suzuki.poulose@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are about to introduce support for sysreg access to ETMv4.4+
component. Since there are generic routines that access the
registers (e.g, CS_LOCK/UNLOCK , claim/disclaim operations, timeout)
and in order to preserve the logic of these operations at a single place
we introduce an abstraction layer for the accesses to a given device.
This will also be helpful in consolidating the sysfs.attribute helpers,
that we define per driver.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 drivers/hwtracing/coresight/coresight-catu.c  |   1 +
 drivers/hwtracing/coresight/coresight-cti.c   |   1 +
 drivers/hwtracing/coresight/coresight-etb10.c |   1 +
 drivers/hwtracing/coresight/coresight-etm3x.c |   1 +
 drivers/hwtracing/coresight/coresight-etm4x.c |   1 +
 .../hwtracing/coresight/coresight-funnel.c    |   1 +
 .../coresight/coresight-replicator.c          |   1 +
 drivers/hwtracing/coresight/coresight-stm.c   |   1 +
 drivers/hwtracing/coresight/coresight-tmc.c   |   1 +
 drivers/hwtracing/coresight/coresight-tpiu.c  |   1 +
 drivers/hwtracing/coresight/coresight.c       |  49 ++++++
 include/linux/coresight.h                     | 156 ++++++++++++++++++
 12 files changed, 215 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
index 1801804a7762..6299ff7b8a14 100644
--- a/drivers/hwtracing/coresight/coresight-catu.c
+++ b/drivers/hwtracing/coresight/coresight-catu.c
@@ -551,6 +551,7 @@ static int catu_probe(struct amba_device *adev, const struct amba_id *id)
 	dev->platform_data = pdata;
 
 	drvdata->base = base;
+	catu_desc.access.base = base;
 	catu_desc.pdata = pdata;
 	catu_desc.dev = dev;
 	catu_desc.groups = catu_groups;
diff --git a/drivers/hwtracing/coresight/coresight-cti.c b/drivers/hwtracing/coresight/coresight-cti.c
index 3ccc703dc940..c810ea3ba155 100644
--- a/drivers/hwtracing/coresight/coresight-cti.c
+++ b/drivers/hwtracing/coresight/coresight-cti.c
@@ -865,6 +865,7 @@ static int cti_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
+	cti_desc.access.base = base;
 
 	dev_set_drvdata(dev, drvdata);
 
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 03e3f2590191..0f2735e15119 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -755,6 +755,7 @@ static int etb_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
+	desc.access.base = base;
 
 	spin_lock_init(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm3x.c b/drivers/hwtracing/coresight/coresight-etm3x.c
index bf22dcfd3327..7ddcb7fcb2d6 100644
--- a/drivers/hwtracing/coresight/coresight-etm3x.c
+++ b/drivers/hwtracing/coresight/coresight-etm3x.c
@@ -805,6 +805,7 @@ static int etm_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
+	desc.access.base = base;
 
 	spin_lock_init(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c b/drivers/hwtracing/coresight/coresight-etm4x.c
index cb83fb77ded6..7bb74c659c4f 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x.c
@@ -1501,6 +1501,7 @@ static int etm4_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
+	desc.access.base = base;
 
 	spin_lock_init(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-funnel.c b/drivers/hwtracing/coresight/coresight-funnel.c
index 900690a9f7f0..67fc3e3b77d8 100644
--- a/drivers/hwtracing/coresight/coresight-funnel.c
+++ b/drivers/hwtracing/coresight/coresight-funnel.c
@@ -242,6 +242,7 @@ static int funnel_probe(struct device *dev, struct resource *res)
 		}
 		drvdata->base = base;
 		desc.groups = coresight_funnel_groups;
+		desc.access.base = base;
 	}
 
 	dev_set_drvdata(dev, drvdata);
diff --git a/drivers/hwtracing/coresight/coresight-replicator.c b/drivers/hwtracing/coresight/coresight-replicator.c
index 78acf29c49ca..65704ada20a5 100644
--- a/drivers/hwtracing/coresight/coresight-replicator.c
+++ b/drivers/hwtracing/coresight/coresight-replicator.c
@@ -254,6 +254,7 @@ static int replicator_probe(struct device *dev, struct resource *res)
 		}
 		drvdata->base = base;
 		desc.groups = replicator_groups;
+		desc.access.base = base;
 	}
 
 	if (fwnode_property_present(dev_fwnode(dev),
diff --git a/drivers/hwtracing/coresight/coresight-stm.c b/drivers/hwtracing/coresight/coresight-stm.c
index 673d2f56ed1e..c8509cc78512 100644
--- a/drivers/hwtracing/coresight/coresight-stm.c
+++ b/drivers/hwtracing/coresight/coresight-stm.c
@@ -881,6 +881,7 @@ static int stm_probe(struct amba_device *adev, const struct amba_id *id)
 	if (IS_ERR(base))
 		return PTR_ERR(base);
 	drvdata->base = base;
+	desc.access.base = base;
 
 	ret = stm_get_stimulus_area(dev, &ch_res);
 	if (ret)
diff --git a/drivers/hwtracing/coresight/coresight-tmc.c b/drivers/hwtracing/coresight/coresight-tmc.c
index 7040d583bed9..b49795ad6861 100644
--- a/drivers/hwtracing/coresight/coresight-tmc.c
+++ b/drivers/hwtracing/coresight/coresight-tmc.c
@@ -458,6 +458,7 @@ static int tmc_probe(struct amba_device *adev, const struct amba_id *id)
 	}
 
 	drvdata->base = base;
+	desc.access.base = base;
 
 	spin_lock_init(&drvdata->spinlock);
 
diff --git a/drivers/hwtracing/coresight/coresight-tpiu.c b/drivers/hwtracing/coresight/coresight-tpiu.c
index f8583e4032a6..7ef7649f48ad 100644
--- a/drivers/hwtracing/coresight/coresight-tpiu.c
+++ b/drivers/hwtracing/coresight/coresight-tpiu.c
@@ -149,6 +149,7 @@ static int tpiu_probe(struct amba_device *adev, const struct amba_id *id)
 		return PTR_ERR(base);
 
 	drvdata->base = base;
+	desc.access.base = base;
 
 	/* Disable tpiu to support older devices */
 	tpiu_disable_hw(drvdata);
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e9c90f2de34a..38e9c03ab754 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -1387,6 +1387,54 @@ static int __init coresight_init(void)
 }
 postcore_initcall(coresight_init);
 
+u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
+{
+	return csdev_access_relaxed_read32(&csdev->access, offset);
+}
+
+u32 coresight_read32(struct coresight_device *csdev, u32 offset)
+{
+	return csdev_access_read32(&csdev->access, offset);
+}
+
+void coresight_relaxed_write32(struct coresight_device *csdev,
+			       u32 val,
+			       u32 offset)
+{
+
+	csdev_access_relaxed_write32(&csdev->access, val, offset);
+}
+
+
+void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
+{
+	csdev_access_write32(&csdev->access, val, offset);
+}
+
+u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset)
+{
+	return csdev_access_relaxed_read64(&csdev->access, offset);
+}
+
+u64 coresight_read64(struct coresight_device *csdev, u32 offset)
+{
+	return csdev_access_read64(&csdev->access, offset);
+}
+
+void coresight_relaxed_write64(struct coresight_device *csdev,
+			       u64 val,
+			       u32 offset)
+{
+
+	csdev_access_relaxed_write64(&csdev->access, val, offset);
+}
+
+
+void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
+{
+	csdev_access_write64(&csdev->access, val, offset);
+}
+
 /*
  * coresight_release_platform_data: Release references to the devices connected
  * to the output port of this device.
@@ -1451,6 +1499,7 @@ struct coresight_device *coresight_register(struct coresight_desc *desc)
 	csdev->type = desc->type;
 	csdev->subtype = desc->subtype;
 	csdev->ops = desc->ops;
+	csdev->access = desc->access;
 	csdev->orphan = false;
 
 	csdev->dev.type = &coresight_dev_type[desc->type];
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 58fffdecdbfd..81ac708689f8 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -7,6 +7,7 @@
 #define _LINUX_CORESIGHT_H
 
 #include <linux/device.h>
+#include <linux/io.h>
 #include <linux/perf_event.h>
 #include <linux/sched.h>
 
@@ -114,6 +115,32 @@ struct coresight_platform_data {
 	struct coresight_connection *conns;
 };
 
+/**
+ * struct csdev_access - Abstraction of a CoreSight device access.
+ *
+ * @no_iomem	: True if the device doesn't have iomem access.
+ * @base	: When no_iomem == false, base address of the component
+ * @read	: Read from the given "offset" of the given instance.
+ * @write	: Write "val" to the given "offset".
+ */
+struct csdev_access {
+	bool no_iomem;
+	union {
+		void __iomem *base;
+		struct {
+			u64 (*read)(struct csdev_access *csa,
+				    u32 offset,
+				    bool relaxed,
+				    bool _64bit);
+			void (*write)(struct csdev_access *csa,
+				      u64 val,
+				      u32 offset,
+				      bool relaxed,
+				      bool _64bit);
+		};
+	};
+};
+
 /**
  * struct coresight_desc - description of a component required from drivers
  * @type:	as defined by @coresight_dev_type.
@@ -134,6 +161,7 @@ struct coresight_desc {
 	struct device *dev;
 	const struct attribute_group **groups;
 	const char *name;
+	struct csdev_access access;
 };
 
 /**
@@ -186,6 +214,7 @@ struct coresight_sysfs_link {
  * @def_sink:	cached reference to default sink found for this device.
  * @ect_dev:	Associated cross trigger device. Not part of the trace data
  *		path or connections.
+ * @csa:	Device i/o access abstraction for this device.
  * @nr_links:   number of sysfs links created to other components from this
  *		device. These will appear in the "connections" group.
  * @has_conns_grp: Have added a "connections" group for sysfs links.
@@ -205,6 +234,7 @@ struct coresight_device {
 	struct coresight_device *def_sink;
 	/* cross trigger handling */
 	struct coresight_device *ect_dev;
+	struct csdev_access access;
 	/* sysfs links between components */
 	int nr_links;
 	bool has_conns_grp;
@@ -324,6 +354,79 @@ struct coresight_ops {
 	const struct coresight_ops_ect *ect_ops;
 };
 
+static inline u32 csdev_access_relaxed_read32(struct csdev_access *csa,
+					      u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return readl_relaxed(csa->base + offset);
+	return csa->read(csa, offset, true, false);
+}
+
+static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
+					   u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return readq_relaxed(csa->base + offset);
+	return csa->read(csa, offset, true, true);
+}
+
+static inline u32 csdev_access_read32(struct csdev_access *csa, u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return readl(csa->base + offset);
+	return csa->read(csa, offset, false, false);
+}
+
+static inline u64 csdev_access_read64(struct csdev_access *csa, u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return readq(csa->base + offset);
+	return csa->read(csa, offset, false, true);
+}
+
+static inline void csdev_access_relaxed_write32(struct csdev_access *csa,
+						u32 val,
+						u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return writel_relaxed(val, csa->base + offset);
+
+	return csa->write(csa, val, offset, true, false);
+}
+
+static inline void csdev_access_relaxed_write64(struct csdev_access *csa,
+					     u64 val,
+					     u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return writeq_relaxed(val, csa->base + offset);
+
+	return csa->write(csa, val, offset, true, true);
+}
+
+static inline void csdev_access_write32(struct csdev_access *csa, u32 val, u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return writel(val, csa->base + offset);
+
+	return csa->write(csa, val, offset, false, false);
+}
+
+static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 offset)
+{
+	if (likely(!csa->no_iomem))
+		return writeq(val, csa->base + offset);
+
+	return csa->write(csa, val, offset, false, true);
+}
+
+
+u64 coresight_relaxed_read64(struct coresight_device *csdev, u32 offset);
+u64 coresight_read64(struct coresight_device *csdev, u32 offset);
+void coresight_relaxed_write64(struct coresight_device *csdev,
+			       u64 val, u32 offset);
+void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
+
 #ifdef CONFIG_CORESIGHT
 extern struct coresight_device *
 coresight_register(struct coresight_desc *desc);
@@ -342,6 +445,14 @@ extern char *coresight_alloc_device_name(struct coresight_dev_list *devs,
 					 struct device *dev);
 
 extern bool coresight_loses_context_with_cpu(struct device *dev);
+
+u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset);
+u32 coresight_read32(struct coresight_device *csdev, u32 offset);
+void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset);
+void coresight_relaxed_write32(struct coresight_device *csdev,
+			       u32 val,
+			       u32 offset);
+
 #else
 static inline struct coresight_device *
 coresight_register(struct coresight_desc *desc) { return NULL; }
@@ -368,6 +479,51 @@ static inline bool coresight_loses_context_with_cpu(struct device *dev)
 {
 	return false;
 }
+
+static inline u32 coresight_relaxed_read32(struct coresight_device *csdev, u32 offset)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static inline u32 coresight_read32(struct coresight_device *csdev, u32 offset)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static void coresight_write32(struct coresight_device *csdev, u32 val, u32 offset)
+{
+}
+
+static void coresight_relaxed_write32(struct coresight_device *csdev,
+				      u32 val, u32 offset);
+{
+}
+
+static inline u64 coresight_relaxed_read64(struct coresight_device *csdev,
+					   u32 offset)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static inline u64 coresight_read64(struct coresight_device *csdev, u32 offset)
+{
+	WARN_ON_ONCE(1);
+	return 0;
+}
+
+static inline void coresight_relaxed_write64(struct coresight_device *csdev,
+					     u64 val,
+					     u32 offset)
+{
+}
+
+static inline void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset)
+{
+}
+
 #endif
 
 extern int coresight_get_cpu(struct device *dev);
-- 
2.24.1

