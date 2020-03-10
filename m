Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBF9C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAB24208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583878226;
	bh=F0BxWcAdg+jzZoMPuYTqzOZa/pAmdK2n3a5vPe5eqzA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TF3eHODnXurIM4H4si1ZRHvPMbMh6uLcqAY+kTzsQyocdcRgDfo9hybNsx9dZH0eD
	 zBoj1DRC60oU8njS/JNlcTbwUg2oVXMoGcc/78HweB6LLWKpEJR3aLoZUXN7Kganfz
	 j8NAzVTtHTAlMhCRfQPcsGlirsXP96fFcIFB31Z4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727520AbgCJWKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:10:25 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37314 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgCJWKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:10:25 -0400
Received: by mail-wr1-f65.google.com with SMTP id 6so44791wre.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:10:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fzoPcCcArgslJEjFGamnoESKQ6n8NlkNe0nFrWqr2Us=;
        b=cJCwkPhxrn2JzXJECusEf3OqsyJ5rNGQA6cpjaTxCGO+Dl99VU4C6/XmEGmgm04ago
         8e6eP6r3y96NUSPTeVyj4OCfTxwMEzLxalNMKY+reFxW/Wl63H0VydLJLGU+V/uChQJx
         lyUtRchbuVXYqTqFrzFBh+rFIAMi22XjH7J6tJvM8YmfcG9l4xUQ1AHfr5Rg602Y6ZE1
         FOyU/t+VEpMltW3EXKan2nvACVh7/w+oCACDjFp8InuW/SMJJ14IR7Uuze6otlPzL6iN
         T3gLRbfk0CmE7cEUPqhxLATtPyG7ItfQkuO8U1TJFSidi9B1QytZYz65bhzC33vcf2m8
         24Uw==
X-Gm-Message-State: ANhLgQ2CPFG+vFqD/n82w3Hie0nIn3REvkvwphzR21PiOdqxt414jBV4
        giljdaifAILqWHp21xhRQfiEHvwtrCI=
X-Google-Smtp-Source: ADFU+vuz7Kl5/dFfUzD4Yt/LB7B4aNfvbc25VgZibMXjn6QBDhlwhZtu3Pi6nHtgw2nFnnWEkb0Jcw==
X-Received: by 2002:adf:aa04:: with SMTP id p4mr13601wrd.238.1583878221819;
        Tue, 10 Mar 2020 15:10:21 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id q5sm21114106wrc.68.2020.03.10.15.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:10:21 -0700 (PDT)
Date:   Tue, 10 Mar 2020 23:10:19 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200310221019.GE8447@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 10-03-20 14:39:48, David Rientjes wrote:
> When a process is oom killed as a result of memcg limits and the victim
> is waiting to exit, nothing ends up actually yielding the processor back
> to the victim on UP systems with preemption disabled.  Instead, the
> charging process simply loops in memcg reclaim and eventually soft
> lockups.
> 
> Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
> watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> RIP: 0010:shrink_lruvec+0x4e9/0xa40
> ...
> Call Trace:
>  shrink_node+0x40d/0x7d0
>  do_try_to_free_pages+0x13f/0x470
>  try_to_free_mem_cgroup_pages+0x16d/0x230
>  try_charge+0x247/0xac0
>  mem_cgroup_try_charge+0x10a/0x220
>  mem_cgroup_try_charge_delay+0x1e/0x40
>  handle_mm_fault+0xdf2/0x15f0
>  do_user_addr_fault+0x21f/0x420
>  page_fault+0x2f/0x40
> 
> Make sure that something ends up actually yielding the processor back to
> the victim to allow for memory freeing.  Most appropriate place appears to
> be shrink_node_memcgs() where the iteration of all decendant memcgs could
> be particularly lengthy.

There is a cond_resched in shrink_lruvec and another one in
shrink_page_list. Why doesn't any of them hit? Is it because there are
no pages on the LRU list? Because rss data suggests there should be
enough pages to go that path. Or maybe it is shrink_slab path that takes
too long?

The patch itself makes sense to me but I would like to see more
explanation on how that happens.

Thanks.

> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>  mm/vmscan.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
>  		unsigned long reclaimed;
>  		unsigned long scanned;
>  
> +		cond_resched();
> +
>  		switch (mem_cgroup_protected(target_memcg, memcg)) {
>  		case MEMCG_PROT_MIN:
>  			/*

-- 
Michal Hocko
SUSE Labs
