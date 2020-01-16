Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F171C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 318EC20728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 22:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pZIi5sE/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389668AbgAPWCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:02:02 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:39521 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388162AbgAPWCC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 17:02:02 -0500
Received: by mail-pj1-f66.google.com with SMTP id e11so2308240pjt.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 14:02:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=3l1bLmmeM9s291uP94O9U/aPjNKzd/SwoB7qzxFa1R0=;
        b=pZIi5sE/9TH17JjoL4l5dJZZrLpm7nc9kqlJkmnnzJuXTFlpU/YTZtduls0CTZLNQm
         E6ll5YpO8ByoE0nF7TJYBSt49NmIhu3tapebJ0GHzTHlrn11c9dfl4pg11YGNTtRTxRR
         g6ct6R0KdTbp94x6U595KvssLi8FgrCtpq3PPgsq7ZGsbVAGcsoE8WV0gRTaMptR7kLu
         Avzv6iRXqtNfuUucdsVE8Dx8aZKT07u4EELR1eoXNKnKFbnCN1FSuHa3xuv9FxuzLVhY
         UCe+3l+fC3JBlJNBgau4SWMziDCNmnvE5ZBSRsIY9lzxnRJqtiLV5b10eh8jS8HfF/jk
         VwwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=3l1bLmmeM9s291uP94O9U/aPjNKzd/SwoB7qzxFa1R0=;
        b=csJNNQtRevc8NyFon7W6CUlquIV4z/ETFYyi2noJed1f3gw1fcrbgWHg3qfTFAvF4g
         sjv4LOVoRdWIjHaW6XV7DOZlJi7YOlelgs9Ys94CbL55N31Q5h/WZ42lphLNVLcLVuh/
         73Y42kAmNmig2IA/39R+JUCT26khhryqLLxYj3Dc8wfoX0hFWK/WsY38aTihBnFcW4bJ
         jhdBfRwsFoJrnNOiMFT5Tq3WZ+pmhDqZG0/ezGjlMKgWl6kPvsqfAz05IHHeFeEBN55j
         P99UALE/PDxLAtLNKCy4g0aNFfou3bjCC1L4e6rl3R1EWFnolqRGGllAa4it6wHaEoY4
         +irg==
X-Gm-Message-State: APjAAAWuVvjV6MCBOYPX4r1A34B01/uyWKANFCPxPWn4JZU2BECiia/m
        Fzmpq4GKN+/WGW3od3XiFLnCcw==
X-Google-Smtp-Source: APXvYqzz/Iq1AFC0H0qPvPoBp1sq2GZeTe9qAtImzX2gAXb3xw+Gl7BruUV5FjWVCYBAKEETDQCciw==
X-Received: by 2002:a17:90a:238b:: with SMTP id g11mr1756480pje.128.1579212121109;
        Thu, 16 Jan 2020 14:02:01 -0800 (PST)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id v4sm26425893pff.174.2020.01.16.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 14:02:00 -0800 (PST)
Date:   Thu, 16 Jan 2020 14:01:59 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
cc:     Wei Yang <richardw.yang@linux.intel.com>, hannes@cmpxchg.org,
        mhocko@kernel.org, vdavydov.dev@gmail.com,
        akpm@linux-foundation.org, kirill.shutemov@linux.intel.com,
        yang.shi@linux.alibaba.com, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        alexander.duyck@gmail.com, stable@vger.kernel.org
Subject: Re: [Patch v3] mm: thp: grab the lock before manipulation defer
 list
In-Reply-To: <0bb34c4a-97c7-0b3c-cf43-8af6cf9c4396@virtuozzo.com>
Message-ID: <alpine.DEB.2.21.2001161357240.109233@chino.kir.corp.google.com>
References: <20200116013100.7679-1-richardw.yang@linux.intel.com> <0bb34c4a-97c7-0b3c-cf43-8af6cf9c4396@virtuozzo.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020, Kirill Tkhai wrote:

> > diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> > index c5b5f74cfd4d..6450bbe394e2 100644
> > --- a/mm/memcontrol.c
> > +++ b/mm/memcontrol.c
> > @@ -5360,10 +5360,12 @@ static int mem_cgroup_move_account(struct page *page,
> >  	}
> >  
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -	if (compound && !list_empty(page_deferred_list(page))) {
> > +	if (compound) {
> >  		spin_lock(&from->deferred_split_queue.split_queue_lock);
> > -		list_del_init(page_deferred_list(page));
> > -		from->deferred_split_queue.split_queue_len--;
> > +		if (!list_empty(page_deferred_list(page))) {
> > +			list_del_init(page_deferred_list(page));
> > +			from->deferred_split_queue.split_queue_len--;
> > +		}
> >  		spin_unlock(&from->deferred_split_queue.split_queue_lock);
> >  	}
> >  #endif
> > @@ -5377,11 +5379,13 @@ static int mem_cgroup_move_account(struct page *page,
> >  	page->mem_cgroup = to;
> >  
> >  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> > -	if (compound && list_empty(page_deferred_list(page))) {
> > +	if (compound) {
> >  		spin_lock(&to->deferred_split_queue.split_queue_lock);
> > -		list_add_tail(page_deferred_list(page),
> > -			      &to->deferred_split_queue.split_queue);
> > -		to->deferred_split_queue.split_queue_len++;
> > +		if (list_empty(page_deferred_list(page))) {
> > +			list_add_tail(page_deferred_list(page),
> > +				      &to->deferred_split_queue.split_queue);
> > +			to->deferred_split_queue.split_queue_len++;
> > +		}
> >  		spin_unlock(&to->deferred_split_queue.split_queue_lock);
> >  	}
> >  #endif
> 
> The patch looks OK for me. But there is another question. I forget, why we unconditionally
> add a page with empty deferred list to deferred_split_queue. Shouldn't we also check that
> it was initially in the list? Something like:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d4394ae4e5be..0be0136adaa6 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5289,6 +5289,7 @@ static int mem_cgroup_move_account(struct page *page,
>  	struct pglist_data *pgdat;
>  	unsigned long flags;
>  	unsigned int nr_pages = compound ? hpage_nr_pages(page) : 1;
> +	bool split = false;
>  	int ret;
>  	bool anon;
>  
> @@ -5346,6 +5347,7 @@ static int mem_cgroup_move_account(struct page *page,
>  		if (!list_empty(page_deferred_list(page))) {
>  			list_del_init(page_deferred_list(page));
>  			from->deferred_split_queue.split_queue_len--;
> +			split = true;
>  		}
>  		spin_unlock(&from->deferred_split_queue.split_queue_lock);
>  	}
> @@ -5360,7 +5362,7 @@ static int mem_cgroup_move_account(struct page *page,
>  	page->mem_cgroup = to;
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	if (compound) {
> +	if (compound && split) {
>  		spin_lock(&to->deferred_split_queue.split_queue_lock);
>  		if (list_empty(page_deferred_list(page))) {
>  			list_add_tail(page_deferred_list(page),
> 

I think that's a good point, especially considering that the current code 
appears to unconditionally place any compound page on the deferred split 
queue of the destination memcg.  The correct list that it should appear 
on, I believe, depends on whether the pmd has been split for the process 
being moved: note the MC_TARGET_PAGE caveat in 
mem_cgroup_move_charge_pte_range() that does not move the charge for 
compound pages with split pmds.  So when mem_cgroup_move_account() is 
called with compound == true, we're moving the charge of the entire 
compound page: why would it appear on that memcg's deferred split queue?
