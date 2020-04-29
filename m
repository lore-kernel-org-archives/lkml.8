Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF6EC83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A76B72082E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 03:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YHm1orTY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgD2D1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 23:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726508AbgD2D1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 23:27:30 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D86C03C1AC
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:30 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id h12so1842265pjz.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 20:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBEYuUoQ8e6Da7eJez+k7YxQ5sLYFa5M+7QyRrMMcew=;
        b=YHm1orTYXSGPPZ6rqzsy/Z/aCobIKLDOgp51Ebnl4u0atgV1seGtUvn3mvdSefeL0Z
         vrTYiCYMoXXmkOAiEyE6Ry3VQW9HjOiFO54tdgL6mm/rhzb/67x4Kl2dym1y448PxHVf
         sIETeXeYrRQBYv3OAE+ieKZCXJrSm6TzbJWwOhrxaAmJzPor4gWC4kqExLtmgAbxrqxk
         n9G4MjSlV/+pnc8q39kVqp5qs6wAMCro8PwBaP8WKYjjvElE8LsGatoLohA/hXjEjnQJ
         arahQkyJ1rTe4qhEcx2D1A837Qa/Zx+jZlOg4hDscCjyMeHzeoup+J7fUdIzZSXU0oIn
         Ne7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBEYuUoQ8e6Da7eJez+k7YxQ5sLYFa5M+7QyRrMMcew=;
        b=rRj+TYUaNgQynAwVqZjj4dHmicPvz3Cm9FBTXhoCH5h8b9c+8rCxdK5oUn2GgoUpby
         9ZWUWKxl9p6Haya2ut/zDKcRHS2TFhmATjkkifhVIlHpZh4ZgyPLzl+cqjHgCjWp0+Bn
         mcNhzauI5vv2swD9s6V5kqJ4Tq36xcJ8JYI32uArFyEQzyCzRCQI8oRUDaEveKfmei8Q
         dRHnMzjM2pOvHQqTt8CzGHb7rdhiXIhdoYaui2a3Zjrw5c1l104YoeymtTdOYXw3gN34
         BNMG7BvtOF1HIg1VacdN691rp89zAMsU2o3oK57STas4RjtzUYG/LBME2IxcWCv4h7TT
         gmiw==
X-Gm-Message-State: AGi0PuYOH4Uk9VU+V9KZLUKerjd8+TFjpf7tuh3L72sbQqhRFMCtJUGC
        azBfItakPh3s01CWYRIhuIE=
X-Google-Smtp-Source: APiQypIMe4cvTWcJXIHZJ0unZHCNL7cX9pPrPhdcmwMdDewi2uTows2IMF6+5o/DmWzKsJrROyXIkw==
X-Received: by 2002:a17:90b:93:: with SMTP id bb19mr736039pjb.134.1588130850170;
        Tue, 28 Apr 2020 20:27:30 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id q11sm9559796pfl.97.2020.04.28.20.27.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 20:27:29 -0700 (PDT)
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
Subject: [PATCH v2 06/10] mm/hugetlb: separate PageHighMem() and PageHighMemZone() use case
Date:   Wed, 29 Apr 2020 12:26:39 +0900
Message-Id: <1588130803-20527-7-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 5548e88..56c9143 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2639,7 +2639,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 		list_for_each_entry_safe(page, next, freel, lru) {
 			if (count >= h->nr_huge_pages)
 				return;
-			if (PageHighMem(page))
+			if (PageHighMemZone(page))
 				continue;
 			list_del(&page->lru);
 			update_and_free_page(h, page);
-- 
2.7.4

