Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EE6C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55B8E20BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 11:07:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730373AbgIJLHh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 07:07:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:41812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730478AbgIJLFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 07:05:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 67064AF2C;
        Thu, 10 Sep 2020 11:05:33 +0000 (UTC)
Subject: Re: [RFC 5/5] mm, page_alloc: disable pcplists during page isolation
To:     David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Oscar Salvador <osalvador@suse.de>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mel Gorman <mgorman@techsingularity.net>
References: <20200907163628.26495-1-vbabka@suse.cz>
 <20200907163628.26495-6-vbabka@suse.cz>
 <d5d5ef64-b239-0640-5640-75c7a3c78584@suse.cz>
 <20200909113647.GG7348@dhcp22.suse.cz>
 <b057e618-94f1-3f5a-a4f6-55fc93ac34eb@suse.cz>
 <5c5753b4-8cb9-fa02-a0fa-d5ca22731cbb@redhat.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <3d3b53db-aeaa-ff24-260b-36427fac9b1c@suse.cz>
Date:   Thu, 10 Sep 2020 13:05:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <5c5753b4-8cb9-fa02-a0fa-d5ca22731cbb@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/10/20 12:29 PM, David Hildenbrand wrote:
> On 09.09.20 13:55, Vlastimil Babka wrote:
>> On 9/9/20 1:36 PM, Michal Hocko wrote:
>>> On Wed 09-09-20 12:48:54, Vlastimil Babka wrote:
>>>> Here's a version that will apply on top of next-20200908. The first 4 patches need no change.
>>>> For callers that pair start_isolate_page_range() with
>>>> undo_isolated_page_range() properly, this is transparent. Currently that's
>>>> alloc_contig_range(). __offline_pages() doesn't call undo_isolated_page_range()
>>>> in the succes case, so it has to be carful to handle restoring pcp->high and batch
>>>> and unlocking pcp_batch_high_lock.
>>>
>>> I was hoping that it would be possible to have this completely hidden
>>> inside start_isolate_page_range code path.
>> 
>> I hoped so too, but we can't know the moment when all processes that were in the
>> critical part of freeing pages to pcplists have moved on (they might have been
>> rescheduled).
>> We could change free_unref_page() to disable IRQs sooner, before
>> free_unref_page_prepare(), or at least the get_pfnblock_migratetype() part. Then
>> after the single drain, we should be safe, AFAICS?
> 
> At least moving it before getting the migratetype should not be that severe?
> 
>> RT guys might not be happy though, but it's much simpler than this patch. I
>> still like some of the cleanups in 1-4 though tbh :)
> 
> It would certainly make this patch much simpler. Do you have a prototype
> lying around?

Below is the critical part, while writing it I realized that there's also
free_unref_page_list() where it's more ugly.

So free_unref_page() simply moves the "determine migratetype" part under
disabled interrupts. For free_unref_page_list() we optimistically determine them
without disabling interrupts, and with disabled interrupts we check if zone has
isolated pageblocks and thus we should not trust that value anymore. That's same
pattern as free_pcppages_bulk uses.

But unfortunately it means an extra page_zone() plus a test for each page on the
list :/

----8<----
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index defefed79cfb..57e2a341c95c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3103,18 +3103,21 @@ void mark_free_pages(struct zone *zone)
 }
 #endif /* CONFIG_PM */
 
-static bool free_unref_page_prepare(struct page *page, unsigned long pfn)
+static bool free_unref_page_prepare(struct page *page)
 {
-	int migratetype;
-
 	if (!free_pcp_prepare(page))
 		return false;
 
-	migratetype = get_pfnblock_migratetype(page, pfn);
-	set_pcppage_migratetype(page, migratetype);
 	return true;
 }
 
+static inline void free_unref_page_set_migratetype(struct page *page, unsigned long pfn)
+{
+	int migratetype	= get_pfnblock_migratetype(page, pfn);
+
+	set_pcppage_migratetype(page, migratetype);
+}
+
 static void free_unref_page_commit(struct page *page, unsigned long pfn)
 {
 	struct zone *zone = page_zone(page);
@@ -3156,10 +3159,17 @@ void free_unref_page(struct page *page)
 	unsigned long flags;
 	unsigned long pfn = page_to_pfn(page);
 
-	if (!free_unref_page_prepare(page, pfn))
+	if (!free_unref_page_prepare(page))
 		return;
 
+	/*
+	 * by disabling interrupts before reading pageblock's migratetype,
+	 * we can guarantee that after changing a pageblock to MIGRATE_ISOLATE
+	 * and drain_all_pages(), there's nobody who would read the old
+	 * migratetype and put a page from isoalted pageblock to pcplists
+	 */
 	local_irq_save(flags);
+	free_unref_page_set_migratetype(page, pfn);
 	free_unref_page_commit(page, pfn);
 	local_irq_restore(flags);
 }
@@ -3176,9 +3186,10 @@ void free_unref_page_list(struct list_head *list)
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
 		pfn = page_to_pfn(page);
-		if (!free_unref_page_prepare(page, pfn))
+		if (!free_unref_page_prepare(page))
 			list_del(&page->lru);
 		set_page_private(page, pfn);
+		free_unref_page_set_migratetype(page, pfn);
 	}
 
 	local_irq_save(flags);
@@ -3187,6 +3198,8 @@ void free_unref_page_list(struct list_head *list)
 
 		set_page_private(page, 0);
 		trace_mm_page_free_batched(page);
+		if (has_isolate_pageblock(page_zone(page)))
+			free_unref_page_set_migratetype(page, pfn);
 		free_unref_page_commit(page, pfn);
 
 		/*


