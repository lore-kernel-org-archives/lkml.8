Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DCC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:32:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCAC6206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584001966;
	bh=flwFP223FcbPBBJsCcekioD0B1av0xCAQaqglyEFLyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iVHZVKNeSiuO/3umOqAScVWRYGx00U/KONi/2gsa00wU6aXEgKAb6FuK0266Y4y8u
	 N/Q7zFfbn6iAn/v4tXOV12yGqLFL6KODyWB6QX0KTc1zB7HSN01OsOJkT/ObT6dPcq
	 7cyhVa61T62e9Xs+y+LX9ObL9kE4e2IoeaMHtps4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbgCLIcp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:32:45 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53089 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgCLIcp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:32:45 -0400
Received: by mail-wm1-f68.google.com with SMTP id 11so5066784wmo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 01:32:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y2vrstQh1zW/hZDali97uunaWWCj2ea+q+1b8YJaz9s=;
        b=Uvf6763SA4gEjYNd/ShiPMGqN9BS9WFKqd/V1hTkj+rpiBBwea1z6cFQY28V/ZQNRD
         RZU9yDQCo/Nyl8IBr0tTgwFrymFXHZRu2IJjOP4vl4gu/zp7aqocyzjiZpgKNY679r/H
         /ozsxLdIxpQDyGdYe1jBYcPoej81ROLVrC2iK4I4HJ7cnzvu16489VyzOl1ssVkUV8WJ
         3R2GcI2YvFiqBOiBooXdmCvCfg/DFWvuHGRF6Vot953bhoo+PMHaXXhDgZkvn+MO1kj1
         BjwULFElR453misceL2XAvO7pOE+Ym1YBHy3hTWswVCuHaM5tdNsqKw+DIn7awq9Du4D
         +2Dg==
X-Gm-Message-State: ANhLgQ2ydxHM3MEs93zjTvfS8ZkwIRYmERspW4GUuewCB4h2zpjcnR+/
        vngl5eixvF0IY25/K2fz5vKHVe5h
X-Google-Smtp-Source: ADFU+vvva8LArSKeKAM6eHoXmnqDT18zn4MX2uQA8OEqtrJ47Vnk7MtxQAWTcPleQ/Mrz/vEpNj2vw==
X-Received: by 2002:a1c:6745:: with SMTP id b66mr3613933wmc.30.1584001963638;
        Thu, 12 Mar 2020 01:32:43 -0700 (PDT)
Received: from localhost (ip-37-188-253-35.eurotel.cz. [37.188.253.35])
        by smtp.gmail.com with ESMTPSA id w1sm10867129wmc.11.2020.03.12.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 01:32:42 -0700 (PDT)
Date:   Thu, 12 Mar 2020 09:32:41 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200312083241.GT23944@dhcp22.suse.cz>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com>
 <20200310221019.GE8447@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003101556270.177273@chino.kir.corp.google.com>
 <20200311082736.GA23944@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003111238570.171292@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003111238570.171292@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 11-03-20 12:45:40, David Rientjes wrote:
> On Wed, 11 Mar 2020, Michal Hocko wrote:
> 
> > > > > When a process is oom killed as a result of memcg limits and the victim
> > > > > is waiting to exit, nothing ends up actually yielding the processor back
> > > > > to the victim on UP systems with preemption disabled.  Instead, the
> > > > > charging process simply loops in memcg reclaim and eventually soft
> > > > > lockups.
> > > > > 
> > > > > Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
> > > > > watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [repro:806]
> > > > > CPU: 0 PID: 806 Comm: repro Not tainted 5.6.0-rc5+ #136
> > > > > RIP: 0010:shrink_lruvec+0x4e9/0xa40
> > > > > ...
> > > > > Call Trace:
> > > > >  shrink_node+0x40d/0x7d0
> > > > >  do_try_to_free_pages+0x13f/0x470
> > > > >  try_to_free_mem_cgroup_pages+0x16d/0x230
> > > > >  try_charge+0x247/0xac0
> > > > >  mem_cgroup_try_charge+0x10a/0x220
> > > > >  mem_cgroup_try_charge_delay+0x1e/0x40
> > > > >  handle_mm_fault+0xdf2/0x15f0
> > > > >  do_user_addr_fault+0x21f/0x420
> > > > >  page_fault+0x2f/0x40
> > > > > 
> > > > > Make sure that something ends up actually yielding the processor back to
> > > > > the victim to allow for memory freeing.  Most appropriate place appears to
> > > > > be shrink_node_memcgs() where the iteration of all decendant memcgs could
> > > > > be particularly lengthy.
> > > > 
> > > > There is a cond_resched in shrink_lruvec and another one in
> > > > shrink_page_list. Why doesn't any of them hit? Is it because there are
> > > > no pages on the LRU list? Because rss data suggests there should be
> > > > enough pages to go that path. Or maybe it is shrink_slab path that takes
> > > > too long?
> > > > 
> > > 
> > > I think it can be a number of cases, most notably mem_cgroup_protected() 
> > > checks which is why the cond_resched() is added above it.  Rather than add 
> > > cond_resched() only for MEMCG_PROT_MIN and for certain MEMCG_PROT_LOW, the 
> > > cond_resched() is added above the switch clause because the iteration 
> > > itself may be potentially very lengthy.
> > 
> > Was any of the above the case for your soft lockup case? How have you
> > managed to trigger it? As I've said I am not against the patch but I
> > would really like to see an actual explanation what happened rather than
> > speculations of what might have happened. If for nothing else then for
> > the future reference.
> > 
> 
> Yes, this is how it was triggered in my own testing.
> 
> > If this is really about all the hierarchy being MEMCG_PROT_MIN protected
> > and that results in a very expensive and pointless reclaim walk that can
> > trigger soft lockup then it should be explicitly mentioned in the
> > changelog.
> 
> I think the changelog clearly states that we need to guarantee that a 
> reclaimer will yield the processor back to allow a victim to exit.  This 
> is where we make the guarantee.  If it helps for the specific reason it 
> triggered in my testing, we could add:
> 
> "For example, mem_cgroup_protected() can prohibit reclaim and thus any 
> yielding in page reclaim would not address the issue."

I would suggest something like the following:
"
The reclaim path (including the OOM) relies on explicit scheduling
points to hand over execution to tasks which could help with the reclaim
process. Currently it is mostly shrink_page_list which yields CPU for
each reclaimed page. This might be insuficient though in some
configurations. E.g. when a memcg OOM path is triggered in a hierarchy
which doesn't have any reclaimable memory because of memory reclaim
protection (MEMCG_PROT_MIN) then there is possible to trigger a soft
lockup during an out of memory situation on non preemptible kernels
<PUT YOUR SOFT LOCKUP SPLAT HERE>

Fix this by adding a cond_resched up in the reclaim path and make sure
there is a yield point regardless of reclaimability of the target
hierarchy.
"

-- 
Michal Hocko
SUSE Labs
