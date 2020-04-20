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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59EF7C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370C8206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dluh6E6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgDTIBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:01:02 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57DAC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:01:01 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t40so4082543pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=alIHvAxi8J0gI0njDpPhNJX2AYMkhsIun+mstYhBeyw=;
        b=Dluh6E6WcvI4lCJpWZru0HsbFamltg/pDLxUXPDdcyd7U73u2Tjuy76v2EqKxIPN1D
         8HfOy0yDAfSEDDCFo8/d107vtsHmZaPhqvlyuQC6EY7L6XeoHELvFxBJ+av+24J71Huc
         GAFwaB5ev5fbbKZzTocmnb1TzfiI2wBFoh6YUP/5jZgdyE9z6PTenV2AJH3xF+wZOBvw
         5+ToqCayK/FEfBPb92ENTgpdeHppCkVkswO803xRpv1Re7dpzo0T90E8rDMsjFk0qdzs
         5SUonL8Eo+6uRoQ26ijPU006Jhx7mPwwucsRAyrOe4E8tRVDb8AuMFIVbT9R8yLx9fqx
         GI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=alIHvAxi8J0gI0njDpPhNJX2AYMkhsIun+mstYhBeyw=;
        b=VQImDFxFiLWF+a3yu2Gfq5rbG4+yQI0o3Eydunbr7xYGupvpwroNVffpoRMC2EhbK4
         cgWF+5iqLjTieM2zRgH08n6ttf/TPvKjPZQrcMXsvDBFbNOi9PIZmHU2jZFFOYzmQvtP
         aENGYfyUkd+TPLR0uFeGovmOmi2ox0ErVqJOTolMrFvzlrfGhJDnmWVMH+24G5vUE//R
         beLZrxA016B0HGbDGpkv8RTqlH4AizH2xIXV0NCk9wyDfuoNF6sD+n5Qc7o5gLenukm0
         Vp2iPVWH2uUFUGgl3gNLdsRZTR8YOZiA44ANUk/51yHlyL5tYsSbGbZcRIXmR0pC69rS
         wFkw==
X-Gm-Message-State: AGi0PuZ5GeBttRBE/nBWw32mdPa0uk3WbGrNBK1SeM4EthHJaplp50VG
        hT4MVDbXZAXky8z9y3lEgWk=
X-Google-Smtp-Source: APiQypJDuKPiCH8RK1OqawZFGOeQwm51EdRyDy79rVDacXxLqIv3PWmH4AI8ZUJeDdV3IBbkNclw8Q==
X-Received: by 2002:a17:902:968a:: with SMTP id n10mr15110926plp.74.1587369661464;
        Mon, 20 Apr 2020 01:01:01 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:01:01 -0700 (PDT)
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
Subject: [PATCH 08/10] mm: separate PageHighMem() and PageHighMemZone() use case
Date:   Mon, 20 Apr 2020 16:59:40 +0900
Message-Id: <1587369582-3882-9-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/memory_hotplug.c | 2 +-
 mm/page_alloc.c     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 8573d2fc..85361e2 100644
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
index d469384..9997f87 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7470,7 +7470,7 @@ void adjust_managed_page_count(struct page *page, long count)
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

