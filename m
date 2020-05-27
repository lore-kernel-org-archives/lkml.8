Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FA9C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93FEB207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 11:53:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgE0Lxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 07:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728714AbgE0Lx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 07:53:26 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7175BC08C5C2
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 04:53:26 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 5564145; Wed, 27 May 2020 13:53:23 +0200 (CEST)
From:   Joerg Roedel <joro@8bytes.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        jroedel@suse.de
Subject: [PATCH 01/10] iommu/amd: Move AMD IOMMU driver to a subdirectory
Date:   Wed, 27 May 2020 13:53:04 +0200
Message-Id: <20200527115313.7426-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200527115313.7426-1-joro@8bytes.org>
References: <20200527115313.7426-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

The driver consists of five C files and three header files by now.
Move them to their own subdirectory to not clutter to iommu top-level
directory with them.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 MAINTAINERS                                          | 2 +-
 drivers/iommu/Makefile                               | 6 +++---
 drivers/iommu/{ => amd}/amd_iommu.h                  | 0
 drivers/iommu/{ => amd}/amd_iommu_proto.h            | 0
 drivers/iommu/{ => amd}/amd_iommu_types.h            | 0
 drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} | 0
 drivers/iommu/{amd_iommu_init.c => amd/init.c}       | 2 +-
 drivers/iommu/{amd_iommu.c => amd/iommu.c}           | 2 +-
 drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c}     | 0
 drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c}   | 0
 10 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/iommu/{ => amd}/amd_iommu.h (100%)
 rename drivers/iommu/{ => amd}/amd_iommu_proto.h (100%)
 rename drivers/iommu/{ => amd}/amd_iommu_types.h (100%)
 rename drivers/iommu/{amd_iommu_debugfs.c => amd/debugfs.c} (100%)
 rename drivers/iommu/{amd_iommu_init.c => amd/init.c} (99%)
 rename drivers/iommu/{amd_iommu.c => amd/iommu.c} (99%)
 rename drivers/iommu/{amd_iommu_v2.c => amd/iommu_v2.c} (100%)
 rename drivers/iommu/{amd_iommu_quirks.c => amd/quirks.c} (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 50659d76976b..dd59ec6676d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -876,7 +876,7 @@ M:	Joerg Roedel <joro@8bytes.org>
 L:	iommu@lists.linux-foundation.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git
-F:	drivers/iommu/amd_iommu*.[ch]
+F:	drivers/iommu/amd/
 F:	include/linux/amd-iommu.h
 
 AMD KFD
diff --git a/drivers/iommu/Makefile b/drivers/iommu/Makefile
index 57cf4ba5e27c..3af7e374b0cb 100644
--- a/drivers/iommu/Makefile
+++ b/drivers/iommu/Makefile
@@ -11,9 +11,9 @@ obj-$(CONFIG_IOASID) += ioasid.o
 obj-$(CONFIG_IOMMU_IOVA) += iova.o
 obj-$(CONFIG_OF_IOMMU)	+= of_iommu.o
 obj-$(CONFIG_MSM_IOMMU) += msm_iommu.o
-obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o amd_iommu_init.o amd_iommu_quirks.o
-obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd_iommu_debugfs.o
-obj-$(CONFIG_AMD_IOMMU_V2) += amd_iommu_v2.o
+obj-$(CONFIG_AMD_IOMMU) += amd/iommu.o amd/init.o amd/quirks.o
+obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += amd/debugfs.o
+obj-$(CONFIG_AMD_IOMMU_V2) += amd/iommu_v2.o
 obj-$(CONFIG_ARM_SMMU) += arm_smmu.o
 arm_smmu-objs += arm-smmu.o arm-smmu-impl.o arm-smmu-qcom.o
 obj-$(CONFIG_ARM_SMMU_V3) += arm-smmu-v3.o
diff --git a/drivers/iommu/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
similarity index 100%
rename from drivers/iommu/amd_iommu.h
rename to drivers/iommu/amd/amd_iommu.h
diff --git a/drivers/iommu/amd_iommu_proto.h b/drivers/iommu/amd/amd_iommu_proto.h
similarity index 100%
rename from drivers/iommu/amd_iommu_proto.h
rename to drivers/iommu/amd/amd_iommu_proto.h
diff --git a/drivers/iommu/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
similarity index 100%
rename from drivers/iommu/amd_iommu_types.h
rename to drivers/iommu/amd/amd_iommu_types.h
diff --git a/drivers/iommu/amd_iommu_debugfs.c b/drivers/iommu/amd/debugfs.c
similarity index 100%
rename from drivers/iommu/amd_iommu_debugfs.c
rename to drivers/iommu/amd/debugfs.c
diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd/init.c
similarity index 99%
rename from drivers/iommu/amd_iommu_init.c
rename to drivers/iommu/amd/init.c
index 5b81fd16f5fa..fda80fd1d9a6 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd/init.c
@@ -35,7 +35,7 @@
 #include "amd_iommu.h"
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 
 /*
  * definitions for the ACPI scanning code
diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd/iommu.c
similarity index 99%
rename from drivers/iommu/amd_iommu.c
rename to drivers/iommu/amd/iommu.c
index 1b36c40d0712..39155f550f18 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -45,7 +45,7 @@
 
 #include "amd_iommu_proto.h"
 #include "amd_iommu_types.h"
-#include "irq_remapping.h"
+#include "../irq_remapping.h"
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
diff --git a/drivers/iommu/amd_iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
similarity index 100%
rename from drivers/iommu/amd_iommu_v2.c
rename to drivers/iommu/amd/iommu_v2.c
diff --git a/drivers/iommu/amd_iommu_quirks.c b/drivers/iommu/amd/quirks.c
similarity index 100%
rename from drivers/iommu/amd_iommu_quirks.c
rename to drivers/iommu/amd/quirks.c
-- 
2.17.1

