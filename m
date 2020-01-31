Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6EFCC33CB7
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D9CC215A4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 16:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580487501;
	bh=1VWQZPn0u1KVvieWX4N5+PcWbTVfMVfkHLGuDvdna+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RsRYOGv0vLX5WViS1gA+iLmI2IscQTgg7JuN9gVub3VVm8h14JX8Zjdsho74QOGh/
	 NjnE44llrnVPauE5EyTgJZJ0KzSd3r8rQqPAj/0F3pdGWNumiaotlZC4ae7WHe3P48
	 8lctfQweMiwvuPufLyue6tckySjYHt/8RoEooFAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729286AbgAaQSU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 11:18:20 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34721 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727211AbgAaQSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 11:18:20 -0500
Received: by mail-wr1-f67.google.com with SMTP id t2so9345215wrr.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 08:18:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kU0rBqbsAp9k9v37rdhwZ9EPOQUK6yfRCG1Wi8K1r+Q=;
        b=OidwfIqqTjxyfVfk/nf7hZJ+n/xAeFgZSRFhZj+gzQtbfDTXC2EZMkHLU5Vmk8ob2/
         HAb+xAvqmOJF6fW3Whux+VE4McUvFUm94ddigMIyVGhkzmuMA83Qb7Ueb7aatqHHU+rd
         ZVVnBV8G8ut4Ej8+jVwtFP0GH5YgIMqmyWmLk5F3lq0pfEw2w8FqDEvAdys3vVImWb6I
         kzKq6WOwh1F+Jx59HnMveGPfXVMaNz/HG8x6DiPDEdhL4o2RLob7nEtNQgMV+ZWBfhu/
         8kGvNxPQ9JwfAkq89CYzdH++cTwKruMMHvy0NKLfdx0uFXlWhwZhqcoE1u869NeOyNDA
         qdcw==
X-Gm-Message-State: APjAAAXqgcIyiIZl5n+n2iXFJr14wQPszBcXQ+ycOcoW5G37J3r2QLXq
        rtYb9vwX3ylQLDzUTzt0SI0=
X-Google-Smtp-Source: APXvYqykH8eSR/NNqARmbjSLiLnaQDgnccYWQDflO5eJCBT7JGTVgVu1bsX4I8ClK8OisIE2yy6AFg==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr12814981wrn.283.1580487496942;
        Fri, 31 Jan 2020 08:18:16 -0800 (PST)
Received: from localhost (ip-37-188-238-177.eurotel.cz. [37.188.238.177])
        by smtp.gmail.com with ESMTPSA id p17sm12354130wrx.20.2020.01.31.08.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 08:18:16 -0800 (PST)
Date:   Fri, 31 Jan 2020 17:18:14 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        hannes@cmpxchg.org, shakeelb@google.com, vdavydov.dev@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] mm: Allocate shrinker_map on appropriate NUMA node
Message-ID: <20200131161814.GC4520@dhcp22.suse.cz>
References: <158047248934.390127.5043060848569612747.stgit@localhost.localdomain>
 <ebe1c944-2e0f-136d-dd09-0bb37d500fe2@redhat.com>
 <5f3fc9a9-9a22-ccc3-5971-9783b60807bc@virtuozzo.com>
 <20200131154735.GA4520@dhcp22.suse.cz>
 <a03cb815-8f80-03db-c1bd-39af960db601@virtuozzo.com>
 <20200131160151.GB4520@dhcp22.suse.cz>
 <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fff0e636-4c36-ed10-281c-8cdb0687c839@virtuozzo.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 31-01-20 19:08:49, Kirill Tkhai wrote:
> mm: Allocate shrinker_map on appropriate NUMA node
> 
> From: Kirill Tkhai <ktkhai@virtuozzo.com>
> 
> Despite shrinker_map may be touched from any cpu
> (e.g., a bit there may be set by a task running
> everywhere); kswapd is always bound to specific
> node. So, we will allocate shrinker_map from
> related NUMA node to respect its NUMA locality.
> Also, this follows generic way we use for allocation
> memcg's per-node data.

I would just drop the last sentence.
 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>

Acked-by: Michal Hocko <mhocko@suse.com>
> 
> v3: Remove node_state() patterns.
> v2: Use NUMA_NO_NODE instead of -1.
> ---
>  mm/memcontrol.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 6f6dc8712e39..c37382f5a43c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -334,7 +334,7 @@ static int memcg_expand_one_shrinker_map(struct mem_cgroup *memcg,
>  		if (!old)
>  			return 0;
>  
> -		new = kvmalloc(sizeof(*new) + size, GFP_KERNEL);
> +		new = kvmalloc_node(sizeof(*new) + size, GFP_KERNEL, nid);
>  		if (!new)
>  			return -ENOMEM;
>  
> @@ -378,7 +378,7 @@ static int memcg_alloc_shrinker_maps(struct mem_cgroup *memcg)
>  	mutex_lock(&memcg_shrinker_map_mutex);
>  	size = memcg_shrinker_map_size;
>  	for_each_node(nid) {
> -		map = kvzalloc(sizeof(*map) + size, GFP_KERNEL);
> +		map = kvzalloc_node(sizeof(*map) + size, GFP_KERNEL, nid);
>  		if (!map) {
>  			memcg_free_shrinker_maps(memcg);
>  			ret = -ENOMEM;

-- 
Michal Hocko
SUSE Labs
