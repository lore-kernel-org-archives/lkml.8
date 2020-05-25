Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801AFC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 696FD2073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:46:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403981AbgEYOqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:46:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:40338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403961AbgEYOqs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:46:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 908B6AC9F;
        Mon, 25 May 2020 14:46:49 +0000 (UTC)
Subject: Re: [PATCH v3 07/19] mm: memcg/slab: allocate obj_cgroups for
 non-root slab pages
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-8-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <49f98033-c39e-b60c-5142-552e586bf434@suse.cz>
Date:   Mon, 25 May 2020 16:46:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-8-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:46 PM, Roman Gushchin wrote:
> --- a/mm/slab.c
> +++ b/mm/slab.c
> @@ -1370,7 +1370,8 @@ static struct page *kmem_getpages(struct kmem_cache *cachep, gfp_t flags,
>  		return NULL;
>  	}
>  
> -	if (charge_slab_page(page, flags, cachep->gfporder, cachep)) {
> +	if (charge_slab_page(page, flags, cachep->gfporder, cachep,
> +			     cachep->num)) {
>  		__free_pages(page, cachep->gfporder);
>  		return NULL;
>  	}

Hmm noticed only when looking at later patch, this hunks adds a parameter that
the function doesn't take, so it doesn't compile.
