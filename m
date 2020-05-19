Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F425C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8FE207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 09:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="VYUcP0s8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgESJ6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 05:58:25 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:19587 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726121AbgESJ6Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 05:58:24 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589882304; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=s+AdGI5XfKXn2vhFE20uM+6hS+slzQYyrhXIMBez0oU=; b=VYUcP0s8yo9V+q1JDpKj04mAJHaD55f+DySWMwZJyfC4Pdg64lHS5aDy6WW41mItzQ+pn7+a
 dx+6KVUa6pkFbrZEzdsb+hd3SXEPURI0vVt1uNOcGlOICoL2sQa4RPmgu0oSq+9FlXHwHtML
 yCKIvL1cmuePZ/g7b5RprWIAExc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 5ec3adb775dd50406e273d83 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 19 May 2020 09:58:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C626C43636; Tue, 19 May 2020 09:58:15 +0000 (UTC)
Received: from charante-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 86DDDC433D2;
        Tue, 19 May 2020 09:58:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 86DDDC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm, page_alloc: skip ->waternark_boost for atomic order-0 allocations
Date:   Tue, 19 May 2020 15:28:04 +0530
Message-Id: <1589882284-21010-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 1.9.1
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

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/page_alloc.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d001d61..5193d7e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3709,6 +3709,18 @@ static bool zone_allows_reclaim(struct zone *local_zone, struct zone *zone)
 		}
 
 		mark = wmark_pages(zone, alloc_flags & ALLOC_WMARK_MASK);
+		/*
+		 * Allow GFP_ATOMIC order-0 allocations to exclude the
+		 * zone->watermark_boost in its watermark calculations.
+		 * We rely on the ALLOC_ flags set for GFP_ATOMIC
+		 * requests in gfp_to_alloc_flags() for this. Reason not to
+		 * use the GFP_ATOMIC directly is that we want to fall back
+		 * to slow path thus wake up kswapd.
+		 */
+		if (unlikely(!order && !(alloc_flags & ALLOC_WMARK_MASK) &&
+		     (alloc_flags & (ALLOC_HARDER | ALLOC_HIGH)))) {
+			mark = zone->_watermark[WMARK_MIN];
+		}
 		if (!zone_watermark_fast(zone, order, mark,
 				       ac->highest_zoneidx, alloc_flags)) {
 			int ret;
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

