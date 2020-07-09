Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C14AC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 118F220674
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 21:24:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jWXegkAC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726768AbgGIVY5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 17:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726228AbgGIVY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 17:24:57 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CF4C08C5CE;
        Thu,  9 Jul 2020 14:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=fqPRR4cRZUFCcaafqyItqT0Rlf8HPTyhfsJ7WZ4PAKw=; b=jWXegkACyJo8K5b4hE+E3FuWUz
        Lx1l/tRkm0uGF7Rg2mqX2Ea3IDUgwdZ/IqTBq8wnGjLyNBPnH2f5/2LBhbSPJbOZHGdTxoTVKGTqg
        fWKKufLNitGB6rZRrNnGzOYeYOiZK/eayWAZHKH0gqV7YdhAdKt7/voLCKBzSwzCkmi4EKdJwGVap
        uTguSxvZ6E5djzWqssAuuwzJbQXRDzL8HCTt4qlh+XHw2lta16rqK+ma9kGldQ8eM+jH2h+awCzoo
        1f9xqFkpRFa03MdZis8tQuT8n2llzdybY4kPK+abskis3AL96aakCKa9NGUY6Wc9BS4XdcWL2+P5v
        CmMXx5qA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jte2G-0003SA-EF; Thu, 09 Jul 2020 21:24:52 +0000
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
To:     Zi Yan <ziy@nvidia.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
 <27CD781D-48F0-4019-934F-78994BAEC656@nvidia.com>
 <97219d3b-96e1-4371-59ea-d038f37a672a@infradead.org>
 <C5E3C65C-8253-4638-9D3C-71A61858BB8B@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97b6780f-36fc-ee44-bf18-ef22d8b87f23@infradead.org>
Date:   Thu, 9 Jul 2020 14:24:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <C5E3C65C-8253-4638-9D3C-71A61858BB8B@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 10:42 AM, Zi Yan wrote:

> 
> I agree. The patch does not apply to mmotm. Can you try the incremental
> patch below? It should apply to mmotm.
> 
> 
> Hi Andrew and Anshuman,
> 
> Should Anshuman resend the incremental patch or Andrew can fold it along
> with the two patches in mmotm into one?
> 
> 
> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
> index e65d49f3cf86..68883ac485fa 100644
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -253,24 +253,32 @@ which are function pointers of struct address_space_operations.
>       PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
>       for own purpose.
> 
> -Quantifying Migration
> +Monitoring Migration
>  =====================
> -Following events can be used to quantify page migration.
> -
> -1. PGMIGRATE_SUCCESS       /* Normal page migration success */
> -2. PGMIGRATE_FAIL          /* Normal page migration failure */
> -3. THP_MIGRATION_SUCCESS   /* Transparent huge page migration success */
> -4. THP_MIGRATION_FAILURE   /* Transparent huge page migration failure */
> -5. THP_MIGRATION_SPLIT     /* Transparent huge page got split, retried */
> -
> -THP_MIGRATION_SUCCESS is when THP is migrated successfully without getting
> -split into it's subpages. THP_MIGRATION_FAILURE is when THP could neither
> -be migrated nor be split. THP_MIGRATION_SPLIT is when THP could not
> -just be migrated as is but instead get split into it's subpages and later
> -retried as normal pages. THP events would also update normal page migration
> -statistics PGMIGRATE_SUCCESS and PGMIGRATE_FAILURE. These events will help
> -in quantifying and analyzing various THP migration events including both
> -success and failure cases.
> +
> +The following events (counters) can be used to monitor page migration.
> +
> +1. PGMIGRATE_SUCCESS: Normal page migration success. Each count means that a
> +   page was migrated. If the page was a non-THP page, then this counter is
> +   increased by one. If the page was a THP, then this counter is increased by
> +   the number of THP subpages. For example, migration of a single 2MB THP that
> +   has 4KB-size base pages (subpages) will cause this counter to increase by
> +   512.
> +
> +2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as for
> +   _SUCCESS, above: this will be increased by the number of subpages, if it was
> +   a THP.
> +
> +3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.
> +
> +4. THP_MIGRATION_FAIL: A THP could not be migrated nor it could be split.
> +
> +5. THP_MIGRATION_SPLIT: A THP was migrated, but not as such: first, the THP had
> +   to be split. After splitting, a migration retry was used for it's sub-pages.
> +
> +THP_MIGRATION_* events also update the appropriate PGMIGRATE_SUCCESS or
> +PGMIGRATE_FAIL events. For example, a THP migration failure will cause both
> +THP_MIGRATION_FAIL and PGMIGRATE_FAIL to increase.
> 
>  Christoph Lameter, May 8, 2006.
>  Minchan Kim, Mar 28, 2016.
> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
> index 5e7ffa025589..2e6ca53b9bbd 100644
> --- a/include/linux/vm_event_item.h
> +++ b/include/linux/vm_event_item.h
> @@ -56,6 +56,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  #endif
>  #ifdef CONFIG_MIGRATION
>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
> +		THP_MIGRATION_SUCCESS,
> +		THP_MIGRATION_FAIL,
> +		THP_MIGRATION_SPLIT,
>  #endif
>  #ifdef CONFIG_COMPACTION
>  		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
> @@ -95,9 +98,6 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>  		THP_ZERO_PAGE_ALLOC_FAILED,
>  		THP_SWPOUT,
>  		THP_SWPOUT_FALLBACK,
> -		THP_MIGRATION_SUCCESS,
> -		THP_MIGRATION_FAILURE,
> -		THP_MIGRATION_SPLIT,
>  #endif
>  #ifdef CONFIG_MEMORY_BALLOON
>  		BALLOON_INFLATE,
> diff --git a/mm/migrate.c b/mm/migrate.c
> index b0125c082549..c6cb8e676f9d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1425,7 +1425,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	struct page *page;
>  	struct page *page2;
>  	int swapwrite = current->flags & PF_SWAPWRITE;
> -	int rc, thp_n_pages;
> +	int rc, nr_subpages;
> 
>  	if (!swapwrite)
>  		current->flags |= PF_SWAPWRITE;
> @@ -1442,7 +1442,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			 * during migration.
>  			 */
>  			is_thp = PageTransHuge(page);
> -			thp_n_pages = thp_nr_pages(page);
> +			nr_subpages = thp_nr_pages(page);
>  			cond_resched();
> 
>  			if (PageHuge(page))
> @@ -1479,7 +1479,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				}
>  				if (is_thp) {
>  					nr_thp_failed++;
> -					nr_failed += thp_n_pages;
> +					nr_failed += nr_subpages;
>  					goto out;
>  				}
>  				nr_failed++;
> @@ -1494,7 +1494,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  			case MIGRATEPAGE_SUCCESS:
>  				if (is_thp) {
>  					nr_thp_succeeded++;
> -					nr_succeeded += thp_n_pages;
> +					nr_succeeded += nr_subpages;
>  					break;
>  				}
>  				nr_succeeded++;
> @@ -1508,7 +1508,7 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  				 */
>  				if (is_thp) {
>  					nr_thp_failed++;
> -					nr_failed += thp_n_pages;
> +					nr_failed += nr_subpages;
>  					break;
>  				}
>  				nr_failed++;
> @@ -1520,16 +1520,11 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>  	nr_thp_failed += thp_retry;
>  	rc = nr_failed;
>  out:
> -	if (nr_succeeded)
> -		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> -	if (nr_failed)
> -		count_vm_events(PGMIGRATE_FAIL, nr_failed);
> -	if (nr_thp_succeeded)
> -		count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> -	if (nr_thp_failed)
> -		count_vm_events(THP_MIGRATION_FAILURE, nr_thp_failed);
> -	if (nr_thp_split)
> -		count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
> +	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
> +	count_vm_events(PGMIGRATE_FAIL, nr_failed);
> +	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
> +	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
> +	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>  	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
>  			       nr_thp_failed, nr_thp_split, mode, reason);
> 
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 9892090df6a2..a21140373edb 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -1274,6 +1274,9 @@ const char * const vmstat_text[] = {
>  #ifdef CONFIG_MIGRATION
>  	"pgmigrate_success",
>  	"pgmigrate_fail",
> +	"thp_migration_success",
> +	"thp_migration_fail",
> +	"thp_migration_split",
>  #endif
>  #ifdef CONFIG_COMPACTION
>  	"compact_migrate_scanned",
> @@ -1320,9 +1323,6 @@ const char * const vmstat_text[] = {
>  	"thp_zero_page_alloc_failed",
>  	"thp_swpout",
>  	"thp_swpout_fallback",
> -	"thp_migration_success",
> -	"thp_migration_failure",
> -	"thp_migration_split",
>  #endif
>  #ifdef CONFIG_MEMORY_BALLOON
>  	"balloon_inflate",

Hi,

Thanks for the patch.
Works for me.

-- 
~Randy

