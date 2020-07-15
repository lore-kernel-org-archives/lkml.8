Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB592C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD23B2064B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 09:51:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbgGOJvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 05:51:17 -0400
Received: from [195.135.220.15] ([195.135.220.15]:53436 "EHLO mx2.suse.de"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1730905AbgGOJvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:51:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4F4A5AF85;
        Wed, 15 Jul 2020 09:51:19 +0000 (UTC)
Subject: Re: [PATCH 3/4] mm/hugetlb: make hugetlb migration callback CMA aware
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1594789529-6206-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1594789529-6206-3-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <d2a26d81-ce9a-c24c-a2f7-d3b1fa2184d4@suse.cz>
Date:   Wed, 15 Jul 2020 11:51:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1594789529-6206-3-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/15/20 7:05 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> new_non_cma_page() in gup.c requires to allocate the new page that is not
> on the CMA area. new_non_cma_page() implements it by using allocation
> scope APIs.
> 
> However, there is a work-around for hugetlb. Normal hugetlb page
> allocation API for migration is alloc_huge_page_nodemask(). It consists
> of two steps. First is dequeing from the pool. Second is, if there is no
> available page on the queue, allocating by using the page allocator.
> 
> new_non_cma_page() can't use this API since first step (deque) isn't
> aware of scope API to exclude CMA area. So, new_non_cma_page() exports
> hugetlb internal function for the second step, alloc_migrate_huge_page(),
> to global scope and uses it directly. This is suboptimal since hugetlb
> pages on the queue cannot be utilized.
> 
> This patch tries to fix this situation by making the deque function on
> hugetlb CMA aware. In the deque function, CMA memory is skipped if
> PF_MEMALLOC_NOCMA flag is found.
> 
> Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>
