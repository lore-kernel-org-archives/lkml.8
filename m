Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48625C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C3A20CC7
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 19:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="LktNJs6w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgBCTxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 14:53:34 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34601 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 14:53:34 -0500
Received: by mail-qt1-f194.google.com with SMTP id h12so12477608qtu.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 11:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Tg9AEPjwHF9SzQm7/+VD4BLr83zEfWvtOKbloqzkYR8=;
        b=LktNJs6wHQ6rCBrdTj45rfZkoSxgswrqWizRzWa5zrzlBSsMuWAm9UIPkK6wGbq8aA
         Jn9uM3xeWbvmYpEQGW2xJMYZzrlWaDEX+P1uApDUPcWujm8yhNDVNpSLYoGdK04556Lm
         luz+sPx7H6fzR1i6EOJpjOdKmg5UkJD4CDL18KhiPPYEB1sJxsOct8eC+ovIXgHqSWun
         JyzLth2dfq7lLeiSL0kODvo6U2J3CXls0jiHcS+knnRqf5rqX/B+guH44M7CXgzUXVPP
         6i2QqnvE+/RcJHUPxFQW6y3uvjy0EpCAJ8RWxJbIsTkLbMfM4lR2JMJpVChPBL7VCYsU
         zsGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Tg9AEPjwHF9SzQm7/+VD4BLr83zEfWvtOKbloqzkYR8=;
        b=DaNc9LlrJUeoyqya9TZRJLrKX6VYYLDpSH3RAxa6NHNAfgzGttHYBADo3EKMbiK5SF
         M47nqbK7lUK/is84CsTstx72P5r0M6/cwwLKRPhNC4FCSKGFZvf1dF1s18vfx2tgKXtV
         /ljge+LqFVXoaRXsIVr4yZS50vxziHKizWTQtZzNyJSP0yNTZ8A3aErJsSV3Ru0zZEFq
         pqcNP+6wjWCGAVM3v3r1E2X8k7x61sD+24jCTw+R1A7lw/13/VUdwPgua2w2DA80+VkP
         pBzL5plK5i+5MeCeL65wE9dQN4FfipNpCte+/COVAx+/dWuTFbF7QRtmHfoqr34/+NLV
         A1lQ==
X-Gm-Message-State: APjAAAWBjIdAsZpq+TYxLE11MIjxlX3ZSV2QFUAnMHHiLdUjQ3JYLYLA
        2WwmwdCJeC6c9Yp9/JtC3xPZVQ==
X-Google-Smtp-Source: APXvYqw4M2if1fYGbOJyF3RGiD+07i2yIoXnqs4pXRy5lRiylx/TmRICoQj3WNP7+zcwMoOWVlR7oA==
X-Received: by 2002:ac8:390a:: with SMTP id s10mr24850033qtb.31.1580759613137;
        Mon, 03 Feb 2020 11:53:33 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id 201sm9950888qkf.10.2020.02.03.11.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 11:53:32 -0800 (PST)
Date:   Mon, 3 Feb 2020 14:53:31 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 17/28] mm: memcg/slab: save obj_cgroup for non-root
 slab objects
Message-ID: <20200203195331.GB4396@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-18-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200127173453.2089565-18-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 09:34:42AM -0800, Roman Gushchin wrote:
> Store the obj_cgroup pointer in the corresponding place of
> page->obj_cgroups for each allocated non-root slab object.
> Make sure that each allocated object holds a reference to obj_cgroup.
> 
> Objcg pointer is obtained from the memcg->objcg dereferencing
> in memcg_kmem_get_cache() and passed from pre_alloc_hook to
> post_alloc_hook. Then in case of successful allocation(s) it's
> getting stored in the page->obj_cgroups vector.
> 
> The objcg obtaining part look a bit bulky now, but it will be simplified
> by next commits in the series.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  include/linux/memcontrol.h |  3 +-
>  mm/memcontrol.c            | 14 +++++++--
>  mm/slab.c                  | 18 +++++++-----
>  mm/slab.h                  | 60 ++++++++++++++++++++++++++++++++++----
>  mm/slub.c                  | 14 +++++----
>  5 files changed, 88 insertions(+), 21 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index 30bbea3f85e2..54bfb26b5016 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -1431,7 +1431,8 @@ static inline void memcg_set_shrinker_bit(struct mem_cgroup *memcg,
>  }
>  #endif
>  
> -struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep);
> +struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
> +					struct obj_cgroup **objcgp);
>  void memcg_kmem_put_cache(struct kmem_cache *cachep);
>  
>  #ifdef CONFIG_MEMCG_KMEM
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 94337ab1ebe9..0e9fe272e688 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -2896,7 +2896,8 @@ static inline bool memcg_kmem_bypass(void)
>   * done with it, memcg_kmem_put_cache() must be called to release the
>   * reference.
>   */
> -struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
> +struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep,
> +					struct obj_cgroup **objcgp)
>  {
>  	struct mem_cgroup *memcg;
>  	struct kmem_cache *memcg_cachep;
> @@ -2952,8 +2953,17 @@ struct kmem_cache *memcg_kmem_get_cache(struct kmem_cache *cachep)
>  	 */
>  	if (unlikely(!memcg_cachep))
>  		memcg_schedule_kmem_cache_create(memcg, cachep);
> -	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt))
> +	else if (percpu_ref_tryget(&memcg_cachep->memcg_params.refcnt)) {
> +		struct obj_cgroup *objcg = rcu_dereference(memcg->objcg);
> +
> +		if (!objcg || !obj_cgroup_tryget(objcg)) {
> +			percpu_ref_put(&memcg_cachep->memcg_params.refcnt);
> +			goto out_unlock;
> +		}

As per the reply to the previous patch: I don't understand why the
objcg requires a pulse check here. As long as the memcg is alive and
can be charged with memory, how can the objcg disappear?
