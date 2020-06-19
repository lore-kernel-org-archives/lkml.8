Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C924C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C33A20786
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405006AbgFSPfJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:35:09 -0400
Received: from foss.arm.com ([217.140.110.172]:39542 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404886AbgFSPbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:31:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E1A12B;
        Fri, 19 Jun 2020 08:31:50 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 095983F71F;
        Fri, 19 Jun 2020 08:31:48 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:31:46 +0100
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
Message-ID: <20200619153146.vaizbj7muy52zvbd@e107158-lin.cambridge.arm.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com>
 <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
 <20200612092454.GA94228@google.com>
 <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
 <CAD=FV=UySLsTaUP3nOfQO98qPEUkY8tMhw25pJ4Yi7FVM5xU6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAD=FV=UySLsTaUP3nOfQO98qPEUkY8tMhw25pJ4Yi7FVM5xU6g@mail.gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,

On 06/18/20 14:31, Doug Anderson wrote:
> Hi,
> 
> On Fri, Jun 12, 2020 at 5:34 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > On 06/12/20 10:24, Quentin Perret wrote:
> > > +CC Qais [FYI]
> >
> > Thanks for the CC.
> >
> > >
> > > On Thursday 11 Jun 2020 at 10:48:40 (-0700), Doug Anderson wrote:
> > > > Hrm.  I guess my first instinct is to say that we still want this
> > > > patch even if we have something that is applied more globally.
> > >
> > > Fair enough.
> > >
> > > > Specifically it sounds as if the patch you point at is suggesting that
> > > > we'd tweak the boost value to something other than max but we'd still
> > > > have a boost value.  In the case of cros_ec_spi I don't believe we
> > > > need any boost value at all, so my patch would still be useful.  The
> > > > computational needs of cros_ec_spi are very modest and it can do its
> > > > work at lower CPU frequencies just fine.  It just can't be interrupted
> > > > for large swaths of time.
> > > >
> > > >
> > > > > IOW, how do you feel about 20200511154053.7822-1-qais.yousef@arm.com ?
> > > >
> > > > I'm not totally a fan, but I'm definitely not an expert in this area
> > > > (I've also only read the patch description and not the patch or the
> > > > whole thread).  I really don't want yet another value that I need to
> > > > tune from board to board.  Even worse, this tuning value isn't
> > > > board-specific but a combination of board and software specific.  By
> > > > this, I'd imagine a scenario where you're using a real-time task to
> > > > get audio decoding done within a certain latency.  I guess you'd tune
> > > > this value to make sure that you can get all your audio decoding done
> > > > in time but also not burn extra power.  Now, imagine that the OS
> > > > upgrades and the audio task suddenly has to decode more complex
> > > > streams.  You've got to go across all of your boards and re-tune every
> > > > one?  ...or, nobody thinks about it and older boards start getting
> > > > stuttery audio?  Perhaps the opposite happens and someone comes up
> > > > with a newer lower-cpu-intensive codec and you could save power.
> > > > Sounds like a bit of a nightmare.
> >
> > Generally I would expect this global tunable to be part of a vendor's SoC BSP.
> 
> I think I'm coming at this from a very different world than the one
> you're thinking of.  The concept of a BSP makes me think of a SoC
> vendor providing a drop of Linux with all their own weird hacks in it
> that only ever works on that one SoC and will never, ever, ever be
> updated.  5 years down the road if a software update is needed
> (security fix?) some poor soul will be in charge of tracking down the
> exact ancient code base that was used to build the original kernel,
> making the tweak, and building a new kernel.  ;-)
> 
> In the world of Chrome OS we try very very hard to build everything
> from a clean code base and are trying hard to stay even closer to
> upstream and away from per-device weirdness...

Hmm I thought OEMs who ship stuff that are based on Chrome OS would have to do
the final tuning here, which would be based on the recommendation of the SoC
vendor. And I'm being overly generic here to think not only SoC from Intel
which traditionally they have been treated in different ways.

I think you provide a generic stack for OEMs, no?

Generally for RT tasks, Linux always required an admin to do the tuning. And to
provide an automatic solution that fits all is not easy to happen, because what
ultimately is important for userspace, is only known by the userspace.

This is an interesting problem for me personally that I have been trying to
look at in my free time. On general purpose systems, it's hard to reason about
what's important because, as you say, you distribute something that should
target a wide range of platforms. And sometimes the end user (like a person
installing Ubuntu Desktop on their laptop), have no clue what a driver is even
to pick the right tuning for all RT tasks in their system.

But this problem already exists and catching up with this will need more work
from both distros and maybe kernel. I can't see a possible situation where the
kernel can do all the tuning without userspace providing more info anyway.

The per-device weirdness you're talking about is just how the way goes in
a world where there are many SoCs that are created to target different budgets
and use cases.

So I don't see the 2 worlds (laptops/mobile) really different, they just
traditionally started differently where such variations in SoC didn't exist
that much. But there are more Arm based SoCs that are targetting laptop markets
now.. So you never know when they will be dealing with the same variations the
mobile world sees today.

> 
> 
> > People tend to think of the flagship SoCs which are powerful, but if you
> > consider the low and medium end devices there's a massive spectrum over there
> > that this range is trying to cover.
> 
> Yeah, perhaps you're right.  When thinking about a laptop it's almost
> always a fairly powerful device and things could certainly be
> different for very low end chips trying to run Linux.

I think there are low end laptops in the market that barely have enough grunt
to do work. So not all laptops are fairly powerful.

> 
> 
> > I would expect older boards init script to be separate for newer boards init
> > script. The OS by default boosts all RT tasks unless a platform specific script
> > overrides that. So I can't see how an OS upgrade would affect older boards.
> 
> In the Chrome OS world I'm part of, the people supporting the boards
> are not always the people adding new whizbang features.  We get new
> versions of the OS every 6 weeks and those new versions may change the
> way things work pretty significantly.  We ship those new versions off
> to all boards.  Certainly they undergo testing, but there are a lot of
> boards and if something is not tuned as well as it was when the device
> first shipped it's likely nobody will really notice.  This is my bias
> against needing per-board tuning.

Apologies for my lack knowledge about the exact process in Chrome OS. In my
head, I think what you do is like what Android and other distros do. Provide
a software stack that can be used on any platform. On Android OEMs do have to
do the tuning (with a help from SoC vendor usually). Not many laptops ship with
Linux as their default OS, but this is an increasing trend and LWN did write
something recently about the demand is increasing for Linux based laptops.


I thought Chrome OS is the same, where an OEM will take your deliverables and
do the final integration.

So I agree at your level it might be hard to reason about the full spectrum.
But I thought the OEMs that wants to ship Chrome OS will need to look at init
scripts, drivers etc to ensure their laptop is competitive.

> 
> 
> > This knob still allows you to disable the max boosting and use the per-task
> > uclamp interface to boost only those tasks you care about. AFAIK this is
> > already done in a hacky way in android devices via special vendors provisions.
> 
> Yeah.  I don't think I have enough skin in the game to really say one
> way or the other what the API should be so I'll probably stay off the
> other, bigger thread and let others decide what the best API should
> be.  For Chrome OS I'd probably advocate just disabling the default
> boost but even there I'd be willing to defer to the folks doing the
> actual work.

Yes I appreciate the challenges you have. I think for most users disabling is
good enough for them as RT tasks could end up causing a lot of power to be
wasted unnecessarily. But if someone wants to take the extra mile and squeeze
the best compromise, they can :)

Thanks

--
Qais Yousef
