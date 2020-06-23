Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 549A6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B43520772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:14:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uu36BHU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbgFWGOy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730412AbgFWGOv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:14:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7613C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:51 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id b16so9572372pfi.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 23:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=aLO5MtRfj6NH9QBTrO4jlGsPPU/dMtpy8l2hw8EHd8U=;
        b=uu36BHU3hicW3omtidDGbKh1z20N5PY/FyKfczJGKsarHZz2s5tqDM6OUsoJlatpeI
         Hh2dRkvpIjOOd6o+qsz98mpMljkhw5jJAwR5WEHy8DRwJRG1AnIYxMdUAFW6HL6Q60Hu
         3FeI8hZGfv/M8Q6Zddcws0/dSei6zWG4eBxFRwOmYu+RF6oCwxlKdapSYTlW1kltblf1
         XuTKA5+TzvNBkfUfiN//Vs/prf6pgOIW0KAInT2Huu7abktcC8c47Iw0fraysYSIR5ce
         RmaASndb3OpgmfeDEQU/7qGPx4QbUMoX2T4fm01E5WmVOyW8mZ+fy0cxVtMRHgVPQsaN
         lfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=aLO5MtRfj6NH9QBTrO4jlGsPPU/dMtpy8l2hw8EHd8U=;
        b=ENsB2roenAYzjnVpvp2N6tUvGK7AlwliqfufpAtdavXPr80myArK/Cj2LCZjutt6DJ
         CVJgcyhqtz5VP+wxMfWz2Yf1rv2MDrsoTAx+4++L+jIX3oThzPDNtGtbD1XD6gRPrzVU
         LOB6g1d23Pkhx02xQZuTDe2uR69NXaNSYO9qJfXT7g4vEs2yoYGwgjHZYoMplBRKFkkX
         wZoj+qi00SrtAwSenopOJFWvvaBTPbBg/iJPVIXj61af17YTMYwp2/NW7Nno1ZFMspyG
         7SH9Jj7M1EicISYcXSV3yNfygjuKMtMAP4gvhPrJ+MzDQ7s6VJ8vPGfzk8elwBVR/uKV
         QDvA==
X-Gm-Message-State: AOAM531Jp9tVgKAyJdHSbzHwCSy5F1AxTGOhiZdl3h2WrOe1dEI3u4PE
        SV2RfCesfQfgt+PQwSOXyB0=
X-Google-Smtp-Source: ABdhPJyg2kZv3M0fSNkQ/Ab+6Tn54VFlyrQjmn6jE7KelDWuKlXnOv58fbhblhQQO1wRtkS0b4xn/g==
X-Received: by 2002:a62:2acf:: with SMTP id q198mr24689706pfq.48.1592892891379;
        Mon, 22 Jun 2020 23:14:51 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id m15sm12801093pgv.45.2020.06.22.23.14.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jun 2020 23:14:50 -0700 (PDT)
From:   js1304@gmail.com
X-Google-Original-From: iamjoonsoo.kim@lge.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH v3 8/8] mm/page_alloc: remove a wrapper for alloc_migration_target()
Date:   Tue, 23 Jun 2020 15:13:48 +0900
Message-Id: <1592892828-1934-9-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined standard migration target callback.
Use it directly.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c     |  9 +++++++--
 mm/page_isolation.c | 11 -----------
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 9808339..884dfb5 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8359,6 +8359,11 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	unsigned long pfn = start;
 	unsigned int tries = 0;
 	int ret = 0;
+	struct migration_target_control mtc = {
+		.nid = zone_to_nid(cc->zone),
+		.nmask = &node_states[N_MEMORY],
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
 	migrate_prep();
 
@@ -8385,8 +8390,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 							&cc->migratepages);
 		cc->nr_migratepages -= nr_reclaimed;
 
-		ret = migrate_pages(&cc->migratepages, alloc_migrate_target,
-				    NULL, 0, cc->mode, MR_CONTIG_RANGE);
+		ret = migrate_pages(&cc->migratepages, alloc_migration_target,
+				NULL, (unsigned long)&mtc, cc->mode, MR_CONTIG_RANGE);
 	}
 	if (ret < 0) {
 		putback_movable_pages(&cc->migratepages);
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index adba031..242c031 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -306,14 +306,3 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 	return pfn < end_pfn ? -EBUSY : 0;
 }
-
-struct page *alloc_migrate_target(struct page *page, unsigned long private)
-{
-	struct migration_target_control mtc = {
-		.nid = page_to_nid(page),
-		.nmask = &node_states[N_MEMORY],
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
-	};
-
-	return alloc_migration_target(page, (unsigned long)&mtc);
-}
-- 
2.7.4

