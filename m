Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B3A8C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BC6B2071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vYnopaOd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729257AbgHaSSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:18:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729623AbgHaSSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:21 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D084C061573
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:20 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id z15so3458790plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X8w/zoyDm7STrfSjeUJijWigenQyydijn+iIkzb3q24=;
        b=vYnopaOdNnS7+NIItBZSxff6fADrxen+MHc7SlnKp9vwSI5AjdhlpcbctmhdOGJaPZ
         gL9Kj2Qkwsn6CdzYmj5TGtlLE7vIkaNMXP98RebxtaaVefc5UxG+ZZlyVD484KTVVGOa
         goL7dBpatc5JhJO1thu1WdwDLgLDpvGGWTA+g6/cgwzrHzM2Gn6zzU7ZG/cTgJK592As
         +54jvyXt5HpRoOp3X107lmkT1JUYHviQsPiXGXH9tHMDkqnKL2VFBC/mwQgC6ALKRP3D
         O0Oki7HXCgfx9LBWYKh4b4Clqe2NYEJVOKTI43GY9e2FgD8CaK9OGj5OTU/VTJ8TREvh
         qozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X8w/zoyDm7STrfSjeUJijWigenQyydijn+iIkzb3q24=;
        b=VHBQcHcXYnQLQebdXl6bf77iGsp8Pl8oZlbP3gG5yCApM9aVWggSLPnGa+8jw6Hn68
         4coFmVNDaRUGtBMYfzSd9Cq97TXI15t5jcb7FBlQbUw3dY7qMroFY62TW8VL1kzbYqfl
         stP+rtPARvh2f12OgY0U/liZDSOlkGJQC5P2b82yVavG1X52y7ny6GBAio2NgayqyR1T
         iaRWP84dQtoCEDetl2nqIKR1bGsdN79qu7kvPgkkS5olEQ2MLB4S85ZxNzBeF+mSCaLR
         FpmFCZNICE55z3ncyt75mFzgo8XSvKQsVdexGvvzux8WazqDiH+Td/XU0miuBOyVmUYR
         Zzrw==
X-Gm-Message-State: AOAM533Ohfq+Hw5PqfOKLrL80dsLam2zkBnwHJ5q8CnPED2b7PnYwXjb
        IV4CLkAAILSd86DXJ0gERozPafBcqlI=
X-Google-Smtp-Source: ABdhPJwNEWW2Ymdpqg4NAx41GhNDrKezooaq7QH3S0f2gK00emLw//18jMGD0eDQyynTp0J5FwjlHw==
X-Received: by 2002:a17:90b:fd0:: with SMTP id gd16mr546460pjb.122.1598897899845;
        Mon, 31 Aug 2020 11:18:19 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:18:19 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>
Cc:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v8 7/7] iommu/vt-d: Check UAPI data processed by IOMMU core
Date:   Mon, 31 Aug 2020 11:25:00 -0700
Message-Id: <1598898300-65475-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU generic layer already does sanity checks on UAPI data for version
match and argsz range based on generic information.

This patch adjusts the following data checking responsibilities:
- removes the redundant version check from VT-d driver
- removes the check for vendor specific data size
- adds check for the use of reserved/undefined flags

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/iommu.c |  3 +--
 drivers/iommu/intel/svm.c   | 11 +++++++++--
 include/uapi/linux/iommu.h  |  1 +
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index 43f16f0cebde..a3a0b5c8921d 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -5399,8 +5399,7 @@ intel_iommu_sva_invalidate(struct iommu_domain *domain, struct device *dev,
 	int ret = 0;
 	u64 size = 0;
 
-	if (!inv_info || !dmar_domain ||
-	    inv_info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+	if (!inv_info || !dmar_domain)
 		return -EINVAL;
 
 	if (!dev || !dev_is_pci(dev))
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 99353d6468fa..0cb9a15f1112 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -284,8 +284,15 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	if (WARN_ON(!iommu) || !data)
 		return -EINVAL;
 
-	if (data->version != IOMMU_GPASID_BIND_VERSION_1 ||
-	    data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+	if (data->format != IOMMU_PASID_FORMAT_INTEL_VTD)
+		return -EINVAL;
+
+	/* IOMMU core ensures argsz is more than the start of the union */
+	if (data->argsz < offsetofend(struct iommu_gpasid_bind_data, vendor.vtd))
+		return -EINVAL;
+
+	/* Make sure no undefined flags are used in vendor data */
+	if (data->vendor.vtd.flags & ~(IOMMU_SVA_VTD_GPASID_LAST - 1))
 		return -EINVAL;
 
 	if (!dev_is_pci(dev))
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index c64bca5af419..1ebc23df4fbc 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -288,6 +288,7 @@ struct iommu_gpasid_bind_data_vtd {
 #define IOMMU_SVA_VTD_GPASID_PWT	(1 << 3) /* page-level write through */
 #define IOMMU_SVA_VTD_GPASID_EMTE	(1 << 4) /* extended mem type enable */
 #define IOMMU_SVA_VTD_GPASID_CD		(1 << 5) /* PASID-level cache disable */
+#define IOMMU_SVA_VTD_GPASID_LAST	(1 << 6)
 	__u64 flags;
 	__u32 pat;
 	__u32 emt;
-- 
2.7.4

