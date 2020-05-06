Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D91BC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 356CF2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="M9DQmflz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgEFUDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:03:04 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:64042 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725966AbgEFUDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:03:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588795384; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0qIdTUUATMq8n20RL86MZF5csAq5w4nM1wfS8+2VTvs=; b=M9DQmflzQrgA6Yh+1R8P3RJn8gs3tIfveR6TovryIrbeFORAxqHZPorje+svnroZcyAsEug/
 CFVXxON/Vd41EGjKZBO7weKyj2ZHP+yDlVWkwqNDcAfc/Oj86HJxMYV4ckT9fZbAA6LCnz/Q
 a97SFlbqVEqYHm5tCAvU8nqLOcs=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb317f5.7fa7ba007dc0-smtp-out-n03;
 Wed, 06 May 2020 20:03:01 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6A3B6C433F2; Wed,  6 May 2020 20:03:00 +0000 (UTC)
Received: from vjitta-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vjitta)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DE3C8C433BA;
        Wed,  6 May 2020 20:02:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DE3C8C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=vjitta@codeaurora.org
From:   vjitta@codeaurora.org
To:     joro@8bytes.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     vinmenon@codeaurora.org, kernel-team@android.com,
        vjitta@codeaurora.org
Subject: [PATCH] iommu/iova: Retry from last rb tree node if iova search fails
Date:   Thu,  7 May 2020 01:31:57 +0530
Message-Id: <1588795317-20879-1-git-send-email-vjitta@codeaurora.org>
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
 drivers/iommu/iova.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 0e6a953..2985222 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -186,6 +186,7 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	unsigned long flags;
 	unsigned long new_pfn;
 	unsigned long align_mask = ~0UL;
+	bool retry = false;
 
 	if (size_aligned)
 		align_mask <<= fls_long(size - 1);
@@ -198,6 +199,8 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 
 	curr = __get_cached_rbnode(iovad, limit_pfn);
 	curr_iova = rb_entry(curr, struct iova, node);
+
+retry_search:
 	do {
 		limit_pfn = min(limit_pfn, curr_iova->pfn_lo);
 		new_pfn = (limit_pfn - size) & align_mask;
@@ -207,6 +210,14 @@ static int __alloc_and_insert_iova_range(struct iova_domain *iovad,
 	} while (curr && new_pfn <= curr_iova->pfn_hi);
 
 	if (limit_pfn < size || new_pfn < iovad->start_pfn) {
+		if (!retry) {
+			curr = rb_last(&iovad->rbroot);
+			curr_iova = rb_entry(curr, struct iova, node);
+			limit_pfn = curr_iova->pfn_lo;
+			retry = true;
+			goto retry_search;
+		}
+
 		iovad->max32_alloc_size = size;
 		goto iova32_full;
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
1.9.1
