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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F464C433E6
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7E982071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:18:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8cFLtHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgHaSSq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728048AbgHaSST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:19 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969A1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id x18so2237173pll.6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hj6II/effaZa4WaELDjyUPpGA7jr1WYD7YDSGUX57Fg=;
        b=o8cFLtHuVuEuDejSEEKxwA6t4TU3znD82VxLYWgHMzbN0mPwp74x3fqD8inLfgu1k+
         XjN9tXmZqN5GWJ17Wsd+YlsGdRHssZC6JalH3WwitNcHGGZB6hbr+tDQx40J0LBB49i/
         kSzqCQOMZVhXF221Ygse29MODQnJ139kLlA5YjasuTZi0ZR9JBGDdcWlvMMxGRS+YN5L
         B+FuDe1YQgTsSeMihg9T5+AR5dEr5PRbOuwNtf6HBIdPlFPt9WNbFZLK7qQOPy4cEDhn
         VihpD1DAR4rYjeFFqdCcWCqV2XWaxEWd79TtordQXZdzcR1TJGEz3uHfWcPaMNGyVxr1
         T3ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hj6II/effaZa4WaELDjyUPpGA7jr1WYD7YDSGUX57Fg=;
        b=ifbpJWdqtCbUSqJ1CWK7wXPla0AjSKbwMUDf7ED6EsZqL16JA3idiOtL/QAD7vc9aP
         O5Q6I9yJKmKQyDaJYdtUxQDnAztn0StOJm3LayxbjoSRAdvAyHJ3GMjJqyjv4ROpy+ZF
         xReDJ6/BsV3Px7btTGGZ30P3wNEpXxlb+kaGnbuU+VwbGvaY6JFYr5UnqKC48R0TORp7
         ROnuzslCUJY/2l64PoRtxc7HVZ93R+uPBThqjYLXMQ2WtiETaZa5om1REnhD5iHTU6Rt
         ustmttwcMxd5fig+gNDCutUiV31X0zgGYb2HB7nnc0nFXpBqBzMFz+JKc6/9Mw8grZyn
         8Qeg==
X-Gm-Message-State: AOAM5310fwn29osEJZv63ovSSlIZqJU8iYOirZZlsPeZvC6fNpNMzDmy
        Tzq3othnzAaU1LSi18HCmHw=
X-Google-Smtp-Source: ABdhPJwpk5nFuc8n93rxcDTl5Ou9sHKrofwLYOKyGJzox9k6elvUlLcdX3RYm1HdYUmQY1TJQhkikQ==
X-Received: by 2002:a17:902:ff07:: with SMTP id f7mr1767673plj.52.1598897898076;
        Mon, 31 Aug 2020 11:18:18 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:18:17 -0700 (PDT)
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
Subject: [PATCH v8 6/7] iommu/uapi: Handle data and argsz filled by users
Date:   Mon, 31 Aug 2020 11:24:59 -0700
Message-Id: <1598898300-65475-7-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IOMMU user APIs are responsible for processing user data. This patch
changes the interface such that user pointers can be passed into IOMMU
code directly. Separate kernel APIs without user pointers are introduced
for in-kernel users of the UAPI functionality.

IOMMU UAPI data has a user filled argsz field which indicates the data
length of the structure. User data is not trusted, argsz must be
validated based on the current kernel data size, mandatory data size,
and feature flags.

User data may also be extended, resulting in possible argsz increase.
Backward compatibility is ensured based on size and flags (or
the functional equivalent fields) checking.

This patch adds sanity checks in the IOMMU layer. In addition to argsz,
reserved/unused fields in padding, flags, and version are also checked.
Details are documented in Documentation/userspace-api/iommu.rst

Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/iommu.c | 201 ++++++++++++++++++++++++++++++++++++++++++++++++--
 include/linux/iommu.h |  28 ++++---
 2 files changed, 212 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 4ae02291ccc2..3bc263ae31ed 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1961,33 +1961,218 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
 }
 EXPORT_SYMBOL_GPL(iommu_attach_device);
 
+/*
+ * Check flags and other user provided data for valid combinations. We also
+ * make sure no reserved fields or unused flags are set. This is to ensure
+ * not breaking userspace in the future when these fields or flags are used.
+ */
+static int iommu_check_cache_invl_data(struct iommu_cache_invalidate_info *info)
+{
+	u32 mask;
+	int i;
+
+	if (info->version != IOMMU_CACHE_INVALIDATE_INFO_VERSION_1)
+		return -EINVAL;
+
+	mask = (1 << IOMMU_CACHE_INV_TYPE_NR) - 1;
+	if (info->cache & ~mask)
+		return -EINVAL;
+
+	if (info->granularity >= IOMMU_INV_GRANU_NR)
+		return -EINVAL;
+
+	switch (info->granularity) {
+	case IOMMU_INV_GRANU_ADDR:
+		if (info->cache & IOMMU_CACHE_INV_TYPE_PASID)
+			return -EINVAL;
+
+		mask = IOMMU_INV_ADDR_FLAGS_PASID |
+			IOMMU_INV_ADDR_FLAGS_ARCHID |
+			IOMMU_INV_ADDR_FLAGS_LEAF;
+
+		if (info->granu.addr_info.flags & ~mask)
+			return -EINVAL;
+		break;
+	case IOMMU_INV_GRANU_PASID:
+		mask = IOMMU_INV_PASID_FLAGS_PASID |
+			IOMMU_INV_PASID_FLAGS_ARCHID;
+		if (info->granu.pasid_info.flags & ~mask)
+			return -EINVAL;
+
+		break;
+	case IOMMU_INV_GRANU_DOMAIN:
+		if (info->cache & IOMMU_CACHE_INV_TYPE_DEV_IOTLB)
+			return -EINVAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Check reserved padding fields */
+	for (i = 0; i < sizeof(info->padding); i++) {
+		if (info->padding[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int iommu_uapi_cache_invalidate(struct iommu_domain *domain, struct device *dev,
-				struct iommu_cache_invalidate_info *inv_info)
+				void __user *uinfo)
 {
+	struct iommu_cache_invalidate_info inv_info = { 0 };
+	u32 minsz;
+	int ret = 0;
+
 	if (unlikely(!domain->ops->cache_invalidate))
 		return -ENODEV;
 
-	return domain->ops->cache_invalidate(domain, dev, inv_info);
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_cache_invalidate_info, granu);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(&inv_info, uinfo, minsz))
+		return -EFAULT;
+
+	/* Fields before variable size union is mandatory */
+	if (inv_info.argsz < minsz)
+		return -EINVAL;
+
+	/* PASID and address granu require additional info beyond minsz */
+	if (inv_info.argsz == minsz &&
+	    ((inv_info.granularity == IOMMU_INV_GRANU_PASID) ||
+		    (inv_info.granularity == IOMMU_INV_GRANU_ADDR)))
+		return -EINVAL;
+
+	if (inv_info.granularity == IOMMU_INV_GRANU_PASID &&
+	    inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.pasid_info))
+		return -EINVAL;
+
+	if (inv_info.granularity == IOMMU_INV_GRANU_ADDR &&
+	    inv_info.argsz < offsetofend(struct iommu_cache_invalidate_info, granu.addr_info))
+		return -EINVAL;
+
+	/*
+	 * User might be using a newer UAPI header which has a larger data
+	 * size, we shall support the existing flags within the current
+	 * size. Copy the remaining user data _after_ minsz but not more
+	 * than the current kernel supported size.
+	 */
+	if (copy_from_user((void *)&inv_info + minsz, uinfo + minsz,
+			   min_t(u32, inv_info.argsz, sizeof(inv_info)) - minsz))
+		return -EFAULT;
+
+	/* Now the argsz is validated, check the content */
+	ret = iommu_check_cache_invl_data(&inv_info);
+	if (ret)
+		return ret;
+
+	return domain->ops->cache_invalidate(domain, dev, &inv_info);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_cache_invalidate);
 
-int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-			       struct device *dev, struct iommu_gpasid_bind_data *data)
+static int iommu_check_bind_data(struct iommu_gpasid_bind_data *data)
+{
+	u32 mask;
+	int i;
+
+	if (data->version != IOMMU_GPASID_BIND_VERSION_1)
+		return -EINVAL;
+
+	/* Check the range of supported formats */
+	if (data->format >= IOMMU_PASID_FORMAT_LAST)
+		return -EINVAL;
+
+	/* Check all flags */
+	mask = IOMMU_SVA_GPASID_VAL;
+	if (data->flags & ~mask)
+		return -EINVAL;
+
+	/* Check reserved padding fields */
+	for (i = 0; i < sizeof(data->padding); i++) {
+		if (data->padding[i])
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int iommu_sva_prepare_bind_data(void __user *udata,
+				       struct iommu_gpasid_bind_data *data)
 {
+	u32 minsz;
+
+	/*
+	 * No new spaces can be added before the variable sized union, the
+	 * minimum size is the offset to the union.
+	 */
+	minsz = offsetof(struct iommu_gpasid_bind_data, vendor);
+
+	/* Copy minsz from user to get flags and argsz */
+	if (copy_from_user(data, udata, minsz))
+		return -EFAULT;
+
+	/* Fields before variable size union is mandatory */
+	if (data->argsz < minsz)
+		return -EINVAL;
+	/*
+	 * User might be using a newer UAPI header, we shall let IOMMU vendor
+	 * driver decide on what size it needs. Since the guest PASID bind data
+	 * can be vendor specific, larger argsz could be the result of extension
+	 * for one vendor but it should not affect another vendor.
+	 * Copy the remaining user data _after_ minsz
+	 */
+	if (copy_from_user((void *)data + minsz, udata + minsz,
+			   min_t(u32, data->argsz, sizeof(*data)) - minsz))
+		return -EFAULT;
+
+	return iommu_check_bind_data(data);
+}
+
+int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain, struct device *dev,
+			       void __user *udata)
+{
+	struct iommu_gpasid_bind_data data = { 0 };
+	int ret;
+
 	if (unlikely(!domain->ops->sva_bind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_bind_gpasid(domain, dev, data);
+	ret = iommu_sva_prepare_bind_data(udata, &data);
+	if (ret)
+		return ret;
+
+	return domain->ops->sva_bind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_bind_gpasid);
 
-int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
-				 ioasid_t pasid)
+int iommu_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+			    struct iommu_gpasid_bind_data *data)
 {
 	if (unlikely(!domain->ops->sva_unbind_gpasid))
 		return -ENODEV;
 
-	return domain->ops->sva_unbind_gpasid(dev, pasid);
+	return domain->ops->sva_unbind_gpasid(dev, data->hpasid);
+}
+EXPORT_SYMBOL_GPL(iommu_sva_unbind_gpasid);
+
+int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain, struct device *dev,
+				 void __user *udata)
+{
+	struct iommu_gpasid_bind_data data = { 0 };
+	int ret;
+
+	if (unlikely(!domain->ops->sva_bind_gpasid))
+		return -ENODEV;
+
+	ret = iommu_sva_prepare_bind_data(udata, &data);
+	if (ret)
+		return ret;
+
+	return iommu_sva_unbind_gpasid(domain, dev, &data);
 }
 EXPORT_SYMBOL_GPL(iommu_uapi_sva_unbind_gpasid);
 
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 710d5d2691eb..c364b1c038da 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -426,11 +426,14 @@ extern void iommu_detach_device(struct iommu_domain *domain,
 				struct device *dev);
 extern int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
 				       struct device *dev,
-				       struct iommu_cache_invalidate_info *inv_info);
+				       void __user *uinfo);
+
 extern int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-				      struct device *dev, struct iommu_gpasid_bind_data *data);
+				      struct device *dev, void __user *udata);
 extern int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
-					struct device *dev, ioasid_t pasid);
+					struct device *dev, void __user *udata);
+extern int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+				   struct device *dev, struct iommu_gpasid_bind_data *data);
 extern struct iommu_domain *iommu_get_domain_for_dev(struct device *dev);
 extern struct iommu_domain *iommu_get_dma_domain(struct device *dev);
 extern int iommu_map(struct iommu_domain *domain, unsigned long iova,
@@ -1032,22 +1035,29 @@ static inline int iommu_sva_get_pasid(struct iommu_sva *handle)
 	return IOMMU_PASID_INVALID;
 }
 
-static inline int iommu_uapi_cache_invalidate(struct iommu_domain *domain,
-					      struct device *dev,
-					      struct iommu_cache_invalidate_info *inv_info)
+static inline int
+iommu_uapi_cache_invalidate(struct iommu_domain *domain,
+			    struct device *dev,
+			    struct iommu_cache_invalidate_info *inv_info)
 {
 	return -ENODEV;
 }
 
 static inline int iommu_uapi_sva_bind_gpasid(struct iommu_domain *domain,
-					     struct device *dev,
-					     struct iommu_gpasid_bind_data *data)
+					     struct device *dev, void __user *udata)
 {
 	return -ENODEV;
 }
 
 static inline int iommu_uapi_sva_unbind_gpasid(struct iommu_domain *domain,
-					       struct device *dev, int pasid)
+					       struct device *dev, void __user *udata)
+{
+	return -ENODEV;
+}
+
+static inline int iommu_sva_unbind_gpasid(struct iommu_domain *domain,
+					  struct device *dev,
+					  struct iommu_gpasid_bind_data *data)
 {
 	return -ENODEV;
 }
-- 
2.7.4

