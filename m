Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3157FC54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04B5D221F4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="orTGtLKO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbgDTIAu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:49 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10100C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:49 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id v2so3653642plp.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBX6qWohHq9VKZ0U2mSr5aRQHj4zccdByOlpRqoMWwY=;
        b=orTGtLKOeO92VzedvwhPGpw+IJTJ77Ml1eZ8mqw74O+Jee5x6bfAEvyptoPctixtsg
         vstlIqY6+Po0HjsIaniK9lMNl4iAmo4P6x0PZGr4/IfrL5Umg5ikWaa2K1M5LO5n1XT6
         FAn5xLXWdfzKZjbfbexpTDWdpjXx4cQptExRCZb5DbLNDl/IOP3inQxmL9NtZyo+wX6J
         QO5fkWlk0qqIdnPMVTUnkesY/2QmJRKQXPQRydWW6p4qftXq11Dz+Dc8RmvIDB2YtEa8
         zhqlJNUIfrwQxcI3BB6ZpAbj6i5pKcAE1xC/NgG2FsNUY539eMZWSOOk17o8jcqO+44p
         Abkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBX6qWohHq9VKZ0U2mSr5aRQHj4zccdByOlpRqoMWwY=;
        b=BmMSzxAEN6KiyfXHxASRu1KdLeFjaYUo9T2Sdd6axeaKKv99YssP33xoUkxzQJEH0q
         WKmvbgoTasG8lxj1MR5p+Z2OidGeJ7j2da6CVwqwOHx+brsVnP3xukjYPX1M7fENgFxC
         bmRavsf1eMCMspmS8ZGnDFDq3QTY28RAdhMdodSiaB2uUqiwWpxtc4Z5gxnuE4vQfcVQ
         yRHUMyH7A7EzGhgLTLiRxeLv55NxSt1EVvsZinoxZmpw9qjcfS/lmVSp3CaikLIBwrcG
         0QmMz7BuIl59qs3Y5R/K2KVPuSlDFOHgvVWjvD7sbvhJiNGu/YBhWcDkvXXkLGDL2DQX
         scmg==
X-Gm-Message-State: AGi0PuZzRLCkCjisn7rwJ1XEXzmtzHIo7HZy/uIDNg+V3UAnhpbtJClP
        aOUa9QNjeS9JYy4ej3DXiu8=
X-Google-Smtp-Source: APiQypKKbyPIRbMq1vcNKZR0DJGfCfwbyZGhnv1+btoqsxzPHzT9AeM+BFO1DpUTeokUXQL0O0yLug==
X-Received: by 2002:a17:90b:3851:: with SMTP id nl17mr1446291pjb.45.1587369648598;
        Mon, 20 Apr 2020 01:00:48 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:00:47 -0700 (PDT)
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
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: [PATCH 05/10] power: separate PageHighMem() and PageHighMemZone() use case
Date:   Mon, 20 Apr 2020 16:59:37 +0900
Message-Id: <1587369582-3882-6-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Until now, PageHighMem() is used for two different cases. One is to check
if there is a direct mapping for this page or not. The other is to check
the zone of this page, that is, weather it is the highmem type zone or not.

Now, we have separate functions, PageHighMem() and PageHighMemZone() for
each cases. Use appropriate one.

Note that there are some rules to determine the proper macro.

1. If PageHighMem() is called for checking if the direct mapping exists
or not, use PageHighMem().
2. If PageHighMem() is used to predict the previous gfp_flags for
this page, use PageHighMemZone(). The zone of the page is related to
the gfp_flags.
3. If purpose of calling PageHighMem() is to count highmem page and
to interact with the system by using this count, use PageHighMemZone().
This counter is usually used to calculate the available memory for an
kernel allocation and pages on the highmem zone cannot be available
for an kernel allocation.
4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
is just copy of the previous PageHighMem() implementation and won't
be changed.

I apply the rule #3 for this patch.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 kernel/power/snapshot.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/power/snapshot.c b/kernel/power/snapshot.c
index 6598001..be759a6 100644
--- a/kernel/power/snapshot.c
+++ b/kernel/power/snapshot.c
@@ -1227,7 +1227,7 @@ static struct page *saveable_highmem_page(struct zone *zone, unsigned long pfn)
 	if (!page || page_zone(page) != zone)
 		return NULL;
 
-	BUG_ON(!PageHighMem(page));
+	BUG_ON(!PageHighMemZone(page));
 
 	if (swsusp_page_is_forbidden(page) ||  swsusp_page_is_free(page))
 		return NULL;
@@ -1291,7 +1291,7 @@ static struct page *saveable_page(struct zone *zone, unsigned long pfn)
 	if (!page || page_zone(page) != zone)
 		return NULL;
 
-	BUG_ON(PageHighMem(page));
+	BUG_ON(PageHighMemZone(page));
 
 	if (swsusp_page_is_forbidden(page) || swsusp_page_is_free(page))
 		return NULL;
@@ -1529,7 +1529,7 @@ static unsigned long preallocate_image_pages(unsigned long nr_pages, gfp_t mask)
 		if (!page)
 			break;
 		memory_bm_set_bit(&copy_bm, page_to_pfn(page));
-		if (PageHighMem(page))
+		if (PageHighMemZone(page))
 			alloc_highmem++;
 		else
 			alloc_normal++;
@@ -1625,7 +1625,7 @@ static unsigned long free_unnecessary_pages(void)
 		unsigned long pfn = memory_bm_next_pfn(&copy_bm);
 		struct page *page = pfn_to_page(pfn);
 
-		if (PageHighMem(page)) {
+		if (PageHighMemZone(page)) {
 			if (!to_free_highmem)
 				continue;
 			to_free_highmem--;
@@ -2264,7 +2264,7 @@ static unsigned int count_highmem_image_pages(struct memory_bitmap *bm)
 	memory_bm_position_reset(bm);
 	pfn = memory_bm_next_pfn(bm);
 	while (pfn != BM_END_OF_MAP) {
-		if (PageHighMem(pfn_to_page(pfn)))
+		if (PageHighMemZone(pfn_to_page(pfn)))
 			cnt++;
 
 		pfn = memory_bm_next_pfn(bm);
@@ -2541,7 +2541,7 @@ static void *get_buffer(struct memory_bitmap *bm, struct chain_allocator *ca)
 		return ERR_PTR(-EFAULT);
 
 	page = pfn_to_page(pfn);
-	if (PageHighMem(page))
+	if (PageHighMemZone(page))
 		return get_highmem_page_buffer(page, ca);
 
 	if (swsusp_page_is_forbidden(page) && swsusp_page_is_free(page))
-- 
2.7.4

