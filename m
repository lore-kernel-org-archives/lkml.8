Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34B1C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:19:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6579A222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583878785;
	bh=/Yfk9WtnoWVJ/U2E2kTwu3H9spimlOdAKv49aBQLHuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=egPbY0HgNgG+/bY5GzrQFNOMfCy0QNPgDw5t45i7EME6WO/Gyv2TpKVpxojOV/4+j
	 IJUYnDBf9ZDWNbZHJ+pEAy5ETB+4h/5rfb8Xj0eOf1pm3re9BD60eSZBh4XsBCnBPK
	 xZlhsboWGR1s319HQh/9+PTy0jDtJI3xYVQRtNKg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbgCJWTo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:19:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34696 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJWTn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:19:43 -0400
Received: by mail-wr1-f67.google.com with SMTP id z15so83296wrl.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:19:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8YYMvcq44BhLcSajpsg/HNjGZ5S6odZLEvG4zvpCcrA=;
        b=MEFv6TDH100fdQNctl+UM05OKrVUDTmHtfwAM1DqAv94145IgQOLWcvgYOJCV+nXIQ
         l36hItuhZUivFhOLPqTxtNj2KiNgtm3HD/6vM2o1fcfnKSoFNjBavEIbg/WelYBAOnkO
         Sil6/q0zMOrVy/Yk7Tp/93a1FNIMgUqH+Q3iamAo2V2C6QK7JA3Hvgs4y6OpiI8dX68T
         1DMqNOFnAx3v+fpGor7cx2TAXp5PyWdm717e7NigSykbc+EDGvtb3kINMOBfXbgMXT7f
         DoBTY/9NK25vsG8TEgasd2nDLql8LhP4jaKC7i4LWIRyBcHc/U2E0aVOxf7wtNJPmgwM
         QnRg==
X-Gm-Message-State: ANhLgQ3owO8NHPrXhmM1zHpk3JiOmA/VefFt6lYvgdyvvsD1KFsZTquu
        2YXSC/2qE8WGnR64U3Ne10qeXTsH/7M=
X-Google-Smtp-Source: ADFU+vs6ekMje5xysr+W5uQbBCABjFxaf+IU/6zPEo0KmG9ptNpnuYl5xtK/J+siEw/iWMvcowthnQ==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr56234wru.22.1583878780380;
        Tue, 10 Mar 2020 15:19:40 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id n5sm9583179wrx.80.2020.03.10.15.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:19:39 -0700 (PDT)
Date:   Tue, 10 Mar 2020 23:19:38 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: make a last minute check to prevent unnecessary
 memcg oom kills
Message-ID: <20200310221938.GF8447@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003101454580.142656@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 14:55:50, David Rientjes wrote:
> Killing a user process as a result of hitting memcg limits is a serious
> decision that is unfortunately needed only when no forward progress in
> reclaiming memory can be made.
> 
> Deciding the appropriate oom victim can take a sufficient amount of time
> that allows another process that is exiting to actually uncharge to the
> same memcg hierarchy and prevent unnecessarily killing user processes.
> 
> An example is to prevent *multiple* unnecessary oom kills on a system
> with two cores where the oom kill occurs when there is an abundance of
> free memory available:
> 
> Memory cgroup out of memory: Killed process 628 (repro) total-vm:41944kB, anon-rss:40888kB, file-rss:496kB, shmem-rss:0kB, UID:0 pgtables:116kB oom_score_adj:0
> <immediately after>
> repro invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0
> CPU: 1 PID: 629 Comm: repro Not tainted 5.6.0-rc5+ #130
> Call Trace:
>  dump_stack+0x78/0xb6
>  dump_header+0x55/0x240
>  oom_kill_process+0xc5/0x170
>  out_of_memory+0x305/0x4a0
>  try_charge+0x77b/0xac0
>  mem_cgroup_try_charge+0x10a/0x220
>  mem_cgroup_try_charge_delay+0x1e/0x40
>  handle_mm_fault+0xdf2/0x15f0
>  do_user_addr_fault+0x21f/0x420
>  async_page_fault+0x2f/0x40
> memory: usage 61336kB, limit 102400kB, failcnt 74
> 
> Notice the second memcg oom kill shows usage is >40MB below its limit of
> 100MB but a process is still unnecessarily killed because the decision has
> already been made to oom kill by calling out_of_memory() before the
> initial victim had a chance to uncharge its memory.

Could you be more specific about the specific workload please?

> Make a last minute check to determine if an oom kill is really needed to
> prevent unnecessary oom killing.

I really see no reason why the memcg oom should behave differently from
the global case. In both cases there will be a point of no return.
Where-ever it is done it will be racy and the oom victim selection will
play the race window role. There is simply no way around that without
making the whole thing completely synchronous. This all looks like a
micro optimization and I would really like to see a relevant real world
usecase presented before new special casing is added.

> 
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  include/linux/memcontrol.h |  7 +++++++
>  mm/memcontrol.c            |  2 +-
>  mm/oom_kill.c              | 16 +++++++++++++---
>  3 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -445,6 +445,8 @@ void mem_cgroup_iter_break(struct mem_cgroup *, struct mem_cgroup *);
>  int mem_cgroup_scan_tasks(struct mem_cgroup *,
>  			  int (*)(struct task_struct *, void *), void *);
>  
> +unsigned long mem_cgroup_margin(struct mem_cgroup *memcg);
> +
>  static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
>  {
>  	if (mem_cgroup_disabled())
> @@ -945,6 +947,11 @@ static inline int mem_cgroup_scan_tasks(struct mem_cgroup *memcg,
>  	return 0;
>  }
>  
> +static inline unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
> +{
> +	return 0;
> +}
> +
>  static inline unsigned short mem_cgroup_id(struct mem_cgroup *memcg)
>  {
>  	return 0;
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1286,7 +1286,7 @@ void mem_cgroup_update_lru_size(struct lruvec *lruvec, enum lru_list lru,
>   * Returns the maximum amount of memory @mem can be charged with, in
>   * pages.
>   */
> -static unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
> +unsigned long mem_cgroup_margin(struct mem_cgroup *memcg)
>  {
>  	unsigned long margin = 0;
>  	unsigned long count;
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -972,9 +972,6 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	}
>  	task_unlock(victim);
>  
> -	if (__ratelimit(&oom_rs))
> -		dump_header(oc, victim);
> -
>  	/*
>  	 * Do we need to kill the entire memory cgroup?
>  	 * Or even one of the ancestor memory cgroups?
> @@ -982,6 +979,19 @@ static void oom_kill_process(struct oom_control *oc, const char *message)
>  	 */
>  	oom_group = mem_cgroup_get_oom_group(victim, oc->memcg);
>  
> +	if (is_memcg_oom(oc)) {
> +		cond_resched();
> +
> +		/* One last check: do we *really* need to kill? */
> +		if (mem_cgroup_margin(oc->memcg) >= (1 << oc->order)) {
> +			put_task_struct(victim);
> +			return;
> +		}
> +	}
> +
> +	if (__ratelimit(&oom_rs))
> +		dump_header(oc, victim);
> +
>  	__oom_kill_process(victim, message);
>  
>  	/*

-- 
Michal Hocko
SUSE Labs
