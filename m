Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 006FCC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5B9022B42
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 23:40:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mqCQBH9v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728009AbgG2Xkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 19:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbgG2Xkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 19:40:45 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEFBC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:40:45 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id a9so2908356pjd.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ehka3Bw+qd9RU1NQVDq9GEs2det9sBZFzS6S/ACMdzA=;
        b=mqCQBH9vMHhimagKysVjN9pVeYMzrPOTA5ICK+rRv5APsM1O7Hptx0qoD/CSJ1A8Da
         n4hoN2jH/nJCLkamRiv7OdvcLtd8lqgPZIGkeLgqiPT8RMisVPsLQOXgN9klc1YnP75y
         dwikCB+pB1/CN52Wm++Hlq2jC5eicp0lpCaRLBo6usz5UXcHSlV1BwOYzmCtFMl0PjOI
         3M2YNMRfnRNItbbPlUgMs4q38Kdk4fqjb9Iavq5kPuGr2CnzHB/NUyLHpPIZtxE3nuR9
         LRkr6ApHxjUGcYzeWQCrzG/396tzmLd3Ye4k/bBxNzsDe4l93mGr/IuzGJJR2XEH872F
         ThRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ehka3Bw+qd9RU1NQVDq9GEs2det9sBZFzS6S/ACMdzA=;
        b=Kf1ZA9SQbIGRS+44bLvsA8WMhqixnGBGDYb1zoK4Cvp3mErYVnaGwwFhXxOvmd/eIw
         HftL25OwslL8CMIL9B1KXycufLLa5suDsdl6h0n7FXVCA3wVuH3/vDOXa8mCfjJLS1Xj
         nbwo+NgRX4yunI7ipnU09GBXQeOdOcq8/1JNo6GpJzPGkkbeIIHM0sRQEedUEEXUQhol
         O6TcorqEoKdPZ0iylZmnrWTdYTrA7bUUHMz1fI4B3iPbhbxdqDItpI1cjPiU4hrEmO2A
         EPmyylO5tUYW21XySTuBK6OsfiezdDP/o/W6i0t1pkyoZN3OJeue+KlBYkQ7RS20PChX
         /EZg==
X-Gm-Message-State: AOAM531KDWwgdIvK4Zl2dbFiyPqTOQxzO0zT6p3GD+zuNxkAaEY6qw1w
        1zN8tsjGpBSFV+Y+zSA5oFSVJw==
X-Google-Smtp-Source: ABdhPJxJSNtCj/X3Tb+Q37+Ym+uH8rDguC9MqpnlzO9RvztZlOCocJLBoapccfc1XEhib+ITKb8rAg==
X-Received: by 2002:a17:902:7c8b:: with SMTP id y11mr28788386pll.142.1596066044318;
        Wed, 29 Jul 2020 16:40:44 -0700 (PDT)
Received: from [2620:15c:17:3:4a0f:cfff:fe51:6667] ([2620:15c:17:3:4a0f:cfff:fe51:6667])
        by smtp.gmail.com with ESMTPSA id m190sm2051252pfm.89.2020.07.29.16.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 16:40:43 -0700 (PDT)
Date:   Wed, 29 Jul 2020 16:40:42 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Qianli Zhao <zhaoqianligood@gmail.com>,
        Roman Gushchin <guro@fb.com>
cc:     cl@linux.com, penberg@kernel.org, iamjoonsoo.kim@lge.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        zhaoqianli@xiaomi.com
Subject: Re: [PATCH] mm: slab: Avoid the use of one-element array and use
 struct_size() helper
In-Reply-To: <1596034214-15010-1-git-send-email-zhaoqianligood@gmail.com>
Message-ID: <alpine.DEB.2.23.453.2007291640140.3120473@chino.kir.corp.google.com>
References: <1596034214-15010-1-git-send-email-zhaoqianligood@gmail.com>
User-Agent: Alpine 2.23 (DEB 453 2020-06-18)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="1482994552-2092936226-1596066043=:3120473"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1482994552-2092936226-1596066043=:3120473
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 29 Jul 2020, Qianli Zhao wrote:

> From: Qianli Zhao <zhaoqianli@xiaomi.com>
> 
> There is a regular need in the kernel to provide a way to declare having a
> dynamically sized set of trailing elements in a structure. Kernel code should
> always use “flexible array members”[1] for these cases. The older style of
> one-element or zero-length arrays should no longer be used[2].
> 
> Make use of the struct_size() helper instead of an open-coded version
> in order to avoid any potential type mistakes.
> 
> [1] https://en.wikipedia.org/wiki/Flexible_array_member
> [2] https://github.com/KSPP/linux/issues/21
> 
> Signed-off-by: Qianli Zhao <zhaoqianli@xiaomi.com>
> ---
>  mm/slab.h        | 2 +-
>  mm/slab_common.c | 7 ++-----
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 74f7e09..c12fb65 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -34,7 +34,7 @@ struct kmem_cache {
>  
>  struct memcg_cache_array {
>  	struct rcu_head rcu;
> -	struct kmem_cache *entries[0];
> +	struct kmem_cache *entries[];
>  };
>  
>  /*

This is removed in the -mm tree, see 
https://www.ozlabs.org/~akpm/mmotm/broken-out/mm-memcg-slab-use-a-single-set-of-kmem_caches-for-all-allocations.patch

> diff --git a/mm/slab_common.c b/mm/slab_common.c
> index fe8b684..56f4818 100644
> --- a/mm/slab_common.c
> +++ b/mm/slab_common.c
> @@ -166,9 +166,7 @@ static int init_memcg_params(struct kmem_cache *s,
>  	if (!memcg_nr_cache_ids)
>  		return 0;
>  
> -	arr = kvzalloc(sizeof(struct memcg_cache_array) +
> -		       memcg_nr_cache_ids * sizeof(void *),
> -		       GFP_KERNEL);
> +	arr = kvzalloc(struct_size(arr, entries, memcg_nr_cache_ids), GFP_KERNEL);
>  	if (!arr)
>  		return -ENOMEM;
>  
> @@ -199,8 +197,7 @@ static int update_memcg_params(struct kmem_cache *s, int new_array_size)
>  {
>  	struct memcg_cache_array *old, *new;
>  
> -	new = kvzalloc(sizeof(struct memcg_cache_array) +
> -		       new_array_size * sizeof(void *), GFP_KERNEL);
> +	new = kvzalloc(struct_size(new, entries, new_array_size), GFP_KERNEL);
>  	if (!new)
>  		return -ENOMEM;
>  
> -- 
> 2.7.4
> 
> 
--1482994552-2092936226-1596066043=:3120473--
