Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5C5C54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E33F206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 13:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nfc2QDHK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729762AbgEKNk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 09:40:28 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:51143 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgEKNk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 09:40:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589204427; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=BjnT+wQssjNt8bOOqGZ9Ke9C4pujItT6DZsy/y1cchM=; b=nfc2QDHKVaZBzJdKP14JvUJw+uHK8ajUwr5yQZUnBMHfSgpSoK9AkbamrC+zfY4jfRFX1paE
 ZlXszFyD1MlNvY/ZeYH7K0SDN+++2JOgckd7gs3O8kAWOfF0gWU+J3k4/d9PzVnjuMupHFmx
 XDnxWaFcaEuIv5Thtx+3prDuxps=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb955c4.7fe1efd24b20-smtp-out-n05;
 Mon, 11 May 2020 13:40:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8B55EC433CB; Mon, 11 May 2020 13:40:19 +0000 (UTC)
Received: from charante-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4786EC433F2;
        Mon, 11 May 2020 13:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4786EC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm, page_alloc: reset the zone->watermark_boost early
Date:   Mon, 11 May 2020 19:10:08 +0530
Message-Id: <1589204408-5152-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updating the zone watermarks by any means, like extra_free_kbytes,
min_free_kbytes, water_mark_scale_factor e.t.c, when watermark_boost is
set will result into the higher low and high watermarks than the user
asks. This can be avoided by resetting the zone->watermark_boost to zero
early.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 1b265b09..822e262 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7746,9 +7746,9 @@ static void __setup_per_zone_wmarks(void)
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
