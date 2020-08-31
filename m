Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23AA5C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 009372071B
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 18:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kHxzjZCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729694AbgHaSTA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 14:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729417AbgHaSSO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 14:18:14 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E418C061755
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:13 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id u20so1043745pfn.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Aug 2020 11:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
        b=kHxzjZCXYMea/x9JBKFQZJIIwC4UW7+yFq2ErH/2JZTRVJ2TmrTNe/pu4woCCdontK
         e82K69jpQqFSzZyUF/UkHYaINhdKsGCxsYD2upc8oqhrc05eJJwQRV8urVNGrW+VEWk7
         86+qxT+PpRMsqo/3OGGS0Hd4tOkNMZROH48VnOw+NIsaJ+dtlJEFYlgKhe8j/NzVcZck
         Z0MlnPN5+3DHP7aTUbzq9NOFZEMq2MD3AN4YKUYEmJjN2CCAzvoKLPfJXki8muHw1lw6
         oxdPPmnmnX/cA0y+XbwHF/lRtJSCQuDi5vFg4Ww8TJ63E3Dj9nQcHRe7SU8eX6UQbkVG
         qQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FfUXWWqx4cqNXXt5EY8o6jZtoACfMPOHAkeL+nG0nLI=;
        b=SxsvCmmz/CZnhENwNDXgfKnNNrt/O3F76FQOVHmBflwS3qOTEfT80Tis6NcX0Nxd2W
         zCMr+tunAHTA3UMF4HES8vyNm56/C7nRE1xWZJvb7l3h2tk3yamYkl8JKhZlO/1mDCSt
         eueOrmm2d1lnSc3Kc90k42R4J7jLDBay41SrckzTDPH2gOJAiY3SrCdOOUUV9RUka/ur
         L771ZtF5iV2Yzg/A34Mfmycp5FNQoQlPJNw+Fszxc2MpaAGrVHlPZs5cgu2Tm/0fLTjS
         c02ysFS/jA20DGuiea/m156X/vd5iS69ZBHOkuIXcmKdjJp1TYEgAqiD1PqygwEUNh93
         ty/g==
X-Gm-Message-State: AOAM5335QPOl4WhQEPvoZkUgFd8ZndRiZH6AabL8hh8tctfHij7A7+ZW
        odrABbZpVRMqxRyMQCmrEWY=
X-Google-Smtp-Source: ABdhPJzw98e6rkgvWdKlzPsWEvv/ggTETFefarTuBRMnQ0LUNHhocpvZ9SXPPZNlI1aJCCx4nkJjFA==
X-Received: by 2002:a65:6882:: with SMTP id e2mr2214079pgt.290.1598897893362;
        Mon, 31 Aug 2020 11:18:13 -0700 (PDT)
Received: from jacob-builder.jf.intel.com (jfdmzpr04-ext.jf.intel.com. [134.134.137.73])
        by smtp.gmail.com with ESMTPSA id y128sm8672547pfy.74.2020.08.31.11.18.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2020 11:18:13 -0700 (PDT)
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
Subject: [PATCH v8 3/7] iommu/uapi: Introduce enum type for PASID data format
Date:   Mon, 31 Aug 2020 11:24:56 -0700
Message-Id: <1598898300-65475-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598898300-65475-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be multiple vendor-specific PASID data formats used in UAPI
structures. This patch adds enum type with a last entry which makes
range checking much easier.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 include/uapi/linux/iommu.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index b42acc8fe007..7cc6ee6c41f7 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -298,11 +298,16 @@ struct iommu_gpasid_bind_data_vtd {
 					 IOMMU_SVA_VTD_GPASID_PCD |  \
 					 IOMMU_SVA_VTD_GPASID_PWT)
 
+enum iommu_pasid_data_format {
+	IOMMU_PASID_FORMAT_INTEL_VTD = 1,
+	IOMMU_PASID_FORMAT_LAST,
+};
+
 /**
  * struct iommu_gpasid_bind_data - Information about device and guest PASID binding
  * @argsz:	User filled size of this data
  * @version:	Version of this data structure
- * @format:	PASID table entry format
+ * @format:	PASID table entry format of enum iommu_pasid_data_format type
  * @flags:	Additional information on guest bind request
  * @gpgd:	Guest page directory base of the guest mm to bind
  * @hpasid:	Process address space ID used for the guest mm in host IOMMU
@@ -321,7 +326,6 @@ struct iommu_gpasid_bind_data {
 	__u32 argsz;
 #define IOMMU_GPASID_BIND_VERSION_1	1
 	__u32 version;
-#define IOMMU_PASID_FORMAT_INTEL_VTD	1
 	__u32 format;
 	__u32 addr_width;
 #define IOMMU_SVA_GPASID_VAL	(1 << 0) /* guest PASID valid */
-- 
2.7.4

