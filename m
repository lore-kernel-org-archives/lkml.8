Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4838BC35E03
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F72A20732
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 14:15:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730659AbgBYOPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 09:15:43 -0500
Received: from outbound-smtp46.blacknight.com ([46.22.136.58]:45641 "EHLO
        outbound-smtp46.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730392AbgBYOPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 09:15:38 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp46.blacknight.com (Postfix) with ESMTPS id E87F9FA7B4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 14:15:36 +0000 (GMT)
Received: (qmail 1974 invoked from network); 25 Feb 2020 14:15:36 -0000
Received: from unknown (HELO stampy.112glenside.lan) (mgorman@techsingularity.net@[84.203.18.57])
  by 81.17.254.9 with ESMTPA; 25 Feb 2020 14:15:36 -0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        Ivan Babrou <ivan@cloudflare.com>,
        Rik van Riel <riel@surriel.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: [PATCH 2/3] mm, page_alloc: Disable watermark boosting if THP is disabled at boot
Date:   Tue, 25 Feb 2020 14:15:33 +0000
Message-Id: <20200225141534.5044-3-mgorman@techsingularity.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200225141534.5044-1-mgorman@techsingularity.net>
References: <20200225141534.5044-1-mgorman@techsingularity.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Watermark boosting is intended to increase the success rate and reduce
latency of high-order allocations, particularly THP. If THP is disabled
at boot, then it makes sense to disable watermark boosting as well. While
there are other high-order allocations that potentially benefit, they
are relatively rare.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
---
 mm/huge_memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b08b199f9a11..565bb9973ff8 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -472,6 +472,7 @@ static int __init setup_transparent_hugepage(char *str)
 			  &transparent_hugepage_flags);
 		clear_bit(TRANSPARENT_HUGEPAGE_REQ_MADV_FLAG,
 			  &transparent_hugepage_flags);
+		disable_watermark_boosting();
 		ret = 1;
 	}
 out:
-- 
2.16.4

