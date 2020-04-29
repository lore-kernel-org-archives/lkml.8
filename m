Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBF4C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394442083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dHGQTgST"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD2D1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgD2D1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:35 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F37DC03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:35 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so429246pfx.6
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JcqYhJSvA4X5ViJ5goqbeTTWp8Y5g5DbmVru2JNvJmM=;
        b=dHGQTgST4T/TIqKzXeO1Lte1bWF1Sn8daJICVO/jnep/VSjF93foldTAiudSwZd4M4
         DsevD5RNclIkEf8EaePx82k+CvnKdkwXbmro/CUQyPcGq/mc3Wp0BN7gWGpgFEAP3IQP
         l+LEP7P0xuKWDNSW5UcGWFnxK/GxZ7cYrtp4gFOeEicD7Q2W72WSJIELL0WC6wcMaOub
         dOTkdrNdbRsrqXgRitrmKzgdF3oCZobjw1Pe1HpHjAFUHKq6MBTUQipMTLAA+4gFhUPq
         5ItG7NGS1KeceRJV6kEml4XfHRazM3PnRMTnzDd3fP7UX3r3Y3ejZtTmbW3a+oa61aDa
         L0Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JcqYhJSvA4X5ViJ5goqbeTTWp8Y5g5DbmVru2JNvJmM=;
        b=PH97h403dFie2iESBF2bqtRi0A3SLQPnuS2dsTA3tA4qBnm4f4Fler+Aie65/S3uJv
         LRW8RXnWALrthQXPkzoN6Yd+OT1SxRnoPX/QdM5PTY0n/eU5b0TfRz34TZRdxUL4X/3R
         QL066h0jaYxZxOopksTYDIuBrShK1zEHslR1MX94cQz45jplXbDAFm+tmHykTKvAOTkD
         PtIclmrlwyaII4qUgWmyUrSdO5gH9aN7aWkN/N04LpJDaXVsmAP3t33up3q3IN0fs41I
         kdS73nXQm97FcaDg9BBa/2ute49ktdhx1LvsP6KD03deLd1uEpLEWZm/TeGhI3emG0SN
         Ffeg==
X-Gm-Message-State: AGi0PuZdSczpOsQ9OzH+32ZEZ6YFmIB1yN2xZ+LHZbJLzV0kOugBaEgd
        evU9X1S51ZO/5W8vJy4+XRQ=
X-Google-Smtp-Source: APiQypJvFpozove4ZkEvpi5UVfGHd8oJpvNm4lin405Dltd2Ts33exbfBSDpzHd66pfNS2AIZ90rDA==
X-Received: by 2002:a65:5947:: with SMTP id g7mr31093218pgu.258.1588130854997;
        Tue, 28 Apr 2020 20:27:34 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:34 -0700 (PDT)
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
Subject: [PATCH v2 07/10] mm: separate PageHighMem() and PageHighMemZone() use case
Date:   Wed, 29 Apr 2020 12:26:40 +0900
Message-Id: <1588130803-20527-8-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 555137b..891c214 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -593,7 +593,7 @@ void generic_online_page(struct page *page, unsigned int order)
 	__free_pages_core(page, order);
 	totalram_pages_add(1UL << order);
 #ifdef CONFIG_HIGHMEM
-	if (PageHighMem(page))
+	if (PageHighMemZone(page))
 		totalhigh_pages_add(1UL << order);
 #endif
 }
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index fc5919e..7fe5115 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7444,7 +7444,7 @@ void adjust_managed_page_count(struct page *page, long count)
 	atomic_long_add(count, &page_zone(page)->managed_pages);
 	totalram_pages_add(count);
 #ifdef CONFIG_HIGHMEM
-	if (PageHighMem(page))
+	if (PageHighMemZone(page))
 		totalhigh_pages_add(count);
 #endif
 }
-- 
2.7.4

