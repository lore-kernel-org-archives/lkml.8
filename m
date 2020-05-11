Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D4FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DA9206F9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:05:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="C9EKsYQ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbgEKLFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:05:19 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:35071 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728613AbgEKLFS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:05:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589195118; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=mnWaIkTHcklbYjU+84DKeK3V8ZTY+Qs+iogIcck9Kf8=; b=C9EKsYQ7GHquk6mi7Q8YqN7uqGcB1pyP49uzp0VArVuv20lzG1Aa2Vn/5KicnE9Glt/YxI/Z
 GTa4GKyNbkfuiD1aUy9Hp8tr4ovIUO+YPQEn4Y+gl+/nO5jGfadh8mPkSD0tNRkeOFNUB/A9
 yqRc/qq0FN72SBtKvF17lz1eqk8=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb9316d.7f0f355edce0-smtp-out-n01;
 Mon, 11 May 2020 11:05:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 961ABC4478F; Mon, 11 May 2020 11:05:16 +0000 (UTC)
Received: from vjitta-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 22866C433F2;
        Mon, 11 May 2020 11:05:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 22866C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     robin.murphy@arm.com, ajaynumb@gmail.com, vinmenon@codeaurora.org,
        kernel-team@android.com, vjitta@codeaurora.org
Subject: [PATCH v2] iommu/iova: Retry from last rb tree node if iova search fails
Date:   Mon, 11 May 2020 16:34:53 +0530
Message-Id: <1589195093-17129-1-git-send-email-vjitta@codeaurora.org>
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
if its available

Signed-off-by: Vijayanand Jitta <vjitta@codeaurora.org>
---
 drivers/iommu/iova.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a953..7d82afc 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -184,8 +184,9 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	struct rb_node *curr, *prev;
 	struct iova *curr_iova;
 	unsigned long flags;
-	unsigned long new_pfn;
+	unsigned long new_pfn, alloc_lo_new;
 	unsigned long align_mask = ~0UL;
+	unsigned long alloc_hi = limit_pfn, alloc_lo = iovad->start_pfn;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
@@ -198,15 +199,25 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = rb_entry(curr, struct iova, node);
+	alloc_lo_new = curr_iova->pfn_hi;
+
+retry:
 	do {
-		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
-		new_pfn = (limit_pfn - size) & align_mask;
+		alloc_hi = min(alloc_hi, curr_iova->pfn_lo);
+		new_pfn = (alloc_hi - size) & align_mask;
 		prev = curr;
 		curr = rb_prev(curr);
 		curr_iova = rb_entry(curr, struct iova, node);
 	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
-	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+	if (alloc_hi < size || new_pfn < alloc_lo) {
+		if (alloc_lo == iovad->start_pfn && alloc_lo_new < limit_pfn) {
+			alloc_hi = limit_pfn;
+			alloc_lo = alloc_lo_new;
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
