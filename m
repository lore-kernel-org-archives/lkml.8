Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B35AC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 03:19:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CFF20575
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 03:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCQDTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 23:19:10 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:58659 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbgCQDTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 23:19:10 -0400
Received: from fsav401.sakura.ne.jp (fsav401.sakura.ne.jp [133.242.250.100])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02H3IpDp047482;
        Tue, 17 Mar 2020 12:18:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav401.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp);
 Tue, 17 Mar 2020 12:18:51 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav401.sakura.ne.jp)
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 02H3Ip6f047472;
        Tue, 17 Mar 2020 12:18:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: (from i-love@localhost)
        by www262.sakura.ne.jp (8.15.2/8.15.2/Submit) id 02H3IpSx047471;
        Tue, 17 Mar 2020 12:18:51 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Message-Id: <202003170318.02H3IpSx047471@www262.sakura.ne.jp>
X-Authentication-Warning: www262.sakura.ne.jp: i-love set sender to penguin-kernel@i-love.sakura.ne.jp using -f
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
MIME-Version: 1.0
Date:   Tue, 17 Mar 2020 12:18:51 +0900
References: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp> <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com>
In-Reply-To: <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com>
Content-Type: text/plain; charset="ISO-2022-JP"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

David Rientjes wrote:
> On Sat, 14 Mar 2020, Tetsuo Handa wrote:
> > If current thread is an OOM victim, schedule_timeout_killable(1) will give other
> > threads (including the OOM reaper kernel thread) CPU time to run, by leaving
> > try_charge() path due to should_force_charge() == true and reaching do_exit() path
> > instead of returning to userspace code doing "for (;;);".
> > 
> > Unless the problem is that current thread cannot reach should_force_charge() check,
> > schedule_timeout_killable(1) should work.
> > 
> 
> No need to yield if current is the oom victim, allowing the oom reaper to 
> run when it may not actually be able to free memory is not required.  It 
> increases the likelihood that some other process schedules and is unable 
> to yield back due to the memcg oom condition such that the victim doesn't 
> get a chance to run again.
> 
> This happens because the victim is allowed to overcharge but other 
> processes attached to an oom memcg hierarchy simply fail the charge.  We 
> are then reliant on all memory chargers in the kernel to yield if their 
> charges fail due to oom.  It's the only way to allow the victim to 
> eventually run.
> 
> So the only change that I would make to your patch is to do this in 
> mem_cgroup_out_of_memory() instead:
> 
> 	if (!fatal_signal_pending(current))
> 		schedule_timeout_killable(1);
> 
> So we don't have this reliance on all other memory chargers to yield when 
> their charge fails and there is no delay for victims themselves.

I see. You want below functions for environments where current thread can
fail to resume execution for long if current thread once reschedules (e.g.
UP kernel, many threads contended on one CPU).

/*
 * Give other threads CPU time, unless current thread was already killed.
 * Used when we prefer killed threads to continue execution (in a hope that
 * killed threads terminate quickly) over giving other threads CPU time.
 */
signed long __sched schedule_timeout_killable_expedited(signed long timeout)
{
	if (unlikely(fatal_signal_pending(current)))
		return timeout;
	return schedule_timeout_killable(timeout);
}

/*
 * Latency reduction via explicit rescheduling in places that are safe,
 * but becomes no-op if current thread was already killed. Used when we
 * prefer killed threads to continue execution (in a hope that killed
 * threads terminate quickly) over giving other threads CPU time.
 */
int cond_resched_expedited(void)
{
	if (unlikely(fatal_signal_pending(current)))
		return 0;
	return cond_resched();
}

> 
>  [ I'll still propose my change that adds cond_resched() to 
>    shrink_node_memcgs() because we can see need_resched set for a 
>    prolonged period of time without scheduling. ]

As long as there is schedule_timeout_killable(), I'm fine with adding
cond_resched() in other places.

> 
> If you agree, I'll propose your patch with a changelog that indicates it 
> can fix the soft lockup issue for UP and can likely get a tested-by for 
> it.
> 

Please go ahead.
