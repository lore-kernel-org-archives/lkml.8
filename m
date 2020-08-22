Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F43C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD3E5207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R03yistd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726719AbgHVE2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgHVE2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:28:25 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2EB4C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:25 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 2so1676819pjx.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3fh4Vbi5cH80+HY7hf3937mL7qFSKmxlG0sv3RflODQ=;
        b=R03yistdQyNLISMlwTUY7gU6KE6eUyrZKmDgLTzR5kSo8m6T+rNJbYdP80vXZeHFZ5
         psCZaOfOX5+2LU3X1rSIdkYKFI1qYDMyxPz69JkzzYMbq03h1nz/LUCgz7QDCs6ZTKfn
         Yt1eSHTAMC02EnycmqnLZSPGAKIsQ1c6P73VvEgw4uEQLQJ6UjeiS/41FL6c8sXVDnqj
         GfI2ZOCxlmlTwNfdGWqzWhnRGplumW87ABzdEhfvqwobb8FM+1Jxfy4YTdmEDJQBbMaG
         K+5ignIQkhdoc9ARItnEYAwvb4ZrJl5f79CnDx/P62eqJuPKTM1/s36SNq7NT1t2nfaH
         b6cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3fh4Vbi5cH80+HY7hf3937mL7qFSKmxlG0sv3RflODQ=;
        b=OkxlFjPSW7nYdrfHgIzARloDLeCp4Xiqev6OU3fgadowxYFCzteYpH0t1mlEY9OC9m
         bLqYS+gKGJsks4QJFflq+SKPn+/phcsqB2gJSYMoRX5H5dUhMD06KahG0FEU7dEuMxGX
         DuChkDF5ajUgt3wxwO5f4v3v27QSUOffcRqSFWfcKu/LjTIAQFp2xV/B6E2amGlsnXTS
         IyWOoJTMADxcwUTfo5K1ZUBAO92LAbJuW3FJvbuzhMNdeQ5tuqp0YJChuVTcwPDUyQVV
         KV7CWGcktQd5VQCae7EtLWOuNGmjn0oSwXRbzaixEqi4EJa8WZ34bZyZ9nWOn9N1GB99
         OzgA==
X-Gm-Message-State: AOAM532mEnvRmOLeniCazos5GAZP4W6BEC6oewg4axGxXcQre1ukmRGe
        FYHMeCdYIcXriOZWT/9kAeIGH5XGcvFhadzN
X-Google-Smtp-Source: ABdhPJzl4iBtdCTA2qkci3IfQHYdcR2m84Dvv37E+iCzNVUExRPh2FFSv0F9UGr0AkkiTndRac6mmg==
X-Received: by 2002:a17:90b:4b0c:: with SMTP id lx12mr5267974pjb.117.1598070505303;
        Fri, 21 Aug 2020 21:28:25 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:28:24 -0700 (PDT)
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
Subject: [PATCH v2 2/9] iommu/ioasid: Rename ioasid_set_data()
Date:   Fri, 21 Aug 2020 21:35:11 -0700
Message-Id: <1598070918-21321-3-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename ioasid_set_data() to ioasid_attach_data() to avoid confusion with
struct ioasid_set. ioasid_set is a group of IOASIDs that share a common
token.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/intel/svm.c | 6 +++---
 drivers/iommu/ioasid.c    | 6 +++---
 include/linux/ioasid.h    | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index b6972dca2ae0..37a9beabc0ca 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -342,7 +342,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 			svm->gpasid = data->gpasid;
 			svm->flags |= SVM_FLAG_GUEST_PASID;
 		}
-		ioasid_set_data(data->hpasid, svm);
+		ioasid_attach_data(data->hpasid, svm);
 		INIT_LIST_HEAD_RCU(&svm->devs);
 		mmput(svm->mm);
 	}
@@ -394,7 +394,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain, struct device *dev,
 	list_add_rcu(&sdev->list, &svm->devs);
  out:
 	if (!IS_ERR_OR_NULL(svm) && list_empty(&svm->devs)) {
-		ioasid_set_data(data->hpasid, NULL);
+		ioasid_attach_data(data->hpasid, NULL);
 		kfree(svm);
 	}
 
@@ -437,7 +437,7 @@ int intel_svm_unbind_gpasid(struct device *dev, int pasid)
 				 * the unbind, IOMMU driver will get notified
 				 * and perform cleanup.
 				 */
-				ioasid_set_data(pasid, NULL);
+				ioasid_attach_data(pasid, NULL);
 				kfree(svm);
 			}
 		}
diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 0f8dd377aada..5f63af07acd5 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -258,14 +258,14 @@ void ioasid_unregister_allocator(struct ioasid_allocator_ops *ops)
 EXPORT_SYMBOL_GPL(ioasid_unregister_allocator);
 
 /**
- * ioasid_set_data - Set private data for an allocated ioasid
+ * ioasid_attach_data - Set private data for an allocated ioasid
  * @ioasid: the ID to set data
  * @data:   the private data
  *
  * For IOASID that is already allocated, private data can be set
  * via this API. Future lookup can be done via ioasid_find.
  */
-int ioasid_set_data(ioasid_t ioasid, void *data)
+int ioasid_attach_data(ioasid_t ioasid, void *data)
 {
 	struct ioasid_data *ioasid_data;
 	int ret = 0;
@@ -287,7 +287,7 @@ int ioasid_set_data(ioasid_t ioasid, void *data)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(ioasid_set_data);
+EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
  * ioasid_alloc - Allocate an IOASID
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 6f000d7a0ddc..9c44947a68c8 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -39,7 +39,7 @@ void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid,
 		  bool (*getter)(void *));
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
-int ioasid_set_data(ioasid_t ioasid, void *data);
+int ioasid_attach_data(ioasid_t ioasid, void *data);
 
 #else /* !CONFIG_IOASID */
 static inline ioasid_t ioasid_alloc(struct ioasid_set *set, ioasid_t min,
@@ -67,7 +67,7 @@ static inline void ioasid_unregister_allocator(struct ioasid_allocator_ops *allo
 {
 }
 
-static inline int ioasid_set_data(ioasid_t ioasid, void *data)
+static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 {
 	return -ENOTSUPP;
 }
-- 
2.7.4

