Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B3EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:10:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ACE320760
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 12:10:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iO5xAJME"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728249AbgFKMKB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 08:10:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49313 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728237AbgFKMJ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 08:09:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591877397; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Date: Message-ID: Subject: From: Cc: To: Sender;
 bh=GHyDQ0CNebWZew+ULIczlDAXcOVl5+2NRVl7coOxMuc=; b=iO5xAJME4au4CDyEUQx9I0yuTKep4yWvVZIcp6aTWenAbU9sdhTNIS6FUN4VQSwqpxNHrvT0
 9ewZ3TD3JXCZPxRoTNXtTMsjlOn0QnQ9u6EWn5jRZfMk4N1q/dEdIJzIF2bADFAL8dL3/mzG
 WHLH2YTtxQ6geRRdldcPmapzUnA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5ee21f11f3deea03f32a289c (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Jun 2020 12:09:53
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B643C433B1; Thu, 11 Jun 2020 12:09:53 +0000 (UTC)
Received: from [192.168.1.102] (unknown [183.83.143.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2005EC433C8;
        Thu, 11 Jun 2020 12:09:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2005EC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
To:     Andrew Morton <akpm@linux-foundation.org>,
        mgorman@techsingularity.net, linux-mm@kvack.org
Cc:     LKML <linux-kernel@vger.kernel.org>, vinmenon@codeaurora.org
From:   Charan Teja Kalla <charante@codeaurora.org>
Subject: [PATCH] mm, page_alloc: skip ->watermark_boost for atomic order-0
 allocations-fix
Message-ID: <31556793-57b1-1c21-1a9d-22674d9bd938@codeaurora.org>
Date:   Thu, 11 Jun 2020 17:39:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When boosting is enabled, it is observed that rate of atomic order-0
allocation failures are high due to the fact that free levels in the
system are checked with ->watermark_boost offset. This is not a problem
for sleepable allocations but for atomic allocations which looks like
regression.

This problem is seen frequently on system setup of Android kernel
running on Snapdragon hardware with 4GB RAM size. When no extfrag event
occurred in the system, ->watermark_boost factor is zero, thus the
watermark configurations in the system are:
   _watermark = (
          [WMARK_MIN] = 1272, --> ~5MB
          [WMARK_LOW] = 9067, --> ~36MB
          [WMARK_HIGH] = 9385), --> ~38MB
   watermark_boost = 0

After launching some memory hungry applications in Android which can
cause extfrag events in the system to an extent that ->watermark_boost
can be set to max i.e. default boost factor makes it to 150% of high
watermark.
   _watermark = (
          [WMARK_MIN] = 1272, --> ~5MB
          [WMARK_LOW] = 9067, --> ~36MB
          [WMARK_HIGH] = 9385), --> ~38MB
   watermark_boost = 14077, -->~57MB

With default system configuration, for an atomic order-0 allocation to
succeed, having free memory of ~2MB will suffice. But boosting makes
the min_wmark to ~61MB thus for an atomic order-0 allocation to be
successful system should have minimum of ~23MB of free memory(from
calculations of zone_watermark_ok(), min = 3/4(min/2)). But failures are
observed despite system is having ~20MB of free memory. In the testing,
this is reproducible as early as first 300secs since boot and with
furtherlowram configurations(<2GB) it is observed as early as first
150secs since boot.

These failures can be avoided by excluding the ->watermark_boost in
watermark caluculations for atomic order-0 allocations.

Fix-suggested-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---

Change in linux-next: https://lore.kernel.org/patchwork/patch/1244272/ 

 mm/page_alloc.c | 36 ++++++++++++++++++++----------------
 1 file changed, 20 insertions(+), 16 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c435b2..18f407e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3580,7 +3580,7 @@ bool zone_watermark_ok(struct zone *z, unsigned int order, unsigned long mark,
 
 static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 				unsigned long mark, int highest_zoneidx,
-				unsigned int alloc_flags)
+				unsigned int alloc_flags, gfp_t gfp_mask)
 {
 	long free_pages = zone_page_state(z, NR_FREE_PAGES);
 	long cma_pages = 0;
@@ -3602,8 +3602,23 @@ static inline bool zone_watermark_fast(struct zone *z, unsigned int order,
 				mark + z->lowmem_reserve[highest_zoneidx])
 		return true;
 
-	return __zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
-					free_pages);
+	if (__zone_watermark_ok(z, order, mark, highest_zoneidx, alloc_flags,
+					free_pages))
+		return true;
+	/*
+	 * Ignore watermark boosting for GFP_ATOMIC order-0 allocations
+	 * when checking the min watermark. The min watermark is the
+	 * point where boosting is ignored so that kswapd is woken up
+	 * when below the low watermark.
+	 */
+	if (unlikely(!order && (gfp_mask & __GFP_ATOMIC) && z->watermark_boost
+		&& ((alloc_flags & ALLOC_WMARK_MASK) == WMARK_MIN))) {
+		mark = z->_watermark[WMARK_MIN];
+		return __zone_watermark_ok(z, order, mark, highest_zoneidx,
+					alloc_flags, free_pages);
+	}
+
+	return false;
 }
 
 bool zone_watermark_ok_safe(struct zone *z, unsigned int order,
@@ -3746,20 +3761,9 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 		}
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
-		/*
-		 * Allow GFP_ATOMIC order-0 allocations to exclude the
-		 * zone->watermark_boost in their watermark calculations.
-		 * We rely on the ALLOC_ flags set for GFP_ATOMIC requests in
-		 * gfp_to_alloc_flags() for this.  Reason not to use the
-		 * GFP_ATOMIC directly is that we want to fall back to slow path
-		 * thus wake up kswapd.
-		 */
-		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
-		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
-			mark = zone->_watermark[WMARK_MIN];
-		}
 		if (!zone_watermark_fast(zone, order, mark,
-				       ac->highest_zoneidx, alloc_flags)) {
+				       ac->highest_zoneidx, alloc_flags,
+				       gfp_mask)) {
 			int ret;
 
 #ifdef CONFIG_DEFERRED_STRUCT_PAGE_INIT
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
