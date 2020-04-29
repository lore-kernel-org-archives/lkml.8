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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B83C83001
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4960120784
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rs9+Ni8w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgD2D1V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgD2D1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:20 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6155C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:20 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id q124so351823pgq.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4/eFw0vWwBVRaZ/3UIgJHxLSvTZ3eLOl09I88FAedw=;
        b=rs9+Ni8w22sXa2fxOCse9k1u5KKvpq45u6RYgFD5LUjVWiQJ/O9bc0lxa7v4eq5hdI
         BQkya5ZqzYtX0fd2dUOt1QRWJ8FKBKayS+ow0GjDI3u1P3KeSjyI2bKCSdaw6WoqiBQH
         7XzJVvu50l15zTz2KqNrRT5/qP7o8y7pg4JJdSsImjSy/siN+6EtIsJdR+yuYcXAi+X3
         IPiynHNv2JbUeYZs1TPRpS39c8KtFWo/Rx3nyBOx/cJMqhN7qk9VZNhS2EKYjsXGk4+o
         ExeY4tLlYL4ulNjzKW3B4jqIAGVt3fw9K1pB/zr5HbjfDi7vZK3rNZJuq/mbF8U8Mw6N
         0gDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4/eFw0vWwBVRaZ/3UIgJHxLSvTZ3eLOl09I88FAedw=;
        b=IfaH9vMbaGe8CTmPT96kRRGoaDzq6V5eSZDPnp1pO2GbhvDkqWdBOXrQ/8W9k/kNxj
         hEzJQALF7xRc0p8dJ341hdUgwsCTxMPMM8RgJuUzy7xDplmNUo63ovhuMIQPbxsvXqXm
         znlwKn1z+ydCMP6fr0kMqzJbUV9rDZi/VcHnLIJNEj54nNBr/3fn7wkzi3SxTpHzyjw+
         0q28NzF9eAalRjre8Aym3dfgZAQxId0+kuwgDIXUA/sf19MgdMZwO8xv/W1S4xI3lH7U
         YBCdG4OG7DUlnyEz7y0pu1sxbPTr0e1TjN56nXsJ4ZOFOKh/UuhYqdZJDJboyBR1naId
         XWaQ==
X-Gm-Message-State: AGi0PuaCUZ6lqZ8t4hV/tBmz5xE7pqR83pfPYNmQM1Gr/4oAQJjeBQcW
        /6KqdpK/O6DUIsYr7wkRlrw=
X-Google-Smtp-Source: APiQypKEbzHnKMzCKX/ncGYbZgq1pAvZNsSE1f4dlTDfmYezOsLJMtfjO4PiP2/R4GsGUKyg6wWRyw==
X-Received: by 2002:a62:6807:: with SMTP id d7mr33624182pfc.296.1588130840165;
        Tue, 28 Apr 2020 20:27:20 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:19 -0700 (PDT)
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
Subject: [PATCH v2 04/10] power: separate PageHighMem() and PageHighMemZone() use case
Date:   Wed, 29 Apr 2020 12:26:37 +0900
Message-Id: <1588130803-20527-5-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
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

Acked-by: Roman Gushchin <guro@fb.com>
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

