Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF32C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:35:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2CB8207CB
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 15:35:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404232AbgEYPfT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 11:35:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:39596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404083AbgEYPfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 11:35:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 5E655AC49;
        Mon, 25 May 2020 15:35:19 +0000 (UTC)
Subject: Re: [PATCH] mm: dump_page: add debugfs file for dumping page state by
 pfn
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <159041635119.987025.7321864888027213705.stgit@buzz>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <cccdc0a9-0f13-232d-cdc9-9e81f90c914b@suse.cz>
Date:   Mon, 25 May 2020 17:35:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <159041635119.987025.7321864888027213705.stgit@buzz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/20 4:19 PM, Konstantin Khlebnikov wrote:
> Tool 'page-types' could list pages mapped by process or file cache pages,
> but it shows only limited amount of state exported via procfs.
> 
> Let's employ existing helper dump_page() to reach remaining information:
> writing pfn into /sys/kernel/debug/dump_page dumps state into kernel log.

Yeah that's indeed useful, however I'm less sure if kernel log is the proper way
to extract the data. For example IIRC with the page_owner file can "seek to pfn"
to dump it, although that makes it somewhat harder to use.

Or we could write pfn to one file and read the dump from another one? But that's
not atomic.

Perhaps if we could do something like "cat /sys/kernel/debug/dump_page/<pfn>"
without all the pfns being actually listed in the dump_page directory with "ls"?
Is that possible?

> # echo 0x37c43c > /sys/kernel/debug/dump_page
> # dmesg | tail -6
>  page:ffffcb0b0df10f00 refcount:1 mapcount:0 mapping:000000007755d3d9 index:0x30
>  0xffffffffae4239e0 name:"libGeoIP.so.1.6.9"
>  flags: 0x200000000020014(uptodate|lru|mappedtodisk)
>  raw: 0200000000020014 ffffcb0b187fd288 ffffcb0b189e6248 ffff9528a04afe10
>  raw: 0000000000000030 0000000000000000 00000001ffffffff 0000000000000000
>  page dumped because: debugfs request
> 
> With CONFIG_PAGE_OWNER=y shows also stacks for last page alloc and free:
> 
>  page:ffffea0018fff480 refcount:1 mapcount:1 mapping:0000000000000000 index:0x7f9f28f62
>  anon flags: 0x100000000080034(uptodate|lru|active|swapbacked)
>  raw: 0100000000080034 ffffea00184140c8 ffffea0018517d88 ffff8886076ba161
>  raw: 00000007f9f28f62 0000000000000000 0000000100000000 ffff888bfc79f000
>  page dumped because: debugfs request
>  page->mem_cgroup:ffff888bfc79f000
>  page_owner tracks the page as allocated
>  page last allocated via order 0, migratetype Movable, gfp_mask 0x100dca(GFP_HIGHUSER_MOVABLE|__GFP_ZERO)
>   prep_new_page+0x139/0x1a0
>   get_page_from_freelist+0xde9/0x14e0
>   __alloc_pages_nodemask+0x18b/0x360
>   alloc_pages_vma+0x7c/0x270
>   __handle_mm_fault+0xd40/0x12b0
>   handle_mm_fault+0xe7/0x1e0
>   do_page_fault+0x2d5/0x610
>   page_fault+0x2f/0x40
>  page last free stack trace:
>   free_pcp_prepare+0x11e/0x1c0
>   free_unref_page_list+0x71/0x180
>   release_pages+0x31e/0x480
>   tlb_flush_mmu+0x44/0x150
>   tlb_finish_mmu+0x3d/0x70
>   exit_mmap+0xdd/0x1a0
>   mmput+0x70/0x140
>   do_exit+0x33f/0xc40
>   do_group_exit+0x3a/0xa0
>   __x64_sys_exit_group+0x14/0x20
>   do_syscall_64+0x48/0x130
>   entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  Documentation/admin-guide/mm/pagemap.rst |    3 +++
>  Documentation/vm/page_owner.rst          |   10 ++++++++++
>  mm/debug.c                               |   27 +++++++++++++++++++++++++++
>  3 files changed, 40 insertions(+)
> 
> diff --git a/Documentation/admin-guide/mm/pagemap.rst b/Documentation/admin-guide/mm/pagemap.rst
> index 340a5aee9b80..663ad5490d72 100644
> --- a/Documentation/admin-guide/mm/pagemap.rst
> +++ b/Documentation/admin-guide/mm/pagemap.rst
> @@ -205,3 +205,6 @@ Before Linux 3.11 pagemap bits 55-60 were used for "page-shift" (which is
>  always 12 at most architectures). Since Linux 3.11 their meaning changes
>  after first clear of soft-dirty bits. Since Linux 4.2 they are used for
>  flags unconditionally.
> +
> +Page state could be dumped into kernel log by writing pfn in text form
> +into /sys/kernel/debug/dump_page.
> diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
> index 0ed5ab8c7ab4..d4d4dc64c19d 100644
> --- a/Documentation/vm/page_owner.rst
> +++ b/Documentation/vm/page_owner.rst
> @@ -88,3 +88,13 @@ Usage
>  
>     See the result about who allocated each page
>     in the ``sorted_page_owner.txt``.
> +
> +Notes
> +=====
> +
> +To lookup pages in file cache or mapped in process you could use interface
> +pagemap documented in Documentation/admin-guide/mm/pagemap.rst or tool
> +page-types in the tools/vm directory.
> +
> +Page state could be dumped into kernel log by writing pfn in text form
> +into /sys/kernel/debug/dump_page.
> diff --git a/mm/debug.c b/mm/debug.c
> index 2189357f0987..5803f2b63d95 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -14,6 +14,7 @@
>  #include <linux/migrate.h>
>  #include <linux/page_owner.h>
>  #include <linux/ctype.h>
> +#include <linux/debugfs.h>
>  
>  #include "internal.h"
>  
> @@ -147,6 +148,32 @@ void dump_page(struct page *page, const char *reason)
>  }
>  EXPORT_SYMBOL(dump_page);
>  
> +#ifdef CONFIG_DEBUG_FS
> +static int dump_page_set(void *data, u64 pfn)
> +{
> +	struct page *page;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	page = pfn_to_online_page(pfn);
> +	if (!page)
> +		return -ENXIO;
> +
> +	dump_page(page, "debugfs request");
> +	return 0;
> +}
> +DEFINE_DEBUGFS_ATTRIBUTE(dump_page_fops, NULL, dump_page_set, "%llx\n");
> +
> +static int __init dump_page_debugfs(void)
> +{
> +	debugfs_create_file_unsafe("dump_page", 0200, NULL, NULL,
> +				   &dump_page_fops);
> +	return 0;
> +}
> +late_initcall(dump_page_debugfs);
> +#endif /* CONFIG_DEBUG_FS */
> +
>  #ifdef CONFIG_DEBUG_VM
>  
>  void dump_vma(const struct vm_area_struct *vma)
> 

