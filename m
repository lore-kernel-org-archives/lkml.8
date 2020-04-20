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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F9FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BA5A21D82
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItF3/sZ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgDTIAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:31 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B088FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:31 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y22so3665033pll.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MEpV3hn90v/RuIN3YFDQo8euDWQ92aPlcVxL9l6luZc=;
        b=ItF3/sZ2EanrjBm2LMdHTVjFNOiCabn95CkywyoZB1iGsyLxMr6ftCI02m1MHLUjRs
         iC6a2bcD4Ik5496j6dODC1mg2gZICwfcWKbw6i49RgeJr3YcxIuxNDN9s7mbW3evoi7h
         WpsP/IhNbXg16uGjeoe5AQ8YbYSBKK5XDUhysWkIyso1o/+02mcrpiNJhd/6Nk8ztTPN
         xdYBJ866yeVULptcz9G340mEVWY1veIegHlirZ93tmTL8OQ3Eo2dgXhviySnyEBgdCms
         Zm1xicNj/yls67BHQA5vUiv/1ICX2/VRKDmDAQkrGvUZDsjVZhuEAMaVAsSptDHri8jX
         Ahtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MEpV3hn90v/RuIN3YFDQo8euDWQ92aPlcVxL9l6luZc=;
        b=qc3pAr0gyNoVbtUEiVjhVvFtYqXsVmcDUm60Amofn8RvY0mZ2aFI9W6VQww4IlcjHO
         98VW5L9ci/22U0HkDmdvr8jWkix5AzoGGQQCAyhEeGNJGtZOYDVkBKDkrk78zle/L/Wi
         J6pKogZ4RFN1Y7ndzgpof5j4V10BnpwQ5U0IiaYKKCj8vZRgiaZyU4UHHmOatJqjViVr
         DZjjVg3Upvqu0uPZs31E+rQ/Fuyvxyyg+VnmLAQZXVTCyxlc7yegFV4URH6Kj9tD3dJ/
         fpxuGQmLxtYr9tWRZrcoA155dZhEhHitbdzPrqrw8rRyyMUBv9wTqDUbv8QJFIWqgDmH
         jmGg==
X-Gm-Message-State: AGi0Puay75RhHm1sgf4DPEvCWi5wi2X0fpx+3tnxNWynpXxqYVh1IzwN
        23J8xQwqU/tO0gLiJtLh+ak=
X-Google-Smtp-Source: APiQypJ10m9X17krhcOmsvvWDdha3Dzj1oYJrOonjT+ccTdwvNcOZ4dsSCJ9x94KBHdghrpRy0MyQw==
X-Received: by 2002:a17:90a:1910:: with SMTP id 16mr20345971pjg.119.1587369631174;
        Mon, 20 Apr 2020 01:00:31 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:00:30 -0700 (PDT)
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
Subject: [PATCH 01/10] mm/page-flags: introduce PageHighMemZone()
Date:   Mon, 20 Apr 2020 16:59:33 +0900
Message-Id: <1587369582-3882-2-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joonsoo Kim <iamjoonsoo.kim@lge.com>

PageHighMem() is used for two different cases. One is to check if there
is a direct mapping for this page or not. The other is to check the
zone of this page, that is, weather it is the highmem type zone or not.

Until now, both the cases are the perfectly same thing. So, implementation
of the PageHighMem() uses the one case that checks if the zone of the page
is the highmem type zone or not.

"#define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))"

ZONE_MOVABLE is special. It is considered as normal type zone on
!CONFIG_HIGHMEM, but, it is considered as highmem type zone
on CONFIG_HIGHMEM. Let's focus on later case. In later case, all pages
on the ZONE_MOVABLE has no direct mapping until now.

However, following patchset
"mm/cma: manage the memory of the CMA area by using the ZONE_MOVABLE"
, which is once merged and reverted, will be tried again and will break
this assumption that all pages on the ZONE_MOVABLE has no direct mapping.
Hence, the ZONE_MOVABLE which is considered as highmem type zone could
have the both types of pages, direct mapped and not. Since
the ZONE_MOVABLE could have both type of pages, __GFP_HIGHMEM is still
required to allocate the memory from it. And, we conservatively need to
consider the ZONE_MOVABLE as highmem type zone.

Even in this situation, PageHighMem() for the pages on the ZONE_MOVABLE
when it is called for checking the direct mapping should return correct
result. Current implementation of PageHighMem() just returns TRUE
if the zone of the page is on a highmem type zone. So, it could be wrong
if the page on the MOVABLE_ZONE is actually direct mapped.

To solve this potential problem, this patch introduces a new
PageHighMemZone() macro. In following patches, two use cases of
PageHighMem() are separated by calling proper macro, PageHighMem() and
PageHighMemZone(). Then, implementation of PageHighMem() will be changed
as just checking if the direct mapping exists or not, regardless of
the zone of the page.

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

My final plan is to change the name, PageHighMem() to PageNoDirectMapped()
or something else in order to represent proper meaning.

Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
---
 include/linux/page-flags.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 222f6f7..fca0cce 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -378,10 +378,16 @@ PAGEFLAG(Readahead, reclaim, PF_NO_COMPOUND)
 /*
  * Must use a macro here due to header dependency issues. page_zone() is not
  * available at this point.
+ * PageHighMem() is for checking if the direct mapping exists or not.
+ * PageHighMemZone() is for checking the zone, where the page is belong to,
+ * in order to predict previous gfp_flags or to count something for system
+ * memory management.
  */
 #define PageHighMem(__p) is_highmem_idx(page_zonenum(__p))
+#define PageHighMemZone(__p) is_highmem_idx(page_zonenum(__p))
 #else
 PAGEFLAG_FALSE(HighMem)
+PAGEFLAG_FALSE(HighMemZone)
 #endif
 
 #ifdef CONFIG_SWAP
-- 
2.7.4

