Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1ACC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F79A20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 15:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733076AbgFWP4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 11:56:10 -0400
Received: from foss.arm.com ([217.140.110.172]:57980 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732781AbgFWP4K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 11:56:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 329F61F1;
        Tue, 23 Jun 2020 08:56:09 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A222D3F6CF;
        Tue, 23 Jun 2020 08:56:07 -0700 (PDT)
Date:   Tue, 23 Jun 2020 16:56:05 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Doug Anderson <dianders@chromium.org>
Cc:     Quentin Perret <qperret@google.com>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Joel Fernandes <joelaf@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        ctheegal@codeaurora.org, Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
Message-ID: <20200623155507.5l6ck4hder2px3ii@e107158-lin.cambridge.arm.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com>
 <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
 <20200612092454.GA94228@google.com>
 <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
 <CAD=FV=UySLsTaUP3nOfQO98qPEUkY8tMhw25pJ4Yi7FVM5xU6g@mail.gmail.com>
 <20200619153146.vaizbj7muy52zvbd@e107158-lin.cambridge.arm.com>
 <CAD=FV=V0YCS69uErFnY-cF_v44mDfAe4AWa+K+U6mQR+TNLkww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=V0YCS69uErFnY-cF_v44mDfAe4AWa+K+U6mQR+TNLkww@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/22/20 11:19, Doug Anderson wrote:

[...]

> > Hmm I thought OEMs who ship stuff that are based on Chrome OS would have to do
> > the final tuning here, which would be based on the recommendation of the SoC
> > vendor. And I'm being overly generic here to think not only SoC from Intel
> > which traditionally they have been treated in different ways.
> >
> > I think you provide a generic stack for OEMs, no?
> 
> No, that's the Android way.  The only way Chrome OS can ship updates
> for the whole fleet every ~6 weeks and support it for so many years is
> that all the builds and updates happen on Google servers.  The only
> way Google can maintain this is to not have a separate kernel code
> base for every single variant of every single board.

I was referring to userspace tuning, which I expected to be platform specific.
Assuming the devices share the same kernel. At least in the context of uclamp
and RT tuning that should be possible.

I appreciate that you want to ship a simple generic setup on as many
devices. But there will be a trade-off to make between optimal tuning and
keeping things simple and generic. The latter is perfectly fine goal to have
of course. Others who want to tune more they're free to do so too as well.

> 
> 
> > Generally for RT tasks, Linux always required an admin to do the tuning. And to
> > provide an automatic solution that fits all is not easy to happen, because what
> > ultimately is important for userspace, is only known by the userspace.
> >
> > This is an interesting problem for me personally that I have been trying to
> > look at in my free time. On general purpose systems, it's hard to reason about
> > what's important because, as you say, you distribute something that should
> > target a wide range of platforms. And sometimes the end user (like a person
> > installing Ubuntu Desktop on their laptop), have no clue what a driver is even
> > to pick the right tuning for all RT tasks in their system.
> >
> > But this problem already exists and catching up with this will need more work
> > from both distros and maybe kernel. I can't see a possible situation where the
> > kernel can do all the tuning without userspace providing more info anyway.
> >
> > The per-device weirdness you're talking about is just how the way goes in
> > a world where there are many SoCs that are created to target different budgets
> > and use cases.
> 
> I think it's sane for the OS to do very high level tuning, like "this
> platform has an underpowered CPU and being fast is more important than
> battery life, so error on the side of running fast" or "this platform
> has a fast SSD so tune disk algorithms appropriately".  ...but picking
> specific values gets tricky.

You can always use the per-task API to boost that task to maximum, if power is
not your concern. From user-space ;-)

If you're power conscious too, yeah there's no way but to test for the minimum
value that gives you what you want. The task can try to regulate itself too if
it can observe when it's not running fast enough (notices a glitch?).

You can get fancy if you want, depending on your goal.

It's hard to get the best though with one size fits all.

HTH

--
Qais Yousef
