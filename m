Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 595A8C54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F20520735
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 18:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgDUSqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 14:46:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:19074 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725870AbgDUSqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 14:46:49 -0400
IronPort-SDR: KPAw5Fk760DiDEjjkXyim4YQDcM2HNNIPoeHNSMRQQngwytiYWM7ykZ6OtN91w5LkYonCXzqeB
 rW+Q0TCzhUdw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 11:46:49 -0700
IronPort-SDR: FKstTcYzg9UVqpN2Pu8Uj1E55yW02DfEITIoFyOQ4ADGVcK7x95LKRQ0Zp1G5ElY495PdT8GwN
 ysN6+C8Rq1xA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,411,1580803200"; 
   d="scan'208";a="334367888"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga001.jf.intel.com with ESMTP; 21 Apr 2020 11:46:48 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Eric Auger <eric.auger@redhat.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v12 7/8] iommu/vt-d: Enlightened PASID allocation
Date:   Tue, 21 Apr 2020 11:52:44 -0700
Message-Id: <1587495165-80096-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1587495165-80096-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

Enabling IOMMU in a guest requires communication with the host
driver for certain aspects. Use of PASID ID to enable Shared Virtual
Addressing (SVA) requires managing PASID's in the host. VT-d 3.0 spec
provides a Virtual Command Register (VCMD) to facilitate this.
Writes to this register in the guest are trapped by vIOMMU which
proxies the call to the host driver.

This virtual command interface consists of a capability register,
a virtual command register, and a virtual response register. Refer
to section 10.4.42, 10.4.43, 10.4.44 for more information.

This patch adds the enlightened PASID allocation/free interfaces
via the virtual command interface.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/intel-pasid.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/iommu/intel-pasid.h | 13 ++++++++++-
 include/linux/intel-iommu.h |  1 +
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-pasid.c b/drivers/iommu/intel-pasid.c
index 708bfa08a3d7..5cfe44f8824a 100644
--- a/drivers/iommu/intel-pasid.c
+++ b/drivers/iommu/intel-pasid.c
@@ -27,6 +27,63 @@
 static DEFINE_SPINLOCK(pasid_lock);
 u32 intel_pasid_max_id = PASID_MAX;
 
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid)
+{
+	unsigned long flags;
+	u8 status_code;
+	int ret = 0;
+	u64 res;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	dmar_writeq(iommu->reg + DMAR_VCMD_REG, VCMD_CMD_ALLOC);
+	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
+		      !(res & VCMD_VRSP_IP), res);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	status_code = VCMD_VRSP_SC(res);
+	switch (status_code) {
+	case VCMD_VRSP_SC_SUCCESS:
+		*pasid = VCMD_VRSP_RESULT_PASID(res);
+		break;
+	case VCMD_VRSP_SC_NO_PASID_AVAIL:
+		pr_info("IOMMU: %s: No PASID available\n", iommu->name);
+		ret = -ENOSPC;
+		break;
+	default:
+		ret = -ENODEV;
+		pr_warn("IOMMU: %s: Unexpected error code %d\n",
+			iommu->name, status_code);
+	}
+
+	return ret;
+}
+
+void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid)
+{
+	unsigned long flags;
+	u8 status_code;
+	u64 res;
+
+	raw_spin_lock_irqsave(&iommu->register_lock, flags);
+	dmar_writeq(iommu->reg + DMAR_VCMD_REG,
+		    VCMD_CMD_OPERAND(pasid) | VCMD_CMD_FREE);
+	IOMMU_WAIT_OP(iommu, DMAR_VCRSP_REG, dmar_readq,
+		      !(res & VCMD_VRSP_IP), res);
+	raw_spin_unlock_irqrestore(&iommu->register_lock, flags);
+
+	status_code = VCMD_VRSP_SC(res);
+	switch (status_code) {
+	case VCMD_VRSP_SC_SUCCESS:
+		break;
+	case VCMD_VRSP_SC_INVALID_PASID:
+		pr_info("IOMMU: %s: Invalid PASID\n", iommu->name);
+		break;
+	default:
+		pr_warn("IOMMU: %s: Unexpected error code %d\n",
+			iommu->name, status_code);
+	}
+}
+
 /*
  * Per device pasid table management:
  */
diff --git a/drivers/iommu/intel-pasid.h b/drivers/iommu/intel-pasid.h
index ccd50c2ae75c..a41b09b3ffde 100644
--- a/drivers/iommu/intel-pasid.h
+++ b/drivers/iommu/intel-pasid.h
@@ -23,6 +23,16 @@
 #define is_pasid_enabled(entry)		(((entry)->lo >> 3) & 0x1)
 #define get_pasid_dir_size(entry)	(1 << ((((entry)->lo >> 9) & 0x7) + 7))
 
+/* Virtual command interface for enlightened pasid management. */
+#define VCMD_CMD_ALLOC			0x1
+#define VCMD_CMD_FREE			0x2
+#define VCMD_VRSP_IP			0x1
+#define VCMD_VRSP_SC(e)			(((e) >> 1) & 0x3)
+#define VCMD_VRSP_SC_SUCCESS		0
+#define VCMD_VRSP_SC_NO_PASID_AVAIL	1
+#define VCMD_VRSP_SC_INVALID_PASID	1
+#define VCMD_VRSP_RESULT_PASID(e)	(((e) >> 8) & 0xfffff)
+#define VCMD_CMD_OPERAND(e)		((e) << 8)
 /*
  * Domain ID reserved for pasid entries programmed for first-level
  * only and pass-through transfer modes.
@@ -111,5 +121,6 @@ int intel_pasid_setup_nested(struct intel_iommu *iommu,
 			     struct dmar_domain *domain, int addr_width);
 void intel_pasid_tear_down_entry(struct intel_iommu *iommu,
 				 struct device *dev, int pasid);
-
+int vcmd_alloc_pasid(struct intel_iommu *iommu, unsigned int *pasid);
+void vcmd_free_pasid(struct intel_iommu *iommu, unsigned int pasid);
 #endif /* __INTEL_PASID_H */
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 9a44245c0f7d..1af16c6d3aec 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -169,6 +169,7 @@
 #define ecap_smpwc(e)		(((e) >> 48) & 0x1)
 #define ecap_flts(e)		(((e) >> 47) & 0x1)
 #define ecap_slts(e)		(((e) >> 46) & 0x1)
+#define ecap_vcs(e)		(((e) >> 44) & 0x1)
 #define ecap_smts(e)		(((e) >> 43) & 0x1)
 #define ecap_dit(e)		((e >> 41) & 0x1)
 #define ecap_pasid(e)		((e >> 40) & 0x1)
-- 
2.7.4

