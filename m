Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 784E8C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 484082078E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 15:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="O+oz/y94"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728976AbgHKP2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 11:28:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728859AbgHKP2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:28:43 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D408C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:28:43 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id y11so6126369qvl.4
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 08:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lgl2XWPxOkvTO1C8S88OrGJFzEG0BedRecFChwB3gY8=;
        b=O+oz/y94S7Ot2vFCIAFHszkvovBOf36KdyrH2IEJWc4M4iGAI+0vUVeb65yAePs+57
         DROlBFWLKmiEh+5yYPQAuZxOyCCI59rbE60yQsK/k5p+hCWZLwZuiio3saMyRdst9aN6
         W00Raq/cnhUCgHcCrtxHXZRE6zekJg2/KMflF2aaWNHLVuSUxA1oo1s4fEWzKninscH7
         +U1Bhx4SjBooCPa+GwTjN7sivvJ+csbnAYbo7Rsrvfg+DIRVEeLlRuCSag4yPLoeRdCG
         FufH0Ro9lxoInq9MGfEz5Pr+bqIIzZVDkYh86LTyBcauJu8KDfKElTqTqBT5krSr8MMX
         gq3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lgl2XWPxOkvTO1C8S88OrGJFzEG0BedRecFChwB3gY8=;
        b=N+fFL+f1fdgIxJO4ZEO8ipOTPh0LMqYgXNUiodz0URi5HoMa9BZYMyVBGz4hJhO0yl
         6aAe7+66/SWCHDL3qRVBZczN/Irv03sAWvcYhEciRyaBaHHLxdNRUYCPLGH2ZS66dcbJ
         Kw55A1+xuuymWtPbdAqR1Bef0We4/FpMAg86tJn5ioyh2gkjfVX+KxAa/AgWL6AkSVgy
         v2ZYOjzhyZlbYYTUQIOo1vJM/wv2MiGY9j2aAqamcOA5feh8Mr3YM8AixGEd1VcrdR8t
         kESy+TuYHyPcCtuzObn5Ahqw66jH2eG/2pe0MR/dSHjgrdVx8j7/3aA4XGEdoXfhxGCe
         tjow==
X-Gm-Message-State: AOAM532e01bO3jeCbV5DO0TSABSEJzQ0LDy32E0JKxmCJt2Nr2nxpXqd
        5+lUR88vA91vbwE4jAR1uP88mQ==
X-Google-Smtp-Source: ABdhPJwUsKgHMBfWAiaT6/HGMo7TWT1YWSQ7mkn2a8Es9KiyKcTAN0v8Enpnj6TS8l5TEuNaxVqYfA==
X-Received: by 2002:ad4:446d:: with SMTP id s13mr1833462qvt.183.1597159722398;
        Tue, 11 Aug 2020 08:28:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2dd0])
        by smtp.gmail.com with ESMTPSA id l189sm17003362qke.67.2020.08.11.08.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 08:28:41 -0700 (PDT)
Date:   Tue, 11 Aug 2020 11:27:37 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200811152737.GB650506@cmpxchg.org>
References: <20200623184515.4132564-1-guro@fb.com>
 <20200623184515.4132564-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623184515.4132564-5-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:45:14AM -0700, Roman Gushchin wrote:
> Memory cgroups are using large chunks of percpu memory to store vmstat
> data.  Yet this memory is not accounted at all, so in the case when there
> are many (dying) cgroups, it's not exactly clear where all the memory is.
> 
> Because the size of memory cgroup internal structures can dramatically
> exceed the size of object or page which is pinning it in the memory, it's
> not a good idea to simple ignore it.  It actually breaks the isolation
> between cgroups.
> 
> Let's account the consumed percpu memory to the parent cgroup.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Dennis Zhou <dennis@kernel.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>

This makes sense, and the accounting is in line with how we track and
distribute child creation quotas (cgroup.max.descendants and
cgroup.max.depth) up the cgroup tree.

I have one minor comment that isn't a dealbreaker for me:

> @@ -5069,13 +5069,15 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
>  	if (!pn)
>  		return 1;
>  
> -	pn->lruvec_stat_local = alloc_percpu(struct lruvec_stat);
> +	pn->lruvec_stat_local = alloc_percpu_gfp(struct lruvec_stat,
> +						 GFP_KERNEL_ACCOUNT);
>  	if (!pn->lruvec_stat_local) {
>  		kfree(pn);
>  		return 1;
>  	}
>  
> -	pn->lruvec_stat_cpu = alloc_percpu(struct lruvec_stat);
> +	pn->lruvec_stat_cpu = alloc_percpu_gfp(struct lruvec_stat,
> +					       GFP_KERNEL_ACCOUNT);
>  	if (!pn->lruvec_stat_cpu) {
>  		free_percpu(pn->lruvec_stat_local);
>  		kfree(pn);
> @@ -5149,11 +5151,13 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
>  		goto fail;
>  	}
>  
> -	memcg->vmstats_local = alloc_percpu(struct memcg_vmstats_percpu);
> +	memcg->vmstats_local = alloc_percpu_gfp(struct memcg_vmstats_percpu,
> +						GFP_KERNEL_ACCOUNT);
>  	if (!memcg->vmstats_local)
>  		goto fail;
>  
> -	memcg->vmstats_percpu = alloc_percpu(struct memcg_vmstats_percpu);
> +	memcg->vmstats_percpu = alloc_percpu_gfp(struct memcg_vmstats_percpu,
> +						 GFP_KERNEL_ACCOUNT);
>  	if (!memcg->vmstats_percpu)
>  		goto fail;
>  
> @@ -5202,7 +5206,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	struct mem_cgroup *memcg;
>  	long error = -ENOMEM;
>  
> +	memalloc_use_memcg(parent);
>  	memcg = mem_cgroup_alloc();
> +	memalloc_unuse_memcg();

The disconnect between 1) requesting accounting and 2) which cgroup to
charge is making me uneasy. It makes mem_cgroup_alloc() a bit of a
handgrenade, because accounting to the current task is almost
guaranteed to be wrong if the use_memcg() annotation were to get lost
in a refactor or not make it to a new caller of the function.

The saving grace is that mem_cgroup_alloc() is pretty unlikely to be
used elsewhere. And pretending it's an independent interface would be
overengineering. But how about the following in mem_cgroup_alloc() and
alloc_mem_cgroup_per_node_info() to document that caller relationship:

	/* We charge the parent cgroup, never the current task */
	WARN_ON_ONCE(!current->active_memcg);
