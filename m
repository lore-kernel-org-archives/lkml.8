Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D68C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6642620768
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 20:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730839AbgIHUFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 16:05:10 -0400
Received: from foss.arm.com ([217.140.110.172]:55426 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730380AbgIHPXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 11:23:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 745241715;
        Tue,  8 Sep 2020 08:22:18 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 599B23F73C;
        Tue,  8 Sep 2020 08:22:17 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:22:15 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        vincent.donnefort@arm.com, mingo@redhat.com, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        valentin.schneider@arm.com
Subject: Re: [PATCH v2] sched/debug: Add new tracepoint to track cpu_capacity
Message-ID: <20200908152214.d7sjawnmnkytv7vk@e107158-lin.cambridge.arm.com>
References: <1598605249-72651-1-git-send-email-vincent.donnefort@arm.com>
 <20200828102724.wmng7p6je2pkc33n@e107158-lin.cambridge.arm.com>
 <1e806d48-fd54-fd86-5b3a-372d9876f360@arm.com>
 <20200828172658.dxygk7j672gho4ax@e107158-lin.cambridge.arm.com>
 <58f5d2e8-493b-7ce1-6abd-57705e5ab437@arm.com>
 <20200902135423.GB93959@lorien.usersys.redhat.com>
 <20200907110223.gtdgqod2iv2w7xmg@e107158-lin.cambridge.arm.com>
 <20200908131954.GA147026@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200908131954.GA147026@lorien.usersys.redhat.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/08/20 09:19, Phil Auld wrote:
> Hi Quais,
> 
> On Mon, Sep 07, 2020 at 12:02:24PM +0100 Qais Yousef wrote:
> > On 09/02/20 09:54, Phil Auld wrote:
> > > > 
> > > > I think this decoupling is not necessary. The natural place for those
> > > > scheduler trace_event based on trace_points extension files is
> > > > kernel/sched/ and here the internal sched.h can just be included.
> > > > 
> > > > If someone really wants to build this as an out-of-tree module there is
> > > > an easy way to make kernel/sched/sched.h visible.
> > > >
> > > 
> > > It's not so much that we really _want_ to do this in an external module.
> > > But we aren't adding more trace events and my (limited) knowledge of
> > > BPF let me to the conclusion that its raw tracepoint functionality
> > > requires full events.  I didn't see any other way to do it.
> > 
> > I did have a patch that allowed that. It might be worth trying to upstream it.
> > It just required a new macro which could be problematic.
> > 
> > https://github.com/qais-yousef/linux/commit/fb9fea29edb8af327e6b2bf3bc41469a8e66df8b
> > 
> > With the above I could attach using bpf::RAW_TRACEPOINT mechanism.
> >
> 
> Yeah, that could work. I meant there was no way to do it with what was there :)
> 
> In our initial attempts at using BPF to get at nr_running (which I was not
> involved in and don't have all the details...) there were issues being able to
> keep up and losing events.  That may have been an implementation issue, but
> using the module and trace-cmd doesn't have that problem. Hopefully you don't
> see that using RAW_TRACEPOINTs.

I haven't played with that since then tbh. I use BPF every now and then, but
rather simplistically. So if I encoutnered such a problem I wouldn't have
noticed.

> Fwiw, I don't think these little helper routines are all that hard to maintain.
> If something changes in those fields, which seems moderately unlikely at least
> for many of them, the compiler will complain.
> 
> And I agree with you about preferring to use the public headers for the module.
> I think we can work around it though, if needed.

+1

Cheers

--
Qais Yousef
