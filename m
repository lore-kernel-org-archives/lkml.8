Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CF0C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D46792072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 05:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HvFKC9NS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgHYFAA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 01:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728159AbgHYE77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 00:59:59 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C35C061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:59:59 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 31so3724318pgy.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 21:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=CujjVNlCBITdfLG2aFM5tMhbSU/fDXpGUzs/pQuuzRE=;
        b=HvFKC9NSuGtmoN2nkRQRB89nb5D1b6pNSLZztimut3+DtGH/VMtl+ADpUf4POGIjqd
         9Fs03QTaNVRlClXTS6x0Dxbgxgzp74huKGew2Tpzmx7z50nO+u5qO4WxIL+You+Ei5ia
         FVQPf0BJdVUA6FYYmoSKfCWIMMK73tgMTP8m6bILGiKSyEMU2lEM78oeubAi75/Yc1zD
         h2bcXT78SbQZ1nbEaOexZiRKgYz4FEcv1PwJa1LkM7792lFQLbjHSY2acjJ2OO9JYcPo
         MIYj6zsKEWDyq5I8Y7fy0jsdRHfnZCWMk7yLHfozu0V3GJ69NEjGTU8rBl5Xj2rHNDSM
         RDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=CujjVNlCBITdfLG2aFM5tMhbSU/fDXpGUzs/pQuuzRE=;
        b=HvlAMFjafRGJ97J0CNV1fe2UU6uI+OywtTezE+V1R+h/F8rnnmagpuwC5jjSx6vGfD
         bJzEtzJEbA9AUjJTvFZUsDTLef6dW6uhyfia+C4uIegCKmF4n1iibOhpXZo8MxKFsJic
         jQSd59MUiPzgwRFzr7OaFj47lNf8xfH4I3ZDfhEjvFl46ZwLQ6B+CS4c7EktPqIleBd4
         WbKaADNhVihgdRdy3loJ2GbTPxswtEPYduVWxRJQwhVqWEGbaW3n8CLOMUa2y0Hs8z0N
         g65XPb97ZnbqxnN+dIhJNDwGzRkQDhIyWzhmKt26Q3wpkYKmcJ63IPiT8vEdzu8N/rM9
         s7nA==
X-Gm-Message-State: AOAM5327hcQZt/U2Vd9Ph/OqjAA4Gq2K2qU8QcVz4VMSW6900k4r3der
        qhCGIwphbWWY8g11ouu5FQON3c3jVv8=
X-Google-Smtp-Source: ABdhPJwYQngyhKIADWe0XS9wdCX6FqarosKpZUi4yFyZfbyt9FnMKzSNHXm0u+GoATqXUHmBWN4ATg==
X-Received: by 2002:a62:5214:: with SMTP id g20mr6763671pfb.168.1598331598622;
        Mon, 24 Aug 2020 21:59:58 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id b78sm13754694pfb.144.2020.08.24.21.59.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 21:59:58 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH for v5.9] mm/page_alloc: handle a missing case for memalloc_nocma_{save/restore} APIs
Date:   Tue, 25 Aug 2020 13:59:42 +0900
Message-Id: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

memalloc_nocma_{save/restore} APIs can be used to skip page allocation
on CMA area, but, there is a missing case and the page on CMA area could
be allocated even if APIs are used. This patch handles this case to fix
the potential issue.

Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
specified.

This patch implements this behaviour by checking allocated page from
the pcplist rather than skipping an allocation from the pcplist entirely.
Skipping the pcplist entirely would result in a mismatch between watermark
check and actual page allocation. And, it requires to break current code
layering that order-0 page is always handled by the pcplist. I'd prefer
to avoid it so this patch uses different way to skip CMA page allocation
from the pcplist.

Fixes: 8510e69c8efe (mm/page_alloc: fix memalloc_nocma_{save/restore} APIs)
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e2bab4..c4abf58 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3341,6 +3341,22 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	pcp = &this_cpu_ptr(zone->pageset)->pcp;
 	list = &pcp->lists[migratetype];
 	page = __rmqueue_pcplist(zone,  migratetype, alloc_flags, pcp, list);
+#ifdef CONFIG_CMA
+	if (page) {
+		int mt = get_pcppage_migratetype(page);
+
+		/*
+		 * pcp could have the pages on CMA area and we need to skip it
+		 * when !ALLOC_CMA. Free all pcplist and retry allocation.
+		 */
+		if (is_migrate_cma(mt) && !(alloc_flags & ALLOC_CMA)) {
+			list_add(&page->lru, &pcp->lists[migratetype]);
+			pcp->count++;
+			free_pcppages_bulk(zone, pcp->count, pcp);
+			page = __rmqueue_pcplist(zone, migratetype, alloc_flags, pcp, list);
+		}
+	}
+#endif
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
 		zone_statistics(preferred_zone, zone);
-- 
2.7.4

