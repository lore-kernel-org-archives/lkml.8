Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88274C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:06:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D73022BEA
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 15:06:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="xVA3qKqV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731321AbgGaPGE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728697AbgGaPGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 11:06:03 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8444C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:06:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 2so24927008qkf.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 08:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ff/aO+f/ar+IJTfIhhVDXCQGW8FBVjjCHNkbg+nD/8E=;
        b=xVA3qKqVLrnkHInB3M7U9/5AssU33ep3UEX72ANbYHcwn7OdX9zg75cCCV7x/K2nNa
         b1BIUmYVhQ7WXkyZkU20DceV3dopjAeMrAqc2guZzTsxJinRGmeOl9Ymg0mAxJlfZqyX
         dwYhfdty5kF+PHCke0BmgkWLyX4hgJK6CLfLeqvkyR/Mg0M3JCELG8YsRUM4qlT+X8Qj
         9dTTHJrGLhq3YOeye2px9l1Reimwbd2nbkT2ixMLy2gWMOJOSQYVmNt5m4cCvztQvyg3
         HRo6Eepk55mVeW4q8dcoYYcxuHuazDbeAHUB8zx6SZfLv8OH7zA/kqP9jAj1lVyy234I
         Vr2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ff/aO+f/ar+IJTfIhhVDXCQGW8FBVjjCHNkbg+nD/8E=;
        b=qwsYix9lmMyCOE8uf8w/802ZOOdyAAnaf51Ivji1bvQvMqaafvzilxf7dTlTjlFqzX
         huiIMfbsyBYUCmjOSrF80PzCuLw2TZnOMyQmTX5aVAEcemmyCv4MT/zfI0flxprbS0hg
         2CTvUeEwaLyPZaeCaTzT9FlpeO3oYIJCijqHGZAiPsrzocEFtNho5YItyvUFBU1hVyEX
         k5zTJlO2ZiceK6nQUaGz848F7fDA+7Jg8+7N6nF/TOFg/3N9YtqTgq/Sy0q5j21lUvIA
         IdQ8Yu9SybBPjHHOwsZkDBCbdxomSW55YQPR04N/yOC8FSbB/F7IoFmWhlsizzRboP3x
         6k4w==
X-Gm-Message-State: AOAM5314wKgit+372PRZjMsDphrG6A6QKc2YUbadQZ5WnESKZ2/6VirG
        072hPH+OYysBl6fGyg+TTGyJBg==
X-Google-Smtp-Source: ABdhPJyYC8OqkZDjHQjI3v8OFXelR/mP7jiMXshyCjcyGLjZUbGbO6kTuC3G6P9+J6dJzwTGPGUOcA==
X-Received: by 2002:a37:a0d3:: with SMTP id j202mr4242255qke.365.1596207961101;
        Fri, 31 Jul 2020 08:06:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:11a4])
        by smtp.gmail.com with ESMTPSA id w11sm9365133qtc.58.2020.07.31.08.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:06:00 -0700 (PDT)
Date:   Fri, 31 Jul 2020 11:04:58 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH mmotm] mm: memcontrol: decouple reference counting from
 page accounting fix
Message-ID: <20200731150458.GA491801@cmpxchg.org>
References: <alpine.LSU.2.11.2007302011450.2347@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.2007302011450.2347@eggly.anvils>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:17:50PM -0700, Hugh Dickins wrote:
> Moving tasks between mem cgroups with memory.move_charge_at_immigrate 3,
> while swapping, crashes soon on mmotm (and so presumably on linux-next):
> for example, spinlock found corrupted when lock_page_memcg() is called.
> It's as if the mem cgroup structures have been freed too early.
> 
> Stab in the dark: what if all the accounting is right, except that the
> css_put_many() in __mem_cgroup_clear_mc() is now (worse than) redundant?
> Removing it fixes the crashes, but that's hardly surprising; and stats
> temporarily hacked into mem_cgroup_css_alloc() and mem_cgroup_css_free()
> showed that mem cgroups were not being leaked with this change.
> 
> Note: this removes the last call to css_put_many() from the tree; and
> mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-accounted-allocations.patch
> removes the last call to css_get_many(): now that their last references
> have gone, I expect them soon to be freed from include/linux/cgroup.h.
> 
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks, Hugh. This fix looks correct to me.

And I'd agree with the put being worse than redundant. Its counterpart
in try_charge() has been removed, so this a clear-cut ref imbalance.

When moving a task between cgroups, we scan the page tables for pages
and swap entries, and then pre-charge the target group while we're
still allowed to veto the task move (can_attach). In the actual attach
step we then reassign all the pages and swap entries and balance the
books in the cgroup the task emigrated from.

That precharging used to acquire css references for every page charge
and swap entry charge when calling try_charge(). That is gone. Now we
move css references along with the page (move_account), and swap
entries use the mem_cgroup_id references which pin the css indirectly.

Leaving that css_put_many behind in the swap path was an oversight.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

> ---
> Fixes mm-memcontrol-decouple-reference-counting-from-page-accounting.patch
> 
>  mm/memcontrol.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> --- mmotm/mm/memcontrol.c	2020-07-27 18:55:00.700554752 -0700
> +++ linux/mm/memcontrol.c	2020-07-30 12:05:00.640091618 -0700
> @@ -5887,8 +5887,6 @@ static void __mem_cgroup_clear_mc(void)
>  		if (!mem_cgroup_is_root(mc.to))
>  			page_counter_uncharge(&mc.to->memory, mc.moved_swap);
>  
> -		css_put_many(&mc.to->css, mc.moved_swap);
> -
>  		mc.moved_swap = 0;
>  	}
>  	memcg_oom_recover(from);
