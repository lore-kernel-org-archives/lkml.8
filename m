Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08EC1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC41720823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:14:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405384AbgFXROn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:14:43 -0400
Received: from foss.arm.com ([217.140.110.172]:45238 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404287AbgFXROn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:14:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 786AF1FB;
        Wed, 24 Jun 2020 10:14:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E77983F71E;
        Wed, 24 Jun 2020 10:14:40 -0700 (PDT)
Date:   Wed, 24 Jun 2020 18:14:38 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Doug Anderson <dianders@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200624171438.olo5qlivf6agbjyn@e107158-lin.cambridge.arm.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
 <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
 <20200624160109.GK4781@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200624160109.GK4781@hirez.programming.kicks-ass.net>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/20 18:01, Peter Zijlstra wrote:
> On Tue, Jun 23, 2020 at 05:40:21PM +0100, Qais Yousef wrote:
> > On 06/22/20 11:21, Doug Anderson wrote:
> > 
> > [...]
> > 
> > > > If you propose something that will help the discussion. I think based on the
> > > > same approach Peter has taken to prevent random RT priorities. In uclamp case
> > > > I think we just want to allow driver to opt RT tasks out of the default
> > > > boosting behavior.
> > > >
> > > > I'm a bit wary that this extra layer of tuning might create a confusion, but
> > > > I can't reason about why is it bad for a driver to say I don't want my RT task
> > > > to be boosted too.
> > > 
> > > Right.  I was basically just trying to say "turn my boosting off".
> > > 
> > > ...so I guess you're saying that doing a v2 of my patch with the
> > > proper #ifdef protection wouldn't be a good way to go and I'd need to
> > > propose some sort of API for this?
> > 
> > It's up to Peter really.
> > 
> > It concerns me in general to start having in-kernel users of uclamp that might
> > end up setting random values (like we ended having random RT priorities), that
> > really don't mean a lot outside the context of the specific system it was
> > tested on. Given the kernel could run anywhere, it's hard to rationalize what's
> > okay or not.
> > 
> > Opting out of default RT boost for a specific task in the kernel, could make
> > sense though it still concerns me for the same reasons. Is this okay for all
> > possible systems this can run on?
> > 
> > It feels better for userspace to turn RT boosting off for all tasks if you know
> > your system is powerful, or use the per task API to switch off boosting for the
> > tasks you know they don't need it.
> > 
> > But if we want to allow in-kernel users, IMO it needs to be done in
> > a controlled way, in a similar manner Peter changed how RT priority can be set
> > in the kernel.
> > 
> > It would be good hear what Peter thinks.
> 
> Hurmph.. I think I understand the problem, but I'm not sure what to do
> about it :-(
> 
> Esp. given the uclamp optimization patches now under consideration. That
> is, if random drivers are going to install uclamps, then that will
> automagically enable the static_key and make the scheduler slower, even
> if that driver isn't particularly interesting to the user.

For some reason this didn't land in my inbox.

Yeah I was considering how we can handle this potential new user without
a clash. But I thought we first need to agree this is indeed the right thing to
do.

The easiest way is to make the new API act on the task struct directly rather
than go through sched_setscheduler(). I.e: a wrapper around uclamp_se_set().

But first, I think we need to consider how accessible we want to keep
sched_setscheduler(). IMO it should be hidden because of its potential
misuse/abuse. Happy to help with that if you agree.

Thanks

--
Qais Yousef
