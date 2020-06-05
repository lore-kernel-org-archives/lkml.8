Return-Path: <SRS0=RcPI=7S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE159C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:54:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03442074B
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Jun 2020 19:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591386876;
	bh=G+SSBx/UKBlLcc1nO11T4/f9U6aPZkjLR6i8uZy0mrY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OMWXPF+DIXMfLWaQW8WAo3xfn2+0plyBmQQyZpr3nA9DpCgVXFXJuZAXnPGFwen+5
	 oUjx0wi2axRxQTrCy3Jdoa/X2ryZFgc2r7Ou0dxPHhsPO2oipwmFImCdXnttgewCjN
	 L3UIQqUib62gfWaSZoSdfDPfr9VtMsGdGGqqOE04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFETyf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Jun 2020 15:54:35 -0400
Received: from mail-vk1-f194.google.com ([209.85.221.194]:37706 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727868AbgFETyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Jun 2020 15:54:35 -0400
Received: by mail-vk1-f194.google.com with SMTP id q10so2509317vka.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Jun 2020 12:54:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eoNDjiLxnZFOoKofg0UiPpVw3AEPVkrGeLXDTLig/ac=;
        b=YC14zf8WER2BRJNWENwTMO914Bt+CGe8bt3cWgGkTJKptHPrnV2qchOuNpPO3qE7l7
         LDjLc/N4Vrq/iwGIHIsHnqMXIUiBAjSEuFG7/3svIiLpqtU55MVl7L4Wh/OvqqUyVR20
         gf2Cgdn4Z8dxxmRjKFDR9CzsxVCq6X9G0ViBrzAIOx/54aCeJIHwBhGiAy6crZrZMn7t
         DjlLK6SalAEO1bhgUrJTv39XwzIpnqvrHwCGmjrNL3PG+pODtDrqSUfoMaCEU4HWMhhH
         JS6pAcNCvPwVZSVFW04Fduy7X2HzAPzZ9+VSUz0O2DIzGBAnMY4Oy6+qXtAX6qRecf1C
         e6uw==
X-Gm-Message-State: AOAM533nYcaiIT7SFr2lSMaWjHZyb7wku9GEiO5S+QYyKnyd/efcJBkw
        cQq/uXlQpdkcmZpCSInwJGA=
X-Google-Smtp-Source: ABdhPJy9hvHCUWEFbe3TvhNWj30EnQfrd2tbCf0vh3zvo0mKUWtKa3WFPn0nIRX/z+jo9C3knn3fow==
X-Received: by 2002:a1f:1a4b:: with SMTP id a72mr8597414vka.0.1591386874115;
        Fri, 05 Jun 2020 12:54:34 -0700 (PDT)
Received: from google.com (239.145.196.35.bc.googleusercontent.com. [35.196.145.239])
        by smtp.gmail.com with ESMTPSA id i2sm1271978vkp.22.2020.06.05.12.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 12:54:33 -0700 (PDT)
Date:   Fri, 5 Jun 2020 19:54:32 +0000
From:   Dennis Zhou <dennis@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
Message-ID: <20200605195432.GD224745@google.com>
References: <20200528232508.1132382-1-guro@fb.com>
 <20200528232508.1132382-5-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528232508.1132382-5-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 04:25:07PM -0700, Roman Gushchin wrote:
> Memory cgroups are using large chunks of percpu memory to store
> vmstat data. Yet this memory is not accounted at all, so in the
> case when there are many (dying) cgroups, it's not exactly clear
> where all the memory is.
> 
> Because the size of  memory cgroup internal structures can
> dramatically exceed the size of object or page which is pinning
> it in the memory, it's not a good idea to simple ignore it.
> It actually breaks the isolation between cgroups.
> 
> Let's account the consumed percpu memory to the parent cgroup.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 5007d1585a4a..0dd0d05a011c 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5020,13 +5020,15 @@ static int alloc_mem_cgroup_per_node_info(struct mem_cgroup *memcg, int node)
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
> @@ -5100,11 +5102,13 @@ static struct mem_cgroup *mem_cgroup_alloc(void)
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
> @@ -5153,7 +5157,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
>  	struct mem_cgroup *memcg;
>  	long error = -ENOMEM;
>  
> +	memalloc_use_memcg(parent);
>  	memcg = mem_cgroup_alloc();
> +	memalloc_unuse_memcg();
>  	if (IS_ERR(memcg))
>  		return ERR_CAST(memcg);
>  
> -- 
> 2.25.4
> 

Acked-by: Dennis Zhou <dennis@kernel.org>

Thanks,
Dennis
