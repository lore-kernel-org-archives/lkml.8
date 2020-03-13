Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C326C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5370E2074A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 22:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o6zQrGkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727512AbgCMWBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 18:01:20 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37727 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbgCMWBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 18:01:20 -0400
Received: by mail-pf1-f195.google.com with SMTP id p14so6087066pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 15:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=UFE9bZCG4sWGzF0InHa1jECdp69Y2rcipLo/idzivo8=;
        b=o6zQrGkfIrtt5FoOA5+Q0j4dDaC/p7dfapsUM9vxhhM+DfktEGLaFpmG+oJu7R2wsa
         /ERomm2bMVyt5ZDEjmCApn34tTXPJQ7eL1gY0xIl5qobH2D22pkddabiBGWAIrW9fxEK
         r/KErvHJfEzlAvSdcCbPAlENTb7rhpHa6+qK2KP980KgDmZH5wTO3qEw7uiocAHiSqGT
         eRERMZ8rirAGZmQN3OtCje2+L/Wcg7rBc4PpBWK9ziK7nT4VGQlLAAxontaTVAWvv3VI
         oF+L+fwq6A2V0o/HjtLHDGpu4RccNKhjSRtfT1//gJRJKJBfUu8U0NsPd9qqMpIY2xhf
         UA4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=UFE9bZCG4sWGzF0InHa1jECdp69Y2rcipLo/idzivo8=;
        b=uMFg1z3FXAjUrX1M92+kmu0SqqsS3CFosb+LgkjFsjmvdFLZCZ3u0XXdbyM1pRjRa3
         I5IhdqEgXe2mI1NlTeplxNky27Epv2W177rFB6NCvPnOg4BvaEvSeoPyN69SnQi1HbBm
         sz8rlwAxWWH3CLBZ5SftEJzoh7nbCboPcH4xNc2jkWUrTkYBIWII0/D3k0gYoa6qGlnO
         PFmAb9mFukDXlWAInoUtcLi6El70kSXUAVSq4EEdGTX7kpncYQq1wwGOpUMfaDJpdzE6
         A+peyqCQIFSRe+BDjohmw/Wf3RMfbkVVlYPzHINRi4D7ps+4otnzpVaWoQyU9W/w1OzN
         TCXg==
X-Gm-Message-State: ANhLgQ2GQXI+Ok4FfmHdDMsUi3inwrzH9PhJkn3xOnuZ1EMekkA4TjsF
        KnxZnBhuwdLV8I/AxmTt31wS9aOpFFY=
X-Google-Smtp-Source: ADFU+vvtFE1n8c5EAfrwRlVwAOQFqHnZX9L7K9vdbWqUnmLqRbdFciiAuv6RUYbMOQFh1awwltDZfA==
X-Received: by 2002:a63:e50b:: with SMTP id r11mr6530266pgh.178.1584136877223;
        Fri, 13 Mar 2020 15:01:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id d6sm8199581pfn.214.2020.03.13.15.01.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2020 15:01:16 -0700 (PDT)
Date:   Fri, 13 Mar 2020 15:01:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <202003130015.02D0F9uT079462@www262.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2003131457370.242651@chino.kir.corp.google.com>
References: <202003120012.02C0CEUB043533@www262.sakura.ne.jp> <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com> <202003130015.02D0F9uT079462@www262.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020, Tetsuo Handa wrote:

> > On an UP kernel with swap disabled, you limit a memcg to 100MB and start 
> > three processes that each fault 40MB attached to it.  Same reproducer as 
> > the "mm, oom: make a last minute check to prevent unnecessary memcg oom 
> > kills" patch except in that case there are two cores.
> > 
> 
> I'm not a heavy memcg user. Please provide steps for reproducing your problem
> in a "copy and pastable" way (e.g. bash script, C program).
> 

Use Documentation/admin-guide/cgroup-v1/memory.rst or 
Documentation/admin-guide/cgroup-v2.rst to setup a memcg depending on 
which cgroup version you use, limit it to 100MB, and attach your process 
to it.

Run three programs that fault 40MB.  To do that, you need to use mmap:

	(void)mmap(NULL, 40 << 20, PROT_READ|PROT_WRITE,
		MAP_PRIVATE|MAP_ANONYMOUS|MAP_POPULATE, 0, 0);

Have it stall after populating the memory:

	for (;;);

> > > @@ -1576,6 +1576,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> > >  	 */
> > >  	ret = should_force_charge() || out_of_memory(&oc);
> > >  	mutex_unlock(&oom_lock);
> > > +	schedule_timeout_killable(1);
> > >  	return ret;
> > >  }
> > >  
> > 
> > If current was process chosen for oom kill, this would actually induce the 
> > problem, not fix it.
> > 
> 
> Why? Memcg OOM path allows using forced charge path if should_force_charge() == true.
> 
> Since your lockup report
> 
>   Call Trace:
>    shrink_node+0x40d/0x7d0
>    do_try_to_free_pages+0x13f/0x470
>    try_to_free_mem_cgroup_pages+0x16d/0x230
>    try_charge+0x247/0xac0
>    mem_cgroup_try_charge+0x10a/0x220
>    mem_cgroup_try_charge_delay+0x1e/0x40
>    handle_mm_fault+0xdf2/0x15f0
>    do_user_addr_fault+0x21f/0x420
>    page_fault+0x2f/0x40
> 
> says that allocating thread was calling try_to_free_mem_cgroup_pages() from try_charge(),
> allocating thread must be able to reach mem_cgroup_out_of_memory() from mem_cgroup_oom()
>  from try_charge(). And actually
> 
>   Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0
> 
> says that allocating thread did reach mem_cgroup_out_of_memory(). Then, allocating thread
> must be able to sleep at mem_cgroup_out_of_memory() if schedule_timeout_killable(1) is
> mem_cgroup_out_of_memory().
> 
> Also, if current process was chosen for OOM-kill, current process will be able to leave
> try_charge() due to should_force_charge() == true, won't it?
> 
> Thus, how can "this would actually induce the problem, not fix it." happen?

The entire issue is that the victim never gets a chance to run because the 
allocator doesn't give it a chance to run on an UP system.  Your patch is 
broken because if the victim is current, you've lost your golden 
opportunity to actually exit and ceded control to the allocator that will 
now starve the victim.
