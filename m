Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE8DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F0A0206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 23:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="eQHxp1SD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgF3X7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 19:59:30 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17076 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgF3X7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 19:59:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5efbd1c70000>; Tue, 30 Jun 2020 16:59:03 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 30 Jun 2020 16:59:16 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 30 Jun 2020 16:59:16 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 30 Jun
 2020 23:59:12 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 30 Jun 2020 23:59:12 +0000
Received: from vdumpa-ubuntu.nvidia.com (Not Verified[172.17.173.140]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5efbd1cf0010>; Tue, 30 Jun 2020 16:59:11 -0700
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
Subject: [PATCH v9 4/4] iommu/arm-smmu: add global/context fault implementation hooks
Date:   Tue, 30 Jun 2020 16:57:52 -0700
Message-ID: <20200630235752.8737-5-vdumpa@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200630235752.8737-1-vdumpa@nvidia.com>
References: <20200630235752.8737-1-vdumpa@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1593561543; bh=mvsLhzJJhzW3ttgF+aYJo6h8LqODEzJ5jbMTqEbxeJs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:MIME-Version:X-NVConfidentiality:
         Content-Transfer-Encoding:Content-Type;
        b=eQHxp1SDb7UbwjQnKrsvfURQf/vyxBH5GHZQpGuWmJebRN9mBproZHS5vufqTL61W
         mJRFSPUgRdUuvETwXbVPsJk0mDY7ZdGw+j8tVTetuvgHQLBUjOrpcyK/Ct5SV1FIuy
         bUbEYIHieOcBE+3tu40Fd1DyH/HFQ33qTuSJROMRRD2HD9AzcUu75+qOJYpiBZj1bA
         VgSDV4JTkotCJldzpWMS2jyKHot61OWFUGonD/bEYN6GG9GQtL9E0JZh9fwywbq2Aa
         1GCDBiUgnfxeTiGKkBRfwIa6V/dFZXUSNaQ3/cfhF6TIFX9+A0V1Shx4ggb6baosrq
         /16k12ujyP/vQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add global/context fault hooks to allow NVIDIA SMMU implementation
handle faults across multiple SMMUs.

Signed-off-by: Krishna Reddy <vdumpa@nvidia.com>
---
 drivers/iommu/arm-smmu-nvidia.c | 98 +++++++++++++++++++++++++++++++++
 drivers/iommu/arm-smmu.c        | 17 +++++-
 drivers/iommu/arm-smmu.h        |  3 +
 3 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/arm-smmu-nvidia.c b/drivers/iommu/arm-smmu-nvidi=
a.c
index 5c874912e1c1a..d279788eab954 100644
--- a/drivers/iommu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm-smmu-nvidia.c
@@ -144,6 +144,102 @@ static int nvidia_smmu_reset(struct arm_smmu_device *=
smmu)
 	return 0;
 }
=20
+static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct arm_smmu_domain, domain);
+}
+
+static irqreturn_t nvidia_smmu_global_fault_inst(int irq,
+						 struct arm_smmu_device *smmu,
+						 int inst)
+{
+	u32 gfsr, gfsynr0, gfsynr1, gfsynr2;
+	void __iomem *gr0_base =3D nvidia_smmu_page(smmu, inst, 0);
+
+	gfsr =3D readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSR);
+	if (!gfsr)
+		return IRQ_NONE;
+
+	gfsynr0 =3D readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR0);
+	gfsynr1 =3D readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR1);
+	gfsynr2 =3D readl_relaxed(gr0_base + ARM_SMMU_GR0_sGFSYNR2);
+
+	dev_err_ratelimited(smmu->dev,
+			    "Unexpected global fault, this could be serious\n");
+	dev_err_ratelimited(smmu->dev,
+			    "\tGFSR 0x%08x, GFSYNR0 0x%08x, GFSYNR1 0x%08x, GFSYNR2 0x%08x\n",
+			    gfsr, gfsynr0, gfsynr1, gfsynr2);
+
+	writel_relaxed(gfsr, gr0_base + ARM_SMMU_GR0_sGFSR);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nvidia_smmu_global_fault(int irq, void *dev)
+{
+	int inst;
+	irqreturn_t irq_ret =3D IRQ_NONE;
+	struct arm_smmu_device *smmu =3D dev;
+	struct nvidia_smmu *nvidia_smmu =3D to_nvidia_smmu(smmu);
+
+	for (inst =3D 0; inst < nvidia_smmu->num_inst; inst++) {
+		irq_ret =3D nvidia_smmu_global_fault_inst(irq, smmu, inst);
+		if (irq_ret =3D=3D IRQ_HANDLED)
+			return irq_ret;
+	}
+
+	return irq_ret;
+}
+
+static irqreturn_t nvidia_smmu_context_fault_bank(int irq,
+						  struct arm_smmu_device *smmu,
+						  int idx, int inst)
+{
+	u32 fsr, fsynr, cbfrsynra;
+	unsigned long iova;
+	void __iomem *gr1_base =3D nvidia_smmu_page(smmu, inst, 1);
+	void __iomem *cb_base =3D nvidia_smmu_page(smmu, inst, smmu->numpage + id=
x);
+
+	fsr =3D readl_relaxed(cb_base + ARM_SMMU_CB_FSR);
+	if (!(fsr & ARM_SMMU_FSR_FAULT))
+		return IRQ_NONE;
+
+	fsynr =3D readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
+	iova =3D readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	cbfrsynra =3D readl_relaxed(gr1_base + ARM_SMMU_GR1_CBFRSYNRA(idx));
+
+	dev_err_ratelimited(smmu->dev,
+			    "Unhandled context fault: fsr=3D0x%x, iova=3D0x%08lx, fsynr=3D0x%x,=
 cbfrsynra=3D0x%x, cb=3D%d\n",
+			    fsr, iova, fsynr, cbfrsynra, idx);
+
+	writel_relaxed(fsr, cb_base + ARM_SMMU_CB_FSR);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t nvidia_smmu_context_fault(int irq, void *dev)
+{
+	int inst, idx;
+	irqreturn_t irq_ret =3D IRQ_NONE;
+	struct iommu_domain *domain =3D dev;
+	struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
+	struct arm_smmu_device *smmu =3D smmu_domain->smmu;
+
+	for (inst =3D 0; inst < to_nvidia_smmu(smmu)->num_inst; inst++) {
+		/*
+		 * Interrupt line is shared between all contexts.
+		 * Check for faults across all contexts.
+		 */
+		for (idx =3D 0; idx < smmu->num_context_banks; idx++) {
+			irq_ret =3D nvidia_smmu_context_fault_bank(irq, smmu,
+								 idx, inst);
+
+			if (irq_ret =3D=3D IRQ_HANDLED)
+				return irq_ret;
+		}
+	}
+
+	return irq_ret;
+}
+
 static const struct arm_smmu_impl nvidia_smmu_impl =3D {
 	.read_reg =3D nvidia_smmu_read_reg,
 	.write_reg =3D nvidia_smmu_write_reg,
@@ -151,6 +247,8 @@ static const struct arm_smmu_impl nvidia_smmu_impl =3D =
{
 	.write_reg64 =3D nvidia_smmu_write_reg64,
 	.reset =3D nvidia_smmu_reset,
 	.tlb_sync =3D nvidia_smmu_tlb_sync,
+	.global_fault =3D nvidia_smmu_global_fault,
+	.context_fault =3D nvidia_smmu_context_fault,
 };
=20
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu=
)
diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index d2054178df357..161d68c8208a4 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -670,6 +670,7 @@ static int arm_smmu_init_domain_context(struct iommu_do=
main *domain,
 	enum io_pgtable_fmt fmt;
 	struct arm_smmu_domain *smmu_domain =3D to_smmu_domain(domain);
 	struct arm_smmu_cfg *cfg =3D &smmu_domain->cfg;
+	irqreturn_t (*context_fault)(int irq, void *dev);
=20
 	mutex_lock(&smmu_domain->init_mutex);
 	if (smmu_domain->smmu)
@@ -832,7 +833,13 @@ static int arm_smmu_init_domain_context(struct iommu_d=
omain *domain,
 	 * handler seeing a half-initialised domain state.
 	 */
 	irq =3D smmu->irqs[smmu->num_global_irqs + cfg->irptndx];
-	ret =3D devm_request_irq(smmu->dev, irq, arm_smmu_context_fault,
+
+	if (smmu->impl && smmu->impl->context_fault)
+		context_fault =3D smmu->impl->context_fault;
+	else
+		context_fault =3D arm_smmu_context_fault;
+
+	ret =3D devm_request_irq(smmu->dev, irq, context_fault,
 			       IRQF_SHARED, "arm-smmu-context-fault", domain);
 	if (ret < 0) {
 		dev_err(smmu->dev, "failed to request context IRQ %d (%u)\n",
@@ -2104,6 +2111,7 @@ static int arm_smmu_device_probe(struct platform_devi=
ce *pdev)
 	struct arm_smmu_device *smmu;
 	struct device *dev =3D &pdev->dev;
 	int num_irqs, i, err;
+	irqreturn_t (*global_fault)(int irq, void *dev);
=20
 	smmu =3D devm_kzalloc(dev, sizeof(*smmu), GFP_KERNEL);
 	if (!smmu) {
@@ -2190,9 +2198,14 @@ static int arm_smmu_device_probe(struct platform_dev=
ice *pdev)
 		smmu->num_context_irqs =3D smmu->num_context_banks;
 	}
=20
+	if (smmu->impl && smmu->impl->global_fault)
+		global_fault =3D smmu->impl->global_fault;
+	else
+		global_fault =3D arm_smmu_global_fault;
+
 	for (i =3D 0; i < smmu->num_global_irqs; ++i) {
 		err =3D devm_request_irq(smmu->dev, smmu->irqs[i],
-				       arm_smmu_global_fault,
+				       global_fault,
 				       IRQF_SHARED,
 				       "arm-smmu global fault",
 				       smmu);
diff --git a/drivers/iommu/arm-smmu.h b/drivers/iommu/arm-smmu.h
index fad63efa1a72d..d890a4a968e8c 100644
--- a/drivers/iommu/arm-smmu.h
+++ b/drivers/iommu/arm-smmu.h
@@ -18,6 +18,7 @@
 #include <linux/io-64-nonatomic-hi-lo.h>
 #include <linux/io-pgtable.h>
 #include <linux/iommu.h>
+#include <linux/irqreturn.h>
 #include <linux/mutex.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
@@ -389,6 +390,8 @@ struct arm_smmu_impl {
 	void (*tlb_sync)(struct arm_smmu_device *smmu, int page, int sync,
 			 int status);
 	int (*def_domain_type)(struct device *dev);
+	irqreturn_t (*global_fault)(int irq, void *dev);
+	irqreturn_t (*context_fault)(int irq, void *dev);
 };
=20
 static inline void __iomem *arm_smmu_page(struct arm_smmu_device *smmu, in=
t n)
--=20
2.26.2

