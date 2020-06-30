Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5546C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:10:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E5720781
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 00:10:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="L/kJCNq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgF3AK4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 20:10:56 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10206 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726182AbgF3AKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 20:10:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efa82ff0000>; Mon, 29 Jun 2020 17:10:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 29 Jun 2020 17:10:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 29 Jun 2020 17:10:52 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 00:10:51 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 00:10:51 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efa830a0000>; Mon, 29 Jun 2020 17:10:50 -0700
From:   Krishna Reddy <vdumpa@nvidia.com>
CC:     <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <iommu@lists.linux-foundation.org>, <linux-kernel@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <treding@nvidia.com>,
        <yhsu@nvidia.com>, <snikam@nvidia.com>, <praithatha@nvidia.com>,
        <talho@nvidia.com>, <bbiswas@nvidia.com>, <mperttunen@nvidia.com>,
        <nicolinc@nvidia.com>, <bhuntsman@nvidia.com>,
        <nicoleotsuka@gmail.com>, Krishna Reddy <vdumpa@nvidia.com>
Subject: [PATCH v8 1/3] iommu/arm-smmu: add NVIDIA implementation for dual ARM MMU-500 usage
Date:   Mon, 29 Jun 2020 17:10:49 -0700
Message-ID: <20200630001051.12350-2-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630001051.12350-1-vdumpa@nvidia.com>
References: <20200630001051.12350-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593475839; bh=e0LVSLaQ4ZIAe4EIAVkwvsfoE2TfFwkZRU1lpmCcIZ0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=L/kJCNq8lawUgBzo8mwqzzI45O8TWZQB4WtFs9xyr6HJUF3JHDa678UMtceXRiYKZ
         A5fZyGPL2LifAFrqxIIGzNZO4fq0zUGodkaaT/iCkisEDunJWQDIynmHuyTJ6STqnc
         34AIMLkqaBOzkh4r/XuwTW9BUlsDSwbu6GFvD4sM32nRaWiE9xIrThDUf1/7umoTEs
         fFZPPQYynp6zh1SrCqQmdlMrCn2SjIud7KeDgGN3QNQQ9VME9xCHP1M59G5thkrbGe
         vM1RH6/GI+D/D6DpnD9F27W9CduV5tS76O+iDjg6r4pUp/vSQU4hC6tyGhDVhClEVY
         AehWa3J50C63g==
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NVIDIA's Tegra194 SoC uses two ARM MMU-500s together to interleave
IOVA accesses across them.
Add NVIDIA implementation for dual ARM MMU-500s and add new compatible
string for Tegra194 SoC SMMU topology.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 MAINTAINERS                     |   2 +
 drivers/iommu/Makefile          |   2 +-
 drivers/iommu/arm-smmu-impl.c   |   3 +
 drivers/iommu/arm-smmu-nvidia.c | 196 ++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.h        |   1 +
 5 files changed, 203 insertions(+), 1 deletion(-)
 create mode 100644 drivers/iommu/arm-smmu-nvidia.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7b5ffd646c6b9..64c37dbdd4426 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16808,8 +16808,10 @@ F:	drivers/i2c/busses/i2c-tegra.c
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
index 342190196dfb0..2b8203db73ec3 100644
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
index c75b9d957b702..70f7318017617 100644
--- a/drivers/iommu/arm-smmu-impl.c
+++ b/drivers/iommu/arm-smmu-impl.c
@@ -171,6 +171,9 @@ struct arm_smmu_device *arm_smmu_impl_init(struct arm_s=
mmu_device *smmu)
 	if (of_property_read_bool(np, "calxeda,smmu-secure-config-access"))
 		smmu->impl =3D &calxeda_impl;
=20
+	if (of_device_is_compatible(smmu->dev->of_node, "nvidia,tegra194-smmu"))
+		return nvidia_smmu_impl_init(smmu);
+
 	if (of_device_is_compatible(np, "qcom,sdm845-smmu-500") ||
 	    of_device_is_compatible(np, "qcom,sc7180-smmu-500"))
 		return qcom_smmu_impl_init(smmu);
diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidi=
a.c
new file mode 100644
index 0000000000000..1124f0ac1823a
--- /dev/null
+++ b/drivers/iommu/arm-smmu-nvidia.c
@@ -0,0 +1,196 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// NVIDIA ARM SMMU v2 implementation quirks
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
+ * Two of them are used together for interleaved IOVA accesses and
+ * used by non-isochronous HW devices for SMMU translations.
+ * Third one is used for SMMU translations from isochronous HW devices.
+ * It is possible to use this implementation to program either
+ * all three or two of the instances identically as desired through
+ * DT node.
+ *
+ * Programming all the three instances identically comes with redundant TL=
B
+ * invalidations as all three never need to be TLB invalidated for a HW de=
vice.
+ *
+ * When Linux kernel supports multiple SMMU devices, the SMMU device used =
for
+ * isochornous HW devices should be added as a separate ARM MMU-500 device
+ * in DT and be programmed independently for efficient TLB invalidates.
+ */
+#define MAX_SMMU_INSTANCES 3
+
+#define TLB_LOOP_TIMEOUT_IN_US		1000000	/* 1s! */
+#define TLB_SPIN_COUNT			10
+
+struct nvidia_smmu {
+	struct arm_smmu_device	smmu;
+	unsigned int		num_inst;
+	void __iomem		*bases[MAX_SMMU_INSTANCES];
+};
+
+static inline struct nvidia_smmu *to_nvidia_smmu(struct arm_smmu_device *s=
mmu)
+{
+	return container_of(smmu, struct nvidia_smmu, smmu);
+}
+
+static inline void __iomem *nvidia_smmu_page(struct arm_smmu_device *smmu,
+			       unsigned int inst, int page)
+{
+	struct nvidia_smmu *nvidia_smmu =3D to_nvidia_smmu(smmu);
+
+	if (!nvidia_smmu->bases[0])
+		nvidia_smmu->bases[0] =3D smmu->base;
+
+	return nvidia_smmu->bases[inst] + (page << smmu->pgshift);
+}
+
+static u32 nvidia_smmu_read_reg(struct arm_smmu_device *smmu,
+			      int page, int offset)
+{
+	void __iomem *reg =3D nvidia_smmu_page(smmu, 0, page) + offset;
+
+	return readl_relaxed(reg);
+}
+
+static void nvidia_smmu_write_reg(struct arm_smmu_device *smmu,
+			    int page, int offset, u32 val)
+{
+	unsigned int i;
+	struct nvidia_smmu *nvidia_smmu =3D to_nvidia_smmu(smmu);
+
+	for (i =3D 0; i < nvidia_smmu->num_inst; i++) {
+		void __iomem *reg =3D nvidia_smmu_page(smmu, i, page) + offset;
+
+		writel_relaxed(val, reg);
+	}
+}
+
+static u64 nvidia_smmu_read_reg64(struct arm_smmu_device *smmu,
+				int page, int offset)
+{
+	void __iomem *reg =3D nvidia_smmu_page(smmu, 0, page) + offset;
+
+	return readq_relaxed(reg);
+}
+
+static void nvidia_smmu_write_reg64(struct arm_smmu_device *smmu,
+				  int page, int offset, u64 val)
+{
+	unsigned int i;
+	struct nvidia_smmu *nvidia_smmu =3D to_nvidia_smmu(smmu);
+
+	for (i =3D 0; i < nvidia_smmu->num_inst; i++) {
+		void __iomem *reg =3D nvidia_smmu_page(smmu, i, page) + offset;
+
+		writeq_relaxed(val, reg);
+	}
+}
+
+static void nvidia_smmu_tlb_sync(struct arm_smmu_device *smmu, int page,
+			   int sync, int status)
+{
+	unsigned int delay;
+
+	arm_smmu_writel(smmu, page, sync, 0);
+
+	for (delay =3D 1; delay < TLB_LOOP_TIMEOUT_IN_US; delay *=3D 2) {
+		unsigned int spin_cnt;
+
+		for (spin_cnt =3D TLB_SPIN_COUNT; spin_cnt > 0; spin_cnt--) {
+			u32 val =3D 0;
+			unsigned int i;
+			struct nvidia_smmu *nvidia_smmu =3D to_nvidia_smmu(smmu);
+
+			for (i =3D 0; i < nvidia_smmu->num_inst; i++) {
+				void __iomem *reg =3D
+					nvidia_smmu_page(smmu, i, page) + status;
+
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
+	for (i =3D 0; i < to_nvidia_smmu(smmu)->num_inst; i++) {
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
+	unsigned int i;
+	struct nvidia_smmu *nvidia_smmu;
+	struct platform_device *pdev =3D to_platform_device(smmu->dev);
+
+	nvidia_smmu =3D devm_kzalloc(smmu->dev, sizeof(*nvidia_smmu), GFP_KERNEL)=
;
+	if (!nvidia_smmu)
+		return ERR_PTR(-ENOMEM);
+
+	nvidia_smmu->smmu =3D *smmu;
+	/* Instance 0 is ioremapped by arm-smmu.c after this function returns */
+	nvidia_smmu->num_inst =3D 1;
+
+	for (i =3D 1; i < MAX_SMMU_INSTANCES; i++) {
+		struct resource *res;
+
+		res =3D platform_get_resource(pdev, IORESOURCE_MEM, i);
+		if (!res)
+			break;
+
+		nvidia_smmu->bases[i] =3D devm_ioremap_resource(smmu->dev, res);
+		if (IS_ERR(nvidia_smmu->bases[i]))
+			return ERR_CAST(nvidia_smmu->bases[i]);
+
+		nvidia_smmu->num_inst++;
+	}
+
+	nvidia_smmu->smmu.impl =3D &nvidia_smmu_impl;
+	/*
+	 * Free the arm_smmu_device struct allocated in arm-smmu.c.
+	 * Once this function returns, arm-smmu.c would use arm_smmu_device
+	 * allocated as part of nvidia_smmu struct.
+	 */
+	devm_kfree(smmu->dev, smmu);
+
+	return &nvidia_smmu->smmu;
+}
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index d172c024be618..8cf1511ed9874 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -450,6 +450,7 @@ static inline void arm_smmu_writeq(struct arm_smmu_devi=
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

