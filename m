Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECBBE206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 09:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbgFBJ0Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 05:26:24 -0400
Received: from 8bytes.org ([81.169.241.247]:45686 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgFBJ0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 05:26:24 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5E6FD445; Tue,  2 Jun 2020 11:26:22 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>, Qian Cai <cai@lca.pw>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 2/2] iommu/vt-d: Move Intel IOMMU driver into subdirectory
Date:   Tue,  2 Jun 2020 11:26:16 +0200
Message-Id: <20200602092616.24638-3-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200602092616.24638-1-joro@8bytes.org>
References: <20200602092616.24638-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Move all files related to the Intel IOMMU driver into its own
subdirectory.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/iommu/Makefile                               | 12 ++++++------
 .../iommu/{intel-iommu-debugfs.c => intel/debugfs.c} |  0
 drivers/iommu/{ => intel}/dmar.c                     |  2 +-
 drivers/iommu/{ => intel}/intel-pasid.h              |  0
 drivers/iommu/{intel-iommu.c => intel/iommu.c}       |  2 +-
 .../{intel_irq_remapping.c => intel/irq_remapping.c} |  2 +-
 drivers/iommu/{intel-pasid.c => intel/pasid.c}       |  0
 drivers/iommu/{intel-svm.c => intel/svm.c}           |  0
 drivers/iommu/{intel-trace.c => intel/trace.c}       |  0
 9 files changed, 9 insertions(+), 9 deletions(-)
 rename drivers/iommu/{intel-iommu-debugfs.c => intel/debugfs.c} (100%)
 rename drivers/iommu/{ => intel}/dmar.c (99%)
 rename drivers/iommu/{ => intel}/intel-pasid.h (100%)
 rename drivers/iommu/{intel-iommu.c => intel/iommu.c} (99%)
 rename drivers/iommu/{intel_irq_remapping.c => intel/irq_remapping.c} (99%)
 rename drivers/iommu/{intel-pasid.c => intel/pasid.c} (100%)
 rename drivers/iommu/{intel-svm.c => intel/svm.c} (100%)
 rename drivers/iommu/{intel-trace.c => intel/trace.c} (100%)

diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 3af7e374b0cb..342190196dfb 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -17,13 +17,13 @@ obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
-obj-$(CONFIG_DMAR_TABLE) += dmar.o
-obj-$(CONFIG_INTEL_IOMMU) += intel-iommu.o intel-pasid.o
-obj-$(CONFIG_INTEL_IOMMU) += intel-trace.o
-obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel-iommu-debugfs.o
-obj-$(CONFIG_INTEL_IOMMU_SVM) += intel-svm.o
+obj-$(CONFIG_DMAR_TABLE) += intel/dmar.o
+obj-$(CONFIG_INTEL_IOMMU) += intel/iommu.o intel/pasid.o
+obj-$(CONFIG_INTEL_IOMMU) += intel/trace.o
+obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += intel/debugfs.o
+obj-$(CONFIG_INTEL_IOMMU_SVM) += intel/svm.o
 obj-$(CONFIG_IPMMU_VMSA) += ipmmu-vmsa.o
-obj-$(CONFIG_IRQ_REMAP) += intel_irq_remapping.o irq_remapping.o
+obj-$(CONFIG_IRQ_REMAP) += intel/irq_remapping.o irq_remapping.o
 obj-$(CONFIG_MTK_IOMMU) += mtk_iommu.o
 obj-$(CONFIG_MTK_IOMMU_V1) += mtk_iommu_v1.o
 obj-$(CONFIG_OMAP_IOMMU) += omap-iommu.o
diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel/debugfs.c
similarity index 100%
rename from drivers/iommu/intel-iommu-debugfs.c
rename to drivers/iommu/intel/debugfs.c
diff --git a/drivers/iommu/dmar.c b/drivers/iommu/intel/dmar.c
similarity index 99%
rename from drivers/iommu/dmar.c
rename to drivers/iommu/intel/dmar.c
index 60a2970c37ff..cc46dff98fa0 100644
--- a/drivers/iommu/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -32,7 +32,7 @@
 #include <asm/irq_remapping.h>
 #include <asm/iommu_table.h>
 
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 
 typedef int (*dmar_res_handler_t)(struct acpi_dmar_header *, void *);
 struct dmar_res_callback {
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel/intel-pasid.h
similarity index 100%
rename from drivers/iommu/intel-pasid.h
rename to drivers/iommu/intel/intel-pasid.h
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel/iommu.c
similarity index 99%
rename from drivers/iommu/intel-iommu.c
rename to drivers/iommu/intel/iommu.c
index 648a785e078a..9129663a7406 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -47,7 +47,7 @@
 #include <asm/iommu.h>
 #include <trace/events/intel_iommu.h>
 
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 #include "intel-pasid.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
diff --git a/drivers/iommu/intel_irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
similarity index 99%
rename from drivers/iommu/intel_irq_remapping.c
rename to drivers/iommu/intel/irq_remapping.c
index a042f123b091..7f8769800815 100644
--- a/drivers/iommu/intel_irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -21,7 +21,7 @@
 #include <asm/pci-direct.h>
 #include <asm/msidef.h>
 
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 
 enum irq_mode {
 	IRQ_REMAPPING,
diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel/pasid.c
similarity index 100%
rename from drivers/iommu/intel-pasid.c
rename to drivers/iommu/intel/pasid.c
diff --git a/drivers/iommu/intel-svm.c b/drivers/iommu/intel/svm.c
similarity index 100%
rename from drivers/iommu/intel-svm.c
rename to drivers/iommu/intel/svm.c
diff --git a/drivers/iommu/intel-trace.c b/drivers/iommu/intel/trace.c
similarity index 100%
rename from drivers/iommu/intel-trace.c
rename to drivers/iommu/intel/trace.c
-- 
2.17.1

