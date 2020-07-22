Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F26C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:48:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B13712073A
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 02:48:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731820AbgGVCsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 22:48:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:48202 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731614AbgGVCsm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 22:48:42 -0400
IronPort-SDR: bM0Cmu1REzGJgQz3SRVMf8RSis6x7NX89hmNEWcVloP8WzEz2qgC6/t1VvH7/LZVEHHtr8QdoT
 og4cHsNwOm8g==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="168406943"
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="168406943"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 19:48:41 -0700
IronPort-SDR: scpZNHuQAquY5BZHrw9dys84tZRFSJT1mTDvjCfvT4iE9aiLMKrVCQeJnxjMbMNMNFXEQ+j5Fi
 TjfLfAcqfu2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,381,1589266800"; 
   d="scan'208";a="392542213"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jul 2020 19:48:40 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 1/1] iommu/vt-d: Rename intel-pasid.h to pasid.h
Date:   Wed, 22 Jul 2020 10:43:48 +0800
Message-Id: <20200722024348.5893-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Intel VT-d files have been move to its own subdirectory, the prefix
makes no sense.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/debugfs.c                  | 2 +-
 drivers/iommu/intel/iommu.c                    | 2 +-
 drivers/iommu/intel/pasid.c                    | 2 +-
 drivers/iommu/intel/{intel-pasid.h => pasid.h} | 2 +-
 drivers/iommu/intel/svm.c                      | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/iommu/intel/{intel-pasid.h => pasid.h} (98%)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index cf1ebb98e418..efea7f02abd9 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -15,7 +15,7 @@
 
 #include <asm/irq_remapping.h>
 
-#include "intel-pasid.h"
+#include "pasid.h"
 
 struct tbl_walk {
 	u16 bus;
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 5228f2c18a90..60de9daea62e 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -48,7 +48,7 @@
 #include <trace/events/intel_iommu.h>
 
 #include "../irq_remapping.h"
-#include "intel-pasid.h"
+#include "pasid.h"
 
 #define ROOT_SIZE		VTD_PAGE_SIZE
 #define CONTEXT_SIZE		VTD_PAGE_SIZE
diff --git a/drivers/iommu/intel/pasid.c b/drivers/iommu/intel/pasid.c
index fa0154cce537..e6faedf42fd4 100644
--- a/drivers/iommu/intel/pasid.c
+++ b/drivers/iommu/intel/pasid.c
@@ -19,7 +19,7 @@
 #include <linux/pci-ats.h>
 #include <linux/spinlock.h>
 
-#include "intel-pasid.h"
+#include "pasid.h"
 
 /*
  * Intel IOMMU system wide PASID name space:
diff --git a/drivers/iommu/intel/intel-pasid.h b/drivers/iommu/intel/pasid.h
similarity index 98%
rename from drivers/iommu/intel/intel-pasid.h
rename to drivers/iommu/intel/pasid.h
index c5318d40e0fa..c9850766c3a9 100644
--- a/drivers/iommu/intel/intel-pasid.h
+++ b/drivers/iommu/intel/pasid.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * intel-pasid.h - PASID idr, table and entry header
+ * pasid.h - PASID idr, table and entry header
  *
  * Copyright (C) 2018 Intel Corporation
  *
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 85ce8daa3177..442623ac4b47 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -20,7 +20,7 @@
 #include <linux/ioasid.h>
 #include <asm/page.h>
 
-#include "intel-pasid.h"
+#include "pasid.h"
 
 static irqreturn_t prq_event_thread(int irq, void *d);
 static void intel_svm_drain_prq(struct device *dev, int pasid);
-- 
2.17.1

