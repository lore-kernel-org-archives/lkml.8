Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C394C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5028D20775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8AN/GDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgD2D1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726792AbgD2D1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:45 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD8C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:45 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id x15so445130pfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=muaMvVRvtjif1FDtMnzRTyXTeXTgI5C5K36AlArPZQc=;
        b=k8AN/GDeTBchP4fwIbxkOgddQWIgIffopQu3L3mCelIC0WH5OlOaFYq2vr9jCIS2Dp
         2krdBtEqJbZzTxYlKup706YS+rz81b7bXBV/3IOJbUQY4AMEz7nR75/FyUvfKnt5jLfd
         pHdpLx4coUMCwvx7y39jdSiiFTFwKkbOhb4zvM/RVj22Ll7D9emJQdsz1n83bKg5AQyf
         bIGIa9R6PKXn1WH131aPrpcpTgwZ9FZ07DtTEl/XzfliTX0h39bHIyeOwagSxbLGI4GH
         zsrA+pq3wHVgHXeFHDOzyS5fvCFGZXGD/Tu0VwQGRP3A+SCC6st0oOkQyCK6eJJVw9DL
         rJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=muaMvVRvtjif1FDtMnzRTyXTeXTgI5C5K36AlArPZQc=;
        b=Ipv4LKbBfF7B6ppHwLbzOpUmii5LqN2LsRPLFq4UISetPFBWAnC7s9DpnPoeDBBX7T
         n4SD1We4civz63KJF6DdOdV9pj0coGWdnr1R6aaOvAFbjxVvJo1ISls4Oi/tlmcQCDXi
         +ZAlek24261jA91srQGiREq5rdXexffQ7JNtNVNpLT3HAimAapaz0HgVrS9jbDD+nShh
         u13Q3cqZWEo2CabHdZbFPbpRTpvhJ4im8lYl2uwG39O8XmgWXD9URMpTEwVqvtkdX9XC
         jXoWNgQclXBwpapxR0GgrUnhsZ0ZvEgb54Lq/g7Uvw5cyiXiGBDHmL9zLoxD1qngCuRJ
         DAeQ==
X-Gm-Message-State: AGi0PuZVQz6QC+CAeMTM+hIYAoNqoSGR4uMGZ+3Rg8qFD11QyswyfkgA
        hK9/Ls49fwYs7xouDtVmFXQ=
X-Google-Smtp-Source: APiQypIOlvX1ynHI0c0eTMrkTJOg9W5adSFTgZ3L1ADNWrNXotMti7seYk0A26aon5+1T+jgVH3X8A==
X-Received: by 2002:a63:7f1a:: with SMTP id a26mr19199834pgd.252.1588130865211;
        Tue, 28 Apr 2020 20:27:45 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:44 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, kernel-team@lge.com,
        Christoph Hellwig <hch@infradead.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v2 09/10] mm/migrate: replace PageHighMem() with open-code
Date:   Wed, 29 Apr 2020 12:26:42 +0900
Message-Id: <1588130803-20527-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Implementation of PageHighMem() will be changed in following patches.
Before that, use open-code to avoid the side effect of implementation
change on PageHighMem().

Acked-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/migrate.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 3e546cb..a9cfd8e 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -37,6 +37,7 @@ static inline struct page *new_page_nodemask(struct page *page,
 	gfp_t gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL;
 	unsigned int order = 0;
 	struct page *new_page = NULL;
+	int zidx;
 
 	if (PageHuge(page))
 		return alloc_huge_page_nodemask(page_hstate(compound_head(page)),
@@ -47,7 +48,8 @@ static inline struct page *new_page_nodemask(struct page *page,
 		order = HPAGE_PMD_ORDER;
 	}
 
-	if (PageHighMem(page) || (zone_idx(page_zone(page)) == ZONE_MOVABLE))
+	zidx = zone_idx(page_zone(page));
+	if (is_highmem_idx(zidx) || zidx == ZONE_MOVABLE)
 		gfp_mask |= __GFP_HIGHMEM;
 
 	new_page = __alloc_pages_nodemask(gfp_mask, order,
-- 
2.7.4

