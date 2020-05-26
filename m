Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E6AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:31:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E073B2073B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 11:31:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728608AbgEZLbZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 07:31:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:40824 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726974AbgEZLbY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 07:31:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 800B9B22B;
        Tue, 26 May 2020 11:31:26 +0000 (UTC)
Subject: Re: [PATCH v3 16/19] mm: memcg/slab: remove redundant check in
 memcg_accumulate_slabinfo()
To:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
References: <20200422204708.2176080-1-guro@fb.com>
 <20200422204708.2176080-17-guro@fb.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <539d6b1c-9719-e29d-c724-20947c806f09@suse.cz>
Date:   Tue, 26 May 2020 13:31:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200422204708.2176080-17-guro@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 10:47 PM, Roman Gushchin wrote:
> memcg_accumulate_slabinfo() is never called with a non-root
> kmem_cache as a first argument, so the is_root_cache(s) check
> is redundant and can be removed without any functional change.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

The check is also in memcg_cache() anyway.

> ---
>  mm/slab_common.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index c045afb9724e..52164ad0f197 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -1087,9 +1087,6 @@ memcg_accumulate_slabinfo(struct kmem_cache *s, struct slabinfo *info)
>  	struct kmem_cache *c;
>  	struct slabinfo sinfo;
>  
> -	if (!is_root_cache(s))
> -		return;
> -
>  	c = memcg_cache(s);
>  	if (c) {
>  		memset(&sinfo, 0, sizeof(sinfo));
> 

