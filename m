Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E880C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F19152088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 00:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="NTXoNW75"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgE0Ay3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 20:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbgE0Ay1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 20:54:27 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DE1FC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 17:54:27 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id y1so7211392qtv.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 17:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PaGroF7rl6CB5WNnHZR73MzXpydl/91JGmUjVqLojKw=;
        b=NTXoNW75s8p04tFR2m0D3xDA/bZx9BCL9Fe21E3Ep7SQ7N6qeZdjnchB+TwTzErxv5
         Cy3avWsNBTDt1CjZNcLl5tZoHoe1JwbPHFIPMcp003ujYufE6gjHtulld0v9A2h88SwV
         Y098z4FYzE0Jvk1l+WsALGPlCTtnqM3m0WTwGOrhyHr5K4E6vRjx/i3LEfe3aAMrttQ0
         m5bL0GQm3C6zZd6MTTQQpuPmiZMaXrVtdUbRLYHQ+SlXasfzjnV3EjtQ8EmbULCm5lNy
         QYIZFjJy7QeHNYU9XZxPzSSigYFdFY2inS5hr34ac5nCAa1W6Oa7vuChNkaOyiJ0vXh+
         Znrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PaGroF7rl6CB5WNnHZR73MzXpydl/91JGmUjVqLojKw=;
        b=lF6orJvlhj/dWtPfVk6smcUlqyk8z/LXUqc4wNMll7jgyiV15RcLZLFniYekQCdluo
         uoyWfWhscwYleNxVsZPT5CkNgH5/nNtH0Oh2hHYSk16hdLlAsagRpgGSWAvy5U3CUzxP
         rmE3z2s0zNb2GU0ggNH3z6INzI0pKeBecd0fLaxMCuEPb/4Rrqh4wpYP/hZ1Uu+EQj/P
         4efpfAjVLFKdY7b1xXdvmTPXSyuFvnW3a7vawL8qoHd2q6QmzK5bkHJY4YFyoCqPprhu
         TGtulVHkfAk5BzEvedr5VuiuaCzSBCi+cbkbtzYsES0JPk1cGzGCy/DNLlqZ9bXyNj7C
         1sOQ==
X-Gm-Message-State: AOAM530FyAe/k1fh/7b/snhyJEk0dTgUBXN1oqGoGUS4QxUWH0DXeDrt
        yfQ8RRpWytxqZSvzzUMSTV/J5w==
X-Google-Smtp-Source: ABdhPJxCSzJWiFlU/+8D3dRsrxy2vIKu0/ZO+If1bo9m7nyaKM7+Uv6FWucpP0ovDJGMyxE0uUh9gg==
X-Received: by 2002:ac8:72ca:: with SMTP id o10mr1525951qtp.376.1590540866269;
        Tue, 26 May 2020 17:54:26 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 205sm1076319qkh.94.2020.05.26.17.54.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 17:54:25 -0700 (PDT)
Date:   Tue, 26 May 2020 20:54:23 -0400
From:   Qian Cai <cai@lca.pw>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     linux-mm@kvack.org, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan.kim@gmail.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH 09/14] mm: deactivations shouldn't bias the LRU balance
Message-ID: <20200527005423.GI991@lca.pw>
References: <20200520232525.798933-1-hannes@cmpxchg.org>
 <20200520232525.798933-10-hannes@cmpxchg.org>
 <20200522133335.GA624@Qians-MacBook-Air.local>
 <20200526155549.GB850116@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526155549.GB850116@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 11:55:49AM -0400, Johannes Weiner wrote:
> > mm/swap.c: In function 'lru_deactivate_file_fn':
> > mm/swap.c:504:11: warning: variable 'file' set but not used
> > [-Wunused-but-set-variable]
> >   int lru, file;
> >            ^~~~ 
> 
> Oops, my gcc doesn't warn about that, but yes, it's clearly dead code.

You will probably need W=1 to see that.

> 
> $ make mm/swap.o
>   GEN     Makefile
>   CALL    /home/hannes/src/linux/linux/scripts/checksyscalls.sh
>   CALL    /home/hannes/src/linux/linux/scripts/atomic/check-atomics.sh
>   DESCEND  objtool
>   CC      mm/swap.o
> $
>  
> > This?
> > 
> > diff --git a/mm/swap.c b/mm/swap.c
> > index fedf5847dfdb..9c38c1b545af 100644
> > --- a/mm/swap.c
> > +++ b/mm/swap.c
> > @@ -501,7 +501,7 @@ void lru_cache_add_active_or_unevictable(struct page *page,
> >  static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
> >  			      void *arg)
> >  {
> > -	int lru, file;
> > +	int lru;
> >  	bool active;
> >  
> >  	if (!PageLRU(page))
> > @@ -515,7 +515,6 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec,
> >  		return;
> >  
> >  	active = PageActive(page);
> > -	file = page_is_file_lru(page);
> >  	lru = page_lru_base_type(page);
> >  
> >  	del_page_from_lru_list(page, lruvec, lru + active);
> 
> Looks good, and it appears Andrew has already queued it. Would you
> mind providing the Signed-off-by: for it?

Don't worry about that. I believe Andrew will squash it when sending to
Linus.
