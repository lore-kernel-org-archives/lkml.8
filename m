Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E62C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1298F20801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 12:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgFLMez (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 08:34:55 -0400
Received: from foss.arm.com ([217.140.110.172]:35722 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726053AbgFLMey (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:34:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18F191F1;
        Fri, 12 Jun 2020 05:34:53 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 575AB3F6CF;
        Fri, 12 Jun 2020 05:34:51 -0700 (PDT)
Date:   Fri, 12 Jun 2020 13:34:48 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Doug Anderson <dianders@chromium.org>,
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
Message-ID: <20200612123448.fcmzv3rdtsbawmpd@e107158-lin.cambridge.arm.com>
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200611110301.GA132747@google.com>
 <CAD=FV=V2FvFcYrghxUSdHNxmcS3DKpnBbk2oL64w7hh=tV-DfQ@mail.gmail.com>
 <20200612092454.GA94228@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200612092454.GA94228@google.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/20 10:24, Quentin Perret wrote:
> +CC Qais [FYI]

Thanks for the CC.

> 
> On Thursday 11 Jun 2020 at 10:48:40 (-0700), Doug Anderson wrote:
> > Hrm.  I guess my first instinct is to say that we still want this
> > patch even if we have something that is applied more globally.
> 
> Fair enough.
> 
> > Specifically it sounds as if the patch you point at is suggesting that
> > we'd tweak the boost value to something other than max but we'd still
> > have a boost value.  In the case of cros_ec_spi I don't believe we
> > need any boost value at all, so my patch would still be useful.  The
> > computational needs of cros_ec_spi are very modest and it can do its
> > work at lower CPU frequencies just fine.  It just can't be interrupted
> > for large swaths of time.
> > 
> > 
> > > IOW, how do you feel about 20200511154053.7822-1-qais.yousef@arm.com ?
> > 
> > I'm not totally a fan, but I'm definitely not an expert in this area
> > (I've also only read the patch description and not the patch or the
> > whole thread).  I really don't want yet another value that I need to
> > tune from board to board.  Even worse, this tuning value isn't
> > board-specific but a combination of board and software specific.  By
> > this, I'd imagine a scenario where you're using a real-time task to
> > get audio decoding done within a certain latency.  I guess you'd tune
> > this value to make sure that you can get all your audio decoding done
> > in time but also not burn extra power.  Now, imagine that the OS
> > upgrades and the audio task suddenly has to decode more complex
> > streams.  You've got to go across all of your boards and re-tune every
> > one?  ...or, nobody thinks about it and older boards start getting
> > stuttery audio?  Perhaps the opposite happens and someone comes up
> > with a newer lower-cpu-intensive codec and you could save power.
> > Sounds like a bit of a nightmare.

Generally I would expect this global tunable to be part of a vendor's SoC BSP.

People tend to think of the flagship SoCs which are powerful, but if you
consider the low and medium end devices there's a massive spectrum over there
that this range is trying to cover.

I would expect older boards init script to be separate for newer boards init
script. The OS by default boosts all RT tasks unless a platform specific script
overrides that. So I can't see how an OS upgrade would affect older boards.

This knob still allows you to disable the max boosting and use the per-task
uclamp interface to boost only those tasks you care about. AFAIK this is
already done in a hacky way in android devices via special vendors provisions.

> > 
> > I'd rather have a boolean value: boost all RT threads to max vs. don't
> > boost all RT threads to max.  Someone that just wanted RT stuff to run

If that's what your use case requires, you can certainly treat it like
a boolean if you want.

> > as fast as possible without any hassle on their system and didn't care
> > about power efficiency could turn this on.  Anyone who really cared
> > about power could turn this off and then could find a more targeted
> > way to boost things, hopefully in a way that doesn't require tuning.
> > One option would be to still boost the CPU to max but only for certain
> > tasks known to be really latency sensitive.  Another might be to

per-task uclamp interface allows you to do that. But SoC vendors/system
integrators need to decide that. I'm saying this with Android in mind
specifically. Linux based laptops that are tuned in similar way are rare. But
hopefully this will change at some point :)

> > somehow measure whether or not the task is making its deadlines and
> > boost the CPU frequency up if deadlines are not being met.  I'm sure
> > there are fancier ways.

You need to use SCHED_DEADLINE then :)

Making sure that RT tasks meet their deadlines is a userspace tuning problem.
There's no way the kernel can know if an RT task is meeting its deadline.

> > 
> > ...of course, I believe your patch allows me to do what I want: I can
> > just set the default boost to 0.  It just leaves in the temptation for
> > others to require a default boost of something else and then I'm stuck
> > in my tuning nightmare.

To cover all possible systems Linux can run on, this variability is required.
On general purpose systems with decent SoCs, I'd expect them to just want to
set this to 0 and selectively boost specific RT tasks.

> 
> Right, so I am not disagreeing at all with the above. FWIW, I expect
> Android to set this default value to 0 as you mentioned, so that uclamp
> basically becomes 'opt-in' for _all_ tasks, including RT.
> 
> Now, given that Qais' patch is commiting something to userspace, I think
> it makes sense to expose the full range rather than a boolean value, as
> it's probably more future-proof. That is, if we expose a boolean knob
> now, and somebody wants to be able to set a default value in the middle
> in a few years, we'll have to add another knob, and maintain both (which
> sucks). But it's just my personal opinion. Feel free to jump in the
> other thread if you feel differently :)

I guess you're talking about Android/Chromium specific knobs on top of the
sysctl one here. Not sure why you need that since init scripts should be able
to modify this directly since they run as root.

Cheers

--
Qais Yousef
