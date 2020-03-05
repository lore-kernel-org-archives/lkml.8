Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FFFBC3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:43:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2B7208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 12:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgCEMn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 07:43:28 -0500
Received: from foss.arm.com ([217.140.110.172]:48132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726049AbgCEMn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:43:28 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274C131B;
        Thu,  5 Mar 2020 04:43:28 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CC1B23F6C4;
        Thu,  5 Mar 2020 04:43:26 -0800 (PST)
Date:   Thu, 5 Mar 2020 12:43:24 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] sched/rt: cpupri_find: Implement fallback
 mechanism for !fit case
Message-ID: <20200305124324.42x6ehjxbnjkklnh@e107158-lin.cambridge.arm.com>
References: <20200302132721.8353-1-qais.yousef@arm.com>
 <20200302132721.8353-2-qais.yousef@arm.com>
 <20200304112739.7b99677e@gandalf.local.home>
 <20200304173925.43xq4wztummxgs3x@e107158-lin.cambridge.arm.com>
 <20200304135404.146c56eb@gandalf.local.home>
 <20200304200153.c4e2p7qnko54pejt@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200304200153.c4e2p7qnko54pejt@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/20 20:01, Qais Yousef wrote:
> On 03/04/20 13:54, Steven Rostedt wrote:
> > > If we fix 1, then assuming found == -1 for all level, we'll still have the
> > > problem that the mask is stale.
> > > 
> > > We can do a full scan again as Tao was suggestion, the 2nd one without any
> > > fitness check that is. But isn't this expensive?
> > 
> > I was hoping to try to avoid that, but it's not that expensive and will
> > probably seldom happen. Perhaps we should run some test cases and trace the
> > results to see how often that can happen.
> > 
> > > 
> > > We risk the mask being stale anyway directly after selecting it. Or a priority
> > > level might become the lowest level just after we dismissed it.
> > 
> > Sure, but that's still a better effort.
> 
> Okay let me run some quick tests and send an updated series if it doesn't
> return something suspicious.

I ran my 6 tasks test which spawns 6 big tasks on 4 little + 2 big system.
I verified that the 2nd fallback search happens during this scenario.

The duration of the run was 10 seconds.

Using tace-cmd record --profile -l select_task_rq_rt I got the following
results for

	A) Falling back to searching the last unfit_priority_idx only
	B) Falling back to a full search with fitness check disabled

A)
  Event: func: select_task_rq_rt() (600) Total: 2486002 Avg: 4143 Max: 11400(ts:1084.358268) Min:1(ts:1080.258259)
  Event: func: select_task_rq_rt() (2) Total: 11900 Avg: 5950 Max: 8680(ts:1079.659145) Min:3220(ts:1079.659288)
  Event: func: select_task_rq_rt() (4) Total: 13080 Avg: 3270 Max: 3580(ts:1079.659815) Min:3080(ts:1079.659475)
  Event: func: select_task_rq_rt() (3) Total: 15240 Avg: 5080 Max: 6260(ts:1079.659222) Min:4180(ts:1079.659591)
  Event: func: select_task_rq_rt() (1) Total: 5500 Avg: 5500 Max: 5500(ts:1079.659344) Min:5500(ts:1079.659344)
  Event: func: select_task_rq_rt() (2) Total: 8440 Avg: 4220 Max: 4600(ts:1079.659380) Min:3840(ts:1079.659786)
  Event: func: select_task_rq_rt() (3) Total: 22920 Avg: 7640 Max: 11100(ts:1079.659672) Min:3620(ts:1079.659891)

B)
  Event: func: select_task_rq_rt() (600) Total: 2468873 Avg: 4114 Max: 12580(ts:510.268625) Min:1(ts:516.868611)
  Event: func: select_task_rq_rt() (4) Total: 19260 Avg: 4815 Max: 7920(ts:507.369259) Min:3340(ts:507.369669)
  Event: func: select_task_rq_rt() (1) Total: 4700 Avg: 4700 Max: 4700(ts:507.369583) Min:4700(ts:507.369583)
  Event: func: select_task_rq_rt() (3) Total: 7640 Avg: 2546 Max: 3320(ts:507.369403) Min:1300(ts:507.369428)
  Event: func: select_task_rq_rt() (2) Total: 8760 Avg: 4380 Max: 5100(ts:507.369497) Min:3660(ts:507.369338)
  Event: func: select_task_rq_rt() (1) Total: 3240 Avg: 3240 Max: 3240(ts:507.369450) Min:3240(ts:507.369450)

So for both the max seems to be ~12us, which I think is fine.

In the profile report I got something like this which I didn't know how to
interpret. The max value is high; ~72ms.

Did I use and look at the profile output correctly? I still have the trace.dat
for the 2 runs.


                |     + 0x266cb00000000
                |     |   1% (1) time:72836320 max:72836320(ts:1079.785460) min:72836320(ts:1079.785460) avg:72836320
                |     |    0x309000a
                |     |    select_task_rq_rt (0xffff800010152c74)
                |     |    0x0
                |     |    0xe885dcc56c
                |     |    0xe885dcdb24
                |     |    0x2788400000000
                |     |    0x1090047




		...



		                + select_task_rq_rt (0xffff800010152c74)
                |   88% (1) time:72100 max:72100(ts:507.369339) min:72100(ts:507.369339) avg:72100
                |    0x24e4b00000000
                |    0x309000a
                |    select_task_rq_rt (0xffff800010152c74)
                |    0x0
                |    0x53be002898
                |    0x53be003b6c
                |    0x26bc400000000
                |


Thanks

--
Qais Yousef

