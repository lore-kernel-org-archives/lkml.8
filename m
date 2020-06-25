Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB766C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B3FD8206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405344AbgFYOUt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:20:49 -0400
Received: from foss.arm.com ([217.140.110.172]:51444 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404890AbgFYOUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:20:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6A8C0A;
        Thu, 25 Jun 2020 07:20:47 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ECA833F73C;
        Thu, 25 Jun 2020 07:20:45 -0700 (PDT)
Date:   Thu, 25 Jun 2020 15:20:43 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200625142043.dicfhqop4hkhr7ji@e107158-lin.cambridge.arm.com>
References: <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
 <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
 <CAJWu+ooXdgqSGisZXnHBtYLo9oQBiaNR=HhKseBN+YFGz-L6Xg@mail.gmail.com>
 <20200624165500.idrugfgplqgi654v@e107158-lin.cambridge.arm.com>
 <CAJWu+oqHUq6fvkfRgAx4qx8x1dm-J-h6moeVskCU3gkRybCPqQ@mail.gmail.com>
 <20200624175236.nblndmg6dfq2vr2u@e107158-lin.cambridge.arm.com>
 <CAJWu+oreQRCAkBhNQ-n6BPjYsdOL074ff8551sF3r7OxsseEVQ@mail.gmail.com>
 <CAD=FV=Xf29qsiBSUit7xoVpxzLnoBT9vZ+0JBGN2bFefDBKG4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=Xf29qsiBSUit7xoVpxzLnoBT9vZ+0JBGN2bFefDBKG4w@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/20 11:29, Doug Anderson wrote:
> Hi,
> 
> On Wed, Jun 24, 2020 at 10:55 AM Joel Fernandes <joelaf@google.com> wrote:
> >
> > On Wed, Jun 24, 2020 at 1:52 PM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 06/24/20 13:35, Joel Fernandes wrote:
> > >
> > > [...]
> > >
> > > > > Doing the in-kernel opt-out via API should be fine, I think. But this will
> > > > > need to be discussed in the wider circle. It will already clash with this for
> > > > > example
> > > > >
> > > > > https://lore.kernel.org/lkml/20200619172011.5810-1-qais.yousef@arm.com/
> > > >
> > > > Have not yet looked closer at that patch, but are you saying this
> > > > patch clashes with that work? Sorry I am operating on 2 hours of sleep
> > > > here.
> > >
> > > The series is an optimization to remove the uclamp overhead from the scheduler
> > > fastpath until the userspace uses it. It introduces a static key that is
> > > disabled by default and will cause uclamp logic not to execute in the fast
> > > path. Once the userspace starts using util clamp, which we detect by either
> > >
> > >         1. Changing uclamp value of a task with sched_setattr()
> > >         2. Modifying the default sysctl_sched_util_clamp_{min, max}
> > >         3. Modifying the default cpu.uclamp.{min, max} value in cgroup
> > >
> > > If we start having in-kernel users changing uclamp value this means drivers
> > > will cause the system to opt-in into uclamp automatically even if the
> > > userspace doesn't actually use it.
> > >
> > > I think we can solve this by providing a special API to opt-out safely. Which
> > > is the right thing to do anyway even if we didn't have this clash.
> >
> > Makes sense, thanks.
> 
> OK, so I think the summary is:
> 
> 1. There are enough external dependencies that are currently in the
> works that it makes sense for those to land first without trying to
> cram my patch to cros_ec in.

+1

> 
> 2. Maybe, as part of the work that's already going on, someone will
> add an API that I can use.  If so then I can write my patch once that
> lands.

I won't be adding this API. Mainly because I can't argue for it personally as
I'm still not convinced it's a valid way of handling RT default boosting
behavior from within the kernel. But it's a valid discussion to have if you
want to drive it.

> 
> 3. If nobody adds an API then I could look at adding the API myself
> once everything else is settled.
> 
> 4. It looks as if the patch you mentioned originally [1] that allows
> userspace to just fully disable uclamp for RT tasks will land
> eventually (if we're stuck for a short term solution we can pick the
> existing patch).  I believe Chrome OS will use that to just fully
> disable the default boosting for RT tasks across our system and (if
> needed) add boosts on a case-by-case basis.  Once we do that, the
> incentive to land a patch for cros_ec will be mostly gone and probably
> we could consider my patch abandoned.  While it would technically
> still be sane to land it won't have any real-world benefit.

I think this is the best way forward. I'm interesting in hearing what
difficulties you encounter while doing this work.

Regarding the patch [1], I need to tweak the way it is implemented and send v6,
but there are no objection to the idea and interface, so hopefully once I send
v6 it'd be accepted.

Thanks

--
Qais Yousef

> [1] https://lore.kernel.org/r/20200511154053.7822-1-qais.yousef@arm.com
