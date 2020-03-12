Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36BDC0044D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:12:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1CB020753
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 00:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgCLAMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 20:12:34 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58461 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731568AbgCLAMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 20:12:34 -0400
Received: from fsav402.sakura.ne.jp (fsav402.sakura.ne.jp [133.242.250.101])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02C0CFQk043539;
        Thu, 12 Mar 2020 09:12:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav402.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp);
 Thu, 12 Mar 2020 09:12:15 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav402.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02C0CEIj043534;
        Thu, 12 Mar 2020 09:12:15 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id 02C0CEUB043533;
        Thu, 12 Mar 2020 09:12:14 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Date:   Thu, 12 Mar 2020 09:12:14 +0900
References: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp> <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 12 Mar 2020, Tetsuo Handa wrote:
> > > If you have an alternate patch to try, we can test it.  But since this 
> > > cond_resched() is needed anyway, I'm not sure it will change the result.
> > 
> > schedule_timeout_killable(1) is an alternate patch to try; I don't think
> > that this cond_resched() is needed anyway.
> > 
> 
> You are suggesting schedule_timeout_killable(1) in shrink_node_memcgs()?
> 

Andrew Morton also mentioned whether cond_resched() in shrink_node_memcgs()
is enough. But like you mentioned,

David Rientjes wrote:
> On Tue, 10 Mar 2020, Andrew Morton wrote:
> 
> > > --- a/mm/vmscan.c
> > > +++ b/mm/vmscan.c
> > > @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> > >  		unsigned long reclaimed;
> > >  		unsigned long scanned;
> > >  
> > > +		cond_resched();
> > > +
> > >  		switch (mem_cgroup_protected(target_memcg, memcg)) {
> > >  		case MEMCG_PROT_MIN:
> > >  			/*
> > 
> > 
> > Obviously better, but this will still spin wheels until this tasks's
> > timeslice expires, and we might want to do something to help ensure
> > that the victim runs next (or soon)?
> > 
> 
> We used to have a schedule_timeout_killable(1) to address exactly that 
> scenario but it was removed in 4.19:
> 
> commit 9bfe5ded054b8e28a94c78580f233d6879a00146
> Author: Michal Hocko <mhocko@suse.com>
> Date:   Fri Aug 17 15:49:04 2018 -0700
> 
>     mm, oom: remove sleep from under oom_lock

you can try re-adding sleep outside of oom_lock:

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d09776cd6e10..3aee7e0eca4e 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -1576,6 +1576,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
 	 */
 	ret = should_force_charge() || out_of_memory(&oc);
 	mutex_unlock(&oom_lock);
+	schedule_timeout_killable(1);
 	return ret;
 }
 
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..e80158049651 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3797,7 +3797,6 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
 	 */
 	if (!mutex_trylock(&oom_lock)) {
 		*did_some_progress = 1;
-		schedule_timeout_uninterruptible(1);
 		return NULL;
 	}
 
@@ -4590,6 +4589,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 
 	/* Retry as long as the OOM killer is making progress */
 	if (did_some_progress) {
+		schedule_timeout_uninterruptible(1);
 		no_progress_loops = 0;
 		goto retry;
 	}

By the way, will you share the reproducer (and how to use the reproducer) ?
