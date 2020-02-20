Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEB7C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE500206F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 15:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgBTPDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 10:03:49 -0500
Received: from foss.arm.com ([217.140.110.172]:44526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728134AbgBTPDt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 10:03:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F291D31B;
        Thu, 20 Feb 2020 07:03:48 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E0993F703;
        Thu, 20 Feb 2020 07:03:47 -0800 (PST)
Date:   Thu, 20 Feb 2020 15:03:44 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     chris hyser <chris.hyser@oracle.com>
Cc:     Parth Shah <parth@linux.ibm.com>, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        dhaval.giani@oracle.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, pavel@ucw.cz, qperret@qperret.net,
        David.Laight@ACULAB.COM, pjt@google.com, tj@kernel.org
Subject: Re: [PATCH v3 0/3] Introduce per-task latency_nice for scheduler
 hints
Message-ID: <20200220150343.dvweamfnk257pg7z@e107158-lin.cambridge.arm.com>
References: <20200116120230.16759-1-parth@linux.ibm.com>
 <8ed0f40c-eeb4-c487-5420-a8eb185b5cdd@linux.ibm.com>
 <c7e5b9da-66a3-3d69-d7aa-0319de3aa736@oracle.com>
 <971909ed-d4e0-6afa-d20b-365ede5a195e@linux.ibm.com>
 <8e984496-e89b-d96c-d84e-2be7f0958ea4@oracle.com>
 <1e216d18-7ec0-4a0d-e124-b730d6e03e6f@oracle.com>
 <de5d8886-6f70-a3fa-8061-5877cd1d98f5@linux.ibm.com>
 <7429e0ae-41ff-e9c4-dd65-3ef1919f5f50@linux.ibm.com>
 <a332d633-7826-b85d-5d9f-5e34f9de084a@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a332d633-7826-b85d-5d9f-5e34f9de084a@oracle.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/20/20 09:30, chris hyser wrote:
> > The below diff works out well enough in-order to align permission checks
> > with NICE.
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 2bfcff5623f9..ef4a397c9170 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -4878,6 +4878,10 @@ static int __sched_setscheduler(struct task_struct *p,
> >                          return -EINVAL;
> >                  if (attr->sched_latency_nice < MIN_LATENCY_NICE)
> >                          return -EINVAL;
> > +               /* Use the same security checks as NICE */
> > +               if (attr->sched_latency_nice < p->latency_nice &&
> > +                   !can_nice(p, attr->sched_latency_nice))
> > +                       return -EPERM;
> >          }
> > 
> >          if (pi)
> > 
> > With the above in effect,
> > A non-root user can only increase the value upto +19, and once increased
> > cannot be decreased. e.g., a user once sets the value latency_nice = 19,
> > the same user cannot set the value latency_nice = 18. This is the same
> > effect as with NICE.
> > 
> > Is such permission checks required?
> > 
> > Unlike NICE, we are going to use latency_nice for scheduler hints only, and
> > so won't it make more sense to allow a user to increase/decrease the values
> > of their owned tasks?
> 
> Whether called a hint or not, it is a trade-off to reduce latency of select
> tasks at the expense of the throughput of the other tasks in the the system.

Does it actually affect the throughput of the other tasks? I thought this will
allow the scheduler to reduce latencies, for instance, when selecting which cpu
it should land on. I can't see how this could hurt other tasks.

Can you expand on the scenario you have in mind please?

> If any of the other tasks belong to other users, you would presumably
> require permission.

AFAIU security_task_setscheduler() will only allow a change if the task is
changing its own attribute value or has SYS_CAP_NICE.

If you're able to change the attribute of another task, then its not only
latency_nice that's broken here.

Thanks

--
Qais Yousef
