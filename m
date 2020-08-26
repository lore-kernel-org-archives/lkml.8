Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0139C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97BC32080C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgHZMsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:48:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:45238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729391AbgHZMsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:48:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BCDECB17A;
        Wed, 26 Aug 2020 12:48:45 +0000 (UTC)
Date:   Wed, 26 Aug 2020 14:48:10 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     xunlei <xlpang@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
Message-ID: <20200826124810.GQ22869@dhcp22.suse.cz>
References: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826081102.GM22869@dhcp22.suse.cz>
 <99efed0e-050a-e313-46ab-8fe6228839d5@linux.alibaba.com>
 <20200826110015.GO22869@dhcp22.suse.cz>
 <f0122b2d-4740-2caf-3c4f-009a513426e3@linux.alibaba.com>
 <20200826120740.GP22869@dhcp22.suse.cz>
 <19eb48db-7d5e-0f55-5dfc-6a71274fd896@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <19eb48db-7d5e-0f55-5dfc-6a71274fd896@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-08-20 20:21:39, xunlei wrote:
> On 2020/8/26 下午8:07, Michal Hocko wrote:
> > On Wed 26-08-20 20:00:47, xunlei wrote:
> >> On 2020/8/26 下午7:00, Michal Hocko wrote:
> >>> On Wed 26-08-20 18:41:18, xunlei wrote:
> >>>> On 2020/8/26 下午4:11, Michal Hocko wrote:
> >>>>> On Wed 26-08-20 15:27:02, Xunlei Pang wrote:
> >>>>>> We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
> >>>>>> the target memcg doesn't have any reclaimable memory.
> >>>>>
> >>>>> Do you have any scenario when this happens or is this some sort of a
> >>>>> test case?
> >>>>
> >>>> It can happen on tiny guest scenarios.
> >>>
> >>> OK, you made me more curious. If this is a tiny guest and this is a hard
> >>> limit reclaim path then we should trigger an oom killer which should
> >>> kill the offender and that in turn bail out from the try_charge lopp
> >>> (see should_force_charge). So how come this repeats enough in your setup
> >>> that it causes soft lockups?
> >>>
> >>
> >> should_force_charge() is false, the current trapped in endless loop is
> >> not the oom victim.
> > 
> > How is that possible? If the oom killer kills a task and that doesn't
> > resolve the oom situation then it would go after another one until all
> > tasks are killed. Or is your task living outside of the memcg it tries
> > to charge?
> > 
> 
> All tasks are in memcgs. Looks like the first oom victim is not finished
> (unable to schedule), later mem_cgroup_oom()->...->oom_evaluate_task()
> will set oc->chosen to -1 and abort.

This shouldn't be possible for too long because oom_reaper would
make it invisible to the oom killer so it should proceed. Also
mem_cgroup_out_of_memory takes a mutex and that is an implicit
scheduling point already.

Which kernel version is this?

And just for the clarification. I am not against the additional
cond_resched. That sounds like a good thing in general because we do
want to have a predictable scheduling during reclaim which is
independent on reclaimability as much as possible. But I would like to
drill down to why you are seeing the lockup because those shouldn't
really happen.

-- 
Michal Hocko
SUSE Labs
