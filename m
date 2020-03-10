Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F875C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31AD8222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 23:02:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AhM2LYnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbgCJXC1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 19:02:27 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40166 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgCJXC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 19:02:26 -0400
Received: by mail-pg1-f194.google.com with SMTP id t24so101561pgj.7
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 16:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=sNJMHcqhH5bIss2Jn3/DDyujT2niTfFiD1TV+eWRWSM=;
        b=AhM2LYnMo549Pcj8tA22dgyojsiuOl3wBouOrWpxbFvolY/IxEaU6woN++aO28nkhr
         wV4EwxFKHBdY8J7cYXuJtNeo+Q1DjvaNz/a469+98LzLVdGWkTKdBmu8Ffd8plzwUtWO
         yhOtOeQStxJnwkCm5YWLUEq4xWtPDJubEq6dVxFKvnLcZCUGGiONnNxIXIVJDWARHdEr
         OCNymGSoMHGnphFunl5/fXtqqbwZaHWsIdugwyx+IF4EygYi/kGfoEp7UY1IMCmkwAiS
         HU/u4G3Vpq1sHojFWjrVZ6MA3rJU4oo2x3EJKwKzCwMZqM0tnWYBTiH9uWLuM0yxm5/z
         F2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=sNJMHcqhH5bIss2Jn3/DDyujT2niTfFiD1TV+eWRWSM=;
        b=D60wHcdX50yfceqWJQ9sJpJfVMfdzwpEFwPW4C3oxZzLMOm0qrc6H6UA/0Al2SEJCM
         DKhCB89yI+IS/VtD2WUbS8/V/GE3EhTOkMWvcDIWyAZ7hNqITejWnXkc5EfFOVICgMir
         nCSHJb0uguor9JMdb0bF+MtDLKncUvw3JIN6hhaRZk78FCbmlVQRo3fKukwzQEy9uDvU
         MreCA36kA5QPtNWRgvl9EFc4V3I6zFX+Is1Xr58PfnwWERVMSo6Mdl/6vJx6W1weogqI
         HRau2v3SI7T6jgeq792vAKZMoUzU8slbE8OvLHZzNIhguRFuSaviOSSrHCZW2635CmiP
         T1aw==
X-Gm-Message-State: ANhLgQ1Lw9VZGFncsnfukrk68cy4jPeUNgKcHx1QncoUalCSb7qQgAbw
        oZf7SIbcRExRUv4AMqSqBOh1qjpIKL4=
X-Google-Smtp-Source: ADFU+vsPEcD1L1fHln7MhGHnJ+8cQSbt0Y/rSgnIw0ZdHjpLWSSdjtdq/hMpBfexq3PLc/P53wO2ew==
X-Received: by 2002:a63:485f:: with SMTP id x31mr21297929pgk.347.1583881345555;
        Tue, 10 Mar 2020 16:02:25 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id x2sm46513691pge.2.2020.03.10.16.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 16:02:24 -0700 (PDT)
Date:   Tue, 10 Mar 2020 16:02:23 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <20200310221019.GE8447@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com> <20200310221019.GE8447@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Mar 2020, Michal Hocko wrote:

> > When a process is oom killed as a result of memcg limits and the victim
> > is waiting to exit, nothing ends up actually yielding the processor back
> > to the victim on UP systems with preemption disabled.  Instead, the
> > charging process simply loops in memcg reclaim and eventually soft
> > lockups.
> > 
> > Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
> > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> > CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> > RIP: 0010:shrink_lruvec+0x4e9/0xa40
> > ...
> > Call Trace:
> >  shrink_node+0x40d/0x7d0
> >  do_try_to_free_pages+0x13f/0x470
> >  try_to_free_mem_cgroup_pages+0x16d/0x230
> >  try_charge+0x247/0xac0
> >  mem_cgroup_try_charge+0x10a/0x220
> >  mem_cgroup_try_charge_delay+0x1e/0x40
> >  handle_mm_fault+0xdf2/0x15f0
> >  do_user_addr_fault+0x21f/0x420
> >  page_fault+0x2f/0x40
> > 
> > Make sure that something ends up actually yielding the processor back to
> > the victim to allow for memory freeing.  Most appropriate place appears to
> > be shrink_node_memcgs() where the iteration of all decendant memcgs could
> > be particularly lengthy.
> 
> There is a cond_resched in shrink_lruvec and another one in
> shrink_page_list. Why doesn't any of them hit? Is it because there are
> no pages on the LRU list? Because rss data suggests there should be
> enough pages to go that path. Or maybe it is shrink_slab path that takes
> too long?
> 

I think it can be a number of cases, most notably mem_cgroup_protected() 
checks which is why the cond_resched() is added above it.  Rather than add 
cond_resched() only for MEMCG_PROT_MIN and for certain MEMCG_PROT_LOW, the 
cond_resched() is added above the switch clause because the iteration 
itself may be potentially very lengthy.

We could also do it in shrink_zones() or the priority based 
do_try_to_free_pages() loop, but I'd be nervous about the lengthy memcg 
iteration in shrink_node_memcgs() independent of this.

Any other ideas on how to ensure we actually try to resched for the 
benefit of an oom victim to prevent this soft lockup?

> The patch itself makes sense to me but I would like to see more
> explanation on how that happens.
> 
> Thanks.
> 
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: David Rientjes <rientjes@google.com>
> > ---
> >  mm/vmscan.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >  		unsigned long reclaimed;
> >  		unsigned long scanned;
> >  
> > +		cond_resched();
> > +
> >  		switch (mem_cgroup_protected(target_memcg, memcg)) {
> >  		case MEMCG_PROT_MIN:
> >  			/*
> 
> -- 
> Michal Hocko
> SUSE Labs
> 
