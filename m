Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D0AC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEEC52077D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728239AbgCYRuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:50:20 -0400
Received: from mga12.intel.com ([192.55.52.136]:57497 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727598AbgCYRts (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:49:48 -0400
IronPort-SDR: iFyAg+p8GndWxSa7YpPX79J0L1iVz6OqLYllNjKG5Qe+GAfHEFIzqa5zXvE8UgNHOIdj3ez2Ue
 NdpM45AlD8ww==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 10:49:48 -0700
IronPort-SDR: gK1wmmwqeK4agq8zNREBwbScLDnRsT0KZSI7TdG8RN5Jy2deYT3WqOrWRO1IKTEOWP8sXpXhIl
 ojS0NNzY/jGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="393702190"
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
Subject: [PATCH 01/10] iommu/ioasid: Introduce system-wide capacity
Date:   Wed, 25 Mar 2020 10:55:22 -0700
Message-Id: <1585158931-1825-2-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASID is a limited system-wide resource that can be allocated at
runtime. This limitation can be enumerated during boot. For example, on
x86 platforms, PCI Process Address Space ID (PASID) allocation uses
IOASID service. The number of supported PASID bits are enumerated by
extended capability register as defined in the VT-d spec.

This patch adds a helper to set the system capacity, it expected to be
set during boot prior to any allocation request.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 15 +++++++++++++++
 include/linux/ioasid.h |  5 ++++-
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 0f8dd377aada..4026e52855b9 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -17,6 +17,21 @@ struct ioasid_data {
 	struct rcu_head rcu;
 };
 
+static ioasid_t ioasid_capacity;
+static ioasid_t ioasid_capacity_avail;
+
+/* System capacity can only be set once */
+void ioasid_install_capacity(ioasid_t total)
+{
+	if (ioasid_capacity) {
+		pr_warn("IOASID capacity already set at %d\n", ioasid_capacity);
+		return;
+	}
+
+	ioasid_capacity = ioasid_capacity_avail = total;
+}
+EXPORT_SYMBOL_GPL(ioasid_install_capacity);
+
 /*
  * struct ioasid_allocator_data - Internal data structure to hold information
  * about an allocator. There are two types of allocators:
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f000d7a0ddc..9711fa0dc357 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -40,7 +40,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_set_data(ioasid_t ioasid, void *data);
-
+void ioasid_install_capacity(ioasid_t total);
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
 				    ioasid_t max, void *private)
@@ -72,5 +72,8 @@ static inline int ioasid_set_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+static inline void ioasid_install_capacity(ioasid_t total)
+{
+}
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

