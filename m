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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73744C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C45F207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV1DpLQk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHVE2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbgHVE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:28:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4FE2C061755
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:29 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j21so1932165pgi.9
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w7TbhItqwKixGiLvRC8dSaYe7kOA0K/CzHhPkWQGXvU=;
        b=RV1DpLQkpXzX35TlE91Ha03BuzgdBScDmkACaJqRjpLSeoB0IM1HGpcTnZwEArhZnL
         Pn4VrlsO/3QxDUCkMwgTkNqOC338rfS6UUbu145dBhoufkjzuZnNbW3DoWCb+1UuYIJ/
         1NOtV5B4rEO0UE+ndv2JctfFNW+SSHNMLpKd02hodc+BkBOS5cZMMbjoawe+xQMN8rMo
         YjTtzLdYN/KmqzQbpEStt32JsMJs0YS0woeR2+yoC1BDq6ruAakB0V6omRDgONiesk9U
         IElpJPeaVS9SHa7VhxLJ34rMWIdocxLVl3CScs9t/ruOPqX6FaMzbEmnNLLDDt4DeQ0Q
         1zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w7TbhItqwKixGiLvRC8dSaYe7kOA0K/CzHhPkWQGXvU=;
        b=orFESZkUQJv+woXpIn/Idddbi932P0jYaAeJlfLwr9gt247DqJpY47qc6ucNH1tOhL
         M/WQCOxSx+8gmhXTnGXxrX09WSs2mdSItrtP9LhO0a/Kd0ZtkJRWcExOJ457Yuv7Qpsn
         IlFuKFt6XHW+IKqTIbwwkHhbpWVumI4Y5SGkidNjuaCw+9kmTnDYkYM7P9RcqfNrD+2X
         URrBVQnYixVshQB/5L/P29d2QMHK8pb7jj/AfW1/b7Jt/y6c6pd8VJ5LCCTWhBA9peo5
         kGmH0IYo53fyC9EAXiRfsfhxb0JACTdVI6ovrSfkLsGHrPrWWZEshYm9vXhAtR2P0OYZ
         h77w==
X-Gm-Message-State: AOAM530RmC3s3ht56xnmIKH35Ma4+tbUKdeTVUtuHkQKLwckqmMnToJe
        1h5Z8Ukx4OmE3ywQ6Pet/PM=
X-Google-Smtp-Source: ABdhPJw8P/fGA7/XuCnSjCYDxJ7ntitIW85diUbooJayDLaJ9qWQzAPLK1euI9maNeQkFz49VlE5Bg==
X-Received: by 2002:aa7:8608:: with SMTP id p8mr4912348pfn.62.1598070508123;
        Fri, 21 Aug 2020 21:28:28 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.26
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:28:27 -0700 (PDT)
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
Subject: [PATCH v2 4/9] iommu/ioasid: Add reference couting functions
Date:   Fri, 21 Aug 2020 21:35:13 -0700
Message-Id: <1598070918-21321-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There can be multiple users of an IOASID, each user could have hardware
contexts associated with the IOASID. In order to align lifecycles,
reference counting is introduced in this patch. It is expected that when
an IOASID is being freed, each user will drop a reference only after its
context is cleared.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h |   4 ++
 2 files changed, 117 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index f73b3dbfc37a..5f31d63c75b1 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -717,6 +717,119 @@ int ioasid_set_for_each_ioasid(struct ioasid_set *set,
 EXPORT_SYMBOL_GPL(ioasid_set_for_each_ioasid);
 
 /**
+ * IOASID refcounting rules
+ * - ioasid_alloc() set initial refcount to 1
+ *
+ * - ioasid_free() decrement and test refcount.
+ *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
+ *     xarray as well as per set xarray. The IOASID will be returned to the
+ *     pool and available for new allocations.
+ *
+ *     If recount is non-zero, mark IOASID as IOASID_STATE_FREE_PENDING.
+ *     No new reference can be added. The IOASID is not returned to the pool
+ *     for reuse.
+ *     After free, ioasid_get() will return error but ioasid_find() and other
+ *     non refcount adding APIs will continue to work until the last reference
+ *     is dropped
+ *
+ * - ioasid_get() get a reference on an active IOASID
+ *
+ * - ioasid_put() decrement and test refcount of the IOASID.
+ *     If refcount is 0, ioasid will be freed. Deleted from the system-wide
+ *     xarray as well as per set xarray. The IOASID will be returned to the
+ *     pool and available for new allocations.
+ *     Do nothing if refcount is non-zero.
+ *
+ * - ioasid_find() does not take reference, caller must hold reference
+ *
+ * ioasid_free() can be called multiple times without error until all refs are
+ * dropped.
+ */
+
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to get unknown IOASID %u\n", ioasid);
+		return -EINVAL;
+	}
+	if (data->state == IOASID_STATE_FREE_PENDING) {
+		pr_err("Trying to get IOASID being freed%u\n", ioasid);
+		return -EBUSY;
+	}
+
+	if (set && data->set != set) {
+		pr_err("Trying to get IOASID not in set%u\n", ioasid);
+		/* data found but does not belong to the set */
+		return -EACCES;
+	}
+	refcount_inc(&data->users);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ioasid_get_locked);
+
+/**
+ * ioasid_get - Obtain a reference of an ioasid
+ * @set
+ * @ioasid
+ *
+ * Check set ownership if @set is non-null.
+ */
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid)
+{
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	ret = ioasid_get_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_get);
+
+void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid)
+{
+	struct ioasid_data *data;
+
+	data = xa_load(&active_allocator->xa, ioasid);
+	if (!data) {
+		pr_err("Trying to put unknown IOASID %u\n", ioasid);
+		return;
+	}
+
+	if (set && data->set != set) {
+		pr_err("Trying to drop IOASID not in the set %u\n", ioasid);
+		return;
+	}
+
+	if (!refcount_dec_and_test(&data->users)) {
+		pr_debug("%s: IOASID %d has %d remainning users\n",
+			__func__, ioasid, refcount_read(&data->users));
+		return;
+	}
+	ioasid_do_free(data);
+}
+EXPORT_SYMBOL_GPL(ioasid_put_locked);
+
+/**
+ * ioasid_put - Drop a reference of an ioasid
+ * @set
+ * @ioasid
+ *
+ * Check set ownership if @set is non-null.
+ */
+void ioasid_put(struct ioasid_set *set, ioasid_t ioasid)
+{
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_put_locked(set, ioasid);
+	spin_unlock(&ioasid_allocator_lock);
+}
+EXPORT_SYMBOL_GPL(ioasid_put);
+
+/**
  * ioasid_find - Find IOASID data
  * @set: the IOASID set
  * @ioasid: the IOASID to find
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 412d025d440e..310abe4187a3 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -76,6 +76,10 @@ int ioasid_attach_data(ioasid_t ioasid, void *data);
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get(struct ioasid_set *set, ioasid_t ioasid);
+int ioasid_get_locked(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_put(struct ioasid_set *set, ioasid_t ioasid);
+void ioasid_put_locked(struct ioasid_set *set, ioasid_t ioasid);
 int ioasid_set_for_each_ioasid(struct ioasid_set *sdata,
 			       void (*fn)(ioasid_t id, void *data),
 			       void *data);
-- 
2.7.4

