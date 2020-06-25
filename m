Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69D5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:34:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CDB20781
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 11:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404286AbgFYLeN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 07:34:13 -0400
Received: from foss.arm.com ([217.140.110.172]:35978 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404239AbgFYLeM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 07:34:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E11791042;
        Thu, 25 Jun 2020 04:34:11 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3E30D3F73C;
        Thu, 25 Jun 2020 04:34:10 -0700 (PDT)
Date:   Thu, 25 Jun 2020 12:34:07 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chris.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] sched/uclamp: Protect uclamp fast path code with
 static key
Message-ID: <20200625113407.awok7pd64fgt7cii@e107158-lin.cambridge.arm.com>
References: <20200624172605.26715-1-qais.yousef@arm.com>
 <20200624172605.26715-3-qais.yousef@arm.com>
 <jhj5zbgroct.mognet@arm.com>
 <20200625110006.q3iepcrh2uh4oizv@e107158-lin.cambridge.arm.com>
 <jhjpn9ngzlx.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <jhjpn9ngzlx.mognet@arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/25/20 12:26, Valentin Schneider wrote:
> 
> On 25/06/20 12:00, Qais Yousef wrote:
> > Hi Valentin
> >
> > On 06/25/20 01:16, Valentin Schneider wrote:
> >> In schedutil_cpu_util(), when uclamp isn't compiled it, we have an explicit
> >> 'goto max'. When uclamp *is* compiled in, that's taken care of by the
> >> "natural" RT uclamp aggregation... Which doesn't happen until we flip the
> >> static key.
> >>
> >> It's yucky, but if you declare the key in the internal sched header, you
> >> could reuse it in the existing 'goto max' (or sysctl value, when we make
> >> that tweakable) path.
> >
> > Not sure if this is the best way forward. I need to think about it.
> > While I am not keen on enabling in kernel users of util clamp, but there was
> > already an attempt to do so. This approach will not allow us to implement
> > something in the future for that. Which maybe is what we want..
> >
> 
> Just to be clear, I'm not suggesting to add any in-kernel toggling of
> uclamp outside of the scheduler: by keeping that to the internal sched
> header & schedutil, we're keeping it contained to internal scheduler land.
> 
> Since a diff is worth a thousand words, here's what I was thinking of (not
> even compiled):

Yeah I understood and already thought about this. But this approach could
prevent potential in kernel-users. Whether we care or not about this now,
I don't know. But it seems the simplest thing to do.

> 
> >> > -	if (update_root_tg)
> >> > +	if (update_root_tg) {
> >> >            uclamp_update_root_tg();
> >> > +		static_branch_enable(&sched_uclamp_used);
> >>
> >> I don't think it matters ATM, but shouldn't we flip that *before* updating
> >> the TG's to avoid any future surprises?
> >
> > What sort of surprises are you thinking of?
> >
> 
> Say if we end up adding static key checks in some other uclamp functions
> (which are called in the TG update) and don't change this here, someone
> will have to scratch their heads to figure out the key enablement needs to
> be moved one line higher. It's harmless future-proofing, I think.

Hehe okay, I'll change that.

Thanks

--
Qais Yousef
