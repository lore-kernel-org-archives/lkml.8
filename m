Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1693C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC25A204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 15:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGCP4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 11:56:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:57216 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726035AbgGCP4e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 11:56:34 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 65440AD79;
        Fri,  3 Jul 2020 15:56:33 +0000 (UTC)
Subject: Re: [PATCH v3 6/8] mm/gup: use a standard migration target allocation
 callback
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1592892828-1934-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1592892828-1934-7-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <1693d7a8-4384-8fd8-69a2-55552329a34d@suse.cz>
Date:   Fri, 3 Jul 2020 17:56:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592892828-1934-7-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/20 8:13 AM, js1304@gmail.com wrote:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
> 
> There is a well-defined migration target allocation callback.
> It's mostly similar with new_non_cma_page() except considering CMA pages.
> 
> This patch adds a CMA consideration to the standard migration target
> allocation callback and use it on gup.c.
> 
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Acked-by: Vlastimil Babka <vbabka@suse.cz>

But a suggestion below.

> ---
>  mm/gup.c      | 57 ++++++++-------------------------------------------------
>  mm/internal.h |  1 +
>  mm/migrate.c  |  4 +++-
>  3 files changed, 12 insertions(+), 50 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index 15be281..f6124e3 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -1608,56 +1608,15 @@ static bool check_dax_vmas(struct vm_area_struct **vmas, long nr_pages)
>  }
>  
>  #ifdef CONFIG_CMA
> -static struct page *new_non_cma_page(struct page *page, unsigned long private)
> +static struct page *alloc_migration_target_non_cma(struct page *page, unsigned long private)
>  {

...

> +	struct migration_target_control mtc = {
> +		.nid = page_to_nid(page),
> +		.gfp_mask = GFP_USER | __GFP_NOWARN,
> +		.skip_cma = true,
> +	};
>  
> -	return __alloc_pages_node(nid, gfp_mask, 0);
> +	return alloc_migration_target(page, (unsigned long)&mtc);

Do we really need this wrapper? The only user is check_and_migrate_cma_pages so
just opencode it?
