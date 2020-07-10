Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4635C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB7CC20772
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 12:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594384163;
	bh=fCqelnP6JZwP5J7r0ZbxTrC8h6TK62cgNG9ljqqbjOM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sWx0PfM8qHKzVBGTf+CRf7eJBcLpYIAI2PHJOVIaaLCHXRzCFKtJBht/BJ+Q/MtNe
	 qxDNy2UAgYCUlJNbJInQR8bfeQ4bllw51Ax68/CWjzJBB/7kZD86CKwje2IOuuEfP3
	 t5bOI3CzXfgEaK38IJzz6Wmz47RSzQIAcrredBCE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgGJM3W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 08:29:22 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36064 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbgGJM3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 08:29:21 -0400
Received: by mail-ed1-f68.google.com with SMTP id dg28so4519903edb.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 05:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cgm+eurmiukbbtx74MhYfKemTBTq6ztp8WelN9Ojqdk=;
        b=rQ9SBFtUZuApZA6d/VeCfiCWT+QUZUndHFV91AAijK99OXK4wV4eqvDy/clwiF4Wj3
         f02tTpNoRQGg7hdxQbZvpkhbnQPf94yjqdVlyptWQcTOIoj9r5NRrA0G9BiJ/3RgSySh
         MA+cFg8j60N/2sc1NggPSyq+No0eTMVZPqER+Y/bLgan062R47RLmWhTfiC+IBCuffGP
         cOFJ2pdHm3fLKfEXrYnNQwbrHG/irLukMt1q8QrzHWwl6Aq36hw1sBbbWqkY0O1f6InF
         9cMAFj2ORGM5jhRHPADQSVfJ6I+bg9oBLofpBfpf8X++H2sCKWi5UtVuzFpeH7MQRoHA
         DxCg==
X-Gm-Message-State: AOAM533Ixo2xql0N3/YOCohRnnq8IzqinKI/utFb9GMI/kG/TKF1hPt4
        PnZP8Qul/VCaCmVvy9LoOkA=
X-Google-Smtp-Source: ABdhPJy7KmfajTBKfpZvajV7rh56847Wmcn4VoMmjn7rSC+KMwoWRhzPWnQStOUD/st0L7QVkoqWyA==
X-Received: by 2002:aa7:c883:: with SMTP id p3mr79304897eds.128.1594384159754;
        Fri, 10 Jul 2020 05:29:19 -0700 (PDT)
Received: from localhost (ip-37-188-148-171.eurotel.cz. [37.188.148.171])
        by smtp.gmail.com with ESMTPSA id w24sm4199587edt.28.2020.07.10.05.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 05:29:19 -0700 (PDT)
Date:   Fri, 10 Jul 2020 14:29:17 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering
 memory.high
Message-ID: <20200710122917.GB3022@dhcp22.suse.cz>
References: <20200709194718.189231-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709194718.189231-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 09-07-20 12:47:18, Roman Gushchin wrote:
> Memory.high limit is implemented in a way such that the kernel
> penalizes all threads which are allocating a memory over the limit.
> Forcing all threads into the synchronous reclaim and adding some
> artificial delays allows to slow down the memory consumption and
> potentially give some time for userspace oom handlers/resource control
> agents to react.
> 
> It works nicely if the memory usage is hitting the limit from below,
> however it works sub-optimal if a user adjusts memory.high to a value
> way below the current memory usage. It basically forces all workload
> threads (doing any memory allocations) into the synchronous reclaim
> and sleep. This makes the workload completely unresponsive for
> a long period of time and can also lead to a system-wide contention on
> lru locks. It can happen even if the workload is not actually tight on
> memory and has, for example, a ton of cold pagecache.
> 
> In the current implementation writing to memory.high causes an atomic
> update of page counter's high value followed by an attempt to reclaim
> enough memory to fit into the new limit. To fix the problem described
> above, all we need is to change the order of execution: try to push
> the memory usage under the limit first, and only then set the new
> high limit.

Shakeel would this help with your pro-active reclaim usecase? It would
require to reset the high limit right after the reclaim returns which is
quite ugly but it would at least not require a completely new interface.
You would simply do
	high = current - to_reclaim
	echo $high > memory.high
	echo infinity > memory.high # To prevent direct reclaim
				    # allocation stalls

The primary reason to set the high limit in advance was to catch
potential runaways more effectively because they would just get
throttled while memory_high_write is reclaiming. With this change
the reclaim here might be just playing never ending catch up. On the
plus side a break out from the reclaim loop would just enforce the limit
so if the operation takes too long then the reclaim burden will move
over to consumers eventually. So I do not see any real danger.

> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Domas Mituzas <domas@fb.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Chris Down <chris@chrisdown.name>

Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index b8424aa56e14..4b71feee7c42 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6203,8 +6203,6 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  	if (err)
>  		return err;
>  
> -	page_counter_set_high(&memcg->memory, high);
> -
>  	for (;;) {
>  		unsigned long nr_pages = page_counter_read(&memcg->memory);
>  		unsigned long reclaimed;
> @@ -6228,6 +6226,8 @@ static ssize_t memory_high_write(struct kernfs_open_file *of,
>  			break;
>  	}
>  
> +	page_counter_set_high(&memcg->memory, high);
> +
>  	return nbytes;
>  }
>  
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
