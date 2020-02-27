Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDD1BC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA94B24693
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728915AbgB0LoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:44:07 -0500
Received: from foss.arm.com ([217.140.110.172]:49044 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728865AbgB0LoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:44:07 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7C7E61FB;
        Thu, 27 Feb 2020 03:44:06 -0800 (PST)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D8323F73B;
        Thu, 27 Feb 2020 03:44:04 -0800 (PST)
Date:   Thu, 27 Feb 2020 11:44:02 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Parth Shah <parth@linux.ibm.com>
Cc:     vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        chris.hyser@oracle.com, patrick.bellasi@matbug.net,
        valentin.schneider@arm.com, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, David.Laight@ACULAB.COM, pjt@google.com,
        pavel@ucw.cz, tj@kernel.org, dhaval.giani@oracle.com,
        qperret@google.com
Subject: Re: [PATCH v4 4/4] sched/core: Add permission checks for setting the
 latency_nice value
Message-ID: <20200227114401.uz5p2e7mcomzoo5k@e107158-lin.cambridge.arm.com>
References: <20200224085918.16955-1-parth@linux.ibm.com>
 <20200224085918.16955-5-parth@linux.ibm.com>
 <20200224132905.32sdpbydnzypib47@e107158-lin.cambridge.arm.com>
 <9a4132f2-62cc-4132-1c6d-964ed679afc7@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a4132f2-62cc-4132-1c6d-964ed679afc7@linux.ibm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/25/20 12:17, Parth Shah wrote:
> 
> 
> On 2/24/20 6:59 PM, Qais Yousef wrote:
> > On 02/24/20 14:29, Parth Shah wrote:
> >> Since the latency_nice uses the similar infrastructure as NICE, use the
> >> already existing CAP_SYS_NICE security checks for the latency_nice. This
> >> should return -EPERM for the non-root user when trying to set the task
> >> latency_nice value to any lower than the current value.
> >>
> >> Signed-off-by: Parth Shah <parth@linux.ibm.com>
> > 
> > I'm not against this, so I'm okay if it goes in as is.
> > 
> > But IMO the definition of this flag is system dependent and I think it's
> > prudent to keep it an admin only configuration.
> > 
> > It'd be hard to predict how normal application could use and depend on this
> > feature in the future, which could tie our hand in terms of extending it.
> > 
> 
> I am fine with this going in too. But just to lie down the fact on single
> page and starting the discussion, here are the pros and cons for including
> this permission checks:
> 
> Pros:
> =====
> - Having this permission checks will allow only root users to promote the
> task, meaning lowering the latency_nice of the task. This is required in
> case when the admin has increased the latency_nice value of a task and
> non-root user can not lower it.
> - In absence of this check, the non-root user can decrease the latency_nice
> value against the admin configured value.
> 
> Cons:
> =====
> - This permission check prevents the non-root user to lower the value. This
> is a problem when the user itself has increased the latency_nice value in
> the past but fails to lower it again.
> - After task fork, non-root user cannot lower the inherited child task's
> latency_nice value, which might be a problem in the future for extending
> this latency_nice ideas for different optimizations.

Worth adding that if we start strict with root (or capable user) only, relaxing
this to allow lowering the nice would still be possible in the future. But the
opposite is not true, we can't reverse the users ability to lower its
latency_nice value once we give it away.

Beside thinking a bit more about it now. If high latency_nice value means
cutting short the idle search for instance, does this prevent someone using
a lower latency nice to be aggressive in some code path to get higher
throughput?

I think this lack of clarity is what makes me think it's better to start
conservative and expand when needed.

My 2p :)

Cheers

--
Qais Yousef
