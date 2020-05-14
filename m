Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5785AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32DD42065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 11:59:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="B3UIZ7fC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726872AbgENL7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 07:59:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:63304 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725955AbgENL7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 07:59:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589457569; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=GWge08NUpx9hYk85PE+U6cP3rNMxXJ52WIEvWFBmNxA=; b=B3UIZ7fCnhcpHa+WJIcTpIAA/QdBu/6UFqr0TkLwsdA3RlhfQrA891uhLbMaPX88GK8eRqy/
 ZJTpDa55Qf+42ZpmeggG0+gGRl+tSoogeZJohqAFLtOh8MZnO9TlbApwRXsR1AqYrGzXM5f7
 S0gpy9YXMC822l+qFpemfCwX6rA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebd32a1.7fa3df0c8ce0-smtp-out-n05;
 Thu, 14 May 2020 11:59:29 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 0195AC433F2; Thu, 14 May 2020 11:59:29 +0000 (UTC)
Received: from charante-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B1A7DC433D2;
        Thu, 14 May 2020 11:59:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B1A7DC433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH v2] mm, page_alloc: reset the zone->watermark_boost early
Date:   Thu, 14 May 2020 17:28:31 +0530
Message-Id: <1589457511-4255-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating the zone watermarks by any means, like min_free_kbytes,
water_mark_scale_factor e.t.c, when ->watermark_boost is set will result
into the higher low and high watermarks than the user asked.

Below are the steps pursued to reproduce the problem on system setup
of Android kernel running on Snapdragon hardware.
1) Default settings of the system are as below:
   #cat /proc/sys/vm/min_free_kbytes = 5162
   #cat /proc/zoneinfo | grep -e boost -e low -e "high " -e min -e Node
	Node 0, zone   Normal
		min      797
		low      8340
		high     8539

2) Monitor the zone->watermark_boost(by adding a debug print in
the kernel) and whenever it is greater than zero value, write the
same value of min_free_kbytes obtained from step 1.
   #echo 5162 > /proc/sys/vm/min_free_kbytes

3) Then read the zone watermarks in the system while the
->watermark_boost is zero. This should show the same values of
watermarks as step 1 but shown a higher values than asked.
   #cat /proc/zoneinfo | grep -e boost -e low -e "high " -e min -e Node
	Node 0, zone   Normal
		min      797
		low      21148
		high     21347

These higher values are because of updating the zone watermarks using
the macro min_wmark_pages(zone) which also adds the
zone->watermark_boost.
	#define min_wmark_pages(z) (z->_watermark[WMARK_MIN] +
					z->watermark_boost)

So the steps that lead to the issue is like below:
1) On the extfrag event, watermarks are boosted by storing the required
value in ->watermark_boost.

2) User tries to update the zone watermarks level in the system through
min_free_kbytes or watermark_scale_factor.

3) Later, when kswapd woke up, it resets the zone->watermark_boost to
zero.

In step 2), we use the min_wmark_pages() macro to store the watermarks
in the zone structure thus the values are always offsetted by
->watermark_boost value. This can be avoided by resetting the
->watermark_boost to zero before it is used.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---

v2: Improve the commit message

v1: (https://patchwork.kernel.org/patch/11540751/)

 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index cef05d3..d001d61 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7761,9 +7761,9 @@ static void __setup_per_zone_wmarks(void)
 			    mult_frac(zone_managed_pages(zone),
 				      watermark_scale_factor, 10000));
 
+		zone->watermark_boost = 0;
 		zone->_watermark[WMARK_LOW]  = min_wmark_pages(zone) + tmp;
 		zone->_watermark[WMARK_HIGH] = min_wmark_pages(zone) + tmp * 2;
-		zone->watermark_boost = 0;
 
 		spin_unlock_irqrestore(&zone->lock, flags);
 	}
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation
