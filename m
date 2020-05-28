Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D926FC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C616B207BC
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406368AbgE1TZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:25:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:43406 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406316AbgE1TZG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:25:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9353AEE8;
        Thu, 28 May 2020 19:25:03 +0000 (UTC)
Subject: Re: [PATCH v2 00/12] clean-up the migration target allocation
 functions
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <45a8ee8b-ec3a-df0f-fe23-6f64097cd263@suse.cz>
Date:   Thu, 28 May 2020 21:25:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/27/20 8:44 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> This patchset clean-up the migration target allocation functions.
> 
> * Changes on v2
> - add acked-by tags
> - fix missing compound_head() call for the patch #3
> - remove thisnode field on alloc_control and use __GFP_THISNODE directly
> - fix missing __gfp_mask setup for the patch
> "mm/hugetlb: do not modify user provided gfp_mask"
> 
> * Cover-letter
> 
> Contributions of this patchset are:
> 1. unify two hugetlb alloc functions. As a result, one is remained.
> 2. make one external hugetlb alloc function to internal one.
> 3. unify three functions for migration target allocation.
> 
> The patchset is based on next-20200526.
> The patchset is available on:

I went through the series and I'd like to make some high-level suggestions
first, that should hopefully simplify the code a bit more and reduce churn:

- in the series, alloc_huge_page_nodemask() becomes the only caller of
alloc_migrate_huge_page(). So you can inline the code there, and it's one less
function out of many with similar name :)

- after that, alloc_huge_page_nodemask(ac) uses ac mostly just to extract
individual fields, and only pass it as a whole to dequeue_huge_page_nodemask().
The only other caller of dequeue...() is dequeue_huge_page_vma() who has to
construct ac from scratch. It might be probably simpler not to introduce struct
alloc_control into hugetlb code at all, and only keep it for
alloc_migrate_target(), at which point it can have a more specific name as
discussed and there's less churn

- I'd suggest not change signature of migrate_pages(), free_page_t and
new_page_t, keeping the opaque private field is fine as not all callbacks use
struct alloc_context pointer, and then e.g. compaction_alloc has to use the
private field etc. alloc_migration_target() can simply cast the private to
struct alloc_control *ac as the first thing

Thanks!
Vlastimil

> https://github.com/JoonsooKim/linux/tree/cleanup-migration-target-allocation-v2.00-next-20200526
> 
> Thanks.
> 
> Joonsoo Kim (12):
>   mm/page_isolation: prefer the node of the source page
>   mm/migrate: move migration helper from .h to .c
>   mm/hugetlb: introduce alloc_control structure to simplify migration
>     target allocation APIs
>   mm/hugetlb: use provided ac->gfp_mask for allocation
>   mm/hugetlb: unify hugetlb migration callback function
>   mm/hugetlb: make hugetlb migration target allocation APIs CMA aware
>   mm/hugetlb: do not modify user provided gfp_mask
>   mm/migrate: change the interface of the migration target alloc/free
>     functions
>   mm/migrate: make standard migration target allocation functions
>   mm/gup: use standard migration target allocation function
>   mm/mempolicy: use standard migration target allocation function
>   mm/page_alloc: use standard migration target allocation function
>     directly
> 
>  include/linux/hugetlb.h        | 33 ++++++---------
>  include/linux/migrate.h        | 44 +++++---------------
>  include/linux/page-isolation.h |  4 +-
>  mm/compaction.c                | 15 ++++---
>  mm/gup.c                       | 60 +++++-----------------------
>  mm/hugetlb.c                   | 91 ++++++++++++++++++++----------------------
>  mm/internal.h                  | 12 +++++-
>  mm/memory-failure.c            | 14 ++++---
>  mm/memory_hotplug.c            | 10 +++--
>  mm/mempolicy.c                 | 38 ++++++------------
>  mm/migrate.c                   | 72 +++++++++++++++++++++++++--------
>  mm/page_alloc.c                |  9 ++++-
>  mm/page_isolation.c            |  5 ---
>  13 files changed, 191 insertions(+), 216 deletions(-)
> 

