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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDE0C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3EEA21927
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QrYUGa62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726321AbgDTIAh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:36 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4A0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:35 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w11so4651663pga.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rG1v9CPi234T/7BGeZb8RVyl19HAO0cKxry9IQFPdUs=;
        b=QrYUGa62xNb+TlIH1Ydgi8sqW1zW5PgqK+OvOJOOgheXl7GlMmDZu+yfifjtb3p5GB
         l6lUv0b9WvzRpP+yRoXShKmYi28dTgVGJqPpFZt0RHoz73aUydDbpQKbaHNyBtUT9q3F
         4EdzwxI2K4oGwm/6xlBnnAoA9w8/w88awsCajgD8spSp2VWbU6A9tAWkOldCm2uwsexf
         HIdfeEhsTiUqKrWyPFPrtRoWILZIvMXnkblNVF8A9pQqqopN6FlnuKD70PeAp0Zgjxyo
         pDbrvqkATfb5NYUlmlX/6s/LwNJ8Y5xRt+3rbDOOqbB119QeGQSYzGnziYsSAtZHzrw/
         5bqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rG1v9CPi234T/7BGeZb8RVyl19HAO0cKxry9IQFPdUs=;
        b=tWZeS2J+36BDXjo0pORM1DD6R+Tb9vskq+HTSbiT1xTZhKE+eBw3DYsNob1GlCes0A
         7S1R5gGcJchD71J0cjq2MUnpsbD3mVh4dxBX7qnjtm5K9SyIZPYFKUomRxrBrZK6iKIW
         +zNuyvdQ0Fiy0jRK2jMJ+V2daIV5+ngPdQTLhQRCo1TvVYOMznz4V7qWxo04T6AR310t
         d/z9bwRJsAPqzmfJOeT4/DgVoGMVr+pxNcTV515cMVrBjdPeoHrrT092obJFRrvsNceM
         F3yF9VAoIYvMr8SUvFpTQ2osqZ+OyG1iyuRWsDz3pTxHvU6tqXZ0Qd0XjunNZuI7KkdQ
         mMig==
X-Gm-Message-State: AGi0PuaMSbzsEh2GVtfR03ZjhWuiTvY80ZcITTW0Xe99Bxsxz2l7fGBZ
        XU6HSdl1TEocaVhIIFjvtkg=
X-Google-Smtp-Source: APiQypJmXi5ZTKe55gow5hxUgM65UKdICyE/3G4E84lD7Zr+iICYmoTtvFX7x+3rJi28CWqIJeEoTw==
X-Received: by 2002:a63:3502:: with SMTP id c2mr4187544pga.276.1587369635436;
        Mon, 20 Apr 2020 01:00:35 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:00:35 -0700 (PDT)
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
Subject: [PATCH 02/10] drm/ttm: separate PageHighMem() and PageHighMemZone() use case
Date:   Mon, 20 Apr 2020 16:59:34 +0900
Message-Id: <1587369582-3882-3-git-send-email-iamjoonsoo.kim@lge.com>
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

I apply the rule #4 for this patch.

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

