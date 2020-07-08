Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BFAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D85DC2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 05:00:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Gc1mYQ6n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729617AbgGHFA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 01:00:29 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17585 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729097AbgGHFAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 01:00:19 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0552d50001>; Tue, 07 Jul 2020 22:00:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 22:00:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jul 2020 22:00:17 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 05:00:14 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 8 Jul 2020 05:00:14 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5f0552dd000d>; Tue, 07 Jul 2020 22:00:14 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
To:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <robh+dt@kernel.org>, <treding@nvidia.com>, <jonathanh@nvidia.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <yhsu@nvidia.com>,
        <snikam@nvidia.com>, <praithatha@nvidia.com>, <talho@nvidia.com>,
        <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v10 3/5] iommu/arm-smmu: add NVIDIA implementation for ARM MMU-500 usage
Date:   Tue, 7 Jul 2020 22:00:15 -0700
Message-ID: <20200708050017.31563-4-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708050017.31563-1-vdumpa@nvidia.com>
References: <20200708050017.31563-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594184405; bh=dfZXAzCY2LCNxFr3FWKy3/OnzpHAtNqh16r4VKF+iSE=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=Gc1mYQ6n664qOfw2+OZL7j+lHgvXgxnC1OwYusaydLHYY5Qib0PTque5ZnG1C1f76
         XSbBjsBLF9A1Rx+xrECm+8Ult9S4fcZ6+yEmLPHVUmBXPqOx3WlXHyYYMcVH2Bms/X
         U+3eTAOf6YS6sEL3JMsmfAqODoTLZ9s+kEPbBe+Hr7hcIMFyb61g7pcOtCMViyapss
         8nxc/GKw2esdtXZ0G+xhC5Z2JiJ9N5uZ7y0q9SpiV3RpLSaFjrjsQBQBRt4QSVXmic
         axDq5J590lUsky6wDFTBufx6NmPUWUOOoZVs87V2geLUEW/KAKNP/rVS2B4hvAXP9O
         f/vPSeTDnZgtA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA's Tegra194 SoC has three ARM MMU-500 instances.
It uses two of the ARM MMU-500s together to interleave IOVA
accesses across them and must be programmed identically.
This implementation supports programming the two ARM MMU-500s
that must be programmed identically.

The third ARM MMU-500 instance is supported by standard
arm-smmu.c driver itself.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 MAINTAINERS                     |   2 +
 drivers/iommu/Makefile          |   2 +-
 drivers/iommu/arm-smmu-impl.c   |   3 +
 drivers/iommu/arm-smmu-nvidia.c | 179 ++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c        |   1 +
 drivers/iommu/arm-smmu.h        |   1 +
 6 files changed, 187 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

diff --git a/MAINTAINERS b/MAINTAINERS
index c23352059a6b..534cedaf8e55 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16811,8 +16811,10 @@ F:	drivers/i2c/busses/i2c-tegra.c
=20
 TEGRA IOMMU DRIVERS
 M:	Thierry Reding <thierry.reding@gmail.com>
+R:	Krishna Reddy <vdumpa@nvidia.com>
 L:	linux-tegra@vger.kernel.org
 S:	Supported
+F:	drivers/iommu/arm-smmu-nvidia.c
 F:	drivers/iommu/tegra*
=20
 TEGRA KBC DRIVER
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 342190196dfb..2b8203db73ec 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -15,7 +15,7 @@ obj-$(CONFIG_AMD_IOMMU) +=3D amd/iommu.o amd/init.o amd/q=
uirks.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) +=3D amd/debugfs.o
 obj-$(CONFIG_AMD_IOMMU_V2) +=3D amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) +=3D arm_smmu.o
-arm_smmu-objs +=3D arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
+arm_smmu-objs +=3D arm-smmu.o arm-smmu-impl.o arm-smmu-nvidia.o arm-smmu-q=
com.o
 obj-$(CONFIG_ARM_SMMU_V3) +=3D arm-smmu-v3.o
 obj-$(CONFIG_DMAR_TABLE) +=3D intel/dmar.o
 obj-$(CONFIG_INTEL_IOMMU) +=3D intel/iommu.o intel/pasid.o
diff --git a/drivers/iommu/arm-smmu-impl.c b/drivers/iommu/arm-smmu-impl.c
index c75b9d957b70..f15571d05474 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -171,6 +171,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_s=
mmu_device *smmu)
 	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
 		smmu->impl =3D &calxeda_impl;
=20
+	if (of_device_is_compatible(np, "nvidia,tegra194-smmu"))
+		return nvidia_smmu_impl_init(smmu);
+
 	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
 	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidi=
a.c
new file mode 100644
index 000000000000..2f55e5793d34
--- /dev/null
+++ b/drivers/iommu/arm-smmu-nvidia.c
@@ -0,0 +1,179 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2019-2020 NVIDIA CORPORATION.  All rights reserved.
+
+#include <linux/bitfield.h>
+#include <linux/delay.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "arm-smmu.h"
+
+/*
+ * Tegra194 has three ARM MMU-500 Instances.
+ * Two of them are used together and must be programmed identically for
+ * interleaved IOVA accesses across them and translates accesses from
+ * non-isochronous HW devices.
+ * Third one is used for translating accesses from isochronous HW devices.
+ * This implementation supports programming of the two instances that must
+ * be programmed identically.
+ * The third instance usage is through standard arm-smmu driver itself and
+ * is out of scope of this implementation.
+ */
+#define NUM_SMMU_INSTANCES 2
+
+struct nvidia_smmu {
+	struct arm_smmu_device	smmu;
+	void __iomem		*bases[NUM_SMMU_INSTANCES];
+};
+
+static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
+					     unsigned int inst, int page)
+{
+	struct nvidia_smmu *nvidia_smmu;
+
+	nvidia_smmu =3D container_of(smmu, struct nvidia_smmu, smmu);
+	return nvidia_smmu->bases[inst] + (page << smmu->pgshift);
+}
+
+static u32 nvidia_smmu_read_reg(struct arm_smmu_device *smmu,
+				int page, int offset)
+{
+	void __iomem *reg =3D nvidia_smmu_page(smmu, 0, page) + offset;
+
+	return readl_relaxed(reg);
+}
+
+static void nvidia_smmu_write_reg(struct arm_smmu_device *smmu,
+				  int page, int offset, u32 val)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < NUM_SMMU_INSTANCES; i++) {
+		void __iomem *reg =3D nvidia_smmu_page(smmu, i, page) + offset;
+
+		writel_relaxed(val, reg);
+	}
+}
+
+static u64 nvidia_smmu_read_reg64(struct arm_smmu_device *smmu,
+				  int page, int offset)
+{
+	void __iomem *reg =3D nvidia_smmu_page(smmu, 0, page) + offset;
+
+	return readq_relaxed(reg);
+}
+
+static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
+				    int page, int offset, u64 val)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < NUM_SMMU_INSTANCES; i++) {
+		void __iomem *reg =3D nvidia_smmu_page(smmu, i, page) + offset;
+
+		writeq_relaxed(val, reg);
+	}
+}
+
+static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+				 int sync, int status)
+{
+	unsigned int delay;
+
+	arm_smmu_writel(smmu, page, sync, 0);
+
+	for (delay =3D 1; delay < TLB_LOOP_TIMEOUT; delay *=3D 2) {
+		unsigned int spin_cnt;
+
+		for (spin_cnt =3D TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
+			u32 val =3D 0;
+			unsigned int i;
+
+			for (i =3D 0; i < NUM_SMMU_INSTANCES; i++) {
+				void __iomem *reg;
+
+				reg =3D nvidia_smmu_page(smmu, i, page) + status;
+				val |=3D readl_relaxed(reg);
+			}
+
+			if (!(val & ARM_SMMU_sTLBGSTATUS_GSACTIVE))
+				return;
+
+			cpu_relax();
+		}
+
+		udelay(delay);
+	}
+
+	dev_err_ratelimited(smmu->dev,
+			    "TLB sync timed out -- SMMU may be deadlocked\n");
+}
+
+static int nvidia_smmu_reset(struct arm_smmu_device *smmu)
+{
+	unsigned int i;
+
+	for (i =3D 0; i < NUM_SMMU_INSTANCES; i++) {
+		u32 val;
+		void __iomem *reg =3D nvidia_smmu_page(smmu, i, ARM_SMMU_GR0) +
+				    ARM_SMMU_GR0_sGFSR;
+
+		/* clear global FSR */
+		val =3D readl_relaxed(reg);
+		writel_relaxed(val, reg);
+	}
+
+	return 0;
+}
+
+static const struct arm_smmu_impl nvidia_smmu_impl =3D {
+	.read_reg =3D nvidia_smmu_read_reg,
+	.write_reg =3D nvidia_smmu_write_reg,
+	.read_reg64 =3D nvidia_smmu_read_reg64,
+	.write_reg64 =3D nvidia_smmu_write_reg64,
+	.reset =3D nvidia_smmu_reset,
+	.tlb_sync =3D nvidia_smmu_tlb_sync,
+};
+
+struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu=
)
+{
+	struct resource *res;
+	struct device *dev =3D smmu->dev;
+	struct nvidia_smmu *nvidia_smmu;
+	struct platform_device *pdev =3D to_platform_device(dev);
+
+	nvidia_smmu =3D devm_kzalloc(dev, sizeof(*nvidia_smmu), GFP_KERNEL);
+	if (!nvidia_smmu)
+		return ERR_PTR(-ENOMEM);
+
+	/*
+	 * Copy the data from struct arm_smmu_device *smmu allocated in
+	 * arm-smmu.c. The smmu from struct nvidia_smmu replaces the smmu
+	 * pointer used in arm-smmu.c once this function returns.
+	 * This is necessary to derive nvidia_smmu from smmu pointer passed
+	 * through arm_smmu_impl function calls subsequently.
+	 */
+	nvidia_smmu->smmu =3D *smmu;
+	/* Instance 0 is ioremapped by arm-smmu.c. */
+	nvidia_smmu->bases[0] =3D smmu->base;
+
+	res =3D platform_get_resource(pdev, IORESOURCE_MEM, 1);
+	if (!res)
+		return ERR_PTR(-ENODEV);
+
+	nvidia_smmu->bases[1] =3D devm_ioremap_resource(dev, res);
+	if (IS_ERR(nvidia_smmu->bases[1]))
+		return ERR_CAST(nvidia_smmu->bases[1]);
+
+	nvidia_smmu->smmu.impl =3D &nvidia_smmu_impl;
+
+	/*
+	 * Free the struct arm_smmu_device *smmu allocated in arm-smmu.c.
+	 * Once this function returns, arm-smmu.c would use arm_smmu_device
+	 * allocated as part of struct nvidia_smmu.
+	 */
+	devm_kfree(dev, smmu);
+
+	return &nvidia_smmu->smmu;
+}
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index e03e873d3bca..c123a5814f70 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -1943,6 +1943,7 @@ static const struct of_device_id arm_smmu_of_match[] =
=3D {
 	{ .compatible =3D "arm,mmu-401", .data =3D &arm_mmu401 },
 	{ .compatible =3D "arm,mmu-500", .data =3D &arm_mmu500 },
 	{ .compatible =3D "cavium,smmu-v2", .data =3D &cavium_smmuv2 },
+	{ .compatible =3D "nvidia,smmu-500", .data =3D &arm_mmu500 },
 	{ .compatible =3D "qcom,smmu-v2", .data =3D &qcom_smmuv2 },
 	{ },
 };
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index c7d0122a7c6c..fad63efa1a72 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -452,6 +452,7 @@ static inline void arm_smmu_writeq(struct arm_smmu_devi=
ce *smmu, int page,
 	arm_smmu_writeq((s), ARM_SMMU_CB((s), (n)), (o), (v))
=20
 struct arm_smmu_device *arm_smmu_impl_init(struct arm_smmu_device *smmu);
+struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu=
);
 struct arm_smmu_device *qcom_smmu_impl_init(struct arm_smmu_device *smmu);
=20
 int arm_mmu500_reset(struct arm_smmu_device *smmu);
--=20
2.26.2

