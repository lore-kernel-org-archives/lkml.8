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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA94C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A6E221D82
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeQZY3U0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgDTIA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgDTIA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:00:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E43C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id t11so4672790pgg.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DSi8Zl5E6C8oRk/MAFIcBEqbn7/mn9+/YHmxcRg+idk=;
        b=EeQZY3U0r7N00A0ghNyd570WI+TMBfPMdHycrThvyRNwh3vChP+6pqA3n24qK3lh3w
         t73jEmbdP2+91Z0OxU2PicyVGliRIpZD/m3LR8xBXhwZ7iSvkWZ2jZtcuaJ8ydErrdJS
         CmEtbz/QIUQyw9hrWt1CA3HsykMrOaiEemg4GiN39cEeSkoUyk/V7YtJGBmtuRFU8X/8
         HOLo3OsRN3sYiEUVt/bP3C5MjKd6HaRHVoXiTezDc/Bcgv7YK7kyvyZr+wcT1TW5kFeF
         EAYXLagqjtp5JMr+3hXW35Id2Pv9/q8Yt0HVIOt4aJJdw/vYNX5nivacF/cXhQf0oI84
         EPJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DSi8Zl5E6C8oRk/MAFIcBEqbn7/mn9+/YHmxcRg+idk=;
        b=DINJ0hZJngXvJeIRcE7ppKUwd2zWWpUWka7vc0+Q5c9Gl3EpchgeHBbnAuX1pJT5Pe
         usyenWcJV0sgsH4Aa9/L0YxDgANmww/lTe0ehb850sqA3/pJaNwz+e8FmiV4ArHy1sMl
         Dl8GD0Qt+6sGYazZguuKHOWhUl6vvFywUQlC462XHFMvoFnVY7RYpeWeayN8DB+o/nqp
         1cUmIcb/y7L8f5tyz45M/cNqQNsq48YIBFUGTWTQEHfk0djOrWMyNYAgCZrUx+RxYYna
         9oXA9Pzx8Egj7C3bittF6RAP2bOvhkykYDXfOqqalL8yukvEhVYrBXIgMQa2jH34LrCD
         0MRg==
X-Gm-Message-State: AGi0PubNm5LhGvjGF4o1r5fm5g0RZTI9X6nETyrbkbhCCoFHJWyA3sum
        DjtFZ2evApzCi3vxWZF8ZTs=
X-Google-Smtp-Source: APiQypK7x7myCxQF8VKSUMw/wmdQndZa+A20INmkZwCxUQsaroAlqyLxW9nRCC2v0z5QL7W3rDFKXw==
X-Received: by 2002:a62:d086:: with SMTP id p128mr16441164pfg.241.1587369657192;
        Mon, 20 Apr 2020 01:00:57 -0700 (PDT)
Received: from localhost.localdomain ([114.206.198.176])
        by smtp.gmail.com with ESMTPSA id n9sm314947pjt.29.2020.04.20.01.00.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 01:00:56 -0700 (PDT)
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
Subject: [PATCH 07/10] mm/hugetlb: separate PageHighMem() and PageHighMemZone() use case
Date:   Mon, 20 Apr 2020 16:59:39 +0900
Message-Id: <1587369582-3882-8-git-send-email-iamjoonsoo.kim@lge.com>
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
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1c50d23..fc3a701 100644
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

