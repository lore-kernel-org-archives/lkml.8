Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64965C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3778520706
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 09:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729555AbgHYJno (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 05:43:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:45586 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728059AbgHYJno (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 05:43:44 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 92048AF33;
        Tue, 25 Aug 2020 09:44:12 +0000 (UTC)
Subject: Re: [PATCH for v5.9] mm/page_alloc: handle a missing case for
 memalloc_nocma_{save/restore} APIs
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        kernel-team@lge.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <e83100ae-d687-3b4e-8256-aee242191ada@suse.cz>
Date:   Tue, 25 Aug 2020 11:43:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1598331582-19923-1-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/25/20 6:59 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> memalloc_nocma_{save/restore} APIs can be used to skip page allocation
> on CMA area, but, there is a missing case and the page on CMA area could
> be allocated even if APIs are used. This patch handles this case to fix
> the potential issue.
> 
> Missing case is an allocation from the pcplist. MIGRATE_MOVABLE pcplist
> could have the pages on CMA area so we need to skip it if ALLOC_CMA isn't
> specified.
> 
> This patch implements this behaviour by checking allocated page from
> the pcplist rather than skipping an allocation from the pcplist entirely.
> Skipping the pcplist entirely would result in a mismatch between watermark
> check and actual page allocation.

Are you sure? I think a mismatch exists already. Pages can be on the pcplist but
they are not considered as free in the watermark check. So passing watermark
check means there should be also pages on free lists. So skipping pcplists would
be safe, no?

> And, it requires to break current code
> layering that order-0 page is always handled by the pcplist. I'd prefer
> to avoid it so this patch uses different way to skip CMA page allocation
> from the pcplist.

Well it would be much simpler and won't affect most of allocations. Better than
flushing pcplists IMHO.

Something like this?
----8<----
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0e2bab486fea..15787ffb1708 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3361,7 +3361,10 @@ struct page *rmqueue(struct zone *preferred_zone,
        unsigned long flags;
        struct page *page;
 
-       if (likely(order == 0)) {
+       if (likely(order == 0) &&
+                       (!IS_ENABLED(CONFIG_CMA) ||
+                        migratetype != MIGRATE_MOVABLE ||
+                        alloc_flags & ALLOC_CMA)) {
                page = rmqueue_pcplist(preferred_zone, zone, gfp_flags,
                                        migratetype, alloc_flags);
                goto out;
