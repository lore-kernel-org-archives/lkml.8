Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97923C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:44:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC3320771
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:44:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMLng (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:43:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:42854 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726106AbgHMLlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:41:12 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2ED8EB750;
        Thu, 13 Aug 2020 11:41:33 +0000 (UTC)
Date:   Thu, 13 Aug 2020 13:41:05 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Charan Teja Reddy <charante@codeaurora.org>
Cc:     akpm@linux-foundation.org, vbabka@suse.cz, david@redhat.com,
        rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, vinmenon@codeaurora.org
Subject: Re: [PATCH V2] mm, page_alloc: fix core hung in free_pcppages_bulk()
Message-ID: <20200813114105.GI9477@dhcp22.suse.cz>
References: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597150703-19003-1-git-send-email-charante@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 11-08-20 18:28:23, Charan Teja Reddy wrote:
[...]
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e4896e6..839039f 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1304,6 +1304,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	struct page *page, *tmp;
>  	LIST_HEAD(head);
>  
> +	/*
> +	 * Ensure proper count is passed which otherwise would stuck in the
> +	 * below while (list_empty(list)) loop.
> +	 */
> +	count = min(pcp->count, count);
>  	while (count) {
>  		struct list_head *list;


How does this prevent the race actually? Don't we need something like
the following instead?
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e028b87ce294..45bcc7ba37c4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1317,9 +1317,16 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		 * lists
 		 */
 		do {
+			bool looped = false;
+
 			batch_free++;
-			if (++migratetype == MIGRATE_PCPTYPES)
+			if (++migratetype == MIGRATE_PCPTYPES) {
+				if (looped)
+					goto free;
+
 				migratetype = 0;
+				looped = true;
+			}
 			list = &pcp->lists[migratetype];
 		} while (list_empty(list));
 
@@ -1352,6 +1359,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
 		} while (--count && --batch_free && !list_empty(list));
 	}
 
+free:
 	spin_lock(&zone->lock);
 	isolated_pageblocks = has_isolate_pageblock(zone);
 
-- 
Michal Hocko
SUSE Labs
