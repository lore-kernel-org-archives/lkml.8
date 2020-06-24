Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDE29C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6082077D
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405844AbgFXRwo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:52:44 -0400
Received: from foss.arm.com ([217.140.110.172]:49038 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405615AbgFXRwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:52:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38DD91FB;
        Wed, 24 Jun 2020 10:52:42 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0FE63F71E;
        Wed, 24 Jun 2020 10:52:40 -0700 (PDT)
Date:   Wed, 24 Jun 2020 18:52:38 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Joel Fernandes <joelaf@google.com>
Cc:     Doug Anderson <dianders@chromium.org>,
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
Message-ID: <20200624175236.nblndmg6dfq2vr2u@e107158-lin.cambridge.arm.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
 <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
 <CAJWu+ooXdgqSGisZXnHBtYLo9oQBiaNR=HhKseBN+YFGz-L6Xg@mail.gmail.com>
 <20200624165500.idrugfgplqgi654v@e107158-lin.cambridge.arm.com>
 <CAJWu+oqHUq6fvkfRgAx4qx8x1dm-J-h6moeVskCU3gkRybCPqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJWu+oqHUq6fvkfRgAx4qx8x1dm-J-h6moeVskCU3gkRybCPqQ@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/24/20 13:35, Joel Fernandes wrote:

[...]

> > Doing the in-kernel opt-out via API should be fine, I think. But this will
> > need to be discussed in the wider circle. It will already clash with this for
> > example
> >
> > https://lore.kernel.org/lkml/20200619172011.5810-1-qais.yousef@arm.com/
> 
> Have not yet looked closer at that patch, but are you saying this
> patch clashes with that work? Sorry I am operating on 2 hours of sleep
> here.

The series is an optimization to remove the uclamp overhead from the scheduler
fastpath until the userspace uses it. It introduces a static key that is
disabled by default and will cause uclamp logic not to execute in the fast
path. Once the userspace starts using util clamp, which we detect by either

	1. Changing uclamp value of a task with sched_setattr()
	2. Modifying the default sysctl_sched_util_clamp_{min, max}
	3. Modifying the default cpu.uclamp.{min, max} value in cgroup

If we start having in-kernel users changing uclamp value this means drivers
will cause the system to opt-in into uclamp automatically even if the
userspace doesn't actually use it.

I think we can solve this by providing a special API to opt-out safely. Which
is the right thing to do anyway even if we didn't have this clash.

Hope this makes sense.

Cheers

--
Qais Yousef
