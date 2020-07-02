Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6770BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:22:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4870120720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593706929;
	bh=W4UDlZ49OH/LiR6KPai/u3hFCRS917Sr4olT+AYboSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QbDoA6y8TXahqiBlmaCLLyPxk1qRpP+n2eeBN9gKGnaIp1+nUSAUoeLXWaPXqyoUP
	 Ehizh+CZPR1G/13mWty44PtygeuWBFZHA+t0Ri0HkclMvXPjljo+/WdY+ZnZz6DxaC
	 Id2/xDp1iTK9cK6O2a0uaCjkKFSxa3cm2U04VAsY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGBQWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:22:07 -0400
Received: from mail-ej1-f68.google.com ([209.85.218.68]:45716 "EHLO
        mail-ej1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgGBQWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:22:07 -0400
Received: by mail-ej1-f68.google.com with SMTP id a1so30443425ejg.12
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 09:22:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DbONkljCM39wKkgdtWGmPLeGjsUj+0c2PNnDTJ43lyE=;
        b=dXWgSWCGeaj8Uyc3ccn94fJw5oC64tl73Y2gQ56e6RVxqEecezu/49glx5H233wDyC
         zWXJxpICrj5kmNEEKWoCXoAMhYqiJH+n106iF7Bd+HArBc7ZNIquVSQ9RUloXeKi/YYq
         +Vzw7BfdFKYK9wFL6d6ZTbkXGai2wBlBRiGBI4BW1jfnuGVwbO2AOVME0DtKW4/ZTBh2
         41lSefZKu8ps2MASjnhAoq+eHZV7xVg3PfkbrLFRupw7KTkogj5fJltMGBwJiRyzLOEd
         c1PEvHICGLSGNblrsGsNBmIX5QAMdZw0as005oYwfGuJ3PNKotxhjqiiXaqr2ZwxxlIM
         vpzQ==
X-Gm-Message-State: AOAM532mz0MxFuYp/bZOwFLIXcZkvW69ne7t5f3kwoM618RD0aJoomcK
        JFo9Il66nnueCmST9Hctszk=
X-Google-Smtp-Source: ABdhPJze2ZMZ0MDoXSjpdzX64hRtOQvPYmu7AUSBq83pqDgkSzXYEiHjyrtKf4ubrt1bltK8bZQagg==
X-Received: by 2002:a17:906:7686:: with SMTP id o6mr29370028ejm.326.1593706925426;
        Thu, 02 Jul 2020 09:22:05 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id q7sm7261247eja.69.2020.07.02.09.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 09:22:04 -0700 (PDT)
Date:   Thu, 2 Jul 2020 18:22:02 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
Message-ID: <20200702162202.GI18446@dhcp22.suse.cz>
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz>
 <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 01-07-20 11:45:52, Roman Gushchin wrote:
[...]
> >From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 1 Jul 2020 11:05:32 -0700
> Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
> 
> Historically the kernel memory accounting was an opt-in feature, which
> could be enabled for individual cgroups. But now it's not true, and
> it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> user has at least one non-root memory cgroup, the kernel memory
> accounting is on. So in most setups it's either always on (if memory
> cgroups are in use and kmem accounting is not disabled), either always
> off (otherwise).
> 
> memcg_kmem_enabled() is used in many places to guard the kernel memory
> accounting code. If memcg_kmem_enabled() can reverse from returning
> true to returning false (as now), we can't rely on it on release paths
> and have to check if it was on before.
> 
> If we'll make memcg_kmem_enabled() irreversible (always returning true
> after returning it for the first time), it'll make the general logic
> more simple and robust. It also will allow to guard some checks which
> otherwise would stay unguarded.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> ---
>  mm/memcontrol.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 50ae77f3985e..2d018a51c941 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -3582,7 +3582,8 @@ static int memcg_online_kmem(struct mem_cgroup *memcg)
>  	objcg->memcg = memcg;
>  	rcu_assign_pointer(memcg->objcg, objcg);
>  
> -	static_branch_inc(&memcg_kmem_enabled_key);
> +	if (!memcg_kmem_enabled())
> +		static_branch_inc(&memcg_kmem_enabled_key);

Wouldn't be static_branch_enable() more readable?

>  	/*
>  	 * A memory cgroup is considered kmem-online as soon as it gets
>  	 * kmemcg_id. Setting the id after enabling static branching will
> @@ -3643,9 +3644,6 @@ static void memcg_free_kmem(struct mem_cgroup *memcg)
>  	/* css_alloc() failed, offlining didn't happen */
>  	if (unlikely(memcg->kmem_state == KMEM_ONLINE))
>  		memcg_offline_kmem(memcg);
> -
> -	if (memcg->kmem_state == KMEM_ALLOCATED)
> -		static_branch_dec(&memcg_kmem_enabled_key);
>  }
>  #else
>  static int memcg_online_kmem(struct mem_cgroup *memcg)
> -- 
> 2.26.2

-- 
Michal Hocko
SUSE Labs
