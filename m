Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FE3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:11:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA5E206A4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 15:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727056AbgE2PLZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 11:11:25 -0400
Received: from foss.arm.com ([217.140.110.172]:37724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2PLZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 11:11:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5D28F1045;
        Fri, 29 May 2020 08:11:24 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A51283F718;
        Fri, 29 May 2020 08:11:21 -0700 (PDT)
Date:   Fri, 29 May 2020 16:11:18 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] sched/uclamp: Add a new sysctl to control RT default
 boost value
Message-ID: <20200529151118.mnysa7jv4l3ntzsk@e107158-lin.cambridge.arm.com>
References: <20200511154053.7822-1-qais.yousef@arm.com>
 <20200528132327.GB706460@hirez.programming.kicks-ass.net>
 <20200528155800.yjrmx3hj72xreryh@e107158-lin.cambridge.arm.com>
 <20200528161112.GI2483@worktop.programming.kicks-ass.net>
 <20200528165130.m5unoewcncuvxynn@e107158-lin.cambridge.arm.com>
 <20200529102125.GB3070@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200529102125.GB3070@suse.de>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/29/20 11:21, Mel Gorman wrote:
> On Thu, May 28, 2020 at 05:51:31PM +0100, Qais Yousef wrote:
> > > Indeed, that one. The fact that regular distros cannot enable this
> > > feature due to performance overhead is unfortunate. It means there is a
> > > lot less potential for this stuff.
> > 
> > I had a humble try to catch the overhead but wasn't successful. The observation
> > wasn't missed by us too then.
> > 
> 
> As with all things, it's perfectly possible I was looking at a workload
> where the cost is more obvious but given that the functions are inlined,
> it's not trivial to spot. I just happened to spot it because I was paying
> close attention to try_to_wake_up() at the time.

Indeed.

> 
> > On my Ubuntu 18.04 machine uclamp is enabled by default by the way. 5.3 kernel
> > though, so uclamp task group stuff not there yet. Should check how their server
> > distro looks like.
> > 
> 
> Elsewhere in the thread, I showed some results based on 5.7 so uclamp
> task group existed but I had it disabled. The uclamp related parts of
> the kconfig were
> 
> # zgrep UCLAMP kconfig-5.7.0-rc7-with-clamp.txt.gz
> CONFIG_UCLAMP_TASK=y
> CONFIG_UCLAMP_BUCKETS_COUNT=5
> # CONFIG_UCLAMP_TASK_GROUP is not set

So you never had the TASK_GROUP part enabled when you noticed the regression?
Or is it the other way around, you just disabled CONFIG_UCLAMP_TASK_GROUP to
'fix' it?

Thanks

--
Qais Yousef
