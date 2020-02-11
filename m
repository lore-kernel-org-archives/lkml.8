Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD02C35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7DF20714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 05:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgBKFYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 00:24:32 -0500
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:37366 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727557AbgBKFYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:24:31 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R561e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04396;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TpeTAeD_1581398658;
Received: from localhost(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TpeTAeD_1581398658)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 11 Feb 2020 13:24:29 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: vmpressure: use mem_cgroup_is_root API
Date:   Tue, 11 Feb 2020 13:24:09 +0800
Message-Id: <1581398649-125989-2-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
References: <1581398649-125989-1-git-send-email-yang.shi@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use mem_cgroup_is_root() API to check if memcg is root memcg instead of
open coding.

Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 mm/vmpressure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 0590f00..d69019f 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -280,7 +280,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
 		enum vmpressure_levels level;
 
 		/* For now, no users for root-level efficiency */
-		if (!memcg || memcg == root_mem_cgroup)
+		if (!memcg || mem_cgroup_is_root(memcg))
 			return;
 
 		spin_lock(&vmpr->sr_lock);
-- 
1.8.3.1

