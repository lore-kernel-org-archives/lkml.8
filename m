Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCFA1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DF192075B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 00:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PVyawGFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729472AbgGHABq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 20:01:46 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:19311 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728208AbgGHABq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 20:01:46 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f050c7f0000>; Tue, 07 Jul 2020 16:59:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 07 Jul 2020 17:01:45 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 07 Jul 2020 17:01:45 -0700
Received: from [10.2.50.36] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 8 Jul
 2020 00:01:44 +0000
Subject: Re: [PATCH V3] mm/vmstat: Add events for THP migration without split
To:     Anshuman Khandual <anshuman.khandual@arm.com>, <linux-mm@kvack.org>
CC:     Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>, Zi Yan <ziy@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
References: <1594080415-27924-1-git-send-email-anshuman.khandual@arm.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <18a3af27-7cab-63d3-29b8-e253021622cc@nvidia.com>
Date:   Tue, 7 Jul 2020 17:01:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594080415-27924-1-git-send-email-anshuman.khandual@arm.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594166399; bh=8UZVSuAcDMvdJUxFqpn5a0BlZLoFzD8SRta3yI2/NXc=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=PVyawGFgMipHA4LC09pqHHxX2WQJa4L+ZkCyqj/az6aQ7zJqFhCw3ZPiilOG/8iPb
         Mi3Ir54/hjXfnmzYSHNIDjM88WTE4muU27cfDeBBthLOBFJGmXraFE8c5DyaAshF/3
         jphEcl7e0qLhf3oNb6smKSY4uUxm22k1GT7+MhZ0A4fDao/W2Tl+7pYbeUlTcy1cio
         IdgZ2laWLlOgKOkKI3Dt4wYl+Yr2P23J/5L6s2hZSyA4PH8mE0q5XbfglrhbFF13Mb
         dvrOdKEiLr81rfWl7NLX1JKolKqR6w3vz2XdKRcVAneowJ0KASm3JFNs0Ychrkx6h3
         Fy+Y31lsHPWYw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-06 17:06, Anshuman Khandual wrote:
> Add following new vmstat events which will help in validating THP migration
> without split. Statistics reported through these new VM events will help in
> performance debugging.
> 
> 1. THP_MIGRATION_SUCCESS
> 2. THP_MIGRATION_FAILURE
> 3. THP_MIGRATION_SPLIT
> 
> In addition, these new events also update normal page migration statistics
> appropriately via PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE. While here, this
> updates current trace event 'mm_migrate_pages' to accommodate now available
> THP statistics.
> 
> Cc: Daniel Jordan <daniel.m.jordan@oracle.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: John Hubbard <jhubbard@nvidia.com>
> Cc: Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>


This is missing the Documentation/ Cc's, did you run scripts/get_maintainer.pl? I'm
adding linux-doc and Jonathan Corbet, for now at least. And I'll refrain from
trimming the reply.


> ---
> Changes in V3:
> 
> - Formatted new events documentation with 'fmt' tool per Matthew
> - Made events universally available i.e dropped ARCH_ENABLE_THP_MIGRATION
> - Added THP_MIGRATION_SPLIT
> - Updated trace_mm_migrate_pages() with THP events
> - Made THP events update normal page migration events as well
> 
> Changes in V2: (https://patchwork.kernel.org/patch/11586893/)
> 
> - Dropped PMD reference both from code and commit message per Matthew
> - Added documentation and updated the commit message per Daniel
> 
> Changes in V1: (https://patchwork.kernel.org/patch/11564497/)
> 
> - Changed function name as thp_pmd_migration_success() per John
> - Folded in a fix (https://patchwork.kernel.org/patch/11563009/) from Hugh
> 
> Changes in RFC V2: (https://patchwork.kernel.org/patch/11554861/)
> 
> - Decopupled and renamed VM events from their implementation per Zi and John
> - Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure and split
> 
> Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)
> 
>   Documentation/vm/page_migration.rst | 19 +++++++++++
>   include/linux/vm_event_item.h       |  3 ++
>   include/trace/events/migrate.h      | 17 ++++++++--
>   mm/migrate.c                        | 49 ++++++++++++++++++++++++++---
>   mm/vmstat.c                         |  3 ++
>   5 files changed, 84 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
> index 1d6cd7db4e43..e65d49f3cf86 100644
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -253,5 +253,24 @@ which are function pointers of struct address_space_operations.
>        PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
>        for own purpose.
>   
> +Quantifying Migration
> +=====================
> +Following events can be used to quantify page migration.
> +
> +1. PGMIGRATE_SUCCESS       /* Normal page migration success */


This doesn't explain what's going on with the new combined counter
behavior. See the proposal below.


> +2. PGMIGRATE_FAIL          /* Normal page migration failure */
> +3. THP_MIGRATION_SUCCESS   /* Transparent huge page migration success */
> +4. THP_MIGRATION_FAILURE   /* Transparent huge page migration failure */


Shouldn't that be THP_MIGRATION_FAIL, in order to match the existing naming
scheme here?


> +5. THP_MIGRATION_SPLIT     /* Transparent huge page got split, retried */
> +
> +THP_MIGRATION_SUCCESS is when THP is migrated successfully without getting
> +split into it's subpages. THP_MIGRATION_FAILURE is when THP could neither
> +be migrated nor be split. THP_MIGRATION_SPLIT is when THP could not
> +just be migrated as is but instead get split into it's subpages and later
> +retried as normal pages. THP events would also update normal page migration
> +statistics PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE. These events will help
> +in quantifying and analyzing various THP migration events including both
> +success and failure cases.
> +


I would like to propose the following instead of the above. It's rewritten
so as to add explanations for the new behavior, remove the redundancy (the last
sentence in particular is a justification, and belongs in a commit log if anywhere,
not in the doc itself), fix a few typos, use the full 80 columns, and clarify a
bit as well. It uses the new THP_MIGRATION_FAIL name:


Monitoring Migration
=====================

The following events (counters) can be used to monitor page migration.

1. PGMIGRATE_SUCCESS: Normal page migration success. Each count means that a
    page was migrated. If the page was a non-THP page, then this counter is
    increased by one. If the page was a THP, then this counter is increased by
    the number of THP subpages. For example, migration of a single 2MB THP that
    has 4KB-size base pages (subpages) will cause this counter to increase by
    512.

2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as for
    _SUCCESS, above: this will be increased by the number of subpages, if it was
    a THP.

3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.

4. THP_MIGRATION_FAIL: A THP could not be migrated at all, even after being
    split.

5. THP_MIGRATION_SPLIT: A THP was migrated, but not as such: first, the THP had
    to be split. After splitting, a migration retry was used for the sub-pages,
    and that retry succeeded.

THP_MIGRATION_* events also update the appropriate PGMIGRATE_SUCCESS or
PGMIGRATE_FAILURE events. For example, a THP migration failure will cause both
THP_MIGRATION_FAIL and PGMIGRATE_FAIL to increase.


>   Christoph Lameter, May 8, 2006.
>   Minchan Kim, Mar 28, 2016.
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 24fc7c3ae7d6..5e7ffa025589 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -95,6 +95,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>   		THP_ZERO_PAGE_ALLOC_FAILED,
>   		THP_SWPOUT,
>   		THP_SWPOUT_FALLBACK,
> +		THP_MIGRATION_SUCCESS,
> +		THP_MIGRATION_FAILURE,
> +		THP_MIGRATION_SPLIT,
>   #endif
>   #ifdef CONFIG_MEMORY_BALLOON
>   		BALLOON_INFLATE,
> diff --git a/include/trace/events/migrate.h b/include/trace/events/migrate.h
> index 705b33d1e395..4d434398d64d 100644
> --- a/include/trace/events/migrate.h
> +++ b/include/trace/events/migrate.h
> @@ -46,13 +46,18 @@ MIGRATE_REASON
>   TRACE_EVENT(mm_migrate_pages,
>   
>   	TP_PROTO(unsigned long succeeded, unsigned long failed,
> -		 enum migrate_mode mode, int reason),
> +		 unsigned long thp_succeeded, unsigned long thp_failed,
> +		 unsigned long thp_split, enum migrate_mode mode, int reason),
>   
> -	TP_ARGS(succeeded, failed, mode, reason),
> +	TP_ARGS(succeeded, failed, thp_succeeded, thp_failed,
> +		thp_split, mode, reason),
>   
>   	TP_STRUCT__entry(
>   		__field(	unsigned long,		succeeded)
>   		__field(	unsigned long,		failed)
> +		__field(	unsigned long,		thp_succeeded)
> +		__field(	unsigned long,		thp_failed)
> +		__field(	unsigned long,		thp_split)
>   		__field(	enum migrate_mode,	mode)
>   		__field(	int,			reason)
>   	),
> @@ -60,13 +65,19 @@ TRACE_EVENT(mm_migrate_pages,
>   	TP_fast_assign(
>   		__entry->succeeded	= succeeded;
>   		__entry->failed		= failed;
> +		__entry->thp_succeeded	= thp_succeeded;
> +		__entry->thp_failed	= thp_failed;
> +		__entry->thp_split	= thp_split;
>   		__entry->mode		= mode;
>   		__entry->reason		= reason;
>   	),
>   
> -	TP_printk("nr_succeeded=%lu nr_failed=%lu mode=%s reason=%s",
> +	TP_printk("nr_succeeded=%lu nr_failed=%lu nr_thp_succeeded=%lu nr_thp_failed=%lu nr_thp_split=%lu mode=%s reason=%s",
>   		__entry->succeeded,
>   		__entry->failed,
> +		__entry->thp_succeeded,
> +		__entry->thp_failed,
> +		__entry->thp_split,
>   		__print_symbolic(__entry->mode, MIGRATE_MODE),
>   		__print_symbolic(__entry->reason, MIGRATE_REASON))
>   );
> diff --git a/mm/migrate.c b/mm/migrate.c
> index f37729673558..baf3cc477d11 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1429,22 +1429,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   		enum migrate_mode mode, int reason)
>   {
>   	int retry = 1;
> +	int thp_retry = 1;
>   	int nr_failed = 0;
>   	int nr_succeeded = 0;
> +	int nr_thp_succeeded = 0;
> +	int nr_thp_failed = 0;
> +	int nr_thp_split = 0;
>   	int pass = 0;
> +	bool is_thp = false;
>   	struct page *page;
>   	struct page *page2;
>   	int swapwrite = current->flags & PF_SWAPWRITE;
> -	int rc;
> +	int rc, thp_nr_pages;
>   
>   	if (!swapwrite)
>   		current->flags |= PF_SWAPWRITE;
>   
> -	for(pass = 0; pass < 10 && retry; pass++) {
> +	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>   		retry = 0;
> +		thp_retry = 0;
>   
>   		list_for_each_entry_safe(page, page2, from, lru) {
>   retry:
> +			/*
> +			 * THP statistics is based on the source huge page.
> +			 * Capture required information that might get lost
> +			 * during migration.
> +			 */
> +			is_thp = PageTransHuge(page);
> +			thp_nr_pages = hpage_nr_pages(page);
>   			cond_resched();
>   
>   			if (PageHuge(page))
> @@ -1475,15 +1488,30 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   					unlock_page(page);
>   					if (!rc) {
>   						list_safe_reset_next(page, page2, lru);
> +						nr_thp_split++;
>   						goto retry;
>   					}
>   				}
> +				if (is_thp) {
> +					nr_thp_failed++;
> +					nr_failed += thp_nr_pages;
> +					goto out;
> +				}
>   				nr_failed++;
>   				goto out;
>   			case -EAGAIN:
> +				if (is_thp) {
> +					thp_retry++;
> +					break;
> +				}
>   				retry++;
>   				break;
>   			case MIGRATEPAGE_SUCCESS:
> +				if (is_thp) {
> +					nr_thp_succeeded++;
> +					nr_succeeded += thp_nr_pages;
> +					break;
> +				}
>   				nr_succeeded++;
>   				break;
>   			default:
> @@ -1493,19 +1521,32 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>   				 * removed from migration page list and not
>   				 * retried in the next outer loop.
>   				 */
> +				if (is_thp) {
> +					nr_thp_failed++;
> +					nr_failed += thp_nr_pages;
> +					break;
> +				}
>   				nr_failed++;
>   				break;
>   			}
>   		}
>   	}
> -	nr_failed += retry;
> +	nr_failed += retry + thp_retry;
> +	nr_thp_failed += thp_retry;
>   	rc = nr_failed;
>   out:
>   	if (nr_succeeded)
>   		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>   	if (nr_failed)
>   		count_vm_events(PGMIGRATE_FAIL, nr_failed);
> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
> +	if (nr_thp_succeeded)
> +		count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> +	if (nr_thp_failed)
> +		count_vm_events(THP_MIGRATION_FAILURE, nr_thp_failed);
> +	if (nr_thp_split)
> +		count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);

As mentioned in the other thread, those "ifs" should be removed. I think you
can also get away with removing the two pre-existing "ifs" in the same
patch, too, just to keep the whole set consistent and more readable.


> +	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
> +			       nr_thp_failed, nr_thp_split, mode, reason);
>   
>   	if (!swapwrite)
>   		current->flags &= ~PF_SWAPWRITE;
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 3fb23a21f6dd..a0fc7c86cdb7 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1280,6 +1280,9 @@ const char * const vmstat_text[] = {
>   	"thp_zero_page_alloc_failed",
>   	"thp_swpout",
>   	"thp_swpout_fallback",
> +	"thp_migration_success",
> +	"thp_migration_failure",
> +	"thp_migration_split",
>   #endif
>   #ifdef CONFIG_MEMORY_BALLOON
>   	"balloon_inflate",
> 


thanks,
-- 
John Hubbard
NVIDIA
