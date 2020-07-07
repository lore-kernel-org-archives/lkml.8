Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0485C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A923D20720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 11:22:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbgGGLWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 07:22:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:34258 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727097AbgGGLWc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 07:22:32 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DCDAFAD81;
        Tue,  7 Jul 2020 11:22:30 +0000 (UTC)
Subject: Re: [PATCH v4 04/11] mm/hugetlb: make hugetlb migration callback CMA
 aware
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1594107889-32228-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <c1cd6e11-08c3-5654-60e7-dec2eb80987a@suse.cz>
Date:   Tue, 7 Jul 2020 13:22:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1594107889-32228-5-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/7/20 9:44 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> new_non_cma_page() in gup.c which try to allocate migration target page
> requires to allocate the new page that is not on the CMA area.
> new_non_cma_page() implements it by removing __GFP_MOVABLE flag.  This way
> works well for THP page or normal page but not for hugetlb page.
> 
> hugetlb page allocation process consists of two steps.  First is dequeing
> from the pool.  Second is, if there is no available page on the queue,
> allocating from the page allocator.
> 
> new_non_cma_page() can control allocation from the page allocator by
> specifying correct gfp flag.  However, dequeing cannot be controlled until
> now, so, new_non_cma_page() skips dequeing completely.  It is a suboptimal
> since new_non_cma_page() cannot utilize hugetlb pages on the queue so this
> patch tries to fix this situation.
> 
> This patch makes the deque function on hugetlb CMA aware and skip CMA
> pages if newly added skip_cma argument is passed as true.

Hmm, can't you instead change dequeue_huge_page_node_exact() to test the PF_
flag and avoid adding bool skip_cma everywhere?

I think that's what Michal suggested [1] except he said "the code already does
by memalloc_nocma_{save,restore} API". It needs extending a bit though, AFAICS.
__gup_longterm_locked() indeed does the save/restore, but restore comes before
check_and_migrate_cma_pages() and thus new_non_cma_page() is called, so an
adjustment is needed there, but that's all?

Hm the adjustment should be also done because save/restore is done around
__get_user_pages_locked(), but check_and_migrate_cma_pages() also calls
__get_user_pages_locked(), and that call not being between nocma save and
restore is thus also a correctness issue?

[1] https://lore.kernel.org/r/20200629075510.GA32461@dhcp22.suse.cz

> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> ---
>  include/linux/hugetlb.h |  6 ++----
>  mm/gup.c                |  3 ++-
>  mm/hugetlb.c            | 46 ++++++++++++++++++++++++++++++----------------
>  mm/mempolicy.c          |  2 +-
>  mm/migrate.c            |  2 +-
>  5 files changed, 36 insertions(+), 23 deletions(-)
> 
