Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67206C35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0913724650
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 03:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="xUld4MdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBYDzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 22:55:40 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:29341 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726962AbgBYDzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 22:55:40 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582602939; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=s35BPNR6Z45kmkW/uZVQApEVNGV6Tou60aGUAhwOQt4=; b=xUld4MdSUBAmhxKRdwbrDLGX3A5pJr0pX755vZhl+G6C0W7vz9gjdp0j6eFFDSQ/zIVZ0Rcw
 sz2//BeWjD5/msinWx8p9GDvEqjC6MWnuHcTz++JJoSChJUZcywxbif/4Uop0DX3HZgowLmP
 rDeGU4VaXXTqamu/x8TLAUuHBOM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e549aa3.7f32c5460a08-smtp-out-n03;
 Tue, 25 Feb 2020 03:55:15 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59122C447A2; Tue, 25 Feb 2020 03:55:13 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 13E91C43383;
        Tue, 25 Feb 2020 03:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 13E91C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Tue, 25 Feb 2020 09:25:05 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] sched/rt: Better manage pushing unfit tasks on
 wakeup
Message-ID: <20200225035505.GI28029@codeaurora.org>
References: <20200223184001.14248-1-qais.yousef@arm.com>
 <20200223184001.14248-6-qais.yousef@arm.com>
 <20200224061004.GH28029@codeaurora.org>
 <20200224121139.cbz2dt5heiouknif@e107158-lin.cambridge.arm.com>
 <CAEU1=PncyV=-vqjkDHSJ4hUhhTfYUgVN-HAe4zXMHtFx1oc5XA@mail.gmail.com>
 <20200224174138.n6pmoeffqg7eqiy2@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224174138.n6pmoeffqg7eqiy2@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 05:41:39PM +0000, Qais Yousef wrote:
> On 02/24/20 21:34, Pavan Kondeti wrote:
> > Hi Qais,
> > 
> > On Mon, Feb 24, 2020 at 5:42 PM Qais Yousef <qais.yousef@arm.com> wrote:
> > [...]
> > > We could do, temporarily, to get these fixes into 5.6. But I do think
> > > select_task_rq_rt() doesn't do a good enough job into pushing unfit tasks to
> > > the right CPUs.
> > >
> > > I don't understand the reasons behind your objection. It seems you think that
> > > select_task_rq_rt() should be enough, but not AFAICS. Can you be a bit more
> > > detailed please?
> > >
> > > FWIW, here's a screenshot of what I see
> > >
> > >         https://imgur.com/a/peV27nE
> > >
> > > After the first activation, select_task_rq_rt() fails to find the right CPU
> > > (due to the same move all tasks to the cpumask_fist()) - but when the task
> > > wakes up on 4, the logic I put causes it to migrate to CPU2, which is the 2nd
> > > big core. CPU1 and CPU2 are the big cores on Juno.
> > >
> > > Now maybe we should fix select_task_rq_rt() to better balance tasks, but not
> > > sure how easy is that.
> > >
> > 
> > Thanks for the trace. Now things are clear to me. Two RT tasks woke up
> > simultaneously and the first task got its previous CPU i.e CPU#1. The next task
> > goes through find_lowest_rq() and got the same CPU#1. Since this task priority
> > is not more than the just queued task (already queued on CPU#1), it is sent
> > to its previous CPU i.e CPU#4 in your case.
> > 
> > From task_woken_rt() path, CPU#4 attempts push_rt_tasks(). CPU#4 is
> > not overloaded,
> > but we have rt_task_fits_capacity() check which forces the push. Since the CPU
> > is not overloaded, your has_unfit_tasks() comes to rescue and push the
> > task. Since
> > the task has not scheduled in yet, it is eligible for push. You added checks
> > to skip resched_curr() in push_rt_tasks() otherwise the push won't happen.
> 
> Nice summary, that's exactly what it is :)
> 
> > Finally, I understood your patch. Obviously this is not clear to me
> > before. I am not
> > sure if this patch is the right approach to solve this race. I will
> > think a bit more.
> 
> I haven't been staring at this code for as long as you, but since we have
> logic at wakeup to do a push, I think we need something here anyway for unfit
> tasks.
> 
> Fixing select_task_rq_rt() to better balance tasks will help a lot in general,
> but if that was enough already then why do we need to consider a push at the
> wakeup at all then?
> 
> AFAIU, in SMP the whole push-pull mechanism is racy and we introduce redundancy
> at taking the decision on various points to ensure we minimize this racy nature
> of SMP systems. Anything could have happened between the time we called
> select_task_rq_rt() and the wakeup, so we double check again before we finally
> go and run. That's how I interpret it.
> 
> I am open to hear about other alternatives first anyway. Your help has been
> much appreciated so far.
> 

The search inside find_lowest_rq() happens without any locks so I believe it
is expected to have races like this. In fact there is a comment in the code
saying "This test is optimistic, if we get it wrong the load-balancer
will have to sort it out" in select_task_rq_rt(). However, the push logic
as of today works only for overloaded case. In that sense, your patch fixes
this race for b.L systems. At the same time, I feel like tracking nonfit tasks
just to fix this race seems to be too much. I will leave this to Steve and
others to take a decision.

I thought of suggesting to remove the below check from select_task_rq_rt()

p->prio < cpu_rq(target)->rt.highest_prio.curr

which would then make the target CPU overloaded and the push logic would
spread the tasks. That works for a b.L system too. However there seems to
be a very good reason for doing this. see
https://lore.kernel.org/patchwork/patch/539137/

The fact that a CPU is part of lowest_mask but running a higher prio RT
task means there is a race. Should we retry one more time to see if we find
another CPU?

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
