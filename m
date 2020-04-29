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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F7C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C5152083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vDtUirzm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726688AbgD2D1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgD2D1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:11 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F15A2C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:10 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fu13so204927pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vjSLLHLjivpaTsGjt9wZU4uxvIUbIBAxgk3j0tUoRA0=;
        b=vDtUirzmzFpjI5hjGRWWmC1lfK3OGlUTM6iParKSOaxrcTMN6d9IdOn8MJuEkZLKhc
         2OQ2fIlvuSFQJ+gQsfLYr1Z6ELxfy6ADQHJ7f02esZQXiEf4TAbL5HCZzppCsgoAkhwi
         BxWmWzbcD7JaBEq0/aimzA4gpSl/Gn/EYXPYeF207HOqZeW49J7zvLIeigZP34VJbdlR
         ZioWLqysSBIozk4h7dIfliiB3ST9m3h3NGYIrjMYKysZRkOESwZSOhyQPmOTA30EE+b9
         tjXoPu4j/p3LURZVzMg55f6+SB2+kAg1fc+UEUo2htrN7Zbv29jmVWyLpXVNS2hAA8h8
         WjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vjSLLHLjivpaTsGjt9wZU4uxvIUbIBAxgk3j0tUoRA0=;
        b=VQqBxk/tyZ5zW+RuGDlsoHkJatvYHqK2IxouPPsgvTRWh3P7G0DF+FnfPND58sf7xi
         +GAF8nVcn8kn/Bvsku/Zy4rhs4cuXDPQaNWabDY/QCY5v9LdgR40bYo9InB0i5yVo+mz
         kAptrAXyeQPK15of6tWIXlD+ODHfNJFyxlCgxgiNfXk2A3Lf68G5K7R86HK+xfKPlsru
         jh6SJuIR68Dj2BZblZDVRQ0uBVf0Dn8LloPYnZTO/E0HAEKf/0v4z0jiX3xNPabVPPEp
         B/nBVS1RlEK1NTCK+6gUi6NNnDGOdoMRxCKota2mNCwVYYr2TpXX4y2LYHoR/MEkVdj9
         QyLg==
X-Gm-Message-State: AGi0PuYQbdWnSI/qqWpe8fpeLflOISqf2R//LGliPGWMdbp+8iRYl23I
        BaKxjPts0J/bDIGqTFsuyro=
X-Google-Smtp-Source: APiQypLYh8NdrZBbpGtSDmCzWjniW2sHQJcbgaiMBawm9jRVW3CaZraKl4M5I3z7H2gU67+DMSliiA==
X-Received: by 2002:a17:90a:d984:: with SMTP id d4mr678963pjv.59.1588130830450;
        Tue, 28 Apr 2020 20:27:10 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:09 -0700 (PDT)
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
Subject: [PATCH v2 02/10] drm/ttm: separate PageHighMem() and PageHighMemZone() use case
Date:   Wed, 29 Apr 2020 12:26:35 +0900
Message-Id: <1588130803-20527-3-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1588130803-20527-1-git-send-email-iamjoonsoo.kim@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

I apply the rule #4 for this patch.

Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 drivers/gpu/drm/ttm/ttm_memory.c         | 4 ++--
 drivers/gpu/drm/ttm/ttm_page_alloc.c     | 2 +-
 drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 2 +-
 drivers/gpu/drm/ttm/ttm_tt.c             | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
index acd63b7..d071b71 100644
--- a/drivers/gpu/drm/ttm/ttm_memory.c
+++ b/drivers/gpu/drm/ttm/ttm_memory.c
@@ -641,7 +641,7 @@ int ttm_mem_global_alloc_page(struct ttm_mem_global *glob,
 	 */
 
 #ifdef CONFIG_HIGHMEM
-	if (PageHighMem(page) && glob->zone_highmem != NULL)
+	if (PageHighMemZone(page) && glob->zone_highmem != NULL)
 		zone = glob->zone_highmem;
 #else
 	if (glob->zone_dma32 && page_to_pfn(page) > 0x00100000UL)
@@ -656,7 +656,7 @@ void ttm_mem_global_free_page(struct ttm_mem_global *glob, struct page *page,
 	struct ttm_mem_zone *zone = NULL;
 
 #ifdef CONFIG_HIGHMEM
-	if (PageHighMem(page) && glob->zone_highmem != NULL)
+	if (PageHighMemZone(page) && glob->zone_highmem != NULL)
 		zone = glob->zone_highmem;
 #else
 	if (glob->zone_dma32 && page_to_pfn(page) > 0x00100000UL)
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
index b40a467..847fabe 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
@@ -530,7 +530,7 @@ static int ttm_alloc_new_pages(struct list_head *pages, gfp_t gfp_flags,
 		/* gfp flags of highmem page should never be dma32 so we
 		 * we should be fine in such case
 		 */
-		if (PageHighMem(p))
+		if (PageHighMemZone(p))
 			continue;
 
 #endif
diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
index faefaae..338b2a2 100644
--- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
+++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
@@ -747,7 +747,7 @@ static int ttm_dma_pool_alloc_new_pages(struct dma_pool *pool,
 		/* gfp flags of highmem page should never be dma32 so we
 		 * we should be fine in such case
 		 */
-		if (PageHighMem(p))
+		if (PageHighMemZone(p))
 			continue;
 #endif
 
diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
index 2ec448e..6e094dd 100644
--- a/drivers/gpu/drm/ttm/ttm_tt.c
+++ b/drivers/gpu/drm/ttm/ttm_tt.c
@@ -119,7 +119,7 @@ static int ttm_tt_set_page_caching(struct page *p,
 {
 	int ret = 0;
 
-	if (PageHighMem(p))
+	if (PageHighMemZone(p))
 		return 0;
 
 	if (c_old != tt_cached) {
-- 
2.7.4

