Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4750CC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26ED220708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 07:45:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CpTVF/md"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgGGHpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:45:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbgGGHpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 03:45:40 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF62C08C5E0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 00:45:40 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so11427433pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 00:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jW8zp7RHqtHeCyFdrmHu1jeTiXid01JuKsYb1RMidWg=;
        b=CpTVF/md2a3iCa8VR9iJwBK+G4iEO3L+T91WDz+Cwf9dU1AKAoDicsLjreeKyMuI6+
         YwZ1SAPNLzOt2HW4z52+kblxmx9Giou4qhMRLwMT0gTMZI5ezBRqgROq30oOJoKjouRK
         3J1uVk+GxIJlUFvnsrYkMvc55CDvOetiLuVba0Bp72G2bMdvpN+EkHNpQoOFwRfzpMS6
         9zaldDwb7AKe/ABA84GNM5tGWm8q7roaWmtD2I0O8JkUe0PO9LoSpgUINDwMo/mPrQgF
         g+IWXRTXEEVZisw32wOull+Rocr/zu84Vk9HidbWayBOJwzb0zvF2a0QvBq7upT3lFZF
         lqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jW8zp7RHqtHeCyFdrmHu1jeTiXid01JuKsYb1RMidWg=;
        b=GAu0VHUccT8RR7lwKnTBer+INgKdoQKMKwlC25HfPtHfHJ1d1nbT3XWwjug7RSMcOM
         2B67hXFkDoeFdypsYhfUXH4HTD8ZFzbI26kkouMqpnqXXzQgQFLognb+UEUoFzXaLiKl
         vATWCLreZxehiw/tfPe0bTvsm80BN/hp+fr5COrTj+lAx4HSihxUBLTdnGxvSm2c5EUU
         U5vmOD6JL+YjLDiNf2LGTxIh9+w97ce3TRiPnbqc0jmrasFtfOel2K8ynnImZ+szNL5C
         aXTJdXcXPgyrUiuUPhe/wiUO/iGrzaF7EviuHunSXfgUbXNfrnrj3L64/IDj+cTR3GQA
         7WWw==
X-Gm-Message-State: AOAM531BWB8xBW+0tOJTV5p+RR3seRnhsnkIRG7FoP9lx0oJtPe0GSHV
        /FCKcFkvQz8SuULjQwFu28U=
X-Google-Smtp-Source: ABdhPJwAO+CEp4G8QkmcEaAo7/LkG4zHaUlREQ+Dc3Aaen6AxX9LJktCqAXuiD93ex8IH76Q/lo/RA==
X-Received: by 2002:a17:90a:db87:: with SMTP id h7mr3221109pjv.159.1594107939801;
        Tue, 07 Jul 2020 00:45:39 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id 191sm21330151pfw.150.2020.07.07.00.45.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 00:45:39 -0700 (PDT)
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
Subject: [PATCH v4 09/11] mm/page_alloc: remove a wrapper for alloc_migration_target()
Date:   Tue,  7 Jul 2020 16:44:47 +0900
Message-Id: <1594107889-32228-10-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

There is a well-defined standard migration target callback.  Use it
directly.

Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 mm/page_alloc.c     |  8 ++++++--
 mm/page_isolation.c | 10 ----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f3b70ee..6416d08 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -8354,6 +8354,10 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
 	unsigned long pfn = start;
 	unsigned int tries = 0;
 	int ret = 0;
+	struct migration_target_control mtc = {
+		.nid = zone_to_nid(cc->zone),
+		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
+	};
 
 	migrate_prep();
 
@@ -8380,8 +8384,8 @@ static int __alloc_contig_migrate_range(struct compact_control *cc,
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
index f25c66e..242c031 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -306,13 +306,3 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
 
 	return pfn < end_pfn ? -EBUSY : 0;
 }
-
-struct page *alloc_migrate_target(struct page *page, unsigned long private)
-{
-	struct migration_target_control mtc = {
-		.nid = page_to_nid(page),
-		.gfp_mask = GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL,
-	};
-
-	return alloc_migration_target(page, (unsigned long)&mtc);
-}
-- 
2.7.4

