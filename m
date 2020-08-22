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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2E70C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A190C207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 04:28:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M6lPzDEH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgHVE2s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 00:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbgHVE2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 00:28:30 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147C9C0613ED
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:30 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id nv17so1682469pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 21:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fpF0Th5lLUO36CqDBVFyDlq5hvY4EE8QAVEqPKtMLqA=;
        b=M6lPzDEHKZbJWURiDOYBdH6Rzq5aLQW0NdQyGZRqZGcfHNnp5LoLfzhJ5fqhi/hDfU
         1DPj1heTzGWr99YG95x5/sS8PdBxgMEhfh1eLhd/rGnNYdRsL3SBnY4tHcaqn+55bN0S
         Q8a5ZZURiQ8/cmmSf8V8scON60KGpNbuSJ+vQG0Yyoz+ifkdvrDCKsn7Y4kIw8dgKtoq
         SRR1OHhOheDjbf/yQoChtJySv+8qY93gMRfw2mzTv6mn4vP3nWhexhwQJHQPoAzpAo9x
         F0z1qSZPZiIi0ZlxToWFtnxg8laGjYpD2Y6JNHUtqyz82j5LtDXjW9bIl+SO1Ef0NxPO
         ntBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fpF0Th5lLUO36CqDBVFyDlq5hvY4EE8QAVEqPKtMLqA=;
        b=mE5+A76ups/csLrPD5XBh/Lg9/zw/14qkVAowtvSyJy7Sc0tJ9mb24JAOnbKi2UT5p
         rs1zijBYYdsj20pduHmsGuKXSj5I5i9DP9JsX7E1kIQ62rPO6PMUga7Omwa7v0tvlQZ/
         soJjGlvaF45WsbVfkq6V/4ugP2qL6lpovAoDuLFldqh97JDm5mgw7eot0bfD3PPAUVEI
         Rn1Ixe8N8DvJSGVrWwt/ldIKh1D2RUM7keHvpkCrVSiuW1LopvXSDpEjNERFwhZ/iIVP
         ZttuyKdcI84WbaNskqe0V3iFdRmIm1Ndc7K3gfPvFTM3JjQHF1k/8Z7kENJFUelznTCF
         p1MA==
X-Gm-Message-State: AOAM532WWfyuiej6d1/LXpbuHmgzUFP1Y5yVw4lpMfGmGQ8aEVu7mjQQ
        IzXkt5XhOE41zY26+I+VWLE=
X-Google-Smtp-Source: ABdhPJzxEre7Xz6k4NV7lxKTwBithgZmi3bIbCB5yzDOkKpqjHbdllVFF9Rw3eMEz6nn09MwfIrdzw==
X-Received: by 2002:a17:902:a50e:: with SMTP id s14mr4666810plq.164.1598070509598;
        Fri, 21 Aug 2020 21:28:29 -0700 (PDT)
Received: from jacob-builder.jf.intel.com ([192.55.55.43])
        by smtp.gmail.com with ESMTPSA id q5sm3341582pgi.31.2020.08.21.21.28.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:28:29 -0700 (PDT)
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
Subject: [PATCH v2 5/9] iommu/ioasid: Introduce ioasid_set private ID
Date:   Fri, 21 Aug 2020 21:35:14 -0700
Message-Id: <1598070918-21321-6-git-send-email-jacob.jun.pan@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
References: <1598070918-21321-1-git-send-email-jacob.jun.pan@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an IOASID set is used for guest SVA, each VM will acquire its
ioasid_set for IOASID allocations. IOASIDs within the VM must have a
host/physical IOASID backing, mapping between guest and host IOASIDs can
be non-identical. IOASID set private ID (SPID) is introduced in this
patch to be used as guest IOASID. However, the concept of ioasid_set
specific namespace is generic, thus named SPID.

As SPID namespace is within the IOASID set, the IOASID core can provide
lookup services at both directions. SPIDs may not be allocated when its
IOASID is allocated, the mapping between SPID and IOASID is usually
established when a guest page table is bound to a host PASID.

Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
---
 drivers/iommu/ioasid.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/ioasid.h | 12 +++++++++++
 2 files changed, 66 insertions(+)

diff --git a/drivers/iommu/ioasid.c b/drivers/iommu/ioasid.c
index 5f31d63c75b1..c0aef38a4fde 100644
--- a/drivers/iommu/ioasid.c
+++ b/drivers/iommu/ioasid.c
@@ -21,6 +21,7 @@ enum ioasid_state {
  * struct ioasid_data - Meta data about ioasid
  *
  * @id:		Unique ID
+ * @spid:	Private ID unique within a set
  * @users	Number of active users
  * @state	Track state of the IOASID
  * @set		Meta data of the set this IOASID belongs to
@@ -29,6 +30,7 @@ enum ioasid_state {
  */
 struct ioasid_data {
 	ioasid_t id;
+	ioasid_t spid;
 	struct ioasid_set *set;
 	refcount_t users;
 	enum ioasid_state state;
@@ -326,6 +328,58 @@ int ioasid_attach_data(ioasid_t ioasid, void *data)
 EXPORT_SYMBOL_GPL(ioasid_attach_data);
 
 /**
+ * ioasid_attach_spid - Attach ioasid_set private ID to an IOASID
+ *
+ * @ioasid: the ID to attach
+ * @spid:   the ioasid_set private ID of @ioasid
+ *
+ * For IOASID that is already allocated, private ID within the set can be
+ * attached via this API. Future lookup can be done via ioasid_find.
+ */
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	struct ioasid_data *ioasid_data;
+	int ret = 0;
+
+	spin_lock(&ioasid_allocator_lock);
+	ioasid_data = xa_load(&active_allocator->xa, ioasid);
+
+	if (!ioasid_data) {
+		pr_err("No IOASID entry %d to attach SPID %d\n",
+			ioasid, spid);
+		ret = -ENOENT;
+		goto done_unlock;
+	}
+	ioasid_data->spid = spid;
+
+done_unlock:
+	spin_unlock(&ioasid_allocator_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(ioasid_attach_spid);
+
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
+{
+	struct ioasid_data *entry;
+	unsigned long index;
+
+	if (!xa_load(&ioasid_sets, set->sid)) {
+		pr_warn("Invalid set\n");
+		return INVALID_IOASID;
+	}
+
+	xa_for_each(&set->xa, index, entry) {
+		if (spid == entry->spid) {
+			pr_debug("Found ioasid %lu by spid %u\n", index, spid);
+			refcount_inc(&entry->users);
+			return index;
+		}
+	}
+	return INVALID_IOASID;
+}
+EXPORT_SYMBOL_GPL(ioasid_find_by_spid);
+
+/**
  * ioasid_alloc - Allocate an IOASID
  * @set: the IOASID set
  * @min: the minimum ID (inclusive)
diff --git a/include/linux/ioasid.h b/include/linux/ioasid.h
index 310abe4187a3..d4b3e83672f6 100644
--- a/include/linux/ioasid.h
+++ b/include/linux/ioasid.h
@@ -73,6 +73,8 @@ bool ioasid_is_active(ioasid_t ioasid);
 
 void *ioasid_find(struct ioasid_set *set, ioasid_t ioasid, bool (*getter)(void *));
 int ioasid_attach_data(ioasid_t ioasid, void *data);
+int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid);
+ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid);
 int ioasid_register_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_unregister_allocator(struct ioasid_allocator_ops *allocator);
 void ioasid_is_in_set(struct ioasid_set *set, ioasid_t ioasid);
@@ -136,5 +138,15 @@ static inline int ioasid_attach_data(ioasid_t ioasid, void *data)
 	return -ENOTSUPP;
 }
 
+staic inline int ioasid_attach_spid(ioasid_t ioasid, ioasid_t spid)
+{
+	return -ENOTSUPP;
+}
+
+static inline ioasid_t ioasid_find_by_spid(struct ioasid_set *set, ioasid_t spid)
+{
+	return -ENOTSUPP;
+}
+
 #endif /* CONFIG_IOASID */
 #endif /* __LINUX_IOASID_H */
-- 
2.7.4

