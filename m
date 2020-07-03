Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADFBC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0293D206BE
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 14:17:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Aux0VBi+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgGCORo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 10:17:44 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:19072 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726039AbgGCORo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 10:17:44 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593785863; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BhNeirievu7ABUQ2mRSmIu+sWUN4ihC6bWjNuJCyjvc=; b=Aux0VBi+/00i4v5koV+p8fC4XCX198bWO9OTkNbdjh5aeLzGsoZDIDopI8RaRA1ED5D/Nh48
 Ql+PdC0CnftPneLphYnpCdNBBpv91CVZlTrioULLBu+4rp9Pe677fPH/Zqhp3r6ICF8QghKc
 ZsOwOqwAR7pN4FBPpdG2Jrshf00=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5eff3dff0206ad41d103726e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 03 Jul 2020 14:17:35
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 55E9BC433C6; Fri,  3 Jul 2020 14:17:34 +0000 (UTC)
Received: from vjitta-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A908C433C8;
        Fri,  3 Jul 2020 14:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A908C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com,
        vjitta@codeaurora.org
Subject: [PATCH 1/2] iommu/iova: Retry from last rb tree node if iova search fails
Date:   Fri,  3 Jul 2020 19:47:14 +0530
Message-Id: <1593785835-27250-1-git-send-email-vjitta@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijayanand Jitta <vjitta@codeaurora.org>

When ever a new iova alloc request comes iova is always searched
from the cached node and the nodes which are previous to cached
node. So, even if there is free iova space available in the nodes
which are next to the cached node iova allocation can still fail
because of this approach.

Consider the following sequence of iova alloc and frees on
1GB of iova space

1) alloc - 500MB
2) alloc - 12MB
3) alloc - 499MB
4) free -  12MB which was allocated in step 2
5) alloc - 13MB

After the above sequence we will have 12MB of free iova space and
cached node will be pointing to the iova pfn of last alloc of 13MB
which will be the lowest iova pfn of that iova space. Now if we get an
alloc request of 2MB we just search from cached node and then look
for lower iova pfn's for free iova and as they aren't any, iova alloc
fails though there is 12MB of free iova space.

To avoid such iova search failures do a retry from the last rb tree node
when iova search fails, this will search the entire tree and get an iova
if its available.

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/iommu/iova.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 49fc01f..4e77116 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	struct rb_node *curr, *prev;
 	struct iova *curr_iova;
 	unsigned long flags;
-	unsigned long new_pfn;
+	unsigned long new_pfn, low_pfn_new;
 	unsigned long align_mask = ~0UL;
+	unsigned long high_pfn = limit_pfn, low_pfn = iovad->start_pfn;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
@@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = rb_entry(curr, struct iova, node);
+	low_pfn_new = curr_iova->pfn_hi + 1;
+
+retry:
 	do {
-		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
-		new_pfn = (limit_pfn - size) & align_mask;
+		high_pfn = min(high_pfn, curr_iova->pfn_lo);
+		new_pfn = (high_pfn - size) & align_mask;
 		prev = curr;
 		curr = rb_prev(curr);
 		curr_iova = rb_entry(curr, struct iova, node);
-	} while (curr && new_pfn <= curr_iova->pfn_hi);
-
-	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+	} while (curr && new_pfn <= curr_iova->pfn_hi && new_pfn >= low_pfn);
+
+	if (high_pfn < size || new_pfn < low_pfn) {
+		if (low_pfn == iovad->start_pfn && low_pfn_new < limit_pfn) {
+			high_pfn = limit_pfn;
+			low_pfn = low_pfn_new;
+			curr = &iovad->anchor.node;
+			curr_iova = rb_entry(curr, struct iova, node);
+			goto retry;
+		}
 		iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
1.9.1

