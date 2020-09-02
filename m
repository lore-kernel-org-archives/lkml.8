Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525CDC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147BB2083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 19:41:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="orJtq8Ju"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgIBTlt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 15:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726177AbgIBTlr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 15:41:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEE52C061244;
        Wed,  2 Sep 2020 12:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=ye3w0feqU1I8cFH7EdcoL4/Bc4Y2UNW9SvvwOIhdaGo=; b=orJtq8JulnnSul2tng/pf9iIsh
        7XdiIKRUkynIllnMMmEUhlk2zT2rdcX+4Yqb+x7KxzcqBO/h3Z55KEgcwVhsLoc5Fab0qwaGCVnj5
        gso+0daPnz4tuGWK9pkHp8FWfM3BJUlgfbfhje8Q+GD8miHlP5DZ67SNMXm1hL5qiTA6Za+w5qQGW
        7rGLP/T5uifc8CvaMljhf7Vyxpl3BrKvjBSwI8+MqO6Q/CWyeCfksGqWmnh2aegnNebeDS1DQXGtm
        h1cgeIv2VnrxSHQOIRFjECOmDwf5s9CvsZyYnhAl7V9ZqIDkG8WnDSiTKp5tnEvCI63rm68liqNb8
        mYfXIiSg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kDYdX-0002Xv-Dh; Wed, 02 Sep 2020 19:41:39 +0000
Subject: Re: [PATCH] mm/doc: editorial pass on page migration
To:     Ralph Campbell <rcampbell@nvidia.com>, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200902190603.13484-1-rcampbell@nvidia.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <1d17188f-e947-70c4-9bf7-2426c8429314@infradead.org>
Date:   Wed, 2 Sep 2020 12:41:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902190603.13484-1-rcampbell@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Ralph,

Thanks for the update/corrections. Nice job.

A few nits/comments below:

On 9/2/20 12:06 PM, Ralph Campbell wrote:
> Add Sphinx reference links to HMM and CPUSETS, and numerous small
> editorial changes to make the page_migration.rst document more readable.
> 
> Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> ---
>  .../admin-guide/cgroup-v1/cpusets.rst         |   2 +
>  Documentation/vm/hmm.rst                      |   2 +-
>  Documentation/vm/page_migration.rst           | 150 +++++++++---------
>  3 files changed, 80 insertions(+), 74 deletions(-)
> 

> diff --git a/Documentation/vm/page_migration.rst b/Documentation/vm/page_migration.rst
> index 68883ac485fa..bde21cd2f21f 100644
> --- a/Documentation/vm/page_migration.rst
> +++ b/Documentation/vm/page_migration.rst
> @@ -4,25 +4,28 @@
>  Page migration
>  ==============
>  
> -Page migration allows the moving of the physical location of pages between
> -nodes in a numa system while the process is running. This means that the
> +Page migration allows moving the physical location of pages between
> +nodes in a NUMA system while the process is running. This means that the
>  virtual addresses that the process sees do not change. However, the
>  system rearranges the physical location of those pages.
>  
> -The main intend of page migration is to reduce the latency of memory access
> +Also see :ref:`Heterogeneous Memory Management (HMM) <hmm>`
> +for migrating pages to or from device private memory.
> +
> +The main intent of page migration is to reduce the latency of memory accesses
>  by moving pages near to the processor where the process accessing that memory
>  is running.
>  
>  Page migration allows a process to manually relocate the node on which its
>  pages are located through the MF_MOVE and MF_MOVE_ALL options while setting
> -a new memory policy via mbind(). The pages of process can also be relocated
> +a new memory policy via mbind(). The pages of a process can also be relocated
>  from another process using the sys_migrate_pages() function call. The
> -migrate_pages function call takes two sets of nodes and moves pages of a
> +migrate_pages() function call takes two sets of nodes and moves pages of a
>  process that are located on the from nodes to the destination nodes.
>  Page migration functions are provided by the numactl package by Andi Kleen
>  (a version later than 0.9.3 is required. Get it from
>  ftp://oss.sgi.com/www/projects/libnuma/download/). numactl provides libnuma

   URL not valid/working AFAICT.

> -which provides an interface similar to other numa functionality for page
> +which provides an interface similar to other NUMA functionality for page
>  migration.  cat ``/proc/<pid>/numa_maps`` allows an easy review of where the
>  pages of a process are located. See also the numa_maps documentation in the
>  proc(5) man page.
> @@ -30,19 +33,19 @@ proc(5) man page.
>  Manual migration is useful if for example the scheduler has relocated
>  a process to a processor on a distant node. A batch scheduler or an
>  administrator may detect the situation and move the pages of the process
> -nearer to the new processor. The kernel itself does only provide
> +nearer to the new processor. The kernel itself only provides
>  manual page migration support. Automatic page migration may be implemented
>  through user space processes that move pages. A special function call
>  "move_pages" allows the moving of individual pages within a process.
> -A NUMA profiler may f.e. obtain a log showing frequent off node
> +For example, A NUMA profiler may obtain a log showing frequent off node

nit only:                                                         off-node

>  accesses and may use the result to move pages to more advantageous
>  locations.
>  
>  Larger installations usually partition the system using cpusets into
>  sections of nodes. Paul Jackson has equipped cpusets with the ability to
>  move pages when a task is moved to another cpuset (See
> -Documentation/admin-guide/cgroup-v1/cpusets.rst).
> -Cpusets allows the automation of process locality. If a task is moved to
> +:ref:`CPUSETS <cpusets>`).
> +Cpusets allow the automation of process locality. If a task is moved to
>  a new cpuset then also all its pages are moved with it so that the
>  performance of the process does not sink dramatically. Also the pages
>  of processes in a cpuset are moved if the allowed memory nodes of a
> @@ -67,9 +70,9 @@ In kernel use of migrate_pages()
>     Lists of pages to be migrated are generated by scanning over
>     pages and moving them into lists. This is done by
>     calling isolate_lru_page().
> -   Calling isolate_lru_page increases the references to the page
> +   Calling isolate_lru_page() increases the references to the page
>     so that it cannot vanish while the page migration occurs.
> -   It also prevents the swapper or other scans to encounter
> +   It also prevents the swapper or other scans from encountering
>     the page.
>  
>  2. We need to have a function of type new_page_t that can be
> @@ -91,23 +94,24 @@ is increased so that the page cannot be freed while page migration occurs.
>  
>  Steps:
>  
> -1. Lock the page to be migrated
> +1. Lock the page to be migrated.
>  
>  2. Ensure that writeback is complete.
>  
>  3. Lock the new page that we want to move to. It is locked so that accesses to
> -   this (not yet uptodate) page immediately lock while the move is in progress.
> +   this (not yet uptodate) page immediately block while the move is in progress.
>  
>  4. All the page table references to the page are converted to migration
>     entries. This decreases the mapcount of a page. If the resulting
>     mapcount is not zero then we do not migrate the page. All user space
> -   processes that attempt to access the page will now wait on the page lock.
> +   processes that attempt to access the page will now wait on the page lock
> +   or wait for the migration page table entry to be removed.
>  
>  5. The i_pages lock is taken. This will cause all processes trying
>     to access the page via the mapping to block on the spinlock.
>  
> -6. The refcount of the page is examined and we back out if references remain
> -   otherwise we know that we are the only one referencing this page.
> +6. The refcount of the page is examined and we back out if references remain.
> +   Otherwise, we know that we are the only one referencing this page.
>  
>  7. The radix tree is checked and if it does not contain the pointer to this
>     page then we back out because someone else modified the radix tree.
> @@ -134,22 +138,22 @@ Steps:
>  
>  15. Queued up writeback on the new page is triggered.
>  
> -16. If migration entries were page then replace them with real ptes. Doing
> -    so will enable access for user space processes not already waiting for
> -    the page lock.
> +16. If migration entries were inserted into the page table, then replace them
> +    with real ptes. Doing so will enable access for user space processes not
> +    already waiting for the page lock.
>  
> -19. The page locks are dropped from the old and new page.
> +17. The page locks are dropped from the old and new page.
>      Processes waiting on the page lock will redo their page faults
>      and will reach the new page.
>  
> -20. The new page is moved to the LRU and can be scanned by the swapper
> -    etc again.
> +18. The new page is moved to the LRU and can be scanned by the swapper,
> +    etc. again.
>  
>  Non-LRU page migration
>  ======================
>  
> -Although original migration aimed for reducing the latency of memory access
> -for NUMA, compaction who want to create high-order page is also main customer.
> +Although migration originally aimed for reducing the latency of memory accesses
> +for NUMA, compaction also uses migration to create high-order pages.
>  
>  Current problem of the implementation is that it is designed to migrate only
>  *LRU* pages. However, there are potential non-lru pages which can be migrated
> @@ -158,46 +162,47 @@ in drivers, for example, zsmalloc, virtio-balloon pages.
>  For virtio-balloon pages, some parts of migration code path have been hooked
>  up and added virtio-balloon specific functions to intercept migration logics.
>  It's too specific to a driver so other drivers who want to make their pages
> -movable would have to add own specific hooks in migration path.
> +movable would have to add their own specific hooks in the migration path.
>  
> -To overclome the problem, VM supports non-LRU page migration which provides
> +To overcome the problem, VM supports non-LRU page migration which provides
>  generic functions for non-LRU movable pages without driver specific hooks
> -migration path.
> +in the migration path.
>  
> -If a driver want to make own pages movable, it should define three functions
> +If a driver wants to make its pages movable, it should define three functions
>  which are function pointers of struct address_space_operations.
>  
>  1. ``bool (*isolate_page) (struct page *page, isolate_mode_t mode);``
>  
> -   What VM expects on isolate_page function of driver is to return *true*
> -   if driver isolates page successfully. On returing true, VM marks the page
> +   What VM expects on isolate_page() function of driver is to return *true*

maybe                 of {or from}

> +   if driver isolates the page successfully. On returning true, VM marks the page
>     as PG_isolated so concurrent isolation in several CPUs skip the page
>     for isolation. If a driver cannot isolate the page, it should return *false*.
>  
>     Once page is successfully isolated, VM uses page.lru fields so driver
> -   shouldn't expect to preserve values in that fields.
> +   shouldn't expect to preserve values in those fields.
>  
>  2. ``int (*migratepage) (struct address_space *mapping,``
>  |	``struct page *newpage, struct page *oldpage, enum migrate_mode);``
>  
> -   After isolation, VM calls migratepage of driver with isolated page.
> -   The function of migratepage is to move content of the old page to new page
> +   After isolation, VM calls migratepage() of driver with the isolated page.
> +   The function of migratepage() is to move the contents of the old page to the
> +   new page
>     and set up fields of struct page newpage. Keep in mind that you should
>     indicate to the VM the oldpage is no longer movable via __ClearPageMovable()
> -   under page_lock if you migrated the oldpage successfully and returns
> +   under page_lock if you migrated the oldpage successfully and returned
>     MIGRATEPAGE_SUCCESS. If driver cannot migrate the page at the moment, driver
>     can return -EAGAIN. On -EAGAIN, VM will retry page migration in a short time
> -   because VM interprets -EAGAIN as "temporal migration failure". On returning
> -   any error except -EAGAIN, VM will give up the page migration without retrying
> -   in this time.
> +   because VM interprets -EAGAIN as "temporary migration failure". On returning
> +   any error except -EAGAIN, VM will give up the page migration without
> +   retrying.
>  
> -   Driver shouldn't touch page.lru field VM using in the functions.
> +   Driver shouldn't touch the page.lru field while in the migratepage() function.
>  
>  3. ``void (*putback_page)(struct page *);``
>  
> -   If migration fails on isolated page, VM should return the isolated page
> -   to the driver so VM calls driver's putback_page with migration failed page.
> -   In this function, driver should put the isolated page back to the own data
> +   If migration fails on the isolated page, VM should return the isolated page
> +   to the driver so VM calls the driver's putback_page() with the isolated page.
> +   In this function, the driver should put the isolated page back into its own data
>     structure.
>  
>  4. non-lru movable page flags
> @@ -206,52 +211,51 @@ which are function pointers of struct address_space_operations.
>  
>     * PG_movable
>  
> -     Driver should use the below function to make page movable under page_lock::
> +     Driver should use the function below to make page movable under page_lock::
>  
>  	void __SetPageMovable(struct page *page, struct address_space *mapping)
>  
>       It needs argument of address_space for registering migration
>       family functions which will be called by VM. Exactly speaking,
> -     PG_movable is not a real flag of struct page. Rather than, VM
> -     reuses page->mapping's lower bits to represent it.
> +     PG_movable is not a real flag of struct page. Rather, VM
> +     reuses the page->mapping's lower bits to represent it::
>  
> -::
>  	#define PAGE_MAPPING_MOVABLE 0x2
>  	page->mapping = page->mapping | PAGE_MAPPING_MOVABLE;
>  
>       so driver shouldn't access page->mapping directly. Instead, driver should
> -     use page_mapping which mask off the low two bits of page->mapping under
> -     page lock so it can get right struct address_space.
> -
> -     For testing of non-lru movable page, VM supports __PageMovable function.
> -     However, it doesn't guarantee to identify non-lru movable page because
> -     page->mapping field is unified with other variables in struct page.
> -     As well, if driver releases the page after isolation by VM, page->mapping
> -     doesn't have stable value although it has PAGE_MAPPING_MOVABLE
> -     (Look at __ClearPageMovable). But __PageMovable is cheap to catch whether
> -     page is LRU or non-lru movable once the page has been isolated. Because
> -     LRU pages never can have PAGE_MAPPING_MOVABLE in page->mapping. It is also
> +     use page_mapping() which masks off the low two bits of page->mapping under
> +     page lock so it can get the right struct address_space.
> +
> +     For testing of non-lru movable pages, VM supports __PageMovable() function.

                       non-LRU

> +     However, it doesn't guarantee to identify non-lru movable pages because

                                                  non-LRU

> +     the page->mapping field is unified with other variables in struct page.
> +     If the driver releases the page after isolation by VM, page->mapping
> +     doesn't have a stable value although it has PAGE_MAPPING_MOVABLE set
> +     (look at __ClearPageMovable). But __PageMovable() is cheap to call whether
> +     page is LRU or non-lru movable once the page has been isolated because LRU

                       non-LRU

> +     pages can never have PAGE_MAPPING_MOVABLE set in page->mapping. It is also
>       good for just peeking to test non-lru movable pages before more expensive
> -     checking with lock_page in pfn scanning to select victim.
> +     checking with lock_page() in pfn scanning to select a victim.
>  
> -     For guaranteeing non-lru movable page, VM provides PageMovable function.
> -     Unlike __PageMovable, PageMovable functions validates page->mapping and
> -     mapping->a_ops->isolate_page under lock_page. The lock_page prevents sudden
> -     destroying of page->mapping.
> +     For guaranteeing non-lru movable page, VM provides PageMovable() function.

                         non-LRU

> +     Unlike __PageMovable(), PageMovable() validates page->mapping and
> +     mapping->a_ops->isolate_page under lock_page(). The lock_page() prevents
> +     sudden destroying of page->mapping.
>  
> -     Driver using __SetPageMovable should clear the flag via __ClearMovablePage
> -     under page_lock before the releasing the page.
> +     Drivers using __SetPageMovable() should clear the flag via
> +     __ClearMovablePage() under page_lock() before the releasing the page.
>  
>     * PG_isolated
>  
>       To prevent concurrent isolation among several CPUs, VM marks isolated page
> -     as PG_isolated under lock_page. So if a CPU encounters PG_isolated non-lru
> -     movable page, it can skip it. Driver doesn't need to manipulate the flag
> -     because VM will set/clear it automatically. Keep in mind that if driver
> -     sees PG_isolated page, it means the page have been isolated by VM so it
> -     shouldn't touch page.lru field.
> -     PG_isolated is alias with PG_reclaim flag so driver shouldn't use the flag
> -     for own purpose.
> +     as PG_isolated under lock_page(). So if a CPU encounters PG_isolated
> +     non-lru movable page, it can skip it. Driver doesn't need to manipulate the

        non-LRU

> +     flag because VM will set/clear it automatically. Keep in mind that if the
> +     driver sees a PG_isolated page, it means the page has been isolated by the
> +     VM so it shouldn't touch the page.lru field.
> +     The PG_isolated flag is aliased with the PG_reclaim flag so drivers
> +     shouldn't use PG_isolated for its own purposes.
>  
>  Monitoring Migration
>  =====================
> @@ -266,8 +270,8 @@ The following events (counters) can be used to monitor page migration.
>     512.
>  
>  2. PGMIGRATE_FAIL: Normal page migration failure. Same counting rules as for
> -   _SUCCESS, above: this will be increased by the number of subpages, if it was
> -   a THP.
> +   PGMIGRATE_SUCCESS, above: this will be increased by the number of subpages,
> +   if it was a THP.
>  
>  3. THP_MIGRATION_SUCCESS: A THP was migrated without being split.
>  
> 

-- 
~Randy

