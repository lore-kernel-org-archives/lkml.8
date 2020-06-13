Return-Path: <SRS0=WLRa=72=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D93C7C433E5
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:41:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEFED2078A
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jun 2020 00:41:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFMAl6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 20:41:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:1255 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbgFMAlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 20:41:51 -0400
IronPort-SDR: 3MNeMiOnMiaPbUkhhASalPXWfMUksW2Z7dDi3++50byWLisj4cYE/ZrcsxRK0e6H4dx4YR6wNf
 o+ot7TbWijEQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 17:41:50 -0700
IronPort-SDR: tnhfQIap+R/wlIbrejzdm1S7eZ42d+agf8wc228PItBDg/FKCIX3l/63B84mb6s8EIb1X8t7ir
 TNsFHTh1YqfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,505,1583222400"; 
   d="scan'208";a="261011196"
Received: from romley-ivt3.sc.intel.com ([172.25.110.60])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2020 17:41:49 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "H Peter Anvin" <hpa@zytor.com>,
        "David Woodhouse" <dwmw2@infradead.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Frederic Barrat" <fbarrat@linux.ibm.com>,
        "Andrew Donnellan" <ajd@linux.ibm.com>,
        "Felix Kuehling" <Felix.Kuehling@amd.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Dave Hansen" <dave.hansen@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Ashok Raj" <ashok.raj@intel.com>,
        "Jacob Jun Pan" <jacob.jun.pan@intel.com>,
        "Dave Jiang" <dave.jiang@intel.com>,
        "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        "Sohil Mehta" <sohil.mehta@intel.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kernel" <linux-kernel@vger.kernel.org>,
        "x86" <x86@kernel.org>, iommu@lists.linux-foundation.org,
        "amd-gfx" <amd-gfx@lists.freedesktop.org>,
        "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2 03/12] iommu/vt-d: Change flags type to unsigned int in binding mm
Date:   Fri, 12 Jun 2020 17:41:24 -0700
Message-Id: <1592008893-9388-4-git-send-email-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
References: <1592008893-9388-1-git-send-email-fenghua.yu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"flags" passed to intel_svm_bind_mm() is a bit mask and should be
defined as "unsigned int" instead of "int".

Change its type to "unsigned int".

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
v2:
- Add this new patch per Thomas' comment.

 drivers/iommu/intel/svm.c   | 7 ++++---
 include/linux/intel-iommu.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b5618341b4b1..4e775e12ae52 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -427,7 +427,8 @@ int intel_svm_unbind_gpasid(struct device *dev, unsigned int pasid)
 
 /* Caller must hold pasid_mutex, mm reference */
 static int
-intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
+intel_svm_bind_mm(struct device *dev, unsigned int flags,
+		  struct svm_dev_ops *ops,
 		  struct mm_struct *mm, struct intel_svm_dev **sd)
 {
 	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
@@ -954,7 +955,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 {
 	struct iommu_sva *sva = ERR_PTR(-EINVAL);
 	struct intel_svm_dev *sdev = NULL;
-	int flags = 0;
+	unsigned int flags = 0;
 	int ret;
 
 	/*
@@ -963,7 +964,7 @@ intel_svm_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
 	 * and intel_svm etc.
 	 */
 	if (drvdata)
-		flags = *(int *)drvdata;
+		flags = *(unsigned int *)drvdata;
 	mutex_lock(&pasid_mutex);
 	ret = intel_svm_bind_mm(dev, flags, NULL, mm, &sdev);
 	if (ret)
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 44fa8879f829..9abc30cf10fc 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -759,7 +759,7 @@ struct intel_svm {
 	struct mm_struct *mm;
 
 	struct intel_iommu *iommu;
-	int flags;
+	unsigned int flags;
 	unsigned int pasid;
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
-- 
2.19.1

