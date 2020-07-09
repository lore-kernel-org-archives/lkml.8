Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05950C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC5B2207FB
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 16:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nnKC5YsZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbgGIQjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 12:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726408AbgGIQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 12:39:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761FC08C5CE;
        Thu,  9 Jul 2020 09:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=3UuxFMebDkzB1e3hCAZj6XFZBbrvawXl6Fk+JRu1hl0=; b=nnKC5YsZwCnHcn/KIBX+6DhoDb
        TchRju5O/hBnMH72gWNs6whIIyETP8BQVrBmXYQKFwNqofhZXr78mXz2gpUQVtVqNdbo1rdGV0w75
        hv2POQuLA3xYMZfb0JNuawPztL9EWZbH+kpnsXU7fuj5tHBDBxAk7dEBl1j58Fu5Xm6nGmnXxz2uK
        6DGyCwrBQPFmDpxOH5Z7TDWdEg5o5U3gs2MQt0I6DviWEOquv1jnBEYC5A7cNPpP1bNjhhAki0Jk3
        WY6FbBKsMhBh4PT5I1EErecibfqE2lETbk18ns92CJHiSHPnFVBixLiwq99TIltmXxgzFNdX41jR4
        Io7Z4E7g==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtZZk-0005zx-Gd; Thu, 09 Jul 2020 16:39:08 +0000
Subject: Re: [PATCH V4] mm/vmstat: Add events for THP migration without split
To:     Zi Yan <ziy@nvidia.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
        Jonathan Corbet <corbet@lwn.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1594287583-16568-1-git-send-email-anshuman.khandual@arm.com>
 <cab90a5c-4c61-e9ad-659f-a9438d639fe5@infradead.org>
 <27CD781D-48F0-4019-934F-78994BAEC656@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <97219d3b-96e1-4371-59ea-d038f37a672a@infradead.org>
Date:   Thu, 9 Jul 2020 09:39:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <27CD781D-48F0-4019-934F-78994BAEC656@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/9/20 9:34 AM, Zi Yan wrote:
> On 9 Jul 2020, at 11:34, Randy Dunlap wrote:
> 
>> Hi,
>>
>> I have a few comments on this.
>>
>> a. I reported it very early and should have been Cc-ed.
>>
>> b. A patch that applies to mmotm or linux-next would have been better
>> than a full replacement patch.
>>
>> c. I tried replacing what I believe is the correct/same patch file in mmotm
>> and still have build errors.
>>
>> (more below)
>>
>> On 7/9/20 2:39 AM, Anshuman Khandual wrote:
>>
>>> ---
>>> Applies on 5.8-rc4.
>>>
>>> Changes in V4:
>>>
>>> - Changed THP_MIGRATION_FAILURE as THP_MIGRATION_FAIL per John
>>> - Dropped all conditional 'if' blocks in migrate_pages() per Andrew and John
>>> - Updated migration events documentation per John
>>> - Updated thp_nr_pages variable as nr_subpages for an expected merge conflict
>>> - Moved all new THP vmstat events into CONFIG_MIGRATION
>>> - Updated Cc list with Documentation/ and tracing related addresses
>>>
>>> Changes in V3: (https://patchwork.kernel.org/patch/11647237/)
>>>
>>> - Formatted new events documentation with 'fmt' tool per Matthew
>>> - Made events universally available i.e dropped ARCH_ENABLE_THP_MIGRATION
>>> - Added THP_MIGRATION_SPLIT
>>> - Updated trace_mm_migrate_pages() with THP events
>>> - Made THP events update normal page migration events as well
>>>
>>> Changes in V2: (https://patchwork.kernel.org/patch/11586893/)
>>>
>>> - Dropped PMD reference both from code and commit message per Matthew
>>> - Added documentation and updated the commit message per Daniel
>>>
>>> Changes in V1: (https://patchwork.kernel.org/patch/11564497/)
>>>
>>> - Changed function name as thp_pmd_migration_success() per John
>>> - Folded in a fix (https://patchwork.kernel.org/patch/11563009/) from Hugh
>>>
>>> Changes in RFC V2: (https://patchwork.kernel.org/patch/11554861/)
>>>
>>> - Decopupled and renamed VM events from their implementation per Zi and John
>>> - Added THP_PMD_MIGRATION_FAILURE VM event upon allocation failure and split
>>>
>>> Changes in RFC V1: (https://patchwork.kernel.org/patch/11542055/)
>>>
>>>  Documentation/vm/page_migration.rst | 27 +++++++++++++++
>>>  include/linux/vm_event_item.h       |  3 ++
>>>  include/trace/events/migrate.h      | 17 ++++++++--
>>>  mm/migrate.c                        | 52 ++++++++++++++++++++++++-----
>>>  mm/vmstat.c                         |  3 ++
>>>  5 files changed, 91 insertions(+), 11 deletions(-)
>>>
>>
>>> diff --git a/include/linux/vm_event_item.h b/include/linux/vm_event_item.h
>>> index 24fc7c3ae7d6..2e6ca53b9bbd 100644
>>> --- a/include/linux/vm_event_item.h
>>> +++ b/include/linux/vm_event_item.h
>>> @@ -56,6 +56,9 @@ enum vm_event_item { PGPGIN, PGPGOUT, PSWPIN, PSWPOUT,
>>>  #endif
>>>  #ifdef CONFIG_MIGRATION
>>>  		PGMIGRATE_SUCCESS, PGMIGRATE_FAIL,
>>> +		THP_MIGRATION_SUCCESS,
>>> +		THP_MIGRATION_FAIL,
>>> +		THP_MIGRATION_SPLIT,
>>
>> These 3 new symbols are still only present if CONFIG_MIGRATION=y, but the build errors
>> are using these symbols even when CONFIG_MIGRATION is not set.
>>
>>>  #endif
>>>  #ifdef CONFIG_COMPACTION
>>>  		COMPACTMIGRATE_SCANNED, COMPACTFREE_SCANNED,
>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index f37729673558..c706e3576cfc 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1429,22 +1429,35 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  		enum migrate_mode mode, int reason)
>>>  {
>>>  	int retry = 1;
>>> +	int thp_retry = 1;
>>>  	int nr_failed = 0;
>>>  	int nr_succeeded = 0;
>>> +	int nr_thp_succeeded = 0;
>>> +	int nr_thp_failed = 0;
>>> +	int nr_thp_split = 0;
>>>  	int pass = 0;
>>> +	bool is_thp = false;
>>>  	struct page *page;
>>>  	struct page *page2;
>>>  	int swapwrite = current->flags & PF_SWAPWRITE;
>>> -	int rc;
>>> +	int rc, nr_subpages;
>>>
>>>  	if (!swapwrite)
>>>  		current->flags |= PF_SWAPWRITE;
>>>
>>> -	for(pass = 0; pass < 10 && retry; pass++) {
>>> +	for (pass = 0; pass < 10 && (retry || thp_retry); pass++) {
>>>  		retry = 0;
>>> +		thp_retry = 0;
>>>
>>>  		list_for_each_entry_safe(page, page2, from, lru) {
>>>  retry:
>>> +			/*
>>> +			 * THP statistics is based on the source huge page.
>>> +			 * Capture required information that might get lost
>>> +			 * during migration.
>>> +			 */
>>> +			is_thp = PageTransHuge(page);
>>> +			nr_subpages = hpage_nr_pages(page);
>>>  			cond_resched();
>>>
>>>  			if (PageHuge(page))
>>> @@ -1475,15 +1488,30 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  					unlock_page(page);
>>>  					if (!rc) {
>>>  						list_safe_reset_next(page, page2, lru);
>>> +						nr_thp_split++;
>>>  						goto retry;
>>>  					}
>>>  				}
>>> +				if (is_thp) {
>>> +					nr_thp_failed++;
>>> +					nr_failed += nr_subpages;
>>> +					goto out;
>>> +				}
>>>  				nr_failed++;
>>>  				goto out;
>>>  			case -EAGAIN:
>>> +				if (is_thp) {
>>> +					thp_retry++;
>>> +					break;
>>> +				}
>>>  				retry++;
>>>  				break;
>>>  			case MIGRATEPAGE_SUCCESS:
>>> +				if (is_thp) {
>>> +					nr_thp_succeeded++;
>>> +					nr_succeeded += nr_subpages;
>>> +					break;
>>> +				}
>>>  				nr_succeeded++;
>>>  				break;
>>>  			default:
>>> @@ -1493,19 +1521,27 @@ int migrate_pages(struct list_head *from, new_page_t get_new_page,
>>>  				 * removed from migration page list and not
>>>  				 * retried in the next outer loop.
>>>  				 */
>>> +				if (is_thp) {
>>> +					nr_thp_failed++;
>>> +					nr_failed += nr_subpages;
>>> +					break;
>>> +				}
>>>  				nr_failed++;
>>>  				break;
>>>  			}
>>>  		}
>>>  	}
>>> -	nr_failed += retry;
>>> +	nr_failed += retry + thp_retry;
>>> +	nr_thp_failed += thp_retry;
>>>  	rc = nr_failed;
>>>  out:
>>> -	if (nr_succeeded)
>>> -		count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>> -	if (nr_failed)
>>> -		count_vm_events(PGMIGRATE_FAIL, nr_failed);
>>> -	trace_mm_migrate_pages(nr_succeeded, nr_failed, mode, reason);
>>> +	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
>>> +	count_vm_events(PGMIGRATE_FAIL, nr_failed);
>>> +	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
>>> +	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
>>> +	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
>>
>> These references still cause build errors.
>>
>>> +	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
>>> +			       nr_thp_failed, nr_thp_split, mode, reason);
>>>
>>>  	if (!swapwrite)
>>>  		current->flags &= ~PF_SWAPWRITE;
>>> diff --git a/mm/vmstat.c b/mm/vmstat.c
>>> index 3fb23a21f6dd..09914a4bfee4 100644
>>> --- a/mm/vmstat.c
>>> +++ b/mm/vmstat.c
>>> @@ -1234,6 +1234,9 @@ const char * const vmstat_text[] = {
>>>  #ifdef CONFIG_MIGRATION
>>>  	"pgmigrate_success",
>>>  	"pgmigrate_fail",
>>> +	"thp_migration_success",
>>> +	"thp_migration_fail",
>>> +	"thp_migration_split",
>>>  #endif
>>>  #ifdef CONFIG_COMPACTION
>>>  	"compact_migrate_scanned",
>>>
>>
> 
> Which arch are you building? I did not see any error
> after applying this patch on mmotm (reverting the existing ones)
> and compiling them on x86_64. I used make x86_64_defconfig and
> unselected COMPACTION and MIGRATION.

Hi,

I am trying to build x86_64.
Maybe I am just having trouble replacing the patch file.
Like I tried to say, I would prefer to see an incremental patch
to fix mmotm or linux-next.


> mm/migrate.c and added vm events will not be used
> if CONFIG_MIGRATION is unchecked. Why would they cause compilation errors?

AFAICT, the patch adds these calls:
+	count_vm_events(PGMIGRATE_SUCCESS, nr_succeeded);
+	count_vm_events(PGMIGRATE_FAIL, nr_failed);
+	count_vm_events(THP_MIGRATION_SUCCESS, nr_thp_succeeded);
+	count_vm_events(THP_MIGRATION_FAIL, nr_thp_failed);
+	count_vm_events(THP_MIGRATION_SPLIT, nr_thp_split);
+	trace_mm_migrate_pages(nr_succeeded, nr_failed, nr_thp_succeeded,
+			       nr_thp_failed, nr_thp_split, mode, reason);

even when CONFIG_MIGRATION is not set, but then the THP_MIGRATIION_SUCCESS/FAIL/SPLIT
symbols are not defined.


-- 
~Randy

