Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE6C4C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C18DD20734
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgFCU0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:26:07 -0400
Received: from foss.arm.com ([217.140.110.172]:37624 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725961AbgFCU0G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:26:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 303D155D;
        Wed,  3 Jun 2020 13:26:06 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6ACA53F52E;
        Wed,  3 Jun 2020 13:26:05 -0700 (PDT)
References: <20200603173150.GB1551@shell.armlinux.org.uk> <jhjh7vshvwl.mognet@arm.com> <20200603184500.GC1551@shell.armlinux.org.uk> <CAKfTPtBdN30ChMgFqqT1bzeU6HExXEQFrQjxbCK-hRT4HEiQkQ@mail.gmail.com> <20200603195853.GD1551@shell.armlinux.org.uk>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: v5.7: new core kernel option missing help text
In-reply-to: <20200603195853.GD1551@shell.armlinux.org.uk>
Date:   Wed, 03 Jun 2020 21:25:57 +0100
Message-ID: <jhjftbbj3qi.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 03/06/20 20:58, Russell King - ARM Linux admin wrote:
> On Wed, Jun 03, 2020 at 09:24:56PM +0200, Vincent Guittot wrote:
>> On Wed, 3 Jun 2020 at 20:45, Russell King - ARM Linux admin
>> <linux@armlinux.org.uk> wrote:
>> > It's a start.  I'm still wondering whether I should answer yes or no
>> > for the platforms I'm building for.
>> >
>> > So far, all I've found is:
>> >
>> > arch/arm/include/asm/topology.h:#define arch_scale_thermal_pressure topology_get_thermal_pressure
>> >
>> > which really doesn't tell me anything about this.  So I'm still in
>> > the dark.
>> >
>> > I guess topology_get_thermal_pressure is provided by something in
>> > drivers/ which will be conditional on some driver or something.
>>
>> You need cpufreq_cooling device to make it useful and only for SMP
>> I don't think that this should not be user configurable because even
>> with the description above, it is not easy to choose.
>> This should be set by the driver that implement the feature which is
>> only cpufreq cooling device for now it
>
> As I have CONFIG_CPU_FREQ_THERMAL=y in my config, I'm guessing (and it's
> only a guess) that I should say y to SCHED_THERMAL_PRESSURE ?
>

arm and arm64 implement arch_scale_thermal_pressure(); the actual
implementation is in the arch_topology "driver" (GENERIC_ARCH_TOPOLOGY).

Then, the caller of arch_set_thermal_pressure() is cpufreq_cooling (see
below); that'll only get called if you have thermal zones using CPU
cooling devices.

AFAICT the current state of things imply we should have something like

        depends on (ARM || ARM64) && GENERIC_ARCH_TOPOLOGY

for that option.

>> > > +     help
>> > > +       This option allows the scheduler to be aware of CPU thermal throttling
>> > > +       (i.e. thermal pressure), providing arch_scale_thermal_pressure() is
>> > > +       implemented.
>
> Is this feature documented in terms of what it does?  Do I assume that
> as the thermal trip points start tripping, that has an influence on
> the scheduler?  Or is it the case that the scheduler is wanting to
> know when the cpu frequency changes?
>
> Grepping for "thermal" in Documentation/scheduler brings up nothing.

The former; changing a CPU cooling device's state (IOW changing its max
allowed frequency for thermal reasons) leads to a call to
arch_set_thermal_pressure() (see
cpufreq_cooling.c::cpufreq_set_cur_state()).

It's somewhat interesting to have, at least in theory. On plain SMP that
would let the scheduler see if some CPUs are more throttled that others,
which would be leveraged when doing load balancing. It's more
interesting for big.LITTLE & co, where in the worst cases we can have
things like capacity inversion, i.e. the bigs are so thermally throttled
that they give less oomf than a LITTLE.
