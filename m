Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F0C4C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D49B207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QBdxPzMW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbgHVE3O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgHVE2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:28:33 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BFA5C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:33 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id o13so1953901pgf.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=87kAejLSZtdI5TJfy/HhQEBqd/O3XWuFJNQpO9tWsn0=;
        b=QBdxPzMWHJRHFtdLQzyjyd3z7TGbM8K4E4ZJc9fvUjGsK1002qAxkmyD8/RfNk6Mrx
         /Pb2/vT++kIHM4uXocCqT8/CiBm4wfhX4rKHz+RkR0h5irzAU6LFdUqX+7JLnAU+1FkD
         C8KefT6Ki6nzS9QrP96NOHk903Wpb0TNjELC9H2fbGMpfycK28LhaYv+TwH/QFNwJCKs
         JAeJEEWZGEVjPRcboPvPnFy480VaWEgY3xnIvGuolFnzYy+dS+08rdF6nHcNAmanFfKB
         DyaR3l62zOlR2dFDFI61EOmT/8kjESAeJWAyEVsT9rxnYkEZMf1crrGXQEKRucKfSztk
         fBEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=87kAejLSZtdI5TJfy/HhQEBqd/O3XWuFJNQpO9tWsn0=;
        b=UmgMcoM7vdCDZVcDp+mnrOda/d0yYsfj7MNwvFzFqHLMlFil21ysvyLK+eZiogvW92
         zJrOr/gIgaeFKPgEEAsxNdi2YiozWf6aUsQ31QR8DiPdBRSfMN6PLK79H363KoSyB0Tr
         reZH8xQis//kg+lY2xD9PMilFFzv0PtlywlE8nPOtOKnfpuftMj9RVSmEuN0G4ctbWFf
         CjaGWC74pfAgwYQpRz7PY2h8LE7CBo5wPBdBNHUYPhGeWVgRZywLY9bm5cYbvG+MKBow
         vk6lu61z+ZnALFeIwmid7Xkprmx5gQ1oA7sbDPEsvVV85VGhDbyc6gr6z6N2oBs4mbkY
         YHgw==
X-Gm-Message-State: AOAM533I0TKx1A/jMvKMNfI0u4JehD9Is2IoMb3jD79EgUMUPXXbQjNe
        AZb8lN/dox/Ycn7nsYMlCEI=
X-Google-Smtp-Source: ABdhPJz62OSM+1HVr8xtL0W6SFZH6xT+ySwXJCPbRPqPhJe/40wWBsl+syDPnCRQHoOlIZ3xIgsBuA==
X-Received: by 2002:a62:164a:: with SMTP id 71mr5054237pfw.266.1598070512576;
        Fri, 21 Aug 2020 21:28:32 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:28:32 -0700 (PDT)
From:   Jacob Pan <jacob.pan.linux@gmail.com>
X-Google-Original-From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        "Lu Baolu" <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        David Woodhouse <dwmw2@infradead.org>
Cc:     Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        Eric Auger <eric.auger@redhat.com>, Wu Hao <hao.wu@intel.com>
Subject: [PATCH v2 7/9] iommu/vt-d: Listen to IOASID notifications
Date:   Fri, 21 Aug 2020 21:35:16 -0700
Message-Id: <1598070918-21321-8-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Intel Scalable I/O Virtualization (SIOV) enabled platforms, IOMMU
driver is one of the users of IOASIDs. In normal flow, callers will
perform IOASID allocation, bind, unbind, and free in order. However, for
guest SVA, IOASID free could come before unbind as guest is untrusted.
This patch registers IOASID notification handler such that IOMMU driver
can perform PASID teardown upon receiving an unexpected IOASID free
event.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c   | 74 ++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/intel-iommu.h |  2 ++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 634e191ca2c3..600e3ae5b656 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -95,6 +95,72 @@ static inline bool intel_svm_capable(struct intel_iommu *iommu)
 	return iommu->flags & VTD_FLAG_SVM_CAPABLE;
 }
 
+#define pasid_lock_held() lock_is_held(&pasid_mutex.dep_map)
+static DEFINE_MUTEX(pasid_mutex);
+
+static void intel_svm_free_async_fn(struct work_struct *work)
+{
+	struct intel_svm *svm = container_of(work, struct intel_svm, work);
+	struct intel_svm_dev *sdev;
+
+	/*
+	 * Unbind all devices associated with this PASID which is
+	 * being freed by other users such as VFIO.
+	 */
+	mutex_lock(&pasid_mutex);
+	list_for_each_entry_rcu(sdev, &svm->devs, list, pasid_lock_held()) {
+		/* Does not poison forward pointer */
+		list_del_rcu(&sdev->list);
+		spin_lock(&svm->iommu->lock);
+		intel_pasid_tear_down_entry(svm->iommu, sdev->dev,
+					svm->pasid, true);
+		spin_unlock(&svm->iommu->lock);
+		kfree_rcu(sdev, rcu);
+		/*
+		 * Free before unbind only happens with guest usaged
+		 * host PASIDs. IOASID free will detach private data
+		 * and free the IOASID entry.
+		 */
+		ioasid_put(NULL, svm->pasid);
+		if (list_empty(&svm->devs))
+			kfree(svm);
+	}
+	mutex_unlock(&pasid_mutex);
+}
+
+
+static int pasid_status_change(struct notifier_block *nb,
+				unsigned long code, void *data)
+{
+	struct ioasid_nb_args *args = (struct ioasid_nb_args *)data;
+	struct intel_svm *svm = (struct intel_svm *)args->pdata;
+	int ret = NOTIFY_DONE;
+
+	if (code == IOASID_FREE) {
+		if (!svm)
+			goto done;
+		if (args->id != svm->pasid) {
+			pr_warn("Notify PASID does not match data %d : %d\n",
+				args->id, svm->pasid);
+			goto done;
+		}
+		schedule_work(&svm->work);
+		return NOTIFY_OK;
+	}
+done:
+	return ret;
+}
+
+static struct notifier_block pasid_nb = {
+	.notifier_call = pasid_status_change,
+};
+
+void intel_svm_add_pasid_notifier(void)
+{
+	/* Listen to all PASIDs, not specific to a set */
+	ioasid_register_notifier(NULL, &pasid_nb);
+}
+
 void intel_svm_check(struct intel_iommu *iommu)
 {
 	if (!pasid_supported(iommu))
@@ -221,7 +287,6 @@ static const struct mmu_notifier_ops intel_mmuops = {
 	.invalidate_range = intel_invalidate_range,
 };
 
-static DEFINE_MUTEX(pasid_mutex);
 static LIST_HEAD(global_svm_list);
 
 #define for_each_svm_dev(sdev, svm, d)			\
@@ -342,7 +407,14 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
+		svm->iommu = iommu;
+		/*
+		 * Set up cleanup async work in case IOASID core notify us PASID
+		 * is freed before unbind.
+		 */
+		INIT_WORK(&svm->work, intel_svm_free_async_fn);
 		ioasid_attach_data(data->hpasid, svm);
+		ioasid_get(NULL, svm->pasid);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 		mmput(svm->mm);
 	}
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index b1ed2f25f7c0..d36038e6ae0b 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -744,6 +744,7 @@ void intel_svm_unbind(struct iommu_sva *handle);
 int intel_svm_get_pasid(struct iommu_sva *handle);
 int intel_svm_page_response(struct device *dev, struct iommu_fault_event *evt,
 			    struct iommu_page_response *msg);
+void intel_svm_add_pasid_notifier(void);
 
 struct svm_dev_ops;
 
@@ -770,6 +771,7 @@ struct intel_svm {
 	int gpasid; /* In case that guest PASID is different from host PASID */
 	struct list_head devs;
 	struct list_head list;
+	struct work_struct work; /* For deferred clean up */
 };
 #else
 static inline void intel_svm_check(struct intel_iommu *iommu) {}
-- 
2.7.4

