Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A59EAC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8508B207DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 12:56:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NG0Rp+3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgHBMz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 08:55:57 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:12412 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgHBMz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 08:55:57 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596372956; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vqFI7c3dNZv0B1DGOiIOgm5q/aIuLzWPrYQcR71+t7k=; b=NG0Rp+3+hvOHPH3U//5xCRtxNHu77sXyyHQFTyBaWDEVTMi2aQLSUdaZSs0QSyBOCzanx3Ch
 YLUE007YtF5fj+pGWu5ZoybZ9NHJLBKlic91siiAU3852DCeBjhxqTXlnCCd9F98YqXh4gUa
 KhGJlbnVfBvwr1ub5wwzfkSDNfo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f26b7d8eb556d49a6103267 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 02 Aug 2020 12:55:52
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 76D57C433CB; Sun,  2 Aug 2020 12:55:52 +0000 (UTC)
Received: from charante-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: charante)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4270AC433C6;
        Sun,  2 Aug 2020 12:55:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4270AC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=charante@codeaurora.org
From:   Charan Teja Reddy <charante@codeaurora.org>
To:     akpm@linux-foundation.org, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, vinmenon@codeaurora.org,
        Charan Teja Reddy <charante@codeaurora.org>
Subject: [PATCH] mm, memory_hotplug: update pcp lists everytime onlining a memory block
Date:   Sun,  2 Aug 2020 18:24:56 +0530
Message-Id: <1596372896-15336-1-git-send-email-charante@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When onlining a first memory block in a zone, pcp lists are not updated
thus pcp struct will have the default setting of ->high = 0,->batch = 1.
This means till the second memory block in a zone(if it have) is onlined
the pcp lists of this zone will not contain any pages because pcp's
->count is always greater than ->high thus free_pcppages_bulk() is
called to free batch size(=1) pages every time system wants to add a
page to the pcp list through free_unref_page(). To put this in a word,
system is not using benefits offered by the pcp lists when there is a
single onlineable memory block in a zone. Correct this by always
updating the pcp lists when memory block is onlined.

Signed-off-by: Charan Teja Reddy <charante@codeaurora.org>
---
 mm/memory_hotplug.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index dcdf327..7f62d69 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -854,8 +854,7 @@ int __ref online_pages(unsigned long pfn, unsigned long nr_pages,
 	node_states_set_node(nid, &arg);
 	if (need_zonelists_rebuild)
 		build_all_zonelists(NULL);
-	else
-		zone_pcp_update(zone);
+	zone_pcp_update(zone);
 
 	init_per_zone_wmark_min();
 
-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a
member of the Code Aurora Forum, hosted by The Linux Foundation

