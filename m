Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 033F2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D17052086A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="va3YQUB/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730240AbgHTMuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 08:50:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31797 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730143AbgHTMtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 08:49:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597927792; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=CTYfSxipttQF90/6IHjYN+pYoPbXSp2wCshlwP0fbw8=; b=va3YQUB/gRLM4S7rrQ35xUJ/xt3tHIUaY5Pq549aprL3qUTf7Y1GbOgdWCoIazQ4n3CZxR2g
 QsqOtsRKzbMhWvXV9OR4FbGJztWdts7rgX/FuUU7rz57cipbKgazeK4p8wlu2CTa439Nc5UJ
 vs8Xoapu5HtEMP8cf0sOPDkI844=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f3e71707eb4541d9364459b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 12:49:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 45007C43395; Thu, 20 Aug 2020 12:49:51 +0000 (UTC)
Received: from vjitta-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68043C433CB;
        Thu, 20 Aug 2020 12:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68043C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com,
        robin.murphy@arm.com, vjitta@codeaurora.org
Subject: [PATCH v2 2/2] iommu/iova: Free global iova rcache on iova alloc failure
Date:   Thu, 20 Aug 2020 18:19:21 +0530
Message-Id: <1597927761-24441-2-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
References: <1597927761-24441-1-git-send-email-vjitta@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

When ever an iova alloc request fails we free the iova
ranges present in the percpu iova rcaches and then retry
but the global iova rcache is not freed as a result we could
still see iova alloc failure even after retry as global
rcache is holding the iova's which can cause fragmentation.
So, free the global iova rcache as well and then go for the
retry.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/iommu/iova.c | 23 +++++++++++++++++++++++
 include/linux/iova.h |  6 ++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 4e77116..5836c87 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -442,6 +442,7 @@ struct iova *find_iova(struct iova_domain *iovad, unsigned long pfn)
 		flush_rcache = false;
 		for_each_online_cpu(cpu)
 			free_cpu_cached_iovas(cpu, iovad);
+		free_global_cached_iovas(iovad);
 		goto retry;
 	}
 
@@ -1055,5 +1056,27 @@ void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad)
 	}
 }
 
+/*
+ * free all the IOVA ranges of global cache
+ */
+void free_global_cached_iovas(struct iova_domain *iovad)
+{
+	struct iova_rcache *rcache;
+	unsigned long flags;
+	int i, j;
+
+	for (i = 0; i < IOVA_RANGE_CACHE_MAX_SIZE; ++i) {
+		rcache = &iovad->rcaches[i];
+		spin_lock_irqsave(&rcache->lock, flags);
+		for (j = 0; j < rcache->depot_size; ++j) {
+			iova_magazine_free_pfns(rcache->depot[j], iovad);
+			iova_magazine_free(rcache->depot[j]);
+			rcache->depot[j] = NULL;
+		}
+		rcache->depot_size = 0;
+		spin_unlock_irqrestore(&rcache->lock, flags);
+	}
+}
+
 MODULE_AUTHOR("Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/iova.h b/include/linux/iova.h
index a0637ab..a905726 100644
--- a/include/linux/iova.h
+++ b/include/linux/iova.h
@@ -163,6 +163,7 @@ int init_iova_flush_queue(struct iova_domain *iovad,
 struct iova *split_and_remove_iova(struct iova_domain *iovad,
 	struct iova *iova, unsigned long pfn_lo, unsigned long pfn_hi);
 void free_cpu_cached_iovas(unsigned int cpu, struct iova_domain *iovad);
+void free_global_cached_iovas(struct iova_domain *iovad);
 #else
 static inline int iova_cache_get(void)
 {
@@ -270,6 +271,11 @@ static inline void free_cpu_cached_iovas(unsigned int cpu,
 					 struct iova_domain *iovad)
 {
 }
+
+static inline void free_global_cached_iovas(struct iova_domain *iovad)
+{
+}
+
 #endif
 
 #endif
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
1.9.1

