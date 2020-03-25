Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C64C2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8F8F2078E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 17:50:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727927AbgCYRuG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 13:50:06 -0400
Received: from mga12.intel.com ([192.55.52.136]:57499 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728087AbgCYRtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 13:49:50 -0400
IronPort-SDR: O7XRHf6Ahtaea6zGPr4QdfPexKshWYQqzEbHcopNAX6qdo0SC7HXmLiJJ4OIMLQu+MQvhMUdWb
 8M6fswOgpbwQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2020 10:49:49 -0700
IronPort-SDR: CQcA4JfLofRhka9mtUoO5weYjq8bYXaqfofvwTmcPeq2yb9H07yQUMSHv1MIURjk8A/LyZUmQk
 OZG9AbxWJlwQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,305,1580803200"; 
   d="scan'208";a="393702214"
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
Subject: [PATCH 08/10] iommu/ioasid: Introduce notifier APIs
Date:   Wed, 25 Mar 2020 10:55:29 -0700
Message-Id: <1585158931-1825-9-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1585158931-1825-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOASID users fit into the publisher-subscriber pattern, a system wide
blocking notifier chain can be used to inform subscribers of state
changes. Notifier mechanism also abstracts publisher from knowing the
private context each subcriber may have.

This patch adds APIs and a global notifier chain, a further optimization
might be per set notifier for ioasid_set aware users.

Usage example:
KVM register notifier block such that it can keep its guest-host PASID
translation table in sync with any IOASID updates.

VFIO publish IOASID change by performing alloc/free, bind/unbind
operations.

IOMMU driver gets notified when IOASID is freed by VFIO or core mm code
such that PASID context can be cleaned up.

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 61 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 8612fe6477dc..27dce2cb5af2 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -11,6 +11,22 @@
 #include <linux/xarray.h>
 
 static DEFINE_XARRAY_ALLOC(ioasid_sets);
+/*
+ * An IOASID could have multiple consumers. When a status change occurs,
+ * this notifier chain is used to keep them in sync. Each consumer of the
+ * IOASID service must register notifier block early to ensure no events
+ * are missed.
+ *
+ * This is a publisher-subscriber pattern where publisher can change the
+ * state of each IOASID, e.g. alloc/free, bind IOASID to a device and mm.
+ * On the other hand, subscribers gets notified for the state change and
+ * keep local states in sync.
+ *
+ * Currently, the notifier is global. A further optimization could be per
+ * IOASID set notifier chain.
+ */
+static BLOCKING_NOTIFIER_HEAD(ioasid_chain);
+
 /**
  * struct ioasid_set_data - Meta data about ioasid_set
  *
@@ -408,6 +424,7 @@ static void ioasid_free_locked(ioasid_t ioasid)
 {
 	struct ioasid_data *ioasid_data;
 	struct ioasid_set_data *sdata;
+	struct ioasid_nb_args args;
 
 	ioasid_data = xa_load(&active_allocator->xa, ioasid);
 	if (!ioasid_data) {
@@ -415,6 +432,13 @@ static void ioasid_free_locked(ioasid_t ioasid)
 		return;
 	}
 
+	args.id = ioasid;
+	args.sid = ioasid_data->sdata->sid;
+	args.pdata = ioasid_data->private;
+	args.set_token = ioasid_data->sdata->token;
+
+	/* Notify all users that this IOASID is being freed */
+	blocking_notifier_call_chain(&ioasid_chain, IOASID_FREE, &args);
 	active_allocator->ops->free(ioasid, active_allocator->ops->pdata);
 	/* Custom allocator needs additional steps to free the xa element */
 	if (active_allocator->flags & IOASID_ALLOCATOR_CUSTOM) {
@@ -624,6 +648,43 @@ int ioasid_find_sid(ioasid_t ioasid)
 }
 EXPORT_SYMBOL_GPL(ioasid_find_sid);
 
+int ioasid_add_notifier(struct notifier_block *nb)
+{
+	return blocking_notifier_chain_register(&ioasid_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_add_notifier);
+
+void ioasid_remove_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&ioasid_chain, nb);
+}
+EXPORT_SYMBOL_GPL(ioasid_remove_notifier);
+
+int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd)
+{
+	struct ioasid_data *ioasid_data;
+	struct ioasid_nb_args args;
+	int ret = 0;
+
+	mutex_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+	if (!ioasid_data) {
+		pr_err("Trying to free unknown IOASID %u\n", ioasid);
+		mutex_unlock(&ioasid_allocator_lock);
+		return -EINVAL;
+	}
+
+	args.id = ioasid;
+	args.sid = ioasid_data->sdata->sid;
+	args.pdata = ioasid_data->private;
+
+	ret = blocking_notifier_call_chain(&ioasid_chain, cmd, &args);
+	mutex_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_notify);
+
 MODULE_AUTHOR("Jean-Philippe Brucker <jean-philippe.brucker@arm.com>");
 MODULE_AUTHOR("Jacob Pan <jacob.jun.pan@linux.intel.com>");
 MODULE_DESCRIPTION("IO Address Space ID (IOASID) allocator");
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index e19c0ad93bd7..32d032913828 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -4,6 +4,7 @@
 
 #include <linux/types.h>
 #include <linux/errno.h>
+#include <linux/notifier.h>
 
 #define INVALID_IOASID ((ioasid_t)-1)
 #define INVALID_IOASID_SET (-1)
@@ -30,6 +31,27 @@ struct ioasid_allocator_ops {
 	void *pdata;
 };
 
+/* Notification data when IOASID status changed */
+enum ioasid_notify_val {
+	IOASID_ALLOC = 1,
+	IOASID_FREE,
+	IOASID_BIND,
+	IOASID_UNBIND,
+};
+
+/**
+ * struct ioasid_nb_args - Argument provided by IOASID core when notifier
+ * is called.
+ * @id:		the IOASID being notified
+ * @sid:	the IOASID set @id belongs to
+ * @pdata:	the private data attached to the IOASID
+ */
+struct ioasid_nb_args {
+	ioasid_t id;
+	int sid;
+	struct ioasid_set *set_token;
+	void *pdata;
+};
 /* Shared IOASID set for reserved for host system use */
 extern int system_ioasid_sid;
 
@@ -43,11 +65,15 @@ void *ioasid_find(int sid, ioasid_t ioasid, bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 int ioasid_attach_data(ioasid_t ioasid, void *data);
+int ioasid_add_notifier(struct notifier_block *nb);
+void ioasid_remove_notifier(struct notifier_block *nb);
 void ioasid_install_capacity(ioasid_t total);
 int ioasid_alloc_system_set(int quota);
 int ioasid_alloc_set(struct ioasid_set *token, ioasid_t quota, int *sid);
 void ioasid_free_set(int sid, bool destroy_set);
 int ioasid_find_sid(ioasid_t ioasid);
+int ioasid_notify(ioasid_t id, enum ioasid_notify_val cmd);
+
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(int sid, ioasid_t min,
 				    ioasid_t max, void *private)
@@ -73,6 +99,20 @@ static inline void *ioasid_find(int sid, ioasid_t ioasid, bool (*getter)(void *)
 	return NULL;
 }
 
+static inline int ioasid_add_notifier(struct notifier_block *nb)
+{
+	return -ENOTSUPP;
+}
+
+static inline void ioasid_remove_notifier(struct notifier_block *nb)
+{
+}
+
+int ioasid_notify(ioasid_t ioasid, enum ioasid_notify_val cmd)
+{
+	return -ENOTSUPP;
+}
+
 static inline int ioasid_register_allocator(struct ioasid_allocator_ops *allocator)
 {
 	return -ENOTSUPP;
-- 
2.7.4

