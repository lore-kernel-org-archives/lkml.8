Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1FCAC33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DBE22080D
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 05:32:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Ylwipr+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbgBCFcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 00:32:51 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:56824 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727210AbgBCFcv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 00:32:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580707968; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=9gFjlGkGSne0S6SuTxy0HoKJ0QJL+VARjcPMRqrgWMo=; b=Ylwipr+sTXwUImJZsdUCde6mtV6jIf1HjbNx8J4332eT5C81RfsvIzkNNWN8zdOYpiwgb79Q
 WwuHJPvtVlxVDBZzQWIJaiN7eIsZhN3r3mxRtE9E87BPZF/1tZdm+nvDqvNze9OzyylTfwWq
 FKGbP+QnIpDJlEDQbrRB2kBzPy8=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e37b07c.7ff5540cab20-smtp-out-n01;
 Mon, 03 Feb 2020 05:32:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CBA6EC447A0; Mon,  3 Feb 2020 05:32:44 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 64CA9C433CB;
        Mon,  3 Feb 2020 05:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 64CA9C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Mon, 3 Feb 2020 11:02:35 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] sched: rt: Make RT capacity aware
Message-ID: <20200203053235.GE27398@codeaurora.org>
References: <20191009104611.15363-1-qais.yousef@arm.com>
 <20200131100629.GC27398@codeaurora.org>
 <20200131153405.2ejp7fggqtg5dodx@e107158-lin.cambridge.arm.com>
 <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IrhDeMKUP4DT/M7F"
Content-Disposition: inline
In-Reply-To: <CAEU1=PnYryM26F-tNAT0JVUoFcygRgE374JiBeJPQeTEoZpANg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IrhDeMKUP4DT/M7F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Qais,

On Sat, Feb 01, 2020 at 07:08:34AM +0530, Pavan Kondeti wrote:
> Hi Qais,
> 
> On Fri, Jan 31, 2020 at 9:04 PM Qais Yousef <qais.yousef@arm.com> wrote:
> 
> > Hi Pavan
> >
> > On 01/31/20 15:36, Pavan Kondeti wrote:
> > > Hi Qais,
> > >
> > > On Wed, Oct 09, 2019 at 11:46:11AM +0100, Qais Yousef wrote:
> >
> > [...]
> >
> > > >
> > > > For RT we don't have a per task utilization signal and we lack any
> > > > information in general about what performance requirement the RT task
> > > > needs. But with the introduction of uclamp, RT tasks can now control
> > > > that by setting uclamp_min to guarantee a minimum performance point.
> >
> > [...]
> >
> > > > ---
> > > >
> > > > Changes in v2:
> > > >     - Use cpupri_find() to check the fitness of the task instead of
> > > >       sprinkling find_lowest_rq() with several checks of
> > > >       rt_task_fits_capacity().
> > > >
> > > >       The selected implementation opted to pass the fitness function
> > as an
> > > >       argument rather than call rt_task_fits_capacity() capacity which
> > is
> > > >       a cleaner to keep the logical separation of the 2 modules; but it
> > > >       means the compiler has less room to optimize
> > rt_task_fits_capacity()
> > > >       out when it's a constant value.
> > > >
> > > > The logic is not perfect. For example if a 'small' task is occupying a
> > big CPU
> > > > and another big task wakes up; we won't force migrate the small task
> > to clear
> > > > the big cpu for the big task that woke up.
> > > >
> > > > IOW, the logic is best effort and can't give hard guarantees. But
> > improves the
> > > > current situation where a task can randomly end up on any CPU
> > regardless of
> > > > what it needs. ie: without this patch an RT task can wake up on a big
> > or small
> > > > CPU, but with this it will always wake up on a big CPU (assuming the
> > big CPUs
> > > > aren't overloaded) - hence provide a consistent performance.
> >
> > [...]
> >
> > > I understand that RT tasks run on BIG cores by default when uclamp is
> > enabled.
> > > Can you tell what happens when we have more runnable RT tasks than the
> > BIG
> > > CPUs? Do they get packed on the BIG CPUs or eventually silver CPUs pull
> > those
> > > tasks? Since rt_task_fits_capacity() is considered during wakeup, push
> > and
> > > pull, the tasks may get packed on BIG forever. Is my understanding
> > correct?
> >
> > I left up the relevant part from the commit message and my 'cover-letter'
> > above
> > that should contain answers to your question.
> >
> > In short, the logic is best effort and isn't a hard guarantee. When the
> > system
> > is overloaded we'll still spread, and a task that needs a big core might
> > end up
> > on a little one. But AFAIU with RT, if you really want guarantees you need
> > to
> > do some planning otherwise there are no guarantees in general that your
> > task
> > will get what it needs.
> >
> > But I understand your question is for the general purpose case. I've
> > hacked my
> > notebook to run a few tests for you
> >
> >
> > https://gist.github.com/qais-yousef/cfe7487e3b43c3c06a152da31ae09101
> >
> > Look at the diagrams in "Test {1, 2, 3} Results". I spawned 6 tasks which
> > match
> > the 6 cores on the Juno I ran on. Based on Linus' master from a couple of
> > days.
> >
> > Note on Juno cores 1 and 2 are the big cors. 'b_*' and 'l_*' are the task
> > names
> > which are remnants from my previous testing where I spawned different
> > numbers
> > of big and small tasks.
> >
> > I repeat the same tests 3 times to demonstrate the repeatability. The logic
> > causes 2 tasks to run on a big CPU, but there's spreading. IMO on a general
> > purpose system this is a good behavior. On a real time system that needs
> > better
> > guarantee then there's no alternative to doing proper RT planning.
> >
> > In the last test I just spawn 2 tasks which end up on the right CPUs, 1
> > and 2.
> > On system like Android my observations has been that there are very little
> > concurrent RT tasks active at the same time. So if there are some tasks in
> > the
> > system that do want to be on the big CPU, they most likely to get that
> > guarantee. Without this patch what you get is completely random.
> >
> >
> Thanks for the results. I see that tasks are indeed spreading on to silver.
> However it is not
> clear to me from the code how tasks would get spread. Because cpupri_find()
> never returns
> little CPU in the lowest_mask because RT task does not fit on little CPU.
> So from wake up
> path, we place the task on the previous CPU or BIG CPU. The push logic also
> has the
> RT capacity checks, so an overloaded BIG CPU may not push tasks to an idle
> (RT free) little CPU.
> 
> 

I pulled your patch on top of v5.5 and run the below rt-app test on SDM845
platform. We expect 5 RT tasks to spread on different CPUs which was happening
without the patch. With the patch, I see one of the task got woken up on a CPU
which is running another RT task.

{
	"tasks" : {
		"big-task" : {
			"instance" : 5,
			"loop" : 10,
			"sleep" : 100000,
			"runtime" : 100000,
		},
	},
	"global" : {
		"duration" : -1,
		"calibration" : 720,
		"default_policy" : "SCHED_FIFO",
		"pi_enabled" : false,
		"lock_pages" : false,
		"logdir" : "/",
		"log_basename" : "rt-app2",
		"ftrace" : false,
		"gnuplot" : false
	}
}

Full trace is attached. Copy/pasting the snippet where it shows packing is
happening. The custom trace_printk are added in cpupri_find() before calling
fitness_fn(). As you can see pid=535 is woken on CPU#7 where pid=538 RT task
is runnning. Right after waking, the push is tried but it did not work either.

This is not a serious problem for us since we don't set RT tasks
uclamp.min=1024 . However, it changed the behavior and might introduce latency
for RT tasks on b.L platforms running the upstream kernel as is.

        big-task-538   [007] d.h.   403.401633: irq_handler_entry: irq=3 name=arch_timer
        big-task-538   [007] d.h2   403.401633: sched_waking: comm=big-task pid=535 prio=89 target_cpu=007
        big-task-538   [007] d.h2   403.401635: cpupri_find: before task=big-task-535 lowest_mask=f
        big-task-538   [007] d.h2   403.401636: cpupri_find: after task=big-task-535 lowest_mask=0
        big-task-538   [007] d.h2   403.401637: cpupri_find: it comes here
        big-task-538   [007] d.h2   403.401638: find_lowest_rq: task=big-task-535 ret=0 lowest_mask=0
        big-task-538   [007] d.h3   403.401640: sched_wakeup: comm=big-task pid=535 prio=89 target_cpu=007
        big-task-538   [007] d.h3   403.401641: cpupri_find: before task=big-task-535 lowest_mask=f
        big-task-538   [007] d.h3   403.401642: cpupri_find: after task=big-task-535 lowest_mask=0
        big-task-538   [007] d.h3   403.401642: cpupri_find: it comes here
        big-task-538   [007] d.h3   403.401643: find_lowest_rq: task=big-task-535 ret=0 lowest_mask=0
        big-task-538   [007] d.h.   403.401644: irq_handler_exit: irq=3 ret=handled
        big-task-538   [007] d..2   403.402413: sched_switch: prev_comm=big-task prev_pid=538 prev_prio=89 prev_state=S ==> next_comm=big-task next_pid=535 next_prio=89

Thanks,
Pavan
-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.


--IrhDeMKUP4DT/M7F
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="trace.tar.gz"
Content-Transfer-Encoding: base64

H4sIAMutN14AA+29YY8dN3I2ms/5FQPsl1zkjrabTbLZwvULvNgk8OIiusHuBgjeIDBka7wS
vJa9khwnQH78JXnOmcNmV5FFVnHmCNAE2XidmYfVZLFYLFY99enD6+8eXnz6r09/M+5n8j9W
67+ZZrOsk43/fZmn+H9nMy/a/7t5sbNZldUm/J4yk/6bu2mgTI8/v3z89PrD3d3f/PzDT+/f
PHx6h//ew4ePTyHQ0/785u5T0IAPL+/e//Tz3/7mb39z9/D+04d3Dx/v372///aX779/+PDb
y7/59cO7T58e3r+80/7nt+E/7u7ufvMvL138u+LPN/fh56v/dffuw18/3v/0/feVP/jt6S/8
H7x/eHhz/+Hh43dvH96U/+h/zn/l/+jt6w9v/Ei//fjT95/8/6383fkP/d/9/OHh4cefP92/
efj509vaX4U/Cz9vHv7y+r93v/yn//3H//f+X37/D/4ff/cv//qb+Mv/E/8fv//nf/zjn/73
P//L3d0//eur3/3p9//fq3yU/7n7n8d/uv7h+b+e/+lvw3+G75uX6f7Nr98t92qd/L/6d7+h
/uPuzYsXi/8velIvls3Mk3p5F2fvm19f//Du/Z9f3n33048/fvX6zbdv7n5+9+Yrv+f8d7/7
6atZTXd+L/z54dM33/38y1d+b1bH0ck4Wr+8e/fzu28+vH738eHlBenH1x9/+Go6//zfrH9Q
d3/3h5Me/PIX/x13795/evjw4ZefP338v5oENemEPPzys+SEqGQc5y7jfPz13afv3r4M6vWf
38TBUozTv44je7DTfwnD6+30X7yB+vTw1R/vvoq74b8+nRA+/vr655/95pxO/y78+eUfz7L/
7V6xPr69N8qdhNUHLdmWmpbMyKQs1XGSyVfzNFhLXEVLyIJWtYQyIf/Puzd/efhf91P8L49a
MqfjWI/88y/fhF/0I8a1ns//5qv6GpoESm3lNTRqQ0Q21XFsMs4yeKd76frXcCeoKa8hZ0KS
na70hO/0j2+v+ztAXPd3GDTZ4P8H2eCassFzPTvqs15B5fjh158+/BBGeTmfpmRBZkRXRnu1
U0XtwJkXG20//6Y0/4/T+LgME74If8gWIRX4cRm81MA6JL96bxZUVluQdTc9j0qz4OL+Xl5n
Uttkt4JtKi3R7KHep1CLUkcorTa92VVt5oI5N2Hq81kS/NP/fkmyGRDoqz2oOYP+17tP/Zi7
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

--IrhDeMKUP4DT/M7F--
