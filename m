Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDA0C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF23B2063A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 05:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgA2F5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 00:57:25 -0500
Received: from mga05.intel.com ([192.55.52.43]:23417 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726091AbgA2F4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 00:56:43 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jan 2020 21:56:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,376,1574150400"; 
   d="scan'208";a="222346518"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga008.jf.intel.com with ESMTP; 28 Jan 2020 21:56:41 -0800
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH V9 02/10] iommu/uapi: Define a mask for bind data
Date:   Tue, 28 Jan 2020 22:01:45 -0800
Message-Id: <1580277713-66934-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1580277713-66934-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory type related guest PASID bind data can be grouped together for
one simple check.
Link: https://lore.kernel.org/linux-iommu/20200109095123.17ed5e6b@jacob-builder/

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 4ad3496e5c43..fcafb6401430 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -284,7 +284,10 @@ struct iommu_gpasid_bind_data_vtd {
 	__u32 pat;
 	__u32 emt;
 };
-
+#define IOMMU_SVA_VTD_GPASID_EMT_MASK	(IOMMU_SVA_VTD_GPASID_CD | \
+					 IOMMU_SVA_VTD_GPASID_EMTE | \
+					 IOMMU_SVA_VTD_GPASID_PCD |  \
+					 IOMMU_SVA_VTD_GPASID_PWT)
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
  * @version:	Version of this data structure
-- 
2.7.4

