Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3FFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDAA820776
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 15:34:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404461AbgE1Peb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 11:34:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:50596 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404400AbgE1Pea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 11:34:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 3C655AD10;
        Thu, 28 May 2020 15:34:28 +0000 (UTC)
Subject: Re: [PATCH v2 01/12] mm/page_isolation: prefer the node of the source
 page
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1590561903-13186-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1590561903-13186-2-git-send-email-iamjoonsoo.kim@lge.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <9ba7576a-ecaf-5b73-f96c-6ca6335e9353@suse.cz>
Date:   Thu, 28 May 2020 17:34:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <1590561903-13186-2-git-send-email-iamjoonsoo.kim@lge.com>
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
> For locality, it's better to migrate the page to the same node
> rather than the node of the current caller's cpu.

Should be, yeah.

> Acked-by: Roman Gushchin <guro@fb.com>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

> ---
>  mm/page_isolation.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 2c11a38..7df89bd 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -300,5 +300,7 @@ int test_pages_isolated(unsigned long start_pfn, unsigned long end_pfn,
>  
>  struct page *alloc_migrate_target(struct page *page, unsigned long private)
>  {
> -	return new_page_nodemask(page, numa_node_id(), &node_states[N_MEMORY]);
> +	int nid = page_to_nid(page);
> +
> +	return new_page_nodemask(page, nid, &node_states[N_MEMORY]);

I wonder why this and others uses node_states[N_MEMORY] and not just NULL. But
maybe that's addressed later.

>  }
> 

