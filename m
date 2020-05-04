Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F8BC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C820D206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 21:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ufRV87cA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgEDVTx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 17:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726291AbgEDVTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 17:19:53 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AAEC061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 14:19:53 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id u10so134723pls.8
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 14:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ofVuImENnldfoCd90MLX4zmTDmxbUDPjKQ1UMuBWtAI=;
        b=ufRV87cABctefq3CaUNBeJz+aryNV1QMLbKKZMSgxvS5vmJY9cXxU4A0vO1sJYTkpv
         qw0ofQhQZdGGXKHGYFlL5L1rbzVebKrR9L4Qac9f+D10zaUJoMV0apsENoPQLwMg6dpP
         NiaruzsFZ6w2qLR1OvL7brj8ccRl8lZLmhrVKPUL9y93OzcN49B0Pq+mPe2mX9mK+lBB
         98RkHdOIoG/fgR7PvO1MlLxXwuPFr2NogTjHm+UcoKoskLBn3YsAoR9p8KZecS9l4coB
         YOS5h6nnvQdYlk8rZg7G6wTWnZM6AFp1X65YkoS47Em088TeixOzpaCQR+dFgCwUEHY5
         3RVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ofVuImENnldfoCd90MLX4zmTDmxbUDPjKQ1UMuBWtAI=;
        b=TdfCoSXUSHNGRGV8eB602gl9tNxw8MOqJx9rXFKl1pg8KZEQKWXYZscQosjW1LQyiQ
         Ec7EZ6riv9vzv1jJdfq4JwQynyd1Y4ujIHmh0phu3j8IvfUOMgd9ILJrvAedimuAcdPt
         gmlMtSetd+jq9b2UhoSo2lHNpwb3XT/LDScwhRcn6eiewl5aYh5fdCv5utEdyn9FNoZG
         ZnS6KJXKCEAxOGQeHaen6cBzBIR7Yze5wAsoZPZA8oVPqZNIS6QtSttydlmuVOUG6KBr
         YsyklPVkpvR7gysEKNlVat47z+QpC4PQtJgQH9pngdgz+vMS0PbHY8H1DdR4VaPkPZRe
         byBw==
X-Gm-Message-State: AGi0PuZ4HOx2d5LMyowOPw0iJyZ/o//JkzPlXS54YFtvL9T5LZw80uqC
        HvflFtNqD4xy7ypSNFk6tbufCQBPCOQ=
X-Google-Smtp-Source: APiQypL6sapy2u1AaG3wPlFmBqQ6veiSJ6fTsqWTa3sLzE3QvHTzNnRKFxj+MFxdaV+J3EimsJXiyA==
X-Received: by 2002:a17:90a:2344:: with SMTP id f62mr86684pje.152.1588627192508;
        Mon, 04 May 2020 14:19:52 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a142sm23508pfa.6.2020.05.04.14.19.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 14:19:51 -0700 (PDT)
Date:   Mon, 4 May 2020 14:19:51 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Subject: Re: [PATCH] slub: limit count of partial slabs scanned to gather
 statistics
In-Reply-To: <158860845968.33385.4165926113074799048.stgit@buzz>
Message-ID: <alpine.DEB.2.22.394.2005041411020.224786@chino.kir.corp.google.com>
References: <158860845968.33385.4165926113074799048.stgit@buzz>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 May 2020, Konstantin Khlebnikov wrote:

> To get exact count of free and used objects slub have to scan list of
> partial slabs. This may take at long time. Scanning holds spinlock and
> blocks allocations which move partial slabs to per-cpu lists and back.
> 
> Example found in the wild:
> 
> # cat /sys/kernel/slab/dentry/partial
> 14478538 N0=7329569 N1=7148969
> # time cat /sys/kernel/slab/dentry/objects
> 286225471 N0=136967768 N1=149257703
> 
> real	0m1.722s
> user	0m0.001s
> sys	0m1.721s
> 
> The same problem in slab was addressed in commit f728b0a5d72a ("mm, slab:
> faster active and free stats") by adding more kmem cache statistics.
> For slub same approach requires atomic op on fast path when object frees.
> 
> Let's simply limit count of scanned slabs and print warning.
> Limit set in /sys/module/slub/parameters/max_partial_to_count.
> Default is 10000 which should be enough for most sane cases.
> 
> Return linear approximation if list of partials is longer than limit.
> Nobody should notice difference.
> 

Hi Konstantin,

Do you only exhibit this on slub for SO_ALL|SO_OBJECTS?  I notice the 
timing in the changelog is only looking at "objects" and not "partial".

If so, it seems this is also a problem for get_slabinfo() since it also 
uses the count_free() callback for count_partial().

Concern would be that the kernel has now drastically changed a statistic 
that it exports to userspace.  There was some discussion about this back 
in 2016[*] and one idea was that slabinfo would truncate its scanning and 
append a '+' to the end of the value to indicate it exceeds the max, i.e. 
10000+.  I think that '+' actually caused the problem itself for userspace 
processes.

I think the patch is too far reaching, however, since it impacts all 
count_partial() counting and not only for the case cited in the changelog.  
Are there examples for things other than the count_free() callback?

 [*] https://lore.kernel.org/patchwork/patch/708427/

> Signed-off-by: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
> ---
>  mm/slub.c |   15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/slub.c b/mm/slub.c
> index 9bf44955c4f1..86a366f7acb6 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -2407,16 +2407,29 @@ static inline unsigned long node_nr_objs(struct kmem_cache_node *n)
>  #endif /* CONFIG_SLUB_DEBUG */
>  
>  #if defined(CONFIG_SLUB_DEBUG) || defined(CONFIG_SYSFS)
> +
> +static unsigned long max_partial_to_count __read_mostly = 10000;
> +module_param(max_partial_to_count, ulong, 0644);
> +
>  static unsigned long count_partial(struct kmem_cache_node *n,
>  					int (*get_count)(struct page *))
>  {
> +	unsigned long counted = 0;
>  	unsigned long flags;
>  	unsigned long x = 0;
>  	struct page *page;
>  
>  	spin_lock_irqsave(&n->list_lock, flags);
> -	list_for_each_entry(page, &n->partial, slab_list)
> +	list_for_each_entry(page, &n->partial, slab_list) {
>  		x += get_count(page);
> +
> +		if (++counted > max_partial_to_count) {
> +			pr_warn_once("SLUB: too much partial slabs to count all objects, increase max_partial_to_count.\n");
> +			/* Approximate total count of objects */
> +			x = mult_frac(x, n->nr_partial, counted);
> +			break;
> +		}
> +	}
>  	spin_unlock_irqrestore(&n->list_lock, flags);
>  	return x;
>  }
> 
> 
