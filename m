Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD9AC35242
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB5820718
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 11:30:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404330AbgAXLa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 06:30:57 -0500
Received: from foss.arm.com ([217.140.110.172]:50188 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404317AbgAXLa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 06:30:56 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B1A99328;
        Fri, 24 Jan 2020 03:30:55 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EAB613F68E;
        Fri, 24 Jan 2020 03:30:53 -0800 (PST)
Date:   Fri, 24 Jan 2020 11:30:51 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Quentin Perret <qperret@google.com>, Wei Wang <wvw@google.com>,
        wei.vince.wang@gmail.com, dietmar.eggemann@arm.com,
        chris.redpath@arm.com, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RFC] sched: restrict iowait boost for boosted task only
Message-ID: <20200124113050.i6ovkibcmutypm3q@e107158-lin>
References: <20200124002811.228334-1-wvw@google.com>
 <20200124025238.jsf36n6w4rrn2ehc@e107158-lin>
 <20200124095125.GA121494@google.com>
 <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <849cc9f0-f4ae-f2b6-8449-f55697928cf5@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/24/20 11:01, Valentin Schneider wrote:
> On 24/01/2020 09:51, Quentin Perret wrote:
> >>> +static inline bool iowait_boosted(struct task_struct *p)
> >>> +{
> >>> +	return p->in_iowait && uclamp_eff_value(p, UCLAMP_MIN) > 0;
> >>
> >> I think this is overloading the usage of util clamp. You're basically using
> >> cpu.uclamp.min to temporarily switch iowait boost on/off.
> >>
> >> Isn't it better to add a new cgroup attribute to toggle this feature?
> >>
> >> The problem does seem generic enough and could benefit other battery-powered
> >> devices outside of the Android world. I don't think the dependency on uclamp &&
> >> energy model are necessary to solve this.
> > 
> > I think using uclamp is not a bad idea here, but perhaps we could do
> > things differently. As of today the iowait boost escapes the clamping
> > mechanism, so one option would be to change that. That would let us set
> > a low max clamp in the 'background' cgroup, which in turns would limit
> > the frequency request for those tasks even if they're IO-intensive.
> > 
> 
> So I'm pretty sure we *do* want tasks with the default clamps to get iowait
> boost'd. What we don't want are background tasks driving up the frequency,
> and that should be via uclamp.max (as Quentin is suggesting) rather than
> uclamp.min (as is suggested in the patch).
> 
> Now, whether that is overloading the usage of uclamp... I'm not sure.
> One of the argument for uclamp was actually frequency selection, so if
> we just make iowait boost respect that, IOW not boost further than
> uclamp.max (which is a bit better than a simple on/off switch), that
> wouldn't be too crazy I think.

Capping iowait boost value in schedutil based on uclamp makes sense indeed.

What didn't make sense to me is the use of uclamp as a switch to toggle iowait
boost on/off.

Cheers

--
Qais Yousef
