Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510F0C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 280B6206B6
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 16:11:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728658AbgBLQLK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 11:11:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:36448 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbgBLQLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 11:11:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 66C18AE84;
        Wed, 12 Feb 2020 16:11:06 +0000 (UTC)
Date:   Wed, 12 Feb 2020 16:11:03 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Phil Auld <pauld@redhat.com>, Parth Shah <parth@linux.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Subject: Re: [PATCH 1/4] sched/fair: reorder enqueue/dequeue_task_fair path
Message-ID: <20200212161103.GX3420@suse.de>
References: <20200211174651.10330-1-vincent.guittot@linaro.org>
 <20200211174651.10330-2-vincent.guittot@linaro.org>
 <20200212132036.GT3420@suse.de>
 <CAKfTPtAM=kgF7Fz-JKFY+s_k5KFirs-8Bub3s1Eqtq7P0NMa0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtAM=kgF7Fz-JKFY+s_k5KFirs-8Bub3s1Eqtq7P0NMa0w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 03:47:30PM +0100, Vincent Guittot wrote:
> > I'm having trouble reconciling the patch with the description and the
> > comments explaining the intent behind the code are unhelpful.
> >
> > There are two loops before and after your patch -- the first dealing with
> > sched entities that are not on a runqueue and the second for the remaining
> > entities that are. The intent appears to be to update the load averages
> > once the entity is active on a runqueue.
> >
> > I'm not getting why the changelog says everything related to cfs is
> > now done in one loop because there are still two. But even if you do
> > get throttled, it's not clear why you jump to the !se check given that
> > for_each_sched_entity did not complete. What it *does* appear to do is
> > have all the h_nr_running related to entities being enqueued updated in
> > one loop and all remaining entities stats updated in the other.
> 
> Let's take the example of 2 levels in addition to root so we have :
> root->cfs1->cfs2
> Now we enqueue a task T1 on cfs2 but cfs1 is throttled, we will have
> the sequence:
> 
> In 1st for_each_sched_entity loop:
>   loop 1
>     enqueue_entity (T1->se, cfs2) which calls update load_avg(cfs2)
>     cfs2->h_nr_running++;
>   loop 2
>     enqueue_entity (cfs2->gse, cfs1) which calls update load_avg(cfs1)
>     break because cfs1 is throttled
> 
> In 2nd for_each_sched_entity loop:
>   loop 1
>     cfs1->h_nr_running++
>     break because throttled
> 
> Using the 2nd loop for incrementing h_nr_running of the throttled cfs
> is useless and we could do that directly in 1st loop and skip the 2nd
> loop
> 
> With this patch we have :
> 
> In 1st for_each_sched_entity loop:
>   loop 1
>     enqueue_entity (T1->se, cfs2) which update load_avg(cfs2)
>     cfs2->h_nr_running++;
>   loop 2
>     enqueue_entity (cfs2->gse, cfs1) which update load_avg(cfs1)
>     cfs1->h_nr_running++
>     skip the 2nd for_each_sched_entity entirely
> 
> Then the patch also reorders the call to update_load_avg() and the
> increment of h_nr_running
> 
> Before the patch we had different order between the to
> for_each_sched_entity which is not a problem because there is
> currently no relation between both. But the following patches make
> PELT using h_nr_running so we must have the same ordering to prevent
> updating pelt with the wrong h_nr_running value
> 

Ok, understood. Thanks for clearing that up!

-- 
Mel Gorman
SUSE Labs
