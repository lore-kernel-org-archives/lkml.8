Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9718C2D0E6
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BF62077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgCYRuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:50:04 -0400
Received: from mga12.intel.com ([192.55.52.136]:57497 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728078AbgCYRtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:49:50 -0400
IronPort-SDR: PtnMxi2P0rxLgT6FNdDh6ehoTXVLl0KuSZPkNNRK7hq+jal0Ew8MVBuFL3AIgRvf5VTHvoqcu2
 wKS15T6eDwiQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 10:49:49 -0700
IronPort-SDR: qKTvv5GSnA5h7dqv9DnrGdJZqJU8gD7hexGiDDXFQy5yYIbC1AU2gRqGWsrAJcoHVEJFEkb3MK
 ICEdMvGeLV8Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="393702216"
Received: from jacob-builder.jf.intel.com ([10.7.199.155])
  by orsmga004.jf.intel.com with ESMTP; 25 Mar 2020 10:49:48 -0700
From:   Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     Joerg Roedel <joro@8bytes.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>
Cc:     "Yi Liu" <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH 09/10] iommu/ioasid: Support ioasid_set quota adjustment
Date:   Wed, 25 Mar 2020 10:55:30 -0700
Message-Id: <1585158931-1825-10-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASID set is allocated with an initial quota, at runtime there may be
needs to balance IOASID resources among different VMs/sets.

This patch adds a new API to adjust per set quota.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |  6 ++++++
 2 files changed, 50 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 27dce2cb5af2..5ac28862a1db 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -578,6 +578,50 @@ void ioasid_free_set(int sid, bool destroy_set)
 }
 EXPORT_SYMBOL_GPL(ioasid_free_set);
 
+/**
+ * ioasid_adjust_set - Adjust the quota of an IOASID set
+ * @quota:	Quota allowed in this set
+ * @sid:	IOASID set ID to be assigned
+ *
+ * Return 0 on success. If the new quota is smaller than the number of
+ * IOASIDs already allocated, -EINVAL will be returned. No change will be
+ * made to the existing quota.
+ */
+int ioasid_adjust_set(int sid, int quota)
+{
+	struct ioasid_set_data *sdata;
+	int ret = 0;
+
+	mutex_lock(&ioasid_allocator_lock);
+	sdata = xa_load(&ioasid_sets, sid);
+	if (!sdata || sdata->nr_ioasids > quota) {
+		pr_err("Failed to adjust IOASID set %d quota %d\n",
+			sid, quota);
+		ret = -EINVAL;
+		goto done_unlock;
+	}
+
+	if (quota >= ioasid_capacity_avail) {
+		ret = -ENOSPC;
+		goto done_unlock;
+	}
+
+	/* Return the delta back to system pool */
+	ioasid_capacity_avail += sdata->size - quota;
+
+	/*
+	 * May have a policy to prevent giving all available IOASIDs
+	 * to one set. But we don't enforce here, it should be in the
+	 * upper layers.
+	 */
+	sdata->size = quota;
+
+done_unlock:
+	mutex_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_adjust_set);
 
 /**
  * ioasid_find - Find IOASID data
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 32d032913828..6e7de6fb91bf 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,6 +73,7 @@ int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
 void ioasid_free_set(int sid, bool destroy_set);
 int ioasid_find_sid(ioasid_t ioasid);
 int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
+int ioasid_adjust_set(int sid, int quota);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
@@ -136,5 +137,10 @@ static inline int ioasid_alloc_system_set(int quota)
 	return -ENOTSUPP;
 }
 
+static inline int ioasid_adjust_set(int sid, int quota)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

