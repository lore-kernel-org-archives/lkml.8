Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31759C433F7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CDCB20720
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:42:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sDuNBNnO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgGMGmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729520AbgGMGmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:42:37 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B20FDC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:37 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e8so5611873pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jW8zp7RHqtHeCyFdrmHu1jeTiXid01JuKsYb1RMidWg=;
        b=sDuNBNnOadqLFjEboOTN+KZ8ju+GgWtvG1go57WqkF61YVPNazQlaE46OSWopM8oFZ
         lGrlnqSLnlJEgCDa8NbqDo83oHtueBqc3u1SeeYXj1x2pW8CfhZiW1hT34jpnIlpKQq/
         gxLbBKW+H0KK1PcAN+u1pLISm2FIP1SxRFyZdUwsYFcJBTo96Cb/q1aAppvV7CtB9Z+S
         PjCEPG/gMe4F8bD21AVn0NheipHo0/Hd6CzGpQFJxcTGYdcGcYwh6KYbOxe/k6ukiCmP
         eM5kzhMnchgu7kJV04iWSI+96y2Iw5a4aIIh4QsEaDzyByhLwimrGX8VCfxDrqh2wF6T
         oI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jW8zp7RHqtHeCyFdrmHu1jeTiXid01JuKsYb1RMidWg=;
        b=TuF5yf6hoMaJt5WKPgL8qnr9fiVsIr5dREfjFvn3eDXar3CqT+1UHGtkPXCDHVITZh
         aga9oTkKe/xCWHW+Jqz6WSFcopqg4TIxuWneIEBynGIGkgaKI04/AhKokhuERtLEP+Ry
         doBmaXusYFN2CnT5QoKmL7g4m4C/wuEobhlT/qAh0PMQsYJYonos2N6k78y2kanAtZK9
         EH/Ma4Z/MRGAR9IO/Hq9fwwGAgpVM8PCOA9w6JM1QwOkcPNPF61gJVac4gUqeZLIgCNC
         PzD0EQAGUybhiZydFAqIy9gm0vkZ3jT9x20WpaEj/msGah6ndoVCvzAF4f3+EveKWVQv
         b6Dw==
X-Gm-Message-State: AOAM532ONlmTgdxmCnwGQLum+RnNJUPiRO+hl1COmJna0f9flB6AvjAq
        eDC9bk6VebfVAmzCy9aKerY=
X-Google-Smtp-Source: ABdhPJy5rFqXfwpnbs8a3UZi85qVhXCA9wmNrP9KpOBu9eRv/VWMwN3oVOjQ51d9bfLEXvlH7Sa6LA==
X-Received: by 2002:a63:de4b:: with SMTP id y11mr43982722pgi.26.1594622557329;
        Sun, 12 Jul 2020 23:42:37 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id l134sm12448695pga.50.2020.07.12.23.42.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:42:36 -0700 (PDT)
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
Subject: [PATCH v5 7/9] mm/page_alloc: remove a wrapper for alloc_migration_target()
Date:   Mon, 13 Jul 2020 15:41:55 +0900
Message-Id: <1594622517-20681-8-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1594622517-20681-1-git-send-email-iamjoonsoo.kim@lge.com>
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

