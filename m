Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B33BC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B59B206B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 00:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbgCMAPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 20:15:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64900 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbgCMAPe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:15:34 -0400
Received: from fsav304.sakura.ne.jp (fsav304.sakura.ne.jp [153.120.85.135])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02D0FAZU079470;
        Fri, 13 Mar 2020 09:15:10 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav304.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp);
 Fri, 13 Mar 2020 09:15:10 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav304.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02D0F9vx079463;
        Fri, 13 Mar 2020 09:15:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id 02D0F9uT079462;
        Fri, 13 Mar 2020 09:15:09 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <202003130015.02D0F9uT079462@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Date:   Fri, 13 Mar 2020 09:15:09 +0900
References: <202003120012.02C0CEUB043533@www262.sakura.ne.jp> <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> > By the way, will you share the reproducer (and how to use the reproducer) ?
> > 
> 
> On an UP kernel with swap disabled, you limit a memcg to 100MB and start 
> three processes that each fault 40MB attached to it.  Same reproducer as 
> the "mm, oom: make a last minute check to prevent unnecessary memcg oom 
> kills" patch except in that case there are two cores.
> 

I'm not a heavy memcg user. Please provide steps for reproducing your problem
in a "copy and pastable" way (e.g. bash script, C program).

> > @@ -1576,6 +1576,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >  	 */
> >  	ret = should_force_charge() || out_of_memory(&oc);
> >  	mutex_unlock(&oom_lock);
> > +	schedule_timeout_killable(1);
> >  	return ret;
> >  }
> >  
> 
> If current was process chosen for oom kill, this would actually induce the 
> problem, not fix it.
> 

Why? Memcg OOM path allows using forced charge path if should_force_charge() == true.

Since your lockup report

  Call Trace:
   shrink_node+0x40d/0x7d0
   do_try_to_free_pages+0x13f/0x470
   try_to_free_mem_cgroup_pages+0x16d/0x230
   try_charge+0x247/0xac0
   mem_cgroup_try_charge+0x10a/0x220
   mem_cgroup_try_charge_delay+0x1e/0x40
   handle_mm_fault+0xdf2/0x15f0
   do_user_addr_fault+0x21f/0x420
   page_fault+0x2f/0x40

says that allocating thread was calling try_to_free_mem_cgroup_pages() from try_charge(),
allocating thread must be able to reach mem_cgroup_out_of_memory() from mem_cgroup_oom()
 from try_charge(). And actually

  Memory cgroup out of memory: Killed process 808 (repro) total-vm:41944kB, anon-rss:35344kB, file-rss:504kB, shmem-rss:0kB, UID:0 pgtables:108kB oom_score_adj:0

says that allocating thread did reach mem_cgroup_out_of_memory(). Then, allocating thread
must be able to sleep at mem_cgroup_out_of_memory() if schedule_timeout_killable(1) is
mem_cgroup_out_of_memory().

Also, if current process was chosen for OOM-kill, current process will be able to leave
try_charge() due to should_force_charge() == true, won't it?

Thus, how can "this would actually induce the problem, not fix it." happen?
If your problem is that something keeps allocating threads away from reaching
should_force_charge() check, please explain the mechanism. If that is explained,
I would agree that schedule_timeout_killable(1) in mem_cgroup_out_of_memory()
won't help.
