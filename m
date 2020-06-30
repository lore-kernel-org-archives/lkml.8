Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCA9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:07:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B40C020772
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:07:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GN8muGlO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729196AbgF3UHB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:07:01 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:36100 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726642AbgF3UHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:07:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593547619;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9jfmIqGlvg6L8cUMcSx5GNUe0sJOHSYjN99uBm+lyzk=;
        b=GN8muGlOUdn7FkbRhq6avX7m89AtZy7YTGpSY0b6edckNN9ECedbVnt89iW07fAV/nLPWS
        QyE3lsiAmcXcAei2fr+5SXRDSJZcngNtjEQcVVFbRmuKjf02rj19idyB+uTnTaEXYVu0yP
        YuLOUGV32RPV6TVX7hsTE/MDlu6ucWg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-402-XTtdO96KOjq2od_fCRPCmg-1; Tue, 30 Jun 2020 16:06:47 -0400
X-MC-Unique: XTtdO96KOjq2od_fCRPCmg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 347831005512;
        Tue, 30 Jun 2020 20:06:46 +0000 (UTC)
Received: from cantor.redhat.com (ovpn-115-86.phx2.redhat.com [10.3.115.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AD6FB7BEA0;
        Tue, 30 Jun 2020 20:06:45 +0000 (UTC)
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 2/2] iommu/amd: Move Kconfig and Makefile bits down into amd directory
Date:   Tue, 30 Jun 2020 13:06:36 -0700
Message-Id: <20200630200636.48600-3-jsnitsel@redhat.com>
In-Reply-To: <20200630200636.48600-1-jsnitsel@redhat.com>
References: <20200630200636.48600-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move AMD Kconfig and Makefile bits down into the amd directory
with the rest of the AMD specific files.

Cc: Joerg Roedel <joro@8bytes.org>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/Kconfig      | 45 +-------------------------------------
 drivers/iommu/Makefile     |  5 +----
 drivers/iommu/amd/Kconfig  | 44 +++++++++++++++++++++++++++++++++++++
 drivers/iommu/amd/Makefile |  4 ++++
 4 files changed, 50 insertions(+), 48 deletions(-)
 create mode 100644 drivers/iommu/amd/Kconfig
 create mode 100644 drivers/iommu/amd/Makefile

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 281cd6bd0fe0..24000e7ed0fa 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -132,50 +132,7 @@ config IOMMU_PGTABLES_L2
 	def_bool y
 	depends on MSM_IOMMU && MMU && SMP && CPU_DCACHE_DISABLE=n
 
-# AMD IOMMU support
-config AMD_IOMMU
-	bool "AMD IOMMU support"
-	select SWIOTLB
-	select PCI_MSI
-	select PCI_ATS
-	select PCI_PRI
-	select PCI_PASID
-	select IOMMU_API
-	select IOMMU_IOVA
-	select IOMMU_DMA
-	depends on X86_64 && PCI && ACPI
-	help
-	  With this option you can enable support for AMD IOMMU hardware in
-	  your system. An IOMMU is a hardware component which provides
-	  remapping of DMA memory accesses from devices. With an AMD IOMMU you
-	  can isolate the DMA memory of different devices and protect the
-	  system from misbehaving device drivers or hardware.
-
-	  You can find out if your system has an AMD IOMMU if you look into
-	  your BIOS for an option to enable it or if you have an IVRS ACPI
-	  table.
-
-config AMD_IOMMU_V2
-	tristate "AMD IOMMU Version 2 driver"
-	depends on AMD_IOMMU
-	select MMU_NOTIFIER
-	help
-	  This option enables support for the AMD IOMMUv2 features of the IOMMU
-	  hardware. Select this option if you want to use devices that support
-	  the PCI PRI and PASID interface.
-
-config AMD_IOMMU_DEBUGFS
-	bool "Enable AMD IOMMU internals in DebugFS"
-	depends on AMD_IOMMU && IOMMU_DEBUGFS
-	help
-	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
-
-	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
-	  Exposes AMD IOMMU device internals in DebugFS.
-
-	  This option is -NOT- intended for production environments, and should
-	  not generally be enabled.
-
+source "drivers/iommu/amd/Kconfig"
 source "drivers/iommu/intel/Kconfig"
 
 config IRQ_REMAP
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 71dd2f382e78..f356bc12b1c7 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-y += intel/
+obj-y += amd/ intel/
 obj-$(CONFIG_IOMMU_API) += iommu.o
 obj-$(CONFIG_IOMMU_API) += iommu-traces.o
 obj-$(CONFIG_IOMMU_API) += iommu-sysfs.o
@@ -12,9 +12,6 @@ obj-$(CONFIG_IOASID) += ioasid.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
-obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
-obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
-obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
new file mode 100644
index 000000000000..1f061d91e0b8
--- /dev/null
+++ b/drivers/iommu/amd/Kconfig
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# AMD IOMMU support
+config AMD_IOMMU
+	bool "AMD IOMMU support"
+	select SWIOTLB
+	select PCI_MSI
+	select PCI_ATS
+	select PCI_PRI
+	select PCI_PASID
+	select IOMMU_API
+	select IOMMU_IOVA
+	select IOMMU_DMA
+	depends on X86_64 && PCI && ACPI
+	help
+	  With this option you can enable support for AMD IOMMU hardware in
+	  your system. An IOMMU is a hardware component which provides
+	  remapping of DMA memory accesses from devices. With an AMD IOMMU you
+	  can isolate the DMA memory of different devices and protect the
+	  system from misbehaving device drivers or hardware.
+
+	  You can find out if your system has an AMD IOMMU if you look into
+	  your BIOS for an option to enable it or if you have an IVRS ACPI
+	  table.
+
+config AMD_IOMMU_V2
+	tristate "AMD IOMMU Version 2 driver"
+	depends on AMD_IOMMU
+	select MMU_NOTIFIER
+	help
+	  This option enables support for the AMD IOMMUv2 features of the IOMMU
+	  hardware. Select this option if you want to use devices that support
+	  the PCI PRI and PASID interface.
+
+config AMD_IOMMU_DEBUGFS
+	bool "Enable AMD IOMMU internals in DebugFS"
+	depends on AMD_IOMMU && IOMMU_DEBUGFS
+	help
+	  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!  !!!WARNING!!!
+
+	  DO NOT ENABLE THIS OPTION UNLESS YOU REALLY, -REALLY- KNOW WHAT YOU ARE DOING!!!
+	  Exposes AMD IOMMU device internals in DebugFS.
+
+	  This option is -NOT- intended for production environments, and should
+	  not generally be enabled.
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
new file mode 100644
index 000000000000..dc5a2fa4fd37
--- /dev/null
+++ b/drivers/iommu/amd/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o
+obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
+obj-$(CONFIG_AMD_IOMMU_V2) += iommu_v2.o
-- 
2.27.0

