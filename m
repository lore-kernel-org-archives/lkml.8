Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33D9C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:43:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BDCBD206F7
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 18:43:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgDISnT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 14:43:19 -0400
Received: from foss.arm.com ([217.140.110.172]:53376 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726571AbgDISnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 14:43:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E2FA31B;
        Thu,  9 Apr 2020 11:43:19 -0700 (PDT)
Received: from [192.168.1.19] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05D293F73D;
        Thu,  9 Apr 2020 11:43:15 -0700 (PDT)
Subject: Re: [PATCH 4/4] sched/deadline: Implement fallback mechanism for !fit
 case
To:     Qais Yousef <qais.yousef@arm.com>,
        luca abeni <luca.abeni@santannapisa.it>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Wei Wang <wvw@google.com>, Quentin Perret <qperret@google.com>,
        Alessio Balsini <balsini@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
References: <20200408095012.3819-1-dietmar.eggemann@arm.com>
 <20200408095012.3819-5-dietmar.eggemann@arm.com>
 <20200409102557.h4humnsa5dlwvlym@e107158-lin.cambridge.arm.com>
 <20200409150010.468951df@sweethome>
 <20200409145359.y276yeikn7dp6jmx@e107158-lin.cambridge.arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <b72f72c1-6043-c44f-31f5-fb4137bd5d52@arm.com>
Date:   Thu, 9 Apr 2020 20:43:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200409145359.y276yeikn7dp6jmx@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.04.20 16:55, Qais Yousef wrote:
> Hi Luca
> 
> On 04/09/20 15:00, luca abeni wrote:

[...]

>> There is already a tunable for the SCHED_DEADLINE admission test
>> (/proc/sys/kernel/sched_rt_{runtime,period}_us, if I understand well
>> what you are suggesting). The problem is that it is not easy to find a
>> value for this tunable that guarantees the hard respect of all
>> deadlines.
> 
> I don't think it's similar to what I was referring to. But my knowledge about
> DL could have failed me to fully appreciate what you're saying.
> 
> This tunable for RT prevents a single task from using 100% CPU time. I think
> DL uses it in a similar manner.
> 
> What I meant by overcommiting, is allowing more DL tasks than the system can
> guarantee to meet their deadlines.
> 
> For example, in the context of capacity awareness, if you have 2 big cores, but
> 4 DL tasks request a bandwidth that can only be satisfied by the big cores,
> then 2 of them will miss their deadlines (almost) consistently, IIUC.

__dl_overflow() now uses

    X = cap_scale(dl_b->bw, rd_capacity(cpu)) instead of X = cpus

in

    dl_b->bw * X < dl_b->total_bw - old_bw + new_bw;


As an example, Arm64 Hikey64 with 4 LITTLE and 4 big CPUs uses now
(4x462 + 4x1024)/1024 = 5944/1024 ~ 5,80 instead of 8 CPUs.

On mainline, the rt-app tests:

"tasks" : {
 "thread0" : {
  "policy" : "SCHED_DEADLINE",
  "instance" : 8,
  "timer" : {"ref" : "unique0", "period" : 16000, "mode" : "absolute" },
  "run" : 10000,
  "dl-runtime" :11000,
  "dl-period" : 16000,
  "dl-deadline" : 16000
  }
}

is admitted on this board whereas with the patchset some of the tasks
are rejected:

[rt-app] <crit> [7] sched_setattr returned -1
sched_setattr: failed to set deadline attributes: Device or resource busy

---

IMHO, one of the 3 places where DL Admission Control hooks into is:

    __sched_setscheduler -> sched_dl_overflow() ->__dl_overflow()

[...]
