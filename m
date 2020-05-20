Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BB93C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D90B20874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 23:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590018040;
	bh=yJQr4N2gMImcjIgh4e+Nb6eX8prUZSgWAz7fgEAtjn8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=IF1uhxT+tDeMK0+FM3EElQlnyTXOnj6+RRg6+cXN9JIjnCTq18qQiY4QD/z8wgWrz
	 0KzhBygungIUmGzpd5z5lif2ejwBzNcyTNcuGxUDbIV/rczig70ERhaai6yRjeVw6N
	 5S4oaAKnymk7ejihJkJVygrWJLuclpPKJuQJ7Rpk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgETXkj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 19:40:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:35440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726747AbgETXkj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 19:40:39 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5825B2072C;
        Wed, 20 May 2020 23:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590018038;
        bh=yJQr4N2gMImcjIgh4e+Nb6eX8prUZSgWAz7fgEAtjn8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uUzCdsJ4dPUOGOhbWC7K6acCbXeqRHR+0qzMhgjEOxgVke9kEnBa7JF5kx3vHFzK1
         2JDsO09C77U5VjEP7YTXkaq7ElxS7VohANm9CztE2bI+QoaSzLs8/SxR/44jb4IDIo
         fHiF99y61RmpcSRtu67jCykydgbedxtWxWl3l/8Y=
Date:   Wed, 20 May 2020 16:40:37 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Chris Down <chris@chrisdown.name>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: unify reclaim retry limits with page
 allocator
Message-Id: <20200520164037.e3598bc902e39415f4c263e7@linux-foundation.org>
In-Reply-To: <20200520163142.GA808793@chrisdown.name>
References: <20200520163142.GA808793@chrisdown.name>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020 17:31:42 +0100 Chris Down <chris@chrisdown.name> wrote:

> Reclaim retries have been set to 5 since the beginning of time in
> 66e1707bc346 ("Memory controller: add per cgroup LRU and reclaim").
> However, we now have a generally agreed-upon standard for page reclaim:
> MAX_RECLAIM_RETRIES (currently 16), added many years later in
> 0a0337e0d1d1 ("mm, oom: rework oom detection").
> 
> In the absence of a compelling reason to declare an OOM earlier in memcg
> context than page allocator context, it seems reasonable to supplant
> MEM_CGROUP_RECLAIM_RETRIES with MAX_RECLAIM_RETRIES, making the page
> allocator and memcg internals more similar in semantics when reclaim
> fails to produce results, avoiding premature OOMs or throttling.
> 
> ...
>
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -73,9 +73,6 @@ EXPORT_SYMBOL(memory_cgrp_subsys);
>  
>  struct mem_cgroup *root_mem_cgroup __read_mostly;
>  
> -/* The number of times we should retry reclaim failures before giving up. */

hm, what tree is this against?

> -#define MEM_CGROUP_RECLAIM_RETRIES	5
> -
>  /* Socket memory accounting disabled? */
>  static bool cgroup_memory_nosocket;
>  
> @@ -2386,7 +2383,7 @@ void mem_cgroup_handle_over_high(void)
>  	unsigned long pflags;
>  	unsigned long nr_reclaimed;
>  	unsigned int nr_pages = current->memcg_nr_pages_over_high;
> -	int nr_retries = MEM_CGROUP_RECLAIM_RETRIES;
> +	int nr_retries = MAX_RECLAIM_RETRIES;

I can't seem to find a tree in which mem_cgroup_handle_over_high() has
a local `nr_retries'.


