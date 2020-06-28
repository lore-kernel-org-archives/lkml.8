Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E85EC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BE7B2076E
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 00:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726898AbgF1AiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 20:38:01 -0400
Received: from mga14.intel.com ([192.55.52.115]:54808 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgF1Ah6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 20:37:58 -0400
IronPort-SDR: 71Icy9lb9Jp3jJ0rhItllaW0I98Fs+oNvvkAI3sCvWxtlIWaC03YKkTICYYk8BWv3ZYTAdHnYD
 vXCe+Zmq1zAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9665"; a="144805157"
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="144805157"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2020 17:37:57 -0700
IronPort-SDR: 4LiVwBRrPEGlyqbBB3MiBnmShQUYMPE5poMADA2/ijxeQkmIy1XlDeoqbwMjmSL77LyGmaGZ9f
 MMfpEdFBGtQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,289,1589266800"; 
   d="scan'208";a="302695011"
Received: from allen-box.sh.intel.com ([10.239.159.139])
  by fmsmga004.fm.intel.com with ESMTP; 27 Jun 2020 17:37:55 -0700
From:   Lu Baolu <baolu.lu@linux.intel.com>
To:     iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Liu Yi L <yi.l.liu@intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Subject: [PATCH 2/4] iommu/vt-d: Add a helper to get svm and sdev for pasid
Date:   Sun, 28 Jun 2020 08:33:30 +0800
Message-Id: <20200628003332.5720-3-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200628003332.5720-1-baolu.lu@linux.intel.com>
References: <20200628003332.5720-1-baolu.lu@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places in the code that need to get the pointers of
svm and sdev according to a pasid and device. Add a helper to achieve
this for code consolidation and readability.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 121 +++++++++++++++++++++-----------------
 1 file changed, 68 insertions(+), 53 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index 25dd74f27252..c23167877b2b 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -228,6 +228,50 @@ static LIST_HEAD(global_svm_list);
 	list_for_each_entry((sdev), &(svm)->devs, list)	\
 		if ((d) != (sdev)->dev) {} else
 
+static int pasid_to_svm_sdev(struct device *dev, unsigned int pasid,
+			     struct intel_svm **rsvm,
+			     struct intel_svm_dev **rsdev)
+{
+	struct intel_svm_dev *d, *sdev = NULL;
+	struct intel_svm *svm;
+
+	/* The caller should hold the pasid_mutex lock */
+	if (WARN_ON(!mutex_is_locked(&pasid_mutex)))
+		return -EINVAL;
+
+	if (pasid == INVALID_IOASID || pasid >= PASID_MAX)
+		return -EINVAL;
+
+	svm = ioasid_find(NULL, pasid, NULL);
+	if (IS_ERR(svm))
+		return PTR_ERR(svm);
+
+	if (!svm)
+		goto out;
+
+	/*
+	 * If we found svm for the PASID, there must be at least one device
+	 * bond.
+	 */
+	if (WARN_ON(list_empty(&svm->devs)))
+		return -EINVAL;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(d, &svm->devs, list) {
+		if (d->dev == dev) {
+			sdev = d;
+			break;
+		}
+	}
+	rcu_read_unlock();
+
+out:
+	*rsvm = svm;
+	*rsdev = sdev;
+
+	return 0;
+}
+
 int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			  struct iommu_gpasid_bind_data *data)
 {
@@ -261,39 +305,27 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	dmar_domain = to_dmar_domain(domain);
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(NULL, data->hpasid, NULL);
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
+	ret = pasid_to_svm_sdev(dev, data->hpasid, &svm, &sdev);
+	if (ret)
 		goto out;
-	}
 
-	if (svm) {
+	if (sdev) {
 		/*
-		 * If we found svm for the PASID, there must be at
-		 * least one device bond, otherwise svm should be freed.
+		 * For devices with aux domains, we should allow
+		 * multiple bind calls with the same PASID and pdev.
 		 */
-		if (WARN_ON(list_empty(&svm->devs))) {
-			ret = -EINVAL;
-			goto out;
+		if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX)) {
+			sdev->users++;
+		} else {
+			dev_warn_ratelimited(dev,
+					     "Already bound with PASID %u\n",
+					     svm->pasid);
+			ret = -EBUSY;
 		}
+		goto out;
+	}
 
-		for_each_svm_dev(sdev, svm, dev) {
-			/*
-			 * For devices with aux domains, we should allow
-			 * multiple bind calls with the same PASID and pdev.
-			 */
-			if (iommu_dev_feature_enabled(dev,
-						      IOMMU_DEV_FEAT_AUX)) {
-				sdev->users++;
-			} else {
-				dev_warn_ratelimited(dev,
-						     "Already bound with PASID %u\n",
-						     svm->pasid);
-				ret = -EBUSY;
-			}
-			goto out;
-		}
-	} else {
+	if (!svm) {
 		/* We come here when PASID has never been bond to a device. */
 		svm = kzalloc(sizeof(*svm), GFP_KERNEL);
 		if (!svm) {
@@ -376,25 +408,17 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
 	struct intel_svm_dev *sdev;
 	struct intel_svm *svm;
-	int ret = -EINVAL;
+	int ret;
 
 	if (WARN_ON(!iommu))
 		return -EINVAL;
 
 	mutex_lock(&pasid_mutex);
-	svm = ioasid_find(NULL, pasid, NULL);
-	if (!svm) {
-		ret = -EINVAL;
-		goto out;
-	}
-
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
+	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	if (ret)
 		goto out;
-	}
 
-	for_each_svm_dev(sdev, svm, dev) {
-		ret = 0;
+	if (sdev) {
 		if (iommu_dev_feature_enabled(dev, IOMMU_DEV_FEAT_AUX))
 			sdev->users--;
 		if (!sdev->users) {
@@ -418,7 +442,6 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				kfree(svm);
 			}
 		}
-		break;
 	}
 out:
 	mutex_unlock(&pasid_mutex);
@@ -596,7 +619,7 @@ intel_svm_bind_mm(struct device *dev, int flags, struct svm_dev_ops *ops,
 	if (sd)
 		*sd = sdev;
 	ret = 0;
- out:
+out:
 	return ret;
 }
 
@@ -612,17 +635,11 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 	if (!iommu)
 		goto out;
 
-	svm = ioasid_find(NULL, pasid, NULL);
-	if (!svm)
-		goto out;
-
-	if (IS_ERR(svm)) {
-		ret = PTR_ERR(svm);
+	ret = pasid_to_svm_sdev(dev, pasid, &svm, &sdev);
+	if (ret)
 		goto out;
-	}
 
-	for_each_svm_dev(sdev, svm, dev) {
-		ret = 0;
+	if (sdev) {
 		sdev->users--;
 		if (!sdev->users) {
 			list_del_rcu(&sdev->list);
@@ -651,10 +668,8 @@ static int intel_svm_unbind_mm(struct device *dev, int pasid)
 				kfree(svm);
 			}
 		}
-		break;
 	}
- out:
-
+out:
 	return ret;
 }
 
-- 
2.17.1

