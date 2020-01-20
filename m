Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 063AEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD43B21D7E
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 15:34:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728596AbgATPeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 10:34:01 -0500
Received: from foss.arm.com ([217.140.110.172]:33770 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726642AbgATPeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 10:34:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1D06630E;
        Mon, 20 Jan 2020 07:34:00 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DBB83F52E;
        Mon, 20 Jan 2020 07:33:58 -0800 (PST)
Date:   Mon, 20 Jan 2020 15:33:56 +0000
From:   Mark Rutland <mark.rutland@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     James Clark <James.Clark@arm.com>, Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, nd <nd@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Al Grant <Al.Grant@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Return EINVAL when precise_ip perf events are
 requested on Arm
Message-ID: <20200120153355.GC43842@lakrids.cambridge.arm.com>
References: <20200115105855.13395-1-james.clark@arm.com>
 <20200115105855.13395-2-james.clark@arm.com>
 <20200117123920.GB8199@willie-the-truck>
 <20200117140143.GD14879@hirez.programming.kicks-ass.net>
 <1231fd60-79cd-fcdf-8b99-a3be746bf2d1@arm.com>
 <20200117151658.GH14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200117151658.GH14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.11.1+11 (2f07cb52) (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 17, 2020 at 04:16:58PM +0100, Peter Zijlstra wrote:
> On Fri, Jan 17, 2020 at 03:00:37PM +0000, James Clark wrote:
> > Hi Peter,
> > 
> > Do you mean something like this?
> 
> Yes.
> 
> > diff --git a/kernel/events/core.c b/kernel/events/core.c
> > index 43d1d4945433..f74acd085bea 100644
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -10812,6 +10812,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
> >                 goto err_pmu;
> >         }
> >  
> > +       if (event->attr.precise_ip &&
> > +               !(pmu->capabilities & PERF_PMU_CAP_PRECISE_IP)) {
> > +               err = -EOPNOTSUPP;
> > +               goto err_pmu;
> > +       }
> > +
> >         err = exclusive_event_init(event);
> >         if (err)
> >                 goto err_pmu;
> > 
> > 
> > Or should it only be done via sysfs to not break userspace?
> 
> So we've added checks like this in the past and gotten away with it. Do
> you already know of some userspace that will break due to it?
> 
> An alternative approach is adding a sysctl like kernel.perf_nostrict
> which would disable this or something, that way 'old' userspace has a
> chicken bit.

Could we allocate a "strict" bit from perf_event_attr::__reserved_1, and
update drivers to expose a whitelist of fields they support?

Then the core could do something like:

	if (attr->strict && !pmu_check_whitelist(pmu, attr))
		return -EOPNOTSUPP;

... and we could also expose the whitelist somewhere in sysfs.

Thanks,
Mark,
